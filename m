MIME-Version: 1.0
References: <20220813204224.22576-1-a@...2181...>
 <20220813204224.22576-5-a@...2181...>
 <Yv9sbNTaD21mSsDC@...1296...>
In-Reply-To: <Yv9sbNTaD21mSsDC@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 19 Aug 2022 13:04:08 +0200
Message-ID: <CAGyAFMVch_xrjWC6SuiZmzVBxQ92+Ktyz5jCVMT_W3BQMs8tUA@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

I remember someone was explaining to me the necessity of verbose
commit messages.

Chi pu=C3=B2 essere?

> It seems to take an existing setup that builds an installer *with* DCO,
> and remove the DCO bits?

> ... so maybe we can have a better commit message that explains this?

We decided to move the uapi header to the openvpn repo, so no need
anymore to clone driver repo to get that header. Hence this change.

> >        - name: configure OpenVPN
> > -        run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig DCO_SOU=
RCEDIR=3D$(realpath ../ovpn-dco-win) LDFLAGS=3D-L$HOME/mingw/opt/lib CFLAGS=
=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D"-L${HOME}/opt/lib -lssl -lcryp=
to" OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/include PREFIX=3D$HOME/mingw/opt LZO=
_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=3D"-L${HOME}/mingw/opt/lib -ll=
zo2" ./configure  --host=3D${CHOST} --disable-lz4 --enable-dco
> > +        run: PKG_CONFIG_PATH=3D${HOME}/mingw/opt/lib/pkgconfig LDFLAGS=
=3D-L$HOME/mingw/opt/lib CFLAGS=3D-I$HOME/mingw/opt/include OPENSSL_LIBS=3D=
"-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=3D-I$HOME/mingw/opt/inclu=
de PREFIX=3D$HOME/mingw/opt LZO_CFLAGS=3D-I$HOME/mingw/opt/include LZO_LIBS=
=3D"-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=3D${CHOST} --disabl=
e-lz4
> >          working-directory: openvpn
>
> This, I think, is clear - "--enable-dco is default for windows builds",
> and maybe also "no DCO_SOURCEDIR neccesary anymore, since ovpn_dco_win.h
> is now part of our tree", right?

Yep.

-Lev

