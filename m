From: Arne Schwabe <arne@...1227...>
Date: Sun, 14 Apr 2013 13:09:20 +0200
Message-Id: <1365937760-17910-1-git-send-email-arne@...1227...>
In-Reply-To: <1365679916-5484-1-git-send-email-arne@...1227...>
References: <1365679916-5484-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove unused variables or put them to the
	defines they are being used in
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

---
 src/openvpn/crypto.c      |    2 --
 src/openvpn/init.c        |    1 -
 src/openvpn/misc.c        |    8 --------
 src/openvpn/options.c     |   26 +++++++++++++-------------
 src/openvpn/proxy.c       |    1 -
 src/openvpn/route.c       |    1 -
 src/openvpn/ssl.c         |    4 ----
 src/openvpn/ssl_openssl.c |    2 --
 src/openvpn/ssl_verify.c  |    2 ++
 9 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d9adf5b..c4c356d 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1028,7 +1028,6 @@ read_passphrase_hash (const char *passphrase_file,
 		      uint8_t *output,
 		      int len)
 {
-  unsigned int outlen = 0;
   md_ctx_t md;
 
   ASSERT (len >= md_kt_size(digest));
@@ -1361,7 +1360,6 @@ prng_bytes (uint8_t *output, int len)
       const int md_size = md_kt_size (nonce_md);
       while (len > 0)
 	{
-	  unsigned int outlen = 0;
 	  const int blen = min_int (len, md_size);
 	  md_full(nonce_md, nonce_data, md_size + nonce_secret_len, nonce_data);
 	  memcpy (output, nonce_data, blen);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 979ba23..15a584e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1204,7 +1204,6 @@ do_init_route_ipv6_list (const struct options *options,
 		    struct env_set *es)
 {
   const char *gw = NULL;
-  int dev = dev_type_enum (options->dev, options->dev_type);
   int metric = -1;		/* no metric set */
 
   gw = options->ifconfig_ipv6_remote;		/* default GW = remote end */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index fa327f8..1120adc 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -701,14 +701,6 @@ env_set_remove_from_environment (const struct env_set *es)
     }
 }
 
-#ifdef HAVE_PUTENV
-
-/* companion functions to putenv */
-
-static struct env_item *global_env = NULL; /* GLOBAL */
-
-#endif
-
 /* add/modify/delete environmental strings */
 
 void
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ec39212..1358968 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2423,20 +2423,20 @@ options_postprocess_mutate_invariant (struct options *options)
     options->ifconfig_noexec = true;
 
 #ifdef WIN32
-  if ((dev == DEV_TYPE_TUN || dev == DEV_TYPE_TAP) && !options->route_delay_defined)
-    {
-      if (options->mode == MODE_POINT_TO_POINT)
-	{
-	  options->route_delay_defined = true;
-	  options->route_delay = 5; /* Vista sometimes has a race without this */
-	}
-    }
+    if ((dev == DEV_TYPE_TUN || dev == DEV_TYPE_TAP) && !options->route_delay_defined)
+      {
+        if (options->mode == MODE_POINT_TO_POINT)
+          {
+            options->route_delay_defined = true;
+            options->route_delay = 5; /* Vista sometimes has a race without this */
+          }
+      }
 
-  if (options->ifconfig_noexec)
-    {
-      options->tuntap_options.ip_win32_type = IPW32_SET_MANUAL;
-      options->ifconfig_noexec = false;
-    }
+    if (options->ifconfig_noexec)
+      {
+        options->tuntap_options.ip_win32_type = IPW32_SET_MANUAL;
+        options->ifconfig_noexec = false;
+      }
 #endif
 
 #if P2MP_SERVER
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 95d7153..04ed421 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -439,7 +439,6 @@ struct http_proxy_info *
 http_proxy_new (const struct http_proxy_options *o)
 {
   struct http_proxy_info *p;
-  struct http_proxy_options opt;
 
   if (!o || !o->server)
     msg (M_FATAL, "HTTP_PROXY: server not specified");
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 4c1e14e..ba1f3f1 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2866,7 +2866,6 @@ get_default_gateway (struct route_gateway_info *rgi)
 	{
 	  /* get interface name */
 	  const struct sockaddr_dl *adl = (struct sockaddr_dl *) ifp;
-	  int len = adl->sdl_nlen;
 	  if (adl->sdl_nlen && adl->sdl_nlen < sizeof(rgi->iface))
 	    {
 	      memcpy (rgi->iface, adl->sdl_data, adl->sdl_nlen);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 43b3980..f79c29c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1732,7 +1732,6 @@ key_method_1_write (struct buffer *buf, struct tls_session *session)
 {
   struct key key;
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
-  struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
 
   ASSERT (session->opt->key_method == 1);
   ASSERT (buf_init (buf, 0));
@@ -1844,7 +1843,6 @@ static bool
 key_method_2_write (struct buffer *buf, struct tls_session *session)
 {
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
-  struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
 
   ASSERT (session->opt->key_method == 2);
   ASSERT (buf_init (buf, 0));
@@ -1928,7 +1926,6 @@ key_method_1_read (struct buffer *buf, struct tls_session *session)
   int status;
   struct key key;
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
-  struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
 
   ASSERT (session->opt->key_method == 1);
 
@@ -1987,7 +1984,6 @@ static bool
 key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_session *session)
 {
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
-  struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
 
   int key_method_flags;
   bool username_status, password_status;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 79cc056..574e1ca 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -490,7 +490,6 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
     const char *priv_key_file_inline
     )
 {
-  int status;
   SSL_CTX *ssl_ctx = NULL;
   BIO *in = NULL;
   EVP_PKEY *pkey = NULL;
@@ -1193,7 +1192,6 @@ show_available_tls_ciphers ()
   SSL_CTX *ctx;
   SSL *ssl;
   const char *cipher_name;
-  const char *print_name;
   const tls_cipher_name_pair *pair;
   int priority = 0;
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e651a8e..b1bbc96 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1027,7 +1027,9 @@ static int
 verify_user_pass_plugin (struct tls_session *session, const struct user_pass *up, const char *raw_username)
 {
   int retval = OPENVPN_PLUGIN_FUNC_ERROR;
+#ifdef PLUGIN_DEF_AUTH
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
+#endif
 
   /* Is username defined? */
   if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen (up->username))
-- 
1.7.9.5


