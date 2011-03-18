MIME-Version: 1.0
In-Reply-To: <4D836B41.2040600@...515...>
References: <4D836B41.2040600@...515...>
Date: Fri, 18 Mar 2011 16:59:15 +0200
Message-ID: <AANLkTi=VPAkEkUjPWgEqZg_p+Fspuc=v5kEPe3z5LN=+@mail.gmail.com>
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

Any reason why I cannot find git or svn repository for openvpn in the
openvpn site?
Maybe it is hidden or misplaced.

2011/3/18 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Hi all,
>
> First working _preview_ of 2.2-RC2 is now available. I've verified that
> this installer works on Windows XP (32-bit) and Windows 7 (64-bit):
>
> <http://build.openvpn.net/downloads/releases/openvpn-2.2-RC2-install-prev=
iew-3.exe>
>
> IMPORTANT: the included TAP-drivers are unsigned, so Windows Vista/7
> (64-bit) won't =C2=A0load them unless it's in "Test mode":
>
> <https://community.openvpn.net/openvpn/wiki/BuildingOnWindows#Method2:Ena=
blingtestmodeontargetcomputer>
>
> The original plan was to release 2.2-RC2 today, but we probably have to
> postpone release date until next week. The most important changes are:
>
> - Turn off ENABLE_CLIENT_ONLY build setting that disabled all server
> functionality (turned on in 2.2-RC by mistake)
> - Implement IPv6 in TUN mode for Windows TAP driver
> - Fix Windows Vista/7 start menu shortcut uninstallation failure
>
> I would be especially interested in hearing whether server functionality
> is now working properly. A more comprehensive changelog is attached below.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
> -----
>
> commit 0a45e8eb34b5b3ea42d740b8a516e7869b0e6ec7
> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
> Date: =C2=A0 Tue Mar 15 16:30:26 2011 +0200
>
> =C2=A0 =C2=A0Fixes to win/openvpn.nsi
>
> =C2=A0 =C2=A0Added support for generating installer with unsigned TAP dri=
vers.
> Fixed Windows
> =C2=A0 =C2=A0Vista/7 Start menu shortcut uninstall failure.
>
> =C2=A0 =C2=A0Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>
> commit e0834eba4f14b26364f03166249a032e77b04489
> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
> Date: =C2=A0 Tue Mar 15 14:46:55 2011 +0200
>
> =C2=A0 =C2=A0Replaced config-win32.h with win/config.h.in
>
> =C2=A0 =C2=A0The original config-win32.h - a static header file - has been
> superceded by both
> =C2=A0 =C2=A0"domake-win" script and the new Python-based buildsystem.
> Transformed it into a
> =C2=A0 =C2=A0template file, win/config.h.in, which obtains the most commo=
nly used
> build
> =C2=A0 =C2=A0parameters from win/settings.in.
>
> =C2=A0 =C2=A0Added support code to win/config.py and win/wb.py to preproc=
ess
> win/config.h.in
> =C2=A0 =C2=A0and copy it to config.h, from where source and header files =
can find it.
>
> =C2=A0 =C2=A0Removed all references to config-win32.h. Also removed obsol=
ete
> =C2=A0 =C2=A0PACKAGE_BUGREPORT and USE_PTHREAD variables from the win/con=
fig.h.in
> file.
>
> =C2=A0 =C2=A0Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>
> commit 00822d72c9be6ecb53b22eb42f8e54ce1a514b01
> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
> Date: =C2=A0 Tue Mar 15 14:06:56 2011 +0200
>
> =C2=A0 =C2=A0Updated INSTALL-win32.txt
>
> =C2=A0 =C2=A0Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>
> commit edec5c7292c59c7cdfdb46549d1fdf51d67e769b
> Author: Samuli Sepp=C3=A4nen <samuli@...515...>
> Date: =C2=A0 Thu Feb 24 15:24:07 2011 +0200
>
> =C2=A0 =C2=A0Added support for prebuilt TAP-drivers. Automated embedding =
manifests.
>
> =C2=A0 =C2=A0Removed win/make_dist.py's dependency on TAP-driver and
> tapinstall.exe building.
> =C2=A0 =C2=A0Also added manifest embedding commands to win/make_dist.py. =
To avoid
> duplicate
> =C2=A0 =C2=A0code moved the "build_vc" method from win/build.py to win/wb=
.py and
> renamed it
> =C2=A0 =C2=A0"run_in_vs_shell".
>
> =C2=A0 =C2=A0Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
>
> commit 0265cf3a6b646cc02a78cc3501dce77f99e81a5f
> Author: Gert Doering <gert@...1296...>
> Date: =C2=A0 Sun Mar 7 19:28:55 2010 +0100
>
> =C2=A0 =C2=A0Implement IPv6 in TUN mode for Windows TAP driver.
>
> =C2=A0 =C2=A0* install-win32/settings.in: bump version to 9.7, TAP_RELDAT=
E to
> "07/03/2010".
>
> =C2=A0 =C2=A0* tap-win32/proto.h: add data types and definitions needed f=
or IPv6
>
> =C2=A0 =C2=A0* tap-win32/types.h: add m_UserToTap_IPv6 ethernet header fo=
r IPv6
> packets
>
> =C2=A0 =C2=A0* tap-win32/tapdrvr.c: implement support for IPv6 in TUN mod=
e:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - IPv6 packets User->OS need correct ether ty=
pe
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - IPv6 packets OS->User get correctly forward=
ed
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - IPv6 neighbour discovery packets for "fe80:=
:8" (magic address
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 installed as route-nexthop by OpenVPN.=
exe) get answered locally
> =C2=A0 =C2=A0(cherry picked from commit 175e17a5abd5969f6803a9cc9587b7959=
e1100ae)
>
> =C2=A0 =C2=A0Signed-off-by: Gert Doering <gert@...1296...>
> =C2=A0 =C2=A0Signed-off-by: David Sommerseth <dazo@...384...>
>
> -------------------------------------------------------------------------=
-----
> Colocation vs. Managed Hosting
> A question and answer guide to determining the best fit
> for your organization - today and in the future.
> http://p.sf.net/sfu/internap-sfd2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

