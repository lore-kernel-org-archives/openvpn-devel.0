From: Arne Schwabe <arne@...1227...>
Date: Mon, 22 Mar 2021 11:21:19 +0100
Message-Id: <20210322102119.14322-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove empty dummy functions
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

These functions seem to have been added to avoid MSVC compiler warnigns.
However nowadays, they trigger compiler warnings from Clang (e.g. when
using --disable-lzo and --disable-lz4):

src/openvpn/fdmisc.c
/Users/arne/oss/openvpn-git/src/openvpn/comp-lz4.c:315:1: error: unused function 'dummy' [-Werror,-Wunused-function]
dummy(void)
^
1 error generated.

Testing with MSVC shows that removing these functions does not trigger
warnings with MSVC either.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/comp-lz4.c  | 6 ------
 src/openvpn/compstub.c  | 6 ------
 src/openvpn/cryptoapi.c | 8 --------
 src/openvpn/fragment.c  | 6 ------
 src/openvpn/gremlin.c   | 6 ------
 src/openvpn/lzo.c       | 6 ------
 src/openvpn/mbuf.c      | 6 ------
 src/openvpn/ntlm.c      | 6 ------
 src/openvpn/perf.c      | 8 --------
 src/openvpn/pkcs11.c    | 8 --------
 src/openvpn/plugin.c    | 6 ------
 src/openvpn/shaper.c    | 6 ------
 12 files changed, 78 deletions(-)

diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 2168a783..9a29b887 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -309,10 +309,4 @@ const struct compress_alg lz4v2_alg = {
     lz4v2_compress,
     lz4v2_decompress
 };
-
-#else  /* if defined(ENABLE_LZ4) */
-static void
-dummy(void)
-{
-}
 #endif /* ENABLE_LZ4 */
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index 9123541b..1de683d0 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -175,10 +175,4 @@ const struct compress_alg comp_stub_alg = {
     stub_compress,
     stub_decompress
 };
-
-#else  /* if defined(USE_COMP) */
-static void
-dummy(void)
-{
-}
 #endif /* USE_STUB */
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 6c4df9e3..a992441b 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -1253,12 +1253,4 @@ err:
     CAPI_DATA_free(cd);
     return 0;
 }
-
-#else  /* ifdef ENABLE_CRYPTOAPI */
-#ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
-static void
-dummy(void)
-{
-}
-#endif
 #endif                          /* _WIN32 */
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 6df71d07..0a1b457e 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -436,10 +436,4 @@ fragment_wakeup(struct fragment_master *f, struct frame *frame)
     /* delete fragments with expired TTLs */
     fragment_ttl_reap(f);
 }
-
-#else  /* ifdef ENABLE_FRAGMENT */
-static void
-dummy(void)
-{
-}
 #endif /* ifdef ENABLE_FRAGMENT */
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index 3f2bded6..796f0526 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -233,10 +233,4 @@ corrupt_gremlin(struct buffer *buf, int flags)
         }
     }
 }
-
-#else  /* ifdef ENABLE_DEBUG */
-static void
-dummy(void)
-{
-}
 #endif /* ifdef ENABLE_DEBUG */
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index d053fedf..2864db1e 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -265,10 +265,4 @@ const struct compress_alg lzo_alg = {
     lzo_compress,
     lzo_decompress
 };
-
-#else  /* if defined(ENABLE_LZO) */
-static void
-dummy(void)
-{
-}
 #endif /* ENABLE_LZO */
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 87faff08..76f478b8 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -171,10 +171,4 @@ mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *mi)
         }
     }
 }
-
-#else  /* if P2MP */
-static void
-dummy(void)
-{
-}
 #endif /* P2MP */
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index e3707484..3abe3b7e 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -412,10 +412,4 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
     return ((const char *)make_base64_string2((unsigned char *)phase3,
                                               phase3_bufpos, gc));
 }
-
-#else  /* if NTLM */
-static void
-dummy(void)
-{
-}
 #endif /* if NTLM */
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index d8823585..40690fa0 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -318,12 +318,4 @@ perf_print_state(int lev)
     }
     gc_free(&gc);
 }
-
-#else  /* ifdef ENABLE_PERFORMANCE_METRICS */
-#ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
-static void
-dummy(void)
-{
-}
-#endif
 #endif /* ifdef ENABLE_PERFORMANCE_METRICS */
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 52422918..d55f106a 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -1001,12 +1001,4 @@ cleanup:
     pkcs11h_terminate();
     gc_free(&gc);
 }
-
-#else  /* if defined(ENABLE_PKCS11) */
-#ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
-static void
-dummy(void)
-{
-}
-#endif
 #endif /* ENABLE_PKCS11 */
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 8b351c45..234e92b9 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -1014,10 +1014,4 @@ plugin_return_print(const int msglevel, const char *prefix, const struct plugin_
     }
 }
 #endif /* ifdef ENABLE_DEBUG */
-
-#else  /* ifdef ENABLE_PLUGIN */
-static void
-dummy(void)
-{
-}
 #endif /* ENABLE_PLUGIN */
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index 62579840..57a24241 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -94,10 +94,4 @@ shaper_msg(struct shaper *s)
     msg(M_INFO, "Output Traffic Shaping initialized at %d bytes per second",
         s->bytes_per_second);
 }
-
-#else  /* ifdef ENABLE_FEATURE_SHAPER */
-static void
-dummy(void)
-{
-}
 #endif /* ENABLE_FEATURE_SHAPER */
-- 
2.30.1


