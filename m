MIME-Version: 1.0
References: <tencent_634348984485969552F3189D5284B3FD7C08@...1414...>
In-Reply-To: <tencent_634348984485969552F3189D5284B3FD7C08@...1414...>
From: Tony He <huangya90@...277...>
Date: Thu, 26 Nov 2020 17:41:52 +0800
Message-ID: <CAAUX2SVnf4dr8FNsgNXbFiRMK1VWQQJWE-JUmDPs4VgzcPsDaA@...278...>
Content-Type: multipart/alternative; boundary="0000000000003bcd2b05b4ff5b5c"
Subject: Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supported?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, lev@...515..., openvpn-devel@lists.sourceforge.net

--0000000000003bcd2b05b4ff5b5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arne,

>Since the original thread was not on the mailing list I am missing your
>goal but if your crypto acelator already works with OpenSSL, then it
>will also work with the "normal" OpenVPN

Yes, it wokrs with "normal" OpenVPN(OpenVPN2), but according to the test
result, it's still not fast(about 60Mbps).
The bottleneck is not encryption operation any more. It comes from the
switch of user space and kernel space in the OpenVPN2,
which makes the poor CPU of  embedded device very busy. That's why we need
OpenVPN3 running in the kernel space.

Tony

Tony <383181189@...1414...> =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:32=E5=86=99=E9=81=93=EF=BC=9A

>
>
>
> ------------------ =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 ------------------
> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* "Arne Schwabe" <arne@...1227...>;
> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* 2020=E5=B9=B411=E6=9C=8826=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) =E4=B8=8B=E5=8D=885:22
> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* "Tony He"<huangya90@...277...>;"Antonio Qu=
artulli"<a@...2181...>;
> *=E6=8A=84=E9=80=81:* "lev"<lev@...515...>;"openvpn-devel"<
> openvpn-devel@lists.sourceforge.net>;
> *=E4=B8=BB=E9=A2=98:* Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac supporte=
d?
>
> Am 26.11.20 um 01:46 schrieb Tony He:
> >>OpenSSL directly talks to the crypto engine via a proprietary interface
> >>that the FW/driver exposes to userspace. The *data* flow does not cross
> >>the linux kernel crypto API
> >
> > No, OpenSSL doesn't directly talk to the  crypto engine via a
> > proprietary interface that the FW/driver exposes to userspace.
> > "cryptodev engine" is NOT the "HW engine" chip vendor provides. It's a
> > common interface and its source is not from
>
>
> To be honest. We currently aim to feature current state of the art
> support. And with supporting only the AEAD algorithm we support all
> clients of 2.4 and later.
>
> Since the original thread was not on the mailing list I am missing your
> goal but if your crypto acelator already works with OpenSSL, then it
> will also work with the "normal" OpenVPN.
>
> If you look over the fence at IPSec accleration in Intel NIC hardware,
> you will find that those also only support AES-GCM. And that with even
> hardware that came out almost 10 years ago.
>
> Or look at TLS 1.3. De facto there is only AES-GCM and Chacha20-Poly1305
> left as standard. TLS1_3_RFC_AES_128_CCM_8_SHA256 is specified but you
> need to specifically configure your TLS library to support this. This
> inclusion of AES-CCM is specifically to cater for use use cases like your=
s.
>
> Since AES-CCM is an AEAD cipher supporting that makes more sense and
> might very straightforword if it is supported by the AEAD APIs we
> already use.
>
> Arne
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000003bcd2b05b4ff5b5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Arne,<div><br></div><div>&gt;Since the original thread =
was not on the mailing list I am missing your<br>&gt;goal but if your crypt=
o acelator already works with OpenSSL, then it<br>&gt;will also work with t=
he &quot;normal&quot; OpenVPN<br></div><div><br></div><div>Yes, it wokrs wi=
th &quot;normal&quot; OpenVPN(OpenVPN2), but according to the test result, =
it&#39;s still not fast(about 60Mbps).</div><div>The bottleneck is not encr=
yption operation any more. It comes from the switch of user space and kerne=
l space in the OpenVPN2,</div><div>which makes the poor CPU of=C2=A0 embedd=
ed device<span style=3D"color:rgb(0,0,0);font-family:&quot;lucida Grande&qu=
ot;,Verdana,&quot;Microsoft YaHei&quot;;font-size:14px">=C2=A0very busy.=C2=
=A0</span>That&#39;s why we need OpenVPN3 running in the kernel space.</div=
><div><br></div><div>Tony</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">Tony &lt;<a href=3D"mailto:383181189@...2585...=
...">383181189@...1414...</a>&gt; =E4=BA=8E2020=E5=B9=B411=E6=9C=8826=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:32=E5=86=99=E9=81=93=EF=BC=9A<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div><br></div><div=
><div><br></div><div><br></div><div style=3D"font-size:12px;font-family:&qu=
ot;Arial Narrow&quot;;padding:2px 0px">------------------=C2=A0=E5=8E=9F=E5=
=A7=8B=E9=82=AE=E4=BB=B6=C2=A0------------------</div><div style=3D"font-si=
ze:12px;background:rgb(239,239,239);padding:8px"><div><b>=E5=8F=91=E4=BB=B6=
=E4=BA=BA:</b>                                                             =
                                                           &quot;Arne Schwa=
