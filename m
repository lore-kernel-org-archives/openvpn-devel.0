From: Arne Schwabe <arne@...1227...>
Date: Wed, 22 Mar 2023 17:13:33 +0100
Message-Id: <20230322161333.1134510-1-arne@...1227...>
In-Reply-To: <20230210142712.572303-2-arne@...1227...>
References: <20230210142712.572303-2-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add 'allow-compression stub-only and
 refuse framing with 'allow-compression no'
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

This changes the "no" setting of allow-compression to also refuse framing. This
is important for our DCO implementation as these do not implement framing.

This behaviour surfaced when a commercial VPN provider was pushing
"comp-lzo no" to a client with DCO. While we are technically at fault here
for announcing comp-lzo no support by announcing IV_LZO_STUB=1, the
VPN provider continues to push "comp-lzo no" even in absense of that
flag.

As the new default we default to allow-compression stub-only if a stub option
is found in the config and to allow-compression no otherwise. This ensures
that we only enable DCO when no compression framing is used.

This will now also bail out if the server pushes a compression setting that
we do not support as mismatching compression is almost never a working
connection. In my lz4-v2 and lzo-v2 you might have a connection that works
mostly but some packets will be dropped since they compressed which is not
desirable either since it becomes very hard to debug.

Patch v2: bail out if server pushes an unsupported method. Also include this
          bail out logic when OpenVPN is compiled without compression support.

Change-Id: Ieefb501038b06c7520ed105c660a1c79887476f3
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                           |   6 ++
 doc/man-sections/protocol-options.rst |   3 +
 src/openvpn/comp.c                    |  32 +++---
 src/openvpn/comp.h                    |  44 ++++----
 src/openvpn/dco.c                     |   4 +-
 src/openvpn/init.c                    |  12 ++-
 src/openvpn/options.c                 | 150 ++++++++++++++++----------
 src/openvpn/options.h                 |   2 -
 8 files changed, 156 insertions(+), 97 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index dedb97ee4..17b4c4d04 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -232,6 +232,12 @@ User-visible Changes
 - The ``client-pending-auth`` management command now requires also the
   key id. The management version has been changed to 5 to indicate this change.
 
+- (OpenVPN 2.6.2) ``--allow-compression no`` has been changed to not allow
+  compression or compression framing at all now and is the new default.
+  Use ``--allow-compression stub-only`` for the old ``no`` behaviour of OpenVPN
+  2.5 and OpenVPN 2.6.0.
+
+
 Common errors with OpenSSL 3.0 and OpenVPN 2.6
 ----------------------------------------------
 Both OpenVPN 2.6 and OpenSSL 3.0 tighten the security considerable, so some
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 248f65cfd..76c323413 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -25,6 +25,9 @@ configured in a compatible way between both the local and remote side.
       compression at the same time is not a feasible option.
 
   :code:`no`  (default)
