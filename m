Message-ID: <50F80441.6060407@...515...>
Date: Thu, 17 Jan 2013 16:01:37 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CABT9mj_oAJ6sRy0_TKrWBVdN5OeTBVwC+-GmAkHbUPmpi=j5HQ@...278...>
	<20130116101123.GU22465@...1296...>
	<CABT9mj_MjH3Bo9tq0ahpnnA8rWh+a3UOaTH9DPgATq+ZJ_6YDQ@...278...>
In-Reply-To: <CABT9mj_MjH3Bo9tq0ahpnnA8rWh+a3UOaTH9DPgATq+ZJ_6YDQ@...278...>
Subject: Re: [Openvpn-devel] compiling with visual studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Athanasios Douitsis <aduitsis@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Athanasios,

> Right, so this is because c99 and VS don't mix. Thanks very much Gert.
>
> To explain why I'm trying to do this: Our institution uses OpenVPN to
> provide remote access (e.g. access to electronic libraries, etc) to
> its users. So we used to build openvpn and package it very very
> similarly to the official release (we were using msys and nsis) along
> with a couple of our conf files. However, domake-win has been removed
> in 2.3 so I am trying to figure out the best way to do it. What would
> be ideal would be the thing that tunnelblick does with deployed mode
> (http://code.google.com/p/tunnelblick/wiki/cCusDeployed). The admin
> does not have to build anything, just open the package and drop a
> deploy folder to the appropriate location. Sadly the windows package
> does not include something similar, so lots of work need to be done to
> build a customized package.
>
I'll look into current status of openvpn-build/msvc and setup a Windows
buildslave to ensure it stays in working order. I really haven't touched
that buildsystem after doing the initial testing way back when.

The official Windows packages have been cross-compiled on Ubuntu 12.04
64-bit. As you used "domake-win" earlier, I'd suggest you set up a
cross-compilation box, too:

<https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem=
#Cross-compilingonNIXgenericsubdir>
<https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem=
#CreatingaNSISinstallerwindows-nsissubdir>

After the build environment has been setup, you will need to customize
two files:

- openvpn-build/windows-nsis/build-complete.vars
- openvpn-build/generic/build.vars

Alternatively, you can override the values in them using environment
variables. Most of the dependencies for openvpn-build are available here:

<http://build.openvpn.net/downloads/releases>

You can modify openvpn-build/windows-nsis/openvpn.nsi to install custom
files/directories using "File /r":

<http://nsis.sourceforge.net/Docs/Chapter4.html#4.9.1.5>

If you have any issues setting up a cross-compilation box, just let me know.

> BTW, if you are referring to
>
> https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsyste=
m#BuildingnativelyonWindowsusingtheMSVCtoolchainmsvcsubdir
>
> I am sorry to say that the info on this page outdated, one has to do
> quite a few things differently to proceed. The biggest gripe is that
> the scripts that are mentioned try to download stuff directly from
> github but github has changed the way it exposes its files. In
> addition, it tries to download some files from Alon's repo and not
> from the official openvpn repo. And now that I mention it, I think
> that the github repo is not synced to the official git so 2.3 is not
> really available there.

The build configuration can and should be changed. That said, I think
openvpn-build default values should make sense, i.e. work out of the
box. I'll send a patch that fixes this.

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


