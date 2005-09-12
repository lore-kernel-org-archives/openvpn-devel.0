Message-ID: <4325776D.5080206@...458...>
From: Piet Delport <pjd@...458...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Feature request:  Management via Unix domain socket?
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
Date: Mon Sep 12 05:42:34 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

At the moment, OpenVPN's management interface can only listen on a TCP port.

Support for listening on a Unix domain socket should be easy, and would be
simpler and more secure for some setups.  The configuration file format would
not even need significant change;  the "management" option could simply take
<filename> <mode> [<pw-file>] instead of <address> <port> [<pw-file>].  The
presence of a / in the filename would unambiguously and backward-compatably
indicate that it's a Unix domain socket, instead of TCP.

(I wanted to add this feature to http://openvpn.net/wiki/OpenVPN_2.x_wishlist,
but the wiki requires registration.  Maybe an existing user can take the time?)

