MIME-Version: 1.0
In-Reply-To: <CAOazyz1buhSdSF7g6MzePAiQ=irD_Qo-RKPC_jXoR9AVqbtkvQ@...278...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOazyz1buhSdSF7g6MzePAiQ=irD_Qo-RKPC_jXoR9AVqbtkvQ@...278...>
Date: Wed, 22 Feb 2012 08:16:14 +0100
Message-ID: <CAOBzU4P0SxY-jF7rb_HsvmtSH8i9PCk+qe5iDQiwJhajsBuYuw@...278...>
From: Frank de Brabander <debrabander@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

dhcp-091:openvpn_src brabander$ git clone --branch build
https://github.com/alonbl/openvpn.git openvpn_alonbl
Cloning into openvpn_alonbl...
remote: Counting objects: 7257, done.
remote: Compressing objects: 100% (1499/1499), done.
remote: Total 7257 (delta 5860), reused 7106 (delta 5709)
Receiving objects: 100% (7257/7257), 2.17 MiB | 621 KiB/s, done.
Resolving deltas: 100% (5860/5860), done.
dhcp-091:openvpn_src brabander$ cd openvpn_alonbl/
dhcp-091:openvpn_alonbl brabander$ autoreconf -i -v
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal -I m4
autoreconf: configure.ac: tracing
autoreconf: running: glibtoolize --copy
glibtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `.'.
glibtoolize: copying file `./ltmain.sh'
glibtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.
glibtoolize: copying file `m4/libtool.m4'
glibtoolize: copying file `m4/ltoptions.m4'
glibtoolize: copying file `m4/ltsugar.m4'
glibtoolize: copying file `m4/ltversion.m4'
glibtoolize: copying file `m4/lt~obsolete.m4'
autoreconf: running: /usr/bin/autoconf
autoreconf: running: /usr/bin/autoheader
autoreconf: running: automake --add-missing --copy --no-force
configure.ac:39: installing `./config.sub'
configure.ac:38: installing `./missing'
configure.ac:38: installing `./install-sh'
configure.ac:39: installing `./config.guess'
src/openvpn/Makefile.am: installing `./depcomp'
autoreconf: Leaving directory `.'
dhcp-091:openvpn_alonbl brabander$ ./configure PKG_CONFIG=3Dfalse
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... ./install-sh -c -d
checking for gawk... no
checking for mawk... no
checking for nawk... no
checking for awk... awk
checking whether make sets $(MAKE)... yes
checking build system type... i386-apple-darwin11.3.0
checking host system type... i386-apple-darwin11.3.0
checking for style of include used by make... GNU
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking dependency style of gcc... gcc3
checking how to run the C preprocessor... gcc -E
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for AIX... no
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking minix/config.h usability... no
checking minix/config.h presence... no
checking for minix/config.h... no
checking whether it is safe to define __EXTENSIONS__... yes
checking pkg-config is at least version 0.9.0... no
checking how to run the C preprocessor... gcc -E
checking for a BSD-compatible install... /usr/bin/install -c
checking whether ln -s works... yes
checking whether make sets $(MAKE)... (cached) yes
checking for ifconfig... /sbin/ifconfig
checking for route... /sbin/route
checking for ip... no
checking for netstat... netstat
checking for man2html... no
checking how to print strings... printf
checking for a sed that does not truncate output... /usr/bin/sed
checking for fgrep... /usr/bin/grep -F
checking for ld used by gcc...
/usr/llvm-gcc-4.2/libexec/gcc/i686-apple-darwin11/4.2.1/ld
checking if the linker
(/usr/llvm-gcc-4.2/libexec/gcc/i686-apple-darwin11/4.2.1/ld) is GNU
ld... no
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm
checking the name lister (/usr/bin/nm) interface... BSD nm
checking the maximum length of command line arguments... 196608
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+=3D"... yes
checking for /usr/llvm-gcc-4.2/libexec/gcc/i686-apple-darwin11/4.2.1/ld
option to reload object files... -r
checking for objdump... no
checking how to recognize dependent libraries... pass_all
checking for ar... ar
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm output from gcc object... ok
checking for dsymutil... dsymutil
checking for nmedit... nmedit
checking for lipo... lipo
checking for otool... otool
checking for otool64... no
checking for -single_module linker flag... yes
checking for -exported_symbols_list linker flag... yes
checking for -force_load linker flag... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fno-common -DPIC
checking if gcc PIC flag -fno-common -DPIC works... yes
checking if gcc static flag -static works... no
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker
(/usr/llvm-gcc-4.2/libexec/gcc/i686-apple-darwin11/4.2.1/ld) supports
shared libraries... yes
checking dynamic linker characteristics... darwin11.3.0 dyld
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for windres... no
checking for an ANSI C-conforming const... yes
checking for inline... inline
checking for working volatile... yes
checking for off_t... yes
checking for pid_t... yes
checking for size_t... yes
checking for uid_t in sys/types.h... yes
checking for int8_t... yes
checking for int16_t... yes
checking for int32_t... yes
checking for int64_t... yes
checking for uint8_t... yes
checking for uint16_t... yes
checking for uint32_t... yes
checking for uint64_t... yes
checking return type of signal handlers... void
checking for ISO C 1999 vararg macro support... no
checking for GNU GCC vararg macro support... no
checking for socklen_t... yes
checking for C compiler empty array size... 0
checking for unsigned int... yes
checking size of unsigned int... 4
checking for unsigned long... yes
checking size of unsigned long... 8
checking stdio.h usability... yes
checking stdio.h presence... yes
checking for stdio.h... yes
checking stdarg.h usability... yes
checking stdarg.h presence... yes
checking for stdarg.h... yes
checking time.h usability... yes
checking time.h presence... yes
checking for time.h... yes
checking errno.h usability... yes
checking errno.h presence... yes
checking for errno.h... yes
checking fcntl.h usability... yes
checking fcntl.h presence... yes
checking for fcntl.h... yes
checking io.h usability... no
checking io.h presence... no
checking for io.h... no
checking direct.h usability... no
checking direct.h presence... no
checking for direct.h... no
checking ctype.h usability... yes
checking ctype.h presence... yes
checking for ctype.h... yes
checking for sys/types.h... (cached) yes
checking sys/socket.h usability... yes
checking sys/socket.h presence... yes
checking for sys/socket.h... yes
checking signal.h usability... yes
checking signal.h presence... yes
checking for signal.h... yes
checking for unistd.h... (cached) yes
checking for dlfcn.h... (cached) yes
checking netinet/in.h usability... yes
checking netinet/in.h presence... yes
checking for netinet/in.h... yes
checking netinet/in_systm.h usability... yes
checking netinet/in_systm.h presence... yes
checking for netinet/in_systm.h... yes
checking netinet/tcp.h usability... yes
checking netinet/tcp.h presence... yes
checking for netinet/tcp.h... yes
checking arpa/inet.h usability... yes
checking arpa/inet.h presence... yes
checking for arpa/inet.h... yes
checking netdb.h usability... yes
checking netdb.h presence... yes
checking for netdb.h... yes
checking windows.h usability... no
checking windows.h presence... no
checking for windows.h... no
checking winsock2.h usability... no
checking winsock2.h presence... no
checking for winsock2.h... no
checking ws2tcpip.h usability... no
checking ws2tcpip.h presence... no
checking for ws2tcpip.h... no
checking sys/time.h usability... yes
checking sys/time.h presence... yes
checking for sys/time.h... yes
checking sys/un.h usability... yes
checking sys/un.h presence... yes
checking for sys/un.h... yes
checking sys/ioctl.h usability... yes
checking sys/ioctl.h presence... yes
checking for sys/ioctl.h... yes
checking for sys/stat.h... (cached) yes
checking sys/mman.h usability... yes
checking sys/mman.h presence... yes
checking for sys/mman.h... yes
checking sys/file.h usability... yes
checking sys/file.h presence... yes
checking for sys/file.h... yes
checking for unistd.h... (cached) yes
checking for signal.h... (cached) yes
checking syslog.h usability... yes
checking syslog.h presence... yes
checking for syslog.h... yes
checking pwd.h usability... yes
checking pwd.h presence... yes
checking for pwd.h... yes
checking grp.h usability... yes
checking grp.h presence... yes
checking for grp.h... yes
checking net/if_tun.h usability... no
checking net/if_tun.h presence... no
checking for net/if_tun.h... no
checking net/tun/if_tun.h usability... no
checking net/tun/if_tun.h presence... no
checking for net/tun/if_tun.h... no
checking stropts.h usability... no
checking stropts.h presence... no
checking for stropts.h... no
checking sys/sockio.h usability... yes
checking sys/sockio.h presence... yes
checking for sys/sockio.h... yes
checking sys/uio.h usability... yes
checking sys/uio.h presence... yes
checking for sys/uio.h... yes
checking linux/if_tun.h usability... no
checking linux/if_tun.h presence... no
checking for linux/if_tun.h... no
checking linux/sockios.h usability... no
checking linux/sockios.h presence... no
checking for linux/sockios.h... no
checking linux/types.h usability... no
checking linux/types.h presence... no
checking for linux/types.h... no
checking sys/poll.h usability... yes
checking sys/poll.h presence... yes
checking for sys/poll.h... yes
checking sys/epoll.h usability... no
checking sys/epoll.h presence... no
checking for sys/epoll.h... no
checking err.h usability... yes
checking err.h presence... yes
checking for err.h... yes
checking for net/if.h... yes
checking for netinet/ip.h... yes
checking for netinet/if_ether.h... yes
checking for resolv.h... yes
checking for in_addr_t... yes
checking for struct tun_pi... no
checking for struct iphdr... no
checking for struct sock_extended_err... no
checking for struct msghdr... yes
checking for struct cmsghdr... yes
checking for struct in_pktinfo... yes
checking for struct sockaddr_in6... yes
checking whether SO_MARK is declared... no
checking whether SIGHUP is declared... yes
checking whether SIGINT is declared... yes
checking whether SIGUSR1 is declared... yes
checking whether SIGUSR2 is declared... yes
checking whether SIGTERM is declared... yes
checking vfork.h usability... no
checking vfork.h presence... no
checking for vfork.h... no
checking for fork... yes
checking for vfork... yes
checking for working fork... yes
checking for working vfork... (cached) yes
checking for daemon... yes
checking for chroot... yes
checking for getpwnam... yes
checking for setuid... yes
checking for nice... yes
checking for system... yes
checking for getpid... yes
checking for dup... yes
checking for dup2... yes
checking for getpass... yes
checking for strerror... yes
checking for syslog... yes
checking for openlog... yes
checking for mlockall... yes
checking for getgrnam... yes
checking for setgid... yes
checking for setgroups... yes
checking for stat... yes
checking for flock... yes
checking for readv... yes
checking for writev... yes
checking for time... yes
checking for gettimeofday... yes
checking for ctime... yes
checking for memset... yes
checking for vsnprintf... yes
checking for strdup... yes
checking for setsid... yes
checking for chdir... yes
checking for putenv... yes
checking for getpeername... yes
checking for unlink... yes
checking for chsize... no
checking for ftruncate... yes
checking for execve... yes
checking for getpeereid... yes
checking for umask... yes
checking for basename... yes
checking for dirname... yes
checking for access... yes
checking for epoll_create... no
checking for sendmsg... yes
checking for recvmsg... yes
checking for res_init... yes
checking for socket... yes
checking for recv... yes
checking for recvfrom... yes
checking for send... yes
checking for sendto... yes
checking for listen... yes
checking for accept... yes
checking for connect... yes
checking for bind... yes
checking for select... yes
checking for gethostbyname... yes
checking for inet_ntoa... yes
checking for setsockopt... yes
checking for getsockopt... yes
checking for getsockname... yes
checking for poll... yes
checking for dlopen in -ldl... yes
checking for inet_ntoa in -lnsl... no
checking for socket in -lsocket... no
checking for gethostbyname in -lresolv... yes
checking for setcon in -lselinux... no
checking for OPENSSL_CRYPTO... no
checking for RSA_new in -lcrypto... yes
checking for OPENSSL_SSL... no
checking for SSL_CTX_new in -lssl... yes
checking for EVP_CIPHER_CTX_set_key_length... yes
checking for ENGINE_load_builtin_engines... yes
checking for ENGINE_register_all_complete... yes
checking for ENGINE_cleanup... yes
checking for ssl_init in -lpolarssl... no
checking for aes_crypt_cbc in -lpolarssl... no
checking for lzo1x_1_15_compress in -llzo2... no
checking for lzo1x_1_15_compress in -llzo... no
checking for PKCS11_HELPER... no
configure: creating ./config.status
config.status: creating Makefile
config.status: creating build/Makefile
config.status: creating build/msvc/Makefile
config.status: creating build/msvc/msvc-generate/Makefile
config.status: creating distro/Makefile
config.status: creating distro/rpm/Makefile
config.status: creating distro/rpm/openvpn.spec
config.status: creating include/Makefile
config.status: creating src/Makefile
config.status: creating src/openvpn/Makefile
config.status: creating src/openvpnserv/Makefile
config.status: creating tests/Makefile
config.status: creating sample/Makefile
config.status: creating doc/Makefile
config.status: creating tests/t_client.sh
config.status: creating config.h
config.status: executing depfiles commands
config.status: executing libtool commands

make & make check both run OK, but is it normal that make check
doesn't do anything anymore?

dhcp-091:openvpn_alonbl brabander$ make check
Making check in build
Making check in msvc
Making check in msvc-generate
make[3]: Nothing to be done for `check'.
make[3]: Nothing to be done for `check-am'.
make[2]: Nothing to be done for `check-am'.
Making check in distro
Making check in rpm
make[2]: Nothing to be done for `check'.
make[2]: Nothing to be done for `check-am'.
Making check in include
make[1]: Nothing to be done for `check'.
Making check in src
Making check in openvpn
make[2]: Nothing to be done for `check'.
Making check in openvpnserv
make[2]: Nothing to be done for `check'.
make[2]: Nothing to be done for `check-am'.
Making check in sample
make[1]: Nothing to be done for `check'.
Making check in doc
make[1]: Nothing to be done for `check'.
Making check in tests
make[1]: Nothing to be done for `check'.
make[1]: Nothing to be done for `check-am'.


