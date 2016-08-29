MIME-Version: 1.0
In-Reply-To: <CAHX+n4s+yo18TiCS_G2xLcbRwSh9Ox2vdmS+2c5MJJmaHEsTnQ@...278...>
References: <CAHX+n4s+yo18TiCS_G2xLcbRwSh9Ox2vdmS+2c5MJJmaHEsTnQ@...278...>
From: Bojan Komazec <bojan.komazec@...277...>
Date: Mon, 29 Aug 2016 09:05:56 +0100
Message-ID: <CAHX+n4t4oBqvL7Jee7hjRAp13VKHcHjXw+=AP=6nXXLyjsVqBA@...278...>
Content-Type: multipart/alternative; boundary=089e0102e0b681121f053b3155b7
Subject: Re: [Openvpn-devel] [PATCH (master)] Updated build parameters to
	match openvpn-install-2.3.12-I601
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--089e0102e0b681121f053b3155b7
Content-Type: text/plain; charset=UTF-8

This is my first attempt to contribute to OpenVpn project. Please let me
know if I am doing it right.

Thanks,
Bojan

On Sun, Aug 28, 2016 at 9:18 PM, Bojan Komazec <bojan.komazec@...277...>
wrote:

> OpenVPN/openvpn-build has to be updated so it fetches and builds OpenVpn
> v2.3.12.
>
> From 87a0ca6307ea9c772fc5fa584efc2f2f0f3805a8 Mon Sep 17 00:00:00 2001
> From: Bojan Komazec <bojan.komazec@...277...>
> Date: Sun, 28 Aug 2016 20:49:02 +0100
> Subject: [PATCH] Updated build parameters to match
> openvpn-install-2.3.12-I601
>
> Signed-off-by: Bojan Komazec <bojan.komazec@...277...>
> ---
>  generic/build.vars | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/generic/build.vars b/generic/build.vars
> index ed93a0b..9d44d06 100644
> --- a/generic/build.vars
> +++ b/generic/build.vars
> @@ -5,7 +5,7 @@ OPENSSL_VERSION="${OPENSSL_VERSION:-1.0.1t}"
>  PKCS11_HELPER_VERSION="${PKCS11_HELPER_VERSION:-1.11}"
>  LZO_VERSION="${LZO_VERSION:-2.09}"
>  TAP_WINDOWS_VERSION="${TAP_WINDOWS_VERSION:-9.21.2}"
> -OPENVPN_VERSION="${OPENVPN_VERSION:-2.3.11}"
> +OPENVPN_VERSION="${OPENVPN_VERSION:-2.3.12}"
>  OPENVPN_GUI_VERSION="${OPENVPN_GUI_VERSION:-10}"
>
>  OPENSSL_URL="${OPENSSL_URL:-http://www.openssl.org/source/
> openssl-${OPENSSL_VERSION}.tar.gz}"
> --
> 2.9.2.windows.1
>

--089e0102e0b681121f053b3155b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This is my first attempt to contribute to OpenVpn project.=
 Please let me know if I am doing it right.<div><br></div><div>Thanks,</div=
><div>Bojan</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Sun, Aug 28, 2016 at 9:18 PM, Bojan Komazec <span dir=3D"ltr">&lt;=
<a href=3D"mailto:bojan.komazec@...277..." target=3D"_blank">bojan.komazec@=
...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=
=3D"ltr">OpenVPN/openvpn-build has to be updated so it fetches and builds O=
penVpn v2.3.12.<div><br></div><div><div>From 87a0ca6307ea9c772fc5fa584efc2f=
<wbr>2f0f3805a8 Mon Sep 17 00:00:00 2001</div><div>From: Bojan Komazec &lt;=
<a href=3D"mailto:bojan.komazec@...277..." target=3D"_blank">bojan.komazec@=
...277...</a>&gt;</div><div>Date: Sun, 28 Aug 2016 20:49:02 +0100</div><div=
>Subject: [PATCH] Updated build parameters to match openvpn-install-2.3.12-=
I601</div><div><br></div><div>Signed-off-by: Bojan Komazec &lt;<a href=3D"m=
ailto:bojan.komazec@...277..." target=3D"_blank">bojan.komazec@...277...</a=
>&gt;</div><div>---</div><div>=C2=A0generic/build.vars | 2 +-</div><div>=C2=
=A01 file changed, 1 insertion(+), 1 deletion(-)</div><div><br></div><div>d=
iff --git a/generic/build.vars b/generic/build.vars</div><div>index ed93a0b=
..9d44d06 100644</div><div>--- a/generic/build.vars</div><div>+++ b/generic=
/build.vars</div><div>@@ -5,7 +5,7 @@ OPENSSL_VERSION=3D&quot;${OPENSSL_<wb=
r>VERSION:-1.0.1t}&quot;</div><div>=C2=A0PKCS11_HELPER_VERSION=3D&quot;${<w=
br>PKCS11_HELPER_VERSION:-1.11}&quot;</div><div>=C2=A0LZO_VERSION=3D&quot;$=
{LZO_VERSION:-<wbr>2.09}&quot;</div><div>=C2=A0TAP_WINDOWS_VERSION=3D&quot;=
${TAP_<wbr>WINDOWS_VERSION:-9.21.2}&quot;</div><div>-OPENVPN_VERSION=3D&quo=
t;${OPENVPN_<wbr>VERSION:-2.3.11}&quot;</div><div>+OPENVPN_VERSION=3D&quot;=
${OPENVPN_<wbr>VERSION:-2.3.12}&quot;</div><div>=C2=A0OPENVPN_GUI_VERSION=
=3D&quot;${<wbr>OPENVPN_GUI_VERSION:-10}&quot;</div><div>=C2=A0</div><div>=
=C2=A0OPENSSL_URL=3D&quot;${OPENSSL_URL:-<a href=3D"http://www.openssl.org/=
source/openssl-$%7BOPENSSL_VERSION%7D.tar.gz" target=3D"_blank">h<wbr>ttp:/=
/www.openssl.org/source/<wbr>openssl-${OPENSSL_VERSION}.<wbr>tar.gz</a>}&qu=
ot;</div><span class=3D"HOEnZb"><font color=3D"#888888"><div>--=C2=A0</div>=
<div>2.9.2.windows.1</div></font></span></div></div>
</blockquote></div><br></div>

--089e0102e0b681121f053b3155b7--

