Message-ID: <001f01c227fb$01803850$1000000a@...4...>
From: "James Yonan" <jim@...3...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 1.3.0 Released
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
Date: Wed Jul 10 03:16:06 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

Download:

http://sourceforge.net/projects/openvpn/

Release Notes:

This is a housekeeping release containing minor fixes and finishing touches
on larger features introduced in previous versions. The version number has
incremented to 1.3.x due to a change in default MTU values.

The default values for --udp-mtu and --tun-mtu have been lowered to 1300 as
a conservative measure to reduce the possibility of packet fragmentation and
loss for users who do not explicitly set a value.

If you are using OpenVPN 1.3.0 to connect to previous versions of OpenVPN,
you should set the MTU explicitly on both peers, keeping in mind that in
pre-1.3.0 versions of OpenVPN, --udp-mtu defaulted to 1500 and --tun-mtu
defaulted to 1450.

Change Log from 1.2.1 -> 1.3.0:

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
* Changed default UDP MTU to 1300 and TUN/TAP MTU to
  1300.
* Successfully tested with OpenSSL 0.9.7 Beta 2.
* Broke out debug level definitions to errlevel.h
* Minor documentation and web site changes.
* All changes maintain protocol compatibility
  with OpenVPN versions since 1.1.0, however default
  MTU changes will require setting the MTU explicitly
  by command line option, if you want 1.3.0 to
  communicate with previous versions.

James



