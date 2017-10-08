pkg install -y openjdk8

# check if fdesc/procfs are mounted
mount | grep fdesc > /dev/null 2>&1  || mount -t fdescfs fdesc /dev/fd
mount | grep procfs > /dev/null 2>&1  || mount -t procfs proc /proc

#check if fdesc/procfs are present in fstab and if not - add them
grep fdesc /etc/fstab >>/dev/null || echo "fdesc	/dev/fd		fdescfs		rw	0	0" >> /etc/fstab
grep procfs /etc/fstab >>/dev/null || echo "proc	/proc		procfs		rw	0	0" >> /etc/fstab



#env LD_PRELOAD=./jre64/lib/amd64/jli/libjli.so  ./jre64/bin/java
#env LD_PRELOAD ~/lib/blah.so program
#or env LD_LIBRARY_PATH=~/lib:$LD_LIBRARY_PATH
#https://lists.freebsd.org/pipermail/freebsd-java/2007-May/006279.html
# Jozef Babjak suggested me to set LD_LIBRARY_PATH, and it works:
#LD_LIBRARY_PATH=/usr/local/linux-sun-jdk1.6.0/jre/lib/i386/jli java
#echo "/usr/home/user/prog/pycharm-2017.2.3/jre64/lib/amd64/jli/ > /compat/linux/etc/ld.so.conf.d/java.conf
