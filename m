Date: Sun, 26 Apr 2009 18:39:46 +0400
From: Victor Wagner <vitus@...1066...>
Message-ID: <20090426143946.GA17612@...1066...>
References: <20090424131323.GB21576@...1066...>
	<fa2e1350904240747m2b9a110w471bceb2c335e765@...278...>
	<20090424202940.GA30397@...1066...>
	<251896ce0904250031l5aa2d985r234602e3fbc4d358@...278...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <251896ce0904250031l5aa2d985r234602e3fbc4d358@...278...>
Content-Transfer-Encoding: 7bit
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

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline

On 2009.04.25 at 16:31:14 +0900, Kazuyoshi Aizawa wrote:

> Hi Victor,
> 
> Could you please post the script once you have built drivers for your package?
> So that I can update my script as well.
> I've wanted to make script to be capable to build drivers on various
> platforms. But I don't have enough systems which can use for test.
> So if you would share your information, it would be appreciated.

Of course. See attached patch (configure.patch).

_This patch does following changes:_

1. If isainfo not found, use uname -p to determine architecture instead
of just fall back to i386. I assume that uname is always here on any
Unix system.

2. Add --disable-64bit argument. If it is not given, everything work as
before. If it is given, search for isainfo is disabled, and uname -p is
used to determine architecture (and it always give 32-bit architecture).

3. Support for DESTDIR variable is added to make install. 
If this variable is given in the make command line (i.e.)

 make install DESTDIR=`pwd`/pkg-tmp

files would be installed into $DESTDIR/usr/kernel instead of
/usr/kernel and no add_drv/rem_drv would be run. 
It is helpful when building a package to be installed on different
machines, but not one which is used for building.

_Things this patch doesn't do:_

It would be nice to check whether ld used is GNU ld or SUN ld, and use
correct ld options in each case (-m64 for GNU ld, and -64 for SUN ld).
But I always use SUN ld, so I didn't give this change a high priority

It would be nice to check whether our cc is GCC or Sun Studio and use
correct options for each compiler. But I don't have Sun Studio installed
on any of my machines.

_Applying patch:_

chdir to directory of driver sources and run 

