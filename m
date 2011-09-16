Date: Fri, 16 Sep 2011 20:00:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110916180039.GR8496@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="89pfdy8kpQe6B5Nt"
Content-Disposition: inline
Subject: [Openvpn-devel] NetBSD platform cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--89pfdy8kpQe6B5Nt
Content-Type: multipart/mixed; boundary="cFU7Ny1L0ShjNgMX"
Content-Disposition: inline

--cFU7Ny1L0ShjNgMX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

testing today's "master" for problems due to the SVN merger (what bit
ecrist on FreeBSD), I noticed a number of problems on NetBSD with the
way tun/tap devices are handled, and (not) cleaned up at session end.

The attached patch cleans up the tun.c code for NetBSD, and has been
tested with IPv4 + IPv6, TUN mode, TUN/top-subnet mode and TAP mode,
and passes all tests *except* TAP+IPv6 (and that one seems to be a
NetBSD kernel side issue, still investigating).

David, please ACK and merge :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cFU7Ny1L0ShjNgMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-platform-cleanup-for-NetBSD.patch"
Content-Transfer-Encoding: quoted-printable

=46rom e5c787261e973ee0638b940f6b4f0e7767890e00 Mon Sep 17 00:00:00 2001
From: Gert Doering <gd@...1505...>
Date: Fri, 16 Sep 2011 19:51:09 +0200
Subject: [PATCH] platform cleanup for NetBSD:

make TAP devices work (need to go via multiplex device /dev/tap)
cleanup TUN devices at program end ("ifconfig tunX destroy")
correctly setup TUN devices for "topology subnet"
don't try to put TAP devices into TUNSIFHEAD mode (get rid of error message)

tested on NetBSD 5.1_STABLE / Sparc64

Signed-off-by: Gert Doering <gd@...1505...>
---
 syshead.h |    4 +++
 tun.c     |   84 +++++++++++++++++++++++++++++++++++++++++++++++++--------=
---
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/syshead.h b/syshead.h
index e208d4c..f10ae04 100644
--- a/syshead.h
+++ b/syshead.h
@@ -207,6 +207,10 @@
 #include <net/if.h>
 #endif
=20
+#ifdef TARGET_NETBSD
+#include <net/if_tap.h>
+#endif
+
 #ifdef TARGET_LINUX
=20
 #if defined(HAVE_NETINET_IF_ETHER_H)
