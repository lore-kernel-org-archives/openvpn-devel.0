From: Steffan Karger <steffan@...1856...>
Date: Tue,  1 Nov 2016 20:06:47 +0100
Message-Id: <1478027207-28651-1-git-send-email-steffan@...1856...>
In-Reply-To: <1473682461-26382-1-git-send-email-steffan@...1856...>
References: <1473682461-26382-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v3] Restore pre-NCP cipher options on SIGUSR1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

As reported by debbie10t on the openvpn-devel list (Message-ID:
<326b8ff7-39a6-1974-c0b0-82fd2abdc7b7@...277...>), an NCP client will
attempt to reconnect with the previously pushed cipher, instead of the
cipher from the config file, after a sigusr1 restart.  This can be a
problem when the server is reconfigured (as debbie10t explainted), or when
roaming to a differently-configured server.  Fix this by restoring the
cipher options from the config file after a sigusr1 restart.

This makes the cipher options behaviour different from other pushable
options, because those are also cached until a sighup restart.  We might
want to change this behaviour in general, but for now let's just fix the
issue at hand.

v2: also cache and restore keysize, as that parameter is relevant too.
v3: inherit cached cipher options from parent context.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c    | 10 ++++++++++
 src/openvpn/openvpn.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ea96f3d..5d25d5f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2273,6 +2273,7 @@ do_init_crypto_tls_c1 (struct context *c)
 
       c->c1.ciphername = options->ciphername;
       c->c1.authname = options->authname;
+      c->c1.keysize = options->keysize;
 
 #if 0 /* was: #if ENABLE_INLINE_FILES --  Note that enabling this code will break restarts */
       if (options->priv_key_file_inline)
@@ -2285,6 +2286,11 @@ do_init_crypto_tls_c1 (struct context *c)
   else
     {
       msg (D_INIT_MEDIUM, "Re-using SSL/TLS context");
+
+      /* Restore pre-NCP cipher options */
+      c->options.ciphername = c->c1.ciphername;
+      c->options.authname = c->c1.authname;
+      c->options.keysize = c->c1.keysize;
     }
 }
 
@@ -3811,6 +3817,10 @@ inherit_context_child (struct context *dest,
   dest->c1.ks.ssl_ctx = src->c1.ks.ssl_ctx;
   dest->c1.ks.tls_auth_key = src->c1.ks.tls_auth_key;
   dest->c1.ks.tls_auth_key_type = src->c1.ks.tls_auth_key_type;
+  /* inherit pre-NCP ciphers */
+  dest->c1.ciphername = src->c1.ciphername;
+  dest->c1.authname = src->c1.authname;
+  dest->c1.keysize = src->c1.keysize;
 #endif
 
   /* options */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 5cda7b4..4366a42 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -213,6 +213,7 @@ struct context_1
 
   const char *ciphername;	/**< Data channel cipher from config file */
   const char *authname;		/**< Data channel auth from config file */
+  int keysize;			/**< Data channel keysize from config file */
 #endif
 };
 
-- 
2.7.4


