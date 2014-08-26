## CMake build tools for custom algorithms in Varian Eclipse.
If you want to avoid Visual Studio, and you prefer the command line, this is the builder you want for compiling, installing, and setting up custom dose calculation algorithms for Varian Eclipse, using the Eclipse Algorithm EAAPI.
Ok, so you can't avoid Visual Studio completely; the compiler is still necessary given the syntax used in the EAAPI header files.
As a preview, EABuilder lets you do things like this:

    cmake <path to project root> -G"Visual Studio 10 Win64" -DSERVANT:STRING=MyAlgorithm -DVERSION:STRING=0.0.1 -DFORCE_AGENT_RELOAD=YES
    cmake --build . --config Debug
    cmake -P install.cmake

This will compile your algorithm against the `Debug` EAAPI (you can choose `Release` as well), install your algorithm into the DCF and register it properly, and force a reloading of agents connected to the DCF server.

EABuilder has been tested on a workstation with Varian Eclipse 11.0.31 only. There is no guarantee it will work on your system with the same or other versions.

## Dependences
 - [CMake 2.8](http://www.cmake.org/cmake/resources/software.html) or above.
 - [Cygwin 1.7](https://www.cygwin.com/) or above if you want to make Windows development  easier.
 - `curl` installed via Cygwin if you want to reload agents during installation.

## Usage and Work-flow
Using the example `CMakeLists.txt` file (`CMakeLists_example.txt`), you will want to make your project directory look something like this:

    +-project/
      +-src/
      | +-*.cc
      +-include/
      | +-*.hh
      +-build/
      +-EABuilder/
      +-CMakeLists.txt (based on EABuilder/CMakeLists_example.txt)
      +-main.cc

In `build/` start the build process like this:

    cmake .. -G"Visual Studio 10 Win64" <other options>
    cmake --build . --config Release

This will compile the code only. If you seek to install your algorithm for testing as well:

    cmake -P install.cmake

A script for uninstalling the algorithm is also copied to the algorithm install location. You can invoke it at any time like this:

    cmake -P uninstall.cmake 

Any and all dependencies for you project can be specified as indicated in the `CMakeLists.txt` file.


## Options
Options available with EABuilder are listed below. At a minimum you will probably want to be setting `SERVANT` and `VERSION`. 

    Variable Name: CMAKE_INSTALL_PREFIX
    Description: The root directory into which the algorithm in installed. If
        you set this value, "/<SERVANT> (<VERSION>)" is appended automatically.
    Default Value: <DCF_DIRECTORY>/server/bin/<SERVANT> (<VERSION>)
    Useage: -DCMAKE_INSTALL_PREFIX=<path>

    Variable Name: SERVANT
    Description: The name of the algorithm.
    Default Value: Algorithm
    Usage: -DSERVANT:STRING=<servant name>

    Variable Name: VERSION
    Description: The version of the algorithm.
    Default Value: 0.0.1
    Usage: -DVERSION:STRING=<servant version>

    Variable Name: DCF_DIRECTORY
    Description: The path to the Distributed Calculation Framework installation.
    Default Value: D:/VMSOS/DCF
    Usage: -DDCF_DRECTORY:PATH=<path>

    Variable Name: OPTIONS_DIRECTORY
    Description: The path to the Distributed Calculation Framework options directory.
    Default Value: D:/VMSOS/DCF/client/Options ([API])
    Usage: -DOPTIONS_DRECTORY:PATH=<path>

    Variable Name: OVERWRITE
    Description: Overwrite any current installation with the same version.
    Default Value: OFF
    Usage: -DOVERWRITE=<ON or OFF>

    Variable Name: REGISTER_SERVANT
    Description: Register the servant during installation.
    Default Value: ON
    Usage: -DREGISTER_SERVANT=<ON or OFF>

    Variable Name: REGISTER_ALGORITHM
    Description: Register the algorithm during installation.
    Default Value: ON
    Usage: -DREGISTER_ALGORITHM=<ON or OFF>

    Variable Name: FORCE_AGENT_RELOAD
    Description: Instruct agents to reload the configuration (requires curl).
    Default Value: OFF
    Usage: -DFORCE_AGENT_RELOAD=<ON or OFF>

    Variable Name: COPY_CALCULATION_OPTIONS
    Description: Copy the Calculation Options schema and files.
    Default Value: OFF
    Usage: -DCOPY_CALCULATION_OPTIONS=<ON or OFF>

    Variable Name: COPY_MATERIAL_TABLE
    Description: Copy the Physical Material Table for this algorithm. In the RT
        Administrator, Clinical Data -> Physical Materials -> Import from DCF,
        to populate the ARIA database.
    Default Value: OFF
    USAGE: -DCOPY_MATERIAL_TABLE=<ON or OFF>

