# - Try to find GLOG
# http://code.google.com/p/google-glog/
#
# Once done, this will define
#
#  GLOG_INCLUDE_DIRS   - where to find glog/logging.h, etc.
#  GLOG_LIBRARIES      - List of libraries when using glog.
#  GLOG_FOUND          - True if glog found.
#
# An includer may set GLOG_ROOT to a glog installation root to tell
# this module where to look.
#
# Author:
# Wolfgang A. Welz <welz@math.tu-berlin.de>
#
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

include(LibFindMacros)

# Dependencies
SET(CMAKE_THREAD_PREFER_PTHREAD)
libfind_package(GLOG Threads)

# If GLOG_ROOT is not set, look for the environment variable
if(NOT GLOG_ROOT AND NOT "$ENV{GLOG_ROOT}" STREQUAL "")
  set(GLOG_ROOT $ENV{GLOG_ROOT})
endif()

set(_GLOG_SEARCHES)

# Search GLOG_ROOT first if it is set.
if(GLOG_ROOT)
  set(_GLOG_SEARCH_ROOT PATHS ${GLOG_ROOT} NO_DEFAULT_PATH)
  list(APPEND _GLOG_SEARCHES _GLOG_SEARCH_ROOT)
endif()

# Normal search.
set(_GLOG_SEARCH_NORMAL
  PATHS ""
)
list(APPEND _GLOG_SEARCHES _GLOG_SEARCH_NORMAL)

# Try each search configuration.
foreach(search ${_GLOG_SEARCHES})
  FIND_PATH(GLOG_INCLUDE_DIR NAMES glog/logging.h ${${search}} PATH_SUFFIXES include)
  FIND_LIBRARY(GLOG_LIBRARY NAMES glog ${${search}} PATH_SUFFIXES lib lib64)
endforeach()

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(GLOG_PROCESS_INCLUDES GLOG_INCLUDE_DIR)
set(GLOG_PROCESS_LIBS GLOG_LIBRARY)
libfind_process(GLOG)
