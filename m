From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 27 Dec 2024 13:46:32 +0100
Message-Id: <20241227124632.110920-1-frank@...2641...>
In-Reply-To: <gerrit.1733833084000.Ia1c5209022d3ab4c0dac6438c41891c7d059f812@...2715...>
References: <gerrit.1733833084000.Ia1c5209022d3ab4c0dac6438c41891c7d059f812@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Allow DEFAULT in data-ciphers and report
 both expanded and user set option
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

From: Arne Schwabe <arne@...1227...>

This adds support for parsing DEFAULT in data-ciphers, the idea is that people
can modify the default without repeating the default ciphers.

In the past we have seem that people will use data-ciphers BF-CBC or
data-ciphers AES-128-CBC when getting the warning that the cipher is not
supported by the server.  This commit aims to provide a better way for
these situation as we still want people to rely on default cipher selection
from OpenVPN when possible.

Change-Id: Ia1c5209022d3ab4c0dac6438c41891c7d059f812
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/828
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/Changes.rst b/Changes.rst
index 34542a5..16ae6fc 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -30,6 +30,12 @@
 
     https://datatracker.ietf.org/doc/draft-irtf-cfrg-aead-limits/
 
+Default ciphers in ``--data-ciphers``
+    Ciphers in ``--data-ciphers`` can contain the string DEFAULT that is
+    replaced by the default ciphers used by OpenVPN, making it easier to
+    add an allowed cipher without having to spell out the default ciphers.
+
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 05f87cc..d04ace8 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -178,6 +178,12 @@
   Chacha20-Poly1305 if the underlying SSL library (and its configuration)
   supports it.
 
+  Starting with OpenVPN 2.7 the special keyword :code:`DEFAULT` can be used
+  in the string and is replaced by the default ciphers.  This can be used to
+  add an additional allowed cipher to the allowed ciphers, e.g.
+  :code:`DEFAULT:AES-192-CBC` to use the default ciphers but also allow
+  :code:`AES-192-CBC`.
+
   Cipher negotiation is enabled in client-server mode only. I.e. if
   ``--mode`` is set to `server` (server-side, implied by setting
   ``--server`` ), or if ``--pull`` is specified (client-side, implied by
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 45b3cfa..279be57 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1896,14 +1896,15 @@
     if (strlen(peer_ciphers) > 0)
     {
         msg(M_INFO, "PUSH: No common cipher between server and client. "
-            "Server data-ciphers: '%s', client supported ciphers '%s'",
-            o->ncp_ciphers, peer_ciphers);
+            "Server data-ciphers: '%s'%s, client supported ciphers '%s'",
+            o->ncp_ciphers_conf, ncp_expanded_ciphers(o, &gc), peer_ciphers);
     }
     else if (tls_multi->remote_ciphername)
     {
         msg(M_INFO, "PUSH: No common cipher between server and client. "
-            "Server data-ciphers: '%s', client supports cipher '%s'",
-            o->ncp_ciphers, tls_multi->remote_ciphername);
+            "Server data-ciphers: '%s'%s, client supports cipher '%s'",
+            o->ncp_ciphers_conf, ncp_expanded_ciphers(o, &gc),
+            tls_multi->remote_ciphername);
     }
     else
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b2a3a8b..d1714fd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3486,40 +3486,6 @@
     }
 }
 
-
-/**
- * Checks for availibility of Chacha20-Poly1305 and sets
- * the ncp_cipher to either AES-256-GCM:AES-128-GCM or
- * AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305.
- */
-static void
-options_postprocess_setdefault_ncpciphers(struct options *o)
-{
-    if (o->ncp_ciphers)
-    {
-        /* custom --data-ciphers set, keep list */
-        return;
-    }
-
-    /* check if crypto library supports chacha */
-    bool can_do_chacha = cipher_valid("CHACHA20-POLY1305");
-
-    if (can_do_chacha && dco_enabled(o))
-    {
-        /* also make sure that dco supports chacha */
-        can_do_chacha = tls_item_in_cipher_list("CHACHA20-POLY1305", dco_get_supported_ciphers());
-    }
-
-    if (can_do_chacha)
-    {
-        o->ncp_ciphers = "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
-    }
-    else
-    {
-        o->ncp_ciphers = "AES-256-GCM:AES-128-GCM";
-    }
-}
-
 static void
 options_postprocess_cipher(struct options *o)
 {
@@ -3550,7 +3516,8 @@
             "defaulted to BF-CBC as fallback when cipher negotiation "
             "failed in this case. If you need this fallback please add "
             "'--data-ciphers-fallback BF-CBC' to your configuration "
-            "and/or add BF-CBC to --data-ciphers.");
+            "and/or add BF-CBC to --data-ciphers. E.g. "
+            "--data-ciphers %s:BF-CBC", o->ncp_ciphers_conf);
     }
     else if (!o->enable_ncp_fallback
              && !tls_item_in_cipher_list(o->ciphername, o->ncp_ciphers))
