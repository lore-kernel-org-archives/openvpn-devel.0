From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 13:34:27 +0200
Message-Id: <20201023113431.26691-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/5] Inline function tls_get_peer_info
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

All other places in our code also directly access peer_info and this
function does not contribute to code clarity.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 2 +-
 src/openvpn/ssl.h   | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a5862020..009b46fa 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3993,7 +3993,7 @@ management_get_peer_info(void *arg, const unsigned long cid)
 
     if (mi)
     {
-        ret = tls_get_peer_info(mi->context.c2.tls_multi);
+        ret = mi->context.c2.tls_multi->peer_info;
     }
 
     return ret;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index f00f8abd..f3032dab 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -499,14 +499,6 @@ bool tls_session_update_crypto_params(struct tls_session *session,
                                       struct frame *frame,
                                       struct frame *frame_fragment);
 
-#ifdef MANAGEMENT_DEF_AUTH
-static inline char *
-tls_get_peer_info(const struct tls_multi *multi)
-{
-    return multi->peer_info;
-}
-#endif
-
 /*
  * inline functions
  */
-- 
2.26.2