Op 21 februari 2012 21:21 heeft Alon Bar-Lev <alon.barlev@...277...>
het volgende geschreven:
> Hello Frank,
>
> Can you please try the recent branch head?
> It should solve this issue as it turns out that for some strange
> reason your environment autoreconf using <autoconf-2.60.
>
> Now it should be supported.
>
> Thanks!
> Alon
>
> On Tue, Feb 21, 2012 at 10:07 AM, Alon Bar-Lev <alon.barlev@...277...> wr=
ote:
>> Hello Frank,
>>
>> Thank you for testing.
>>
>> Can you please try to download my tarball[1] and not autoreconf at your =
machine?
>> I think your autotools are waaay to old.
>>
>> And... can you please send me:
>> # autoconf --version
>> # aclocal --version
>> # automake --version
>> # libtool --version
>>
>> Alon
>>
>> [1] https://github.com/alonbl/openvpn/downloads
>>
>>
>> On Tue, Feb 21, 2012 at 9:47 AM, Frank de Brabander
>> <debrabander@...277...> wrote:
>>> I did a quick test on OS X (Lion) and the build fails.
>>>
>>> mekboek:openvpn_src brabander$ git clone --branch build
>>> https://github.com/alonbl/openvpn.git openvpn_alonbl
>>> mekboek:openvpn_src brabander$ cd openvpn_alonbl/
>>> mekboek:openvpn_alonbl brabander$ autoreconf -i -v
>>> autoreconf: Entering directory `.'
>>> autoreconf: configure.ac: not using Gettext
>>> autoreconf: running: aclocal -I m4
>>> configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
>>> of an AC_DEFINE in the second argument, where no actions should be
>>> taken
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/g=
eneral.m4:1905:
>>> AC_CACHE_VAL is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/g=
eneral.m4:1918:
>>> AC_CACHE_CHECK is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/m4=
sh.m4:523:
>>> AS_IF is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/t=
ypes.m4:243:
>>> AC_CHECK_TYPE is expanded from...
>>> m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
>>> configure.ac:337: the top level
>>> autoreconf: configure.ac: tracing
>>> configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
>>> of an AC_DEFINE in the second argument, where no actions should be
>>> taken
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/g=
eneral.m4:1905:
>>> AC_CACHE_VAL is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/g=
eneral.m4:1918:
>>> AC_CACHE_CHECK is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/m4=
sh.m4:523:
>>> AS_IF is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/t=
ypes.m4:243:
>>> AC_CHECK_TYPE is expanded from...
>>> m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
>>> configure.ac:337: the top level
>>> autoreconf: running: glibtoolize --copy
>>> glibtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `.'.
>>> glibtoolize: copying file `./ltmain.sh'
>>> glibtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.
>>> glibtoolize: copying file `m4/libtool.m4'
>>> glibtoolize: copying file `m4/ltoptions.m4'
>>> glibtoolize: copying file `m4/ltsugar.m4'
>>> glibtoolize: copying file `m4/ltversion.m4'
>>> glibtoolize: copying file `m4/lt~obsolete.m4'
>>> configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
>>> of an AC_DEFINE in the second argument, where no actions should be
>>> taken
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/g=
eneral.m4:1905:
>>> AC_CACHE_VAL is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/g=
eneral.m4:1918:
>>> AC_CACHE_CHECK is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/m4=
sh.m4:523:
>>> AS_IF is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/t=
ypes.m4:243:
>>> AC_CHECK_TYPE is expanded from...
>>> m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
>>> configure.ac:337: the top level
>>> autoreconf: running: /usr/bin/autoconf
>>> configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
>>> of an AC_DEFINE in the second argument, where no actions should be
>>> taken
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/g=
eneral.m4:1905:
>>> AC_CACHE_VAL is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/g=
eneral.m4:1918:
>>> AC_CACHE_CHECK is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/m4=
sh.m4:523:
>>> AS_IF is expanded from...
>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf/t=
ypes.m4:243:
>>> AC_CHECK_TYPE is expanded from...
>>> m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
>>> configure.ac:337: the top level
>>> configure.ac:31: error: possibly undefined macro: AC_DEFINE
>>> =A0 =A0 =A0If this token and others are legitimate, please use m4_patte=
rn_allow.
>>> =A0 =A0 =A0See the Autoconf documentation.
>>> configure.ac:545: error: possibly undefined macro: AC_CHECK_LIB
>>> configure:14349: error: possibly undefined macro: AS_VAR_IF
>>> autoreconf: /usr/bin/autoconf failed with exit status: 1
>>>
>>> -----------------------------------------------------------------------=
-------
>>> Keep Your Developer Skills Current with LearnDevNow!
>>> The most comprehensive online learning library for Microsoft developers
>>> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
>>> Metro Style Apps, more. Free future releases when you subscribe now!
>>> http://p.sf.net/sfu/learndevnow-d2d
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

