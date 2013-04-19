From: Gert Doering <gert@...1296...>
Date: Fri, 19 Apr 2013 19:41:03 +0200
Message-Id: <1366393268-27392-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] forward-port of all outstanding 2.1 SVN patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi folks,

here's a patch series that brings all not-yet-ported changes from James'
SVN 2.1 tree to the current git master tree (plus one of mine, 5/5 is
a bugfix for 2/5 - I decided to have it as extra patch so it's clear 
that this is deviating from "just take what is in SVN").

This is necessary groundwork to run OpenVPN AS with the 2.3 core, and 
thus bring development work of "community openvpn" and "AS" a bit more
closely together again.

Patches have been tested on Linux, FreeBSD and MacOS 10.5, for
standalone OpenVPN (client and p2pm server) and inside AS, and I'm 
fairly confident that the stuff works and nothing crashes :-)

(Don't ask me what 1/5 is for.  It came from SVN, it was straightforward
to port and test, and "something in the AS context" wants it)

gert


