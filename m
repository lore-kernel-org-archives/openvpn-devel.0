Message-ID: <4FE99C02.6070004@...515...>
Date: Tue, 26 Jun 2012 14:24:50 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Tap-windows release and version numbering
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

I'm preparing a (signed) release of tap-windows[1] so that we can bundle
it with OpenVPN 2.3-alpha2, instead of using some arbitrary tap-windows
package built from Git sources.

Anyways, I was wondering if we should bump the version number in
tap-windows/version.m4 [2]? Would that force Windows to upgrade the
driver instead of using an older one with the same version number (e.g.
from openvpn-2.3-alpha1)?

Any ideas?

[1] <https://github.com/OpenVPN/tap-windows>
[2] <https://github.com/OpenVPN/tap-windows/blob/master/version.m4>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




