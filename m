From: Antonio Quartulli <a@...2181...>
Date: Wed, 13 Jun 2018 20:28:22 +0800
Message-Id: <20180613122824.4207-2-a@...2181...>
In-Reply-To: <20180613122824.4207-1-a@...2181...>
References: <20180613122824.4207-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 1/3] tun: ensure gc and argv are properly
 handled
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

Ensure this kind of objects are always properly released to avoid
memory leaks.

At the same time, remove those gc_arena objects that are initialized
but never used/released.

Signed-off-by: Antonio Quartulli <antonio@...515...>

---

Changes from v1:
- remove gc_arena at all when not used


 src/openvpn/tun.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3eb0f78a..72506c4b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2600,7 +2600,6 @@ close_tun(struct tuntap *tt)
     }
     else if (tt)
     {
-        struct gc_arena gc = gc_new();
         struct argv argv = argv_new();
 
         /* setup command, close tun dev (clears tt->actual_name!), run command
@@ -2615,6 +2614,7 @@ close_tun(struct tuntap *tt)
         openvpn_execve_check(&argv, NULL, 0, "OpenBSD 'destroy tun interface' failed (non-critical)");
 
         free(tt);
+        argv_reset(&argv);
     }
 }
 
@@ -2685,7 +2685,6 @@ close_tun(struct tuntap *tt)
     }
     else if (tt)
     {
-        struct gc_arena gc = gc_new();
         struct argv argv = argv_new();
 
         /* setup command, close tun dev (clears tt->actual_name!), run command
@@ -2700,6 +2699,7 @@ close_tun(struct tuntap *tt)
         openvpn_execve_check(&argv, NULL, 0, "NetBSD 'destroy tun interface' failed (non-critical)");
 
         free(tt);
+        argv_reset(&argv);
     }
 }
 
@@ -2837,6 +2837,7 @@ close_tun(struct tuntap *tt)
         openvpn_execve_check(&argv, NULL, 0, "FreeBSD 'destroy tun interface' failed (non-critical)");
 
         free(tt);
+        argv_reset(&argv);
     }
 }
 
@@ -3308,6 +3309,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         env_set_add( es, "ODMDIR=/etc/objrepos" );
         openvpn_execve_check(&argv, es, S_FATAL, "AIX 'create tun interface' failed");
         env_set_destroy(es);
+        argv_reset(&argv);
     }
     else
     {
@@ -3333,7 +3335,6 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 close_tun(struct tuntap *tt)
 {
-    struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
     struct env_set *es = env_set_create(NULL);
 
@@ -3362,6 +3363,7 @@ close_tun(struct tuntap *tt)
 
     free(tt);
     env_set_destroy(es);
+    argv_reset(&argv);
 }
 
 int
-- 
2.17.1


