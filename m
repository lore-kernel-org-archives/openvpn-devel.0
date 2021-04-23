MIME-Version: 1.0
References: <20210421080016.110-1-lstipakov@...277...>
In-Reply-To: <20210421080016.110-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 23 Apr 2021 00:13:11 -0400
Message-ID: <CAKuzo_hxBKp8GahnETu6+DHM2q3U2edcUcqqfkzv3KdVFRCa-Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000009277f505c09c040d"
Subject: Re: [Openvpn-devel] [PATCH] tapctl: support for ovpn-dco Windows
 driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--0000000000009277f505c09c040d
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Apr 21, 2021 at 4:02 AM Lev Stipakov <lstipakov@...277...> wrote:

> From: Lev Stipakov <lev@...515...>
>
> Make tapctl aware of ovpn-dco.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/tapctl/main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/src/tapctl/main.c b/src/tapctl/main.c
> index d5bc7290..3350bf1f 100644
> --- a/src/tapctl/main.c
> +++ b/src/tapctl/main.c
> @@ -81,9 +81,9 @@ static const TCHAR usage_message_create[] =
>      TEXT("               specified, a default adapter name is chosen by
> Windows.         \n")
>      TEXT("               Note: This name can also be specified as
> OpenVPN's --dev-node   \n")
>      TEXT("               option.
>                \n")
> -    TEXT("--hwid <hwid>  Adapter hardware ID. Default value is
> root\\tap0901, which       \n")
> -    TEXT("               describes tap-windows6 driver. To work with
> wintun driver,      \n")
> -    TEXT("               specify 'wintun'.
>                \n")
> +    TEXT("--hwid <hwid>  Adapter hardware ID. Default value is
> root\\tap0901, which      \n")
> +    TEXT("               describes tap-windows6 driver. To work with
> wintun or ovpn-dco  \n")
> +    TEXT("               driver, specify 'wintun' or 'ovpn-dco'.
>                \n")
>      TEXT("\n")
>      TEXT("Output:\n")
>      TEXT("\n")
> @@ -101,8 +101,8 @@ static const TCHAR usage_message_list[] =
>      TEXT("\n")
>      TEXT("Options:\n")
>      TEXT("\n")
> -    TEXT("--hwid <hwid>  Adapter hardware ID. By default, root\\tap0901,
> tap0901 and      \n")
> -    TEXT("               wintun adapters are listed. Use this switch to
> limit the list.  \n")
> +    TEXT("--hwid <hwid>  Adapter hardware ID. By default, root\\tap0901,
> tap0901, wintun and \n")
> +    TEXT("               ovpn-dco adapters are listed. Use this switch to
> limit the list.\n")
>      TEXT("\n")
>      TEXT("Output:\n")
>      TEXT("\n")
> @@ -275,7 +275,8 @@ create_delete_adapter:
>          TCHAR szzHwId[0x100] =
>              TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0")
>              TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0")
> -            TEXT("Wintun\0");
> +            TEXT("Wintun\0")
> +            TEXT("ovpn-dco\0");
>
>          /* Parse options. */
>          for (int i = 2; i < argc; i++)
>

Looks good, assuming ovpn-dco is the correct hwid for the new driver.

Acked-by: selva.nair@...277...

--0000000000009277f505c09c040d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 21, 2021 at 4:02 AM Lev St=
ipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank">lev@...493...=
515...</a>&gt;<br>
<br>
Make tapctl aware of ovpn-dco.<br>
<br>
Signed-off-by: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"=
_blank">lev@...515...</a>&gt;<br>
---<br>
=C2=A0src/tapctl/main.c | 13 +++++++------<br>
=C2=A01 file changed, 7 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/src/tapctl/main.c b/src/tapctl/main.c<br>
index d5bc7290..3350bf1f 100644<br>
--- a/src/tapctl/main.c<br>
+++ b/src/tapctl/main.c<br>
@@ -81,9 +81,9 @@ static const TCHAR usage_message_create[] =3D<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0specified, a default adapter name is chosen by Windows.=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\n&quot;)<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0Note: This name can also be specified as OpenVPN&#39;s --dev-n=
ode=C2=A0 =C2=A0\n&quot;)<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0option.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\n=
&quot;)<br>
-=C2=A0 =C2=A0 TEXT(&quot;--hwid &lt;hwid&gt;=C2=A0 Adapter hardware ID. De=
fault value is root\\tap0901, which=C2=A0 =C2=A0 =C2=A0 =C2=A0\n&quot;)<br>
-=C2=A0 =C2=A0 TEXT(&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0describes tap-windows6 driver. To work with wintun driver,=C2=A0 =C2=
=A0 =C2=A0 \n&quot;)<br>
-=C2=A0 =C2=A0 TEXT(&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0specify &#39;wintun&#39;.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\n&quot;)<br>
+=C2=A0 =C2=A0 TEXT(&quot;--hwid &lt;hwid&gt;=C2=A0 Adapter hardware ID. De=
fault value is root\\tap0901, which=C2=A0 =C2=A0 =C2=A0 \n&quot;)<br>
+=C2=A0 =C2=A0 TEXT(&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0describes tap-windows6 driver. To work with wintun or ovpn-dco=C2=A0 =
\n&quot;)<br>
+=C2=A0 =C2=A0 TEXT(&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0driver, specify &#39;wintun&#39; or &#39;ovpn-dco&#39;.=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0\n&quot;)<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;\n&quot;)<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;Output:\n&quot;)<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;\n&quot;)<br>
@@ -101,8 +101,8 @@ static const TCHAR usage_message_list[] =3D<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;\n&quot;)<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;Options:\n&quot;)<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;\n&quot;)<br>
-=C2=A0 =C2=A0 TEXT(&quot;--hwid &lt;hwid&gt;=C2=A0 Adapter hardware ID. By=
 default, root\\tap0901, tap0901 and=C2=A0 =C2=A0 =C2=A0 \n&quot;)<br>
-=C2=A0 =C2=A0 TEXT(&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0wintun adapters are listed. Use this switch to limit the list.=C2=A0 =
\n&quot;)<br>
+=C2=A0 =C2=A0 TEXT(&quot;--hwid &lt;hwid&gt;=C2=A0 Adapter hardware ID. By=
 default, root\\tap0901, tap0901, wintun and \n&quot;)<br>
+=C2=A0 =C2=A0 TEXT(&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ovpn-dco adapters are listed. Use this switch to limit the list.\n&qu=
ot;)<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;\n&quot;)<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;Output:\n&quot;)<br>
=C2=A0 =C2=A0 =C2=A0TEXT(&quot;\n&quot;)<br>
@@ -275,7 +275,8 @@ create_delete_adapter:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCHAR szzHwId[0x100] =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEXT(&quot;root\\&quot;) TE=
XT(TAP_WIN_COMPONENT_ID) TEXT(&quot;\0&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEXT(TAP_WIN_COMPONENT_ID) =
TEXT(&quot;\0&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TEXT(&quot;Wintun\0&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TEXT(&quot;Wintun\0&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TEXT(&quot;ovpn-dco\0&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Parse options. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 2; i &lt; argc; i++)<br></=
blockquote><div><br></div><div>Looks good, assuming ovpn-dco is the correct=
 hwid for the new driver.</div><div><br></div><div>Acked-by: <a href=3D"mai=
lto:selva.nair@...277...">selva.nair@...277...</a></div></div></div>

--0000000000009277f505c09c040d--

