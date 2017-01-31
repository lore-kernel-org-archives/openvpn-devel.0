MIME-Version: 1.0
In-Reply-To: <20170131182241.10590-1-a@...2181...>
References: <20170131182241.10590-1-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 31 Jan 2017 15:02:33 -0500
Message-ID: <CAKuzo_h69pmh=+jG=xPdprDSPLxR0Z9QhBnD_eM5bh1PUYsKYw@...278...>
Content-Type: multipart/alternative; boundary=001a11409c20e2c0510547696a1d
Subject: Re: [Openvpn-devel] [PATCH] reload HTTP proxy credentials when
 moving to the next connection profile
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11409c20e2c0510547696a1d
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Jan 31, 2017 at 1:22 PM, Antonio Quartulli <a@...2181...> wrote:

> iff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
> index b0ed3279..27f34bed 100644
> --- a/src/openvpn/proxy.c
> +++ b/src/openvpn/proxy.c
> @@ -256,7 +256,16 @@ username_password_as_base64(const struct
> http_proxy_info *p,
>  static void
>  get_user_pass_http(struct http_proxy_info *p, const bool force)
>  {
> -    if (!static_proxy_user_pass.defined || force)
> +    /*
> +     * in case of forced (re)load, make sure the static storage is set as
> +     * undefined, otherwise get_user_pass() won't try to load any
> credential
> +     */
> +    if (force)
> +    {
> +        static_proxy_user_pass.defined = false;
> +    }
>

While unsetting the define attribute appears to have no unintended side
effects,  purge_user_pass(&static_proxy_user_pass, true) would be cleaner.


> +
> +    if (!static_proxy_user_pass.defined)
>      {
>          unsigned int flags = GET_USER_PASS_MANAGEMENT;
>          if (p->queried_creds)
>

That said, there is one issue with this approach. Looks like SIGUSR1
restarts will now always prompt for proxy password, which is not proper. If
so, a more nuanced fix that preserves the current behaviour for a single
proxy credentials is required. May be, do the "purge proxy pass" in init.c
only if the connection entry has http-proxy specified?

I think the intent of the original code/man page is to have proxy password
work the same way as auth-user-pass with an implicit auth-nocache assumed.
Then multiple credentials is not expected, but could still work if the
proxy password is purged when an authentication error happens instead of
when the remote changes.

Finally, socks credentials may also be affected.

Selva

--001a11409c20e2c0510547696a1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Jan 31, 2017 at 1:22 PM, Antoni=
o <span class=3D"" id=3D":84x.1" tabindex=3D"-1">Quartulli</span> <span dir=
=3D"ltr">&lt;<a href=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D"m_-5469=
486025501691990m_-5457491941632127192:4do" class=3D"m_-5469486025501691990m=
_-5457491941632127192a3s m_-5469486025501691990m_-5457491941632127192aXjCH =
m_-5469486025501691990m_-5457491941632127192m159f5c5eea7d2341">iff --git a/=
src/openvpn/proxy.c b/src/openvpn/proxy.c<br>
index b0ed3279..27f34bed 100644<br>
--- a/src/openvpn/proxy.c<br>
+++ b/src/openvpn/proxy.c<br>
@@ -256,7 +256,16 @@ username_password_as_base64(co<wbr>nst struct http_pro=
xy_info *p,<br>
=C2=A0static void<br>
=C2=A0get_user_pass_http(struct http_proxy_info *p, const bool force)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (!static_proxy_user_pass.defin<wbr>ed || force)<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* in case of forced (re)load, make sure the static sto=
rage is set as<br>
+=C2=A0 =C2=A0 =C2=A0* undefined, otherwise get_user_pass() won&#39;t try t=
o load any credential<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (force)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 static_proxy_user_pass.defined =3D false;<br>
+=C2=A0 =C2=A0 }<br></div></blockquote><div><br></div><div>While <span clas=
s=3D"" id=3D":84x.2" tabindex=3D"-1">unsetting</span> the define attribute =
appears to have no unintended side effects, =C2=A0purge_user_pass(&amp;stat=
ic_<wbr>proxy_user_pass, true) would be cleaner.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"><div id=3D"m_-5469486025501691990m_-545749194163=
2127192:4do" class=3D"m_-5469486025501691990m_-5457491941632127192a3s m_-54=
69486025501691990m_-5457491941632127192aXjCH m_-5469486025501691990m_-54574=
91941632127192m159f5c5eea7d2341">
+<br>
+=C2=A0 =C2=A0 if (!static_proxy_user_pass.defin<wbr>ed)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int flags =3D GET_USER_PASS_MANA=
GEMENT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-&gt;queried_creds)</div></blockquot=
e></div><br>That said, there is one issue with this approach. Looks like SI=
GUSR1 restarts will now always prompt for proxy password, which is not prop=
er. If so, a more nuanced fix that preserves the current behaviour for a si=
ngle proxy credentials is required. May be, do the &quot;purge proxy pass&q=
uot; in <span class=3D"" id=3D":84x.3" tabindex=3D"-1">init</span>.c only i=
f the connection entry has http-proxy specified?</div><div class=3D"gmail_e=
xtra"><br></div><div class=3D"gmail_extra">I think the intent of the origin=
al code/man page is to have proxy password work the same way as <span class=
=3D"" id=3D":84x.4" tabindex=3D"-1">auth</span>-user-pass with an implicit =
<span class=3D"" id=3D":84x.5" tabindex=3D"-1">auth</span>-<span class=3D""=
 id=3D":84x.6" tabindex=3D"-1">nocache</span> assumed. Then multiple creden=
tials is not expected, but could still work if the proxy password is purged=
 when an authentication error happens instead of when the remote changes.</=
div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Finally=
, socks credentials may also be affected.</div><div class=3D"gmail_extra"><=
br></div><div class=3D"gmail_extra"><span class=3D"" id=3D":84x.7" tabindex=
=3D"-1">Selva</span>=C2=A0</div></div>

--001a11409c20e2c0510547696a1d--

