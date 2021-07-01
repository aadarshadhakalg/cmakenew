# CMAKENEW
A command line utility to bootstrap simple cmake project.

## Installation

### Linux

** Run this command **

```
sudo apt install wget && wget https://raw.githubusercontent.com/aadarshadhakalg/cmakenew/master/downloads/linux/cmakenew && sudo mkdir /opt/cmakenew && sudo cp cmakenew /opt/cmakenew/cmakenew && sudo chmod +x /opt/cmakenew/cmakenew && echo 'export PATH="/opt/cmakenew/:$PATH"' >> $HOME/.bashrc && source $HOME/.bashrc

```


### Usage

Create a new project

Usage: cmakenew <command> [arguments]

Global options:
-h, --help      Print this usage information.
-i, --info      Shows Developer Info
-d, --doctor    Environment Checkup

Available commands:
  create   Creates new cmake project

Run "cmakenew help <command>" for more information about a command
