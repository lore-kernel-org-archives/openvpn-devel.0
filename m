References: <CAFHpkQFNHWNWZsw+vN=HUQA_MgMEAX9LMa3FMKfoCpTps2k2AQ@...278...>
	<CAKuzo_isuFn2dC6hZ-bqP2aMF8j_mxgStXctAzC-RayEkBUTbw@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <d4f8578f-149a-0f13-b1d7-8f763b590966@...515...>
Date: Thu, 9 Jun 2016 09:16:06 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_isuFn2dC6hZ-bqP2aMF8j_mxgStXctAzC-RayEkBUTbw@...278...>
Subject: Re: [Openvpn-devel] how snapshot installers are built ?
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
To: Selva Nair <selva.nair@...277...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0Lg=?= =?UTF-8?B?0YbQuNC9?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

> Hi,
>
>
>     I see daily builds like
>
>
>     http://build.openvpn.net/downloads/snapshots/openvpn-install-master-2=
0160607214911-63b3e000c9-x86_64.exe
>
>
>     I used to think they are built with "build-snapshot":
>     https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/bui=
ld-snapshot
>
>     however, when I run it,
>
>
>     ....
>     tap-windows
>     Fixup libtool files
>     Restore libtool files
>     Fixup libtool files
>     Build openvpn
>     ../generic/build: line 284: cd:
>     /home/ilia/openvpn-build/windows-nsis/tmp/build-i686/openvpn-2.3.11:
>     No such file or directory
>     FATAL: cd openvpn
>     FATAL: build i686 >&2
>     FATAL: build-complete >&2
>     [ilia@...23... windows-nsis]$
>
>
>     somehow it tries to find openvpn-2.3.11 instead of master.
>
>
>     how am I supposed to run that script ?

The build-snapshot script is a simple wrapper around build-complete,=20
which is why it failed. You basically need to use

OPENVPN_VERSION=3D2.3_git build-snapshot <args>

Basically build-snapshot creates a tarball from Git sources and feeds=20
that to build-complete for the build.

> Samuli had posted a link to
>  https://github.com/mattock/openvpn-windows-buildtest which, I think,
> has the necessary scripts to use with openvpn-build for daily snapshot
> building..
>
> Selva

Those scripts are indeed the ones I use to generate the Windows=20
installer snapshots.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

