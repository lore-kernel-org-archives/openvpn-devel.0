MIME-Version: 1.0
References: <CAGyAFMWrp0L3hJeJSPhE619hOLZVXkJWvm3oOCRdq=NqMXiKzw@...278...>
 <20191220161117.1434-6-simon@...2293...>
In-Reply-To: <20191220161117.1434-6-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 21 Dec 2019 13:31:24 +0200
Message-ID: <CAGyAFMXMkCf=qoYopK0N=FrWxVvBQ4RKKKQ2y+dUnhwpjh=LPQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000001ebab6059a35238e"
Subject: Re: [Openvpn-devel] [PATCH v2 6/7] wintun: stop sending
 TAP-Windows6 ioctls to NDIS device
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

--0000000000001ebab6059a35238e
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry for not mentioning it earlier.

There is already check in forward.c:

    if (tuntap_defined(c->c1.tuntap))
    {
        tun_show_debug(c->c1.tuntap);
    }

Same goes for tap_win_getinfo in sig.c:

    if (tuntap_defined(c->c1.tuntap))
    {
        status_printf(so, "TAP-WIN32 driver status,\"%s\"",
                      tap_win_getinfo(c->c1.tuntap, &gc));
    }

There is one place where that check is missing, error.c:

    #elif defined(_WIN32)
        /* get possible driver error from TAP-Windows driver */
        extended_msg = tap_win_getinfo(tt, &gc);
    #endif

There is no need to call tuntap_defined() twice, so either
we remove it from calling code or from tun_* methods.
For the sake of consistency I propose to add it to error.c
and remove from tun_* methods, which would just check for !tt->wintun.

-- 
-Lev

--0000000000001ebab6059a35238e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Sorry for not ment=
ioning it=C2=A0earlier.</div><div><br></div><div>There is already check in =
forward.c:</div><div><br></div><div>=C2=A0 =C2=A0 if (tuntap_defined(c-&gt;=
c1.tuntap))<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 tun_show_debu=
g(c-&gt;c1.tuntap);<br>=C2=A0 =C2=A0 }<br></div><div><br></div><div>Same go=
es for tap_win_getinfo in sig.c:</div><div><br></div><div>=C2=A0 =C2=A0 if =
(tuntap_defined(c-&gt;c1.tuntap))<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 status_printf(so, &quot;TAP-WIN32 driver status,\&quot;%s\&quot;=
&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 tap_win_getinfo(c-&gt;c1.tuntap, &amp;gc));<br>=C2=A0 =C2=A0 =
}<br></div><div><br></div><div>There is one place where that check is missi=
ng, error.c:</div><div><br></div><div>=C2=A0 =C2=A0 #elif defined(_WIN32)<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* get possible driver error from TAP-Windows=
 driver */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 extended_msg =3D tap_win_getinfo(=
tt, &amp;gc);<br>=C2=A0 =C2=A0 #endif<br></div><div><br></div><div>There is=
 no need to call tuntap_defined() twice, so either=C2=A0</div><div>we remov=
e it from calling code or from tun_* methods.</div><div>For the sake of con=
sistency I propose to add it to error.c</div><div>and remove from tun_* met=
hods, which would just check for=C2=A0!tt-&gt;wintun.</div><div><br></div><=
/div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">-Lev</div></div>

--0000000000001ebab6059a35238e--

