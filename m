References: <51d6f746-c379-3cba-d204-103d722f1fde@...515...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <eed7dde7-46b9-2c66-d57a-9681100c0bee@...277...>
Date: Sat, 20 Apr 2019 14:14:54 +0100
MIME-Version: 1.0
In-Reply-To: <51d6f746-c379-3cba-d204-103d722f1fde@...515...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] New OpenVPN 2.4.7 installers with tap-windows6
 and other componets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Tested and working, 32bit Win7 install over a previous install.

On 20/04/2019 10:16, Samuli Sepp=E4nen wrote:
> Hi all,
>=20
> Here are completely untested OpenVPN 2.4.7 installers which I wanted to
> get out for testing a.s.a.p.:
>=20
> <https://build.openvpn.net/downloads/releases/openvpn-install-2.4.7-I604-=
Win7.exe>
> <https://build.openvpn.net/downloads/releases/openvpn-install-2.4.7-I604-=
Win10.exe>
>=20
> As the name implies, there is a different version for Windows 7 (plus
> 8/8.1/Server 2012r2) and for Windows 10 (all versions). This is
> necessary due to code signatures in the tap-windows6 driver.
>=20
> The above installers bundle the following components:
>=20
> - tap-windows6 9.23.2 (many improvements incl. arm64 support)
> - openvpn-gui 11 (latest from Git master)
> - openvpnserv2 1.4.0.0 (latest from Git master)
>=20
> If you want to just test the tap-windows6 installers they're here:
>=20
> <https://build.openvpn.net/downloads/releases/tap-windows-9.23.2-I601-Win=
7.exe>
> <https://build.openvpn.net/downloads/releases/tap-windows-9.23.2-I601-Win=
10.exe>
>=20
> The latter installer _might_ work on Windows 10-based ARM64 devices, but
> that has not been tested at all.
>=20
> I will run my pre-release tests as soon as I can, but probably not
> today. Any help in testing these would be most welcome!
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

