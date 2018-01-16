Date: Tue, 16 Jan 2018 09:26:52 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180116082652.GJ69387@...1296...>
References: <CAKh=nwFOSOCugW1JWYfiQFZLTKRBc6qoi=U9ewzjOSpaGP1-Kg@...278...>
 <6a6ede658da2e35b718a9ccb733b132a955ffefe.1515792908.git.logout@...260...>
 <183bd138-e733-042e-9cc3-c66bbf6ea9bd@...1856...>
 <CAKh=nwEeSBgkbz5-_R_eU7rK9fYpDQ=1jsY+02+vMxRJ8=wZxg@...278...>
 <CAKuzo_j6Uuw8minumYHECmqtE9ocvrzGtO0_3FUcGnNy4q3Bqw@...278...>
 <CAKh=nwGDv2fKJ6STqYthwpH+1SkztkLj1=KH4MWJ58ifc_byog@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Km2V3aJx5eFEhJmw"
Content-Disposition: inline
In-Reply-To: <CAKh=nwGDv2fKJ6STqYthwpH+1SkztkLj1=KH4MWJ58ifc_byog@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] OpenSSL: remove some EVP_PKEY
 type checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

--Km2V3aJx5eFEhJmw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 16, 2018 at 01:56:11AM +0100, Emmanuel Deloget wrote:
> 3) rework it as proposed in the patch
>=20
> RSA *rsa =3D NULL;
> if ((rsa =3D EVP_PKEY_get0_RSA(pkey)) !=3D NULL) { ... }

I do not particularily like assignments in if() clauses, especially when
the variable is declared right above it.  So if we go for (3), my=20
favourite would be

RSA *rsa =3D EVP_PKEY_get0_RSA(pkey);
if (rsa !=3D NULL) { ... }


but this is just a side remark.  The question on "1, 2 or 3" I'll defer
to you folks that are maintaing this code (Steffan and Selva, mostly :) ).

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--Km2V3aJx5eFEhJmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaXbdLAAoJEB2Cnv7KVigSohsMALIgPQkVvDz0/3ytWMaHMrRe
8+yAJzXUxOCTTs4swTa/8tOY1Dx6VjAjp3H9QChLHSG4NduHq6pz2T3DwEqXANQD
tZNDEmOC79gE3tB7e2iF5dokW9T/g3dKKfWNjAoCdS19dfvk4cBIc/CW0w7t7iBg
1SMMCgE0cyX7aRFfpnfOJIiX/YdaeVz3nFExKMXWh5mc9uzfAbLIUdHQa/YpP8zQ
g3EhqrRBUrYg6v+np8soI8b0xuHSmsBIWOJ+g1Hh5qH1vNeL7JisBiCKRHFaW1H/
2LKldJW9AQ3yO4txtdTAfCWOLikqV53c0RfOPE1qtcKcWNK7yP8MlZ8/lbG52mGB
+5Z5VxCQEttxKHuPLmfWHtcbl74cOaetE59jPZdiNatpqeUHaHJ+vLl0pc1HOfJR
YoFYY9EfgT6NpivC30muTxFIpFL+h33CNDT2ngvPz141ZuiYfKOJhg98424XwbNc
l8QvDoiYpoBbnnbzw7DuZ/cux1LG2p0JwIoSRpaS9w==
=/b1C
-----END PGP SIGNATURE-----

--Km2V3aJx5eFEhJmw--

