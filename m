Message-ID: <027801c22065$881812e0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Pre-1.2.2 beta available, please test
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Sun Jun 30 11:39:02 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

I plan to release 1.2.2 in a few days if there are no problems with this
beta.

Download:

http://openvpn.sourceforge.net/beta/openvpn-1.2.1.8.tar.gz

Changes since 1.2.1:

* Added --dev-node option to allow explicit selection of
  tun/tap device node.
* Removed mlockall call from child thread, as it doesn't
  appear to be necessary (child thread inherits mlockall
  state from parent).
* Added --ping-timer-rem which causes timer for --ping-exit
  and --ping-restart not to run unless we have a remote IP
  address.
* Added condrestart to openvpn.init and openvpn.spec
  (Bishop Clark).
* Added --ifconfig case for FreeBSD (Matthias Andree).
* Call openlog with facility=LOG_DAEMON (Matthias Andree).
* Changed LOG_INFO messages to LOG_NOTICE.
* Added warning when key files are group/others accessible.
* Added --single-session flag for TLS mode.
* Fixed bug where --writepid would segfault if used with
  an invalid filename.
* Fixed bug where --ipchange status message was formatted
  incorrectly.
* Print more concise error message when system() call
  fails.
* All changes maintain protocol compatibility with OpenVPN
  versions since 1.1.0.

James



