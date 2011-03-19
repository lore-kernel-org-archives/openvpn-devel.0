MIME-Version: 1.0
In-Reply-To: <4D8376F0.3080202@...515...>
References: <4D836B41.2040600@...515...>
	<AANLkTi=VPAkEkUjPWgEqZg_p+Fspuc=v5kEPe3z5LN=+@mail.gmail.com>
	<4D8376F0.3080202@...515...>
Date: Sat, 19 Mar 2011 08:24:39 +0200
Message-ID: <AANLkTimARrUoZR5-B92_c2mXgEF4QUW475ZqYuhTERU-@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] First OpenVPN 2.2-RC2 preview available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

GIT/SVN repository is expected to be published clearly in opened
source projects, just like you have Download option in menu, there
should be Source or similar.

If your git is the one that is candidate for next release, publish it,
better something than nothing.

Also, please install gitweb, so the repository can be tracked online.

You should have a branch for the "james" openvpn so people know what he ack=
ed.

Thanks,
Alon.

2011/3/18 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Hi Alon,
>
> The SVN repo is only used privately by James and not used for official
> releases. Link to the Git repo can be found under "OpenVPN - Snapshots
> and development code" on downloads page:
>
> <http://openvpn.net/index.php/open-source/downloads.html>
>
> It is also linked to from the Wiki[1]. Now that I think of it, linking
> visibly to the development version from the "Community Project" menu
> would make sense. For example like this:
>
> Community project
> =C2=A0 --- Overview
> =C2=A0 --- Downloads
> =C2=A0 --- Development versions (link to [1])
> =C2=A0 --- Documentation
> =C2=A0 --- ...
>
> What do you think?
>
> Btw. Afaik your patch[1] is still not included in 2.2-RC2. As the tree
> is not tagged yet, there's still room for it. I'll ask if James could
> ACK it.
>
> [1] <https://community.openvpn.net/openvpn/wiki/TesterDocumentation>
> [2] <http://thread.gmane.org/gmane.network.openvpn.devel/4450>
>
> --
>
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>> Any reason why I cannot find git or svn repository for openvpn in the
>> openvpn site?
>> Maybe it is hidden or misplaced.
>>
>> 2011/3/18 Samuli Sepp=C3=A4nen <samuli@...515...>:
>>
>>> Hi all,
>>>
>>> First working _preview_ of 2.2-RC2 is now available. I've verified that
>>> this installer works on Windows XP (32-bit) and Windows 7 (64-bit):
>>>
>>> <http://build.openvpn.net/downloads/releases/openvpn-2.2-RC2-install-pr=
eview-3.exe>
>>>
>>> IMPORTANT: the included TAP-drivers are unsigned, so Windows Vista/7
>>> (64-bit) won't =C2=A0load them unless it's in "Test mode":
>>>
>>> <https://community.openvpn.net/openvpn/wiki/BuildingOnWindows#Method2:E=
nablingtestmodeontargetcomputer>
>>>
>>> The original plan was to release 2.2-RC2 today, but we probably have to
>>> postpone release date until next week. The most important changes are:
>>>
>>> - Turn off ENABLE_CLIENT_ONLY build setting that disabled all server
>>> functionality (turned on in 2.2-RC by mistake)
>>> - Implement IPv6 in TUN mode for Windows TAP driver
>>> - Fix Windows Vista/7 start menu shortcut uninstallation failure
>>>
>>> I would be especially interested in hearing whether server functionality
>>> is now working properly. A more comprehensive changelog is attached bel=
ow.
>>>
>>> --
>>> Samuli Sepp=C3=A4nen
>>> Community Manager
>>> OpenVPN Technologies, Inc
>>>
>>> irc freenode net: mattock
>>>
>>> -----
>>>
>>> commit 0a45e8eb34b5b3ea42d740b8a516e7869b0e6ec7
>>> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
>>> Date: =C2=A0 Tue Mar 15 16:30:26 2011 +0200
>>>
>>> =C2=A0 =C2=A0Fixes to win/openvpn.nsi
>>>
>>> =C2=A0 =C2=A0Added support for generating installer with unsigned TAP d=
rivers.
>>> Fixed Windows
>>> =C2=A0 =C2=A0Vista/7 Start menu shortcut uninstall failure.
>>>
>>> =C2=A0 =C2=A0Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>>>
>>> commit e0834eba4f14b26364f03166249a032e77b04489
>>> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
>>> Date: =C2=A0 Tue Mar 15 14:46:55 2011 +0200
>>>
>>> =C2=A0 =C2=A0Replaced config-win32.h with win/config.h.in
>>>
>>> =C2=A0 =C2=A0The original config-win32.h - a static header file - has b=
een
>>> superceded by both
>>> =C2=A0 =C2=A0"domake-win" script and the new Python-based buildsystem.
>>> Transformed it into a
>>> =C2=A0 =C2=A0template file, win/config.h.in, which obtains the most com=
monly used
>>> build
>>> =C2=A0 =C2=A0parameters from win/settings.in.
>>>
>>> =C2=A0 =C2=A0Added support code to win/config.py and win/wb.py to prepr=
ocess
>>> win/config.h.in
>>> =C2=A0 =C2=A0and copy it to config.h, from where source and header file=
s can find it.
>>>
>>> =C2=A0 =C2=A0Removed all references to config-win32.h. Also removed obs=
olete
>>> =C2=A0 =C2=A0PACKAGE_BUGREPORT and USE_PTHREAD variables from the win/c=
onfig.h.in
>>> file.
>>>
>>> =C2=A0 =C2=A0Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>>>
>>> commit 00822d72c9be6ecb53b22eb42f8e54ce1a514b01
>>> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
>>> Date: =C2=A0 Tue Mar 15 14:06:56 2011 +0200
>>>
>>> =C2=A0 =C2=A0Updated INSTALL-win32.txt
>>>
>>> =C2=A0 =C2=A0Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>>>
>>> commit edec5c7292c59c7cdfdb46549d1fdf51d67e769b
>>> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
>>> Date: =C2=A0 Thu Feb 24 15:24:07 2011 +0200
>>>
>>> =C2=A0 =C2=A0Added support for prebuilt TAP-drivers. Automated embeddin=
g manifests.
>>>
>>> =C2=A0 =C2=A0Removed win/make_dist.py's dependency on TAP-driver and
>>> tapinstall.exe building.
>>> =C2=A0 =C2=A0Also added manifest embedding commands to win/make_dist.py=
. To avoid
>>> duplicate
>>> =C2=A0 =C2=A0code moved the "build_vc" method from win/build.py to win/=
wb.py and
>>> renamed it
>>> =C2=A0 =C2=A0"run_in_vs_shell".
>>>
>>> =C2=A0 =C2=A0Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>>>
>>> commit 0265cf3a6b646cc02a78cc3501dce77f99e81a5f
>>> Author: Gert Doering <gert@...1296...>
>>> Date: =C2=A0 Sun Mar 7 19:28:55 2010 +0100
>>>
>>> =C2=A0 =C2=A0Implement IPv6 in TUN mode for Windows TAP driver.
>>>
>>> =C2=A0 =C2=A0* install-win32/settings.in: bump version to 9.7, TAP_RELD=
ATE to
>>> "07/03/2010".
>>>
>>> =C2=A0 =C2=A0* tap-win32/proto.h: add data types and definitions needed=
 for IPv6
>>>
>>> =C2=A0 =C2=A0* tap-win32/types.h: add m_UserToTap_IPv6 ethernet header =
for IPv6
>>> packets
>>>
>>> =C2=A0 =C2=A0* tap-win32/tapdrvr.c: implement support for IPv6 in TUN m=
ode:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - IPv6 packets User->OS need correct ether =
type
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - IPv6 packets OS->User get correctly forwa=
rded
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - IPv6 neighbour discovery packets for "fe8=
0::8" (magic address
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 installed as route-nexthop by OpenVP=
N.exe) get answered locally
>>> =C2=A0 =C2=A0(cherry picked from commit 175e17a5abd5969f6803a9cc9587b79=
59e1100ae)
>>>
>>> =C2=A0 =C2=A0Signed-off-by: Gert Doering <gert@...1296...>
>>> =C2=A0 =C2=A0Signed-off-by: David Sommerseth <dazo@...384...>
>>>
>>> -----------------------------------------------------------------------=
-------
>>> Colocation vs. Managed Hosting
>>> A question and answer guide to determining the best fit
>>> for your organization - today and in the future.
>>> http://p.sf.net/sfu/internap-sfd2d
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>>>
>
>
>

