Date: Wed, 15 Apr 2020 19:58:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200415175828.GK1431@...1296...>
References: <1581519967-16950-1-git-send-email-selva.nair@...277...>
 <202002131954.01DJsIrb090643@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="F5foZO7yuPxym+dD"
Content-Disposition: inline
In-Reply-To: <202002131954.01DJsIrb090643@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Skip expired certificates
 in Windows certificate store
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--F5foZO7yuPxym+dD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

is this one and aa6affe6df811db11577847366a569def0a3e314 also material
for release/2.4?  So "feature" or "bug" category?

(I've left this sit in my inbox and also in patchwork to remind me that
I wanted to clarify this, and then never got around to actually do so)

gert


On Thu, Feb 13, 2020 at 08:54:18PM +0100, Gert Doering wrote:
> Your patch has been applied to the master branch.
>=20
> Haven't done any real testing, just test build on MinGW (to have "the
> other build environment").  Passes :-)
>=20
> commit 7b63984d51a2582ba2d406e46a7debb11df7f478
> Author: Selva Nair
> Date:   Wed Feb 12 10:06:06 2020 -0500
>=20
>      Skip expired certificates in Windows certificate store
>=20
>      Signed-off-by: Selva Nair <selva.nair@...277...>
>      Acked-by: Lev Stipakov <lstipakov@...277...>
>      Message-Id: <1581519967-16950-1-git-send-email-selva.nair@...277...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg19404.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>=20
>=20
> --
> kind regards,
>=20
> Gert Doering
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--F5foZO7yuPxym+dD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJel0tDAAoJEB2Cnv7KVigScZQL/1JoQ4yD2JrknrEtOmlIJBAh
1e8RMwcRvq2AJUJ85POz/fp+he6jNAjfJSz0JEaIuOvt3h96mVCrpQJtdWbbe6Tp
HjGSnx6AUJ79dxbbyESGyit8eUtvq6JQUWtYk2I3HKlXY138nOSLLNofhwErlgwC
ybbKgC+z3OgzeXxrkuKqpmmVvsaqTwEEr9MbjIJUWcCJwE8E6he/M1T6QoAHIJJM
L86UeX/NDJxiUsgq9CHloYmGOJWyOpIdC0NawxX08wPgXo541ydsyo8K53T3uH5m
pGwEacknKigp80470mLqfqaHLnHzepuQ2Yp4/8etr5vPkr2ZR1nKlgpWwRn7A3JW
vp4b4JApIeNOBdiUMUsCPNnvg4PboTJPSszwWbOFVvseOEZGFqulilVeZuxrRgM0
5caN4aG7jiLir4Vsui9yNBDklOKxEPpWS1O2tTTh9UyL6kmImbk8YbMNWHvteiXt
/PA61Dx+NkSo79Z3D7SFCvchFyeHEWIl3kY801R6rQ==
=dOK4
-----END PGP SIGNATURE-----

--F5foZO7yuPxym+dD--

