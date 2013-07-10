# - Try to find CPLEX
# Once done, this will define
#
#  CPLEX_INCLUDE_DIRS   - where to find scip/scip.h, etc.
#  CPLEX_LIBRARIES      - List of libraries when using scip.
#  CPLEX_FOUND          - True if scip found.
#
#  CPLEX_VERSION        - The version of scip found (x.y.z)
#  CPLEX_VERSION_MAJOR  - The major version of scip
#  CPLEX_VERSION_MINOR  - The minor version of scip
#  CPLEX_VERSION_PATCH  - The patch version of scip
#
# An includer may set CPLEX_ROOT to a cplex installation root to tell
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
libfind_package(CPLEX Threads)

# If CPLEX_ROOT is not set, look for the environment variable
if(NOT CPLEX_ROOT AND NOT "$ENV{CPLEX_ROOT}" STREQUAL "")
  set(CPLEX_ROOT $ENV{CPLEX_ROOT})
endif()

set(_CPLEX_SEARCHES)

# Search CPLEX_ROOT first if it is set.
if(CPLEX_ROOT)
  set(_CPLEX_SEARCH_ROOT PATHS ${CPLEX_ROOT} NO_DEFAULT_PATH)
  list(APPEND _CPLEX_SEARCHES _CPLEX_SEARCH_ROOT)
endif()

# Normal search.
set(_CPLEX_SEARCH_NORMAL
  PATHS ""
)
list(APPEND _CPLEX_SEARCHES _CPLEX_SEARCH_NORMAL)

# Try each search configuration.
foreach(search ${_CPLEX_SEARCHES})
  FIND_PATH(CPLEX_INCLUDE_DIR NAMES ilcplex/ilocplex.h ${${search}} PATH_SUFFIXES include)
  FIND_LIBRARY(CPLEX_LIBRARY NAMES cplex ${${search}} PATH_SUFFIXES lib lib/x86-64_sles10_4.1/static_pic)
endforeach()

IF(CPLEX_INCLUDE_DIR AND EXISTS "${CPLEX_INCLUDE_DIR}/ilcplex/cpxconst.h")
  FILE(STRINGS "${CPLEX_INCLUDE_DIR}/ilcplex/cpxconst.h" CPXCONST_H REGEX "^ *#define CPX_VERSION_.*$")

  STRING(REGEX REPLACE "^.*#define CPX_VERSION_VERSION +([0-9]+).*" "\\1" CPLEX_VERSION_MAJOR ${CPXCONST_H})
  STRING(REGEX REPLACE "^.*#define CPX_VERSION_RELEASE +([0-9]+).*" "\\1" CPLEX_VERSION_MINOR ${CPXCONST_H})
  STRING(REGEX REPLACE "^.*#define CPX_VERSION_MODIFICATION +([0-9]+).*" "\\1" CPLEX_VERSION_PATCH ${CPXCONST_H})
  SET(CPLEX_VERSION "${CPLEX_VERSION_MAJOR}.${CPLEX_VERSION_MINOR}.${CPLEX_VERSION_PATCH}")
ENDIF()

# Set the include dir variables and the libraries and let libfind_process do the rest.
# NOTE: Singular variables for this library, plural for libraries this this lib depends on.
set(CPLEX_PROCESS_INCLUDES CPLEX_INCLUDE_DIR)
set(CPLEX_PROCESS_LIBS CPLEX_LIBRARY CMAKE_THREAD_LIBS_INIT)
libfind_process(CPLEX)
