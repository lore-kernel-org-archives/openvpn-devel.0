From: Arne Schwabe <arne@...1227...>
Date: Mon,  2 Aug 2021 13:55:21 +0200
Message-Id: <20210802115521.699150-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Modernise OpenVPN defaults and introduce
 '--compat-mode'
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

TLS 1.0 should be allowed anymore in a sensible default configuration. Bump
the default to TLS 1.2
Also modify --cipher not to be automatically appended and default
allow-compression to no. This also allows a default configuration to be
compatible with DCO.

Also introduce --compat-mode version to allow an easy way for UI/users
to maximise compatibility to earlier versions at the cost of DCO and
security.

--compat-mode is only intended as an easier way to set options that
are still present. It will not implement options that are removed
(e.g. --keysize), so it is meant a best effort option and not as
a mean to provide 100% compatibility.

Patch v2: rebase

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                          | 23 +++++++
 doc/man-sections/generic-options.rst | 21 ++++++
 src/openvpn/comp.h                   |  1 +
 src/openvpn/options.c                | 97 +++++++++++++++++++++++-----
 src/openvpn/options.h                | 17 +++++
 src/openvpn/ssl_ncp.c                | 13 ++++
 src/openvpn/ssl_ncp.h                |  8 +++
 7 files changed, 165 insertions(+), 15 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 0323a7f7a..cf3329486 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -45,6 +45,12 @@ Pending auth support for plugins and scripts
 
     See ``sample/sample-scripts/totpauth.py`` for an example.
 
+Compatibility mode (``--compat-mode``)
+    The modernisation of defaults can impact the compatibility of OpenVPN 2.6.0
+    with older peers. The options ``--compat-mode`` allows UIs to provide users
+    an easy way to still connect to older servers.
+
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
@@ -65,6 +71,23 @@ Deprecated features
     This option mainly served a role as debug option when NCP was first
     introduced. It should now no longer be necessary.
 
+TLS 1.0 and 1.1 are deprecated
+    ``tls-version-min`` is set to 1.2 by default.  OpenVPN 2.6.0 defaults
+    to a minimum TLS version of 1.2 as TLS 1.0 and 1.1 should be generally
+    avoided. Note that OpenVPN versions older than 2.3.7 use TLS 1.0 only.
+
+``--cipher`` options is no longer included in ``--data-ciphers`` by default
+    Data cipher negotiation has been introduced in 2.4.0 and been significantly
+    improved in 2.5.0. The implicit fallback to the cipher specified in
+    ``--cipher`` has been removed.
+
+Compression no longer enabled by default
+    Unless an explicit compression option is specified in the configuration,
+    ``--allow-compression`` defaults to ``no`` in OpeNVPN 2.6.0.
+    OpenVPN 2.5 still allowed by default a server to enable compression by
+    pushing compression related options.
+
+
 Overview of changes in 2.5
 ==========================
 
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 203e35f57..739e845ac 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -52,6 +52,27 @@ which mode OpenVPN is configured as.
   BSDs implement a getrandom() or getentropy() syscall that removes the
   need for /dev/urandom to be available.
 
+--compat-mode version
+  This option provides a way to alter the default of OpenVPN to be more
+  compatible with the version ``version`` specified. All of the changes
+  this option does can also be achieved using invdivdiual configuration
+  option.
+
+  Note: Using this options sets reverts defaults to no longer recommended
+  values and should be avoided if possible.
+
+  The following table details what defaults are changed depending on the
+  version specified.
+
+  - 2.5.x or lower: ``--allow-compression asym`` is automatically added
+    to the configuration if no other compression options are present.
+  - 2.4.x or lower: The cipher in ``--cipher`` is appended to
+    ``--data-ciphers``
+  - 2.3.x or lower: ``--data-cipher-fallback`` is automatically added with
+    the same cipher as ``--cipher``
+  - 2.3.6 or lower: ``--tls-version-min 1.0`` is added to the configuration
+    when ``--tls-version-min`` is not explicitly set.
+
 --config file
   Load additional config options from ``file`` where each line corresponds
   to one command line option, but with the leading '--' removed.
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index cd4f0e1a2..619a574e5 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -59,6 +59,7 @@
 #define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
                                             * we still accept other compressions to be pushed */
 #define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
