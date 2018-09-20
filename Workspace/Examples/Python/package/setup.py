#!/usr/bin/env python3
from setuptools import setup, find_packages
import os
import re

long_description = open(
    os.path.join(
        os.path.dirname(__file__),
        'README.rst'
    )
).read()

def get_version(package):
    """
    Return package version as listed in `__version__` in `__init__.py`.
    """
    path = os.path.join(os.path.dirname(__file__), package, '__init__.py')
    with open(path, 'rb') as f:
        init_py = f.read().decode('utf-8')
    return re.search("__version__ = ['\"]([^'\"]+)['\"]", init_py).group(1)

setup(
    name='',
    author='Harry S Law',
    version=get_version(''),
    url='',
    description='',
    long_description=long_description,
    packages=find_packages('.'),
    install_requires=[],
    classifiers=[
        """
        1 - Planning
        2 - Pre-Alpha
        3 - Alpha
        4 - Beta
        5 - Production/Stable
        6 - Mature
        7 - Inactive
        """
        'Development Status :: 1 Planning',
        'License :: OSI Approved :: BSD License',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.7',
        'Topic :: Software Development',
    ],
)
