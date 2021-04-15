From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Thu, 15 Apr 2021 11:12:48 +0200
Message-ID: <20210415091248.18149-1-maximilian.fillinger@...2507...>
In-Reply-To: <dcd5b87c-6a68-a191-dae9-cc35ecb99b65@...2181...>
References: <dcd5b87c-6a68-a191-dae9-cc35ecb99b65@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 1/2] In init_ssl,
 open the correct CRL path pre-chroot
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
Cc: a@...2181...

When using the chroot option, the init_ssl function can be called before
entering the chroot or, when OpenVPN receives a SIGHUP, afterwards. This
commit ensures that OpenVPN tries to open the correct path for the CRL
file in either situation.

This commit does not address key and certificate files. For these, the
--persist-key option should be used.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/init.c    |  2 +-
 src/openvpn/misc.c    | 11 +++++++++++
 src/openvpn/misc.h    |  6 ++++++
 src/openvpn/options.c |  8 +-------
 src/openvpn/ssl.c     | 21 +++++++++++++++++++--
 src/openvpn/ssl.h     |  2 +-
 6 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 28d183aa..f18e054a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2702,7 +2702,7 @@ do_init_crypto_tls_c1(struct context *c)
          * Initialize the OpenSSL library's global
          * SSL context.
          */
-        init_ssl(options, &(c->c1.ks.ssl_ctx));
+        init_ssl(options, &(c->c1.ks.ssl_ctx), c->c0 && c->c0->uid_gid_chroot_set);
         if (!tls_ctx_initialised(&c->c1.ks.ssl_ctx))
         {
             switch (auth_retry_get())
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index feaefb3b..650daa0c 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -767,3 +767,14 @@ get_num_elements(const char *string, char delimiter)
 
     return element_count;
 }
+
+struct buffer
+prepend_dir(const char *dir, const char *path, struct gc_arena *gc)
+{
+    size_t len = strlen(dir) + strlen(PATH_SEPARATOR_STR) + strlen(path) + 1;
+    struct buffer combined_path = alloc_buf_gc(len, gc);
+    buf_printf(&combined_path, "%s%s%s", dir, PATH_SEPARATOR_STR, path);
+    ASSERT(combined_path.len > 0);
+
+    return combined_path;
+}
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 9b018eb5..d9005353 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -190,4 +190,10 @@ void output_peer_info_env(struct env_set *es, const char *peer_info);
 int
 get_num_elements(const char *string, char delimiter);
 
+/**
+ * Prepend a directory to a path.
+ */
+struct buffer
+prepend_dir(const char *dir, const char *path, struct gc_arena *gc);
+
 #endif /* ifndef MISC_H */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9e61b1e0..9ce12a2b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3317,14 +3317,8 @@ check_file_access_chroot(const char *chroot, const int type, const char *file, c
     {
         struct gc_arena gc = gc_new();
         struct buffer chroot_file;
-        int len = 0;
-
-        /* Build up a new full path including chroot directory */
-        len = strlen(chroot) + strlen(PATH_SEPARATOR_STR) + strlen(file) + 1;
-        chroot_file = alloc_buf_gc(len, &gc);
-        buf_printf(&chroot_file, "%s%s%s", chroot, PATH_SEPARATOR_STR, file);
-        ASSERT(chroot_file.len > 0);
 
+        chroot_file = prepend_dir(chroot, file, &gc);
         ret = check_file_access(type, BSTR(&chroot_file), mode, opt);
         gc_free(&gc);
     }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d8662d00..1e0e6170 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -584,7 +584,7 @@ tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
  * All files are in PEM format.
  */
 void
-init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
+init_ssl(const struct options *options, struct tls_root_ctx *new_ctx, bool in_chroot)
 {
     ASSERT(NULL != new_ctx);
 
@@ -702,7 +702,24 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
     /* Read CRL */
     if (options->crl_file && !(options->ssl_flags & SSLF_CRL_VERIFY_DIR))
     {
-        tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_inline);
+        /* If we're running with the chroot option, we may run init_ssl() before
+         * and after chroot-ing. We can use the crl_file path as-is if we're
+         * not going to chroot, or if we already are inside the chroot.
+         *
+         * If we're going to chroot later, we need to prefix the path of the
+         * chroot directory to crl_file.
+         */
+        if (!options->chroot_dir || in_chroot || options->crl_file_inline)
+        {
+            tls_ctx_reload_crl(new_ctx, options->crl_file, options->crl_file_inline);
+        }
+        else
+        {
+            struct gc_arena gc = gc_new();
+            struct buffer crl_file_buf = prepend_dir(options->chroot_dir, options->crl_file, &gc);
+            tls_ctx_reload_crl(new_ctx, BSTR(&crl_file_buf), options->crl_file_inline);
+            gc_free(&gc);
+        }
     }
 
     /* Once keys and cert are loaded, load ECDH parameters */
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 300a70d3..45ebe720 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -159,7 +159,7 @@ void free_ssl_lib(void);
  * Build master SSL context object that serves for the whole of OpenVPN
  * instantiation
  */
-void init_ssl(const struct options *options, struct tls_root_ctx *ctx);
+void init_ssl(const struct options *options, struct tls_root_ctx *ctx, bool in_chroot);
 
 /** @addtogroup control_processor
  *  @{ */
-- 
2.11.0


