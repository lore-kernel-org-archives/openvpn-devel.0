MIME-Version: 1.0
In-Reply-To: <20171010231130.6832-2-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-2-simon@...2293...>
From: Selva <selva.nair@...277...>
Date: Wed, 11 Oct 2017 09:46:04 -0400
Message-ID: <CAKuzo_hd1VFOhL1X6Yppoo+cLBMyFFdDF7c92sTKQGmP-mrZ5g@...278...>
Content-Type: multipart/alternative; boundary="001a1144b308587dc0055b45a665"
Subject: Re: [Openvpn-devel] [PATCH 02/13] Mixing wide and regular strings
 in concatenations is not allowed in MSVC.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1144b308587dc0055b45a665
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Oct 10, 2017 at 7:11 PM, <simon@...2293...> wrote:

> From: Simon Rozman <simon@...2293...>
>
> ---
>  src/openvpnserv/interactive.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 9d473e4..4b08086 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -370,12 +370,12 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir,
> const WCHAR *options)
>      BOOL ret = FALSE;
>      int i;
>      const WCHAR *msg1 = L"You have specified a config file location (%s
> relative to %s)"
> -                        " that requires admin approval. This error may be
> avoided"
> -                        " by adding your account to the \"%s\" group";
> +                        L" that requires admin approval. This error may
> be avoided"
> +                        L" by adding your account to the \"%s\" group";
>
>      const WCHAR *msg2 = L"You have specified an option (%s) that may be
> used"
> -                        " only with admin approval. This error may be
> avoided"
> -                        " by adding your account to the \"%s\" group";
> +                        L" only with admin approval. This error may be
> avoided"
> +                        L" by adding your account to the \"%s\" group";
>
>      argv = CommandLineToArgvW(options, &argc);
>

This one is easy, though the original is valid C99, MSVC does not support
concatenating non-identically prefixed strings.

ACK.

--001a1144b308587dc0055b45a665
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Oct 10, 2017 at 7:11 PM,  <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simo=
n@...2293...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: =
Simon Rozman &lt;<a href=3D"mailto:simon@...2293..." target=3D"_blank">simo=
n@...2293...</a>&gt;<br>
<br>
---<br>
=C2=A0src/openvpnserv/interactive.c | 8 ++++----<br>
=C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/src/openvpnserv/interactive.<wbr>c b/src/openvpnserv/interacti=
ve.<wbr>c<br>
index 9d473e4..4b08086 100644<br>
--- a/src/openvpnserv/interactive.<wbr>c<br>
+++ b/src/openvpnserv/interactive.<wbr>c<br>
@@ -370,12 +370,12 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, co=
nst WCHAR *options)<br>
=C2=A0 =C2=A0 =C2=A0BOOL ret =3D FALSE;<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0const WCHAR *msg1 =3D L&quot;You have specified a confi=
g file location (%s relative to %s)&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot; that requires admin approval. This error may be avoided&q=
uot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot; by adding your account to the \&quot;%s\&quot; group&quot=
;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 L&quot; that requires admin approval. This error may be avoided&=
quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 L&quot; by adding your account to the \&quot;%s\&quot; group&quo=
t;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0const WCHAR *msg2 =3D L&quot;You have specified an opti=
on (%s) that may be used&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot; only with admin approval. This error may be avoided&quot;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot; by adding your account to the \&quot;%s\&quot; group&quot=
;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 L&quot; only with admin approval. This error may be avoided&quot=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 L&quot; by adding your account to the \&quot;%s\&quot; group&quo=
t;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0argv =3D CommandLineToArgvW(options, &amp;argc);<br></b=
lockquote><div><br></div><div>This one is easy, though the original is vali=
d C99, MSVC does not support concatenating non-identically prefixed strings=
.</div><div><br></div><div>ACK.</div><div><br></div></div></div></div>

--001a1144b308587dc0055b45a665--

