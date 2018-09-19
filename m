From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 19 Sep 2018 19:37:42 +0300
Message-Id: <1537375062-1385-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Refactor NCP-negotiable options handling
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

This patch decouples setting/unsetting NCP options
from the state of TLS context. At startup (and then
per sighup) we load config (pre-NCP) values to c1,
which persists over sigusr1. When tearing tunnel down
we restore (possibly modified) c->options back to
c1 (original) values.

Fixes #1105

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/init.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f432106..9353527 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -612,6 +612,33 @@ uninit_proxy(struct context *c)
     uninit_proxy_dowork(c);
 }
 
+/*
+ * Assign NCP-negotiable options to context->c1
+ * from context->options (initially config values).
+ * They persist over sigusr1 restart.
+ */
+static void
+do_set_ncp_options(struct context *c)
+{
+    c->c1.ciphername = c->options.ciphername;
+    c->c1.authname = c->options.authname;
+    c->c1.keysize = c->options.keysize;
+}
+
+/*
+ * Restore NCP-negotiable options from c->c1 to
+ * c->options. The latter ones can be altered by
+ * pushed options and therefore need to be restored
+ * to original values on sigusr1 restart.
+ */
+static void
+do_unset_ncp_options(struct context *c)
+{
+    c->options.ciphername = c->c1.ciphername;
+    c->options.authname = c->c1.authname;
+    c->options.keysize = c->c1.keysize;
+}
+
 void
 context_init_1(struct context *c)
 {
@@ -621,6 +648,8 @@ context_init_1(struct context *c)
 
     init_connection_list(c);
 
+    do_set_ncp_options(c);
+
 #if defined(ENABLE_PKCS11)
     if (c->first_time)
     {
@@ -2593,10 +2622,6 @@ do_init_crypto_tls_c1(struct context *c)
         /* initialize tls-auth/crypt key */
         do_init_tls_wrap_key(c);
 
-        c->c1.ciphername = options->ciphername;
-        c->c1.authname = options->authname;
-        c->c1.keysize = options->keysize;
-
 #if 0 /* was: #if ENABLE_INLINE_FILES --  Note that enabling this code will break restarts */
         if (options->priv_key_file_inline)
         {
@@ -2609,11 +2634,6 @@ do_init_crypto_tls_c1(struct context *c)
     {
         msg(D_INIT_MEDIUM, "Re-using SSL/TLS context");
 
-        /* Restore pre-NCP cipher options */
-        c->options.ciphername = c->c1.ciphername;
-        c->options.authname = c->c1.authname;
-        c->options.keysize = c->c1.keysize;
-
         /*
          * tls-auth/crypt key can be configured per connection block, therefore
          * we must reload it as it may have changed
@@ -4293,6 +4313,8 @@ close_instance(struct context *c)
         /* free key schedules */
         do_close_free_key_schedule(c, (c->mode == CM_P2P || c->mode == CM_TOP));
 
+        do_unset_ncp_options(c);
+
         /* close TCP/UDP connection */
         do_close_link_socket(c);
 
-- 
2.7.4


