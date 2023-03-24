From: Arne Schwabe <arne@...1227...>
Date: Fri, 24 Mar 2023 13:10:50 +0100
Message-Id: <20230324121050.1350913-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Parse compression options and bail out
 when compression is disabled
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

This change keeps the option parsing of compression options even when
compression is disabled. This allows OpenVPN to also refuse/reject connections
that try to use compression when compression is completely disabled.

Patch v4: fix one missing USE_COMP

Change-Id: I9d7afd8f1d67d2455b4ec6bc12f4dcde80140c4f
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/comp.c    | 14 ++++---
 src/openvpn/comp.h    | 85 ++++++++++++++++++++++---------------------
 src/openvpn/init.c    |  4 +-
 src/openvpn/multi.c   |  2 -
 src/openvpn/options.c | 12 +-----
 src/openvpn/options.h |  4 --
 6 files changed, 56 insertions(+), 65 deletions(-)

diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index c7a562f5a..27b640ce0 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -29,10 +29,11 @@
 
 #include "syshead.h"
 
-#ifdef USE_COMP
-
 #include "comp.h"
 #include "error.h"
+
+#ifdef USE_COMP
+
 #include "otime.h"
 
 #include "memdbg.h"
@@ -158,6 +159,7 @@ comp_generate_peer_info_string(const struct compress_options *opt, struct buffer
     buf_printf(out, "IV_COMP_STUB=1\n");
     buf_printf(out, "IV_COMP_STUBv2=1\n");
 }
+#endif /* USE_COMP */
 
 bool
 check_compression_settings_valid(struct compress_options *info, int msglevel)
@@ -170,8 +172,13 @@ check_compression_settings_valid(struct compress_options *info, int msglevel)
     if (info->alg != COMP_ALGV2_UNCOMPRESSED && info->alg != COMP_ALG_UNDEF
         && (info->flags & COMP_F_ALLOW_NOCOMP_ONLY))
     {
+#ifdef USE_COMP
         msg(msglevel, "Compression or compression stub framing is not allowed "
             "since data-channel offloading is enabled.");
+#else
+        msg(msglevel, "Compression or compression stub framing is not allowed "
+            "since OpenVPN was built without compression support.");
+#endif
         return false;
     }
 
@@ -199,6 +206,3 @@ check_compression_settings_valid(struct compress_options *info, int msglevel)
 #endif
     return true;
 }
-
-
-#endif /* USE_COMP */
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 71b350d09..89940cf3a 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -28,12 +28,19 @@
 #ifndef OPENVPN_COMP_H
 #define OPENVPN_COMP_H
 
-#ifdef USE_COMP
+/* We always parse all compression options, so we include these defines/struct
+ * outside of the USE_COMP define */
 
-#include "buffer.h"
-#include "mtu.h"
-#include "common.h"
-#include "status.h"
+/* Compression flags */
+#define COMP_F_ADAPTIVE             (1<<0) /* COMP_ALG_LZO only */
+#define COMP_F_ALLOW_COMPRESS       (1<<1) /* not only downlink is compressed but also uplink */
+#define COMP_F_SWAP                 (1<<2) /* initial command byte is swapped with last byte in buffer to preserve payload alignment */
+#define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only support compression stubs */
+#define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
+                                            * we still accept other compressions to be pushed */
+#define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
+#define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly set to allow asymetric compression */
+#define COMP_F_ALLOW_NOCOMP_ONLY    (1<<7) /* Do not allow compression framing (breaks DCO) */
 
 /* algorithms */
 #define COMP_ALG_UNDEF  0
@@ -51,16 +58,37 @@
  #define COMP_ALGV2_SNAPPY   13
  */
 
-/* Compression flags */
-#define COMP_F_ADAPTIVE             (1<<0) /* COMP_ALG_LZO only */
-#define COMP_F_ALLOW_COMPRESS       (1<<1) /* not only downlink is compressed but also uplink */
-#define COMP_F_SWAP                 (1<<2) /* initial command byte is swapped with last byte in buffer to preserve payload alignment */
-#define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only support compression stubs */
-#define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
-                                            * we still accept other compressions to be pushed */
-#define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
-#define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly set to allow asymetric compression */
-#define COMP_F_ALLOW_NOCOMP_ONLY    (1<<7) /* Do not allow compression framing (breaks DCO) */
+/*
+ * Information that basically identifies a compression
+ * algorithm and related flags.
+ */
+struct compress_options
+{
+    int alg;
+    unsigned int flags;
+};
+
+static inline bool
+comp_non_stub_enabled(const struct compress_options *info)
+{
+    return info->alg != COMP_ALGV2_UNCOMPRESSED
+           && info->alg != COMP_ALG_STUB
+           && info->alg != COMP_ALG_UNDEF;
+}
+
+/**
+ * Checks if the compression settings are valid. Takes into account the
+ * flags of allow-compression and also the whether algorithms are compiled
+ * in
+ */
+bool
+check_compression_settings_valid(struct compress_options *info, int msglevel);
+
+#ifdef USE_COMP
+#include "buffer.h"
+#include "mtu.h"
+#include "common.h"
+#include "status.h"
 
 /*
  * Length of prepended prefix on compressed packets
@@ -130,16 +158,6 @@ struct compress_alg
 #include "comp-lz4.h"
 #endif
 
-/*
- * Information that basically identifies a compression
- * algorithm and related flags.
- */
-struct compress_options
-{
-    int alg;
-    unsigned int flags;
-};
-
 /*
  * Workspace union of all supported compression algorithms
  */
