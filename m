From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 28 Apr 2010 16:55:12 +0200
Message-Id: <1272466514-18866-5-git-send-email-fabian.knittel@...1338...>
In-Reply-To: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
References: <1272466514-18866-1-git-send-email-fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 4/6] vlan: Improve documentation of
	remove_vlan_tag()
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

This patch improves the comments that document the remove_vlan_tag() function.
It clarifies what is meant by "priority-tagged frames" and documents the
parameters and return value.

Signed-off-by: Fabian Knittel <fabian.knittel@...1338...>
---
 multi.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/multi.c b/multi.c
index 83c5aa3..2f531c2 100644
--- a/multi.c
+++ b/multi.c
@@ -2175,8 +2175,9 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 #ifdef ENABLE_VLAN_TAGGING
 /*
  * For vlan_accept == VAF_ONLY_UNTAGGED_OR_PRIORITY:
- *   If a frame is VLAN-tagged, it is dropped.  Otherwise, the global
- *   vlan_pvid is returned as VID.
+ *   Only untagged frames and frames that are priority-tagged (VID == 0) are
+ *   accepted.  (This means that VLAN-tagged frames are dropped.)  For frames
+ *   that aren't dropped, the global vlan_pvid is returned as VID.
  *
  * For vlan_accept == VAF_ONLY_VLAN_TAGGED:
  *   If a frame is VLAN-tagged and contains no priority information, the
@@ -2188,6 +2189,10 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
  * For vlan_accept == VAF_ALL:
  *   Accepts both VLAN-tagged and untagged (or priority-tagged) frames and
  *   and handles them as described above.
+ *
+ * @param c   The global context.
+ * @param buf The ethernet frame.
+ * @return    Returns -1 if the frame is dropped or the VID if it is accepted.
  */
 static int16_t
 remove_vlan_tag (const struct context *c, struct buffer *buf)
-- 
1.7.0


