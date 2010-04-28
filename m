From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 28 Apr 2010 16:55:08 +0200
Message-Id: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 0/6] Updates to VLAN patches
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

in response to Peter's recent review of my VLAN patch-set, I've prepared a
batch of incremental updates.  There should be no functional changes, as the
patches mainly work on stylistic code issues and documentation clarifications.

The patches are also available via the feat_vlan branch on
git://fsmi-dev.fsmi.uni-karlsruhe.de/openvpn.git

Cheers
Fabian

Fabian Knittel (6):
  vlan: Mention 802.1Q in configuration descriptions
  vlan: use uint16_t for storage of the VID where possible
  vlan: slightly clean-up buf_filter_incoming_vlan_tags()
  vlan: Improve documentation of remove_vlan_tag()
  vlan: is_ipv4: fix position of variable definition
  vlan: move htons / ntohs into vlanhdr_get/_set functions

 configure.ac |    4 +-
 mroute.c     |    6 ++--
 mroute.h     |    6 ++--
 multi.c      |   80 ++++++++++++++++++++++++++++++++++------------------------
 options.c    |    4 +-
 options.h    |    2 +-
 proto.c      |    2 +-
 proto.h      |   45 ++++++++++++++++++++++++--------
 8 files changed, 92 insertions(+), 57 deletions(-)


