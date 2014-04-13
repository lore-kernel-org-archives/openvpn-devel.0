From: Kevin Cernekee <cernekee@...277...>
Date: Sat, 12 Apr 2014 22:16:53 -0700
Message-Id: <1397366216-657-1-git-send-email-cernekee@...277...>
Subject: [Openvpn-devel] [PATCH 0/3] Support non-root operation using ocproxy
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

Sometimes it is desirable to establish VPN connections without setting
up a kernel tun/tap device.  Possible use cases include:

 - Routing traffic from different applications through different VPNs.

 - Connecting to multiple VPNs (clients, sites, ...) that have
   overlapping IP ranges.

 - Connecting to multiple VPNs that each advertise their own default
   route and/or DNS settings.

 - Situations in which direct access to the VPN from all processes/UIDs
   is not necessarily wanted, impairs performance, or presents an
   unacceptable risk of intrusion or data leakage.

 - Multiuser systems or container-based VPSes.

 - Other situations in which the openvpn user or program is not trusted
   to reconfigure a tun/tap device.

For a long time, OpenConnect has had the ability to run as non-root[1],
redirecting VPN traffic to/from a helper program over a socketpair.
ocproxy[2] was written to take advantage of this interface.  Now I am
submitting changes to allow openvpn to be used in a similar manner.
Sample usage:

openvpn --config foo.ovpn \
        --script-security 2 \
        --dev "|/usr/bin/ocproxy -L 2222:unix-host:22 -D 11080"

The -D and -L flags work just like their equivalents on ssh, enabling port
forwarding and a SOCKS5 proxy on the specified local sockets.
"--dev-type tun" is assumed if unspecified.  The IP configuration is
passed into ocproxy through "vpnc-script"-compatible environment variables.

This was tested on Linux with IPv4.

[1] http://www.infradead.org/openconnect/nonroot.html
[2] http://repo.or.cz/w/ocproxy.git


Kevin Cernekee (3):
  Add S_NOWAIT and S_SETPGRP flags to openvpn_execve
  Move MTU field into struct tuntap
  Add "pipe to external program" device

 doc/openvpn.8      |   29 +++++++++++++--
 src/openvpn/init.c |   17 ++++++---
 src/openvpn/misc.c |    9 ++++-
 src/openvpn/misc.h |    6 ++--
 src/openvpn/tun.c  |  102 ++++++++++++++++++++++++++++++++++++++++++++++++----
 src/openvpn/tun.h  |    4 ++-
 6 files changed, 149 insertions(+), 18 deletions(-)

-- 
1.7.9.5


