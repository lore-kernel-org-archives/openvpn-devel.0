Message-ID: <51028EBC.9090802@...515...>
Date: Fri, 25 Jan 2013 15:55:08 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <047Rawoli0656S06.1358951888@...1802...>
In-Reply-To: <047Rawoli0656S06.1358951888@...1802...>
Subject: Re: [Openvpn-devel] Windows 2.3 builds lack TAP driver utilities
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
To: Josh Cepek <josh.cepek@...1085...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Josh,

Thanks for reporting this! I added a bug report here:

<https://community.openvpn.net/openvpn/ticket/255>

I got some other NSI fixes[1] in the queue, and will take care of this
one also.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1]

<https://community.openvpn.net/openvpn/ticket/249>
<https://community.openvpn.net/openvpn/ticket/252>

> The Windows installer for 2.3 (both 32 and 64-bit versions) no longer ins=
talls
> the TAP-Win32 utility scripts by default (addtap.bat & deltapall.bat.) Th=
ese
> scripts are required for end-users to manage TAP adapters, and specifical=
ly to
> install more than 1 adapter if use of multiple VPNs is required.
>
> These scripts used to be installed under the .\bin\ path in <=3D2.2.2. In=
 2.3.0
> this appears to have been logically split into a separate installer,
> tap-windows.exe, which has its own installation directory. By default, th=
is
> installer does not install the optional "Utilities" feature, which causes
> these 2 batch files to be missing. As this tap-windows component installa=
tion
> is performed silently during OpenVPN installation, this option is never
> presented to the user.
>
> According to the NSIS source[1], this flag should be passed to the embedd=
ed
> tap-windows installer in recent versions of the build script. Looking at =
the
> way the program call is made using Process Explorer (PE) using the 2.3.0
> release, the indicated line in the NSIS source doesn't match the 2.3.0 re=
lease
> package. Compare that line with what PE shows during installation:
> "C:\DOCUME~1\TestUser\LOCALS~1\Temp\tap-windows.exe" /S
>
> The source changes for the tap-windows project's own NSIS file[2] also ap=
pear
> to have been changed recently enough (similar timeline to the openvpn-bui=
ld
> NSIS changes) that it may also need to be built from a recent source copy=
 to
> get the correct macro (SelectByParameter) support required to support the
> /SELECT_UTILITIES feature flag.
>
> Unless I've missed something in the sources, it would appear the 2.3.0 bu=
ild
> lacks a recent enough version of the openvpn.nsis script. The solution sh=
ould
> be to re-package both installers with recent versions of the NSIS sources.
> Expected results are both TAP-Win32 utility batch files installed by defa=
ult
> during a silent installation of tap-windows.
>
> [1]
> https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn=
.nsi#L243
>
> [2]
> https://github.com/OpenVPN/tap-windows/blob/master/installer/tap-windows.=
nsi#L168
>
> --
> Josh
>
>
> -------------------------------------------------------------------------=
-----
> Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
> MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
> with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
> MVPs and experts. ON SALE this month only -- learn more at:
> http://p.sf.net/sfu/learnnow-d2d
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



