From: "James Yonan" <jim@...41...>
Message-ID: <twig.1100040511.60533@...41...>
Subject: [Openvpn-devel] IANA has approved a unique port number for OpenVPN
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
Date: Tue Nov  9 14:49:02 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

I just got a note from IANA confirming that they've assigned TCP/UDP port 1194
to OpenVPN.

You can see the allocation here in the global list:

http://www.iana.org/assignments/port-numbers

The question, of course, is when should we switch over to using 1194 as the
default? (We're currently using 5000 which doesn't really belong to us.)

I'd be inclined to make the change before 2.0 final is released.  Any other
opinions?

Of course, this will be moot for those of you who select your own port number
using the "port" directive.  It's only a question of changing the default from
5000 to 1194 when no "port" directive is specified.

James



