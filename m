MIME-Version: 1.0
References: <CAGyAFMV=HvOYDRSB7eRpBDp-47wX2vie8JPgp48in1fH+eXn=A@...278...>
 <CAFHpkQFVpN-+Uoc6QsLmD8hjwEC7Ba1Q2SP4SuS_EMu_PT=3nw@...278...>
 <7bdf712d-4e0c-0667-c9eb-1bdd862b1e40@...2080...>
 <bfead88f-3e91-6d49-ea70-e73f626468f1@...1147...>
 <CAGyAFMW10tUVswPa8NfVieUJMm1oX1BFQaa9a0GP3NmgWpRshg@...278...>
 <CAGyAFMWODccNnD+yby7HrOUfdDFaceC3AX70+jG9_hL9vF=q+A@...278...>
 <CAGyAFMUqqjF67DDdr+BQXvFU515_zK=fDehUJH1TF+zjyjuiAA@...278...>
In-Reply-To: <CAGyAFMUqqjF67DDdr+BQXvFU515_zK=fDehUJH1TF+zjyjuiAA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 14 Jun 2019 18:56:56 +0300
Message-ID: <CAGyAFMWaHBAR1fPVx5PUERg=JU9hg+mQMhtQExqpE_tHvevSAw@...278...>
Content-Type: multipart/alternative; boundary="000000000000dc12ce058b4ab234"
Subject: Re: [Openvpn-devel] Wintun performance results
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>, wireguard@...2500...

--000000000000dc12ce058b4ab234
Content-Type: text/plain; charset="UTF-8"

Hi,

I got some new Wintun (I used version 0.2) performance stats I would like
to share. I have tested openvpn2 and openvpn3 (both with openssl) on the
client against openvpn2 and proprietary openvpn3 server (which is openvpn3
with kernel acceleration). Cipher AES-256-GCM.

Server - proprietary openvpn3
----------------------------------------------------

ovpn3 wintun   1.90 Gbit/s
ovpn3 tap6       890 Mbit/s

ovpn2 wintun    870 Mbit/s
ovpn2 tap6       440 Mbit/s


Server - open source openvpn2
----------------------------------------------------

ovpn3 wintun    670 Mbit/s
ovpn3 tap6       580 Mbit/s

ovpn2 wintun    610 Mbit/s
ovpn2 tap6        450 Mbit/s


As you see, in every case Wintun overperforms tap-windows6 and approaches
mind boggling 2 Gbit/s.

My openvpn2 wintun patch could be found here
https://github.com/lstipakov/openvpn/tree/feature/wintun, and openvpn3 -
https://github.com/lstipakov/openvpn3/tree/fix/wintun-fixes

Jason / Simon - great work on Wintun!

-- 
-Lev

--000000000000dc12ce058b4ab234
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<br><br>I got some new Wintun (I used =
version 0.2) performance stats I would like to share. I have tested openvpn=
2 and openvpn3 (both with openssl) on the client against openvpn2 and propr=
ietary openvpn3 server (which is openvpn3 with kernel acceleration). Cipher=
 AES-256-GCM.<br><br>Server - proprietary openvpn3=C2=A0<br>---------------=
-------------------------------------<br><br>ovpn3 wintun=C2=A0 =C2=A01.90 =
Gbit/s<br>ovpn3 tap6=C2=A0 =C2=A0 =C2=A0 =C2=A0890 Mbit/s<br><br>ovpn2 wint=
un=C2=A0 =C2=A0 870 Mbit/s<div>ovpn2 tap6=C2=A0 =C2=A0 =C2=A0 =C2=A0440 Mbi=
t/s=C2=A0<br><div><br></div><div><br></div><div>Server - open source openvp=
n2<br>----------------------------------------------------=C2=A0=C2=A0<br><=
/div><div><br></div></div><div>ovpn3 wintun=C2=A0 =C2=A0 670 Mbit/s</div><d=
iv>ovpn3 tap6=C2=A0 =C2=A0 =C2=A0 =C2=A0580 Mbit/s=C2=A0=C2=A0<br></div><di=
v><br></div><div>ovpn2 wintun=C2=A0 =C2=A0 610 Mbit/s</div><div>ovpn2 tap6=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 450 Mbit/s</div><div><br></div><div><br></div><=
div>As you see, in every case Wintun overperforms tap-windows6 and approach=
es mind boggling 2 Gbit/s.</div><div><br></div><div>My openvpn2 wintun patc=
h could be found here=C2=A0<a href=3D"https://github.com/lstipakov/openvpn/=
tree/feature/wintun">https://github.com/lstipakov/openvpn/tree/feature/wint=
un</a>, and openvpn3 -=C2=A0<a href=3D"https://github.com/lstipakov/openvpn=
3/tree/fix/wintun-fixes">https://github.com/lstipakov/openvpn3/tree/fix/win=
tun-fixes</a></div><div><br></div><div>Jason / Simon - great work on Wintun=
!</div><div><br></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatur=
e">-Lev</div></div>

--000000000000dc12ce058b4ab234--

