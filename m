Date: Wed, 23 Jan 2013 08:38:08 -0600
From: "Josh Cepek" <josh.cepek@...1085...>
Mime-Version: 1.0
Message-ID: <047Rawoli0656S06.1358951888@...1802...>
Subject: [Openvpn-devel] Windows 2.3 builds lack TAP driver utilities
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
To: openvpn-devel@lists.sourceforge.net

The Windows installer for 2.3 (both 32 and 64-bit versions) no longer insta=
lls
the TAP-Win32 utility scripts by default (addtap.bat & deltapall.bat.) These
scripts are required for end-users to manage TAP adapters, and specifically=
 to
install more than 1 adapter if use of multiple VPNs is required.

These scripts used to be installed under the .\bin\ path in <=3D2.2.2. In 2=
.3.0
this appears to have been logically split into a separate installer,
tap-windows.exe, which has its own installation directory. By default, this
installer does not install the optional "Utilities" feature, which causes
these 2 batch files to be missing. As this tap-windows component installati=
on
is performed silently during OpenVPN installation, this option is never
presented to the user.

According to the NSIS source[1], this flag should be passed to the embedded
tap-windows installer in recent versions of the build script. Looking at the
way the program call is made using Process Explorer (PE) using the 2.3.0
release, the indicated line in the NSIS source doesn't match the 2.3.0 rele=
ase
package. Compare that line with what PE shows during installation:
"C:\DOCUME~1\TestUser\LOCALS~1\Temp\tap-windows.exe" /S

The source changes for the tap-windows project's own NSIS file[2] also appe=
ar
to have been changed recently enough (similar timeline to the openvpn-build
NSIS changes) that it may also need to be built from a recent source copy to
get the correct macro (SelectByParameter) support required to support the
/SELECT_UTILITIES feature flag.

Unless I've missed something in the sources, it would appear the 2.3.0 build
lacks a recent enough version of the openvpn.nsis script. The solution shou=
ld
be to re-package both installers with recent versions of the NSIS sources.
Expected results are both TAP-Win32 utility batch files installed by default
during a silent installation of tap-windows.

[1]
https://github.com/OpenVPN/openvpn-build/blob/master/windows-nsis/openvpn.n=
si#L243

[2]
https://github.com/OpenVPN/tap-windows/blob/master/installer/tap-windows.ns=
i#L168

--
Josh


