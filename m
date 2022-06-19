MIME-Version: 1.0
References: <20210930113308.815777-1-mkh199740@...450...>
In-Reply-To: <20210930113308.815777-1-mkh199740@...450...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 19 Jun 2022 13:28:58 -0400
Message-ID: <CAKuzo_iWaTiKSeiTVrqkLfbPLp+ScvGm_m8stEUNOzunobXVUg@...278...>
Content-Type: multipart/alternative; boundary="000000000000a2e2d305e1d053fe"
Subject: Re: [Openvpn-devel] [PATCH] Add ability to specify initialize flags
 for pkcs11 provider
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Petr Mikhalicin <mkh199740@...450...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a2e2d305e1d053fe
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Sep 30, 2021 at 7:34 AM Petr Mikhalicin via Openvpn-devel <
openvpn-devel@lists.sourceforge.net> wrote:

> New pkcs11-helper interface allows to setup pkcs11 provider via
> properties:
> https://github.com/alonbl/pkcs11-helper/commit/b78d21c7e26041746aa4ae3d08b95469e1714a85
>
> Also pkcs11-helper added ability to setup init args for pkcs11 provider:
>
> https://github.com/alonbl/pkcs11-helper/commit/133f893e30856eba1de715ecd6fe176722eb3097
>
> Signed-off-by: Petr Mikhalicin <mkh199740@...450...>
>

Sorry for the long delay in getting back on this. I somehow also missed the
related discussion on Trac (
https://community.openvpn.net/openvpn/ticket/1453)

I don't quite understand the need for exposing "init-args" to the user. The
only two supported flags in the cryptoki docs are related to the use of
threads. But we are the application and we should know what flags to pass
--- not the user --- isn't it? If CKF_OS_LOCKING_OK is required, can't we
just set it unconditionally?

That said, OpenVPN2 is single threaded, so why is there a "bug in openvpn"
related to the use of pkcs11 library from multiple threads referred to in
the trac ticket?

Selva

--000000000000a2e2d305e1d053fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 30, 2021 at 7:34 AM Petr M=
ikhalicin via Openvpn-devel &lt;<a href=3D"mailto:openvpn-devel@...1011...=
eforge.net" target=3D"_blank">openvpn-devel@lists.sourceforge.net</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">New pkcs11=
-helper interface allows to setup pkcs11 provider via<br>
properties: <a href=3D"https://github.com/alonbl/pkcs11-helper/commit/b78d2=
1c7e26041746aa4ae3d08b95469e1714a85" rel=3D"noreferrer" target=3D"_blank">h=
ttps://github.com/alonbl/pkcs11-helper/commit/b78d21c7e26041746aa4ae3d08b95=
469e1714a85</a><br>
<br>
Also pkcs11-helper added ability to setup init args for pkcs11 provider:<br>
<a href=3D"https://github.com/alonbl/pkcs11-helper/commit/133f893e30856eba1=
de715ecd6fe176722eb3097" rel=3D"noreferrer" target=3D"_blank">https://githu=
b.com/alonbl/pkcs11-helper/commit/133f893e30856eba1de715ecd6fe176722eb3097<=
/a><br>
<br>
Signed-off-by: Petr Mikhalicin &lt;<a href=3D"mailto:mkh199740@...450..." t=
arget=3D"_blank">mkh199740@...450...</a>&gt;<br></blockquote><div><br></div=
><div>Sorry for the long delay in getting back on this. I somehow also miss=
ed the related discussion on Trac (<a href=3D"https://community.openvpn.net=
/openvpn/ticket/1453" target=3D"_blank">https://community.openvpn.net/openv=
pn/ticket/1453</a>)</div><div><br></div><div>I don&#39;t quite understand t=
he need for exposing &quot;init-args&quot; to the user. The only two suppor=
ted flags in the cryptoki docs are related to the use of threads. But we ar=
e the application and we should know what flags to pass --- not the user --=
- isn&#39;t it? If CKF_OS_LOCKING_OK is required, can&#39;t we just set it =
unconditionally?=C2=A0</div><div><br></div><div>That said, OpenVPN2 is sing=
le threaded, so why is there=C2=A0a &quot;bug in openvpn&quot; related to t=
he use of pkcs11 library from multiple threads referred to in the trac tick=
et?</div><div><br></div><div>Selva</div></div></div>

--000000000000a2e2d305e1d053fe--

