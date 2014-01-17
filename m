Message-ID: <52D9722D.3040401@...1227...>
Date: Fri, 17 Jan 2014 19:10:53 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1389972638-8006-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1389972638-8006-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="uq5MKUc3TkVlrhQmRBAkf2WKksPH7gBA1"
Subject: Re: [Openvpn-devel] [PATCH] make sure sa_family_t is defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uq5MKUc3TkVlrhQmRBAkf2WKksPH7gBA1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 17.01.14 16:30, schrieb Heiko Hund:
> On Windows there's no sa_family_t. This patch defines it in
> syshead.h is configure did not find it in the system headers.

ACK.

Arne


--uq5MKUc3TkVlrhQmRBAkf2WKksPH7gBA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLZcjQACgkQe8+cMNS4zRcGQgCcCMXFmn9LdcCApVfi+K54iVtC
qz8AmQGoB/sv37mbQcv/Q44rTUPIHZNS
=WtMr
-----END PGP SIGNATURE-----

--uq5MKUc3TkVlrhQmRBAkf2WKksPH7gBA1--

