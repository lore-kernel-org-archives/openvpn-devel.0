Date: Wed, 15 Aug 2012 12:53:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120815105339.GG18296@...1296...>
References: <20120814194736.GU2535@...1296...>
	<20120815100012.GD18296@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <20120815100012.GD18296@...1296...>
Subject: Re: [Openvpn-devel] RFC: tun/tap cleanup at program end
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--f+W+jCU1fRNres8c
Content-Type: multipart/mixed; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 15, 2012 at 12:00:12PM +0200, Gert Doering wrote:
>   3 - check for the existance of "--dev tap3" and remember, not cleaning
>       if it existed previously, doing this with RT_NETLINK which should
>       be sufficiently portable across all BSDs.  Same advantage as "2",
>       hopefully much nicer implementation.

Here we go.  I discovered if_nametoindex(), which is really handy for
this :-)

Eric, please test whether this solves your issues.

David, please do *not yet* commit, even if someone ACKs - I need to test
this on OpenBSD, NetBSD and FreeBSD 9 as well.  So far, only tested on=20
FreeBSD 7.4 (and works).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Keep-pre-existing-tun-tap-devices-around-on-BSD.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 57c8532499a487f41ecabbcf9cb23c64ac82f32d Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Wed, 15 Aug 2012 13:51:30 +0300
Subject: [PATCH] Keep pre-existing tun/tap devices around on *BSD

This amends commit 62c613d46dc49 to check whether a named tun/tap
device ("--dev tunX" instead of "--dev tun") exists before OpenVPN
started - if yes, keep around at program end.  If no, destroy.

Tested on FreeBSD 7.4.

Also has a spelling fix, and change clear_tuntap() to be "static"
(only ever called from within tun.c).

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c |   22 +++++++++++++++++-----
 src/openvpn/tun.h |    4 +++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 6218b73..ed67261 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -890,7 +890,7 @@ do_ifconfig (struct tuntap *tt,
 #elif defined(TARGET_OPENBSD)
=20
       /*
-       * On OpenBSD, tun interfaces are persistant if created with
+       * On OpenBSD, tun interfaces are persistent if created with
        * "ifconfig tunX create", and auto-destroyed if created by
        * opening "/dev/tunX" (so we just use the /dev/tunX)
        */
@@ -1235,7 +1235,7 @@ do_ifconfig (struct tuntap *tt,
   gc_free (&gc);
 }
=20
-void
+static void
 clear_tuntap (struct tuntap *tuntap)
 {
   CLEAR (*tuntap);
@@ -1344,6 +1344,13 @@ open_tun_generic (const char *dev, const char *dev_t=
ype, const char *dev_node,
=20
       if (!dynamic_opened)
 	{
+  	  /* has named device existed before? if so, don't destroy at end */
+	  if ( if_nametoindex( dev ) > 0 )
+	    {
+	      msg (M_INFO, "TUN/TAP device %s exists previously, keep at program =
end", dev );
+	      tt->persistent_if =3D true;
+	    }
+
 	  if ((tt->fd =3D open (tunname, O_RDWR)) < 0)
 	    msg (M_ERR, "Cannot open TUN/TAP dev %s", tunname);
 	}
@@ -2030,7 +2037,7 @@ close_tun (struct tuntap* tt)
 {
   /* only *TAP* devices need destroying, tun devices auto-self-destruct
    */
-  if (tt && tt->type =3D=3D DEV_TYPE_TUN )
+  if (tt && (tt->type =3D=3D DEV_TYPE_TUN || tt->persistent_if ) )
     {
       close_tun_generic (tt);
       free(tt);
@@ -2165,7 +2172,7 @@ close_tun (struct tuntap *tt)
 {
   /* only tun devices need destroying, tap devices auto-self-destruct
    */
-  if (tt && tt->type !=3D DEV_TYPE_TUN )
+  if (tt && ( tt->type !=3D DEV_TYPE_TUN || tt->persistent_if ) )
     {
       close_tun_generic (tt);
       free(tt);
@@ -2303,7 +2310,12 @@ open_tun (const char *dev, const char *dev_type, con=
st char *dev_node, struct tu
 void
 close_tun (struct tuntap *tt)
 {
-  if (tt)
+  if (tt && tt->persistent_if )		/* keep pre-existing if around */
+    {
+      close_tun_generic (tt);
+      free (tt);
+    }
+  else if (tt)				/* close and destroy */
     {
       struct gc_arena gc =3D gc_new ();
       struct argv argv;
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 9bd990f..8622bf8 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -137,6 +137,8 @@ struct tuntap
=20
   bool ipv6;
=20
+  bool persistent_if;		/* if existed before, keep on program end */
+
   struct tuntap_options options; /* options set on command line */
=20
   char *actual_name; /* actual name of TUN/TAP dev, usually including unit=
 number */
@@ -201,7 +203,7 @@ tuntap_defined (const struct tuntap *tt)
  * Function prototypes
  */
=20
-void clear_tuntap (struct tuntap *tuntap);
+static void clear_tuntap (struct tuntap *tuntap);
=20
 void open_tun (const char *dev, const char *dev_type, const char *dev_node,
 	       struct tuntap *tt);
--=20
1.7.3.5


--H+4ONPRPur6+Ovig--

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUCt/s6kuBuNlUUl1AQJqjAP/W2nmW1QFLcSNFRRMhPkPv7liMcB/vxtU
WCJy0f24Y+kObcJStnhmkTjqw5hyUa0sx6OxgLJU2QoDzuB/yyQqvDWzh7gYJYHM
tjBZ+94D5W6IzHIm/9AjIdWSUnqsXmxmZGgPYQ+1Zm34IlS8iuMQhKpEEx0a1GPf
HepWoUHvdlY=
=rntb
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--

