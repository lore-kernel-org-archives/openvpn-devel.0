From: Antonio Quartulli <a@...2181...>
Date: Wed,  9 Oct 2019 16:34:13 +0200
Message-Id: <20191009143422.9419-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 0/9] support VLANs in TAP mode
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
Cc: Antonio Quartulli <a@...2181...>

This patchset is the restyled, adjusted and (partly) re-worked version
of the patchset that can be found in this GitHub PR
https://github.com/OpenVPN/openvpn/pull/76
originally authored by Fabian Knittel.

The status of this new patchset is tracked here:
https://community.openvpn.net/openvpn/ticket/6#comment:5

These new patches have already gone through a first round of review by
Gert and are now being posted on the mailing list for broader
scrutinity.


In a nutshell, this new feature allows to assign each client to a VLAN
(like if it was a host plugged into a switch, with OpenVPN server being
the switch). This will ensure proper isolation between clients on
different VLANs.
On top of that, depending on the configuration, clients can be bridged with
different networks on the server side, thanks to the VLAN tagging
applied to their outgoing packets (more is explained in the additional
manpage content).

A specific document explaining more in details how this feature can be
useful in common setups is planned to be drafted after the patchset has
been merged.

Feedback is welcome!

Regards,

Antonio Quartulli (9):
  maddr: create helper function to populate maddr object from eth_addr
  VLAN: add basic VLAN tagging support
  maddr: export VLAN ID from client context to maddr object
  VLAN: filter multicast and client-to-client unicast traffic
  is_ipv_X: add support for parsing IP header inside a 802.1q frame
  VLAN: implement support for forwarding only pre-tagged VLAN packets
  VLAN: allow forwarding tagged and untagged packets on the server TAP
    device
  VLAN: add documentation to manpage
  VLAN: allow user to avoid compiling VLAN handling code

 configure.ac            |  12 ++
 doc/openvpn.8           |  99 +++++++++++-
 src/openvpn/Makefile.am |   4 +
 src/openvpn/errlevel.h  |   2 +
 src/openvpn/mroute.c    |  66 +++++---
 src/openvpn/mroute.h    |  13 +-
 src/openvpn/multi.c     |  47 +++++-
 src/openvpn/multi.h     |   2 +
 src/openvpn/options.c   |  99 ++++++++++++
 src/openvpn/options.h   |  13 ++
 src/openvpn/proto.c     |  42 +++--
 src/openvpn/proto.h     |  25 +++
 src/openvpn/vlan.c      | 337 ++++++++++++++++++++++++++++++++++++++++
 src/openvpn/vlan.h      | 131 ++++++++++++++++
 14 files changed, 852 insertions(+), 40 deletions(-)
 create mode 100644 src/openvpn/vlan.c
 create mode 100644 src/openvpn/vlan.h

-- 
2.23.0


