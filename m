MIME-Version: 1.0
References: <CAGyAFMV=HvOYDRSB7eRpBDp-47wX2vie8JPgp48in1fH+eXn=A@...278...>
 <CAFHpkQFVpN-+Uoc6QsLmD8hjwEC7Ba1Q2SP4SuS_EMu_PT=3nw@...278...>
 <7bdf712d-4e0c-0667-c9eb-1bdd862b1e40@...2080...>
 <bfead88f-3e91-6d49-ea70-e73f626468f1@...1147...>
 <CAGyAFMW10tUVswPa8NfVieUJMm1oX1BFQaa9a0GP3NmgWpRshg@...278...>
 <CAGyAFMWODccNnD+yby7HrOUfdDFaceC3AX70+jG9_hL9vF=q+A@...278...>
In-Reply-To: <CAGyAFMWODccNnD+yby7HrOUfdDFaceC3AX70+jG9_hL9vF=q+A@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 3 Jun 2019 21:04:53 +0300
Message-ID: <CAGyAFMUqqjF67DDdr+BQXvFU515_zK=fDehUJH1TF+zjyjuiAA@...278...>
Content-Type: multipart/alternative; boundary="0000000000003f4325058a6f348c"
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

--0000000000003f4325058a6f348c
Content-Type: text/plain; charset="UTF-8"

Hi,

Here you can get the latest binary of openvpn3 test Windows client with
both wintun and tap-windows6 support.

https://ci.appveyor.com/project/openvpn/openvpn3/build/artifacts

To use it with wintun, open admin command prompt and run:

> cli.exe -w profile.ovpn

To use tap-windows6, just omit "-w" switch.

Please note that this is a development tool first of all, not a client to
be consumed by most of users.

-Lev

--0000000000003f4325058a6f348c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Here you can get t=
he latest binary of openvpn3 test Windows client with both wintun and tap-w=
indows6 support.</div><div><br></div><div><a href=3D"https://ci.appveyor.co=
m/project/openvpn/openvpn3/build/artifacts">https://ci.appveyor.com/project=
/openvpn/openvpn3/build/artifacts</a>=C2=A0</div><div><br></div><div>To use=
 it with wintun, open admin command prompt and run:</div><div><br></div><di=
v>&gt; cli.exe -w profile.ovpn<br></div><div><br></div><div>To use tap-wind=
ows6, just omit &quot;-w&quot; switch.</div><div><br></div><div>Please note=
 that this is a development tool first of all, not a client to be consumed =
by most of users.=C2=A0</div><div><br></div><div>-Lev</div></div></div>

--0000000000003f4325058a6f348c--

