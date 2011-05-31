Date: Tue, 31 May 2011 15:24:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110531132435.GZ8496@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EU5xizdSiRFq8q2U"
Content-Disposition: inline
Subject: [Openvpn-devel] Patch for socket.c / add_in6_addr() on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--EU5xizdSiRFq8q2U
Content-Type: multipart/mixed; boundary="C+utvyBJx29cZheI"
Content-Disposition: inline

--C+utvyBJx29cZheI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

attached you'll find another patch that is needed to make OpenVPN compile
on Windows.  After quite some consideration I have decided to change
the implementation for all platforms, as doing this with #ifdef WIN32
would be messy at best.

What the function in question does is "add a 32 bit offset to an IPv6
address" - needed for server IP address calculation and for client pool
assignment.  The old implementation did so in rounds of 32 bit, but the
windows declaration of "struct in6_addr" has no 32bit-accessor in the
underlying union...  windows has 8 and 16 bit, solaris has 8 and 32 bit,
etc., so the only thing available everywhere is "8 bit".

The addition stuff is a bit tricky as you need to be able to handle=20
overflows (what's 0x2 + 0xffffffff in 32bit-math?) - but I've actually
tested this for the relevant overflow candidates on Linux/i386 and
NetBSD/Sparc64 (different word size, different endianness), and also ran=20
random additions on 3 different implementations and compared the results=20
(same!).  So I'm sure it works :-)

The new function takes about 1.5-1.8x more time, that is, 70usec vs. 40usec
on my Atom 330 - and it's only called once per client connect on the
server.  I'm willing to accept the slowness here to make the code easier
to read, and more portable.

Samuli has confirmed that it fixes this particular compilation problem
on Windows :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--C+utvyBJx29cZheI
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


--C+utvyBJx29cZheI--

--EU5xizdSiRFq8q2U
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTeTsE6kuBuNlUUl1AQIVdwP9ESU74RCGNUm0IQMLKcicUaz5dRD5rn10
cw8zezOGZ75Y37+wo5dlAWcLDErM+K88miB7LWDJFFnNEtyyh7MGYonqqW++vNc5
KSULneRXd8c0nVX4AaG2vGTVgf0T8ROHuVwAlCcxPynRgXPF/qcTJOmQ5cYbRuik
63i+7bdIg4U=
=nb6P
-----END PGP SIGNATURE-----

--EU5xizdSiRFq8q2U--

