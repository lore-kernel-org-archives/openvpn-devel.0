MIME-Version: 1.0
In-Reply-To: <1448705029-9062-1-git-send-email-steffan@...1856...>
References: <1448705029-9062-1-git-send-email-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 29 Nov 2015 00:29:14 -0500
Message-ID: <CAKuzo_h10E+5UfjZDuvRQADeTuryG+meropr=uXt6L90DvPwOA@...278...>
Content-Type: multipart/alternative; boundary=089e01176623a6b5130525a735d5
Subject: Re: [Openvpn-devel] [PATCH] Support duplicate x509 field values in
	environment
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

--089e01176623a6b5130525a735d5
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat, Nov 28, 2015 at 5:03 AM, Steffan Karger <steffan@...1856...> wrote:

> As reported in trac #387, an x509 DN can contain duplicate fields.
> Previously, we would overwrite any previous field value with a new one if
> we would process a second same-name field.  Now, instead, append _$N,
> starting at N=1 to the name for each consequent field to export all fields
> to the enviroment.
>

A useful change and clean code. A couple of places could benefit from const
qualifiers, though:

--- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -607,6 +607,16 @@ env_set_add (struct env_set *es, const char *str)
>    env_set_add_nolock (es, str);
>  }
>
> +const char*
> +env_set_get (struct env_set *es, const char *name)
>

... (const struct env_set *es,....   )      <to be matched in misc.h>

+{
> +  struct env_item *item = es->list;
>

const struct env_item *item = ...

+  while (item && !envstring_equal(item->string, name)) {
> +      item = item->next;
> +  }
> +  return item ? item->string : NULL;
> +}
>

Thanks,

Selva

--089e01176623a6b5130525a735d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Sat, Nov 28, 2015 at 5:03 AM, St=
effan Karger <span dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856..." ta=
rget=3D"_blank">steffan@...1856...</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div style=3D"overflow:hidden">As report=
ed in trac #387, an x509 DN can contain duplicate fields.<br>
Previously, we would overwrite any previous field value with a new one if<b=
r>
we would process a second same-name field.=C2=A0 Now, instead, append _$N,<=
br>
starting at N=3D1 to the name for each consequent field to export all field=
s<br>
to the enviroment.</div></blockquote></div><br></div><div class=3D"gmail_ex=
tra">A useful change and clean code. A couple of places could benefit from =
const qualifiers, though:<br><br><blockquote style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail=
_quote">--- a/src/openvpn/misc.c<br>
+++ b/src/openvpn/misc.c<br>
@@ -607,6 +607,16 @@ env_set_add (struct env_set *es, const char *str)<br>
=C2=A0 =C2=A0env_set_add_nolock (es, str);<br>
=C2=A0}<br><br>+const char*<br>
+env_set_get (struct env_set *es, const char *name)<br></blockquote>
<br></div><div class=3D"gmail_extra">... (const struct env_set *es,.... =C2=
=A0 )=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &lt;to be matched in misc.h&gt;<br><br>=
</div><div class=3D"gmail_extra"><blockquote style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail=
_quote">+{<br>
+=C2=A0 struct env_item *item =3D es-&gt;list;<br></blockquote>
<br>const struct env_item *item =3D ...<br><br><blockquote style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" =
class=3D"gmail_quote">+=C2=A0 while (item &amp;&amp; !envstring_equal(item-=
&gt;string, name)) {<br>
+=C2=A0 =C2=A0 =C2=A0 item =3D item-&gt;next;<br>
+=C2=A0 }<br>
+=C2=A0 return item ? item-&gt;string : NULL;<br>
+}<br></blockquote><br></div><div class=3D"gmail_extra">Thanks,<br><br></di=
v><div class=3D"gmail_extra">Selva<br></div></div>

--089e01176623a6b5130525a735d5--

