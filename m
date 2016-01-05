From: Arne Schwabe <arne@...1227...>
Date: Tue,  5 Jan 2016 15:56:01 +0100
Message-Id: <1452005761-5503-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix assert when comp is called with unknown
	algorithm, always call comp init method
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
 src/openvpn/comp.c    | 6 +++---
 src/openvpn/options.c | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index b420ea5..3a32c62 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -48,7 +48,6 @@ comp_init(const struct compress_options *opt)
       ALLOC_OBJ_CLEAR (compctx, struct compress_context);
       compctx->flags = opt->flags;
       compctx->alg = comp_stub_alg;
-      (*compctx->alg.compress_init)(compctx);
       break;
     case COMP_ALGV2_UNCOMPRESSED:
       ALLOC_OBJ_CLEAR (compctx, struct compress_context);
@@ -60,7 +59,6 @@ comp_init(const struct compress_options *opt)
       ALLOC_OBJ_CLEAR (compctx, struct compress_context);
       compctx->flags = opt->flags;
       compctx->alg = lzo_alg;
-      (*compctx->alg.compress_init)(compctx);
       break;
 #endif
 #ifdef ENABLE_LZ4
@@ -68,7 +66,6 @@ comp_init(const struct compress_options *opt)
       ALLOC_OBJ_CLEAR (compctx, struct compress_context);
       compctx->flags = opt->flags;
       compctx->alg = lz4_alg;
-      (*compctx->alg.compress_init)(compctx);
       break;
     case COMP_ALGV2_LZ4:
       ALLOC_OBJ_CLEAR (compctx, struct compress_context);
@@ -77,6 +74,9 @@ comp_init(const struct compress_options *opt)
       break;
 #endif
     }
+  if (compctx)
+    (*compctx->alg.compress_init)(compctx);
+
   return compctx;
 }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index af60850..ecffa2a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6318,7 +6318,6 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_COMP);
       if (p[1])
 	{
-	  options->comp.flags = 0;
 	  if (streq (p[1], "stub"))
 	    {
 	      options->comp.alg = COMP_ALG_STUB;
@@ -6333,6 +6332,7 @@ add_option (struct options *options,
 	  else if (streq (p[1], "lzo"))
 	    {
 	      options->comp.alg = COMP_ALG_LZO;
+	      options->comp.flags = 0;
 	    }
 #endif
 #if defined(ENABLE_LZ4)
@@ -6344,6 +6344,7 @@ add_option (struct options *options,
 	  else if (streq (p[1], "lz4-v2"))
 	    {
 	      options->comp.alg = COMP_ALGV2_LZ4;
+	      options->comp.flags = 0;
 	    }
 #endif
 	  else
-- 
2.5.4 (Apple Git-61)


