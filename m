References: <20200725235023.22441-1-arne@...1227...>
 <CAEsd45Seh_4O1DmNcOBOwWknZKi4oDSTfVC+L3OAAOTP=OCFuA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a6a0a017-20c6-c53f-cc84-39547002caf2@...1227...>
Date: Sun, 26 Jul 2020 02:38:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAEsd45Seh_4O1DmNcOBOwWknZKi4oDSTfVC+L3OAAOTP=OCFuA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WSWCtHh8NB9pneMaemioqg9TKADKstc3Y"
Subject: Re: [Openvpn-devel] [PATCH] Include utun device number in utun
 error messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WSWCtHh8NB9pneMaemioqg9TKADKstc3Y
Content-Type: multipart/mixed; boundary="tCt68TqRoMHl7da2pV0FvmJX7lmT5srVq"

--tCt68TqRoMHl7da2pV0FvmJX7lmT5srVq
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>=20
> Feature-ACK. The failure messages have concerned some Tunnelblick
> users. This _might_ help clarify things for them and it certainly
> won't hurt.
>=20
> I have not tested the code, but it looks fine.
>=20
> Note that the last half of the patch consists only of whitespace
> changes (starting at "@@ -5682,15 +5685,15 @@).

Yes my mistake, I did a uncrustify on the file before checking in but
did not double check that it only modified the parts that I modified before.

Arne


--tCt68TqRoMHl7da2pV0FvmJX7lmT5srVq--

--WSWCtHh8NB9pneMaemioqg9TKADKstc3Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8c0I4ACgkQFRhsZwKx
RFT7Ag//TS58623U/XV0Rg7ewK4cFQ0c+pDo8gsBmmjp/vxvLqQPRe/C1nRmeEOt
5C38NTMWafATkIgZsfmOhwpW6IGaPCY3cywP5Yhi8zm91NOUDFzfxthYJammjfav
g8Ua0hVmOPFhPb+4qb2dNPAp+JipP5sXvZ0ZCZEMDuF16f2WOZj3m3nLHnZKuOLp
s8S0rIJxfP6Nju6S7RpK0nGCQ6DbC3KYS1sUWs2SHVGE2kZeFrVHa0TvGfGTUDBE
QETGBTY6eTgcBWHVqD608fwUG/COl+uCEx+lKoF4MDESSCWn0zWAmb/fQDaP8vp7
kU+kgYl9o8A5HGqlJRN2ScLTgVwyqYLl+GHDoI0yYYrwcnJSE7ksydTeW+nSJ7Lb
2Nx67tQxTLodZ5cZff4jYeoCV3CCfF9RC2HYZET9UopC/5ytjPsdEI3n/PLQxkQL
g0J6maddWDUe6hZsgSugVvuqZfRAiR2dW7oXTKKzWKpoz3Ac4kaozZKeHxQ6jw2o
hp7Z2CEpBYZLT+NKjDuHRfYkWKy1qrJtZnxrgV3XdotHF+yL5pXrgFC/oRuT1XSH
XzzRykzfU/jwag9MwKNpEB+wbGv+iEDSL10MrxNapM/OuXPQuyXNPnYVwR01/9JJ
i2TnPASu+YYWwlIu9zMwqYiYsYQ8WwUZtHlh+IzSohNn+88I8jo=
=+Rpk
-----END PGP SIGNATURE-----

--WSWCtHh8NB9pneMaemioqg9TKADKstc3Y--