+#define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly set to allow assymetric compression */
 
 
 /*
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 63cda1e86..cd6d464a3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -854,6 +854,7 @@ init_options(struct options *o, const bool init_gc)
     o->use_prediction_resistance = false;
 #endif
     o->tls_timeout = 2;
+    o->ssl_flags = (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIFT);
     o->renegotiate_bytes = -1;
     o->renegotiate_seconds = 3600;
     o->renegotiate_seconds_min = -1;
@@ -3079,8 +3080,12 @@ options_postprocess_verify(const struct options *o)
 static void
 options_postprocess_cipher(struct options *o)
 {
-    if (!o->pull && !(o->mode == MODE_SERVER))
+    if (!o->tls_server && !o->tls_client)
     {
+        /* we are in the classic P2P mode */
+        msg( M_WARN, "Cipher negotiation is disabled since TLS "
+             "mode is not enabled");
+
         /* If the cipher is not set, use the old default of BF-CBC. We will
          * warn that this is deprecated on cipher initialisation, no need
          * to warn here as well */
@@ -3101,26 +3106,68 @@ options_postprocess_cipher(struct options *o)
         /* We still need to set the ciphername to BF-CBC since various other
          * parts of OpenVPN assert that the ciphername is set */
         o->ciphername = "BF-CBC";
+
+        msg(M_WARN, "Note: --cipher is not set. Previous OpenVPN versions "
+                    "defaulted to BF-CBC as fallback when cipher negotiation "
+                    "failed in this case. If you need this fallback please add "
+                    "'--data-ciphers-fallback 'BF-CBC' to your configuration "
+                    "and/or add BF-CBC to --data-ciphers.");
     }
     else if (!o->enable_ncp_fallback
              && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
     {
-        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing in"
-            " --data-ciphers (%s). Future OpenVPN version will "
-            "ignore --cipher for cipher negotiations. "
-            "Add '%s' to --data-ciphers or change --cipher '%s' to "
-            "--data-ciphers-fallback '%s' to silence this warning.",
-            o->ciphername, o->ncp_ciphers, o->ciphername,
-            o->ciphername, o->ciphername);
-        o->enable_ncp_fallback = true;
+        msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing in "
+            "--data-ciphers (%s). OpenVPN ignores --cipher for cipher "
+            "negotiations. ",
+            o->ciphername, o->ncp_ciphers);
+    }
+}
+
+static void
+options_set_backwards_compatible_options(struct options *o)
+{
+    /* TLS min version is not set */
+    if ((o->ssl_flags & SSLF_TLS_VERSION_MIN_MASK) == 0)
+    {
+        if (!need_compatibility(o, 203070))
+        {
+            /* 2.3.6 and earlier have TLS 1.0 only, set minimum to TLS 1.0 */
+            o->ssl_flags = (TLS_VER_1_0 << SSLF_TLS_VERSION_MIN_SHIFT);
+        }
+        else
+        {
+            /* Use TLS 1.2 as proper default */
+            o->ssl_flags = (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIFT);
+        }
+    }
 
-        /* Append the --cipher to ncp_ciphers to allow it in NCP */
-        size_t newlen = strlen(o->ncp_ciphers) + 1 + strlen(o->ciphername) + 1;
-        char *ncp_ciphers = gc_malloc(newlen, false, &o->gc);
+    /* Versions < 2.5.0 do need --cipher in the list of accepted ciphers.
+     * Version 2.4 might probably does not need it but NCP was not so
+     * good with 2.4 and ncp-disable might be more common on 2.4 peers.
+     * Only do this iif --cipher is not explicitly (BF-CBC). This is not
+     * 100% correct backwards compatible behaviour but 2.5 already behaved like
+     * this */
+    if (o->ciphername && need_compatibility(o, 205000)
+        && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
+    {
+        append_cipher_to_ncp_list(o, o->ciphername);
+    }
+
+    /* Versions <= 2.3.0 additionally might be compiled with --enable-small and
+     * not have OCC strings required for "poor man's NCP" */
+    if (o->ciphername &&  need_compatibility(o, 204000))
+    {
+        o->enable_ncp_fallback = true;
+    }
 
-        ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers,
-                                o->ciphername));
-        o->ncp_ciphers = ncp_ciphers;
+    /* Compression is deprecated and we do not want to announce support for it
+     * by default anymore, additionally DCO breaks with with compression.
+     * Disable compression by default starting with 2.6.0 if no other
+     * compression related options have been explicitly set */
+    if (!comp_non_stub_enabled(&o->comp) && !need_compatibility(o, 206000)
+        && (o->comp.flags == 0))
+    {
+        o->comp.flags = COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_ONLY;
     }
 }
 
