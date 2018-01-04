#!/usr/bin/env bash

# if you're getting errors installing some python packages, look into output.
# in case of  '/usr/bin/ld: cannot find -lffi' (or some other library) this may be a solution:
# https://stackoverflow.com/questions/18783390/

# ensure there are needed libs or `pkg install` them otherwise:

# ls /usr/local/lib/ | grep ffi
# libffi-3.2.1
# libffi.a
# libffi.so
# libffi.so.6
# libffi.so.6.0.4

# this works now
# LDFLAGS="-L/usr/local/lib" pip install pynacl