From: Antonio Quartulli <a@...2181...>
Date: Thu, 24 Aug 2017 15:53:12 +0800
Message-Id: <20170824075312.24801-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] avoid useless assignment
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

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/multi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 5892ac07..6cdb0110 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -633,7 +633,7 @@ multi_process_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags
 static inline bool
 multi_process_outgoing_link_dowork(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
-    bool ret = true;
+    bool ret;
     set_prefix(mi);
     process_outgoing_link(&mi->context);
     ret = multi_process_post(m, mi, mpp_flags);
-- 
2.14.1


