From: Antonio Quartulli <a@...2181...>
Date: Wed, 13 Jun 2018 20:28:21 +0800
Message-Id: <20180613122824.4207-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 0/3] pre-ipv6-only clean up patchset
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

This patchset is the result of some of Gert's comment on the IPv6-only
patchset.

For this reason, this patchset is expected to be applied *before*
applying future versions (v3...) of the IPv6-only patchset.

This patchset is mostly about restyling the code a bit and getting rid
of unused members. Hence, there is no new feature being introduced.

Patch 1 is fixing potential memory leaks resulting from not releasing
some argv local variables and removes unused gc_areas.


This version 2 is basically addressing all the coments raised by Gert on
the previous version.
Detailed changes are rpeorted in each patch.


Cheers,

p.s. buildbot is currently unusable due to the ongoing maintenance on
the OpenVPN servers and therefor eonly local tests have been performed.


Antonio Quartulli (3):
  tun: ensure gc and argv are properly handled
  tun: always pass a valid tt pointer
  tun: get rid of tt->did_ifconfig member

 src/openvpn/init.c |   7 +-
 src/openvpn/tun.c  | 513 ++++++++++++++++++++++-----------------------
 src/openvpn/tun.h  |   1 -
 3 files changed, 254 insertions(+), 267 deletions(-)

-- 
2.17.1


