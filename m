MIME-Version: 1.0
References: <20210922095756.1929-1-chipitsine@...277...>
 <4654662a-587a-ca90-6678-5c5ff71e9c66@...1227...>
 <CAGyAFMWXBpvo-mxOkNsFrYR9oB9MVRcFEQ6SBs7rP0A6LeNu6Q@...278...>
In-Reply-To: <CAGyAFMWXBpvo-mxOkNsFrYR9oB9MVRcFEQ6SBs7rP0A6LeNu6Q@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 27 Sep 2021 15:06:13 +0500
Message-ID: <CAFHpkQECg=UVywGzXXBeA1V5R7M5zSr8QkCT=Mj7ThBFB5c+yg@...278...>
Content-Type: multipart/alternative; boundary="000000000000e504e405ccf73fe9"
Subject: Re: [Openvpn-devel] [PATCH v2] BUILD: enable CFG and Spectre
 mitigation for MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--000000000000e504e405ccf73fe9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll setup test stand similar to this one
https://community.openvpn.net/openvpn/wiki/PerformanceTestingOpenVPN
hopefully in next 1-2 weeks

I also believe that spectre mitigation is neglectable, but it is good to
have numbers

=D0=BF=D0=BD, 27 =D1=81=D0=B5=D0=BD=D1=82. 2021 =D0=B3. =D0=B2 12:58, Lev S=
tipakov <lstipakov@...277...>:

> I didn't, but here
>
> https://devblogs.microsoft.com/cppblog/spectre-mitigations-in-msvc/
>
> it says that
>
> "On the MSVC team, we=E2=80=99ve reviewed information in detail and condu=
cted
> extensive tests, which showed the performance impact of the new
> /Qspectre switch to be negligible."
> --
> -Lev
>

--000000000000e504e405ccf73fe9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;ll setup test stand similar to this one <a href=
=3D"https://community.openvpn.net/openvpn/wiki/PerformanceTestingOpenVPN">h=
ttps://community.openvpn.net/openvpn/wiki/PerformanceTestingOpenVPN</a></di=
v><div>hopefully in next 1-2 weeks</div><div><br></div><div>I also believe =
that spectre mitigation is neglectable, but it is good to have numbers<br><=
/div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">=D0=BF=D0=BD, 27 =D1=81=D0=B5=D0=BD=D1=82. 2021 =D0=B3. =D0=B2 12:58, =
Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...=
</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I didn=
&#39;t, but here<br>
<br>
<a href=3D"https://devblogs.microsoft.com/cppblog/spectre-mitigations-in-ms=
vc/" rel=3D"noreferrer" target=3D"_blank">https://devblogs.microsoft.com/cp=
pblog/spectre-mitigations-in-msvc/</a><br>
<br>
it says that<br>
<br>
&quot;On the MSVC team, we=E2=80=99ve reviewed information in detail and co=
nducted<br>
extensive tests, which showed the performance impact of the new<br>
/Qspectre switch to be negligible.&quot;<br>
-- <br>
-Lev<br>
</blockquote></div>

--000000000000e504e405ccf73fe9--

