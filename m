MIME-Version: 1.0
References: <51d6f746-c379-3cba-d204-103d722f1fde@...515...>
In-Reply-To: <51d6f746-c379-3cba-d204-103d722f1fde@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 23 Apr 2019 11:50:28 -0400
Message-ID: <CAKuzo_i3xee94jgGBZFgcpXkU5eZuQrbrVO09+Fbp7ApX1rn2Q@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sat, Apr 20, 2019 at 5:17 AM Samuli Sepp=C3=A4nen <samuli@...515...> wro=
te:
>
> Hi all,
>
> Here are completely untested OpenVPN 2.4.7 installers which I wanted to
> get out for testing a.s.a.p.:
>
> <https://build.openvpn.net/downloads/releases/openvpn-install-2.4.7-I604-=
Win7.exe>
> <https://build.openvpn.net/downloads/releases/openvpn-install-2.4.7-I604-=
Win10.exe>
>
> As the name implies, there is a different version for Windows 7 (plus
> 8/8.1/Server 2012r2) and for Windows 10 (all versions). This is
> necessary due to code signatures in the tap-windows6 driver.
>
> The above installers bundle the following components:
>
> - tap-windows6 9.23.2 (many improvements incl. arm64 support)
> - openvpn-gui 11 (latest from Git master)
> - openvpnserv2 1.4.0.0 (latest from Git master)
>
> If you want to just test the tap-windows6 installers they're here:
>
> <https://build.openvpn.net/downloads/releases/tap-windows-9.23.2-I601-Win=
7.exe>
> <https://build.openvpn.net/downloads/releases/tap-windows-9.23.2-I601-Win=
10.exe>
>
> The latter installer _might_ work on Windows 10-based ARM64 devices, but
> that has not been tested at all.
>
> I will run my pre-release tests as soon as I can, but probably not
> today. Any help in testing these would be most welcome!


Sorry for the delayed response: this installer doesn't work for me on
Windows 10. Installation of TAP driver fails with a cryptic message
"An error occurred" and nothing in setupapi logs.

On further tests, one issue is that tapinstall.exe now depends on
VCRUNTIME140.dll which is not present in stock Windows. Probably
that's what causes the failure.

Selva

