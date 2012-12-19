Date: Wed, 19 Dec 2012 22:26:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121219212619.GN22465@...1296...>
References: <20121217220355.GB23292@...1794...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="glUAVOaDCVqE0op2"
Content-Disposition: inline
In-Reply-To: <20121217220355.GB23292@...1794...>
Subject: Re: [Openvpn-devel] Fixing "passtos" on !Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jeremie Le Hen <jeremie@...1793...>
Cc: openvpn-devel@lists.sourceforge.net

--glUAVOaDCVqE0op2
Content-Type: multipart/mixed; boundary="vHvyrvsPfhEnwpQy"
Content-Disposition: inline

--vHvyrvsPfhEnwpQy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 17, 2012 at 11:03:55PM +0100, Jeremie Le Hen wrote:
> I thereby kindly ask you to bring this patch in the source tree.  I
> don't know about your release procedure, but it would be really nice if
> it could hit the tree before 2.3 is released.

Thanks for the excessive links to documentation - it helps verifying
things.  I agree that this is a useful last-minute correction and should
go in (feature-ACK).

I don't particularily like the way your patch is coded, though, as it's
"all of them but Linux" that have "int" here (except Windows, which uses
DWORD, but the docs say "use QoS API instead") - too many #ifdefs.

http://msdn.microsoft.com/en-us/library/windows/desktop/ms738586(v=3Dvs.85)=
.aspx

so I'd propose to #ifdef it differently, patch appended.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--vHvyrvsPfhEnwpQy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-parameter-type-for-IP_TOS-setsockopt-on-non-Linu.patch"
Content-Transfer-Encoding: quoted-printable

=46rom b6e0f27b4e6965de14cf0ec3e901a52d256cc88a Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Wed, 19 Dec 2012 22:12:41 +0100
Subject: [PATCH] Fix parameter type for IP_TOS setsockopt on non-Linux
 systems.

Linux uses uint8_t, all BSD based stacks and Solaris use "int"  (Windows
documentation says "DWORD" and "do not use, use QoS API instead").

Bug reported and fix provided by Torsten Vielhak and Jeremie Le Hen.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 9cb01fa..4e7e7f8 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -237,7 +237,11 @@ struct link_socket
=20
 #if PASSTOS_CAPABILITY
   /* used to get/set TOS. */
+#if defined(TARGET_LINUX)
   uint8_t ptos;
+#else /* all the BSDs, Solaris, MacOS use plain "int" -> see "man ip" ther=
e */
+  int  ptos;
+#endif
   bool ptos_defined;
 #endif
=20
--=20
1.7.8.6


--vHvyrvsPfhEnwpQy--

--glUAVOaDCVqE0op2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUNIw+6kuBuNlUUl1AQImhQP+MnqIo69IpHUvxqJKEqRATTco+Ks6pCib
bhAcQu+My9BZguOPPgWx4aZjj0bjlpUHcPHroNfhxtR74leBYl256tZ8FLG+UmM/
moTgXzlvjC0JBB2WjAJ8JW59htDiidArXS/ox0K1VIsxb8ka9KFwHbyBmzHqlwNV
WYlOf5ooFog=
=Te5E
-----END PGP SIGNATURE-----

--glUAVOaDCVqE0op2--

