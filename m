Message-ID: <70BE12F3EEB84953AEC765E475A7CA70@...1853...>
From: <debbie10t@...277...>
Date: Thu, 23 Jul 2015 23:44:41 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] autoreconf: Unescaped left brace in regex is
	deprecated
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi

Openvpn still compiles without noticable errors and
functions correctly under my variety of test but
I was wondering if this is important ?

[root@...2045... openvpn]# pacman -Syu
:: Synchronising package databases...
 core is up to date
 extra is up to date
 community                                             2.7 MiB   678K/s
00:04 [############################################] 100%
:: Starting full system upgrade...
 there is nothing to do

[root@...2045... openvpn]# mkdir 20150723
[root@...2045... openvpn]# git clone https://github.com/OpenVPN/openvpn 20150723
Cloning into '20150723'...
remote: Counting objects: 11999, done.
remote: Total 11999 (delta 0), reused 0 (delta 0), pack-reused 11999
Receiving objects: 100% (11999/11999), 10.27 MiB | 730.00 KiB/s, done.
Resolving deltas: 100% (8337/8337), done.
Checking connectivity... done.

[root@...2045... 20150706]# systemctl stop openvpn@*
[root@...2045... 20150706]# ps -ef|grep open
root       535   393  0 22:49 pts/0    00:00:00 grep open

[root@...2045... 20150706]# whereis openvpn
openvpn: /etc/openvpn /usr/local/sbin/openvpn /usr/local/lib/openvpn

[root@...2045... openvpn]# cd 20150723
[root@...2045... 20150723]# autoreconf -i -v -f
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal --force -I m4
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
autoreconf: configure.ac: tracing
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
autoreconf: running: libtoolize --copy --force
libtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, '.'.
libtoolize: copying file './ltmain.sh'
libtoolize: putting macros in AC_CONFIG_MACRO_DIRS, 'm4'.
libtoolize: copying file 'm4/libtool.m4'
libtoolize: copying file 'm4/ltoptions.m4'
libtoolize: copying file 'm4/ltsugar.m4'
libtoolize: copying file 'm4/ltversion.m4'
libtoolize: copying file 'm4/lt~obsolete.m4'
libtoolize: Remember to add 'LT_INIT' to configure.ac.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
autoreconf: running: /usr/bin/autoconf --force
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
autoreconf: running: /usr/bin/autoheader --force
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
autoreconf: running: automake --add-missing --copy --force-missing
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
Unescaped left brace in regex is deprecated, passed through in regex; marked
by <-- HERE in m/\${ <-- HERE ([^ \t=:+{}]+)}/ at /usr/bin/automake line
3936.
configure.ac:54: installing './compile'
configure.ac:53: installing './config.guess'
configure.ac:53: installing './config.sub'
configure.ac:52: installing './install-sh'
configure.ac:52: installing './missing'
src/compat/Makefile.am: installing './depcomp'
autoreconf: Leaving directory `.'
[root@...2045... 20150723]#

[root@...2045... 20150723]# gcc --version
gcc (GCC) 5.2.0
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

[root@...2045... 20150723]# uname -a
Linux home 4.1.2-2-ARCH #1 SMP PREEMPT Wed Jul 15 08:51:45 UTC 2015 i686
GNU/Linux

[root@...2045... 20150723]# autoreconf --version
autoreconf (GNU Autoconf) 2.69
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+/Autoconf: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>,
<http://gnu.org/licenses/exceptions.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by David J. MacKenzie and Akim Demaille.
[root@...2045... 20150723]#

[root@...2046... 20150723]# openvpn --version
OpenVPN 2.3_git 20150723 [git:master/82acf2163412aae9+] i686-pc-linux-gnu
[SSL (OpenSSL)] [LZO] [SNAPPY] [LZ4] [EPOLL] [MH] [IPv6] built on Jul 23
2015
library versions: OpenSSL 1.0.2d 9 Jul 2015, LZO 2.09
Originally developed by James Yonan
Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
Compile time defines: enable_comp_stub=no enable_crypto=yes
enable_crypto_ofb_cfb=yes enable_debug=yes enable_def_auth=yes
enable_dlopen=unknown enable_dlopen_self=unknown
enable_dlopen_self_static=unknown enable_fast_install=yes
enable_fragment=yes enable_iproute2=no enable_libtool_lock=yes
enable_lz4=yes enable_lzo=yes enable_management=yes enable_multi=yes
enable_multihome=yes enable_pam_dlopen=no enable_password_save=no
enable_pedantic=no enable_pf=yes enable_pkcs11=no enable_plugin_auth_pam=yes
enable_plugin_down_root=yes enable_plugins=yes enable_port_share=yes
enable_selinux=no enable_server=yes enable_shared=yes
enable_shared_with_static_runtimes=no enable_small=no enable_snappy=yes
enable_static=yes enable_strict=no enable_strict_options=no
enable_systemd=no enable_werror=no enable_win32_dll=yes
enable_x509_alt_username=no with_aix_soname=aix with_crypto_library=openssl
with_gnu_ld=yes with_mem_check=no with_plugindir='$(libdir)/openvpn/plugins'
with_sysroot=no


--
Thanks


