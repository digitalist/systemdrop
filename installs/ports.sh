# https://www.freebsd.org/doc/handbook/ports-using.html
# portsnap fetch
# portsnap extract
#chain: portsnap fetch update

# Subversion must be installed before it can be used to check out the ports tree. If a copy of the ports tree is already present, install Subversion like this:
# cd /usr/ports/devel/subversion
# make install clean

# If the ports tree is not available, or pkg is being used to manage packages, Subversion can be installed as a package:
pkg install -y subversion

#Check out a copy of the ports tree:
svn checkout https://svn.FreeBSD.org/ports/head /usr/ports

# As needed, update /usr/ports after the initial Subversion checkout:
svn update /usr/ports