@@ -3558,7 +3525,7 @@
         msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing in "
             "--data-ciphers (%s). OpenVPN ignores --cipher for cipher "
             "negotiations. ",
-            o->ciphername, o->ncp_ciphers);
+            o->ciphername, o->ncp_ciphers_conf);
     }
 }
 
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 6ab92e2..55f12dd 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -559,6 +559,8 @@
     const char *ciphername;
     bool enable_ncp_fallback;      /**< If defined fall back to
                                    * ciphername if NCP fails */
+    /** The original ncp_ciphers specified by the user in the configuration*/
+    const char *ncp_ciphers_conf;
     const char *ncp_ciphers;
     const char *authname;
     const char *engine;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 968858e..e403ae6 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -39,6 +39,8 @@
 #include "config.h"
 #endif
 
+#include <string.h>
+
 #include "syshead.h"
 #include "win32.h"
 
@@ -222,7 +224,6 @@
 
     return token != NULL;
 }
-
 const char *
 tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc)
 {
@@ -334,15 +335,16 @@
         return true;
     }
 
-    /* We failed negotiation, give appropiate error message */
+    /* We failed negotiation, give appropriate error message */
     if (c->c2.tls_multi->remote_ciphername)
     {
         msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to negotiate "
             "cipher with server.  Add the server's "
-            "cipher ('%s') to --data-ciphers (currently '%s') if "
-            "you want to connect to this server.",
+            "cipher ('%s') to --data-ciphers (currently '%s'), e.g."
+            "--data-ciphers %s:%s if you want to connect to this server.",
             c->c2.tls_multi->remote_ciphername,
-            c->options.ncp_ciphers);
+            c->options.ncp_ciphers_conf, c->options.ncp_ciphers_conf,
+            c->c2.tls_multi->remote_ciphername);
         return false;
 
     }
@@ -516,10 +518,13 @@
     if (!session->opt->server && !cipher_allowed_as_fallback
         && !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
     {
-        msg(D_TLS_ERRORS, "Error: negotiated cipher not allowed - %s not in %s",
-            options->ciphername, options->ncp_ciphers);
+        struct gc_arena gc = gc_new();
+        msg(D_TLS_ERRORS, "Error: negotiated cipher not allowed - %s not in %s%s",
+            options->ciphername, options->ncp_ciphers_conf,
+            ncp_expanded_ciphers(options, &gc));
         /* undo cipher push, abort connection setup */
         options->ciphername = session->opt->config_ciphername;
+        gc_free(&gc);
         return false;
     }
     else
@@ -527,3 +532,100 @@
         return true;
     }
 }
