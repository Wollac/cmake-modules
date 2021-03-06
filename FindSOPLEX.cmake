# - Try to find SOPLEX
# See http://soplex.zib.de/ for more information on SoPlex
#
# Once done, this will define
#
#  SOPLEX_INCLUDE_DIRS   - where to find soplex.h, etc.
#  SOPLEX_LIBRARIES      - List of libraries when using soplex.
#  SOPLEX_FOUND          - True if soplex found.
#
# An includer may set SOPLEX_ROOT to a soplex installation root to tell
# this module where to look.
#
# Variables used by this module, they can change the default behaviour and
# need to be set before calling find_package:
#
# Author:
# Wolfgang A. Welz <welz@math.tu-berlin.de>
#
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

include(LibFindMacros)

# If SOPLEX_ROOT is not set, look for the environment variable
if(NOT SOPLEX_ROOT AND NOT "$ENV{SOPLEX_ROOT}" STREQUAL "")
  set(SOPLEX_ROOT $ENV{SOPLEX_ROOT})
endif()

set(_SOPLEX_SEARCHES)

# Search SOPLEX_ROOT first if it is set.
if(SOPLEX_ROOT)
  set(_SOPLEX_SEARCH_ROOT PATHS ${SOPLEX_ROOT} NO_DEFAULT_PATH)
  list(APPEND _SOPLEX_SEARCHES _SOPLEX_SEARCH_ROOT)
endif()

# Normal search.
set(_SOPLEX_SEARCH_NORMAL
  PATHS ""
)
list(APPEND _SOPLEX_SEARCHES _SOPLEX_SEARCH_NORMAL)

# Try each search configuration.
foreach(search ${_SOPLEX_SEARCHES})
  FIND_PATH(SOPLEX_INCLUDE_DIR NAMES soplex.h ${${search}} PATH_SUFFIXES src include)
  FIND_LIBRARY(SOPLEX_LIBRARY NAMES soplex ${${search}} PATH_SUFFIXES lib)
endforeach()

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(SOPLEX_PROCESS_INCLUDES SOPLEX_INCLUDE_DIR)
set(SOPLEX_PROCESS_LIBS SOPLEX_LIBRARY)
libfind_process(SOPLEX)
