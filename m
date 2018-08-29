From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 29 Aug 2018 15:49:43 +0200
Message-ID: <1535550583-21825-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix memory leak after sighup
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

The c.es env_set is (re)allocated for each "sighup loop iteration", while
it was free'd only once at process shutdown.  Move the env_set_destroy()
call to match the same level as the env_set_create() call to fix that.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/openvpn.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index b9e914a..3819889 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -329,6 +329,7 @@ openvpn_main(int argc, char *argv[])
             }
             while (c.sig->signal_received == SIGUSR1);
 
+            env_set_destroy(c.es);
             uninit_options(&c.options);
             gc_reset(&c.gc);
         }
@@ -337,8 +338,6 @@ openvpn_main(int argc, char *argv[])
 
     context_gc_free(&c);
 
-    env_set_destroy(c.es);
-
 #ifdef ENABLE_MANAGEMENT
     /* close management interface */
     close_management();
-- 
2.7.4


