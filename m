From: Arne Schwabe <arne@...1227...>
Date: Thu, 23 Mar 2023 18:05:59 +0100
Message-Id: <20230323170601.1256132-2-arne@...1227...>
In-Reply-To: <20230323170601.1256132-1-arne@...1227...>
References: <20230323170601.1256132-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 2/4] Refuse connection if server pushes
 an option contradicting allow-compress
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

This removes also the checks in options.c itself as they we now bail out
later and no longer need to ignore them during parsing.

Change-Id: I872c06f402c35112194ba77c3d6aee78e22547cb
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst           |  4 ++++
 src/openvpn/comp.c    | 29 +++++++++++++++++++++++++++++
 src/openvpn/comp.h    |  8 ++++++++
 src/openvpn/init.c    |  8 ++++++++
 src/openvpn/multi.c   |  8 ++++++++
 src/openvpn/options.c | 27 ++++-----------------------
 6 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index dedb97ee4..77bcef266 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -232,6 +232,10 @@ User-visible Changes
 - The ``client-pending-auth`` management command now requires also the
   key id. The management version has been changed to 5 to indicate this change.
 
+- (OpenVPN 2.6.2) A client will now refuse a connection if pushed compression
+  settings will contradict the setting of allow-compression as this almost
+  always results in a non-working connection.
+
 Common errors with OpenSSL 3.0 and OpenVPN 2.6
 ----------------------------------------------
 Both OpenVPN 2.6 and OpenSSL 3.0 tighten the security considerable, so some
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 3b8d78996..d6d8029da 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -157,4 +157,33 @@ comp_generate_peer_info_string(const struct compress_options *opt, struct buffer
     }
 }
 
+bool
+check_compression_settings_valid(struct compress_options *info, int msglevel)
+{
+    if ((info->flags & COMP_F_ALLOW_STUB_ONLY) && comp_non_stub_enabled(info))
+    {
+        msg(msglevel, "Compression is not allowed since allow-compression is "
+            "set to 'no'");
+        return false;
+    }
+#ifndef ENABLE_LZ4
+    if (info->alg == COMP_ALGV2_LZ4 || info->alg == COMP_ALG_LZ4)
+    {
+        msg(msglevel, "OpenVPN is compiled without LZ4 support. Requested "
+            "compression cannot be enabled.");
+        return false;
+    }
+#endif
+#ifndef ENABLE_LZO
+    if (info->alg == COMP_ALG_LZO || info->alg == COMP_ALG_LZ4)
+    {
+        msg(msglevel, "OpenVPN is compiled without LZO support. Requested "
+            "compression cannot be enabled.");
+        return false;
+    }
+#endif
+    return true;
+}
+
+
 #endif /* USE_COMP */
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 685f40391..8636727ab 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -196,5 +196,13 @@ comp_non_stub_enabled(const struct compress_options *info)
            && info->alg != COMP_ALG_UNDEF;
 }
 
+/**
+ * Checks if the compression settings are valid. Takes into account the
+ * flags of allow-compression and also the whether algorithms are compiled
+ * in
+ */
+bool
+check_compression_settings_valid(struct compress_options *info, int msglevel);
+
 #endif /* USE_COMP */
 #endif /* ifndef OPENVPN_COMP_H */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3a6f624fd..14859499d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2637,6 +2637,14 @@ do_deferred_options(struct context *c, const unsigned int found)
 #ifdef USE_COMP
     if (found & OPT_P_COMP)
     {
+        if (!check_compression_settings_valid(&c->options.comp, D_PUSH_ERRORS))
+        {
+            msg(D_PUSH_ERRORS, "OPTIONS ERROR: server pushed compression "
+                "settings that are not allowed and will result "
+                "in a non-working connection. "
+                "See also allow-compression in the manual.");
+            return false;
+        }
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: compression parms modified");
         comp_uninit(c->c2.comp_context);
         c->c2.comp_context = comp_init(&c->options.comp);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 1480bf477..ac090ef5a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2766,6 +2766,14 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         cc_succeeded = false;
     }
 
+#ifdef USE_COMP
+    if (!check_compression_settings_valid(&mi->context.options.comp, D_MULTI_ERRORS))
+    {
+        msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to invalid compression options");
+        cc_succeeded = false;
+    }
+#endif
+
     if (cc_succeeded)
     {
         multi_client_connect_late_setup(m, mi, *option_types_found);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2bed4ce99..435e1ca9e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3779,6 +3779,9 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
     /* this depends on o->windows_driver, which is set above */
     options_postprocess_mutate_invariant(o);
 
+    /* check that compression settings in the options are okay */
+    check_compression_settings_valid(&o->comp, M_USAGE);
+
     /*
      * Save certain parms before modifying options during connect, especially
      * when using --pull
@@ -8405,21 +8408,12 @@ add_option(struct options *options,
 
         /* All lzo variants do not use swap */
         options->comp.flags &= ~COMP_F_SWAP;
-#if defined(ENABLE_LZO)
+
         if (p[1] && streq(p[1], "no"))
-#endif
         {
             options->comp.alg = COMP_ALG_STUB;
             options->comp.flags &= ~COMP_F_ADAPTIVE;
         }
-#if defined(ENABLE_LZO)
-        else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
-        {
-            /* Also printed on a push to hint at configuration problems */
-            msg(msglevel, "Cannot set comp-lzo to '%s', "
-                "allow-compression is set to 'no'", p[1]);
-            goto err;
-        }
         else if (p[1])
         {
             if (streq(p[1], "yes"))
@@ -8444,7 +8438,6 @@ add_option(struct options *options,
             options->comp.flags |= COMP_F_ADAPTIVE;
         }
         show_compression_warning(&options->comp);
-#endif /* if defined(ENABLE_LZO) */
     }
     else if (streq(p[0], "comp-noadapt") && !p[1])
     {
@@ -8478,23 +8471,12 @@ add_option(struct options *options,
         {
             options->comp.alg = COMP_ALG_UNDEF;
             options->comp.flags = COMP_F_MIGRATE;
-
         }
-        else if (options->comp.flags & COMP_F_ALLOW_STUB_ONLY)
-        {
-            /* Also printed on a push to hint at configuration problems */
-            msg(msglevel, "Cannot set compress to '%s', "
-                "allow-compression is set to 'no'", alg);
-            goto err;
-        }
-#if defined(ENABLE_LZO)
         else if (streq(alg, "lzo"))
         {
             options->comp.alg = COMP_ALG_LZO;
             options->comp.flags &= ~(COMP_F_ADAPTIVE | COMP_F_SWAP);
         }
-#endif
-#if defined(ENABLE_LZ4)
         else if (streq(alg, "lz4"))
         {
             options->comp.alg = COMP_ALG_LZ4;
@@ -8504,7 +8486,6 @@ add_option(struct options *options,
         {
             options->comp.alg = COMP_ALGV2_LZ4;
         }
-#endif
         else
         {
             msg(msglevel, "bad comp option: %s", alg);
-- 
2.37.1 (Apple Git-137.1)


