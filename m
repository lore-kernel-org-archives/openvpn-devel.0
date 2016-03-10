From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56E185E9.60506@...515...>
Date: Thu, 10 Mar 2016 16:34:17 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] Windows installer with SHA-256 signatures ready for
	testing
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

Here are new Windows 2.3.10 installers with OpenSSL 1.0.1s and SHA-2=20
signatures:

<http://build.openvpn.net/downloads/temp/openvpn-install-2.3.10-I603-i686.e=
xe>
<http://build.openvpn.net/downloads/temp/openvpn-install-2.3.10-I603-x86_64=
.exe>

I tested the latter lightly on Windows 7 Pro 64-bit and it seemed to=20
work just fine and the signatures seemed to be correct. However, more=20
testing is required before these installers can be officially released.

There is potentially a severe issue which manifests itself on Windows=20
Vista SP2 / Windows Server 2008 SP2:

<https://support.microsoft.com/en-us/kb/2763674>

A second problem should be limited to Windows 7 and Windows Server 2008=20
R2 installations that are booted through a non-Windows bootloader (e.g.=20
grub):

<https://support.microsoft.com/en-us/kb/3033929>

Let me know if you can confirm or discredit either of these issues -=20
that would help us get the new installers released soon.

Thanks,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

PS. The tap-windows6 driver in the installers is still the old one=20
signed with SHA-1. I'm working on signing it with an EV certificatte, so=20
that Windows 10 accepts it.

