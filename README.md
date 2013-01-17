dotfiles
========
About
-----
All the cool kids do it, right? This is just a simple script 
and collection of config files that I use on my systems. Rather 
then go through and manually configure everything or copy files 
by hand (and have different versions of each), I can simply 
clone a repository and run a script.

Installation
------------
### Requirements
+ Git (checkout/updating)

### Install
    $ git clone git://github.com/rnelson/dotfiles.git
    $ cd dotfiles
    $ vim setup.sh
    $ ./setup.sh

There is a small configuration section in the setup script that 
needs to match the user's environment. Eventually, I'll rewrite 
the script and improve that.

Structure
---------
### common
The `common` directory holds configuration that is common to all 
systems, such as my SSH configuration and authorized SSH keys. 
Every system will copy these files.

### computer
Underneath `computer` is a folder for each computer (the name 
matching the output of `hostname`). These files get copied only 
to systems matching that hostname.

While the setup script is entirely manual at this point, eventually 
it will check for the existence of a file in both there and `common` 
and append the computer's version if a common one exists.

### os
`os` is similar to `computer` except it sets up files based on the 
operating system on the computer. The OS is determined by running 
`uname`.
