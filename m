MIME-Version: 1.0
References: <20191219223917.1614-1-simon@...2293...>
 <20191219223917.1614-6-simon@...2293...>
In-Reply-To: <20191219223917.1614-6-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Dec 2019 13:56:18 +0200
Message-ID: <CAGyAFMWrp0L3hJeJSPhE619hOLZVXkJWvm3oOCRdq=NqMXiKzw@...278...>
Content-Type: multipart/alternative; boundary="000000000000364c05059a215e44"
Subject: Re: [Openvpn-devel] [PATCH 6/7] wintun: stop sending TAP-Windows6
 ioctls to NDIS device
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000364c05059a215e44
Content-Type: text/plain; charset="UTF-8"

Hi,

@@ -688,7 +688,10 @@ x_check_status(int status,
>          }
>  #elif defined(_WIN32)
>          /* get possible driver error from TAP-Windows driver */
> -        extended_msg = tap_win_getinfo(tt, &gc);
> +        if (!tt->wintun)
> +        {
> +            extended_msg = tap_win_getinfo(tt, &gc);
> +        }
>


What if we make error.c device type agnostic and move that check into
tun.c, tap_win_getinfo():

    const char *
    tap_win_getinfo(const struct tuntap *tt, struct gc_arena *gc)
    {
        if (tuntap_defined(tt) && !tuntap_is_wintun(tt))
            {
                /* get debug log from tap-windows6 */

-Lev

--000000000000364c05059a215e44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div></div><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">@@ -688,7 +688,=
10 @@ x_check_status(int status,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#elif defined(_WIN32)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* get possible driver error from TAP-Win=
dows driver */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 extended_msg =3D tap_win_getinfo(tt, &amp;gc);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tt-&gt;wintun)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 extended_msg =3D tap_win_getinfo=
(tt, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div><br></di=
v><div>What if we make error.c device type agnostic and move that check int=
o tun.c, tap_win_getinfo():</div><div><br></div><div>=C2=A0 =C2=A0 const ch=
ar *<br>=C2=A0 =C2=A0 tap_win_getinfo(const struct tuntap *tt, struct gc_ar=
ena *gc)<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tuntap_defin=
ed(tt) &amp;&amp; !tuntap_is_wintun(tt))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 {<br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* get debug log from tap-windows6 */</div><div><br></div><div>-Lev=
</div></div></div>

--000000000000364c05059a215e44--

