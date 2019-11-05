From: Tom Yan <tom.ty89@...277...>
Date: Tue, 5 Nov 2019 03:08:36 +0000
Message-ID: <BN7PR04MB52517BB2179BE30E03B775CAFD7E0@...2532...>
References: <20191103053148.18059-1-tom.ty89@...277...>
 <20191103182443.GC40538@...1296...>
 <20191103183351.GD40538@...1296...>
 <CAGnHSEn0jaM3u9LCXxArhQkL9ddZQ9UROOZ8+PXPf+oAwTyswg@...278...>
 <20191103204613.GE40538@...1296...>,
 <a991a966-039e-c171-7201-01b90a23d2b7@...1227...>
In-Reply-To: <a991a966-039e-c171-7201-01b90a23d2b7@...1227...>
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_BN7PR04MB52517BB2179BE30E03B775CAFD7E0BN7PR04MB5251namp_"
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ipv4
 prefix (RFC 3021)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--_000_BN7PR04MB52517BB2179BE30E03B775CAFD7E0BN7PR04MB5251namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Yeah I was merely referring to the trivial warning of the ifconfig mismatch=
. It's not exactly a problem but it just sort of made me aware of such thin=
g as /31 subnet and noticed the bug on Linux. That's why I never opened an =
issue on ics-openvpn.
________________________________
From: Arne Schwabe <arne@...1227...>
Sent: Tuesday, November 5, 2019 12:28:25 AM
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net <openvpn-devel@...475...=
t>
Subject: Re: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ipv4 pref=
ix (RFC 3021)

>> Yeah the removal of the p2p topology was one of the reasons. It's
>> actually the fact that ics-openvpn doesn't really parse point-to-point
>> ifconfig that made me aware of this.
>
> I wasn't aware of that, but since Arne is reading here, maybe he can
> comment on it.  It's possible that the Android VPN API just does not
> permit p2p mode, but wants a subnet.
>
> Arne, any idea if /31 works on Android?

Yes. But Android is special here anyway. It always wants a subnet mask
but the mask can be also be 255.255.255.255. And you also don't have a
gateway address and Android also does not set a route to the tun
interface (On Android 4.4+). So basically you always operate in p2p mode
and emulate other modes by adding routes to the tun interface.

Arne


--_000_BN7PR04MB52517BB2179BE30E03B775CAFD7E0BN7PR04MB5251namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Yeah I was merely referring to the trivial warning of the ifconfig mismatch=
. It's not exactly a problem but it just sort of made me aware of such thin=
g as /31 subnet and noticed the bug on Linux. That's why I never opened an =
issue on ics-openvpn.</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Arne Schwabe &lt;ar=
ne@...1227...&gt;<br>
<b>Sent:</b> Tuesday, November 5, 2019 12:28:25 AM<br>
<b>To:</b> Gert Doering &lt;gert@...1296...&gt;<br>
<b>Cc:</b> openvpn-devel@lists.sourceforge.net &lt;openvpn-devel@...1439...=
ceforge.net&gt;<br>
<b>Subject:</b> Re: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ip=
v4 prefix (RFC 3021)</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">&gt;&gt; Yeah the removal of the p2p topology was =
one of the reasons. It's<br>
&gt;&gt; actually the fact that ics-openvpn doesn't really parse point-to-p=
oint<br>
&gt;&gt; ifconfig that made me aware of this.<br>
&gt; <br>
&gt; I wasn't aware of that, but since Arne is reading here, maybe he can<b=
r>
&gt; comment on it.&nbsp; It's possible that the Android VPN API just does =
not<br>
&gt; permit p2p mode, but wants a subnet.<br>
&gt; <br>
&gt; Arne, any idea if /31 works on Android?<br>
<br>
Yes. But Android is special here anyway. It always wants a subnet mask<br>
but the mask can be also be 255.255.255.255. And you also don't have a<br>
gateway address and Android also does not set a route to the tun<br>
interface (On Android 4.4&#43;). So basically you always operate in p2p mod=
e<br>
and emulate other modes by adding routes to the tun interface.<br>
<br>
Arne<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_BN7PR04MB52517BB2179BE30E03B775CAFD7E0BN7PR04MB5251namp_--

