References: <CABT9mj_oAJ6sRy0_TKrWBVdN5OeTBVwC+-GmAkHbUPmpi=j5HQ@...278...>
	<20130116101123.GU22465@...1296...>
	<CABT9mj_MjH3Bo9tq0ahpnnA8rWh+a3UOaTH9DPgATq+ZJ_6YDQ@...278...>
	<50F80441.6060407@...515...>
In-Reply-To: <50F80441.6060407@...515...>
Mime-Version: 1.0 (1.0)
Message-Id: <994BD26D-4B6E-427E-AD47-BEA12119EDEC@...277...>
From: Athanasios Douitsis <aduitsis@...277...>
Date: Fri, 18 Jan 2013 00:10:41 +0200
Subject: Re: [Openvpn-devel] compiling with visual studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



17 =CE=99=CE=B1=CE=BD 2013, 4:01 =CE=BC.=CE=BC., =CE=BF/=CE=B7 Samuli Sepp=
=C3=A4nen <samuli@...515...> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:

> Hi Athanasios,
>=20
>> Right, so this is because c99 and VS don't mix. Thanks very much Gert.
>>=20
>> To explain why I'm trying to do this: Our institution uses OpenVPN to
>> provide remote access (e.g. access to electronic libraries, etc) to
>> its users. So we used to build openvpn and package it very very
>> similarly to the official release (we were using msys and nsis) along
>> with a couple of our conf files. However, domake-win has been removed
>> in 2.3 so I am trying to figure out the best way to do it. What would
>> be ideal would be the thing that tunnelblick does with deployed mode
>> (http://code.google.com/p/tunnelblick/wiki/cCusDeployed). The admin
>> does not have to build anything, just open the package and drop a
>> deploy folder to the appropriate location. Sadly the windows package
>> does not include something similar, so lots of work need to be done to
>> build a customized package.
>>=20
> I'll look into current status of openvpn-build/msvc and setup a Windows
> buildslave to ensure it stays in working order. I really haven't touched
> that buildsystem after doing the initial testing way back when.
>=20
> The official Windows packages have been cross-compiled on Ubuntu 12.04
> 64-bit. As you used "domake-win" earlier, I'd suggest you set up a
> cross-compilation box, too:
>=20
> <https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsyst=
em#Cross-compilingonNIXgenericsubdir>
> <https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsyst=
em#CreatingaNSISinstallerwindows-nsissubdir>
>=20
> After the build environment has been setup, you will need to customize
> two files:
>=20
> - openvpn-build/windows-nsis/build-complete.vars
> - openvpn-build/generic/build.vars
>=20
> Alternatively, you can override the values in them using environment
> variables. Most of the dependencies for openvpn-build are available here:
>=20
> <http://build.openvpn.net/downloads/releases>
>=20
> You can modify openvpn-build/windows-nsis/openvpn.nsi to install custom
> files/directories using "File /r":
>=20
> <http://nsis.sourceforge.net/Docs/Chapter4.html#4.9.1.5>
>=20
> If you have any issues setting up a cross-compilation box, just let me kn=
ow.
>=20
>> BTW, if you are referring to
>>=20
>> https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsyst=
em#BuildingnativelyonWindowsusingtheMSVCtoolchainmsvcsubdir
>>=20
>> I am sorry to say that the info on this page outdated, one has to do
>> quite a few things differently to proceed. The biggest gripe is that
>> the scripts that are mentioned try to download stuff directly from
>> github but github has changed the way it exposes its files. In
>> addition, it tries to download some files from Alon's repo and not
>> from the official openvpn repo. And now that I mention it, I think
>> that the github repo is not synced to the official git so 2.3 is not
>> really available there.
>=20
> The build configuration can and should be changed. That said, I think
> openvpn-build default values should make sense, i.e. work out of the
> box. I'll send a patch that fixes this.

Hi,

First of thanks for taking the time to write a very comprehensive response,=
 much appreciated.=20

Although I have already succeeded with the msvc build, the idea of having a=
 dedicated vm doing building and packaging seems very agreeable. I'll be su=
re to get back to you if there are any questions.=20

Best regards and thanks,
Athanasios=20




>=20
> Best regards,
>=20
> --=20
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock
>=20

