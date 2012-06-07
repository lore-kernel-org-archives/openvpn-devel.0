Date: Thu, 7 Jun 2012 19:46:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120607174638.GW1059@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GBDnBH7+ZvLx8QD4"
Content-Disposition: inline
Subject: [Openvpn-devel] implement dynamic search for first-free tun/tap on
	Solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--GBDnBH7+ZvLx8QD4
Content-Type: multipart/mixed; boundary="kjpMrWxdCilgNbo1"
Content-Disposition: inline

--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Solaris buildslave failed to test, because "--dev tun" did not work
if tun0 was already in use (didn't hunt to tun1).

Fixed, tested on OpenSolaris 10 / i386 - but the code is straightforward,=20
so it should work on "standard Solaris" and "sparc" as well.  Managed to
get it to hunt to tun2 just fine, and then ran out of possible OpenVPN
targets :-) but if it works for tun0, tun1, tun2 there is no reason why
it shouldn't work for tun63.=20

The moving around of the open() calls is purely cosmetic - I wanted to
have all code that relates to tun device unit number in one block, not
"first parse device name, then open unrelated stuff, then try to use
that just-parsed device and the resulting 'ptr' variable".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-Implement-search-for-first-free-tun-tap-device-on.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 606e5c98ba25381b8396eb8a12d923af55ed6385 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Thu, 7 Jun 2012 17:38:17 +0200
Subject: [PATCH] Implement search for "first free" tun/tap device on Solaris

Without this patch, Solaris will do "--dev tun3" just fine, but "--dev tun"
will either use "tun0" if that is available, or fail.  With the patch, the
first available device is searched if "--dev tun" or "--dev tap" (without
a number) is specified.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c |   40 ++++++++++++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 633150f..c9edbb8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1711,6 +1711,12 @@ open_tun (const char *dev, const char *dev_type, con=
st char *dev_node, struct tu
       msg (M_FATAL, "I don't recognize device %s as a tun or tap device",
 	   dev);
     }
+
+  if ((tt->ip_fd =3D open (ip_node, O_RDWR, 0)) < 0)
+    msg (M_ERR, "Can't open %s", ip_node);
+
+  if ((tt->fd =3D open (dev_node, O_RDWR, 0)) < 0)
+    msg (M_ERR, "Can't open %s", dev_node);
  =20
   /* get unit number */
   if (*dev)
@@ -1721,19 +1727,37 @@ open_tun (const char *dev, const char *dev_type, co=
nst char *dev_node, struct tu
       ppa =3D atoi (ptr);
     }
=20
-  if ((tt->ip_fd =3D open (ip_node, O_RDWR, 0)) < 0)
-    msg (M_ERR, "Can't open %s", ip_node);
-
-  if ((tt->fd =3D open (dev_node, O_RDWR, 0)) < 0)
-    msg (M_ERR, "Can't open %s", dev_node);
-
   /* Assign a new PPA and get its unit number. */
   strioc_ppa.ic_cmd =3D TUNNEWPPA;
   strioc_ppa.ic_timout =3D 0;
   strioc_ppa.ic_len =3D sizeof(ppa);
   strioc_ppa.ic_dp =3D (char *)&ppa;
-  if ((ppa =3D ioctl (tt->fd, I_STR, &strioc_ppa)) < 0)
-    msg (M_ERR, "Can't assign new interface");
+
+  if ( *ptr =3D=3D '\0' )		/* no number given, try dynamic */
+    {
+      bool found_one =3D false;
+      while( ! found_one && ppa < 64 )
+	{
+	  int new_ppa =3D ioctl (tt->fd, I_STR, &strioc_ppa);
+	  if ( new_ppa >=3D 0 )
+	    {
+	      msg( M_INFO, "open_tun: got dynamic interface '%s%d'", dev_tuntap_t=
ype, new_ppa );
+	      ppa =3D new_ppa;
+	      found_one =3D true;
+	      break;
+	    }
+	  if ( errno !=3D EEXIST )
+	    msg (M_ERR, "open_tun: unexpected error trying to find free %s interf=
ace", dev_tuntap_type );
+	  ppa++;
+	}
+      if ( !found_one )
+	msg (M_ERR, "open_tun: could not find free %s interface, give up.", dev_t=
untap_type );
+    }
+  else				/* try this particular one */
+    {
+      if ((ppa =3D ioctl (tt->fd, I_STR, &strioc_ppa)) < 0)
+        msg (M_ERR, "Can't assign PPA for new interface (%s%d)", dev_tunta=
p_type, ppa );
+    }
=20
   if ((if_fd =3D open (dev_node, O_RDWR, 0)) < 0)
     msg (M_ERR, "Can't open %s (2)", dev_node);
--=20
1.5.6.5


--kjpMrWxdCilgNbo1--

--GBDnBH7+ZvLx8QD4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT9Do/qkuBuNlUUl1AQI2uQP+Jf+dbfrDoHACAwTMbpcnFEf2L4TgY32A
eh5Ornb2r+umH9SQ0FAmvoXY9kg39H/gf5+Ep2FPar+dwq6DaiizDSb7oXNf/ZEN
OOIMyEj9OvchyrUBC/iXd/ndWG6n58msmN8xkdHD5LbdI47bd4MuMWF3evE5Y5+h
Gy2xqwHmTBI=
=k/aJ
-----END PGP SIGNATURE-----

--GBDnBH7+ZvLx8QD4--

