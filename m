From: Arne Schwabe <arne@...1227...>
Date: Thu, 23 Mar 2023 18:06:00 +0100
Message-Id: <20230323170601.1256132-3-arne@...1227...>
In-Reply-To: <20230323170601.1256132-1-arne@...1227...>
References: <20230323170601.1256132-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 3/4] Add 'allow-compression stub-only'
 internally for DCO
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

This changes the "no" setting of allow-compression to also refuse framing.
This is important for our DCO implementation as these do not implement framing.

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

Patch v3: always parse all compression option and move logic to check method

Change-Id: Ibd0c77af24e2214b3055d585dc23a4b06dccd414
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/protocol-options.rst |  4 ++-
 src/openvpn/comp.c                    | 47 ++++++++++++++++++---------
 src/openvpn/comp.h                    |  2 +-
 src/openvpn/options.c                 | 18 ++++++++--
 4 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 248f65cfd..055d08f95 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -25,7 +25,9 @@ configured in a compatible way between both the local and remote side.
       compression at the same time is not a feasible option.
 
   :code:`no`  (default)
-      OpenVPN will refuse any non-stub compression.
+      OpenVPN will refuse any compression.  If data-channel offloading
+      is enabled. OpenVPN will additionally also refuse compression
+      framing (stub).
 
   :code:`yes`
       OpenVPN will send and receive compressed packets.
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index d6d8029da..c7a562f5a 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -134,36 +134,51 @@ comp_print_stats(const struct compress_context *compctx, struct status_output *s
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
 
 bool
 check_compression_settings_valid(struct compress_options *info, int msglevel)
 {
+    /*
+     * We also allow comp-stub-v2 here as it technically allows escaping of
+     * weird mac address and IPv5 protocol but practically always is used
+     * as an way to disable all framing.
+     */
+    if (info->alg != COMP_ALGV2_UNCOMPRESSED && info->alg != COMP_ALG_UNDEF
+        && (info->flags & COMP_F_ALLOW_NOCOMP_ONLY))
+    {
+        msg(msglevel, "Compression or compression stub framing is not allowed "
+            "since data-channel offloading is enabled.");
+        return false;
+    }
+
     if ((info->flags & COMP_F_ALLOW_STUB_ONLY) && comp_non_stub_enabled(info))
     {
         msg(msglevel, "Compression is not allowed since allow-compression is "
-            "set to 'no'");
+            "set to 'stub-only'");
         return false;
     }
 #ifndef ENABLE_LZ4
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 8636727ab..71b350d09 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -60,7 +60,7 @@
                                             * we still accept other compressions to be pushed */
 #define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
 #define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly set to allow asymetric compression */
-
+#define COMP_F_ALLOW_NOCOMP_ONLY    (1<<7) /* Do not allow compression framing (breaks DCO) */
 
 /*
  * Length of prepended prefix on compressed packets
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 435e1ca9e..92f7456a4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3644,10 +3644,16 @@ options_set_backwards_compatible_options(struct options *o)
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
@@ -3749,6 +3755,12 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
         o->tuntap_options.disable_dco = !dco_check_option(D_DCO, o)
                                         || !dco_check_startup_option(D_DCO, o);
     }
+#ifdef USE_COMP
+    if (dco_enabled(o))
+    {
+        o->comp.flags |= COMP_F_ALLOW_NOCOMP_ONLY;
+    }
+#endif
 
 #ifdef _WIN32
     if (dco_enabled(o))
-- 
2.37.1 (Apple Git-137.1)


