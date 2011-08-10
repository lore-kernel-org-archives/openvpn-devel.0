Date: Wed, 10 Aug 2011 22:36:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110810203646.GC8496@...1296...>
References: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
	<1312980908-25157-3-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p3Xf9BP7cPTaiYKa"
Content-Disposition: inline
In-Reply-To: <1312980908-25157-3-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] don't use struct in6_addr s6_addr32
	member anymore
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--p3Xf9BP7cPTaiYKa
Content-Type: multipart/mixed; boundary="0RvHPfoxBV7Bhjl7"
Content-Disposition: inline

--0RvHPfoxBV7Bhjl7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 10, 2011 at 12:55:08PM +0000, Heiko Hund wrote:
> The s6_addr32 member of struct in6_addr is not available when building
> for WIN32. To work around this, a local union is defined that allows
> accessing 32 bit chunks of the IPv6 address passed to add_in6_addr().

NAK, that's massively ugly.=20=20

I've changed the code to do 8-bit rounds.  While somewhat slower, the=20
code is actually more readable that way, and since this is only called=20
once per connecting client, the few microseconds are well-spent.

My patch attached again.  David?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0RvHPfoxBV7Bhjl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Replace-32-bit-based-add_in6_addr-implementation-by-.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 1e3c114d655f65dfc3528b1d8884a026ba8bad6b Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sat, 28 May 2011 22:50:40 +0200
Subject: [PATCH] Replace 32-bit-based add_in6_addr() implementation by an 8=
-bit based one
 - windows has no 32-bit accessor to the union inside "struct in6_addr",
 and the 8-bit accessor is the only common denominator across BSD, Solaris,
 Linux and Windows...

Signed-off-by: Gert Doering <gert@...1296...>
---
 socket.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/socket.c b/socket.c
index 6b855c0..7903c26 100644
--- a/socket.c
+++ b/socket.c
@@ -2619,32 +2619,30 @@ print_in6_addr (struct in6_addr a6, unsigned int fl=
ags, struct gc_arena *gc)
   return BSTR (&out);
 }
=20
+#ifndef UINT8_MAX
+# define UINT8_MAX 0xff
+#endif
+
 /* add some offset to an ipv6 address
- * (add in steps of 32 bits, taking overflow into next round)
+ * (add in steps of 8 bits, taking overflow into next round)
  */
-#ifndef s6_addr32
-# ifdef TARGET_SOLARIS
-#  define s6_addr32 _S6_un._S6_u32
-# else
-#  define s6_addr32 __u6_addr.__u6_addr32
-# endif
-#endif
-#ifndef UINT32_MAX
-# define UINT32_MAX (4294967295U)
-#endif
 struct in6_addr add_in6_addr( struct in6_addr base, uint32_t add )
 {
     int i;
-    uint32_t h;
=20
-    for( i=3D3; i>=3D0 && add > 0 ; i-- )
+    for( i=3D15; i>=3D0 && add > 0 ; i-- )
     {
-	h =3D ntohl( base.s6_addr32[i] );
-	base.s6_addr32[i] =3D htonl( (h+add) & UINT32_MAX );
-	/* 32-bit overrun?=20
-	 * caveat: can't do "h+add > UINT32_MAX" with 32bit math!
+	register int carry;
+	register uint32_t h;
+
+	h =3D (unsigned char) base.s6_addr[i];
+	base.s6_addr[i] =3D (h+add) & UINT8_MAX;
+
+	/* using explicit carry for the 8-bit additions will catch
+         * 8-bit and(!) 32-bit overruns nicely
          */
-	add =3D ( h > UINT32_MAX - add )?  1: 0;
+	carry =3D ((h & 0xff)  + (add & 0xff)) >> 8;
+	add =3D (add>>8) + carry;
     }
     return base;
 }
--=20
1.7.3.4


--0RvHPfoxBV7Bhjl7--

--p3Xf9BP7cPTaiYKa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTkLr3qkuBuNlUUl1AQI6FQQArakKH8S6/5xCC1srma9chzviT88VrZzB
nzKEKCYI38DiwYYEm9g9nkrfUTnO8/rCdAeyxuh7MNewM02OijMMJNq5EeYzifwt
nzjGzOK8xDsuVQDohtVQjOJkVvb62ThktZXl95wfX+GaIh6ieWxY2xZZqK3oqX4a
zpqW91EumgU=
=Ht0K
-----END PGP SIGNATURE-----

--p3Xf9BP7cPTaiYKa--

