Message-ID: <4F4610F1.7020002@...1114...>
Date: Thu, 23 Feb 2012 11:12:01 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F438CF2.1060305@...515...> <4F4601A5.3080203@...1549...>
In-Reply-To: <4F4601A5.3080203@...1549...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0F9CF192E3C438D1DCA69870"
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 preview 1
 installer now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0F9CF192E3C438D1DCA69870
Content-Type: multipart/mixed; boundary="------------070001050200030609070008"

This is a multi-part message in MIME format.
--------------070001050200030609070008
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 23/02/12 10:06, Freek Dijkstra wrote:
> Reporting that
> http://build.openvpn.net/downloads/releases/openvpn-2.3-alpha1.tar.gz
> compiles and runs fine for me.
>=20
[...snip...]
> My recommendation is to:
>=20
> 1. Remove the "NOTE: explicit support for IPv6 tun devices is not
> provided for this OS"

Please try the attached patch and see if this works better.  I've flipped
the flag about explicit IPv6 support for OSX/Darwin.  Your tests obviously
shows the support is present.

> 2. If possible, add a message about the cause to the "Cannot allocate
> TUN/TAP dev dynamically" message (e.g. "permission denied" or "no tun
> interface available" ,...)

For now, in the patch, I've just added a bit more helpful hint.

We probably could do some more checks to give a more exact error.  But as
this is highly platform specific, I didn't dare touching the OSX code more
as I don't have access to that platform at all.


kind regards,

David Sommerseth

--------------070001050200030609070008
Content-Type: text/x-patch;
	name="0001-Fix-errornous-IPv6-warning-for-OSX-and-enhance-TUN-T.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename*0="0001-Fix-errornous-IPv6-warning-for-OSX-and-enhance-TUN-T.pa";
	filename*1="tch"

=46rom a01f6ff9fb8901048cd9aacdd665affef082084a Mon Sep 17 00:00:00 2001
From: David Sommerseth <davids@...1347...>
Date: Thu, 23 Feb 2012 10:43:04 +0100
Subject: [PATCH] Fix errornous IPv6 warning for OSX and enhance TUN/TAP
 allocation error

OSX/Darwin supports IPv6 in its TUN/TAP driver.  Flipped the flag indicat=
ing
this support.

Further if the TUN/TAP driver in the OS is not loaded, the allocation of =
TUN/TAP
devices will fail.  And when using dynamic allocation (when configuring t=
un
instead of tun0), OpenVPN will exit saying "dynamic allocation failed".  =
Rather
be helpful and give a hint why this might have failed.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 tun.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tun.c b/tun.c
index c92c0d7..55f894a 100644
--- a/tun.c
+++ b/tun.c
@@ -1321,7 +1321,7 @@ open_tun_generic (const char *dev, const char *dev_=
type, const char *dev_node,
 		  msg (D_READ_WRITE | M_ERRNO, "Tried opening %s (failed)", tunname);
 		}
 	      if (!dynamic_opened)
-		msg (M_FATAL, "Cannot allocate TUN/TAP dev dynamically");
+		msg (M_FATAL, "Cannot allocate TUN/TAP dev dynamically.  Is the TUN/TA=
P driver loaded?");
 	    }
 	  /*
 	   * explicit unit number specified
@@ -2451,7 +2451,7 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)=

 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, s=
truct tuntap *tt)
 {
-  open_tun_generic (dev, dev_type, dev_node, false, true, tt);
+  open_tun_generic (dev, dev_type, dev_node, true, true, tt);
 }
=20
 void
--=20
1.7.4.4


--------------070001050200030609070008--

--------------enig0F9CF192E3C438D1DCA69870
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9GEPMACgkQDC186MBRfrrLOACeK/Bu51eAXFLe8ufucj1bCFZS
HdgAnjsuQY3pTS4xYaghebwt+gm1F+Vh
=+1Gu
-----END PGP SIGNATURE-----

--------------enig0F9CF192E3C438D1DCA69870--

