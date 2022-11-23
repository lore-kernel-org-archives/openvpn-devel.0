Date: Wed, 23 Nov 2022 08:42:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y33O2H0yik5n7Py8@...1296...>
References: <024a01d72508$551785d0$ff469170$@yandex-team.ru>
 <20210507135022.20382-1-themiron@...2010...>
 <Y30VvTxrLTceAGrU@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+dEKzuIXKB+jMkaT"
Content-Disposition: inline
In-Reply-To: <Y30VvTxrLTceAGrU@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v12] Add DNS SRV remote host discovery
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

--+dEKzuIXKB+jMkaT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 22, 2022 at 07:32:29PM +0100, Gert Doering wrote:
>   - use getrrsetbyname(), and add that via "compat" source if a target
>     platform does not have it - this is what OpenSSH does
>=20
>   - add #ifdefs to disable --srv functionality on OpenBSD
>     (which is not really where we want to go)

I think these two options are the most realistic to move forward here.

getrrsetbyname() looks like a good API, and taking the compat functions
from OpenSSH (I think we can, license-wise) would bring it to the other
platforms.  But that's more work.

"Just pretending that there are no SRV records" would be the quick and=20
dirty approach for OpenBSD otherwise, #ifdef'ing out the whole problematic
function.

In any case, since I've been working on the code now, someone else needs
to volunteer to review the v13/v14 patches.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+dEKzuIXKB+jMkaT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjfc7YAAoJEB2Cnv7KVigSPewL/3Zasf1WK9DPxoU3iOI/5Vmm
SmdgeoA2NLUEWprfAf0n3VwyrBHvsSxLQef1/N4qlk/Mj4nA7jw0JFT2IYEWxxFQ
Ed9VrGlc0hGXZ84/L0fgIqVeUTHj3Ax6t1hkgBP8/lxuCkEyCNERiXDP9A40J/QL
Loh77LfHmSEqIlFF0cZo0kmw884CPKXC8xbyIuAY4uhecCUkkxojgc474nj2qrAx
HZgSrtLBoReudL4lg0PgwfcnDf65xa24ZoySbFwIsVEoNidbcRmAwz2liIvpwWB9
pNeSAbwCOK9djwB+lTrIlE+VR7eg/zAwTefS09QDY6KRaCRdTqkchc+GDau73BGT
Qshrjvl8g9CGWoAzu6AsuamKjORTFOlByRUfM3GToVi523P9e+lZMvREAEeG7K0i
fgzghLhfKHRe0xMbSIMwEjuh1x8VCjyFe3A0H7lp4FOjT1fadkbl4mZjrqenJaVZ
9TFUP6uUHRTWsx6Zfvtk5l4zTwqJ//Wy8bS/e8XRBQ==
=yWFU
-----END PGP SIGNATURE-----

--+dEKzuIXKB+jMkaT--

