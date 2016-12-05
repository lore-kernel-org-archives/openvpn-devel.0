References: <CAKuzo_jj4H3toE0JXp-HNKBH5=Y_iXqVPKOndkycFTYmQoL0=g@...278...>
	<CAFHpkQEj2h4wwV056vy3dk4BBE=LuOoRtSqwMFonstY8RPNLYA@...278...>
	<ac786c37-b52a-cb6d-dc5b-31764db832d5@...2080...>
	<CAKuzo_iOeHQUbJ8HdpEyAbGSQYPF5GaG81Dm9P2cCMNJ-PUN9A@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <845c3c82-6f15-19bf-bcfa-c81b514c7941@...515...>
Date: Mon, 5 Dec 2016 20:30:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iOeHQUbJ8HdpEyAbGSQYPF5GaG81Dm9P2cCMNJ-PUN9A@...278...>
Subject: Re: [Openvpn-devel] The windows installer and interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 05/12/2016 05:06, Selva Nair ha scritto:
>
> On Sun, Dec 4, 2016 at 6:20 PM, David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>> wrote:
>
>     Be brave, settle for some really reasonable defaults we would prefer.
>     Ship it and see how it is perceived.  If there are issues, we can res=
pin
>     a new installer with modified defaults regardless of the core OpenVPN
>     release schedule.
>
>
>
> Totally agree. For starters let's install interactive service as a part
> of openvpn core -- its good for users and cant hurt anyone.
>
> Selva
>

An installer that implements the suggested changes is available here:

<http://build.openvpn.net/downloads/snapshots/openvpn-install-2.4_rc1-I601-=
openvpn-build-pr58.exe>

I tested the installer myself on Windows 7 Pro and it "seemed to work=20
fine". More testing would of course be welcome, especially with=20
non-default options.

As the name of the installer implies it is based on this PR:

<https://github.com/OpenVPN/openvpn-build/pull/58>

I reviewed the changes and they seemed reasonable. Note that that the=20
CoreSetup function will go away in the final version; Selva added it=20
just to ease review.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

