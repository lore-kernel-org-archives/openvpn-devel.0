Message-ID: <535790BE.40407@...1227...>
Date: Wed, 23 Apr 2014 12:06:54 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1393370880-28553-1-git-send-email-steffan@...1856...>
	<1393370880-28553-2-git-send-email-steffan@...1856...>
In-Reply-To: <1393370880-28553-2-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Me84OF0bj2f5n0x3FRI1tLlSHkkqMWPjk"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Add support for elliptic curve
 diffie-hellmann key exchange (ECDH)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Me84OF0bj2f5n0x3FRI1tLlSHkkqMWPjk
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 26.02.14 00:27, schrieb Steffan Karger:
> This patch is based on Jan Just Keijser's patch from Feb 7, 2012.
>
> When OpenSSL 1.0.2 or newer is used, lets OpenSSL do the heavy lifting.
>
> Otherwise, tries the following things (in order of preference):
>  * When supplied, use the ecdh curve specified by the user.
>  * Try to extract the curve from the private key, use the same curve.
>  * Fall back on secp384r1 curve.
>
> Note that although the curve lookup succeeds, OpenSSL 1.0.0 and older do
> *not* support TLSv1.1 or TLSv1.2, which means no that no EC-crypto can be
> used.
>
> This patch also bumps the minimum required OpenSSL version to 0.9.8,
> because older version do not have all the functions used and would require
> adding (more) #ifdefs.
>
ACK.

Arne


--Me84OF0bj2f5n0x3FRI1tLlSHkkqMWPjk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNXkL4ACgkQe8+cMNS4zRem+QCfVsMHh+G+9KWCMroGHnarDd6+
bjMAoMBqy9oH0ejOMEpBNsmRpkV36fSY
=MAja
-----END PGP SIGNATURE-----

--Me84OF0bj2f5n0x3FRI1tLlSHkkqMWPjk--

