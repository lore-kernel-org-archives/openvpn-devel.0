Message-ID: <4881A969.1080505@...1085...>
Date: Sat, 19 Jul 2008 03:44:25 -0500
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
References: <alpine.LNX.1.10.0807190603560.21295@...1117...>
	<48818309.30109@...1085...>
In-Reply-To: <48818309.30109@...1085...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig40822082CB485D30965C3088"
Subject: Re: [Openvpn-devel] [patch] Assertion failed at lzo.c:165
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
--------------enig40822082CB485D30965C3088
Content-Type: multipart/mixed; boundary="------------030309030609090407050305"

This is a multi-part message in MIME format.
--------------030309030609090407050305
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Josh Cepek wrote:
> Assuming I have read the source correctly, it seems to me that the=20
> packet could be dropped (probably with an associated error to the log)=20
> rather than using an ASSERT() call.  This way malformed data from=20
> internal clients behind a VPN peer won't bring down the VPN.

I've attached a patch that does this.  It compiles & runs fine for me=20
and the logging appears to work as expected (I tested this by reversing=20
the conditional test since I don't have the problem originally reported.)

I'm not completely sure on the correctness of the process to empty the=20
buffer to ignore the packet, but from the other code in this function I=20
believe what I've added will simply cause the bad packet to be ignored.=20
  Feel free to change if necessary.

--=20
Josh

--------------030309030609090407050305
Content-Type: text/plain; charset="utf-8"; name=openvpn-lzo-buffer.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="openvpn-lzo-buffer.patch"

--- /home/josh/src/openvpn/openvpn-2.1_rc7/lzo.c	2008-01-23 21:08:41.000000=
000 +0000
+++ /home/josh/temp/lzo.c.new	2008-07-19 08:32:50.000000000 +0000
@@ -162,7 +162,12 @@
     {
       ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
       ASSERT (buf_safe (&work, LZO_EXTRA_BUFFER (PAYLOAD_SIZE (frame))));
-      ASSERT (buf->len <=3D PAYLOAD_SIZE (frame));
+      if (buf->len > PAYLOAD_SIZE (frame))
+	{
+	  dmsg (D_COMP_ERRORS, "LZO compression failed: buffer exceeds allowable =
payload length");
+	  buf->len =3D 0;
+	  return;
+	}
=20
       err =3D LZO_COMPRESS (BPTR (buf), BLEN (buf), BPTR (&work), &zlen, l=
zowork->wmem);
       if (err !=3D LZO_E_OK)

--------------030309030609090407050305--

--------------enig40822082CB485D30965C3088
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkiBqW8ACgkQHSSgJy5aUSf6qgCgiqIkHjtedAYyckBBHS8/cFbC
BFYAn0KceGId0YJAr44DD+GtN21EXd+G
=Soqo
-----END PGP SIGNATURE-----

--------------enig40822082CB485D30965C3088--


