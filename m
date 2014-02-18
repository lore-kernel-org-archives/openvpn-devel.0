Message-ID: <5303A63D.4030200@...1227...>
Date: Tue, 18 Feb 2014 19:28:13 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1391000624-15092-1-git-send-email-heiko.hund@...1489...>
	<1392746395-19246-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1392746395-19246-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="NwMTfVkmCv3XNO3e7aC0xKFhTp75P4P3q"
Subject: Re: [Openvpn-devel] [PATCHv2] grow route lists dynamically
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
--NwMTfVkmCv3XNO3e7aC0xKFhTp75P4P3q
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 18.02.14 18:59, schrieb Heiko Hund:
> This removes the need for the --max-routes option. Instead of
> allocating a fixed size array for the route(-option)s they are
> managed in linked lists instead.
>
ACK.

Arne


--NwMTfVkmCv3XNO3e7aC0xKFhTp75P4P3q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMDpkMACgkQe8+cMNS4zRe8XACeMDfXmfYCqlHvYGThTlIBsgXH
wQwAn3QBQtBhSZbX5zcV4wyDQ9nT0mXd
=lAec
-----END PGP SIGNATURE-----

--NwMTfVkmCv3XNO3e7aC0xKFhTp75P4P3q--

