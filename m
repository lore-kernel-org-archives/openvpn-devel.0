From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  6 Sep 2019 18:40:37 +0300
Message-Id: <1567784437-25922-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] tun.h: change tun_set() return value type
 to void
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

This function's return value is never used, so make it void.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/tun.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 69831c4..475643a 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -513,7 +513,7 @@ tun_event_handle(const struct tuntap *tt)
 #endif
 }
 
-static inline unsigned int
+static inline void
 tun_set(struct tuntap *tt,
         struct event_set *es,
         unsigned int rwflags,
@@ -539,7 +539,6 @@ tun_set(struct tuntap *tt,
 #endif
         tt->rwflags_debug = rwflags;
     }
-    return rwflags;
 }
 
 const char *tun_stat(const struct tuntap *tt, unsigned int rwflags, struct gc_arena *gc);
-- 
2.7.4


