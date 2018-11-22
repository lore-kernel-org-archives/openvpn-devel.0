From: Cyril Scetbon <cyril.scetbon@...260...>
Message-Id: <DFA3F418-5C5E-46F6-A39B-9CF5D76F2EE9@...260...>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_4536B610-5864-4913-9F7D-0491288F27E7"
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date: Thu, 22 Nov 2018 08:46:05 -0500
In-Reply-To: <20181122092047.GS962@...1296...>
References: <11098166-9909-4011-83F9-C5BC3FEA769D@...260...>
 <20181122092047.GS962@...1296...>
Subject: Re: [Openvpn-devel] foreign_option_2 not set in 2.4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_4536B610-5864-4913-9F7D-0491288F27E7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

OpenVPN 2.4.6 x86_64-alpine-linux-musl [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] =
[MH/PKTINFO] [AEAD] built on Jul  8 2018

Output with =E2=80=94verb 4 https://pastebin.com/huQmnGaU <https://pastebin=
.com/huQmnGaU>=20
=E2=80=94
Cyril Scetbon

> On Nov 22, 2018, at 4:20 AM, Gert Doering <gert@...1296...> wrote:
>=20
> Hi,
>=20
> On Wed, Nov 21, 2018 at 10:41:45PM -0500, Cyril Scetbon wrote:
>> I???ve discovered that foreign_option_2 is not set using 2.4.4 but is se=
t using 2.3.10.
>>=20
>> foreign_option_1=3Ddhcp-option DNS 10.201.50.150
>> foreign_option_2=3Ddhcp-option DOMAIN cyril.net
>>=20
>> I had to downgrade to 2.3 because of it.
>=20
> Which platform?  What's shown in the (--verb 4) log file?
>=20
> gert
>=20
> --=20
> "If was one thing all people took for granted, was conviction that if you=
=20
> feed honest figures into a computer, honest figures come out. Never doubt=
ed=20
> it myself till I met a computer with a sense of humor."
>                             Robert A. Heinlein, The Moon is a Harsh Mistr=
ess
>=20
> Gert Doering - Munich, Germany                             gert@...1296...


--Apple-Mail=_4536B610-5864-4913-9F7D-0491288F27E7
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D"">OpenVPN 2.4.6 x86_64-alpin=
e-linux-musl [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] built =
on Jul &nbsp;8 2018<div class=3D""><br class=3D""></div><div class=3D"">Out=
put with =E2=80=94verb 4&nbsp;<a href=3D"https://pastebin.com/huQmnGaU" cla=
ss=3D"">https://pastebin.com/huQmnGaU</a>&nbsp;<br class=3D""><div class=3D=
"">
<div style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line=
-break: after-white-space;" class=3D""><div style=3D"color: rgb(0, 0, 0); f=
ont-family: Helvetica; font-size: 12px; font-style: normal; font-variant-ca=
ps: normal; font-weight: normal; letter-spacing: normal; text-align: start;=
 text-indent: 0px; text-transform: none; white-space: normal; word-spacing:=
 0px; -webkit-text-stroke-width: 0px;">=E2=80=94</div><div style=3D"color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; tex=
t-align: start; text-indent: 0px; text-transform: none; white-space: normal=
; word-spacing: 0px; -webkit-text-stroke-width: 0px;">Cyril Scetbon</div></=
div>
</div>
<div><br class=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">On=
 Nov 22, 2018, at 4:20 AM, Gert Doering &lt;<a href=3D"mailto:gert@...1725...=
.." class=3D"">gert@...1296...</a>&gt; wrote:</div><br class=3D"Apple-inter=
change-newline"><div class=3D""><div class=3D"">Hi,<br class=3D""><br class=
=3D"">On Wed, Nov 21, 2018 at 10:41:45PM -0500, Cyril Scetbon wrote:<br cla=
ss=3D""><blockquote type=3D"cite" class=3D"">I???ve discovered that foreign=
_option_2 is not set using 2.4.4 but is set using 2.3.10.<br class=3D""><br=
 class=3D"">foreign_option_1=3Ddhcp-option DNS 10.201.50.150<br class=3D"">=
foreign_option_2=3Ddhcp-option DOMAIN <a href=3D"http://cyril.net" class=3D=
"">cyril.net</a><br class=3D""><br class=3D"">I had to downgrade to 2.3 bec=
ause of it.<br class=3D""></blockquote><br class=3D"">Which platform? &nbsp=
;What's shown in the (--verb 4) log file?<br class=3D""><br class=3D"">gert=
<br class=3D""><br class=3D"">-- <br class=3D"">"If was one thing all peopl=
e took for granted, was conviction that if you <br class=3D""> feed honest =
figures into a computer, honest figures come out. Never doubted <br class=
=3D""> it myself till I met a computer with a sense of humor."<br class=3D"=
"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;Robert A. Heinlein, The Moon is a Harsh Mistress<br cl=
ass=3D""><br class=3D"">Gert Doering - Munich, Germany &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a=
 href=3D"mailto:gert@...1296..." class=3D"">gert@...1296...</a><br class=3D=
""></div></div></blockquote></div><br class=3D""></div></body></html>=

--Apple-Mail=_4536B610-5864-4913-9F7D-0491288F27E7--

