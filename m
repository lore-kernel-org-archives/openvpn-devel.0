From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 18 Jul 2018 16:27:53 +0200
Message-ID: <1531924073-29243-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1531924073-29243-1-git-send-email-steffan.karger@...1435...>
References: <1531924073-29243-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Remove unneeded newline in debug
 message in reliable.c
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
Cc: Gert van Dijk <gert.vandijk@...1435...>, Steffan Karger <steffan.karger@...1435...>

From: Gert van Dijk <gert.vandijk@...1435...>

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/reliable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index d295076..a7f4ed9 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -462,7 +462,7 @@ reliable_wont_break_sequentiality(const struct reliable *rel, packet_id_type id)
              (packet_id_print_type)id, reliable_print_ids(rel, &gc));
     }
 
-    dmsg(D_REL_DEBUG, "ACK RWBS rel->size=%d rel->packet_id=%08x id=%08x ret=%d\n", rel->size, rel->packet_id, id, ret);
+    dmsg(D_REL_DEBUG, "ACK RWBS rel->size=%d rel->packet_id=%08x id=%08x ret=%d", rel->size, rel->packet_id, id, ret);
 
     gc_free(&gc);
     return ret;
-- 
2.7.4


