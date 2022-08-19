Date: Fri, 19 Aug 2022 12:56:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv9sbNTaD21mSsDC@...1296...>
References: <20220813204224.22576-1-a@...2181...>
 <20220813204224.22576-5-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hPxagKUkQJowYEOw"
Content-Disposition: inline
In-Reply-To: <20220813204224.22576-5-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v101 5/7] dco-win: update GH Actions
 config file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--hPxagKUkQJowYEOw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 13, 2022 at 10:42:22PM +0200, Antonio Quartulli wrote:
> Signed-off-by: Lev Stipakov <lev@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  .github/workflows/build.yaml | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

I do not understand this commit.  Not at all.

It seems to take an existing setup that builds an installer *with* DCO,
and remove the DCO bits?

> @@ -59,11 +59,6 @@ jobs:
>      steps:
>        - name: Install dependencies
>          run: sudo apt update && sudo apt install -y mingw-w64 libtool au=
tomake autoconf man2html unzip
> -      - name: Checkout ovpn-dco-win
> -        uses: actions/checkout@...2620...
> -        with:
> -          repository: OpenVPN/ovpn-dco-win
> -          path: ovpn-dco-win

... so maybe we can have a better commit message that explains this?


> @@ -151,7 +146,7 @@ jobs:
>          run: cp ./tap-windows-${TAP_WINDOWS_VERSION}/include/tap-windows=
.h ${HOME}/mingw/opt/include/
>=20=20
>        - name: configure OpenVPN
> -        run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig DCO_SOURC=
EDIR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D-L$HOME/mingw/opt/lib CFLAGS=
=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D"-L${HOME}/opt/lib -lssl -lcryp=
to" OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PREFIX=3D$HOME/mingw/opt LZO=
_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=3D"-L${HOME}/mingw/opt/lib -ll=
zo2" ./configure  --host=3D${CHOST} --disable-lz4 --enable-dco
> +        run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig LDFLAGS=
=3D-L$HOME/mingw/opt/lib CFLAGS=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D=
"-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/inclu=
de PREFIX=3D$HOME/mingw/opt LZO_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=
=3D"-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=3D${CHOST} --disabl=
e-lz4
>          working-directory: openvpn

This, I think, is clear - "--enable-dco is default for windows builds",
and maybe also "no DCO_SOURCEDIR neccesary anymore, since ovpn_dco_win.h
is now part of our tree", right?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--hPxagKUkQJowYEOw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/2xsAAoJEB2Cnv7KVigSuF8L/iC60gDcNRSPSlauF3aTKhec
B/JhRf2qVaVHInLVN6mewyJD1cuDpiA9yxzPirnucSy5FFM6cLz+kouuPslB/EvP
mS2C9+jp8qrWhVJ28s7w4G8rzJ/IRrPlzKJTs0Psr8v6aZCQ1Ed75f5G5YNACkT9
EoGaskSYBb/C0v+feJyE4pbPrKzUaKUhO82TkIbOLfiU31dBk3XYVh7Q5S+OhB7c
go/2uhh4PPHr5JJTM2Lv8oGCHmue11D9sJhA2lKK1B/fbbCBM/116XUGrQbNFXKK
dRITWEQG66QvxPn7LOobJqdEVDL2E6hvPDsjgU+b3xjkR7ac6CGeVeJLNcQ+UPp/
MCC56LIEkC8mG2um88/um+L0pNFRlNnXaH3+naM9jw7/xogdlhH40B07ptFYesr6
yekCy3sHZGLm6mefNWBuNwGOzXK21RFeH+aik+KxJDSTPFysHnO46DtdN4JQKqy8
8yiL88ha+31hl69l4sO29RkrcZOOIunBpRf3+i4zuw==
=Z9Kx
-----END PGP SIGNATURE-----

--hPxagKUkQJowYEOw--

