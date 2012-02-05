Date: Sun, 5 Feb 2012 16:48:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120205154846.GB13929@...1296...>
References: <20120205131601.GA26602@...1296...>
	<4F2E8C00.6090909@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p/1JFEOz/hVXxMAZ"
Content-Disposition: inline
In-Reply-To: <4F2E8C00.6090909@...384...>
Subject: Re: [Openvpn-devel] OpenBSD platform cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--p/1JFEOz/hVXxMAZ
Content-Type: multipart/mixed; boundary="BtmVPk+Smchi6n7w"
Content-Disposition: inline

--BtmVPk+Smchi6n7w
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 05, 2012 at 03:02:40PM +0100, David Sommerseth wrote:
> >as promised :-) - it now passes all my t_client.rc tests, and smells
> >a lot less funny.  We now might even throw out all these weird
> >#ifdefs from tun.h...
>=20
> Maybe an attachment would be nice? ;-)

And I thought you could just fetch this from the git repo on my laptop
(suspended to disk and turned off, of course!).  Well, that's what you
get when debugging assert() crashes instead concentrating on your
e-mail :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BtmVPk+Smchi6n7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Platform-cleanup-for-OpenBSD.patch"
Content-Transfer-Encoding: quoted-printable

=46rom df533746e6bf6b66020b6da4720b20e26878aedf Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1542...>
Date: Sun, 5 Feb 2012 13:35:03 +0100
Subject: [PATCH] Platform cleanup for OpenBSD

Turn around initialization order (IFCONFIG_AFTER_TUN_OPEN) to make it
"the same as all other platforms besides Windows" (tun.h).

Remove "ifconfig destroy / ifconfig create" from open_tun() and change
to generic "create tun device by opening /dev/tunN" approach, thus
cleaning up the IFCONFIG_BEFORE_TUN_OPEN bit.

Add "-link0" for ifconfig calls in tun mode, to make sure that even if
we happen to re-use a not-cleaned-up tun interface in tap mode, it will
then be setup correctly (-link0 -> tun, link0 -> tap).

Add correct ifconfig calls for "topology subnet".

On tunnel close, only call "ifconfig destroy" if it was a tap interface
(tun + link0), because those do not auto-disappear (OpenBSD bug?)

Get rid of READV/WRITEV #ifdef's - as per the man page, these calls have
been added to 4.2BSD, and there never was an OpenBSD version without.

Tested on OpenBSD 4.9 with tun+tap, ipv4+ipv6, topology net30+subnet

Signed-off-by: Gert Doering <gert@...1296...>
---
 tun.c |   60 +++++++++++++++++++++++++++++++++---------------------------
 tun.h |    2 +-
 2 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/tun.c b/tun.c
