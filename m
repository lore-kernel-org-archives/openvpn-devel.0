From: "=?windows-1252?q?Fran=E7ois?= Revol" <revol@...260...>
Message-Id: <18479273504-BeMail@...337...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 1.5 ported to BeOS (BONE) and Zeta
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Jan 13 03:47:19 2005
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

I've been having a port of 1.5 for some time already, never bothered to
post about it, since it requires a tuntap driver which I wrote but
isn't public yet, but will be bundled with Zeta ( http://yellowtab.com
).
We should get 2.0 ported soon if it doesn't have quirks, but I thought
I'd post that one anyway.

Most changes are just about adding BeOS configurations, and the code to
open the tuntap driver, which I designed to have the same API as the
Linux one (except it's published as /dev/misc/tuntap because our devfs
is hierarchical).
The syslog stuff is in the gui library (don't ask why).
The new network stack (BONE, the old one is not on par with VPN anyway)
has some oddnesses like __inet_aton, but it's been worked around.
Priorities are different in BeOS.
BONE CLI tools have an odd syntax as well...

Fran=E7ois.

The diff
http://clapcrest.free.fr/revol/beos/patches/openvpn-1.5.0-
beos.patch.002.txt

P.S. I'm not subscribed.


