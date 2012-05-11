Message-ID: <4FAD2F8C.6000709@...515...>
Date: Fri, 11 May 2012 18:26:04 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] First partially-working snapshot build for Windows
	now available
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

I finally managed to generate fairly crude OpenVPN Windows installers
using Alon's new openvpn-build buildsystem. Due to a build issue
"openvpn-gui" is not included, and the tap-driver is seems to be
unsigned. Regardless, here are the results nevertheless:

<http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_master-I0=
00_master-i686.exe>
<http://build.openvpn.net/downloads/snapshots/openvpn-install-2.3_master-I0=
00_master-x86_64.exe>

All of the libraries and executables have been signed with a self-signed
test key. This includes openssl libraries and such. If you want Windows
to trust these executables, you need to download this certificate:

<http://build.openvpn.net/downloads/openvpntestca-cert.cer>

Then you need to import it to your "Trusted CA" key store, e.g. with

> certutil -user -addstore Root openvpntestca-cert.cer

After this Windows should not complain about an unknown publisher. I'll
try to come up with really usable installer next week.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


