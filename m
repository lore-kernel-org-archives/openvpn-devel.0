From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 31 Oct 2018 14:07:16 +0100
Message-ID: <1540991236-4016-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tls-crypt-v2: fix client reconnect bug
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

As reported by tincantech on the openvpn-devel IRC channel, a tls-crypt-v2
client could be caused to trigger an assert in tls_crypt_wrap() because the
client key might not be correctly initialized after a reconnect attempt.

This was caused by code that was written before the connection-block
tls-auth/tls-crypt logic was integrated (57d6f103), rebased on that change,
but not sufficiently changed to be compatible with the new logic.

This commit fixes that bug.

Note that I also moved the violating hunk of code to the same function
where the tls-auth and tls-crypt (v1) keys are initialized. Once moved
there, it is immediately clear that v2 didn't follow the same (new) logic.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/init.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 39e8ca5..2a1b38e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2594,6 +2594,26 @@ do_init_tls_wrap_key(struct context *c)
                            options->ce.tls_crypt_file,
                            options->ce.tls_crypt_inline, options->tls_server);
     }
+
+    /* tls-crypt with client-specific keys (--tls-crypt-v2) */
+    if (options->ce.tls_crypt_v2_file)
+    {
+        if (options->tls_server)
+        {
+            tls_crypt_v2_init_server_key(&c->c1.ks.tls_crypt_v2_server_key,
+                                         true, options->ce.tls_crypt_v2_file,
+                                         options->ce.tls_crypt_v2_inline);
+        }
+        else
+        {
+            tls_crypt_v2_init_client_key(&c->c1.ks.tls_wrap_key,
+                                         &c->c1.ks.tls_crypt_v2_wkc,
+                                         options->ce.tls_crypt_v2_file,
+                                         options->ce.tls_crypt_v2_inline);
+        }
+    }
+
+
 }
 
 /*
@@ -2645,27 +2665,9 @@ do_init_crypto_tls_c1(struct context *c)
         /* Initialize PRNG with config-specified digest */
         prng_init(options->prng_hash, options->prng_nonce_secret_len);
 
-        /* initialize tls-auth/crypt key */
+        /* initialize tls-auth/crypt/crypt-v2 key */
         do_init_tls_wrap_key(c);
 
-        /* tls-crypt with client-specific keys (--tls-crypt-v2) */
-        if (options->tls_crypt_v2_file)
-        {
-            if (options->tls_server)
-            {
-                tls_crypt_v2_init_server_key(&c->c1.ks.tls_crypt_v2_server_key,
-                                             true, options->tls_crypt_v2_file,
-                                             options->tls_crypt_v2_inline);
-            }
-            else
-            {
-                tls_crypt_v2_init_client_key(&c->c1.ks.tls_wrap_key,
-                                             &c->c1.ks.tls_crypt_v2_wkc,
-                                             options->tls_crypt_v2_file,
-                                             options->tls_crypt_v2_inline);
-            }
-        }
-
 #if 0 /* was: #if ENABLE_INLINE_FILES --  Note that enabling this code will break restarts */
         if (options->priv_key_file_inline)
         {
@@ -2891,13 +2893,13 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         to.tls_wrap.opt.flags |= CO_PACKET_ID_LONG_FORM;
         tls_crypt_adjust_frame_parameters(&to.frame);
 
-        if (options->tls_crypt_v2_file)
+        if (options->ce.tls_crypt_v2_file)
         {
             to.tls_wrap.tls_crypt_v2_wkc = &c->c1.ks.tls_crypt_v2_wkc;
         }
     }
 
-    if (options->tls_crypt_v2_file)
+    if (options->ce.tls_crypt_v2_file)
     {
         to.tls_crypt_v2 = true;
         if (options->tls_server)
-- 
2.7.4