@@ -3136,6 +3183,8 @@ options_postprocess_mutate(struct options *o)
     helper_keepalive(o);
     helper_tcp_nodelay(o);
 
+    options_set_backwards_compatible_options(o);
+
     options_postprocess_cipher(o);
     options_postprocess_mutate_invariant(o);
 
@@ -3213,6 +3262,12 @@ options_postprocess_mutate(struct options *o)
      * when using --pull
      */
     pre_connect_save(o);
+
+    /* Give a general warning at the end of initialisation that defaults
+     * have changed */
+    msg(M_WARN, "Note that modernistation of defaults in OpenVPN 2.6 limits "
+                "compatibility with old versions. See Changes.rst and "
+                "--compat-mode in the manual for details.");
 }
 
 /*
@@ -6704,6 +6759,17 @@ add_option(struct options *options,
             setenv_str(es, p[1], p[2] ? p[2] : "");
         }
     }
+    else if (streq(p[0], "compat-mode") && p[1] && !p[3])
+    {
+        unsigned int major, minor, patch;
+        if (!(sscanf(p[1], "%u.%u.%u", &major, &minor, &patch) == 3))
+        {
+            msg(msglevel, "cannot parse version number for -compat-mode: %s", p[1]);
+            goto err;
+        }
+
+        options->backwards_compatible = major * 10000 + minor * 100 + patch;
+    }
     else if (streq(p[0], "setenv-safe") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_SETENV);
@@ -7701,6 +7767,7 @@ add_option(struct options *options,
         else if (streq(p[1], "asym"))
         {
             options->comp.flags &= ~COMP_F_ALLOW_COMPRESS;
+            options->comp.flags |= COMP_F_ALLOW_ASYM;
         }
         else if (streq(p[1], "yes"))
         {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b0e40cb7f..925083865 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -225,6 +225,10 @@ struct options
 
     /* enable forward compatibility for post-2.1 features */
     bool forward_compatible;
+    /** What version we should try to be compatible with as major * 10000 +
+      * minor * 100 + patch, e.g. 2.4.7 => 204070 */
+    unsigned int backwards_compatible;
+
     /* list of options that should be ignored even if unknown */
     const char **ignore_unknown_option;
 
@@ -660,6 +664,19 @@ struct options
     unsigned int data_channel_crypto_flags;
 };
 
+/**
+ * Returns if we want 'backwards-compatible' to a certain version
+ * @param version   the first version does that *NOT* need the compatibility
+ *                  e.g. 204000 for all versions <= 2.4.0
+ * @return          compatibility should be enabled.
+ */
+static inline bool
+need_compatibility(const struct options *o, int version)
+{
+    return o->backwards_compatible != 0 && o->backwards_compatible < version;
+}
+
+
 #define streq(x, y) (!strcmp((x), (y)))
 
 /*
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 6967e2bba..022a9dc3b 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -172,6 +172,19 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
     return ret;
 }
 
+
+void
+append_cipher_to_ncp_list(struct options *o, const char *ciphername)
+{
+    /* Append the --cipher to ncp_ciphers to allow it in NCP */
+    size_t newlen = strlen(o->ncp_ciphers) + 1 + strlen(ciphername) + 1;
+    char *ncp_ciphers = gc_malloc(newlen, false, &o->gc);
+
+    ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers,
+                            ciphername));
+    o->ncp_ciphers = ncp_ciphers;
+}
+
 bool
 tls_item_in_cipher_list(const char *item, const char *list)
 {
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 4a2601a2e..09ddeb28e 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -102,6 +102,14 @@ tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc);
 char *
 mutate_ncp_cipher_list(const char *list, struct gc_arena *gc);
 
+/**
+ * Appends the cipher specified by the ciphernamer parameter to to
+ * the o->ncp_ciphers list.
+ * @param o             options struct to modify. Its gc is also used
+ * @param ciphername    the ciphername to add
+ */
+void append_cipher_to_ncp_list(struct options *o, const char *ciphername);
+
 /**
  * Return true iff item is present in the colon-separated zero-terminated
  * cipher list.
-- 
2.32.0