+      OpenVPN will refuse any compression or compression framing (stub).
+
+  :code:`stub-only`
       OpenVPN will refuse any non-stub compression.
 
   :code:`yes`
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 3b8d78996..c7ec6c7f5 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -134,27 +134,29 @@ comp_print_stats(const struct compress_context *compctx, struct status_output *s
 void
 comp_generate_peer_info_string(const struct compress_options *opt, struct buffer *out)
 {
-    if (opt)
+    if (!opt || opt->flags & COMP_F_ALLOW_NOCOMP_ONLY)
+    {
+        return;
+    }
+
+    bool lzo_avail = false;
+    if (!(opt->flags & COMP_F_ADVERTISE_STUBS_ONLY))
     {
-        bool lzo_avail = false;
-        if (!(opt->flags & COMP_F_ADVERTISE_STUBS_ONLY))
-        {
 #if defined(ENABLE_LZ4)
-            buf_printf(out, "IV_LZ4=1\n");
-            buf_printf(out, "IV_LZ4v2=1\n");
+        buf_printf(out, "IV_LZ4=1\n");
+        buf_printf(out, "IV_LZ4v2=1\n");
 #endif
 #if defined(ENABLE_LZO)
-            buf_printf(out, "IV_LZO=1\n");
-            lzo_avail = true;
+        buf_printf(out, "IV_LZO=1\n");
+        lzo_avail = true;
 #endif
-        }
-        if (!lzo_avail)
-        {
-            buf_printf(out, "IV_LZO_STUB=1\n");
-        }
-        buf_printf(out, "IV_COMP_STUB=1\n");
-        buf_printf(out, "IV_COMP_STUBv2=1\n");
     }
+    if (!lzo_avail)
+    {
+        buf_printf(out, "IV_LZO_STUB=1\n");
+    }
+    buf_printf(out, "IV_COMP_STUB=1\n");
+    buf_printf(out, "IV_COMP_STUBv2=1\n");
 }
 
 #endif /* USE_COMP */
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 685f40391..49b715b10 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -28,6 +28,29 @@
 #ifndef OPENVPN_COMP_H
 #define OPENVPN_COMP_H
 
+/* Compression flags */
+#define COMP_F_ADAPTIVE             (1<<0) /* COMP_ALG_LZO only */
+#define COMP_F_ALLOW_COMPRESS       (1<<1) /* not only downlink is compressed but also uplink */
+#define COMP_F_SWAP                 (1<<2) /* initial command byte is swapped with last byte in buffer to preserve payload alignment */
+#define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only support compression stubs */
+#define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
+                                            * we still accept other compressions to be pushed */
+#define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
+#define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly set to allow asymetric compression */
+#define COMP_F_ALLOW_NOCOMP_ONLY    (1<<7) /* Do not allow compression framing like stub v2 or comp-lzo no. Breaks DCO */
+#define COMP_F_INVALID_SETTING      (1<<8) /* The server pushed an invalid setting that cannot work */
+
+/*
+ * Information that basically identifies a compression
+ * algorithm and related flags. Also used without compression to bail
+ * out if we
+ */
+struct compress_options
+{
+    int alg;
+    unsigned int flags;
+};
+
 #ifdef USE_COMP
 
 #include "buffer.h"
@@ -51,17 +74,6 @@
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
-
-
 /*
  * Length of prepended prefix on compressed packets
  */
@@ -130,16 +142,6 @@ struct compress_alg
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
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 308578b47..c514bb143 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -408,9 +408,7 @@ dco_check_option(int msglevel, const struct options *o)
     }
 
 #if defined(USE_COMP)
-    if (o->comp.alg != COMP_ALG_UNDEF
-        || o->comp.flags & COMP_F_ALLOW_ASYM
-        || o->comp.flags & COMP_F_ALLOW_COMPRESS)
+    if (o->comp.alg != COMP_ALG_UNDEF || !(o->comp.flags & COMP_F_ALLOW_NOCOMP_ONLY))
     {
         msg(msglevel, "Note: '--allow-compression' is not set to 'no', disabling data channel offload.");
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3a6f624fd..2108efa90 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2634,14 +2634,22 @@ do_deferred_options(struct context *c, const unsigned int found)
         }
     }
 
-#ifdef USE_COMP
     if (found & OPT_P_COMP)
     {
+        if (c->options.comp.flags & COMP_F_INVALID_SETTING)
+        {
+            msg(D_PUSH_ERRORS, "OPTIONS ERROR: server pushed compression "
+                "settings that are not allowed and will result "
+                "in a non-working connection. "
+                "See also allow-compression in the manual.");
+            return false;
+        }
+#ifdef USE_COMP
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: compression parms modified");
         comp_uninit(c->c2.comp_context);
         c->c2.comp_context = comp_init(&c->options.comp);
-    }
 #endif
+    }
 
     if (found & OPT_P_SHAPER)
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 64a8250b2..b4cbdb8d6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3644,11 +3644,21 @@ options_set_backwards_compatible_options(struct options *o)
      *
      * Disable compression by default starting with 2.6.0 if no other
      * compression related option has been explicitly set */
-    if (!comp_non_stub_enabled(&o->comp) && !need_compatibility_before(o, 20600)
-        && (o->comp.flags == 0))
+    if (!need_compatibility_before(o, 20600) && (o->comp.flags == 0))
     {
-        o->comp.flags = COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_ONLY;
+        if (o->comp.alg == COMP_ALG_UNDEF)
+        {
+            o->comp.flags = COMP_F_ALLOW_NOCOMP_ONLY;
+        }
+        else if (!comp_non_stub_enabled(&o->comp))
+        {
+            o->comp.flags = COMP_F_ALLOW_STUB_ONLY | COMP_F_ADVERTISE_STUBS_ONLY;
+        }
     }
