References: <CAFHpkQH9Jq2bvXbCFh-xHfRBZWU4kkPW61U6BThWA5yiC1=_MA@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5726FE8F.3050108@...515...>
Date: Mon, 2 May 2016 10:15:27 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQH9Jq2bvXbCFh-xHfRBZWU4kkPW61U6BThWA5yiC1=_MA@...278...>
Subject: Re: [Openvpn-devel] compiling openvpn-gui artifacts on PR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hello,
>
> what do you think if we involve circle ci for compiling PR ?
> it is know to keep artifacts
>
> https://circleci.com/gh/chipitsine/openvpn-gui-circleci/12#artifacts
>
> https://circleci.com/gh/chipitsine/openvpn-gui-circleci/10#artifacts
>
> I haven't figured out how to report automatically to github "test just
> compiled exe", but it look better (currently Samuli compiles exe and
> upload them somewhere)

So this Circle CI would be an alternative to Travis CI? Or was it so=20
that Travis is unable to build PRs?

The downloads you referred to are here, btw:

<http://build.openvpn.net/downloads/snapshots/>

There are builds for both the "master" and "release/2.3" branch. The=20
installers are produced using a custom script that goes through the=20
entire openvpn-build build chain. Replicating that very complex process=20
using a "real" CI system would not be worth the effort imho.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

