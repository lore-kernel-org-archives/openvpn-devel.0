Message-Id: <200305050621.h456Lq122103@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] Third release candidate for 1.4.0
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
Date: Sun May  4 23:23:03 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This release candidate fixes some longstanding annoyances with the
openvpn.init script, making it more robust, with better sanity checks on
command line options, and more accurate reporting of fail/success status back
to the caller.

The later feature required some changes to the way that --daemon works. 
--daemon now switches output to the syslog as soon as the daemon option is
parsed off the command line or config file.  But the daemonization point is
delayed until all initialization is complete.  Therefore, most fatal errors on
initialization will occur before daemonization, allowing the error status to
be returned to the init script.

http://openvpn.sourceforge.net/beta/openvpn-1.3.2.35.tar.gz

James



