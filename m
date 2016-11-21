MIME-Version: 1.0
In-Reply-To: <CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
References: <CAFHpkQEKrJqNB2ZmhAwKGebVb6SB75HpnWcrw_niSaALL_S4mA@...278...>
	<CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 21 Nov 2016 22:31:45 +0500
Message-ID: <CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
Content-Type: multipart/alternative; boundary=047d7bf10b4ea6105c0541d3078d
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
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

--047d7bf10b4ea6105c0541d3078d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-11-17 3:04 GMT+05:00 Steffan Karger <steffan@...1856...>:

> On 16 November 2016 at 18:06, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
> > is it ok ?
>
> No, it's not.  But someone needs to figure out how to use cmocka on
> OSX, or disable the offending test on OSX.  If I find some time I
> will, but I haven't yet gotten around to it.
>

this line

https://github.com/OpenVPN/openvpn/blob/master/tests/unit_tests/openvpn/Mak=
efile.am#L17

causes an error

https://travis-ci.org/OpenVPN/openvpn/jobs/177700958#L1258

I guess, someone who did that commit, can resolve it.


>
> -Steffan
>

--047d7bf10b4ea6105c0541d3078d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-11-17 3:04 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 16 Novembe=
r 2016 at 18:06, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=
=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">chipitsine@...277...<=
/a>&gt; wrote:<br>
&gt; is it ok ?<br>
<br>
No, it&#39;s not.=C2=A0 But someone needs to figure out how to use cmocka o=
n<br>
OSX, or disable the offending test on OSX.=C2=A0 If I find some time I<br>
will, but I haven&#39;t yet gotten around to it.<br></blockquote><div><br><=
/div><div>this line<br><br><a href=3D"https://github.com/OpenVPN/openvpn/bl=
ob/master/tests/unit_tests/openvpn/Makefile.am#L17">https://github.com/Open=
VPN/openvpn/blob/master/tests/unit_tests/openvpn/Makefile.am#L17</a><br><br=
></div><div>causes an error<br><br><a href=3D"https://travis-ci.org/OpenVPN=
/openvpn/jobs/177700958#L1258">https://travis-ci.org/OpenVPN/openvpn/jobs/1=
77700958#L1258</a><br><br></div><div>I guess, someone who did that commit, =
can resolve it.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
</font></span></blockquote></div><br></div></div>

--047d7bf10b4ea6105c0541d3078d--

