Message-Id: <200305160757.h4G7vO122768@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] OpenVPN 1.4.1 Released
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri May 16 00:58:08 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-announce@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This release fixes two bugs in 1.4.0, including a build issue on OpenBSD, and
a bug under Linux 2.4 that can cause 100% CPU utilization if the --verb 0
option is used to suppress all output.

In addition, if a Linux 2.4 TUN/TAP open attempt fails, the code will now fall
back to the 2.2 TUN/TAP interface and try again.

http://sourceforge.net/projects/openvpn/

James


