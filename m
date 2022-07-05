MIME-Version: 1.0
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-26-a@...2181...>
 <YsQFFkxkn5BdEdTQ@...2678...>
 <a6ccb545-ebad-fe78-7691-80e694792b98@...2181...>
In-Reply-To: <a6ccb545-ebad-fe78-7691-80e694792b98@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 5 Jul 2022 13:38:36 +0300
Message-ID: <CAGyAFMV+0mqnPRA6L41hec6OwSumHvuJCSAx9jQZWhjVDQYWvg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 25/25] dco-win: update GH Actions config
 file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Antonio Quartulli <a@...2181...>
Cc: Frank Lichtenheld <frank@...2641...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

We have moved dco-win uapi header to openvpn repo, so we don't have to
checkout ovpn-dco-win repo to get it - this is what this commit does.
But yeah, good point on having dco builds without dco.

ti 5. hein=C3=A4k. 2022 klo 12.36 Antonio Quartulli (a@...2181...) kirjoitt=
i:
>
> Hi,
>
> On 05/07/2022 11:32, Frank Lichtenheld wrote:
> > I think this commit could use an additional sentence
> > in the commit message on why exactly you remove this?
> >
> > Doesn't immediately make sense to me.
>
> To be honest, I am not even sure why we have a build with DCO in the
> first place. There is no DCO code yet in master but somehow we have the
> GH action for that :-D
>
> Anyway, can add a sentence to explain what is going on.
>
> Cheers,
>
> >
> > On Fri, Jun 24, 2022 at 10:38:09AM +0200, Antonio Quartulli wrote:
> >> Signed-off-by: Lev Stipakov <lev@...515...>
> >> Signed-off-by: Antonio Quartulli <a@...2181...>
> >> ---
> >>   .github/workflows/build.yaml | 7 +------
> >>   1 file changed, 1 insertion(+), 6 deletions(-)
> >>
> >> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.ya=
ml
> >> index b905c0d2..536dd9d6 100644
> >> --- a/.github/workflows/build.yaml
> >> +++ b/.github/workflows/build.yaml
> >> @@ -59,11 +59,6 @@ jobs:
> >>       steps:
> >>         - name: Install dependencies
> >>           run: sudo apt update && sudo apt install -y mingw-w64 libtoo=
l automake autoconf man2html unzip
> >> -      - name: Checkout ovpn-dco-win
> >> -        uses: actions/checkout@...2620...
> >> -        with:
> >> -          repository: OpenVPN/ovpn-dco-win
> >> -          path: ovpn-dco-win
> >>         - name: Checkout OpenVPN
> >>           uses: actions/checkout@...2620...
> >>           with:
> >> @@ -151,7 +146,7 @@ jobs:
> >>           run: cp ./tap-windows-${TAP_WINDOWS_VERSION}/include/tap-win=
dows.h ${HOME}/mingw/opt/include/
> >>
> >>         - name: configure OpenVPN
> >> -        run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig DCO_SO=
URCEDIR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D-L$HOME/mingw/opt/lib CFLAG=
S=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D"-L${HOME}/opt/lib -lssl -lcry=
pto" OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PREFIX=3D$HOME/mingw/opt LZ=
O_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=3D"-L${HOME}/mingw/opt/lib -l=
lzo2" ./configure  --host=3D${CHOST} --disable-lz4 --enable-dco
> >> +        run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig LDFLAG=
S=3D-L$HOME/mingw/opt/lib CFLAGS=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=
=3D"-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/in=
clude PREFIX=3D$HOME/mingw/opt LZO_CFLAGS=3D-I$HOME/mingw/opt/include LZO_L=
IBS=3D"-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=3D${CHOST} --dis=
able-lz4
> >>           working-directory: openvpn
> >>
> >>         - name: build OpenVPN
> >
> > Regards,
>
> --
> Antonio Quartulli
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--=20
-Lev

