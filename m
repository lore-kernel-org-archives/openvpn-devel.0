Message-ID: <020001c2260b$424b92e0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] new beta available
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
Date: Sun Jul  7 16:07:02 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

Download:

http://openvpn.sourceforge.net/beta/openvpn-1.2.1.10.tar.gz

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
* Added --disable-occ option.
* Added --local, --remote, and --ifconfig options sanity
  check.
* Changed default UDP MTU to 1450 and TUN/TAP MTU to
  1400.
* Successfully tested with OpenSSL 0.9.7 Beta 2.
* Broke out debug level definitions to errlevel.h
* Minor documentation and web site changes.
* All changes maintain protocol compatibility
  with OpenVPN versions since 1.1.0, however default
  MTU changes will require setting the MTU explicitly
  by command line option, if you want MYVERSION to
  communicate with previous versions.

James



