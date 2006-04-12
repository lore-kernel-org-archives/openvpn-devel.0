Message-ID: <443D0C85.4050307@...411...>
From: Giancarlo Razzolini <linux-fan@...411...>
Reply-To: linux-fan@...411...
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enigBE98C94AFD36748F0D724EEA"
Subject: [Openvpn-devel] Openvpn plugin for passwd or shadow authentication
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Apr 12 07:21:09 2006
To: openvpn-users <openvpn-users@lists.sourceforge.net>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBE98C94AFD36748F0D724EEA
Content-Type: multipart/mixed;
 boundary="------------000201070302070301080800"

This is a multi-part message in MIME format.
--------------000201070302070301080800
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

	Hi folks,

	I had a need to do authentication using the shadow suite rather than
using PAM, because the system were i was using it, didn't supported
PAM. I then wrote a small C program that made authentication using the
shadow suite, and used it as the --auth-user-pass-verify argument. But i
didn't liked this setup because i had to run openvpn as root, and
couldn't drop the privileges anymore, losing some of it's security.

	I then wrote this plugin, that is heavily based on the auth-pam and
down-root plugins, to do either shadow or passwd authentication. Some
systems, as the majority of the BSD systems, uses a wrapper to the old
function that does the authentication, the getpwnam(3), so the plugin
authenticate using it. In other systems (the majority of linux
distributions and AFAIK sun), the shadow suite is used, with the
function getspnam(3). As there isn't an easy way to check if the system
uses passwd or shadow authentication, it must be defined as a compiler
directive in the Makefile.

	Right know i tested it in a Slackware 10.2 box, in OpenBSD 3.8 and in a
red-hat based distro, called Conectiva 10.0. It's here for you to test
it and, whether it works or not, please send some reports.

	The file must be decompressed under the openvpn-2.0.X directory, it
will then create a directory under the plugin, called auth-passwd. Read
the README and alter the Makefile to suit your needs.

Thanks in advance,
--=20
Giancarlo Razzolini
Linux User 172199
Moleque Sem Conteudo Numero #002
Slackware Current
OpenBSD Stable
Snike Tecnologia em Inform=E1tica
4386 2A6F FFD4 4D5F 5842  6EA0 7ABE BBAB 9C0E 6B85

--------------000201070302070301080800
Content-Type: file;
 name="auth-passwd.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="auth-passwd.tar.gz"

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
--------------000201070302070301080800
Content-Type: text/plain; charset="utf-8"; name=auth-passwd.tar.gz.md5
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="auth-passwd.tar.gz.md5"

aa90d098d4300d45c4e78929e1de6859  auth-passwd.tar.gz

--------------000201070302070301080800--

--------------enigBE98C94AFD36748F0D724EEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFEPQyKer67q5wOa4URA5tNAKCf0CKkKhQmzQ2M7WS8qmaGBp2MXgCeIK/b
7dR+qG0RQ3H8DuCY2DuGIuY=
=J8G+
-----END PGP SIGNATURE-----

--------------enigBE98C94AFD36748F0D724EEA--