patch -p1 < (whereever you've put attached configure.patch)

Using a patch program from SUNWcsu package (/usr/bin/patch) is OK 
(although it choke on plain diff -u output.)

_BTW:_ Why do you distribute modified tun.c file instead of patch?
Using patch has following advantages:
1. If some changes was done in upstream, which do not touch patched
functionality, patch produced with diff -u or diff -c probably would still 
apply and do the right thing

2. If there are incompatible changes in upstream, patch most likely
would break and user would clearly see that something goes wrong.

3. Your modified tun.c for openvpn-2.1rc15 is 4452 lines, and unified diff
between it and original one is 214 lines. 

I'm attaching this patch too (solaris.tap.patch).
It should be applied with patch -p0

If you are interested, I would send my packaging makefiles which produce
solaris package for your driver, which can be installed on both 32 and
64-bit machines. But somewhat later, because I've not finished them yet.


								Sincerely yours, Victor


--/04w6evG8XlLl3ft
Content-Type: text/x-diff; charset=koi8-r
Content-Disposition: attachment; filename="configure.patch"
Content-Transfer-Encoding: quoted-printable

Index: tuntap/Makefile.in
diff -ru tuntap/Makefile.in tuntap.patched/Makefile.in
--- tuntap/Makefile.in	=F0=D4 =C1=D0=D2. 28 19:38:13 2006
+++ tuntap.patched/Makefile.in	=F7=D3 =C1=D0=D2. 26 18:10:18 2009
@@ -50,15 +50,16 @@
 	$(CC) $(CFLAGS) -c tun.c -o tap.o -DTUNTAP_TAP
=20
 install: modules=20
-	$(INSTALL) -m 644 -o root -g root if_tun.h /usr/include/net=20
-	$(INSTALL) -m 644 -o root -g root tun $(DRV_DIR)
-	$(INSTALL) -m 644 -o root -g root tap $(DRV_DIR)
-	$(INSTALL) -m 644 -o root -g root tun.conf $(DRV_CONF_DIR)
-	$(INSTALL) -m 644 -o root -g root tap.conf $(DRV_CONF_DIR)
-	-$(REM_DRV) tun >/dev/null 2>&1
-	-$(REM_DRV) tap >/dev/null 2>&1
-	$(ADD_DRV) tun=09
-	$(ADD_DRV) tap
+	$(INSTALL) -m 644 -o root -g root if_tun.h $(DESTDIR)/usr/include/net=20
+	$(INSTALL) -m 644 -o root -g root tun $(DESTDIR)$(DRV_DIR)
+	$(INSTALL) -m 644 -o root -g root tap $(DESTDIR)$(DRV_DIR)
+	$(INSTALL) -m 644 -o root -g root tun.conf $(DESTDIR)$(DRV_CONF_DIR)
+	$(INSTALL) -m 644 -o root -g root tap.conf $(DESTDIR)$(DRV_CONF_DIR)
+	-[ -n "$(DESTDIR)" ]&& $(REM_DRV) tun >/dev/null 2>&1
+	-[ -n "$(DESTDIR)" ]&& $(REM_DRV) tap >/dev/null 2>&1
+	-[ -n "$(DESTDIR)" ]&& $(ADD_DRV) tun=09
+	-[ -n "$(DESTDIR)" ]&& $(ADD_DRV) tap
+endif
=20
 clean:
 	rm -f tun tap *.o *~
Index: tuntap/configure.in
diff -ru tuntap/configure.in tuntap.patched/configure.in
--- tuntap/configure.in	=F7=D3 =C9=C0=CE=D1 24 19:00:44 2007
+++ tuntap.patched/configure.in	=F7=D3 =C1=D0=D2. 26 18:15:54 2009
@@ -24,14 +24,22 @@
 AC_PROG_CC
 AC_PROG_INSTALL
=20
+AC_ARG_ENABLE([64bit],
+   [  --disable-64bit         disable build of 64-bit driver],
+[use_64bit=3D"$enableval"],[use_64bit=3Dyes])
+
+if test "$use_64bit" =3D "yes"
+then
 AC_CHECK_PROG(ISAINFO, isainfo, yes, no, /usr/bin)
-if test "$ISAINFO" =3D "yes" ;
+else
+ISAINFO=3Dno
+fi
+if test "$ISAINFO" =3D "yes" -a "$use_64bit" =3D "yes";
 then=20
     KARCH=3D`/usr/bin/isainfo -k`
 else
-    KARCH=3D'i386'
+    KARCH=3D`uname -p`
 fi
-
 case $KARCH in
      'sparc' | 'i386')
 	M64_OPT=3D""
@@ -50,7 +58,7 @@
 TUN_VER=3D"$REL `date '+%m/%d/%Y'`"; export TUN_VER
=20
 AC_ARG_ENABLE(debug,
-   --enable-debug        Enable debuging,
+[  --enable-debug          Enable debuging],
    AC_DEFINE(TUN_DEBUG, 1)
 )
=20

--/04w6evG8XlLl3ft
Content-Type: text/x-diff; charset=koi8-r
Content-Disposition: attachment; filename="solaris.tap.patch"

Index: tun.c
--- openvpn-2.1_rc15/tun.c	2008-11-17 03:48:04.000000000 +0300
+++ tun.c	2008-12-07 12:32:12.000000000 +0300
@@ -30,6 +30,12 @@
  * from VTun by Maxim Krasnyansky <max_mk@...109...>.
  */
 
+/*
+ *  Modified by: Kazuyoshi <admin2@...628...>
+ *  Modified for supporting tap device for Solaris
+ *  $Date: 2008/12/07 09:27:04 $, $Revision: 1.9 $
+ */
+
 #include "syshead.h"
 
 #include "tun.h"
@@ -63,6 +69,7 @@
 
 #ifdef TARGET_SOLARIS
 static void solaris_error_close (struct tuntap *tt, const struct env_set *es, const char *actual);
+#include <stropts.h>
 #endif
 
 bool
@@ -701,7 +708,13 @@
 			    );
 	}
       else
-	no_tap_ifconfig ();
+          argv_printf (&argv,
+                            " %s %s %s netmask %s broadcast + up",
+                            IFCONFIG_PATH,
+                            actual,
+                            ifconfig_local,
+                            ifconfig_remote_netmask
+                            );
 
       argv_msg (M_INFO, &argv);
       if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig phase-2 failed"))
