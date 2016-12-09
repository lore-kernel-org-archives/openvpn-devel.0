From: David Sommerseth <davids@...515...>
Date: Fri,  9 Dec 2016 14:45:03 +0100
Message-Id: <1481291105-27739-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH 0/2] Improve --ifconfig and --ifconfig-push
	sanity check
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

This patch set is combining two separate mail threads [1] [2] as they are related.

These patches have also been rearragned, where the first patch adds the generic
improvements and prepares for the push.c update which is in the second patch.

These patches combined will resolve the issue reported in Trac ticket #755


[1] <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13445.html>,
    Message-Id: <1480545687-19365-1-git-send-email-davids@...515...>
[2] <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13334.html>,
    Message-Id: <1481251952-30704-1-git-send-email-davids@...515...>

David Sommerseth (2):
  Improve ifconfig_sanity_check()
  push: Provide a warning if --ifconfig-push have --topology mismatch

 src/openvpn/push.c |  8 ++++++++
 src/openvpn/tun.c  | 46 ++++++++++++++++++++++++++++++++++------------
 src/openvpn/tun.h  |  2 ++
 3 files changed, 44 insertions(+), 12 deletions(-)

-- 
1.8.3.1


