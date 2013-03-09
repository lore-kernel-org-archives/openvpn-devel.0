From: Peter Caprioli <petercap@...530...>
Date: Sat, 9 Mar 2013 18:23:04 +0000
Message-ID: <C673F57BE2DD3148AC2DD4AF464686F901BBDB56@...1815...>
Content-Language: sv-SE
MIME-Version: 1.0
Subject: [Openvpn-devel] TCP support is broken in 2.3.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi everyone,

About two weeks ago I created ticket # 263 regarding a possible bug in Open=
VPN 2.3.0. The ticket seems to have received little attention albeit being =
somewhat serious.

The bug is easy to reproduce and the ticket contains information on how to =
do so. In short, clients get disconnected if the server attempts to send da=
ta in a faster rate than the network can handle. This only happens if TCP i=
s used. I have verified this behaviour on several platforms with both preco=
mpiled packages and compiled from scratch.

I'd be grateful if someone could verify this behaviour and maybe start inve=
stigating why it is happening.

Best regards,
Peter Caprioli
