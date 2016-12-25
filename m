Date: Sun, 25 Dec 2016 18:09:01 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20161225100901.GG8708@...2182...>
References: <20161219013949.19551-1-a@...2181...>
	<2fc5173c-b27b-3828-f227-e15687831667@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <2fc5173c-b27b-3828-f227-e15687831667@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, Dec 25, 2016 at 10:44:45AM +0100, Steffan Karger wrote:
>=20
> On 19-12-16 02:39, Antonio Quartulli wrote:
> > Carrying around the INLINE_TAG is not really efficient,
> > because it requires a strcmp() to be performed every
> > time we want to understand if the data is stored inline
> > or not.
> >=20
> > Convert all the *_inline attributes to bool to make the
> > logic easier and checks more efficient.
>=20
> This makes sense, feature-ACK.
>=20
> > Signed-off-by: Antonio Quartulli <a@...2181...>
> > ---

[CUT]

>=20
> Seeing the recurring "don't accidentially print key data" issues, I
> think adding a wrapper function to check for "[[INLINE]]" (and NULL?)
> would make sense.

I do agree on this. I thought I caught all the cases...but I left out some =
of
them. I'll implement a small helper function and use it where needed.

> Apart from that, this looks good te me!

Thanks a lot for your feedback!
I'll send v3 after including all your comments.


Cheers,

--=20
Antonio Quartulli

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYX5q6AAoJEJ6F1zG2JyOsahwP/jyDf8gLR8qRZzcSA97+BleK
lOrJN2/uhY8+RwgiKsYeE5elLIgTCGwIbrHNimQkJfpTiM3eVstSzTVB1Kfarho3
PJCmrojJyWoe1gfT6ov/3HzupZWHXUzX25d0gwKy72LBKLeL4qStohhbPgzs7xvZ
aVw138MFdaG1tzhUxmYQpefAEbPEjzFPBQFwuE0cUgCfd01fOVqFfTP/HTVBybUS
0VLLwgufzlfOTqnuELUrG49VlLXwy3/ShdIdAAcbXburDU2o41fFI+CZXn6GJF1D
cxQVjGUVG+ITA3xAJA8PU9ZreeHDliq78x/TduoYGUvVCQfHF+wb8Cfg0hl2BWTt
CoLEsycU6fr6mI8c7Dg5Yjdfw2qM0LEIfRJNnYVAj1e4DWrgy5YesyeF9G/JnyGz
4q07LGqwftayorX3ITTJSUZbblXPYLRlRJ6Az7ICjh13AE4LJQ18KfTtV+0SHJQ+
SIVVwttGPnTBEweoccZKPQxeityarLIyMUeDYvIXEJX7iTPbAE81T+cjhA3B/hZC
6R9S2YYFXE/a1nvxRZ/FkvubR997IVaACVrOMapzTLQBkNnVyHAQMrZpppo08EPv
2yNraXp3yqrPNQ5R0b57cfzEqWP6N0igMxPJpTiPH1Tm8iXaHcOdF8S1lB/ogl+6
vlZQVEH5yEMUvKblexcD
=d5z4
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--

