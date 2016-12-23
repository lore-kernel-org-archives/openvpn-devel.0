MIME-Version: 1.0
In-Reply-To: <1482524791-5788-1-git-send-email-steffan@...1856...>
References: <1482524791-5788-1-git-send-email-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 23 Dec 2016 16:23:48 -0500
Message-ID: <CAKuzo_jKfWW0TA2TUzFhPFOQa6JjtfDNpiAStTUp4vyT+7yOOw@...278...>
Content-Type: multipart/alternative; boundary=001a113a3162a13c1705445a019c
Subject: Re: [Openvpn-devel] [PATCH] Add nl_for_brace=add to uncrustify.conf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113a3162a13c1705445a019c
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 23, 2016 at 3:26 PM, Steffan Karger <steffan@...1856...> wrote:

> diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
> index 95e0b2a..3745ed0 100644
> --- a/dev-tools/uncrustify.conf
> +++ b/dev-tools/uncrustify.conf
> @@ -9,6 +9,7 @@ nl_brace_else=add
>  nl_elseif_brace=add
>  nl_else_brace=add
>  nl_else_if=remove
> +nl_for_brace=add
>

What about

nl_switch_brace = add
nl_while_brace = add
nl_fdef_brace = add

These are not optional as per the style, are they?

nl_after_semicolon
(I know no one here writes x=1; y=2; z= 3; on the same line,
but assuming we do not want such usage in patches....)

Selva

--001a113a3162a13c1705445a019c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Dec 23, 2016 at 3:26 PM, Steffan Karger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D"m_-5743082639=
610600438m_-2907758932460943629:2g4" class=3D"m_-5743082639610600438m_-2907=
758932460943629a3s m_-5743082639610600438m_-2907758932460943629aXjCH m_-574=
3082639610600438m_-2907758932460943629m1592d5eec29d5138">diff --git a/dev-t=
ools/uncrustify.conf b/dev-tools/uncrustify.conf<br>
index 95e0b2a..3745ed0 100644<br>
--- a/dev-tools/uncrustify.conf<br>
+++ b/dev-tools/uncrustify.conf<br>
@@ -9,6 +9,7 @@ nl_brace_else=3Dadd<br>
=C2=A0nl_elseif_brace=3Dadd<br>
=C2=A0nl_else_brace=3Dadd<br>
=C2=A0nl_else_if=3Dremove<br>
+nl_for_brace=3Dadd</div></blockquote></div><br>What about=C2=A0</div><div =
class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">nl_switch_brace =
=3D add</div><div class=3D"gmail_extra">nl_while_brace =3D add</div><div cl=
ass=3D"gmail_extra">nl_fdef_brace =3D add</div><div class=3D"gmail_extra"><=
br></div><div class=3D"gmail_extra">These are not optional as per the style=
, are they?</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_e=
xtra">nl_after_semicolon=C2=A0</div><div class=3D"gmail_extra">(I know no o=
ne here writes x=3D1; y=3D2; z=3D 3; on the same line,=C2=A0</div><div clas=
s=3D"gmail_extra">but assuming we do not want such usage in patches....)</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</d=
iv></div>

--001a113a3162a13c1705445a019c--

