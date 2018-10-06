From: Lev Stipakov <lstipakov@...277...>
Date: Sat,  6 Oct 2018 12:30:19 +0300
Message-Id: <1538818219-18141-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] init.c: refine functions names and
 description
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

From: Lev Stipakov <lev@...515...>

This patch provides better naming and description
for functions which deal with backup/restore NCP-negotiable
options.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/init.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b2ab2a6..9172dbb 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -613,26 +613,20 @@ uninit_proxy(struct context *c)
 }
 
 /*
- * Assign NCP-negotiable options to context->c1
- * from context->options (initially config values).
- * They persist over sigusr1 restart.
+ * Saves the initial state of NCP-regotiable
+ * options into a storage which persists over SIGUSR1.
  */
 static void
-do_set_ncp_options(struct context *c)
+save_ncp_options(struct context *c)
 {
     c->c1.ciphername = c->options.ciphername;
     c->c1.authname = c->options.authname;
     c->c1.keysize = c->options.keysize;
 }
 
-/*
- * Restore NCP-negotiable options from c->c1 to
- * c->options. The latter ones can be altered by
- * pushed options and therefore need to be restored
- * to original values on sigusr1 restart.
- */
+/* Restores NCP-negotiable options to original values */
 static void
-do_unset_ncp_options(struct context *c)
+restore_ncp_options(struct context *c)
 {
     c->options.ciphername = c->c1.ciphername;
     c->options.authname = c->c1.authname;
@@ -648,7 +642,7 @@ context_init_1(struct context *c)
 
     init_connection_list(c);
 
-    do_set_ncp_options(c);
+    save_ncp_options(c);
 
 #if defined(ENABLE_PKCS11)
     if (c->first_time)
@@ -4320,7 +4314,7 @@ close_instance(struct context *c)
         /* free key schedules */
         do_close_free_key_schedule(c, (c->mode == CM_P2P || c->mode == CM_TOP));
 
-        do_unset_ncp_options(c);
+        restore_ncp_options(c);
 
         /* close TCP/UDP connection */
         do_close_link_socket(c);
-- 
2.7.4


