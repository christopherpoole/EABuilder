# CMake build tools for custom algorithms in Varian Eclipse.
#
# Author:    Christopher M Poole <mail@christopherpoole.net>
# Institute: Dept. Ob. Gyn., University of Melbourne, Australia
# Date:      21 August 2014
#
# --- Algorithm Installation and Uninstallation ---

# Populate the installation configuration template
configure_file(EABuilder/templates/install.cmake.in install.cmake @ONLY IMMEDIATE)

# Install the algorithm, and configure the DCF to use the user algorithm
install(SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/install.cmake)

