From: Arne Schwabe <arne@...1227...>
Date: Sat, 24 Dec 2022 20:42:44 +0100
Message-Id: <20221224194253.3202231-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/9] Various patches to improve DCO behaviour
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This is a list of various patches that improve certain corner cases of DCO
behaviour or improve. The remaining issues seem to be in the ovpn-dco module
and need to fixed there first. Remaining issues in ovpn-dco:

- if there are a lot of event, the recvfrom the netlink socket will give
  a ENOMEM. Using Control-S and Control-Q to temporarily pause the OpenVPN
  daemon is a reliable way for me to trigger it.

- OpenVPN tcp sessions that are gone, especially when doing TCP reset are
  not notified to the user space

- With UDP and bombarding server already when starting up gives me a hard
  freeze

- Unload ovpn-dco sometimes does not work. Getting 'In use by xy ' failures.

- Latest FreeBSD dco module seems to be very broken. Reverting latest commit
  fixes it.



Arne Schwabe (9):
  Rename TM_UNTRUSTED to TM_INITIAL
  Always start session in TM_INITIAL rather than TM_ACTIVE or TM_INITIAL

These two could be smashed into one commit but two makes reviewing easier. They
clean up the state machine a bit and by doing so fix an obscore corner case
that would not work in p2p dco.

  Move dco_installed back to link_socket from link_socket.info.actual

With the intention of moving back to using normal send/recv instead of using
netlink, the special handling of figuring out which peer address uses wht
mechansim is no longer necessary. Instead of hunting the bug down, just always
use sendto when wanting to send something.

  Ensure we do not promote a TA_TIMEOUT to a TA_WRITE/TA_READ event with
    dco
Ensures that we do not go to a socket write/read on a DCO installed TCP
socket.

  Also drop incoming dco packet content when dropping the packet
  otherwise we would not clear the received packet and the dco code
  would refuse to put a new one there.

  Do not set nl socket buffer size
This does not change anything and is more cosmetic.

  Bail out when trying to install a TCP socket with residual data to DCO

This is something we could probably fix if we spent a lot more time and
only ever read as little as possible (i.e. read 2 bytes to know next
packet length, and then read only the length of the next packet). But instead
of adding a lot of extra code, I rather want to wait for the plans of ovpn-dco
and tcp and how the API evolves.

  Improve logging when seeing a message for an unkown peer
  Ignore OVPN_DEL_PEER_REASON_USERSPACE to avoid race conditions

This commit fixes a race condition that lead to OpenVPN trying to add
a peer that already existed.

 src/openvpn/dco.c        |  23 +-------
 src/openvpn/dco_linux.c  |   3 --
 src/openvpn/forward.c    |  27 ++--------
 src/openvpn/forward.h    |  30 +++++++++++
 src/openvpn/init.c       |   2 +-
 src/openvpn/mtcp.c       |  20 +++++--
 src/openvpn/mudp.c       |   2 +-
 src/openvpn/multi.c      |  45 +++++++++++++---
 src/openvpn/socket.c     |   8 +--
 src/openvpn/socket.h     |  11 ++--
 src/openvpn/ssl.c        | 113 +++++++++++++++------------------------
 src/openvpn/ssl.h        |   2 +-
 src/openvpn/ssl_common.h |   2 +-
 13 files changed, 144 insertions(+), 144 deletions(-)

-- 
2.37.1 (Apple Git-137.1)


