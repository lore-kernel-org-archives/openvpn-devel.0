From: Arne Schwabe <arne@...1227...>
Date: Mon, 18 Jun 2012 20:39:08 +0200
Message-Id: <1340044749-10694-6-git-send-email-arne@...1227...>
In-Reply-To: <1340044749-10694-1-git-send-email-arne@...1227...>
References: <1340044749-10694-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 5/6] Fix most of the clang warnings,
	mostly unused variables and comparisons which were always true
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


Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c             |    2 --
 src/openvpn/mroute.c             |   28 ++++++++++++----------------
 src/openvpn/multi.c              |    7 +------
 src/openvpn/options.c            |    2 --
 src/openvpn/route.c              |    1 -
 src/openvpn/ssl.c                |    4 ----
 src/openvpn/ssl_openssl.c        |    1 -
 src/openvpn/ssl_verify_openssl.c |    2 +-
 8 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ac2eecd..a898ffb 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1010,7 +1010,6 @@ read_passphrase_hash (const char *passphrase_file,
 		      uint8_t *output,
 		      int len)
 {
-  unsigned int outlen = 0;
   md_ctx_t md;
 
   ASSERT (len >= md_kt_size(digest));
@@ -1343,7 +1342,6 @@ prng_bytes (uint8_t *output, int len)
       const int md_size = md_kt_size (nonce_md);
       while (len > 0)
 	{
-	  unsigned int outlen = 0;
 	  const int blen = min_int (len, md_size);
 	  md_full(nonce_md, nonce_data, md_size + nonce_secret_len, nonce_data);
 	  memcpy (output, nonce_data, blen);
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index aecb702..5449a9b 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -522,29 +522,25 @@ void
 mroute_helper_add_iroute6 (struct mroute_helper *mh, 
                            const struct iroute_ipv6 *ir6)
 {
-  if (ir6->netbits >= 0)
-    {
-      ASSERT (ir6->netbits < MR_HELPER_NET_LEN);
-      ++mh->cache_generation;
-      ++mh->net_len_refcount[ir6->netbits];
-      if (mh->net_len_refcount[ir6->netbits] == 1)
+  ASSERT (ir6->netbits < MR_HELPER_NET_LEN);
+  ++mh->cache_generation;
+  ++mh->net_len_refcount[ir6->netbits];
+  if (mh->net_len_refcount[ir6->netbits] == 1)
 	mroute_helper_regenerate (mh);
-    }
+
 }
 
 void
 mroute_helper_del_iroute6 (struct mroute_helper *mh, 
 			   const struct iroute_ipv6 *ir6)
 {
-  if (ir6->netbits >= 0)
-    {
-      ASSERT (ir6->netbits < MR_HELPER_NET_LEN);
-      ++mh->cache_generation;
-      --mh->net_len_refcount[ir6->netbits];
-      ASSERT (mh->net_len_refcount[ir6->netbits] >= 0);
-      if (!mh->net_len_refcount[ir6->netbits])
-	mroute_helper_regenerate (mh);
-    }
+   ASSERT (ir6->netbits < MR_HELPER_NET_LEN);
+   ++mh->cache_generation;
+   --mh->net_len_refcount[ir6->netbits];
+   ASSERT (mh->net_len_refcount[ir6->netbits] >= 0);
+   if (!mh->net_len_refcount[ir6->netbits])
+     mroute_helper_regenerate (mh);
+
 }
 
 void
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9876b80..1a17869 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1164,15 +1164,10 @@ multi_add_iroutes (struct multi_context *m,
 	}
       for ( ir6 = mi->context.options.iroutes_ipv6; ir6 != NULL; ir6 = ir6->next )
 	{
-	  if (ir6->netbits >= 0)
-	    msg (D_MULTI_LOW, "MULTI: internal route %s/%d -> %s",
+      msg (D_MULTI_LOW, "MULTI: internal route %s/%d -> %s",
 		 print_in6_addr (ir6->network, 0, &gc),
 		 ir6->netbits,
 		 multi_instance_string (mi, false, &gc));
-	  else
-	    msg (D_MULTI_LOW, "MULTI: internal route %s -> %s",
-		 print_in6_addr (ir6->network, 0, &gc),
-		 multi_instance_string (mi, false, &gc));
 
 	  mroute_helper_add_iroute6 (m->route_helper, ir6);
       
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ea60826..64e42aa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2455,8 +2455,6 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
 static void
 options_postprocess_mutate_invariant (struct options *options)
 {
-  const int dev = dev_type_enum (options->dev, options->dev_type);
-
   /*
    * In forking TCP server mode, you don't need to ifconfig
    * the tap device (the assumption is that it will be bridged).
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d967d4f..4999e66 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2864,7 +2864,6 @@ get_default_gateway (struct route_gateway_info *rgi)
 	{
 	  /* get interface name */
 	  const struct sockaddr_dl *adl = (struct sockaddr_dl *) ifp;
-	  int len = adl->sdl_nlen;
 	  if (adl->sdl_nlen && adl->sdl_nlen < sizeof(rgi->iface))
 	    {
 	      memcpy (rgi->iface, adl->sdl_data, adl->sdl_nlen);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 19512c0..0272805 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1585,7 +1585,6 @@ key_method_1_write (struct buffer *buf, struct tls_session *session)
 {
   struct key key;
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
-  struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
 
   ASSERT (session->opt->key_method == 1);
   ASSERT (buf_init (buf, 0));
@@ -1697,7 +1696,6 @@ static bool
 key_method_2_write (struct buffer *buf, struct tls_session *session)
 {
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
-  struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
 
   ASSERT (session->opt->key_method == 2);
   ASSERT (buf_init (buf, 0));
@@ -1781,7 +1779,6 @@ key_method_1_read (struct buffer *buf, struct tls_session *session)
   int status;
   struct key key;
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
-  struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
 
   ASSERT (session->opt->key_method == 1);
 
@@ -1840,7 +1837,6 @@ static bool
 key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_session *session)
 {
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
-  struct key_state *ks_lame = &session->key[KS_LAME_DUCK]; /* retiring key */
 
   int key_method_flags;
   bool username_status, password_status;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a727b60..57285fa 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -428,7 +428,6 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
     const char *priv_key_file_inline
     )
 {
-  int status;
   SSL_CTX *ssl_ctx = NULL;
   BIO *in = NULL;
   EVP_PKEY *pkey = NULL;
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index f5dce0d..219d0a7 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -241,7 +241,7 @@ x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 unsigned char *
 x509_get_sha1_hash (X509 *cert, struct gc_arena *gc)
 {
-  char *hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
+  unsigned char *hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
   memcpy(hash, cert->sha1_hash, SHA_DIGEST_LENGTH);
   return hash;
 }
-- 
1.7.7.5 (Apple Git-26)