+
+/**
+ * Replaces the string DEFAULT with the string \c replace.
+ *
+ * @param o         Options struct to modify and to use the gc from
+ * @param replace   string used to replace the DEFAULT string
+ */
+static void
+replace_default_in_ncp_ciphers_option(struct options *o, const char *replace)
+{
+    const char *search = "DEFAULT";
+    const int ncp_ciphers_len = strlen(o->ncp_ciphers) + strlen(replace) - strlen(search) + 1;
+
+    uint8_t *ncp_ciphers = gc_malloc(ncp_ciphers_len, true, &o->gc);
+
+    struct buffer ncp_ciphers_buf;
+    buf_set_write(&ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);
+
+    const char *def = strstr(o->ncp_ciphers, search);
+
+    /* Copy everything before the DEFAULT string */
+    buf_write(&ncp_ciphers_buf, o->ncp_ciphers, def - o->ncp_ciphers);
+
+    /* copy the default string. */
+    buf_write(&ncp_ciphers_buf, replace, strlen(replace));
+
+    /* copy the rest of the ncp cipher string */
+    const char *after_default = def + strlen(search);
+    buf_write(&ncp_ciphers_buf, after_default, strlen(after_default));
+
+    o->ncp_ciphers = (char *) ncp_ciphers;
+}
+
+/**
+ * Checks for availibility of Chacha20-Poly1305 and sets
+ * the ncp_cipher to either AES-256-GCM:AES-128-GCM or
+ * AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305.
+ */
+void
+options_postprocess_setdefault_ncpciphers(struct options *o)
+{
+    bool default_in_cipher_list = o->ncp_ciphers
+                                  && tls_item_in_cipher_list("DEFAULT", o->ncp_ciphers);
+
+    /* preserve the values that the user put into the configuration */
+    o->ncp_ciphers_conf = o->ncp_ciphers;
+
+    /* check if crypto library supports chacha */
+    bool can_do_chacha = cipher_valid("CHACHA20-POLY1305");
+
+    if (can_do_chacha && dco_enabled(o))
+    {
+        /* also make sure that dco supports chacha */
+        can_do_chacha = tls_item_in_cipher_list("CHACHA20-POLY1305", dco_get_supported_ciphers());
+    }
+
+    const char *default_ciphers = "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+
+    if (!can_do_chacha)
+    {
+        default_ciphers = "AES-256-GCM:AES-128-GCM";
+    }
+
+    /* want to rather print DEFAULT instead of a manually set default list */
+    if (!o->ncp_ciphers_conf || !strcmp(default_ciphers, o->ncp_ciphers_conf))
+    {
+        o->ncp_ciphers = default_ciphers;
+        o->ncp_ciphers_conf = "DEFAULT";
+    }
+    else if (!default_in_cipher_list)
+    {
+        /* custom cipher list without DEFAULT string in it,
+         * nothing to replace/mutate */
+        return;
+    }
+    else
+    {
+        replace_default_in_ncp_ciphers_option(o, default_ciphers);
+    }
+}
+
+const char *
+ncp_expanded_ciphers(struct options *o, struct gc_arena *gc)
+{
+    if (!strcmp(o->ncp_ciphers, o->ncp_ciphers_conf))
+    {
+        /* expanded ciphers and user set ciphers are identical, no need to
+         * add an expanded version */
+        return "";
+    }
+
+    /* two extra brackets, one space, NUL byte */
+    struct buffer expanded_ciphers_buf = alloc_buf_gc(strlen(o->ncp_ciphers) + 4, gc);
+
+    buf_printf(&expanded_ciphers_buf, " (%s)", o->ncp_ciphers);
+    return BSTR(&expanded_ciphers_buf);
+}
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index afbe331..f90b19a 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -156,4 +156,23 @@
 bool
 check_session_cipher(struct tls_session *session, struct options *options);
 
+/**
+ * Checks for availability of Chacha20-Poly1305 and sets
+ * the ncp_cipher to either AES-256-GCM:AES-128-GCM or
+ * AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305 if not set.
+ *
+ * If DEFAULT is in the ncp_cipher string, it will be replaced
+ * by the default cipher string as defined above.
+ */
+void
+options_postprocess_setdefault_ncpciphers(struct options *o);
+
+/** returns the o->ncp_ciphers in brackets, e.g.
+ *  (AES-256-GCM:CHACHA20-POLY1305) if o->ncp_ciphers_conf
+ *  and o->ncp_ciphers differ, otherwise an empty string
+ *
+ *  The returned string will be allocated in the passed \c gc
+ */
+const char *
+ncp_expanded_ciphers(struct options *o, struct gc_arena *gc);
 #endif /* ifndef OPENVPN_SSL_NCP_H */
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index a8e1021..b744e96 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -54,6 +54,17 @@
     ASSERT(0);
 }
 
+
+/* Define a dummy dco cipher option to avoid linking against all the DCO
+ * units */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_supported_ciphers(void)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
+
 static void
 test_check_ncp_ciphers_list(void **state)
 {
@@ -260,13 +271,135 @@
     gc_free(&gc);
 }
 
