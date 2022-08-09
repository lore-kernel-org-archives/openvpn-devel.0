From: Lev Stipakov <lstipakov@...277...>
Date: Tue,  9 Aug 2022 10:22:20 +0300
Message-Id: <20220809072220.255-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] tun.c: remove unused gc_arena from
 init_tun()
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/tun.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 54f7d72c..f3152a52 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -745,7 +745,6 @@ init_tun(const char *dev,        /* --dev option */
          struct env_set *es,
          openvpn_net_ctx_t *ctx)
 {
-    struct gc_arena gc = gc_new();
     struct tuntap *tt;
 
     ALLOC_OBJ(tt, struct tuntap);
@@ -878,7 +877,6 @@ init_tun(const char *dev,        /* --dev option */
         do_ifconfig_setenv(tt, es);
     }
 
-    gc_free(&gc);
     return tt;
 }
 
-- 
2.23.0.windows.1


