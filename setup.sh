#!/usr/bin/env bash
# dotfiles v0.0.1
# Public domain
# Ross Nelson, 2010.12.19

# For now, this is just going to require manual
# updating to deal with additional files; eventually,
# it can list directories and copy files that way.
# At that point, a _ should perhaps denote a .
# e.g.,
#   dotfiles/common/_irssi/
#   dotfiles/common/_irssi/config
#   dotfiles/common/_zshrc


# ====== START OF CONFIGURATION ======
#DOTFILESDIR="/Users/rnelson/.dotfiles/" # Directory to use for whatever is needed (e.g., backups)
DOTFILESDIR="/home/rnelson/.dotfiles/" # Directory to use for whatever is needed (e.g., backups)
BACKUP="YES"                            # Create a backup of files/directories that are replaced
# ======= END OF CONFIGURATION =======


# Grab the current date
DATE=`date "+%Y%m%d%H%M"`

# Set up backup stuff (if enabled)
if [ $BACKUP = "YES" ]; then
	BACKUPNAME="dotfiles-backup-$DATE"
	BACKUPDIR=$DOTFILESDIR$BACKUPNAME
	
	mkdir -p $BACKUPDIR
fi

### Common
# git
if [ $BACKUP = "YES" ]; then
	if [ -e ~/.gitignore ]; then
		mv ~/.gitignore $BACKUPDIR
	fi
fi
cp common/gitignore ~/.gitignore

# irssi
if [ $BACKUP = "YES" ]; then
	if [ -e ~/.irssi ]; then
		if [ ! -d ~/.irssi ]; then
			mv ~/.irssi ~/.irssi.dotfiles-$DATE.bak
			mkdir ~/.irssi
		else
			mkdir $BACKUPDIR/irssi
			if [ -e ~/.irssi/config ]; then
				mv ~/.irssi/config $BACKUPDIR/irssi/config
			fi
		fi
	fi
fi
if [ ! -d ~/.irssi ]; then
	mkdir ~/.irssi
fi
cp common/irssi/config ~/.irssi/config

# mutt
if [ $BACKUP = "YES" ]; then
	if [ -e ~/.muttrc ]; then
		mv ~/.muttrc $BACKUPDIR
	fi
fi
cp common/muttrc ~/.muttrc

# ssh
if [ $BACKUP = "YES" ]; then
	if [ -e ~/.ssh ]; then
		if [ ! -d ~/.ssh ]; then
			mv ~/.ssh ~/.ssh.dotfiles-$DATE.bak
			mkdir ~/.ssh
		else
			mkdir $BACKUPDIR/ssh
			if [ -e ~/.ssh/authorized_keys2 ]; then
				mv ~/.ssh/authorized_keys2 $BACKUPDIR/ssh/authorized_keys2
			fi
			if [ -e ~/.ssh/config ]; then
				mv ~/.ssh/config $BACKUPDIR/ssh/config
			fi
		fi
	fi
fi
if [ ! -d ~/.ssh ]; then
	mkdir ~/.ssh
fi
cp common/ssh/authorized_keys2 ~/.ssh/authorized_keys2
cp common/ssh/config ~/.ssh/config

# subversion
if [ $BACKUP = "YES" ]; then
	if [ -e ~/.subversion ]; then
		if [ ! -d ~/.subversion ]; then
			mv ~/.subversion ~/.subversion.dotfiles-$DATE.bak
			mkdir ~/.subversion
		else
			mkdir $BACKUPDIR/subversion
			if [ -e ~/.subversion/config ]; then
				mv ~/.subversion/config $BACKUPDIR/subversion/config
			fi
		fi
	fi
fi
if [ ! -d ~/.subversion ]; then
	mkdir ~/.subversion
fi
cp common/subversion/config ~/.subversion/config

# zsh
if [ $BACKUP = "YES" ]; then
	if [ -e ~/.zshrc ]; then
		mv ~/.zshrc $BACKUPDIR/zshrc
	fi
fi
cp common/zshrc ~/.zshrc

# vim
if [ $BACKUP = "YES" ]; then
	if [ -e ~/.vimrc ]; then
		mv ~/.vimrc $BACKUPDIR/vimrc
	fi
fi
cp common/vimrc ~/.vimrc
mkdir -p ~/.vim/colors
cp common/vim/colors/* ~/.vim/colors
### End common



### Computers
## boxer
if [ "`hostname`" = "boxer.local" ]; then
	# Additional ssh configuration
	if [ -e ~/.ssh/config ]; then
		cat computer/boxer.local/ssh/config >> ~/.ssh/config
	fi
	
	# Additional zsh configuration
	if [ -e ~/.zshrc ]; then
		cat computer/boxer.local/zshrc >> ~/.zshrc
	fi
fi
## End boxer
## iceland
if [ "`hostname`" = "iceland" ]; then
	# Additional mutt configuration
	if [ -e ~/.muttrc ]; then
		cat computer/iceland/muttrc >> ~/.muttrc
	fi
	
	# Additional configuration files
	if [ -e ~/.shweatherrc ]; then
		if [ $BACKUP = "YES" ]; then
			mv ~/.shweatherrc $BACKUPDIR/shweatherrc
		fi
		cp computer/iceland/shweatherrc ~/.shweatherrc
	fi
fi
## End iceland
## clover
if [ "`hostname`" = "clover" ]; then
	# Bash configuration
	if [ -e ~/.bashrc ]; then
		if [ $BACKUP = "YES" ]; then
			mv ~/.bashrc $BACKUPDIR/bashrc
		fi
		cp computer/clover/bashrc ~/.bashrc
	fi
fi
## End clover
### End computers



### Operating systems
## Darwin
if [ "`uname`" = "Darwin" ]; then
	# Additional zsh configuration
	if [ -e ~/.zshrc ]; then
		cat os/Darwin/zshrc >> ~/.zshrc
	fi
fi
## 
### End operating systems

# Compress and remove the backup
if [ $BACKUP = "YES" ]; then
	tar -cf $DOTFILESDIR/$BACKUPNAME.tar $BACKUPDIR
	bzip2 -9 $DOTFILESDIR/$BACKUPNAME.tar
	rm -rf $BACKUPDIR
fi
