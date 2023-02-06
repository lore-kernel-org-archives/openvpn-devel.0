MIME-Version: 1.0
References: <20230203165529.125771-1-frank@...2641...>
 <20230206112218.51430-1-frank@...2641...>
In-Reply-To: <20230206112218.51430-1-frank@...2641...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 6 Feb 2023 13:16:18 -0500
Message-ID: <CAKuzo_i6FhU_k9soY_s9QNifJt+12cx5uZuUJ2EuTacvPrBLLA@...278...>
Content-Type: multipart/alternative; boundary="00000000000001895b05f40c0867"
Subject: Re: [Openvpn-devel] [PATCH v2] configure: enable DCO by default on
 FreeBSD/Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000001895b05f40c0867
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Feb 6, 2023 at 6:24 AM Frank Lichtenheld <frank@...2641...>
wrote:

> Automatically disabled when
> - iproute2 is enabled
>   (Don't want to force people specifying --disable-dco explicitely)
> - libnv is missing on FreeBSD
>   (FreeBSD version too old anyway)
>
> Will still error out if libnl-genl is missing on Linux to
> make people aware of new dependency.
>
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  configure.ac | 78 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 61 insertions(+), 17 deletions(-)
>
> v2: error out when libnl-genl is missing as discussed with ordex on
>     IRC.
>
>
> diff --git a/configure.ac b/configure.ac
> index 91500087..acfa4bc1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -144,14 +144,27 @@ AC_ARG_ENABLE(
>
>  AC_ARG_ENABLE(
>         [dco],
> -       [AS_HELP_STRING([--enable-dco], [enable data channel offload
> support using the ovpn-dco kernel module (always enabled on Windows)
> @<:@default=no@:>@])],
> +       [AS_HELP_STRING([--disable-dco], [enable data channel offload
> support using the ovpn-dco kernel module (always enabled on Windows)
> @<:@default=yes@:>@])],
>

The help string should be
"disable data channel offload support ..." instead of "enable data channel
offload ..." as it's now prefixed with "--disable-dco" .

The "default=yes" in this case may be better written as "default=auto" (or
"platform specific") but it's not critical. Here, default always refers to
the "--enable-FEATURE" form of the option. Confusing but consistent with
how other options are described.

We could be more helpful by describing both enable and disable forms of all
options, as well as custom args that the enable form takes (if any), but
that's beyond the scope of this patch.

-if test "$enable_dco" = "yes"; then
> +if test "$enable_dco" != "no"; then
> +       enable_dco_arg="$enable_dco"
> +       if test "${enable_iproute2}" = "yes"; then
> +               AC_MSG_WARN([iproute2 support cannot be enabled when using
> DCO])
>

This is mildly misleading as here iproute2 is going to win over DCO but the
message appears to indicate otherwise. It would result in outputs like:

WARNING: iproute2 support cannot be enabled when using DCO
WARNING: DCO support disabled
(or in an error)

Phrasing the first as "DCO cannot be enabled when using iproute2" would be
better.


> +               enable_dco="no"
> +       fi
> +       case "$host" in
> +               *-*-linux*)


I'll defer to those who understand DCO better to ACK the technical part.

Selva

--00000000000001895b05f40c0867
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 6, 2023 at 6:24 AM Fra=
nk Lichtenheld &lt;<a href=3D"mailto:frank@...2641..." target=3D"_blank">fr=
ank@...2641...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Automatically disabled when<br>
- iproute2 is enabled<br>
=C2=A0 (Don&#39;t want to force people specifying --disable-dco explicitely=
)<br>
- libnv is missing on FreeBSD<br>
=C2=A0 (FreeBSD version too old anyway)<br>
<br>
Will still error out if libnl-genl is missing on Linux to<br>
make people aware of new dependency.<br>
<br>
Signed-off-by: Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641..." ta=
rget=3D"_blank">frank@...2641...</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a> | 78 ++++++++++++++++++++++++++++++++++++++++------------<=
br>
=C2=A01 file changed, 61 insertions(+), 17 deletions(-)<br>
<br>
v2: error out when libnl-genl is missing as discussed with ordex on<br>
=C2=A0 =C2=A0 IRC.<br>
<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 91500087..acfa4bc1 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -144,14 +144,27 @@ AC_ARG_ENABLE(<br>
<br>
=C2=A0AC_ARG_ENABLE(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [dco],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0[AS_HELP_STRING([--enable-dco], [enable data ch=
annel offload support using the ovpn-dco kernel module (always enabled on W=
indows) @&lt;:@default=3Dno@:&gt;@])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[AS_HELP_STRING([--disable-dco], [enable data c=
hannel offload support using the ovpn-dco kernel module (always enabled on =
Windows) @&lt;:@default=3Dyes@:&gt;@])],<br></blockquote><div><br></div><di=
v>The help string should be</div><div>&quot;disable data channel offload su=
pport ...&quot; instead of &quot;enable data channel offload ...&quot; as i=
t&#39;s now prefixed with &quot;--disable-dco&quot; .=C2=A0</div><div><br><=
/div><div>The &quot;default=3Dyes&quot; in this case may be better written =
as &quot;default=3Dauto&quot; (or &quot;platform specific&quot;) but it&#39=
;s not critical. Here, default always refers to the &quot;--enable-FEATURE&=
quot; form of the option. Confusing but consistent with how other options a=
re described.=C2=A0</div><div><br></div><div>We could be more helpful by de=
scribing both enable and disable forms of all options, as well as custom ar=
gs that the enable form takes (if any), but that&#39;s beyond the scope of =
this patch.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><span style=3D"color:rgb(80,0,80)">-if test &quot;$enable_dco&quot; =
=3D &quot;yes&quot;; then<br></span><span style=3D"color:rgb(80,0,80)">+if =
test &quot;$enable_dco&quot; !=3D &quot;no&quot;; then<br></span><span styl=
e=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0enable_dco_arg=3D&quot=
;$enable_dco&quot;<br></span><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0if test &quot;${enable_iproute2}&quot; =3D &quot;yes&quot;=
; then<br></span><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AC_MSG_WARN([iproute2 support cannot be e=
nabled when using DCO])<br></span></blockquote><div><br></div><div>This is =
mildly misleading as here iproute2 is going to win over DCO but the message=
 appears to indicate otherwise. It would result in outputs like:</div><div>=
<br></div><div>WARNING: iproute2 support cannot be enabled when using DCO<b=
r>WARNING: DCO support disabled<br></div><div>(or in an error)</div><div><b=
r></div><div>Phrasing the first as &quot;DCO cannot be enabled when using i=
proute2&quot; would be better.</div><div>=C2=A0=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><span style=3D"color:rgb(80,0,80)"></span=
><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0enable_dco=3D&quot;no&quot;<br></span><span style=3D"color=
:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br></span><span style=3D"colo=
r:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0case &quot;$host&quot; in<br></=
span><span style=3D"color:rgb(80,0,80)">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0*-*-linux*)</span></blockquote><div>=C2=A0</div><div>I=
&#39;ll defer to those who understand DCO better to ACK the technical part.=
</div><div><br></div><div>Selva</div></div></div></div>

--00000000000001895b05f40c0867--

