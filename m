MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB0921EB1EE9D7A34FD9126BC0AB470@...2433...>
References: <DM5PR2101MB1112D9B5D70AC19014BC5BEDB0420@...2412...>
 <MW2PR2101MB09219BB9BA77ADD409D3DFECAB410@...2433...>
 <CAFHpkQHPWDfPDqiJ0_7FrMLc18q9EoC8j1NBAkYx9snXo+V0Uw@...278...>
 <MW2PR2101MB0921EB1EE9D7A34FD9126BC0AB470@...2433...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 6 Jul 2018 12:37:16 -0400
Message-ID: <CAKuzo_hzASoEx-VZHe4tV5bPHOCjNfumoKmHL+kOCSHvg_0zdw@...278...>
Subject: Re: [Openvpn-devel] Upstreaming pqcrypto changes from
 microsoft/openvpn
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
To: Kevin Kane <kkane@...2393...>
Cc: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Thanks for the follow up.

On Fri, Jul 6, 2018 at 12:03 PM, Kevin Kane via Openvpn-devel
<openvpn-devel@lists.sourceforge.net> wrote:
> [Combining threads.]
>
>
>
> The work on the OpenSSL fork, and figuring out just what the right interf=
ace
> is to bring PQ crypto to current crypto libraries, is going to be on-goin=
g.
> PQ crypto algorithms don=E2=80=99t fit so well in the common conventions =
we=E2=80=99ve
> become accustomed to for current algorithms.
>
>
>
> As for the dialer, I need to look into getting approval to upstream it, b=
ut
> I expect I can share it. The goal of that work was to have some real basic
> integration with the network connections flyout that appears when you cli=
ck
> its icon in the notification area. What I=E2=80=99ve done is modest, thou=
gh, so let
> me make clear what I=E2=80=99ve actually done. I changed OpenVPN-GUI when=
 it starts
> up to create such an entry for each configuration file it finds, and if t=
he
> user clicks =E2=80=9CConnect=E2=80=9D on one of those entries, it=E2=80=
=99s exactly the same as if
> the user brought up the right-click menu for OpenVPN-GUI=E2=80=99s icon, =
selected
> that configuration file, and clicked Connect. The plug-in sends the exact
> same Windows message to OpenVPN-GUI, which causes it to bring up its stat=
us
> window and instruct the system service to establish the connection. That=
=E2=80=99s
> it.
>
>
>
> So there are some caveats. 1) OpenVPN-GUI has to be running; the plug-in
> will complain if it=E2=80=99s not. In fact OpenVPN-GUI clears out the lis=
t when it
> exits cleanly. 2) If OpenVPN-GUI crashes, the entries will be left in the
> list but won=E2=80=99t be usable for anything. I prefix each entry with t=
he string
> =E2=80=9COpenVPN =E2=80=9C, though, and the next time it runs it will cle=
an up these
> entries. 3) Because OpenVPN uses tap-windows instead of the normal Windows
> NDIS devices for the networking, the flyout can=E2=80=99t detect whether =
or not the
> connection is active or not, and so it will always present a =E2=80=9CCon=
nect=E2=80=9D
> button. OpenVPN-GUI ignores this when the connection is already alive, so
> nothing bad happens, but it can be a confusing experience. I didn=E2=80=
=99t
> investigate what it might take to get tap-windows to surface its
> connected/disconnected state to the flyout in the correct way, nor did I
> investigate if this could be used to automatically bring up connections on
> demand or before login.

I had looked at the dialer.c code and came to the same conclusion --
that it needs a lot more work to be usable.

The dll is barebones:  implements only connect
(not even disconnect), communication with the GUI uses
PostMessage with menu-ids (flakey and one way), the GUI is not
brought to the foreground on connect, so password prompts and
other popups show minimized etc. etc.

It also pollutes the control panel -> Network connections with an entry for
each config.

As for connect before login, running the entire GUI and openvpn code as sys=
tem
is a no-no. Instead the dll can be extended with minimal code for
starting openvpn (spawning it with minimal privileges). But in that
case wont it be
better to implement the Pre-Logon_access-Provider (PLAP) interface
which appears to be
meant for such purposes?

Selva

