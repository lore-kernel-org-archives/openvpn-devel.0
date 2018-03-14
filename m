MIME-Version: 1.0
In-Reply-To: <CAKuzo_g8KXGKN-A-egEonQEFpkro5wb5OigDbycg0j_Ae=5Tow@...278...>
References: <20171205121952.13008-1-EngyCZ@...277...>
 <CAKuzo_g6YTkx+-3i=TEFn9b2yPjx9rBweTz=4H7uuOT8VokEdg@...278...>
 <CAHODtZSTyD8NOc8cVNaGaZ9z+HZrKK-+L6h_t0gqhAh3pJMk+w@...278...>
 <CAHODtZQRb48Aa8AsxXoSnUUSLE27u-EjCOWavFJj7nwZqPYd7w@...278...>
 <CAKuzo_g8KXGKN-A-egEonQEFpkro5wb5OigDbycg0j_Ae=5Tow@...278...>
From: =?UTF-8?B?SmnFmcOtIEVuZ2VsdGhhbGVy?= <engycz@...277...>
Date: Wed, 14 Mar 2018 08:32:47 +0100
Message-ID: <CAHODtZThxjAUb-sZ4bA1Y238hPeK=zKGcSbU9d3nib+8rt0YMg@...278...>
Content-Type: multipart/alternative; boundary="001a1141bffcbfdfa805675a61d4"
Subject: Re: [Openvpn-devel] [PATCH] Add a warning for disabled DHCP media
 sense on Window
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1141bffcbfdfa805675a61d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi.
  You right. Disabled dhcp media sense can be set as global for all
interfaces or in adapter specific setting if it supports it (TAP supports
it).
But for must users is the global settings hidden deep in the system and for
me it took several months to find the cause of my problems. Interface
specific settings can be cleared by uninstalling and reinstalling OpenVPN.

Ji=C5=99=C3=AD

2018-03-14 4:33 GMT+01:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> On Tue, Mar 13, 2018 at 7:36 AM, Ji=C5=99=C3=AD Engelthaler <engycz@...1664...=
7...>
> wrote:
> >
> > Any discussion / opinions ? Here https://github.com/OpenVPN/
> openvpn/pull/97#issuecomment-372530059
> > one user reported, that this patch were useful for him.
>
> Though I agree that checking for whether media sense is globally
> disabled would help some, I'm not convinced that this is the right
> approach. The media sense can be disabled on individual adaptors too
> isn't it? -- say tap adaptor media status set as "always connected". And
> that won't be caught or fixed by this check.
>
> If dhcp-renew will cure this, why not just make --dhcp-renew the
> default? That way we get rid of another config option and no new
> code is needed. Is there an argument why that option should not be on
> by default?
>
> Selva
>

--001a1141bffcbfdfa805675a61d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>
<div><div>Hi.<br></div>=C2=A0 You right. Disabled dhcp media sense can be s=
et
 as global for all interfaces or in adapter specific setting if it=20
supports it (TAP supports it).<br></div><div>But for must users is the=20
global settings hidden deep in the system and for me it took several=20
months to find the cause of my problems. Interface specific settings can
 be cleared by uninstalling and reinstalling OpenVPN.</div>

<br></div>Ji=C5=99=C3=AD<br></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">2018-03-14 4:33 GMT+01:00 Selva Nair <span dir=3D"ltr">&lt=
;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1664...=
7...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Tue, Mar 13, 2018 at 7:36 AM, Ji=C5=99=C3=AD Engelthaler &lt;<a href=3D"=
mailto:engycz@...277...">engycz@...277...</a>&gt; wrote:<br>
&gt;<br>
&gt; Any discussion / opinions ? Here <a href=3D"https://github.com/OpenVPN=
/openvpn/pull/97#issuecomment-372530059" rel=3D"noreferrer" target=3D"_blan=
k">https://github.com/OpenVPN/<wbr>openvpn/pull/97#issuecomment-<wbr>372530=
059</a><br>
&gt; one user reported, that this patch were useful for him.<br>
<br>
</span>Though I agree that checking for whether media sense is globally<br>
disabled would help some, I&#39;m not convinced that this is the right<br>
approach. The media sense can be disabled on individual adaptors too<br>
isn&#39;t it? -- say tap adaptor media status set as &quot;always connected=
&quot;. And<br>
that won&#39;t be caught or fixed by this check.<br>
<br>
If dhcp-renew will cure this, why not just make --dhcp-renew the<br>
default? That way we get rid of another config option and no new<br>
code is needed. Is there an argument why that option should not be on<br>
by default?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Selva<br>
</font></span></blockquote></div><br></div>

--001a1141bffcbfdfa805675a61d4--

