From: Teemu Kiviniemi <teemuki@...124...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-4VxgLhZs8RXdHo7bOpAT"
Message-Id: <1067328520.7131.321.camel@...125...>
Mime-Version: 1.0
Subject: [Openvpn-devel] --tls-cipher documentation bug
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
Date: Tue Oct 28 00:10:05 2003
To: openvpn-devel@lists.sourceforge.net

--=-4VxgLhZs8RXdHo7bOpAT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I think I found a bug in the openvpn(8) man page:

> --tls-cipher l
>     A  list  l  of allowable TLS ciphers separated by |

When I use the character '|' to separate the ciphers, OpenSSL complains.
The correct format is described in the ciphers(1) man page:

> CIPHER LIST FORMAT
> The cipher list consists of one or more cipher strings separated
> by colons.  Commas or spaces are also acceptable separators but colons
> are normally used.

I changed '|' to be ':'. The patch is available at:
http://iki.fi/teemuki/openvpn/cvs-docfix.diff

The patch is against EXP15 CVS branch with my cvs-tlsremote.diff merged.
The patch changes also the help text in options.c.

Teemu


--=-4VxgLhZs8RXdHo7bOpAT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/niQHq0EylM9fq6oRAhOsAJ0cB6aL//Lb8lwcviOG6L0lLpjn2ACfYMDo
T+uec28rNj/8dGullisiu2w=
=w/5G
-----END PGP SIGNATURE-----

--=-4VxgLhZs8RXdHo7bOpAT--


