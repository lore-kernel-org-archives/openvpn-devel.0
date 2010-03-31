From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 31 Mar 2010 23:58:13 +0200
Message-Id: <cover.1270060247.git.fabian.knittel@...1338...>
Subject: [Openvpn-devel] [RFC][PATCH 0/9] VLAN tagging on TAP devices in
	OpenVPN server mode
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

Hi,

we're currently attempting to use OpenVPN in an environment where potentially
several hundred users connect to a cluster of OpenVPN instances and gain
access to several different internal networks.

The different networks are internally managed using VLANs (based on IEEE
802.1Q).  (The packets are transported in tagged form on the internal backbones
and inserted into the actual department networks in untagged form.)

Instead of using one OpenVPN server instance per VLAN (e.g. on a
different port or a different load-balanced IP) we would like every instance
to provide access to all networks by directly plugging into the "backbone",
i.e. by directly handling tagged packets.


The following patch-set is a first draft to implement VLAN tagging on an
OpenVPN server running in server mode and using a TAP device.

Each client gets assigned a VLAN identifier (VID) (e.g. through a
client-connect script or through ccd files), indicating the network the client
may communicate with.

Packets coming in from the TAP device are assumed to be tagged with
IEEE 802.1Q headers.  OpenVPN removes the tag, remembers the VID and
routes the packet to the destination client(s) on the other side of the
secure tunnel which have a matching VID.

Packets that OpenVPN pushes onto the device are tagged according to which VID
the sending client belonged to.


For high-level illustration, consider the following example network:

  |---+---------------------| Untagged internal network A
      |
      |          |---+------| Untagged internal network B
      |              |
      |              |
      T(*)           T(**)
 |====+=====+========+======| Backbone with tagged networks A and B
            |
            |                 (*)  Switch tags/untags with VID 11
            |                 (**) Switch tags/untags with VID 22
           tap (***)          (***) receives tagged packets from A and B
       [ OpenVPN server ]
           | | |
           | | +---------[ OpenVPN client 1 (server-side: --vlan-tag 11) ]
           | |                   tap
           | |                    |
           | |              |-----+---------| Untagged network A
           | |
           | +-----------[ OpenVPN client 2 (server-side: --vlan-tag 11) ]
           |                     tap
           |                      |
           |                |-----+---------| Untagged network A
           |
           +-------------[ OpenVPN client 3 (server-side: --vlan-tag 22) ]
                                 tap
                                  |
                            |-----+---------| Untagged network B

The internal network A is only available to clients 1 and 2, network B is
only available to client 3.  A and B are seperate broadcast domains and
broadcasts on network A only propagate to client 1's and client 2's
networks.

The server's tap interface sits on the backbone and inputs/outputs
only tagged packets.

The clients receive and send untagged packets and require no explicit VLAN
support.


The patch-set is now based on Davide Guerri's --passtos patch, as it directly
falls with-in the functionality of my original version and looked like a
candidate for integration.

The patches are also available directly via git, see our gitweb at

  http://opensource.fsmi.uni-karlsruhe.de/cgi-bin/gitweb.cgi?p=openvpn.git;a=shortlog;h=refs/heads/feat_vlan_on_feat_passtos

The last two patches (add debug logging ...) aren't really intended for
inclusion.  I haven't looked into proper log levels, so currently the debug
messages flood at notice priority.  I'm not sure whether the messages should
be included at all.

Another question would be whether I should turn the feature into a compile-time
selectable option.

The patch-set has only received light testing up to now, as it was originally
only intended as a proof of concept.  At this point I'm very interested in
all kinds of feed-back and would like to determine whether you might be
interested in integrating something like this in an official OpenVPN release
at some point.

Cheers
Fabian

Fabian Knittel (9):
  is_ipv4(): add packet length check for 802.1Q packets
  vlan: Add global --vlan-tagging option
  vlan: Add per-client --vlan-tag option
  vlan: Prepend and remove VLAN identifiers on outgoing and incoming
    frames
  vlan: Add VLAN identifier to mroute_addr for ethernet addresses
  vlan: Restrict broadcasts to the sender's VLAN.
  vlan: Slightly enhance PF's protocol inspection of 802.1Q packets
  vlan: add debug logging to tagging / untagging
  vlan: add debug logging to broadcast filter

 mroute.c  |   20 ++++++++--
 mroute.h  |    8 +++--
 multi.c   |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 multi.h   |    5 +++
 options.c |   34 +++++++++++++++++
 options.h |    3 ++
 proto.c   |    3 ++
 proto.h   |   36 ++++++++++++++++--
 8 files changed, 210 insertions(+), 20 deletions(-)


