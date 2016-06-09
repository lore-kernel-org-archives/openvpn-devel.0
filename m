References: <CAFHpkQFNHWNWZsw+vN=HUQA_MgMEAX9LMa3FMKfoCpTps2k2AQ@...278...>
	<CAKuzo_isuFn2dC6hZ-bqP2aMF8j_mxgStXctAzC-RayEkBUTbw@...278...>
	<d4f8578f-149a-0f13-b1d7-8f763b590966@...515...>
	<CAFHpkQGzt=jGdBF=Xp59dNnE-1g9TYyjih9P0KxXnUk8Zx-6UQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <e98c1127-1e38-ce15-cdab-63eb217526bb@...515...>
Date: Thu, 9 Jun 2016 09:51:54 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGzt=jGdBF=Xp59dNnE-1g9TYyjih9P0KxXnUk8Zx-6UQ@...278...>
Subject: Re: [Openvpn-devel] how snapshot installers are built ?
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

>
>             I see daily builds like
>
>
>
>         http://build.openvpn.net/downloads/snapshots/openvpn-install-mast=
er-20160607214911-63b3e000c9-x86_64.exe
>
>
>             I used to think they are built with "build-snapshot":
>
>         https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis=
/build-snapshot
>
>             however, when I run it,
>
>
>             ....
>             tap-windows
>             Fixup libtool files
>             Restore libtool files
>             Fixup libtool files
>             Build openvpn
>             ../generic/build: line 284: cd:
>
>         /home/ilia/openvpn-build/windows-nsis/tmp/build-i686/openvpn-2.3.=
11:
>             No such file or directory
>             FATAL: cd openvpn
>             FATAL: build i686 >&2
>             FATAL: build-complete >&2
>             [ilia@...23... windows-nsis]$
>
>
>             somehow it tries to find openvpn-2.3.11 instead of master.
>
>
>             how am I supposed to run that script ?
>
>
>     The build-snapshot script is a simple wrapper around build-complete,
>     which is why it failed. You basically need to use
>
>     OPENVPN_VERSION=3D2.3_git build-snapshot <args>
>
>
>
> I've managed to build snapshot by hands (I found guide on wiki)
> however, I used to think that I either run that script and it builds or
> it says me "please specify OPENVPN_VERSION..."
>
>
> I'll try to make a patch if I would have time

Excellent idea, in particular because this tends to hit people quite=20
often. Basically you could either check that the value of=20
OPENVPN_VERSION matches the value in version.m4, or even better, set the=20
value from version.m4 automatically when using build-snapshot.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

