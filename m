MIME-Version: 1.0
References: <CAAUX2SWYWhU-S97Ak-6XdAVQ+hty_Y8RHu_KSM8hZPiKaP7a1w@...278...>
 <e9f619bb-bd36-c77a-5f66-e7c33f6be579@...1227...>
 <CAAUX2SVde3STTxGmthXod2-pDzLPYkm+yRYvG1T4yyJGoLMKLw@...278...>
 <63cfcb94-6060-9d45-66f8-6dbfd69d7dd9@...2181...>
In-Reply-To: <63cfcb94-6060-9d45-66f8-6dbfd69d7dd9@...2181...>
From: Tony He <huangya90@...277...>
Date: Thu, 4 Mar 2021 17:10:19 +0800
Message-ID: <CAAUX2SWL_mw0YgkoCA6dd2vXT7YtkgZbib+GTQkDVrNvWMU72Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000d2712505bcb2565f"
Subject: Re: [Openvpn-devel] Segmentation fault in OpenVPN 2.6_git
 [git:dco/fcc852a9b2ea832c]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000d2712505bcb2565f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli <a@...2181...> =E4=BA=8E2021=E5=B9=B43=E6=9C=884=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:48=E5=86=99=E9=81=93=EF=BC=9A

> Hi Tony,
>
> On 04/03/2021 03:10, Tony He wrote:
> >
> > Arne Schwabe <arne@...1227... <mailto:arne@...1227...>> =E4=BA=8E2021=
=E5=B9=B43=E6=9C=883=E6=97=A5
> > =E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:56=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     Am 03.03.21 um 08:46 schrieb Tony He:
> >     > Hi Arne,
> >     >
> >     > I encountered segmentation fault in your dco branch. Master branch
> is
> >     > OK. I reverted the commit "Linux data-channel offload support",
> but it
> >     > still happens.
> >     > Anything wrong? Can you reproduce?
> >
> >     OpenVPN without any encryption or TLS is not something I tested.
> >     Consider this obscure mode broken as part of being a preview releas=
e.
> >
> >
> > So can you reproduce this issue at your side? Did you just test static
> > key? Can you paste your commands or configurations=EF=BC=9F
>
> What Arne meant is that, given the following message in your log,
>
> ******* WARNING *******: All encryption and authentication features
> disabled -- All data will be tunnelled as clear text and will not be
> protected against man-in-the-middle changes. PLEASE DO RECONSIDER THIS
> CONFIGURATION!
>
> it appears that you are testing *without* any form of encryption.
> This special case is untested at the moment.
>
I used static key and saw same error.
 % sudo /project/openvpn/schwabe/openvpn.git/src/openvpn/openvpn --ifconfig
10.200.0.1 10.200.0.2 --dev tun --secret static.key
[sudo] password for tony:
2021-03-04 16:20:33 OpenVPN 2.6_git [git:dco/8be9bbd16b2c5e1b]
x86_64-pc-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD]
[DCO] built on Mar  4 2021
2021-03-04 16:20:33 library versions: OpenSSL 1.1.1  11 Sep 2018, LZO 2.08
2021-03-04 16:20:33 WARNING: INSECURE cipher (BF-CBC) with block size less
than 128 bit (64 bit).  This allows attacks like SWEET32.  Mitigate by
using a --cipher with a larger block size (e.g. AES-256-CBC). Support for
these insecure ciphers will be removed in OpenVPN 2.6.
2021-03-04 16:20:33 WARNING: INSECURE cipher (BF-CBC) with block size less
than 128 bit (64 bit).  This allows attacks like SWEET32.  Mitigate by
using a --cipher with a larger block size (e.g. AES-256-CBC). Support for
these insecure ciphers will be removed in OpenVPN 2.6.
2021-03-04 16:20:33 WARNING: INSECURE cipher (BF-CBC) with block size less
than 128 bit (64 bit).  This allows attacks like SWEET32.  Mitigate by
using a --cipher with a larger block size (e.g. AES-256-CBC). Support for
these insecure ciphers will be removed in OpenVPN 2.6.
2021-03-04 16:20:33 sitnl_send: rtnl: generic error (-17): File exists
2021-03-04 16:20:33 net_iface_mtu_set: mtu 1500 for ovpn-dco1
2021-03-04 16:20:33 net_iface_up: set ovpn-dco1 up
2021-03-04 16:20:33 net_addr_ptp_v4_add: 10.200.0.1 peer 10.200.0.2 dev
ovpn-dco1
2021-03-04 16:20:33 Could not determine IPv4/IPv6 protocol. Using AF_INET
2021-03-04 16:20:33 UDPv4 link local (bound): [AF_INET][undef]:1194
2021-03-04 16:20:33 UDPv4 link remote: [AF_UNSPEC]
zsh: segmentation fault  sudo
/project/openvpn/schwabe/openvpn.git/src/openvpn/openvpn --ifconfig


>
> A classic configuration with CA/certs/keys should work.
> Have you tried that?
>
> Yes. I also tried this for a while and did not saw this error. However,
the dco was not enabled by default.  So I asked Arne's commands or
configurations.
But I just played with my configurations again and adjust verb to "5".
Below log tells that I must set "topology subnet=E2=80=9C explicitly. Now it
finally works.


Note: NOT using '--topology subnet' disables data channel offload.



> Regards,
>
> >
> >
> >     Thanks for the report.
> >
> >     Arne
> >
> >
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>
> --
> Antonio Quartulli
>

