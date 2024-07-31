FROM rockylinux:9

RUN sed -i '/\[crb\]/,/^ *\[/ s/enabled=0/enabled=1/' /etc/yum.repos.d/rocky.repo

RUN dnf -y -q install \
        libXpm net-tools bzip2 wget vim gcc gcc-c++ samba dos2unix glibc-devel glibc.i686 glibc-devel.i686 \
        mpfr.i686 mpfr-devel.i686 rsync autoconf automake libtool gettext* bison binutils \
        flex device-mapper-devel SDL libpciaccess libusb freetype freetype-devel qemu-* virt-* \
        libvirt* vte* NetworkManager-bluetooth brlapi fuse-devel dejavu* gnu-efi* pesign shim \
        iscsi-initiator-utils grub2-tools zip nasm acpica-tools glibc-static zlib-static xorriso lz4 squashfs-tools

RUN alternatives --install /usr/bin/python python /usr/bin/python3 3

CMD cd /ventoy/INSTALL && ls -la && sh docker_ci_build.sh
