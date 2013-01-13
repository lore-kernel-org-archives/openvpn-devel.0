Message-ID: <50F33457.9080804@...68...>
Date: Sun, 13 Jan 2013 23:25:27 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD3D1A7FEA93F008EA1EF1B45"
Subject: [Openvpn-devel] easy-rsa status?
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
--------------enigD3D1A7FEA93F008EA1EF1B45
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Greetings,

I have just added the easy-rsa package to the FreeBSD ports collection,
security/easy-rsa, and security/openvpn is now optionally (default: yes)
depending on security/easy-rsa so people get this, as they did with 2.2.2.

However, I found it hard to collect together the few scattered pieces or
easy-rsa (a tiny bit in the Wiki, in Github, and one tarball in the
download directories) and it appears that it is not entirely consistent
in itself with versioning (file name of the .tar.gz versus files inside
the tarball), missing howto documentation -- so that might look a bit
scary to end users.

Is any work underway to get this nicely arranged in one place in the
Trac wiki, or elsewhere, and make it a first-class subproject?

Thanks & best regards
Matthias


--------------enigD3D1A7FEA93F008EA1EF1B45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDzNFcACgkQvmGDOQUufZXV7gCgxux1fijI9ObRf/caeGTtQ//g
YCEAnjgcAIaqzefCu3qzjG9waAuT9Aau
=i53T
-----END PGP SIGNATURE-----

--------------enigD3D1A7FEA93F008EA1EF1B45--