--000000000000d2712505bcb2565f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Antonio Quartulli &lt;a@...2181...&gt=
; =E4=BA=8E2021=E5=B9=B43=E6=9C=884=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=
=8D=883:48=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Hi Tony,<br>
<br>
On 04/03/2021 03:10, Tony He wrote:<br>
&gt; <br>
&gt; Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">=
arne@...1227...</a> &lt;mailto:<a href=3D"mailto:arne@...1227..." target=3D=
"_blank">arne@...1227...</a>&gt;&gt; =E4=BA=8E2021=E5=B9=B43=E6=9C=883=E6=
=97=A5<br>
&gt; =E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:56=E5=86=99=E9=81=93=EF=BC=9A<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Am 03.03.21 um 08:46 schrieb Tony He:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi Arne,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I encountered segmentation fault in your dco b=
ranch. Master branch is<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; OK. I reverted the commit=C2=A0&quot;Linux dat=
a-channel offload support&quot;, but it<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; still happens.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Anything wrong? Can you reproduce?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0OpenVPN without any encryption or TLS is not someth=
ing I tested.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Consider this obscure mode broken as part of being =
a preview release.<br>
&gt; <br>
&gt; <br>
&gt; So can you reproduce this issue at your side? Did you just test static=
<br>
&gt; key? Can you paste your commands or configurations=EF=BC=9F<br>
<br>
What Arne meant is that, given the following message in your log,<br>
<br>
******* WARNING *******: All encryption and authentication features<br>
disabled -- All data will be tunnelled as clear text and will not be<br>
protected against man-in-the-middle changes. PLEASE DO RECONSIDER THIS<br>
CONFIGURATION!<br>
<br>
it appears that you are testing *without* any form of encryption.<br>
This special case is untested at the moment.<br></blockquote><div>I used st=
atic key and saw same error.</div>=C2=A0% sudo /project/openvpn/schwabe/ope=
nvpn.git/src/openvpn/openvpn --ifconfig 10.200.0.1 10.200.0.2 --dev tun --s=
ecret static.key<br>[sudo] password for tony: <br>2021-03-04 16:20:33 OpenV=
PN 2.6_git [git:dco/8be9bbd16b2c5e1b] x86_64-pc-linux-gnu [SSL (OpenSSL)] [=
LZO] [LZ4] [EPOLL] [MH/PKTINFO] [AEAD] [DCO] built on Mar =C2=A04 2021<br>2=
021-03-04 16:20:33 library versions: OpenSSL 1.1.1 =C2=A011 Sep 2018, LZO 2=
.08<br>2021-03-04 16:20:33 WARNING: INSECURE cipher (BF-CBC) with block siz=
e less than 128 bit (64 bit).=C2=A0 This allows attacks like SWEET32.=C2=A0=
 Mitigate by using a --cipher with a larger block size (e.g. AES-256-CBC). =
Support for these insecure ciphers will be removed in OpenVPN 2.6.<br>2021-=
03-04 16:20:33 WARNING: INSECURE cipher (BF-CBC) with block size less than =
128 bit (64 bit).=C2=A0 This allows attacks like SWEET32.=C2=A0 Mitigate by=
 using a --cipher with a larger block size (e.g. AES-256-CBC). Support for =
these insecure ciphers will be removed in OpenVPN 2.6.<br>2021-03-04 16:20:=
33 WARNING: INSECURE cipher (BF-CBC) with block size less than 128 bit (64 =
bit).=C2=A0 This allows attacks like SWEET32.=C2=A0 Mitigate by using a --c=
ipher with a larger block size (e.g. AES-256-CBC). Support for these insecu=
re ciphers will be removed in OpenVPN 2.6.<br>2021-03-04 16:20:33 sitnl_sen=
d: rtnl: generic error (-17): File exists<br>2021-03-04 16:20:33 net_iface_=
mtu_set: mtu 1500 for ovpn-dco1<br>2021-03-04 16:20:33 net_iface_up: set ov=
pn-dco1 up<br>2021-03-04 16:20:33 net_addr_ptp_v4_add: 10.200.0.1 peer 10.2=
00.0.2 dev ovpn-dco1<br>2021-03-04 16:20:33 Could not determine IPv4/IPv6 p=
rotocol. Using AF_INET<br>2021-03-04 16:20:33 UDPv4 link local (bound): [AF=
_INET][undef]:1194<br>2021-03-04 16:20:33 UDPv4 link remote: [AF_UNSPEC]<br=
>zsh: segmentation fault =C2=A0sudo /project/openvpn/schwabe/openvpn.git/sr=
c/openvpn/openvpn --ifconfig =C2=A0 =C2=A0 <br><div>=C2=A0=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
A classic configuration with CA/certs/keys should work.<br>
Have you tried that?<br>
<br></blockquote><div>Yes. I also tried this for a while and did not saw th=
is error. However, the dco=C2=A0was not enabled by default.=C2=A0 So I aske=
d Arne&#39;s commands or configurations.</div><div>But I just played with m=
y configurations again and adjust verb to &quot;5&quot;. Below log tells th=
at I must set &quot;topology subnet=E2=80=9C=C2=A0<span style=3D"font-varia=
nt-numeric:normal;font-variant-east-asian:normal;color:rgb(51,51,51);font-f=
amily:Arial,&quot;Microsoft YaHei&quot;,&quot;\005fae\008f6f\0096c5\009ed1&=
quot;,&quot;\005b8b\004f53&quot;,&quot;Malgun Gothic&quot;,Meiryo,sans-seri=
f;font-size:14px;line-height:21px">explicitly. Now it finally works.</span>=
</div><div><br></div><div><br></div><div>Note: NOT using &#39;--topology su=
bnet&#39; disables data channel offload.=C2=A0=C2=A0<br></div><div><br></di=
v><div>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Regards,<br>
<br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks for the report.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Arne<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blan=
k">Openvpn-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/l=
istinfo/openvpn-devel</a><br>
&gt; <br>
<br>
-- <br>
Antonio Quartulli<br>
</blockquote></div></div>

--000000000000d2712505bcb2565f--