be&quot;                                                                   =
                 &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">a=
rne@...1227...</a>&gt;;</div><div><b>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:<=
/b>=C2=A02020=E5=B9=B411=E6=9C=8826=E6=97=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) =
=E4=B8=8B=E5=8D=885:22</div><div><b>=E6=94=B6=E4=BB=B6=E4=BA=BA:</b>=C2=A0&=
quot;Tony He&quot;&lt;<a href=3D"mailto:huangya90@...277..." target=3D"_bla=
nk">huangya90@...277...</a>&gt;;&quot;Antonio Quartulli&quot;&lt;a@...2586...=
..&gt;;</div><div><b>=E6=8A=84=E9=80=81:</b>=C2=A0&quot;lev&quot;&lt;<a hre=
f=3D"mailto:lev@...515..." target=3D"_blank">lev@...515...</a>&gt;;&quot;op=
envpn-devel&quot;&lt;<a href=3D"mailto:openvpn-devel@lists.sourceforge.net"=
 target=3D"_blank">openvpn-devel@lists.sourceforge.net</a>&gt;;</div><div><=
b>=E4=B8=BB=E9=A2=98:</b>=C2=A0Re: [Openvpn-devel] [ovpn-dco] Is cbc-hmac s=
upported?</div></div><div><br></div>Am 26.11.20 um 01:46 schrieb Tony He:<b=
r>&gt;&gt;OpenSSL directly talks to the crypto engine via a proprietary int=
erface<br>&gt;&gt;that the FW/driver exposes to userspace. The *data* flow =
does not cross<br>&gt;&gt;the linux kernel crypto API<br>&gt; <br>&gt; No, =
OpenSSL doesn&#39;t directly talk to the=C2=A0=C2=A0crypto engine via a<br>=
&gt; proprietary interface=C2=A0that the FW/driver exposes to userspace.<br=
>&gt; &quot;cryptodev engine&quot; is NOT the &quot;HW engine&quot; chip ve=
ndor provides. It&#39;s a<br>&gt; common interface and its source is not fr=
om<br><br><br>To be honest. We currently aim to feature current state of th=
e art<br>support. And with supporting only the AEAD algorithm we support al=
l<br>clients of 2.4 and later.<br><br>Since the original thread was not on =
the mailing list I am missing your<br>goal but if your crypto acelator alre=
ady works with OpenSSL, then it<br>will also work with the &quot;normal&quo=
t; OpenVPN.<br><br>If you look over the fence at IPSec accleration in Intel=
 NIC hardware,<br>you will find that those also only support AES-GCM. And t=
hat with even<br>hardware that came out almost 10 years ago.<br><br>Or look=
 at TLS 1.3. De facto there is only AES-GCM and Chacha20-Poly1305<br>left a=
s standard. TLS1_3_RFC_AES_128_CCM_8_SHA256 is specified but you<br>need to=
 specifically configure your TLS library to support this. This<br>inclusion=
 of AES-CCM is specifically to cater for use use cases like yours.<br><br>S=
ince AES-CCM is an AEAD cipher supporting that makes more sense and<br>migh=
t very straightforword if it is supported by the AEAD APIs we<br>already us=
e.<br><br>Arne<br><br><br>_______________________________________________<b=
r>Openvpn-devel mailing list<br><a href=3D"mailto:Openvpn-devel@...1011...=
eforge.net" target=3D"_blank">Openvpn-devel@lists.sourceforge.net</a><br><a=
 href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" target=
=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a><=
br></div></blockquote></div>

--0000000000003bcd2b05b4ff5b5c--