@@ -187,22 +205,5 @@ comp_enabled(const struct compress_options *info)
 {
     return info->alg != COMP_ALG_UNDEF;
 }
-
-static inline bool
-comp_non_stub_enabled(const struct compress_options *info)
-{
-    return info->alg != COMP_ALGV2_UNCOMPRESSED
-           && info->alg != COMP_ALG_STUB
-           && info->alg != COMP_ALG_UNDEF;
-}
-
-/**
- * Checks if the compression settings are valid. Takes into account the
- * flags of allow-compression and also the whether algorithms are compiled
- * in
- */
-bool
-check_compression_settings_valid(struct compress_options *info, int msglevel);
-
 #endif /* USE_COMP */
 #endif /* ifndef OPENVPN_COMP_H */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 14859499d..d358ad003 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2634,7 +2634,6 @@ do_deferred_options(struct context *c, const unsigned int found)
         }
     }
 
-#ifdef USE_COMP
     if (found & OPT_P_COMP)
     {
         if (!check_compression_settings_valid(&c->options.comp, D_PUSH_ERRORS))
@@ -2645,11 +2644,12 @@ do_deferred_options(struct context *c, const unsigned int found)
                 "See also allow-compression in the manual.");
             return false;
         }
+#ifdef USE_COMP
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: compression parms modified");
         comp_uninit(c->c2.comp_context);
         c->c2.comp_context = comp_init(&c->options.comp);
-    }
 #endif
+    }
 
     if (found & OPT_P_SHAPER)
     {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ac090ef5a..5444e7520 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2766,13 +2766,11 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         cc_succeeded = false;
     }
 
-#ifdef USE_COMP
     if (!check_compression_settings_valid(&mi->context.options.comp, D_MULTI_ERRORS))
     {
         msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to invalid compression options");
         cc_succeeded = false;
     }
-#endif
 
     if (cc_succeeded)
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0ccff7213..2680f2684 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1906,10 +1906,8 @@ show_settings(const struct options *o)
 
     SHOW_BOOL(fast_io);
 
-#ifdef USE_COMP
     SHOW_INT(comp.alg);
     SHOW_INT(comp.flags);
-#endif
 
     SHOW_STR(route_script);
     SHOW_STR(route_default_gateway);
@@ -3320,9 +3318,7 @@ pre_connect_save(struct options *o)
     o->pre_connect->ping_send_timeout = o->ping_send_timeout;
 
     /* Miscellaneous Options */
-#ifdef USE_COMP
     o->pre_connect->comp = o->comp;
-#endif
 }
 
 void
@@ -3386,9 +3382,7 @@ pre_connect_restore(struct options *o, struct gc_arena *gc)
         o->ping_send_timeout = pp->ping_send_timeout;
 
         /* Miscellaneous Options */
-#ifdef USE_COMP
         o->comp = pp->comp;
-#endif
     }
 
     o->push_continuation = 0;
@@ -3651,6 +3645,8 @@ options_set_backwards_compatible_options(struct options *o)
             o->comp.flags = COMP_F_ALLOW_STUB_ONLY | COMP_F_ADVERTISE_STUBS_ONLY;
         }
     }
+#else  /* ifdef USE_COMP */
+    o->comp.flags = COMP_F_ALLOW_NOCOMP_ONLY;
 #endif
 }
 
@@ -5665,7 +5661,6 @@ set_user_script(struct options *options,
 #endif
 }
 
-#ifdef USE_COMP
 static void
 show_compression_warning(struct compress_options *info)
 {
@@ -5684,7 +5679,6 @@ show_compression_warning(struct compress_options *info)
         }
     }
 }
-#endif
 
 bool
 key_is_external(const struct options *options)
@@ -8366,7 +8360,6 @@ add_option(struct options *options,
         options->passtos = true;
     }
 #endif
-#if defined(USE_COMP)
     else if (streq(p[0], "allow-compression") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
@@ -8502,7 +8495,6 @@ add_option(struct options *options,
 
         show_compression_warning(&options->comp);
     }
-#endif /* USE_COMP */
     else if (streq(p[0], "show-ciphers") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2f25f5d07..f5890b90f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -87,9 +87,7 @@ struct options_pre_connect
     int ping_rec_timeout_action;
 
     int foreign_option_index;
-#ifdef USE_COMP
     struct compress_options comp;
-#endif
 };
 
 #if !defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_MBEDTLS)
@@ -395,9 +393,7 @@ struct options
     /* optimize TUN/TAP/UDP writes */
     bool fast_io;
 
-#ifdef USE_COMP
     struct compress_options comp;
-#endif
 
     /* buffer sizes */
     int rcvbuf;
-- 
2.37.1 (Apple Git-137.1)