diff --git a/tun.c b/tun.c
index aa17c36..a71909c 100644
--- a/tun.c
+++ b/tun.c
@@ -946,16 +946,6 @@ do_ifconfig (struct tuntap *tt,
 # define NETBSD_MULTI_AF
 #endif
=20
-      /* as on OpenBSD and Darwin, destroy and re-create tun<x> interface
-       */
-      argv_printf (&argv, "%s %s destroy", IFCONFIG_PATH, actual );
-      argv_msg (M_INFO, &argv);
-      openvpn_execve_check (&argv, es, 0, "NetBSD ifconfig destroy failed"=
);
-
-      argv_printf (&argv, "%s %s create", IFCONFIG_PATH, actual );
-      argv_msg (M_INFO, &argv);
-      openvpn_execve_check (&argv, es, S_FATAL, "NetBSD ifconfig create fa=
iled");
-
       if (tun)
 	argv_printf (&argv,
 			  "%s %s %s %s mtu %d netmask 255.255.255.255 up",
@@ -966,6 +956,19 @@ do_ifconfig (struct tuntap *tt,
 			  tun_mtu
 			  );
       else
+	if ( tt->topology =3D=3D TOP_SUBNET )
+	{
+	    argv_printf (&argv,
+			  "%s %s %s %s mtu %d netmask %s up",
+			  IFCONFIG_PATH,
+			  actual,
+			  ifconfig_local,
+			  ifconfig_local,
+			  tun_mtu,
+			  ifconfig_remote_netmask
+			  );
+	}
+      else
       /*
        * NetBSD has distinct tun and tap devices
        * so we don't need the "link0" extra parameter to specify we want t=
o do=20
@@ -1265,6 +1268,30 @@ open_tun_generic (const char *dev, const char *dev_t=
ype, const char *dev_node,
 	   * explicit unit number.  Try opening /dev/[dev]n
 	   * where n =3D [0, 255].
 	   */
+#ifdef TARGET_NETBSD
+	  /* on NetBSD, tap (but not tun) devices are opened by
+           * opening /dev/tap and then querying the system about the
+	   * actual device name (tap0, tap1, ...) assigned
+           */
+	  if ( dynamic && strcmp( dev, "tap" ) =3D=3D 0 )
+	    {
+	      struct ifreq ifr;
+	      if ((tt->fd =3D open ( "/dev/tap", O_RDWR)) < 0)
+		{
+		  msg (M_FATAL, "Cannot allocate NetBSD TAP dev dynamically");
+		}
+	      if ( ioctl( tt->fd, TAPGIFNAME, (void*)&ifr ) < 0 )
+		{
+		  msg (M_FATAL, "Cannot query NetBSD TAP device name");
+		}
+	      CLEAR(dynamic_name);
+	      strncpy( dynamic_name, ifr.ifr_name, sizeof(dynamic_name)-1 );
+	      dynamic_opened =3D true;
+	      openvpn_snprintf (tunname, sizeof (tunname), "/dev/%s", dynamic_nam=
e );
+	    }
+	  else
+#endif
+
 	  if (dynamic && !has_digit((unsigned char *)dev))
 	    {
 	      int i;
@@ -2085,24 +2112,49 @@ open_tun (const char *dev, const char *dev_type, co=
nst char *dev_node, struct tu
         ioctl (tt->fd, TUNSLMODE, &i);   /* link layer mode off */
=20
 #ifdef NETBSD_MULTI_AF
-        i =3D 1;
-        if (ioctl (tt->fd, TUNSIFHEAD, &i) < 0) 	/* multi-af mode on */
+	if ( tt->type =3D=3D DEV_TYPE_TUN )
 	  {
-	    msg (M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD): %s", strerror(errno));
+	    i =3D 1;
+	    if (ioctl (tt->fd, TUNSIFHEAD, &i) < 0) 	/* multi-af mode on */
+	      {
+		msg (M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD): %s", strerror(errno));
+	      }
 	  }
 #endif
       }
 }
=20
+/* the current way OpenVPN handles tun devices on NetBSD leads to
+ * lingering tunX interfaces after close -> for a full cleanup, they
+ * need to be explicitely destroyed
+ */
 void
 close_tun (struct tuntap *tt)
 {
-  /* TODO: we really should cleanup non-persistant tunX with=20
-   * "ifconfig tunX destroy" here...
+  /* only tun devices need destroying, tap devices auto-self-destruct
    */
-  if (tt)
+  if (tt && tt->type !=3D DEV_TYPE_TUN )
     {
       close_tun_generic (tt);
+      free(tt);
+    }
+  else if (tt)
+    {
+      struct gc_arena gc =3D gc_new ();
+      struct argv argv;
+
+      /* setup command, close tun dev (clears tt->actual_name!), run comma=
nd
+       */
+
+      argv_init (&argv);
+      argv_printf (&argv, "%s %s destroy",
+                          IFCONFIG_PATH, tt->actual_name);
+
+      close_tun_generic (tt);
+
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, NULL, 0, "NetBSD 'destroy tun interface=
' failed (non-critical)");
+
       free (tt);
     }
 }
--=20
1.6.4


--cFU7Ny1L0ShjNgMX--

--89pfdy8kpQe6B5Nt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTnOOx6kuBuNlUUl1AQIIrgQAxVQDQglEOvcL31EJ8W7Jvi3rBztv12+c
D2/pgul1lnoIFHJWNFQZwVloUttfKpdtmtcIQiZDjIvlqfOx+yk6GePJILw6E67C
scw/dHoQtBpPs/6h44wuoWNXIQQxx71ngzYDARh0TFLJ1PzNB4FrGgfHBFrl+e2f
IOk5jFQqxlw=
=KKl9
-----END PGP SIGNATURE-----

--89pfdy8kpQe6B5Nt--

