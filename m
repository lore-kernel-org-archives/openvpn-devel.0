Message-ID: <4D4C7466.4030301@...1147...>
Date: Fri, 04 Feb 2011 22:49:26 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4D4BE51E.1050905@...515...>
In-Reply-To: <4D4BE51E.1050905@...515...>
Subject: Re: [Openvpn-devel] Help testing OpenVPN 2.2-rc Windows installer?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Samuli,

Samuli Sepp=E4nen wrote:
> Hi,
>
> As some of you may be aware, I've been working on the new Python-based
> OpenVPN Windows buildsystem; now the first fully functional OpenVPN
> installer is ready:
>
> <http://build.openvpn.net/downloads/releases/openvpn-2.2-rc-install-previ=
ew-1.exe>
>
> However, I've only done very limited testing. On Windows 7 64-bit
> platform the following seems to work:
>
> - installing and uninstalling all userspace components
> - installing and uninstalling the (64-bit) TAP driver
> - running OpenVPN as service
> - running OpenVPN using the OpenVPN-GUI
>
> I've only noticed two small issues on the Win7 64-bit platform:
>
> - uninstall does not remove the OpenVPN start menu entries properly
> (remove manually using right click -> delete)
> - "View README" at the end of install does not work
>
> Note that the installer itself is not signed, even though the TAP
> drivers are. This will be fixed in the final 2.2-rc release.
>
> Now, I'd need help in verifying that both the installer and the included
> executables work properly on all supported 32 and 64-bit Windows
> platforms (XP and later). If you can, please test the installer on some
> _non-critical system_ and report back, whether everything works properly
> or not. Once all installer bugs are squashed, I'll make the
> openvpn-2.2-rc release. After that I'll clean up my buildsystem patches,
> send them here for review and then update the Windows building Wiki page:
>
>=20=20=20
just tried it on a 32bit Windows XP SP3 machine. Installation went OK,=20
the README works but the format of the README file itself does not=20
display properly in Notepad (CR/LF problem?).

The bad news is that the binaries don't work. All binaries refuse to=20
start (openvpn.exe, openssl.exe, openvpn-gui.exe). The command-line=20
tools fail with 'Cannot execute the specified program'. The OpenVPN GUI=20
fails with an error 0xC0150002.

I have not tested whether the TAP-Win32 driver works.

share and enjoy,

JJK


