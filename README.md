# CMAKENEW
A command line utility to bootstrap simple cmake project.

## Installation

### Linux


**Download ```script.sh``` and Run this command**
```
./script.sh

```

### Windows:

1. Download Executable from [here](https://raw.githubusercontent.com/aadarshadhakalg/cmakenew/master/downloads/windows/cmakenew.exe)
2. Copy the executable file to C:\cmaketools\cmaketools.exe
3. Update your path
  - Open the Start Search, type in “env”, and choose “Edit the system environment variables”
  - Click the “Environment Variables…” button.
  - Under the “System Variables” section, find “Path”, and click edit.
  - Now, you can click “New” and type ```C:\cmaketools\```. 
  - Dismiss all of the dialogs by choosing “OK”. Your changes are saved!  

## Usage:
```
Create a new project

Usage: cmakenew <command> [arguments]

Global options:
-h, --help      Print this usage information.
-i, --info      Shows Developer Info
-d, --doctor    Environment Checkup

Available commands:
  create   Creates new cmake project

Run "cmakenew help <command>" for more information about a command
```