@@ -1384,13 +1397,16 @@
 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, bool ipv6, struct tuntap *tt)
 {
-  int if_fd, muxid, ppa = -1;
-  struct ifreq ifr;
+  int if_fd, ip_muxid, arp_muxid, arp_fd, ppa = -1;
+  struct lifreq ifr;
   const char *ptr;
-  const char *ip_node;
+  const char *ip_node, *arp_node;
   const char *dev_tuntap_type;
   int link_type;
   bool is_tun;
+  struct strioctl  strioc_if, strioc_ppa;
+
+  memset(&ifr, 0x0, sizeof(ifr));
 
   ipv6_support (ipv6, false, tt);
 
@@ -1411,9 +1427,10 @@
     }
   else if (tt->type == DEV_TYPE_TAP)
     {
-      ip_node = "/dev/ip";
+      ip_node = "/dev/udp";
       if (!dev_node)
 	dev_node = "/dev/tap";
+      arp_node = dev_node;
       dev_tuntap_type = "tap";
       link_type = I_PLINK; /* was: I_LINK */
       is_tun = false;
@@ -1440,7 +1457,11 @@
     msg (M_ERR, "Can't open %s", dev_node);
 
   /* Assign a new PPA and get its unit number. */
-  if ((ppa = ioctl (tt->fd, TUNNEWPPA, ppa)) < 0)
+  strioc_ppa.ic_cmd = TUNNEWPPA;
+  strioc_ppa.ic_timout = 0;
+  strioc_ppa.ic_len = sizeof(ppa);
+  strioc_ppa.ic_dp = (char *)&ppa;
+  if ((ppa = ioctl (tt->fd, I_STR, &strioc_ppa)) < 0)
     msg (M_ERR, "Can't assign new interface");
 
   if ((if_fd = open (dev_node, O_RDWR, 0)) < 0)
@@ -1449,27 +1470,79 @@
   if (ioctl (if_fd, I_PUSH, "ip") < 0)
     msg (M_ERR, "Can't push IP module");
 
-  /* Assign ppa according to the unit number returned by tun device */
-  if (ioctl (if_fd, IF_UNITSEL, (char *) &ppa) < 0)
-    msg (M_ERR, "Can't set PPA %d", ppa);
-
-  if ((muxid = ioctl (tt->ip_fd, link_type, if_fd)) < 0)
-    msg (M_ERR, "Can't link %s device to IP", dev_tuntap_type);
-
-  close (if_fd);
+  if (tt->type == DEV_TYPE_TUN)
+    {
+        /* Assign ppa according to the unit number returned by tun device */
+        if (ioctl (if_fd, IF_UNITSEL, (char *) &ppa) < 0)
+          msg (M_ERR, "Can't set PPA %d", ppa);
+    }
 
   tt->actual_name = (char *) malloc (32);
   check_malloc_return (tt->actual_name);
 
   openvpn_snprintf (tt->actual_name, 32, "%s%d", dev_tuntap_type, ppa);
 
+  if (tt->type == DEV_TYPE_TAP)
+    {
+          if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0)
+            msg (M_ERR, "Can't get flags\n");
+          strncpynt (ifr.lifr_name, tt->actual_name, sizeof (ifr.lifr_name));
+          ifr.lifr_ppa = ppa;
+          /* Assign ppa according to the unit number returned by tun device */
+          if (ioctl (if_fd, SIOCSLIFNAME, &ifr) < 0)
+            msg (M_ERR, "Can't set PPA %d", ppa);
+          if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) <0)
+            msg (M_ERR, "Can't get flags\n");
+          /* Push arp module to if_fd */
+          if (ioctl (if_fd, I_PUSH, "arp") < 0)
+            msg (M_ERR, "Can't push ARP module");
+
+          /* Push arp module to ip_fd */
+          if (ioctl (tt->ip_fd, I_POP, NULL) < 0)
+            msg (M_ERR, "I_POP failed\n");
+          if (ioctl (tt->ip_fd, I_PUSH, "arp") < 0)
+            msg (M_ERR, "Can't push ARP module\n");
+
+          /* Open arp_fd */
+          if ((arp_fd = open (arp_node, O_RDWR, 0)) < 0)
+            msg (M_ERR, "Can't open %s\n", arp_node);
+          /* Push arp module to arp_fd */
+          if (ioctl (arp_fd, I_PUSH, "arp") < 0)
+            msg (M_ERR, "Can't push ARP module\n");
+
+          /* Set ifname to arp */
+          strioc_if.ic_cmd = SIOCSLIFNAME;
+          strioc_if.ic_timout = 0;
+          strioc_if.ic_len = sizeof(ifr);
+          strioc_if.ic_dp = (char *)&ifr;
+          if (ioctl(arp_fd, I_STR, &strioc_if) < 0){
+              msg (M_ERR, "Can't set ifname to arp\n");
+          }
+   }
+
+  if ((ip_muxid = ioctl (tt->ip_fd, link_type, if_fd)) < 0)
+    msg (M_ERR, "Can't link %s device to IP", dev_tuntap_type);
+
+  if (tt->type == DEV_TYPE_TAP) {
+          if ((arp_muxid = ioctl (tt->ip_fd, link_type, arp_fd)) < 0)
+            msg (M_ERR, "Can't link %s device to ARP", dev_tuntap_type);
+          close (arp_fd);
+  }
+
   CLEAR (ifr);
