From: Gert Doering <gert@...1296...>
Date: Fri, 10 Jan 2014 17:25:41 +0100
Message-Id: <1389371142-26705-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 1/2] remove some "unused variable" warnings
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

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/comp-lz4.c | 1 -
 src/openvpn/options.c  | 2 ++
 src/openvpn/ssl.c      | 3 +--
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index afa43b1..4651148 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -64,7 +64,6 @@ lz4_compress (struct buffer *buf, struct buffer work,
 	       struct compress_context *compctx,
 	       const struct frame* frame)
 {
-  int result;
   bool compressed = false;
 
   if (buf->len <= 0)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0803da7..9e21d5a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2425,7 +2425,9 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
 static void
 options_postprocess_mutate_invariant (struct options *options)
 {
+#ifdef WIN32
   const int dev = dev_type_enum (options->dev, options->dev_type);
+#endif
 
   /*
    * In forking TCP server mode, you don't need to ifconfig
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 15518ca..c61701a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1331,7 +1331,7 @@ tls1_P_hash(const md_kt_t *md_kt,
 	    int olen)
 {
   struct gc_arena gc = gc_new ();
-  int chunk,n;
+  int chunk;
   hmac_ctx_t ctx;
   hmac_ctx_t ctx_tmp;
   uint8_t A1[MAX_HMAC_KEY_LENGTH];
@@ -1357,7 +1357,6 @@ tls1_P_hash(const md_kt_t *md_kt,
   hmac_ctx_update(&ctx,seed,seed_len);
   hmac_ctx_final(&ctx, A1);
 
-  n=0;
   for (;;)
     {
       hmac_ctx_reset(&ctx);
-- 
1.8.3.2


