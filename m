From: Teemu Kiviniemi <teemuki@...124...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ymOKomiS4BYxHPlKmOfC"
Message-Id: <1067263967.14300.265.camel@...125...>
Mime-Version: 1.0
Subject: [Openvpn-devel] a replacement for --tls-remote and verify-cn
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Oct 27 06:18:08 2003
To: openvpn-devel@lists.sourceforge.net

--=-ymOKomiS4BYxHPlKmOfC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I ran into problems in using --tls-verify to verify the remote host with
--chroot enabled. --tls-verify runs the verify script with system()
command, so it assumes that /bin/sh is available. Usually, in a chroot
environment, that's not true.

I implemented a new config option: --tls-remote x509name

With --tls-remote the remote host is verified by looking at the X509
name. If the remote X509 name doesn't match the given x509name, the
remote host is rejected.

With --tls-remote, it's possible to verify remote host even with a
completely empty chroot directory. --tls-remote also removes the need
for an external --tls-verify script in most cases.

Config example:
tls-remote /O=3Dexampleorg/CN=3Dname

I have tested the patch with a TLS tunnel on Debian Woody.

A patch against OpenVPN 1.5 beta12 is available at:
http://iki.fi/teemuki/openvpn/1.5_beta12-tlsremote.diff

Feel free to use it. :)

Teemu


--=-ymOKomiS4BYxHPlKmOfC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/nSfeq0EylM9fq6oRAuxYAKCAWHtXnpRMt1pa8BtrKJ9Vww1mlgCeK35S
KsfSBIR/3gXJAZj+o5nlZi0=
=ntqL
-----END PGP SIGNATURE-----

--=-ymOKomiS4BYxHPlKmOfC--



