Message-ID: <546BCC47.5010205@...68...>
Date: Tue, 18 Nov 2014 23:46:31 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="BrTBrIdmLSPiDwJ480C4nDfGuL3BukFs3"
Subject: [Openvpn-devel] AES-NI trouble, and patch - please review/comment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?B?RXJtYWwgTHXDp2k=?= <eri@...2002...>, Renato Botelho <garga@...1249...>, Chris Buechler <cmb@...2002...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BrTBrIdmLSPiDwJ480C4nDfGuL3BukFs3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

I received a bug report against the FreeBSD OpenVPN port, but before
applying a patch (by Ermal Lu=C3=A7i) I do not currently oversee, I would
like your input.

https://redmine.pfsense.org/issues/3966			 original
https://community.openvpn.net/openvpn/ticket/480	 copy
https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D195004 downstream

Is this a safe fix, or will it break other features or requirements, in
the lights of restarts after timeouts, and all that?

Thanks.

Cheers,
Matthias


--BrTBrIdmLSPiDwJ480C4nDfGuL3BukFs3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlRrzEwACgkQvmGDOQUufZUKcACdHU2wmUHbJjpPAs8LSPxnO72r
SDIAn3nnxwiF2q06ZD3Wc5IHslu4QP+T
=zeZp
-----END PGP SIGNATURE-----

--BrTBrIdmLSPiDwJ480C4nDfGuL3BukFs3--

