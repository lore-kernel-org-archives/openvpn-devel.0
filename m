From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Pre-1.3.3 beta available for testing
Message-ID: <20030219133617.GE6319@...33...>
References: <200302161913.h1GJDuf19905@...41...>
Mime-Version: 1.0
In-Reply-To: <200302161913.h1GJDuf19905@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb 19 05:37:08 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sun, 16 Feb 2003, James Yonan wrote:

> Beta is available on CVS as well as here:
> 
> http://openvpn.sourceforge.net/beta/openvpn-1.3.2.9.tar.gz

I tried the current CVS as of some minutes ago on Linux, Solaris and
FreeBSD.  This first mail is about Linux, Solaris status is in a
separate mail.

This mail has four sections.

1. Here are important complaints of my compiler (SuSE 8.1, gcc 3.2, with
lzo):

packet_id.c: In function `packet_id_add':
packet_id.c:67: warning: comparison between signed and unsigned
socket.c: In function `getaddr':
socket.c:69: warning: comparison between signed and unsigned
tun.c:254: warning: `open_tun_generic' defined but not used

2. SuSE 7.3, gcc 2.95, without lzo installed is a no-go despite
--disable-lzo:

source='/home/ma/tmp/openvpn/lzo.c' object='lzo.o' libtool=no \
depfile='.deps/lzo.Po' tmpdepfile='.deps/lzo.TPo' \
depmode=gcc /bin/sh /home/ma/tmp/openvpn/depcomp \
gcc -DHAVE_CONFIG_H -I. -I/home/ma/tmp/openvpn -I.     -g -O2 -c `test -f '/home/ma/tmp/openvpn/lzo.c' || echo '/home/ma/tmp/openvpn/'`/home/ma/tmp/openvpn/lzo.c
In file included from /home/ma/tmp/openvpn/lzo.c:32:
/home/ma/tmp/openvpn/lzo.h:28: lzo1x.h: No such file or directory
make[1]: *** [lzo.o] Error 1

I tracked this down to flaws in the Makefile.am that ships a config.h
(which breaks VPATH builds). Here's a patch to rectify this and to
enable you to "make dist" to get the tarball with all subdirectories
included:


Index: openvpn.spec
===================================================================
RCS file: /cvsroot/openvpn/openvpn/openvpn.spec,v
retrieving revision 1.59
diff -u -r1.59 openvpn.spec
--- openvpn.spec	16 Feb 2003 19:01:49 -0000	1.59
+++ openvpn.spec	19 Feb 2003 13:34:48 -0000
@@ -22,7 +22,6 @@
 %setup -q
 
 %build
-./pre-touch
 %configure --enable-pthread
 %__make
 
Index: Makefile.am
===================================================================
RCS file: /cvsroot/openvpn/openvpn/Makefile.am,v
retrieving revision 1.3
diff -u -r1.3 Makefile.am
--- Makefile.am	25 Jun 2002 06:56:16 -0000	1.3
+++ Makefile.am	19 Feb 2003 13:24:25 -0000
@@ -24,9 +24,23 @@
 #
 
 sbin_PROGRAMS = openvpn
-openvpn_SOURCES = basic.h buffer.c buffer.h circ_list.h common.h config.h crypto.c crypto.h errlevel.h error.c error.h fdmisc.c fdmisc.h gremlin.c gremlin.h interval.h lzo.c lzo.h memdbg.h misc.c misc.h mtu.h openvpn.c openvpn.h options.c options.h packet_id.c packet_id.h reliable.c reliable.h session_id.c session_id.h shaper.c shaper.h socket.c socket.h ssl.c ssl.h syshead.h thread.c thread.h tun.c tun.h
+nodist_openvpn_SOURCES = config.h
+openvpn_SOURCES = basic.h buffer.c buffer.h circ_list.h common.h \
+		  crypto.c crypto.h errlevel.h error.c error.h \
+		  fdmisc.c fdmisc.h gremlin.c gremlin.h interval.h \
+		  lzo.c lzo.h memdbg.h misc.c misc.h mtu.h openvpn.c \
+		  openvpn.h options.c options.h packet_id.c \
+		  packet_id.h reliable.c reliable.h session_id.c \
+		  session_id.h shaper.c shaper.h socket.c socket.h \
+		  ssl.c ssl.h syshead.h thread.c thread.h tun.c tun.h
 
 KEY_FILES = dh1024.pem client.crt client.key server.crt server.key tmp-ca.crt tmp-ca.key
 
 man_MANS = openvpn.8
-EXTRA_DIST = $(KEY_FILES)
+EXTRA_DIST = $(KEY_FILES) $(man_MANS) \
+	     COPYRIGHT.GPL PORTS openvpn.spec \
+	     easy-rsa sample-config-files sample-keys \
+	     sample-scripts
+
+dist-hook:
+	cd $(distdir) && for i in $(EXTRA_DIST) ; do find $$i -name CVS -type d -prune -exec rm -r '{}' ';' ; done

3. I also suggest this patch to enhance portability, particularly for older,
possibly non-gcc, configurations:

Index: configure.ac
===================================================================
RCS file: /cvsroot/openvpn/openvpn/configure.ac,v
retrieving revision 1.51
diff -u -r1.51 configure.ac
--- configure.ac	16 Feb 2003 19:01:49 -0000	1.51
+++ configure.ac	19 Feb 2003 12:46:32 -0000
@@ -137,8 +137,11 @@
 dnl Checks for typedefs, structures, and compiler characteristics.
 AC_C_CONST
 AC_C_INLINE
+AC_C_VOLATILE
+AC_TYPE_OFF_T
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
+AC_TYPE_UID_T
 AC_HEADER_TIME
 
 dnl Check for more header files.

4. don't use autogen.sh, it has been superseded by "autoreconf". Try
   autoreconf -i -v (be chary about passing -f, it will kill your COPYING and
   INSTALL files!)

   I think you then don't need pre-touch either. In fact, I usually discourage
   keeping generated files in CVS. They only bloat things and cause unnecessary
   rebuilds and commits.

   Please consider doing:
   cvs rm -f Makefile.in aclocal.m4 config.h.in configure
   cvs rm -f config.guess config.sub depcomp install-sh missing
   cvs rm -f mkinstalldirs
   cvs commit -m "Remove generated files from CVS."

-- 
Matthias Andree

