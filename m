From: lstipakov@...277...
Mime-Version: 1.0 (1.0)
Date: Sun, 21 Aug 2022 19:54:47 +0300
Message-Id: <30608457-10A3-470E-B079-FA58AE4C1D3D@...277...>
References: <CAKuzo_hyreVwf5DEDGQNOXNtci8pE8Kf=tBCnhw0X+Xh0PEEFQ@...278...>
In-Reply-To: <CAKuzo_hyreVwf5DEDGQNOXNtci8pE8Kf=tBCnhw0X+Xh0PEEFQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v102 3/7] dco-win: implement ovpn-dco
 support in P2P Windows code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Simon Rozman <simon@...2293...>, =?utf-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <a@...2181...>

Yes, persist-tun support is in progress and coming soon.=20

Agreed on =E2=80=9Dwindows-driver dco-win=E2=80=9D. I=E2=80=99ll send a pat=
ch.=20

L=C3=A4hetetty iPhonesta

> Selva Nair <selva.nair@...277...> kirjoitti 21.8.2022 kello 19.29:
>=20
> =EF=BB=BF
> Hi,
>=20
> Did a quick test on Windows 10 and appears to work as expected. Some mino=
r things:
>=20
> (i) I had persist-tun which caused a fatal error that required opening th=
e log file to find what's wrong and then fix the config file -- unfortunate=
ly the GUI status window cannot display such early errors. Isn't a warning =
that persist-tun is not supported enough?
>=20
> (ii) windows-driver ovpn-dco   (without the trailing -win) would be bette=
r? "windows" is already there in the option name.
>=20
> Selva

