#include <argp.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <locale.h>

#define VERSION "when-0.1.3"
#define MAX_LEN 256

int
usage(int exit_code)
{
  fprintf(stderr,
"when - a simple time formatting command\n"
"\n"
"  $ when [[-h] [-v] [-i INTERVAL] [-s] [-f FORMAT]]\n"
"           -h Show this help screen\n"
"                -v Show current version number\n"
"                     -i Set interval for continous mode\n"
"                                   -s Set continous output mode\n"
"                                        -f Format of output string'\n");
  return exit_code;
}

int
output(char *format)
{
  char buf[MAX_LEN];
  time_t ep;
  struct tm *lt;

    if ((ep = time(NULL)) != -1 && (lt = localtime(&ep)) != NULL &&
            strftime(buf, sizeof(buf), format, lt) > 0 &&
            printf("%s\n", buf) > 0 &&
            fflush(stdout) != EOF)
        return EXIT_SUCCESS;
    else
        return EXIT_FAILURE;
}

int
main(int argc, char **argv)
{
  int stay = 0;
  int interval = 3;
  char *format = "%a %H:%M";

  int opt;
  while ((opt = getopt(argc, argv, "hvi:sf:")) != -1) {
    switch (opt) {
      case 's':
        stay = 1;
        break;
      case 'i':
        interval = atoi(optarg);
        break;
      case 'f':
        format = optarg;
        break;
      case 'h':
        usage(EXIT_SUCCESS);
        break;
      case 'v':
        fprintf(stderr, "%s\n", VERSION);
        exit(EXIT_SUCCESS);
        break;

      default:
        usage(EXIT_FAILURE);
        break;
    }
  }

  if ((setlocale(LC_ALL, "")) == NULL)
    perror("setlocale");

  if (stay)
    while (output(format) == EXIT_SUCCESS)
      sleep(interval);
  else
    return output(format);

  return EXIT_SUCCESS;
}