-  strncpynt (ifr.ifr_name, tt->actual_name, sizeof (ifr.ifr_name));
-  ifr.ifr_ip_muxid = muxid;
+  strncpynt (ifr.lifr_name, tt->actual_name, sizeof (ifr.lifr_name));
+  ifr.lifr_ip_muxid  = ip_muxid;
+  if (tt->type == DEV_TYPE_TAP) {
+          ifr.lifr_arp_muxid = arp_muxid;
+  }
 
-  if (ioctl (tt->ip_fd, SIOCSIFMUXID, &ifr) < 0)
+  if (ioctl (tt->ip_fd, SIOCSLIFMUXID, &ifr) < 0)
     {
-      ioctl (tt->ip_fd, I_PUNLINK, muxid);
+      if (tt->type == DEV_TYPE_TAP)
+        {
+              ioctl (tt->ip_fd, I_PUNLINK , arp_muxid);
+        }
+      ioctl (tt->ip_fd, I_PUNLINK, ip_muxid);
       msg (M_ERR, "Can't set multiplexor id");
     }
 
@@ -1486,19 +1559,25 @@
   if (tt)
     {
       if (tt->ip_fd >= 0)
-	{
-	  struct ifreq ifr;
-	  CLEAR (ifr);
-	  strncpynt (ifr.ifr_name, tt->actual_name, sizeof (ifr.ifr_name));
-
-	  if (ioctl (tt->ip_fd, SIOCGIFFLAGS, &ifr) < 0)
-	    msg (M_WARN | M_ERRNO, "Can't get iface flags");
-
-	  if (ioctl (tt->ip_fd, SIOCGIFMUXID, &ifr) < 0)
-	    msg (M_WARN | M_ERRNO, "Can't get multiplexor id");
+      {
+          struct lifreq ifr;
+          CLEAR (ifr);
+          strncpynt (ifr.lifr_name, tt->actual_name, sizeof (ifr.lifr_name));
+
+          if (ioctl (tt->ip_fd, SIOCGLIFFLAGS, &ifr) < 0)
+            msg (M_WARN | M_ERRNO, "Can't get iface flags");
+
+          if (ioctl (tt->ip_fd, SIOCGLIFMUXID, &ifr) < 0)
+            msg (M_WARN | M_ERRNO, "Can't get multiplexor id");
+
+          if (tt->type == DEV_TYPE_TAP)
+            {
+                  if (ioctl (tt->ip_fd, I_PUNLINK, ifr.lifr_arp_muxid) < 0)
+                    msg (M_WARN | M_ERRNO, "Can't unlink interface(arp)");
+            }
 
-	  if (ioctl (tt->ip_fd, I_PUNLINK, ifr.ifr_ip_muxid) < 0)
-	    msg (M_WARN | M_ERRNO, "Can't unlink interface");
+          if (ioctl (tt->ip_fd, I_PUNLINK, ifr.lifr_ip_muxid) < 0)
+            msg (M_WARN | M_ERRNO, "Can't unlink interface(ip)");
 
 	  close (tt->ip_fd);
 	  tt->ip_fd = -1;

--/04w6evG8XlLl3ft--

