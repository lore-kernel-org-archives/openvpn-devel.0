Message-ID: <4D8376F0.3080202@...515...>
Date: Fri, 18 Mar 2011 17:14:56 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4D836B41.2040600@...515...>
	<AANLkTi=VPAkEkUjPWgEqZg_p+Fspuc=v5kEPe3z5LN=+@mail.gmail.com>
In-Reply-To: <AANLkTi=VPAkEkUjPWgEqZg_p+Fspuc=v5kEPe3z5LN=+@mail.gmail.com>
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Alon,

The SVN repo is only used privately by James and not used for official
releases. Link to the Git repo can be found under "OpenVPN - Snapshots
and development code" on downloads page:

<http://openvpn.net/index.php/open-source/downloads.html>

It is also linked to from the Wiki[1]. Now that I think of it, linking
visibly to the development version from the "Community Project" menu
would make sense. For example like this:

Community project
   --- Overview
   --- Downloads
   --- Development versions (link to [1])
   --- Documentation
   --- ...

What do you think?

Btw. Afaik your patch[1] is still not included in 2.2-RC2. As the tree
is not tagged yet, there's still room for it. I'll ask if James could
ACK it.

[1] <https://community.openvpn.net/openvpn/wiki/TesterDocumentation>
[2] <http://thread.gmane.org/gmane.network.openvpn.devel/4450>

--=20

Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

> Any reason why I cannot find git or svn repository for openvpn in the
> openvpn site?
> Maybe it is hidden or misplaced.
>
> 2011/3/18 Samuli Sepp=C3=A4nen <samuli@...515...>:
>=20=20=20
>> Hi all,
>>
>> First working _preview_ of 2.2-RC2 is now available. I've verified that
>> this installer works on Windows XP (32-bit) and Windows 7 (64-bit):
>>
>> <http://build.openvpn.net/downloads/releases/openvpn-2.2-RC2-install-pre=
view-3.exe>
>>
>> IMPORTANT: the included TAP-drivers are unsigned, so Windows Vista/7
>> (64-bit) won't  load them unless it's in "Test mode":
>>
>> <https://community.openvpn.net/openvpn/wiki/BuildingOnWindows#Method2:En=
ablingtestmodeontargetcomputer>
>>
>> The original plan was to release 2.2-RC2 today, but we probably have to
>> postpone release date until next week. The most important changes are:
>>
>> - Turn off ENABLE_CLIENT_ONLY build setting that disabled all server
>> functionality (turned on in 2.2-RC by mistake)
>> - Implement IPv6 in TUN mode for Windows TAP driver
>> - Fix Windows Vista/7 start menu shortcut uninstallation failure
>>
>> I would be especially interested in hearing whether server functionality
>> is now working properly. A more comprehensive changelog is attached belo=
w.
>>
>> --
>> Samuli Sepp=C3=A4nen
>> Community Manager
>> OpenVPN Technologies, Inc
>>
>> irc freenode net: mattock
>>
>> -----
>>
>> commit 0a45e8eb34b5b3ea42d740b8a516e7869b0e6ec7
>> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
>> Date:   Tue Mar 15 16:30:26 2011 +0200
>>
>>    Fixes to win/openvpn.nsi
>>
>>    Added support for generating installer with unsigned TAP drivers.
>> Fixed Windows
>>    Vista/7 Start menu shortcut uninstall failure.
>>
>>    Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>>
>> commit e0834eba4f14b26364f03166249a032e77b04489
>> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
>> Date:   Tue Mar 15 14:46:55 2011 +0200
>>
>>    Replaced config-win32.h with win/config.h.in
>>
>>    The original config-win32.h - a static header file - has been
>> superceded by both
>>    "domake-win" script and the new Python-based buildsystem.
>> Transformed it into a
>>    template file, win/config.h.in, which obtains the most commonly used
>> build
>>    parameters from win/settings.in.
>>
>>    Added support code to win/config.py and win/wb.py to preprocess
>> win/config.h.in
>>    and copy it to config.h, from where source and header files can find =
it.
>>
>>    Removed all references to config-win32.h. Also removed obsolete
>>    PACKAGE_BUGREPORT and USE_PTHREAD variables from the win/config.h.in
>> file.
>>
>>    Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>>
>> commit 00822d72c9be6ecb53b22eb42f8e54ce1a514b01
>> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
>> Date:   Tue Mar 15 14:06:56 2011 +0200
>>
>>    Updated INSTALL-win32.txt
>>
>>    Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>>
>> commit edec5c7292c59c7cdfdb46549d1fdf51d67e769b
>> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
>> Date:   Thu Feb 24 15:24:07 2011 +0200
>>
>>    Added support for prebuilt TAP-drivers. Automated embedding manifests.
>>
>>    Removed win/make_dist.py's dependency on TAP-driver and
>> tapinstall.exe building.
>>    Also added manifest embedding commands to win/make_dist.py. To avoid
>> duplicate
>>    code moved the "build_vc" method from win/build.py to win/wb.py and
>> renamed it
>>    "run_in_vs_shell".
>>
>>    Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>>
>> commit 0265cf3a6b646cc02a78cc3501dce77f99e81a5f
>> Author: Gert Doering <gert@...1296...>
>> Date:   Sun Mar 7 19:28:55 2010 +0100
>>
>>    Implement IPv6 in TUN mode for Windows TAP driver.
>>
>>    * install-win32/settings.in: bump version to 9.7, TAP_RELDATE to
>> "07/03/2010".
>>
>>    * tap-win32/proto.h: add data types and definitions needed for IPv6
>>
>>    * tap-win32/types.h: add m_UserToTap_IPv6 ethernet header for IPv6
>> packets
>>
>>    * tap-win32/tapdrvr.c: implement support for IPv6 in TUN mode:
>>         - IPv6 packets User->OS need correct ether type
>>         - IPv6 packets OS->User get correctly forwarded
>>         - IPv6 neighbour discovery packets for "fe80::8" (magic address
>>           installed as route-nexthop by OpenVPN.exe) get answered locally
>>    (cherry picked from commit 175e17a5abd5969f6803a9cc9587b7959e1100ae)
>>
>>    Signed-off-by: Gert Doering <gert@...1296...>
>>    Signed-off-by: David Sommerseth <dazo@...384...>
>>
>> ------------------------------------------------------------------------=
------
>> Colocation vs. Managed Hosting
>> A question and answer guide to determining the best fit
>> for your organization - today and in the future.
>> http://p.sf.net/sfu/internap-sfd2d
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>=20=20=20=20=20



