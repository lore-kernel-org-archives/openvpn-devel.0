From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5718DD61.8020509@...515...>
Date: Thu, 21 Apr 2016 17:02:09 +0300
MIME-Version: 1.0
Subject: [Openvpn-devel] Tap-windows-9.21.2 installers available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Tap-windows-9.21.2 installer is now available here:

<http://build.openvpn.net/downloads/releases/tap-windows-9.21.2.exe>

The driver files are also available separately:

<http://build.openvpn.net/downloads/releases/tap-windows-9.21.2.tar.gz>
<http://build.openvpn.net/downloads/releases/tap-windows-9.21.2.zip>

GnuPG signatures are also available - just add .asc to the file's URL.

I'll produce new OpenVPN Windows installers containing this new=20
tap-windows6 driver soonish, next week probably. If you want, you can=20
test the driver beforehand to make sure it works ok. That said, earlier=20
drivers created with the same process have been fairly extensively=20
tested[1]. However, the installer has not yet been tested at all, though=20
it should work just fine.

All the executables (installer, tapinstall.exe) and driver catalog files=20
have dual signatures and _should_ work on all Windows versions from=20
Vista onwards.

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1] See "tap6-dual-sha1-sha2ev" here:

<https://community.openvpn.net/openvpn/wiki/TapWindows6CodesignTests>

