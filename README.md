# My public scripts 

This repository contains a collection of shell scripts designed to automate the installation, compiling and configuration of various software and tools. Each script is tailored for a specific purpose, making it easier to set up your development environment or deploy applications.

General Usage

	1.	Open a Terminal: Navigate to the directory where the install script resides.
	2.	Make the Script Executable (if not already):

chmod +x install


	3.	Run the Script:

./install <command>

Replace <command> with the specific software or tool you want to install.

Supported Commands

The script provides several commands to install or compile different tools. Below is a list of available commands and their descriptions:

Command	Description
go	Installs Golang and sets up the Go environment.
java	Installs Java.
vim	Installs Vim, Mercurial, Git, and Meld.
git	Installs Git and Git LFS support.
qt	Installs Qt (specific to Raspbian).
adb	Installs ADB (specific to Raspbian).
nvidia	Installs NVIDIA drivers and CUDA toolkit.
openscad	Compiles and installs OpenSCAD.
fritzing	Compiles and installs Fritzing.
opencv	Compiles and installs OpenCV 4.
wordpress	Installs WordPress in a folder named wp.
rpitools	Installs Raspberry Pi development tools.
lemp	Installs Nginx, MariaDB, and PHP (LEMP stack).
postgres	Installs PostgreSQL.
(no command)	Displays the help message with usage instructions.

Example Commands

	1.	Install Golang:

./install go


	2.	Install Git with LFS support:

./install git


	3.	Compile and Install OpenSCAD:

./install openscad

Additional Notes

	•	The script uses sudo for many commands, so you may need administrator privileges.
	•	It references other scripts in the install_scripts and compile_scripts directories, which should be present alongside the main script.
	•	If you see a message like “We need root permissions to proceed,” you’ll need to press a key to continue when prompted.
	•	To add or modify a command, you can extend the script by editing the case statement and adding a corresponding function.
