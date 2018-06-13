From: Antonio Quartulli <a@...2181...>
Date: Wed, 13 Jun 2018 16:12:15 +0800
Message-Id: <20180613081218.1834-2-a@...2181...>
In-Reply-To: <20180613081218.1834-1-a@...2181...>
References: <20180613081218.1834-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 1/3] tun: ensure gc and argv are always freed
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

Everytime a argv object is initialized with argv_new(), it has
to be released with argv_reset() once not needed anymore.

The same holds for gc_arena objects initialized with gc_new() that
have to be released with gc_free().

Ensure both kind of objects are always properly released to avoid
memory leaks.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/tun.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3eb0f78a..466d4d42 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2615,6 +2615,8 @@ close_tun(struct tuntap *tt)
         openvpn_execve_check(&argv, NULL, 0, "OpenBSD 'destroy tun interface' failed (non-critical)");
 
         free(tt);
+        argv_reset(&argv);
+        gc_free(&gc);
     }
 }
 
@@ -2700,6 +2702,8 @@ close_tun(struct tuntap *tt)
         openvpn_execve_check(&argv, NULL, 0, "NetBSD 'destroy tun interface' failed (non-critical)");
 
         free(tt);
+        argv_reset(&argv);
+        gc_free(&gc);
     }
 }
 
@@ -2837,6 +2841,7 @@ close_tun(struct tuntap *tt)
         openvpn_execve_check(&argv, NULL, 0, "FreeBSD 'destroy tun interface' failed (non-critical)");
 
         free(tt);
+        argv_reset(&argv);
     }
 }
 
@@ -3308,6 +3313,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         env_set_add( es, "ODMDIR=/etc/objrepos" );
         openvpn_execve_check(&argv, es, S_FATAL, "AIX 'create tun interface' failed");
         env_set_destroy(es);
+        argv_reset(&argv);
     }
     else
     {
@@ -3362,6 +3368,8 @@ close_tun(struct tuntap *tt)
 
     free(tt);
     env_set_destroy(es);
+    argv_reset(&argv);
+    gc_free(gc);
 }
 
 int
-- 
2.17.1


