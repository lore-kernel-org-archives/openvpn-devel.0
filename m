Date: Sun, 26 Apr 2009 20:07:34 +0400
From: Victor Wagner <vitus@...1066...>
Message-ID: <20090426160734.GA19542@...1066...>
References: <20090424131323.GB21576@...1066...>
	<fa2e1350904240747m2b9a110w471bceb2c335e765@...278...>
	<20090424202940.GA30397@...1066...>
	<251896ce0904250031l5aa2d985r234602e3fbc4d358@...278...>
	<20090426143946.GA17612@...1066...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20090426143946.GA17612@...1066...>
Subject: Re: [Openvpn-devel] Solaris questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On 2009.04.26 at 18:39:46 +0400, Victor Wagner wrote:

> Of course. See attached patch (configure.patch).

Unfortunately, I've send untested patch. I've checked configure
invocation, but was too haste to check whether produced Makefile would
work.

Now there is tested patch.

Only thing is that to do make install without root rights (which is
common thing when building package and installing into temporary
directory) you need /usr/ucb/install from SUNscpu package.

Either included install-sh or GNU install from sunfreeware fails for
unability to chown files.

With this patch I've been able to build package for
Solaris 8,9,10 both i386 and sparc. And all Sparc packages and 10/intel
contain both 64-bit and 32-bit drivers.

I do not attach packaging Makefile yet, becouse it depends on my
solaris packaging scripts, which are not published anywhere.



--azLHFNyN32YCQGCU
Content-Type: text/x-diff; charset=koi8-r
Content-Disposition: attachment; filename="configure.patch"

Index: tuntap/configure.in
diff -ru tuntap.orig/configure.in tuntap/configure.in
--- tuntap.orig/configure.in	2007-06-24 19:00:44.000000000 +0400
+++ tuntap/configure.in	2009-04-26 19:18:18.000000000 +0400
@@ -24,14 +24,22 @@
 AC_PROG_CC
 AC_PROG_INSTALL
 
+AC_ARG_ENABLE([64bit],
+   [  --disable-64bit         disable build of 64-bit driver],
+[use_64bit="$enableval"],[use_64bit=yes])
+
+if test "$use_64bit" = "yes"
+then
 AC_CHECK_PROG(ISAINFO, isainfo, yes, no, /usr/bin)
-if test "$ISAINFO" = "yes" ;
+else
+ISAINFO=no
+fi
+if test "$ISAINFO" = "yes" -a "$use_64bit" = "yes";
 then 
     KARCH=`/usr/bin/isainfo -k`
 else
-    KARCH='i386'
+    KARCH=`uname -p`
 fi
-
 case $KARCH in
      'sparc' | 'i386')
 	M64_OPT=""
@@ -50,7 +58,7 @@
 TUN_VER="$REL `date '+%m/%d/%Y'`"; export TUN_VER
 
 AC_ARG_ENABLE(debug,
-   --enable-debug        Enable debuging,
+[  --enable-debug          Enable debuging],
    AC_DEFINE(TUN_DEBUG, 1)
 )
 
Index: tuntap/Makefile.in
diff -ru tuntap.orig/Makefile.in tuntap/Makefile.in
--- tuntap.orig/Makefile.in	2006-04-28 19:38:13.000000000 +0400
+++ tuntap/Makefile.in	2009-04-26 19:53:35.000000000 +0400
@@ -50,15 +50,18 @@
 	$(CC) $(CFLAGS) -c tun.c -o tap.o -DTUNTAP_TAP
 
 install: modules 
-	$(INSTALL) -m 644 -o root -g root if_tun.h /usr/include/net 
-	$(INSTALL) -m 644 -o root -g root tun $(DRV_DIR)
-	$(INSTALL) -m 644 -o root -g root tap $(DRV_DIR)
-	$(INSTALL) -m 644 -o root -g root tun.conf $(DRV_CONF_DIR)
-	$(INSTALL) -m 644 -o root -g root tap.conf $(DRV_CONF_DIR)
-	-$(REM_DRV) tun >/dev/null 2>&1
-	-$(REM_DRV) tap >/dev/null 2>&1
-	$(ADD_DRV) tun	
-	$(ADD_DRV) tap
+	[ -n "$(DESTDIR)" ] && $(INSTALL) -d -m 0755 -o root -g bin $(DESTDIR)/usr/include/net
+	[ -n "$(DESTDIR)" ] && $(INSTALL) -d -m 0755 -o root -g sys $(DESTDIR)$(DRV_DIR)
+	$(INSTALL) -m 644 -o root -g root if_tun.h $(DESTDIR)/usr/include/net 
+	$(INSTALL) -m 644 -o root -g root tun $(DESTDIR)$(DRV_DIR)
+	$(INSTALL) -m 644 -o root -g root tap $(DESTDIR)$(DRV_DIR)
+	$(INSTALL) -m 644 -o root -g root tun.conf $(DESTDIR)$(DRV_CONF_DIR)
+	$(INSTALL) -m 644 -o root -g root tap.conf $(DESTDIR)$(DRV_CONF_DIR)
+	
+	-[ -z "$(DESTDIR)" ]&& $(REM_DRV) tun >/dev/null 2>&1
+	-[ -z "$(DESTDIR)" ]&& $(REM_DRV) tap >/dev/null 2>&1
+	-[ -z "$(DESTDIR)" ]&& $(ADD_DRV) tun	
+	-[ -z "$(DESTDIR)" ]&& $(ADD_DRV) tap
 
 clean:
 	rm -f tun tap *.o *~

--azLHFNyN32YCQGCU--

