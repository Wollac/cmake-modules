# - Try to find Readline
# Once done this will define
#
# Readline_FOUND - system has Readline
# Readline_INCLUDE_DIRS - the Readline include directory
# Readline_LIBRARIES - link these to use Readline
#
# Author:
# Wolfgang A. Welz <welz@math.tu-berlin.de>
#
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

include(LibFindMacros)

# Dependencies
libfind_package(SCIP Curses)

FIND_PATH(Readline_INCLUDE_DIR readline/readline.h)
FIND_LIBRARY(Readline_LIBRARY NAMES readline)

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(Readline_PROCESS_INCLUDES Readline_INCLUDE_DIR)
set(Readline_PROCESS_LIBS Readline_LIBRARY CURSES_LIBRARY)
libfind_process(Readline)
