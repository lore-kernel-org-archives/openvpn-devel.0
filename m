Date: Tue, 14 Feb 2023 14:48:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y+uRRZmIcCYE2Zz/@greenie.muc.de>
References: <20230204004512.250271-2-selva.nair@...277...>
 <20230204064010.257925-1-selva.nair@...277...>
 <20230204064010.257925-2-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GgT+Vlh5JLLtJ+qx"
Content-Disposition: inline
In-Reply-To: <20230204064010.257925-2-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Add a unit test for functions in
 cryptoapi.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--GgT+Vlh5JLLtJ+qx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 04, 2023 at 01:40:10AM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - Though named cryptoapi_testdriver, right now this only tests
>   parsing of thumbprint specified as a selector for --cryptioapicert
>   option. More tests coming..
>=20
> v2: a line that belongs here was mistakenly included in the previous
> commit. Corrected.

So, unit test are good, especially for the Windows bits that could
really use more testing - so thanks for that.

OTOH, having the test here without adding it to .github/workflows/build.yaml
means "it not run automatically".  How do we want to do that, do you want
to send a v3 with build.yaml extended, or shall I merge this as is, and
we do a separate patch "... and now run the unit test"?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GgT+Vlh5JLLtJ+qx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj65FFAAoJEB2Cnv7KVigSrq0L/juwKz0WbxLWkRxSNethzRBx
BGDVYw4xJb+EzaZXGHuyqgoOarI8r8lM3z5FqQIun+vWLM7LnHFolEzNKZQrYov1
wHi2noCDbEeTAOYSJbQJNXPth74j69qtowFiZeQKJ1vF091Z1ScekccV2XuRiCqQ
rKzEqIBzz196EqknAVs2/xE5A4ySkTu07DEwq6vRqejM4FK1/z97xFo795y0/RcH
Fyj3wOXuAAJjYEIRiOAqT01Ui8z2937LTRLoMvKclox5WvV1P/P7eoXCnikzDj4e
BFumihtE+5KbONJiyC8B+qxv5G/ZO4sfzipD9cuvSjCfOaCisFWHFfOqrq+0LS8j
ZkLvMWzxajQwwUgh+4xSXu+zQbq2+EEMnoZ9cyBhu6UFkQTVjRZFoX6PdlzmZIs4
HRA9McdubCPAOULGnL6pHal6jYZOXQ0Z8aL/pwKBiRp8bUAIaYht4YO9tXnWNAoe
LksIornrHOSYewWIJ48ZxbkGNQl6GkuxZ9hQOwnwGg==
=DV4m
-----END PGP SIGNATURE-----

--GgT+Vlh5JLLtJ+qx--

