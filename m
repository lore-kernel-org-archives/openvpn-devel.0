From: Arne Schwabe <arne@...1227...>
Date: Mon,  8 Oct 2018 19:50:44 +0200
Message-Id: <20181008175044.8289-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix building with --disable-management
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

---
 src/openvpn/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 9075d63b..af6d44f7 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -177,7 +177,6 @@ server_pushed_signal(struct context *c, const struct buffer *buffer, const bool
 
 void server_pushed_info(struct context *c, const struct buffer *buffer, const int adv)
 {
-  struct gc_arena gc;
   const char *m = "";
   struct buffer buf = *buffer;
 
@@ -187,6 +186,7 @@ void server_pushed_info(struct context *c, const struct buffer *buffer, const in
     }
 
     #ifdef ENABLE_MANAGEMENT
+    struct gc_arena gc;
     if (management)
     {
         gc = gc_new();
-- 
2.19.0


