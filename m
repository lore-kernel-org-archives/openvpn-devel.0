Date: Wed, 18 May 2022 11:37:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YoS+R/bSOQYesTKb@...1296...>
References: <20211019183127.614175-17-arne@...1227...>
 <202110210624.19L6Okf0035545@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GPzUWkFLCFYElLmd"
Content-Disposition: inline
In-Reply-To: <202110210624.19L6Okf0035545@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add message when decoding
 PKCS12 file fails.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--GPzUWkFLCFYElLmd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

decided in the community meeting today that this should also be
cherry-picked to 2.5 - I have not actually tested with a pkcs12 file,
just run the basic compile/client test cycle (and the patch is
trivial enough).

commit 1f54811e92c89fe07d7cea8339e928980bfe0536 (HEAD -> release/2.5)
Author: Arne Schwabe <arne@...1227...>
Date:   Tue Oct 19 20:31:22 2021 +0200

    Add message when decoding PKCS12 file fails.

gert

On Thu, Oct 21, 2021 at 08:24:46AM +0200, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> "That was an easy one" :-) - error reporting is always useful, and
> the code change is trivial enough.  Tested with "wrong password" only,
> which now prints:
>=20
> 2021-10-21 08:24:01 OpenSSL: error:23076071:PKCS12 routines:PKCS12_parse:=
mac verify failure
> 2021-10-21 08:24:01 OpenSSL: error:23076071:PKCS12 routines:PKCS12_parse:=
mac verify failure
> 2021-10-21 08:24:01 Decoding PKCS12 failed. Probably wrong password or un=
supported/legacy encryption
> 2021-10-21 08:24:01 SIGUSR1[soft,private-key-password-failure] received, =
process restarting
>=20
> Your patch has been applied to the master branch.
>=20
> commit 6ac4e63c577986ec11eae3519fe8516e8ca8ac0f
> Author: Arne Schwabe
> Date:   Tue Oct 19 20:31:22 2021 +0200
>=20
>      Add message when decoding PKCS12 file fails.
>=20
>      Signed-off-by: Arne Schwabe <arne@...1227...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <20211019183127.614175-17-arne@...1227...>
>      URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg23017.html
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

--GPzUWkFLCFYElLmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJihL5HAAoJEB2Cnv7KVigSgq4L/2ku0xus7bn/qMWbnf5MFKd+
XBM1e1HJtP96DCPQjDShhGMPgcNiO5uf9iP7svklP8ib8FhY9AU/vA4lMjPhMD2p
LHO1wHQ5teJEwF+RnkjUbn/ANK21EKTC52tUnRpI8jNCZI/f9vnP2BV7osdGR9m/
M/v7HbbZdngikcwbiLtXUzPGfSQmx/FiIFFQvVgW4uJTc4JjvnycHqIpXYSo6ru0
gQTDaxH03909qgAU1LhkcbTNAf1Xp0NXQtDmO8CPDxczjVV9ctS7mN9XUt73glte
cVx9zc+PH4EPJVht8RUlhd322cGNKcVXG1oCuDWfOPdHhiWHYj5yQOl1FqZuYqa+
cetIjFSmS2hLk3gHjWTkxTouj7wOrzMe+g8flKHI6EAwWorRDLkrlNds7KrFJs2V
5Q809BAN7/mT5PG0OsNuix+uKRIxCh1a1+0YqaXDnrO69CjFjxh4ZW3rWUHnt8xv
h1q+4VqKvMhxU7VfQGiGsfSOOirTCrIz2cCQM7f77A==
=ULCM
-----END PGP SIGNATURE-----

--GPzUWkFLCFYElLmd--

