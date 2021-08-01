Date: Sun, 1 Aug 2021 19:55:58 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YQbgLkyyLs2lA/aj@...1296...>
References: <E1lSJph-0004I0-JF@...2479...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/klg1Zru/FbDpmZw"
Content-Disposition: inline
In-Reply-To: <E1lSJph-0004I0-JF@...2479...>
Subject: Re: [Openvpn-devel] [PATCH] Change CTR DRBG update function call to
 new mbedtls 2.16.0 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Max Fillinger <maximilian.fillinger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net, uipko.berghuis@...1435...

--/klg1Zru/FbDpmZw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 02, 2021 at 03:26:23PM +0200, Max Fillinger wrote:
> From: Uipko Berghuis <uipko.berghuis@...1435...>
>=20
> In mbedtls 2.16.0 mbedtls_ctr_drbg_update() changed to
> mbedtls_ctr_drbg_update_ret(). Change the function name and handle
> the new return value error code.

Going through patches in patchwork right now.

I'll put this one to "Changes Requested", as we need the extra compat
wrapper for older mbedTLS versions, as Steffan suggested downthread.


Please amend, and send us a v2 :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/klg1Zru/FbDpmZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhBuAtAAoJEB2Cnv7KVigSg9IL/0q6YHzNUpr2RmELYUDlges+
2aR5g9Cx5H912wInYezkWPxfgeqgHGscQK/uiirv14oeYWNOFyd3gIL6GWYYqiBe
DrBLqSW4LVClJ+XRAg6j/ixjwFNfc6VXs6GIqNjgpI8o5t8P8wOp8CE/Ag7DmXBj
6Rm9DTFUf3tLO0SssCJKXkiZNi2+q+b5I67J0HyYOyLRYpF/FJW80I1MRNo1Owql
O0F46RMKohQHJpk8UdaoI2ymVEP4My8jLWuJf6xihtNHaYCbMBcwiYrDcWh/lRZd
FJ7PWkKezYiEpHZXa7s5Dql2YrjJu4gL2U4u5LWZueGSOdAz+6kHzCRCRm0i+lt7
/f5VL2WKG0IyhwdPoP+fWa7OcpYagknhm1o6NCMXQtapVL7uaSm8Y3yRkNyiG+6G
2XkH0GMjZWEAGh+dYF+yFb9F7NhwARWBdEzC0b9jyL8fiuWv0NUYsNp9XXtTBj1f
26fgIUxunKC/+Z7EA2eCuWlQWGpN4SxC3hkpwBrM+Q==
=gEY3
-----END PGP SIGNATURE-----

--/klg1Zru/FbDpmZw--