index 1527ac8..1a4a16f 100644
--- a/tun.c
+++ b/tun.c
@@ -880,29 +880,15 @@ do_ifconfig (struct tuntap *tt,
 #elif defined(TARGET_OPENBSD)
=20
       /*
-       * OpenBSD tun devices appear to be persistent by default.  It seems=
 in order
-       * to make this work correctly, we need to delete the previous insta=
nce
-       * (if it exists), and re-ifconfig.  Let me know if you know a bette=
r way.
+       * On OpenBSD, tun interfaces are persistant if created with
+       * "ifconfig tunX create", and auto-destroyed if created by=20
+       * opening "/dev/tunX" (so we just use the /dev/tunX)
        */
=20
-      argv_printf (&argv,
-			"%s %s destroy",
-			IFCONFIG_PATH,
-			actual);
-      argv_msg (M_INFO, &argv);
-      openvpn_execve_check (&argv, es, 0, NULL);
-      argv_printf (&argv,
-			"%s %s create",
-			IFCONFIG_PATH,
-			actual);
-      argv_msg (M_INFO, &argv);
-      openvpn_execve_check (&argv, es, 0, NULL);
-      msg (M_INFO, "NOTE: Tried to delete pre-existing tun/tap instance --=
 No Problem if failure");
-
       /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255=
.255.255 up */
       if (tun)
 	argv_printf (&argv,
-			  "%s %s %s %s mtu %d netmask 255.255.255.255 up",
+			  "%s %s %s %s mtu %d netmask 255.255.255.255 up -link0",
 			  IFCONFIG_PATH,
 			  actual,
 			  ifconfig_local,
@@ -910,6 +896,19 @@ do_ifconfig (struct tuntap *tt,
 			  tun_mtu
 			  );
       else
+	if ( tt->topology =3D=3D TOP_SUBNET )
+	{
+	    argv_printf (&argv,
+			  "%s %s %s %s mtu %d netmask %s up -link0",
+			  IFCONFIG_PATH,
+			  actual,
+			  ifconfig_local,
+			  ifconfig_local,
+			  tun_mtu,
+			  ifconfig_remote_netmask
+			  );
+	}
+      else
 	argv_printf (&argv,
 			  "%s %s %s netmask %s mtu %d broadcast %s link0",
 			  IFCONFIG_PATH,
@@ -1959,10 +1958,6 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
=20
 #elif defined(TARGET_OPENBSD)
=20
-#if !defined(HAVE_READV) || !defined(HAVE_WRITEV)
-#error openbsd build requires readv & writev library functions
-#endif
-
 /*
  * OpenBSD has a slightly incompatible TUN device from
  * the rest of the world, in that it prepends a
@@ -2006,15 +2001,26 @@ open_tun (const char *dev, const char *dev_type, co=
nst char *dev_node, struct tu
     }
 }
=20
-/* the current way OpenVPN handles tun devices on OpenBSD leads to
- * lingering tunX interfaces after close -> for a full cleanup, they
- * need to be explicitely destroyed
+/* tun(4): "If the device was created by opening /dev/tunN, it will be
+ *          automatically destroyed.  Devices created via ifconfig(8) are
+ *          only marked as not running and traffic will be dropped
+ *          returning EHOSTDOWN."
+ * --> no special handling should be needed - *but* OpenBSD is misbehaving
+ * here: if the interface was put in tap mode ("ifconfig tunN link0"), it
+ * *will* stay around, and needs to be cleaned up manually
  */
-
+=20
 void
 close_tun (struct tuntap* tt)
 {
-  if (tt)
+  /* only *TAP* devices need destroying, tun devices auto-self-destruct
+   */
+  if (tt && tt->type =3D=3D DEV_TYPE_TUN )
+    {
+      close_tun_generic (tt);
+      free(tt);
+    }
+  else if (tt)
     {
       struct gc_arena gc =3D gc_new ();
       struct argv argv;
diff --git a/tun.h b/tun.h
index c0785dd..513257f 100644
--- a/tun.h
+++ b/tun.h
@@ -283,7 +283,7 @@ ifconfig_order(void)
 #elif defined(TARGET_SOLARIS)
   return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(TARGET_OPENBSD)
-  return IFCONFIG_BEFORE_TUN_OPEN;
+  return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(TARGET_DARWIN)
   return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(TARGET_NETBSD)
--=20
1.7.3.5


--BtmVPk+Smchi6n7w--

--p/1JFEOz/hVXxMAZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTy6k3qkuBuNlUUl1AQI4YAP/dlfGXk7eozOsYRq5BKX9hM415PeMuhhE
9UeYUeGmu+5HOkckuKoBTtSExryaPCyaXS6I5vu7ZMiVHPyBWvpca0QJqXz8KoIS
qR+joVgjd8ED2aBIQcNdFGjP6WSbh4ME8/jzE4b0uKVAPMSlOyoCVNOVJfWBckBN
ILaiDlmJAVE=
=RkJi
-----END PGP SIGNATURE-----

--p/1JFEOz/hVXxMAZ--

