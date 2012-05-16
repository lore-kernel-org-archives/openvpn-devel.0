Message-ID: <4FB38F35.20103@...515...>
Date: Wed, 16 May 2012 14:27:49 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Pre-2.3-alpha2 Windows installers now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

Here are the first fully-functional Windows installers built (by me)
with Alon's new cross-compilation environment (a.k.a. "generic"
buildsystem):

<http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_master-I0=
00_master-i686.exe>
<http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_master-I0=
00_master-x86_64.exe>

The installers and executables and libraries in them have been signed
with a self-signed test certificate. This means that Windows Vista/7
64-bit will refuse to install the (self-signed) TAP-drivers, unless this
CA certificate is in the system keystore:

<http://build.openvpn.net/downloads/openvpntestca-cert.cer>

This certificate can be imported using Microsoft management console
(mmc.exe):

- Add  the "Certificates" snap-in
- Go to "Trusted root certificates"
- Right-click "Certificates"
- Select "All tasks" -> "Import"

After this you can run the OpenVPN installer and it should just work. A
version of OpenVPN signed with paid-for certificate is coming soonish.
That one will work on any supported Windows version without jumping
through these hoops.

Have fun (and please report back any issues you find),

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


