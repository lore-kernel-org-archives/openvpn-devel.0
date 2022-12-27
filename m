Date: Tue, 27 Dec 2022 10:36:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y6q8kjxeFt8WmjJN@...1296...>
References: <20210825210232.22509-1-selva.nair@...277...>
 <20210907223126.8440-1-selva.nair@...277...>
 <0366748c-832f-2704-9693-ef6842489977@...1227...>
 <CAKuzo_gmU-iP2dY9Vh1T2ZgJQEMJUCfnRj5ZnKiFLbCCAeK+sA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UPt84xJdH00wWMRi"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gmU-iP2dY9Vh1T2ZgJQEMJUCfnRj5ZnKiFLbCCAeK+sA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/3] Add remote-count and
 remote-entry query via management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--UPt84xJdH00wWMRi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 26, 2022 at 05:30:23PM -0500, Selva Nair wrote:
> > > +
> > > +#define min(a,b) ((a) < (b) ? (a) : (b))
> >
> > We already have min_int and min_uint in integer.h. For consistency I
> > would prefer using those instead of adding a macro.

Unfortunately, this is more than "just an extra macro" - it breaks our
MSVC builds due to the windows equivalent of -Werr and macro
redefinition...

https://github.com/OpenVPN/openvpn/actions/runs/3786194652/jobs/6436868937

D:\a\openvpn\openvpn\src\openvpn\manage.c(862,1): warning C4005: 'min': mac=
ro redefinition [D:\a\openvpn\openvpn\src\openvpn\openvpn.vcxproj]
D:\a\openvpn\openvpn\src\openvpn\manage.c(862,1): error C2220: the followin=
g warning is treated as an error [D:\a\openvpn\openvpn\src\openvpn\openvpn.=
vcxproj]

(not sure why it calls out "the following warning" when it talks about the
one before it? but anyway)

this came a bit unexpected, so it's been pushed out already...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UPt84xJdH00wWMRi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjqrySAAoJEB2Cnv7KVigS77oL/ArNtT97btS8iaF3V5glXL5G
vYiJ9y0jKSfX+iRmkqa/pIRId/8I15P3fD3iC/+mdINgIPFsl7mikWwBMQB4Ay2t
0YRQRJvjmYcVpPNd7pFViildn+Y19YJKKIYZU07casR0NTD3/R5UfVlCRnEPP0fa
/F48+4CPEUoKatHEBGmWsd9DVx7AoSJJT8ncMcGR/pqdaTZEeKFHmIsV2QqSWBgz
REyPR/tuTIbO37lyalav/MaLnn2TXz3FQoO/5DH/mHBE6VJwzUAurQIXrHVUb18L
IapvHGTacDFEyzVo4Gi71yrlZ5Wv/OoYmhrxBhJ9xDiBQosltO0tT6lBoa38HIi5
coXzgF67DbbTlCZIHxrFo1IJF1y/SUfSG2XvNHEjo7VM2onE49VWp8uYPyRk012J
7ghkLRUDglgNr8PkB2JZmwAfUYXnPqbyJADO1a1+5jPXZYI/7817Eb5fgCLdpgwH
YeRxl35NwB4RpndFrCkfr+7S/W9f/Nf/Z7yIf8oXqA==
=V6PI
-----END PGP SIGNATURE-----

--UPt84xJdH00wWMRi--

