Message-Id: <200305150448.h4F4ml104812@...41...>
From: "James Yonan" <jim@...41...>
Subject: [Openvpn-devel] Release candidate for 1.4.1
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
Date: Wed May 14 21:50:02 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

A couple of bugs have surfaced in 1.4.0, including a problem with --verb 0
under Linux 2.4 and a trivial compile problem for OpenBSD.

I'd like to release 1.4.1 soon, which resolves both of these issues.

Please test this release candidate if possible.

Download:

http://openvpn.sourceforge.net/beta/openvpn-1.4.0.3.tar.gz

ChangeLog:

* Modified the Linux 2.4 TUN/TAP open code to
  fall back to the 2.2 TUN/TAP interface if the
  open or ioctl fails.
* Fixed bug when --verb is set to 0 and non-fatal
  socket errors occur, causing 100% CPU utilization.
  Occurs on platorms where
  EXTENDED_SOCKET_ERROR_CAPABILITY is defined,
  such as Linux 2.4.
* Fixed typo in tun.c that was preventing
  OpenBSD build.

James



