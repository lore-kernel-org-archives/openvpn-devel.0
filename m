MIME-Version: 1.0
In-Reply-To: <1474573258-25420-2-git-send-email-davids@...515...>
References: <1474573258-25420-1-git-send-email-davids@...515...>
	<1474573258-25420-2-git-send-email-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 22 Sep 2016 16:51:14 -0400
Message-ID: <CAKuzo_iHjBzeEELJoGwpR_V8_tHdL9WMpVjxNiPPC1FMCvPQEw@...278...>
Content-Type: multipart/alternative; boundary=001a1145711cc9eadd053d1ed30b
Subject: Re: [Openvpn-devel] [PATCH] Remove static global allocation of HTTP
 proxy user/passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1145711cc9eadd053d1ed30b
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Sep 22, 2016 at 3:40 PM, David Sommerseth <davids@...515...>
wrote:

> This avoids allocating static memory which is not used unless the
> a HTTP proxy with authentication is configured.


.....

The only place the original code referred to the global
static_proxy_user_pass appears to be in this function and from its usage it
appears redundant.

 static void
>  get_user_pass_http (struct http_proxy_info *p, const bool force)
>  {
> -  if (!static_proxy_user_pass.defined || force)
> +  if (!proxy_user_pass_cache || !proxy_user_pass_cache->defined|| force)
>      {
>        unsigned int flags = GET_USER_PASS_MANAGEMENT;
> +
> +      if (!proxy_user_pass_cache)
> +        {
> +          ALLOC_OBJ_CLEAR (proxy_user_pass_cache, struct user_pass);
> +        }
> +      else
> +        {
> +          CLEAR (*proxy_user_pass_cache);
> +        }
> +
>        if (p->queried_creds)
>         flags |= GET_USER_PASS_PREVIOUS_CREDS_FAILED;
>        if (p->options.inline_creds)
>         flags |= GET_USER_PASS_INLINE_CREDS;
> -      get_user_pass (&static_proxy_user_pass,
> +      get_user_pass (proxy_user_pass_cache,
>                      p->options.auth_file,
>                      UP_TYPE_PROXY,
>                      flags);
>        p->queried_creds = true;
> -      p->up = static_proxy_user_pass;
>

A copy of the struct is made only when a new password is obtained using
get_user_pass. Then, what was the purpose of the static? Or was it a bug
that the copy of the cached password was not made every time this function
was called? If not, we can just delete the static and use p->up directly.

     }
> +  p->up = proxy_user_pass_cache;
>  }
>

Selva

--001a1145711cc9eadd053d1ed30b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Sep 22, 2016 at 3:40 PM, David =
Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:davids@...515..." target=
=3D"_blank">davids@...515...</a>&gt;</span> wrote:</div><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-style=
:solid;padding-left:1ex">This avoids allocating static memory which is not =
used unless the<br>a HTTP proxy with authentication is configured.</blockqu=
ote></div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">.=
....</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">T=
he only place the original code referred to the global static_proxy_user_pa=
ss appears to be in this function and from its usage it appears redundant.<=
/div><div class=3D"gmail_quote"><br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex"><div>=C2=A0static void=
<br>
=C2=A0get_user_pass_http (struct http_proxy_info *p, const bool force)<br>
=C2=A0{<br>
-=C2=A0 if (!static_proxy_user_pass.defin<wbr>ed || force)<br>
+=C2=A0 if (!proxy_user_pass_cache || !proxy_user_pass_cache-&gt;define<wbr=
>d|| force)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int flags =3D GET_USER_PASS_MANAGEMENT;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 if (!proxy_user_pass_cache)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ALLOC_OBJ_CLEAR (proxy_user_pass_cache,=
 struct user_pass);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CLEAR (*proxy_user_pass_cache);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-&gt;queried_creds)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D GET_USER_PASS_PREVIOUS_CREDS_F<wbr>A=
ILED;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-&gt;options.inline_creds)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D GET_USER_PASS_INLINE_CREDS;<br>
-=C2=A0 =C2=A0 =C2=A0 get_user_pass (&amp;static_proxy_user_pass,<br>
+=C2=A0 =C2=A0 =C2=A0 get_user_pass (proxy_user_pass_cache,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0p-&gt;options.auth_file,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0UP_TYPE_PROXY,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0flags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;queried_creds =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 p-&gt;up =3D static_proxy_user_pass;<br></div></block=
quote><div><br></div><div>A copy of the struct is made only when a new pass=
word is obtained using get_user_pass. Then, what was the purpose of the sta=
tic? Or was it a bug that the copy of the cached password was not made ever=
y time this function was called? If not, we can just delete the static and =
use p-&gt;up directly.</div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color=
:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 p-&gt;up =3D proxy_user_pass_cache;<br>
=C2=A0}</div></blockquote></div><div class=3D"gmail_extra"><br></div><div c=
lass=3D"gmail_extra">Selva</div><br></div></div>

--001a1145711cc9eadd053d1ed30b--

