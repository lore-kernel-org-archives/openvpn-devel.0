Date: Sun, 19 Apr 2020 17:46:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200419154614.GC1431@...1296...>
References: <20200416113930.15192-1-arne@...1227...>
 <20200416113930.15192-3-arne@...1227...>
 <5e764697-b61e-7115-7e3c-fcc7bf0407e7@...2181...>
 <20200419102725.GA1431@...1296...>
 <33b3339e-f90c-e35d-5921-f937fb07acd8@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Lf5N93S3uGY/b6lN"
Content-Disposition: inline
In-Reply-To: <33b3339e-f90c-e35d-5921-f937fb07acd8@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] After the last big formatting
 patch a number of changes have been commited that do not conform with our
 style/uncrustify config. This has lead to the problem that running
 uncrustify on before sending PR some of the changes made by uncrustify need
 to be backed out again.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--Lf5N93S3uGY/b6lN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 19, 2020 at 02:22:37PM +0200, Antonio Quartulli wrote:
> >>> -    char* ret =3D management_query_multiline_flatten(man,
> >>> -            (char *)buf_bptr(&buf_data), prompt, desc,
> >>> -            &man->connection.ext_key_state, &man->connection.ext_key=
_input);
> >>> +    char *ret =3D management_query_multiline_flatten(man,
> >>> +                                                   (char *)buf_bptr(=
&buf_data), prompt, desc,
>=20
> fully agreed. but in this case uncrustify is just fixing the alignment -
> moving the arguments above would not make uncrustify unhappy because all
> rules would still be respected.

I think uncrustify would promptly move them down again... line length
rule.

Of course it's worth a try...  we're at a good point for refactoring
and code cleanup.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Lf5N93S3uGY/b6lN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJenHJFAAoJEB2Cnv7KVigSKT8L/jvo5V7EiYBvlzqU9suIO32Q
MrtXRwAsos41Hjncr+r/rcZtBnhUVW147xLaoxFtGrDx1yGugPD0BTMaTEFi6n0T
P0KePXi386okoBaX603x93UVT2gIFQOMxK8tC/LJ02fq7Pd1xf7h+hjJw8r/q7VD
fMmPK4l6KlbpVs3iue6e0h3AzGng5vT8e1NvxKN6Y7booBgdKuOSHWhpAbqUMGA9
jtGlOJmEVWa+L7kmOL8SwSO8yDaEzCcK0QJRS/MCQQ4G2GPdtLgZvaJkw3FhcvsZ
WwAfD2RIXJJOtEDk6feljAQXUHAK2mDQVl78+zSO2eld/vsGS9jDnk93IZiW40GX
hxi0c+/8oc+ftRtPriCDCXhEyUsQiOI9I/QNAGQCtrDifvVxLHNInm/ymexV1VnM
eFRSRMhuhKnO4h2uR8rFbJUFYPd0yfqzmpayE6HWRnM0QnZwlaILUR9X/CbqH9dO
V56DVRuvISleVd3LOoC6f9e7QB9A3fs/0mbqdwBmxg==
=tdK7
-----END PGP SIGNATURE-----

--Lf5N93S3uGY/b6lN--

