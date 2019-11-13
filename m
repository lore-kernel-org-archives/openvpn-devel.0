MIME-Version: 1.0
References: <1573148729-27339-4-git-send-email-lstipakov@...277...>
 <201911091525.xA9FPrNX082306@...2054...>
In-Reply-To: <201911091525.xA9FPrNX082306@...2054...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 13 Nov 2019 12:48:37 +0200
Message-ID: <CAGyAFMVovYqF7Jr=9k2TKe3TbSgwWyn1wScLtU8z6UF6B2D_aA@...278...>
Content-Type: multipart/alternative; boundary="000000000000176b880597381cb5"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: wintun: implement opening
 wintun device
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000176b880597381cb5
Content-Type: text/plain; charset="UTF-8"

Hi,


> What I do not really like is the inflation of the code with
>
>         if (!tt->wintun)
>
> statements now.  I think this should be refactored out into an
> "open_tun_wintun()" and an "open_tun_tap_windows()" function, where
> all the bits that are now inside an "if (!tt->wintun)" get their
> own function with less if() and less nesting.
>

I agree.

I have sent a (yet another) patch (https://patchwork.openvpn.net/patch/918/
)
which refactors open_tun() method, which now looks like this:

    tun_open_device(tt, dev_node, &device_guid);

    if (tt->wintun)
    {
        wintun_register_ring_buffer(tt);
    }
    else
    {
        tuntap_post_open(tt, device_guid);
    }

Note that it requires 6 of 7 wintun patches to be merged.

Alternatively I can rebase wintun 4/5/6 patches on top of this one.

-- 
-Lev

--000000000000176b880597381cb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div class=3D"gmail_quote"><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">What I do not=
 really like is the inflation of the code with <br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tt-&gt;wintun)<br>
<br>
statements now.=C2=A0 I think this should be refactored out into an<br>
&quot;open_tun_wintun()&quot; and an &quot;open_tun_tap_windows()&quot; fun=
ction, where<br>
all the bits that are now inside an &quot;if (!tt-&gt;wintun)&quot; get the=
ir<br>
own function with less if() and less nesting.<br></blockquote><div><br></di=
v><div>I agree.=C2=A0</div><div><br></div><div>I have sent a (yet another) =
patch (<a href=3D"https://patchwork.openvpn.net/patch/918/">https://patchwo=
rk.openvpn.net/patch/918/</a>)=C2=A0</div><div>which refactors open_tun() m=
ethod, which now looks like this:</div><div><br></div><div>=C2=A0 =C2=A0 tu=
n_open_device(tt, dev_node, &amp;device_guid);<br><br>=C2=A0 =C2=A0 if (tt-=
&gt;wintun)<br>=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 wintun_regist=
er_ring_buffer(tt);<br>=C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 else<br>=C2=A0 =C2=
=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 tuntap_post_open(tt, device_guid);<br>=
=C2=A0 =C2=A0 }<br></div><div><br></div><div>Note that it requires 6 of 7 w=
intun patches to be merged.</div><div><br></div><div>Alternatively I can re=
base wintun 4/5/6 patches on top of this one.</div></div><div><br></div>-- =
<br><div dir=3D"ltr">-Lev</div></div>

--000000000000176b880597381cb5--