+static void
+test_ncp_default(void **state)
+{
+    bool have_chacha = cipher_valid("CHACHA20-POLY1305");
+
+    struct options o = { 0 };
+
+    o.gc = gc_new();
+
+    /* no user specified string */
+    o.ncp_ciphers = NULL;
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    if (have_chacha)
+    {
+        assert_string_equal(o.ncp_ciphers, "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305");
+    }
+    else
+    {
+        assert_string_equal(o.ncp_ciphers, "AES-256-GCM:AES-128-GCM");
+    }
+    assert_string_equal(o.ncp_ciphers_conf, "DEFAULT");
+
+    /* check that a default string is replaced with DEFAULT */
+    if (have_chacha)
+    {
+        o.ncp_ciphers = "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+    }
+    else
+    {
+        o.ncp_ciphers = "AES-256-GCM:AES-128-GCM";
+    }
+
+    options_postprocess_setdefault_ncpciphers(&o);
+    assert_string_equal(o.ncp_ciphers_conf, "DEFAULT");
+
+    /* test default in the middle of the string */
+    o.ncp_ciphers = "BF-CBC:DEFAULT:AES-128-CBC:AES-256-CBC";
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    if (have_chacha)
+    {
+        assert_string_equal(o.ncp_ciphers, "BF-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305:AES-128-CBC:AES-256-CBC");
+    }
+    else
+    {
+        assert_string_equal(o.ncp_ciphers, "BF-CBC:AES-256-GCM:AES-128-GCM:AES-128-CBC:AES-256-CBC");
+    }
+    assert_string_equal(o.ncp_ciphers_conf, "BF-CBC:DEFAULT:AES-128-CBC:AES-256-CBC");
+
+    /* string at the beginning */
+    o.ncp_ciphers = "DEFAULT:AES-128-CBC:AES-192-CBC";
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    if (have_chacha)
+    {
+        assert_string_equal(o.ncp_ciphers, "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305:AES-128-CBC:AES-192-CBC");
+    }
+    else
+    {
+        assert_string_equal(o.ncp_ciphers, "AES-256-GCM:AES-128-GCM:AES-128-CBC:AES-192-CBC");
+    }
+    assert_string_equal(o.ncp_ciphers_conf, "DEFAULT:AES-128-CBC:AES-192-CBC");
+
+    /* DEFAULT at the end */
+    o.ncp_ciphers = "AES-192-GCM:AES-128-CBC:DEFAULT";
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    if (have_chacha)
+    {
+        assert_string_equal(o.ncp_ciphers, "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305");
+    }
+    else
+    {
+        assert_string_equal(o.ncp_ciphers, "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM");
+    }
+    assert_string_equal(o.ncp_ciphers_conf, "AES-192-GCM:AES-128-CBC:DEFAULT");
+
+    gc_free(&o.gc);
+}
+
+static void
+test_ncp_expand(void **state)
+{
+    bool have_chacha = cipher_valid("CHACHA20-POLY1305");
+    struct options o = {0};
+
+    o.gc = gc_new();
+    struct gc_arena gc = gc_new();
+
+    /* no user specified string */
+    o.ncp_ciphers = NULL;
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    const char *expanded = ncp_expanded_ciphers(&o, &gc);
+
+    /* user specificed string with DEFAULT in it */
+    o.ncp_ciphers = "AES-192-GCM:DEFAULT";
+    options_postprocess_setdefault_ncpciphers(&o);
+    const char *expanded2 = ncp_expanded_ciphers(&o, &gc);
+
+    if (have_chacha)
+    {
+        assert_string_equal(expanded, " (AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305)");
+        assert_string_equal(expanded2, " (AES-192-GCM:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305)");
+    }
+    else
+    {
+        assert_string_equal(expanded, " (AES-256-GCM:AES-128-GCM)");
+        assert_string_equal(expanded2, " (AES-192-GCM:AES-256-GCM:AES-128-GCM)");
+    }
+
+    o.ncp_ciphers = "AES-192-GCM:BF-CBC";
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    assert_string_equal(ncp_expanded_ciphers(&o, &gc), "");
+
+    gc_free(&o.gc);
+    gc_free(&gc);
+}
 
 
 const struct CMUnitTest ncp_tests[] = {
     cmocka_unit_test(test_check_ncp_ciphers_list),
     cmocka_unit_test(test_extract_client_ciphers),
     cmocka_unit_test(test_poor_man),
-    cmocka_unit_test(test_ncp_best)
+    cmocka_unit_test(test_ncp_best),
+    cmocka_unit_test(test_ncp_default),
+    cmocka_unit_test(test_ncp_expand),
 };
 
 