+#else  /* ifdef USE_COMP */
+    /* If no compression is compiled in, we do not support compression in
+     * any way */
+    o->comp.flags = COMP_F_ALLOW_NOCOMP_ONLY;
 #endif
 }
 
@@ -8355,15 +8365,23 @@ add_option(struct options *options,
         options->passtos = true;
     }
 #endif
-#if defined(USE_COMP)
+#ifdef USE_COMP
     else if (streq(p[0], "allow-compression") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
         if (streq(p[1], "no"))
         {
-            options->comp.flags =
-                COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_ONLY;
+            options->comp.flags = COMP_F_ALLOW_NOCOMP_ONLY;
+            if (comp_non_stub_enabled(&options->comp))
+            {
+                msg(msglevel, "'--allow-compression no' conflicts with "
+                    " enabling compression");
+            }
+        }
+        else if (streq(p[1], "stub-only"))
+        {
+            options->comp.flags = COMP_F_ADVERTISE_STUBS_ONLY|COMP_F_ALLOW_STUB_ONLY;
             if (comp_non_stub_enabled(&options->comp))
             {
                 msg(msglevel, "'--allow-compression no' conflicts with "
@@ -8374,7 +8392,7 @@ add_option(struct options *options,
         {
             /* Also printed on a push to hint at configuration problems */
             msg(msglevel, "Cannot set allow-compression to '%s' "
-                "after set to 'no'", p[1]);
+                "after set to 'stub-only'", p[1]);
             goto err;
         }
         else if (streq(p[1], "asym"))
@@ -8395,18 +8413,29 @@ add_option(struct options *options,
         else
         {
             msg(msglevel, "bad allow-compression option: %s -- "
-                "must be 'yes', 'no', or 'asym'", p[1]);
+                "must be 'yes', 'no', 'stub-only', or 'asym'", p[1]);
             goto err;
         }
     }
+#endif /* ifdef USE_COMP */
     else if (streq(p[0], "comp-lzo") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_COMP);
 
         /* All lzo variants do not use swap */
         options->comp.flags &= ~COMP_F_SWAP;
+
+        if (options->comp.flags & COMP_F_ALLOW_NOCOMP_ONLY)
+        {
+            /* Also printed on a push to hint at configuration problems */
+            msg(msglevel, "Cannot set comp-lzo to '%s', "
+                "allow-compression is set to 'no'", p[1]);
+            options->comp.flags |= COMP_F_INVALID_SETTING;
+            goto err;
+        }
+#if defined(USE_COMP)
 #if defined(ENABLE_LZO)
-        if (p[1] && streq(p[1], "no"))
+        else if (p[1] && streq(p[1], "no"))
 #endif
         {
             options->comp.alg = COMP_ALG_STUB;
@@ -8417,7 +8446,8 @@ add_option(struct options *options,
         {
             /* Also printed on a push to hint at configuration problems */
             msg(msglevel, "Cannot set comp-lzo to '%s', "
-                "allow-compression is set to 'no'", p[1]);
+                "allow-compression is set to 'stub-only'", p[1]);
+            options->comp.flags |= COMP_F_INVALID_SETTING;
             goto err;
         }
         else if (p[1])
@@ -8445,6 +8475,7 @@ add_option(struct options *options,
         }
         show_compression_warning(&options->comp);
 #endif /* if defined(ENABLE_LZO) */
+#endif /* if defined(USE_COMP) */
     }
     else if (streq(p[0], "comp-noadapt") && !p[1])
     {
@@ -8458,63 +8489,74 @@ add_option(struct options *options,
     else if (streq(p[0], "compress") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_COMP);
+        const char *alg = "stub";
         if (p[1])
         {
-            if (streq(p[1], "stub"))
-            {
-                options->comp.alg = COMP_ALG_STUB;
-                options->comp.flags |= (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
-            }
-            else if (streq(p[1], "stub-v2"))
-            {
-                options->comp.alg = COMP_ALGV2_UNCOMPRESSED;
-                options->comp.flags |= COMP_F_ADVERTISE_STUBS_ONLY;
-            }
-            else if (streq(p[1], "migrate"))
-            {
-                options->comp.alg = COMP_ALG_UNDEF;
-                options->comp.flags = COMP_F_MIGRATE;
-
-            }
-            else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
+            alg = p[1];
+        }
+        if (options->comp.flags & COMP_F_ALLOW_NOCOMP_ONLY)
+        {
+            /* Also printed on a push to hint at configuration problems */
+            msg(msglevel, "Cannot set compress to '%s', "
+                "allow-compression is set to 'no'", p[1]);
+            if (!streq(alg, "stub-v2"))
             {
-                /* Also printed on a push to hint at configuration problems */
-                msg(msglevel, "Cannot set compress to '%s', "
-                    "allow-compression is set to 'no'", p[1]);
-                goto err;
+                /* We allow stub-v2 to ignored on push as it often blindly
+                 * pushed to disable compression on the client side */
+                options->comp.flags |= COMP_F_INVALID_SETTING;
             }
+            goto err;
+        }
+#if defined(USE_COMP)
+        else if (streq(p[1], "stub"))
+        {
+            options->comp.alg = COMP_ALG_STUB;
+            options->comp.flags |= (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
+        }
+        else if (streq(p[1], "stub-v2"))
+        {
+            options->comp.alg = COMP_ALGV2_UNCOMPRESSED;
+            options->comp.flags |= COMP_F_ADVERTISE_STUBS_ONLY;
+        }
+        else if (streq(p[1], "migrate"))
+        {
+            options->comp.alg = COMP_ALG_UNDEF;
+            options->comp.flags = COMP_F_MIGRATE;
+        }
+        else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
+        {
+            /* Also printed on a push to hint at configuration problems */
+            msg(msglevel, "Cannot set compress to '%s', "
+                "allow-compression is set to 'stub-only'", p[1]);
+            options->comp.flags |= COMP_F_INVALID_SETTING;
+            goto err;
+        }
 #if defined(ENABLE_LZO)
-            else if (streq(p[1], "lzo"))
-            {
-                options->comp.alg = COMP_ALG_LZO;
-                options->comp.flags &= ~(COMP_F_ADAPTIVE | COMP_F_SWAP);
-            }
+        else if (streq(p[1], "lzo"))
+        {
+            options->comp.alg = COMP_ALG_LZO;
+            options->comp.flags &= ~(COMP_F_ADAPTIVE | COMP_F_SWAP);
+        }
 #endif
 #if defined(ENABLE_LZ4)
-            else if (streq(p[1], "lz4"))
-            {
-                options->comp.alg = COMP_ALG_LZ4;
-                options->comp.flags |= COMP_F_SWAP;
-            }
-            else if (streq(p[1], "lz4-v2"))
-            {
-                options->comp.alg = COMP_ALGV2_LZ4;
-            }
-#endif
-            else
-            {
-                msg(msglevel, "bad comp option: %s", p[1]);
-                goto err;
-            }
+        else if (streq(p[1], "lz4"))
+        {
+            options->comp.alg = COMP_ALG_LZ4;
+            options->comp.flags |= COMP_F_SWAP;
         }
+        else if (streq(p[1], "lz4-v2"))
+        {
+            options->comp.alg = COMP_ALGV2_LZ4;
+        }
+#endif
         else
         {
-            options->comp.alg = COMP_ALG_STUB;
-            options->comp.flags |= COMP_F_SWAP;
+            msg(msglevel, "bad comp option: %s", p[1]);
+            goto err;
         }
         show_compression_warning(&options->comp);
+#endif /* if defined(USE_COMP) */
     }
-#endif /* USE_COMP */
     else if (streq(p[0], "show-ciphers") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2f25f5d07..c56ef5e5e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -395,9 +395,7 @@ struct options
     /* optimize TUN/TAP/UDP writes */
     bool fast_io;
 
-#ifdef USE_COMP
     struct compress_options comp;
-#endif
 
     /* buffer sizes */
     int rcvbuf;
-- 
2.37.1 (Apple Git-137.1)


