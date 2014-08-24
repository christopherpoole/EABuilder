# CMake build tools for custom algorithms in Varian Eclipse.
#
# Author:    Christopher M Poole <mail@christopherpoole.net>
# Institute: Dept. Ob. Gyn., University of Melbourne, Australia
# Date:      21 August 2014
#
# --- Build Setup and Options ---

set(SERVANT "Algorithm" CACHE STRING "The name of the algorithm")
set(VERSION "0.0.1" CACHE STRING "The version of the algorithm")
set(DCF_DIRECTORY "D:/VMSOS/DCF" CACHE PATH "The path to the Distributed Calculation Framework installation")

option(OVERWRITE "Overwrite any current installation with the same version" OFF)
option(REGISTER_SERVANT "Register the servant during installation" ON)
option(REGISTER_ALGORITHM "Register the algorithm during installation" ON)
option(FORCE_AGENT_RELOAD "Instruct agents to reload the configuration (requires curl)" OFF)
option(COPY_CALCULATION_OPTIONS "Copy the Calculation Options schema and files." OFF)
option(COPY_MATERIAL_TABLE "Copy the Physical Material Table for this algorithm. In the RT Administrator, Clinical Data -> Physical Materials -> Import from DCF, to populate the ARIA database." OFF)

if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${DCF_DIRECTORY}/server/bin/${SERVANT} (${VERSION})" CACHE PATH "default install path" FORCE)
else()
    set(CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}/${SERVANT} (${VERSION})" CACHE PATH "default install path" FORCE)
endif()

if (EXISTS ${CMAKE_INSTALL_PREFIX})
    if (NOT ${OVERWRITE})
        message(FATAL_ERROR "The proposed installation directory (${CMAKE_INSTALL_PREFIX}) already exists. Use -DOVERWRITE='ON' to ignore, or increment the version.")
    endif()
endif()

# Append 'Servant' to the algorithm name
set(SERVANT "${SERVANT}Servant")

# Setup the project.
project(${SERVANT})

# Find the Eclipse Algorithm API includes and libraries.
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/EABuilder/modules")

find_package(EAAPI REQUIRED)
include_directories(${EAAPI_INCLUDE_DIRS})

