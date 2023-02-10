From: Arne Schwabe <arne@...1227...>
Date: Fri, 10 Feb 2023 15:27:05 +0100
Message-Id: <20230210142712.572303-2-arne@...1227...>
In-Reply-To: <20230210142712.572303-1-arne@...1227...>
References: <20230210142712.572303-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Add 'allow-compression stub-only and
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                           |  5 +++
 doc/man-sections/protocol-options.rst |  3 ++
 src/openvpn/comp.c                    | 32 +++++++++--------
 src/openvpn/comp.h                    |  2 +-
 src/openvpn/dco.c                     |  4 +--
 src/openvpn/options.c                 | 50 +++++++++++++++++++++------
 6 files changed, 66 insertions(+), 30 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index c5335ce93..3a573cc9a 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -223,6 +223,11 @@ User-visible Changes
   compatibility with older versions. See the manual page on the
   ``--compat-mode`` for details.
 
+- (OpenVPN 2.6.1) ``--allow-compression no`` has been changed to not allow
+  compression or compression framing at all now and is the new default.
+  Use ``--allow-compression stub-only`` for the old ``no`` behaviour of OpenVPN
+  2.5 and OpenVPN 2.6.0.
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
index 685f40391..027fa0593 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -60,7 +60,7 @@
                                             * we still accept other compressions to be pushed */
 #define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
 #define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly set to allow asymetric compression */
-
+#define COMP_F_ALLOW_NOCOMP_ONLY    (1<<7) /* Do not allow compression framing like stub v2 or comp-lzo no. Breaks DCO */
 
 /*
  * Length of prepended prefix on compressed packets
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 3087a0df8..10337b964 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -410,9 +410,7 @@ dco_check_option(int msglevel, const struct options *o)
     }
 
 #if defined(USE_COMP)
-    if (o->comp.alg != COMP_ALG_UNDEF
-        || o->comp.flags & COMP_F_ALLOW_ASYM
-        || o->comp.flags & COMP_F_ALLOW_COMPRESS)
+    if (o->comp.alg != COMP_ALG_UNDEF || !(o->comp.flags & COMP_F_ALLOW_NOCOMP_ONLY))
     {
         msg(msglevel, "Note: '--allow-compression' is not set to 'no', disabling data channel offload.");
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ab1b01cf7..6550dc52c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3628,10 +3628,16 @@ options_set_backwards_compatible_options(struct options *o)
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
 #endif
 }
@@ -8330,8 +8336,16 @@ add_option(struct options *options,
 
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
@@ -8342,7 +8356,7 @@ add_option(struct options *options,
         {
             /* Also printed on a push to hint at configuration problems */
             msg(msglevel, "Cannot set allow-compression to '%s' "
-                "after set to 'no'", p[1]);
+                "after set to 'stub-only'", p[1]);
             goto err;
         }
         else if (streq(p[1], "asym"))
@@ -8373,8 +8387,16 @@ add_option(struct options *options,
 
         /* All lzo variants do not use swap */
         options->comp.flags &= ~COMP_F_SWAP;
+
+        if (options->comp.flags & COMP_F_ALLOW_NOCOMP_ONLY)
+        {
+            /* Also printed on a push to hint at configuration problems */
+            msg(msglevel, "Cannot set comp-lzo to '%s', "
+                "allow-compression is set to 'no'", p[1]);
+            goto err;
+        }
 #if defined(ENABLE_LZO)
-        if (p[1] && streq(p[1], "no"))
+        else if (p[1] && streq(p[1], "no"))
 #endif
         {
             options->comp.alg = COMP_ALG_STUB;
@@ -8385,7 +8407,7 @@ add_option(struct options *options,
         {
             /* Also printed on a push to hint at configuration problems */
             msg(msglevel, "Cannot set comp-lzo to '%s', "
-                "allow-compression is set to 'no'", p[1]);
+                "allow-compression is set to 'stub-only'", p[1]);
             goto err;
         }
         else if (p[1])
@@ -8428,7 +8450,14 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_COMP);
         if (p[1])
         {
-            if (streq(p[1], "stub"))
+            if (options->comp.flags & COMP_F_ALLOW_NOCOMP_ONLY)
+            {
+                /* Also printed on a push to hint at configuration problems */
+                msg(msglevel, "Cannot set compress to '%s', "
+                    "allow-compression is set to 'no'", p[1]);
+                goto err;
+            }
+            else if (streq(p[1], "stub"))
             {
                 options->comp.alg = COMP_ALG_STUB;
                 options->comp.flags |= (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
@@ -8442,13 +8471,12 @@ add_option(struct options *options,
             {
                 options->comp.alg = COMP_ALG_UNDEF;
                 options->comp.flags = COMP_F_MIGRATE;
-
             }
             else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
             {
                 /* Also printed on a push to hint at configuration problems */
                 msg(msglevel, "Cannot set compress to '%s', "
-                    "allow-compression is set to 'no'", p[1]);
+                    "allow-compression is set to 'stub-only'", p[1]);
                 goto err;
             }
 #if defined(ENABLE_LZO)
-- 
2.37.1 (Apple Git-137.1)


