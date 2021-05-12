From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 May 2021 15:15:05 +0200
Message-Id: <20210512131511.1309914-4-arne@...1227...>
In-Reply-To: <20210512131511.1309914-1-arne@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/9] Inline do_init_auth_token_key
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

The extra function does give really give a better understanding
of the code or does give any other benefit, inline it to make
the code more streamlined.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fa10d3d4f..1d77a9d42 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2671,22 +2671,6 @@ do_init_tls_wrap_key(struct context *c)
 
 }
 
-/*
- * Initialise the auth-token key context
- */
-static void
-do_init_auth_token_key(struct context *c)
-{
-    if (!c->options.auth_token_generate)
-    {
-        return;
-    }
-
-    auth_token_init_secret(&c->c1.ks.auth_token_key,
-                           c->options.auth_token_secret_file,
-                           c->options.auth_token_secret_file_inline);
-}
-
 /*
  * Initialize the persistent component of OpenVPN's TLS mode,
  * which is preserved across SIGUSR1 resets.
@@ -2761,7 +2745,12 @@ do_init_crypto_tls_c1(struct context *c)
         do_init_tls_wrap_key(c);
 
         /* initialise auth-token crypto support */
-        do_init_auth_token_key(c);
+        if (c->options.auth_token_generate)
+        {
+            auth_token_init_secret(&c->c1.ks.auth_token_key,
+                                   c->options.auth_token_secret_file,
+                                   c->options.auth_token_secret_file_inline);
+        }
 
 #if 0 /* was: #if ENABLE_INLINE_FILES --  Note that enabling this code will break restarts */
         if (options->priv_key_file_inline)
-- 
2.31.1


