From: Arne Schwabe <arne@...1227...>
Date: Sun, 30 Apr 2023 19:22:02 +0200
Message-Id: <20230430172202.206528-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove unused variable line
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

The newer compilers started to complain about this.

Change-Id: I784def4d941b7d21c7979f84f8681719c9ff7a53
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/pool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index f899b95d2..4af9bcb10 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -608,7 +608,6 @@ ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_pool *
         struct gc_arena gc = gc_new();
         struct buffer in = alloc_buf_gc(256, &gc);
         char *cn_buf, *ip_buf, *ip6_buf;
-        int line = 0;
 
         ALLOC_ARRAY_CLEAR_GC(cn_buf, char, buf_size, &gc);
         ALLOC_ARRAY_CLEAR_GC(ip_buf, char, buf_size, &gc);
@@ -621,7 +620,6 @@ ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_pool *
             {
                 break;
             }
-            ++line;
             if (!BLEN(&in))
             {
                 continue;
-- 
2.39.2 (Apple Git-143)


