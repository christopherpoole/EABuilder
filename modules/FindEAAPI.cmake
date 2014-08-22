# CMake build tools for custom algorithms in Varian Eclipse.
#
# Author:    Christopher M Poole <mail@christopherpoole.net>
# Institute: Dept. Ob. Gyn., University of Melbourne, Australia
# Date:      21 August 2014
#
# --- Find the Varian Eclipse Algorithms API (EAAPI) ---
#
# This script will define the following:
#   EAAPI_FOUND - We have found the EAAPI.
#   EAAPI_INCLUDE_DIRS - The EAAPI include directory.
#   EAAPI_LIBRARIES - The EAAPI libraries to link against.
#   EAAPI_BINARIES - The EAAPI DLLs to link against.
#   EAAPI_DEFINITIONS - Compiler flags for using the EAAPI.

find_package(PkgConfig)
set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib" ".dll")

# Find the EAAPI headers.
find_path(EAAPI_INCLUDE_DIR include HINTS C:/EAAPI)
set(EAAPI_INCLUDE_DIRS ${EAAPI_INCLUDE_DIR}/include)

# Find the EAAPI libraries, both Debug and Release
find_library(EAAPI_LIBRARY NAMES EAAPI_x64_Release.lib HINTS C:/EAAPI/lib/x64_Release)
find_library(EAAPI_DEBUG_LIBRARY NAMES EAAPI_x64_Debug.lib HINTS C:/EAAPI/lib/x64_Debug)
set(EAAPI_LIBRARIES optimized ${EAAPI_LIBRARY} Rpcrt4.lib
                    debug     ${EAAPI_DEBUG_LIBRARY} Rpcrt4.lib)

# Find the EAAPI binaries, both Debug and Release
find_library(EAAPI_BINARY NAMES VCServant.dll HINTS C:/EAAPI/bin/x64_Release)
find_library(EAAPI_DEBUG_BINARY NAMES VCServantd.dll HINTS C:/EAAPI/bin/x64_Debug)
set(EAAPI_BINARIES optimized ${EAAPI_BINARY}
                   debug     ${EAAPI_DEBUG_BINARY})


# Set compiler flags for both Debug and Release target
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MD /EHsc /Zp8 /D _SECURE_SCL=0 /D NDEBUG")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MDd /EHsc /Zp8 /D _SECURE_SCL=0 /D _HAS_ITERATOR_DEBUGGING=0")

find_package_handle_standard_args(EAAPI DEFAULT_MSG EAAPI_LIBRARY EAAPI_INCLUDE_DIR)

