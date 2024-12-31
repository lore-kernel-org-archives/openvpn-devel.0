From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 31 Dec 2024 16:51:13 +0000
In-Reply-To: <gerrit.1733833084000.Ia1c5209022d3ab4c0dac6438c41891c7d059f812@...2715...>
References: <gerrit.1733833084000.Ia1c5209022d3ab4c0dac6438c41891c7d059f812@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e55a247ceb2ba216072caf09febec592996db1bf-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JGjh1ZVQUnY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow DEFAULT in
 data-ciphers and report both expanded and user set o...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JGjh1ZVQUnY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/828?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Allow DEFAULT in data-ciphers and report both expanded and =
user set option
......................................................................

Allow DEFAULT in data-ciphers and report both expanded and user set option

This adds support for parsing DEFAULT in data-ciphers, the idea is that peo=
ple
can modify the default without repeating the default ciphers.

In the past we have seem that people will use data-ciphers BF-CBC or
data-ciphers AES-128-CBC when getting the warning that the cipher is not
supported by the server.  This commit aims to provide a better way for
these situation as we still want people to rely on default cipher selection
from OpenVPN when possible.

Change-Id: Ia1c5209022d3ab4c0dac6438c41891c7d059f812
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20241227124632.110920-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
245.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M doc/man-sections/protocol-options.rst
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_ncp.h
M tests/unit_tests/openvpn/test_ncp.c
8 files changed, 284 insertions(+), 48 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/828/4

diff --git a/Changes.rst b/Changes.rst
index 34542a5..16ae6fc 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -30,6 +30,12 @@
=20
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
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/proto=
col-options.rst
index 05f87cc..d04ace8 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -178,6 +178,12 @@
   Chacha20-Poly1305 if the underlying SSL library (and its configuration)
   supports it.

+  Starting with OpenVPN 2.7 the special keyword :code:`DEFAULT` can be used
+  in the string and is replaced by the default ciphers.  This can be used =
to
+  add an additional allowed cipher to the allowed ciphers, e.g.
+  :code:`DEFAULT:AES-192-CBC` to use the default ciphers but also allow
+  :code:`AES-192-CBC`.
+
   Cipher negotiation is enabled in client-server mode only. I.e. if
   ``--mode`` is set to `server` (server-side, implied by setting
   ``--server`` ), or if ``--pull`` is specified (client-side, implied by
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 67bb58f..f426b46 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1897,14 +1897,15 @@
     if (strlen(peer_ciphers) > 0)
     {
         msg(M_INFO, "PUSH: No common cipher between server and client. "
-            "Server data-ciphers: '%s', client supported ciphers '%s'",
-            o->ncp_ciphers, peer_ciphers);
+            "Server data-ciphers: '%s'%s, client supported ciphers '%s'",
+            o->ncp_ciphers_conf, ncp_expanded_ciphers(o, &gc), peer_cipher=
s);
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
index 20e8d55..1c35d67 100644
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
-    bool can_do_chacha =3D cipher_valid("CHACHA20-POLY1305");
-
-    if (can_do_chacha && dco_enabled(o))
-    {
-        /* also make sure that dco supports chacha */
-        can_do_chacha =3D tls_item_in_cipher_list("CHACHA20-POLY1305", dco=
_get_supported_ciphers());
-    }
-
-    if (can_do_chacha)
-    {
-        o->ncp_ciphers =3D "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
-    }
-    else
-    {
-        o->ncp_ciphers =3D "AES-256-GCM:AES-128-GCM";
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
         msg(M_WARN, "DEPRECATED OPTION: --cipher set to '%s' but missing i=
n "
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
+    /** The original ncp_ciphers specified by the user in the configuratio=
n*/
+    const char *ncp_ciphers_conf;
     const char *ncp_ciphers;
     const char *authname;
     const char *engine;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 167bdb2..b238fc0 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -40,6 +40,8 @@
 #include "config.h"
 #endif

+#include <string.h>
+
 #include "syshead.h"
 #include "win32.h"

@@ -223,7 +225,6 @@

     return token !=3D NULL;
 }
-
 const char *
 tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc)
 {
@@ -335,15 +336,16 @@
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
@@ -517,10 +519,13 @@
     if (!session->opt->server && !cipher_allowed_as_fallback
         && !tls_item_in_cipher_list(options->ciphername, options->ncp_ciph=
ers))
     {
-        msg(D_TLS_ERRORS, "Error: negotiated cipher not allowed - %s not i=
n %s",
-            options->ciphername, options->ncp_ciphers);
+        struct gc_arena gc =3D gc_new();
+        msg(D_TLS_ERRORS, "Error: negotiated cipher not allowed - %s not i=
n %s%s",
+            options->ciphername, options->ncp_ciphers_conf,
+            ncp_expanded_ciphers(options, &gc));
         /* undo cipher push, abort connection setup */
         options->ciphername =3D session->opt->config_ciphername;
+        gc_free(&gc);
         return false;
     }
     else
@@ -528,3 +533,100 @@
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
+replace_default_in_ncp_ciphers_option(struct options *o, const char *repla=
ce)
+{
+    const char *search =3D "DEFAULT";
+    const int ncp_ciphers_len =3D strlen(o->ncp_ciphers) + strlen(replace)=
 - strlen(search) + 1;
+
+    uint8_t *ncp_ciphers =3D gc_malloc(ncp_ciphers_len, true, &o->gc);
+
+    struct buffer ncp_ciphers_buf;
+    buf_set_write(&ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);
+
+    const char *def =3D strstr(o->ncp_ciphers, search);
+
+    /* Copy everything before the DEFAULT string */
+    buf_write(&ncp_ciphers_buf, o->ncp_ciphers, def - o->ncp_ciphers);
+
+    /* copy the default string. */
+    buf_write(&ncp_ciphers_buf, replace, strlen(replace));
+
+    /* copy the rest of the ncp cipher string */
+    const char *after_default =3D def + strlen(search);
+    buf_write(&ncp_ciphers_buf, after_default, strlen(after_default));
+
+    o->ncp_ciphers =3D (char *) ncp_ciphers;
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
+    bool default_in_cipher_list =3D o->ncp_ciphers
+                                  && tls_item_in_cipher_list("DEFAULT", o-=
>ncp_ciphers);
+
+    /* preserve the values that the user put into the configuration */
+    o->ncp_ciphers_conf =3D o->ncp_ciphers;
+
+    /* check if crypto library supports chacha */
+    bool can_do_chacha =3D cipher_valid("CHACHA20-POLY1305");
+
+    if (can_do_chacha && dco_enabled(o))
+    {
+        /* also make sure that dco supports chacha */
+        can_do_chacha =3D tls_item_in_cipher_list("CHACHA20-POLY1305", dco=
_get_supported_ciphers());
+    }
+
+    const char *default_ciphers =3D "AES-256-GCM:AES-128-GCM:CHACHA20-POLY=
1305";
+
+    if (!can_do_chacha)
+    {
+        default_ciphers =3D "AES-256-GCM:AES-128-GCM";
+    }
+
+    /* want to rather print DEFAULT instead of a manually set default list=
 */
+    if (!o->ncp_ciphers_conf || !strcmp(default_ciphers, o->ncp_ciphers_co=
nf))
+    {
+        o->ncp_ciphers =3D default_ciphers;
+        o->ncp_ciphers_conf =3D "DEFAULT";
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
+    struct buffer expanded_ciphers_buf =3D alloc_buf_gc(strlen(o->ncp_ciph=
ers) + 4, gc);
+
+    buf_printf(&expanded_ciphers_buf, " (%s)", o->ncp_ciphers);
+    return BSTR(&expanded_ciphers_buf);
+}
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 0bdb6a0..36be65b 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -157,4 +157,23 @@
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
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn=
/test_ncp.c
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
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1=
305";
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
+    bool have_chacha =3D cipher_valid("CHACHA20-POLY1305");
+
+    struct options o =3D { 0 };
+
+    o.gc =3D gc_new();
+
+    /* no user specified string */
+    o.ncp_ciphers =3D NULL;
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    if (have_chacha)
+    {
+        assert_string_equal(o.ncp_ciphers, "AES-256-GCM:AES-128-GCM:CHACHA=
20-POLY1305");
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
+        o.ncp_ciphers =3D "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+    }
+    else
+    {
+        o.ncp_ciphers =3D "AES-256-GCM:AES-128-GCM";
+    }
+
+    options_postprocess_setdefault_ncpciphers(&o);
+    assert_string_equal(o.ncp_ciphers_conf, "DEFAULT");
+
+    /* test default in the middle of the string */
+    o.ncp_ciphers =3D "BF-CBC:DEFAULT:AES-128-CBC:AES-256-CBC";
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    if (have_chacha)
+    {
+        assert_string_equal(o.ncp_ciphers, "BF-CBC:AES-256-GCM:AES-128-GCM=
:CHACHA20-POLY1305:AES-128-CBC:AES-256-CBC");
+    }
+    else
+    {
+        assert_string_equal(o.ncp_ciphers, "BF-CBC:AES-256-GCM:AES-128-GCM=
:AES-128-CBC:AES-256-CBC");
+    }
+    assert_string_equal(o.ncp_ciphers_conf, "BF-CBC:DEFAULT:AES-128-CBC:AE=
S-256-CBC");
+
+    /* string at the beginning */
+    o.ncp_ciphers =3D "DEFAULT:AES-128-CBC:AES-192-CBC";
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    if (have_chacha)
+    {
+        assert_string_equal(o.ncp_ciphers, "AES-256-GCM:AES-128-GCM:CHACHA=
20-POLY1305:AES-128-CBC:AES-192-CBC");
+    }
+    else
+    {
+        assert_string_equal(o.ncp_ciphers, "AES-256-GCM:AES-128-GCM:AES-12=
8-CBC:AES-192-CBC");
+    }
+    assert_string_equal(o.ncp_ciphers_conf, "DEFAULT:AES-128-CBC:AES-192-C=
BC");
+
+    /* DEFAULT at the end */
+    o.ncp_ciphers =3D "AES-192-GCM:AES-128-CBC:DEFAULT";
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    if (have_chacha)
+    {
+        assert_string_equal(o.ncp_ciphers, "AES-192-GCM:AES-128-CBC:AES-25=
6-GCM:AES-128-GCM:CHACHA20-POLY1305");
+    }
+    else
+    {
+        assert_string_equal(o.ncp_ciphers, "AES-192-GCM:AES-128-CBC:AES-25=
6-GCM:AES-128-GCM");
+    }
+    assert_string_equal(o.ncp_ciphers_conf, "AES-192-GCM:AES-128-CBC:DEFAU=
LT");
+
+    gc_free(&o.gc);
+}
+
+static void
+test_ncp_expand(void **state)
+{
+    bool have_chacha =3D cipher_valid("CHACHA20-POLY1305");
+    struct options o =3D {0};
+
+    o.gc =3D gc_new();
+    struct gc_arena gc =3D gc_new();
+
+    /* no user specified string */
+    o.ncp_ciphers =3D NULL;
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    const char *expanded =3D ncp_expanded_ciphers(&o, &gc);
+
+    /* user specificed string with DEFAULT in it */
+    o.ncp_ciphers =3D "AES-192-GCM:DEFAULT";
+    options_postprocess_setdefault_ncpciphers(&o);
+    const char *expanded2 =3D ncp_expanded_ciphers(&o, &gc);
+
+    if (have_chacha)
+    {
+        assert_string_equal(expanded, " (AES-256-GCM:AES-128-GCM:CHACHA20-=
POLY1305)");
+        assert_string_equal(expanded2, " (AES-192-GCM:AES-256-GCM:AES-128-=
GCM:CHACHA20-POLY1305)");
+    }
+    else
+    {
+        assert_string_equal(expanded, " (AES-256-GCM:AES-128-GCM)");
+        assert_string_equal(expanded2, " (AES-192-GCM:AES-256-GCM:AES-128-=
GCM)");
+    }
+
+    o.ncp_ciphers =3D "AES-192-GCM:BF-CBC";
+    options_postprocess_setdefault_ncpciphers(&o);
+
+    assert_string_equal(ncp_expanded_ciphers(&o, &gc), "");
+
+    gc_free(&o.gc);
+    gc_free(&gc);
+}


 const struct CMUnitTest ncp_tests[] =3D {
     cmocka_unit_test(test_check_ncp_ciphers_list),
     cmocka_unit_test(test_extract_client_ciphers),
     cmocka_unit_test(test_poor_man),
-    cmocka_unit_test(test_ncp_best)
+    cmocka_unit_test(test_ncp_best),
+    cmocka_unit_test(test_ncp_default),
+    cmocka_unit_test(test_ncp_expand),
 };



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/828?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1c5209022d3ab4c0dac6438c41891c7d059f812
Gerrit-Change-Number: 828
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--JGjh1ZVQUnY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
828?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Allow DEFAULT in data-ciphers and report both=
 expanded and user set option<br><br>This adds support for parsing DEFAULT =
in data-ciphers, the idea is that people<br>can modify the default without =
repeating the default ciphers.<br><br>In the past we have seem that people =
will use data-ciphers BF-CBC or<br>data-ciphers AES-128-CBC when getting th=
e warning that the cipher is not<br>supported by the server.  This commit a=
ims to provide a better way for<br>these situation as we still want people =
to rely on default cipher selection<br>from OpenVPN when possible.<br><br>C=
hange-Id: Ia1c5209022d3ab4c0dac6438c41891c7d059f812<br>Signed-off-by: Arne =
Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>Message-Id: &lt;20241227124632.110920-1-frank@...2641...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg30245.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M Changes.rst<br>M doc/man-sections/protocol-options.rst<br>M src/openv=
pn/multi.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/o=
penvpn/ssl_ncp.c<br>M src/openvpn/ssl_ncp.h<br>M tests/unit_tests/openvpn/t=
est_ncp.c<br>8 files changed, 284 insertions(+), 48 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/828/4</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 34542a5..16=
ae6fc 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -30,6 +30,12 @@</span><br><span> </span><br><span>=
     https://datatracker.ietf.org/doc/draft-irtf-cfrg-aead-limits/</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+Default ci=
phers in ``--data-ciphers``</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    Ciphers in ``--data-ciphers`` can contain the string DEFAULT th=
at is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    replaced b=
y the default ciphers used by OpenVPN, making it easier to</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    add an allowed cipher without ha=
ving to spell out the default ciphers.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> Deprecated features</span><br><span> -------------------<=
/span><br><span> ``secret`` support has been removed by default.</span><br>=
<span>diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections=
/protocol-options.rst</span><br><span>index 05f87cc..d04ace8 100644</span><=
br><span>--- a/doc/man-sections/protocol-options.rst</span><br><span>+++ b/=
doc/man-sections/protocol-options.rst</span><br><span>@@ -178,6 +178,12 @@<=
/span><br><span>   Chacha20-Poly1305 if the underlying SSL library (and its=
 configuration)</span><br><span>   supports it.</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  Starting with OpenVPN 2.7 t=
he special keyword :code:`DEFAULT` can be used</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  in the string and is replaced by the default c=
iphers.  This can be used to</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  add an additional allowed cipher to the allowed ciphers, e.g.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`DEFAULT:AES-1=
92-CBC` to use the default ciphers but also allow</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  :code:`AES-192-CBC`.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   Cipher negotiation is=
 enabled in client-server mode only. I.e. if</span><br><span>   ``--mode`` =
is set to `server` (server-side, implied by setting</span><br><span>   ``--=
server`` ), or if ``--pull`` is specified (client-side, implied by</span><b=
r><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><s=
pan>index 67bb58f..f426b46 100644</span><br><span>--- a/src/openvpn/multi.c=
</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1897,14 +189=
7,15 @@</span><br><span>     if (strlen(peer_ciphers) &gt; 0)</span><br><sp=
an>     {</span><br><span>         msg(M_INFO, &quot;PUSH: No common cipher=
 between server and client. &quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            &quot;Server data-ciphers: &#39;%s&#39;, client su=
pported ciphers &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            o-&gt;ncp_ciphers, peer_ciphers);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;Server data-ciphe=
rs: &#39;%s&#39;%s, client supported ciphers &#39;%s&#39;&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;ncp_ciphers_=
conf, ncp_expanded_ciphers(o, &amp;gc), peer_ciphers);</span><br><span>    =
 }</span><br><span>     else if (tls_multi-&gt;remote_ciphername)</span><br=
><span>     {</span><br><span>         msg(M_INFO, &quot;PUSH: No common ci=
pher between server and client. &quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            &quot;Server data-ciphers: &#39;%s&#39;, clien=
t supports cipher &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            o-&gt;ncp_ciphers, tls_multi-&gt;remote_ciphern=
ame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &q=
uot;Server data-ciphers: &#39;%s&#39;%s, client supports cipher &#39;%s&#39=
;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 o-&gt;ncp_ciphers_conf, ncp_expanded_ciphers(o, &amp;gc),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            tls_multi-&gt;remote_cip=
hername);</span><br><span>     }</span><br><span>     else</span><br><span>=
     {</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/opt=
ions.c</span><br><span>index 20e8d55..1c35d67 100644</span><br><span>--- a/=
src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br=
><span>@@ -3486,40 +3486,6 @@</span><br><span>     }</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * Checks for availibility of Chacha20-Poly130=
5 and sets</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the ncp_=
cipher to either AES-256-GCM:AES-128-GCM or</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305.</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-options_postprocess_setdefault_ncpciphers(struct options =
*o)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;ncp_ciphers)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        /* custom --data-ciphers set, keep list *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* check if crypto library supports chacha */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    bool can_do_chacha =3D cipher_v=
alid(&quot;CHACHA20-POLY1305&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (can_do_chacha &amp;&amp; dco_enabled(o))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /* also make sure that dco supports chacha */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        can_do_chacha =3D tls_item_in_=
cipher_list(&quot;CHACHA20-POLY1305&quot;, dco_get_supported_ciphers());</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (can_do_chacha)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       o-&gt;ncp_ciphers =3D &quot;AES-256-GCM:AES-128-GCM:CHACHA20-POLY130=
5&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        o-&gt;ncp_ciphers =3D &quot;AES-256-GCM:AES-128-GC=
M&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> op=
tions_postprocess_cipher(struct options *o)</span><br><span> {</span><br><s=
pan>@@ -3550,7 +3516,8 @@</span><br><span>             &quot;defaulted to B=
F-CBC as fallback when cipher negotiation &quot;</span><br><span>          =
   &quot;failed in this case. If you need this fallback please add &quot;</=
span><br><span>             &quot;&#39;--data-ciphers-fallback BF-CBC&#39; =
to your configuration &quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            &quot;and/or add BF-CBC to --data-ciphers.&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;and/or =
add BF-CBC to --data-ciphers. E.g. &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;--data-ciphers %s:BF-CBC&quot;, o-&=
gt;ncp_ciphers_conf);</span><br><span>     }</span><br><span>     else if (=
!o-&gt;enable_ncp_fallback</span><br><span>              &amp;&amp; !tls_it=
em_in_cipher_list(o-&gt;ciphername, o-&gt;ncp_ciphers))</span><br><span>@@ =
-3558,7 +3525,7 @@</span><br><span>         msg(M_WARN, &quot;DEPRECATED OP=
TION: --cipher set to &#39;%s&#39; but missing in &quot;</span><br><span>  =
           &quot;--data-ciphers (%s). OpenVPN ignores --cipher for cipher &=
quot;</span><br><span>             &quot;negotiations. &quot;,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;ciphername, o-&g=
t;ncp_ciphers);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        o-&gt;ciphername, o-&gt;ncp_ciphers_conf);</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvp=
n/options.h b/src/openvpn/options.h</span><br><span>index 6ab92e2..55f12dd =
100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/sr=
c/openvpn/options.h</span><br><span>@@ -559,6 +559,8 @@</span><br><span>   =
  const char *ciphername;</span><br><span>     bool enable_ncp_fallback;   =
   /**&lt; If defined fall back to</span><br><span>                        =
            * ciphername if NCP fails */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /** The original ncp_ciphers specified by the user=
 in the configuration*/</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *ncp_ciphers_conf;</span><br><span>     const char *ncp_=
ciphers;</span><br><span>     const char *authname;</span><br><span>     co=
nst char *engine;</span><br><span>diff --git a/src/openvpn/ssl_ncp.c b/src/=
openvpn/ssl_ncp.c</span><br><span>index 167bdb2..b238fc0 100644</span><br><=
span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.=
c</span><br><span>@@ -40,6 +40,8 @@</span><br><span> #include &quot;config.=
h&quot;</span><br><span> #endif</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &quot;syshea=
d.h&quot;</span><br><span> #include &quot;win32.h&quot;</span><br><span> </=
span><br><span>@@ -223,7 +225,6 @@</span><br><span> </span><br><span>     r=
eturn token !=3D NULL;</span><br><span> }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> const char *</span><br><span> tls_pee=
r_ncp_list(const char *peer_info, struct gc_arena *gc)</span><br><span> {</=
span><br><span>@@ -335,15 +336,16 @@</span><br><span>         return true;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /* We failed negotiation, give appropiate error mess=
age */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We fai=
led negotiation, give appropriate error message */</span><br><span>     if =
(c-&gt;c2.tls_multi-&gt;remote_ciphername)</span><br><span>     {</span><br=
><span>         msg(D_TLS_ERRORS, &quot;OPTIONS ERROR: failed to negotiate =
&quot;</span><br><span>             &quot;cipher with server.  Add the serv=
er&#39;s &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      &quot;cipher (&#39;%s&#39;) to --data-ciphers (currently &#39;%s&#39;=
) if &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  &quot;you want to connect to this server.&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &quot;cipher (&#39;%s&#39;) to -=
-data-ciphers (currently &#39;%s&#39;), e.g.&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &quot;--data-ciphers %s:%s if yo=
u want to connect to this server.&quot;,</span><br><span>             c-&gt=
;c2.tls_multi-&gt;remote_ciphername,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            c-&gt;options.ncp_ciphers);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options.ncp_ciphers_co=
nf, c-&gt;options.ncp_ciphers_conf,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            c-&gt;c2.tls_multi-&gt;remote_ciphername);</spa=
n><br><span>         return false;</span><br><span> </span><br><span>     }=
</span><br><span>@@ -517,10 +519,13 @@</span><br><span>     if (!session-&g=
t;opt-&gt;server &amp;&amp; !cipher_allowed_as_fallback</span><br><span>   =
      &amp;&amp; !tls_item_in_cipher_list(options-&gt;ciphername, options-&=
gt;ncp_ciphers))</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(D_TLS_ERRORS, &quot;Error: negotiated cipher =
not allowed - %s not in %s&quot;,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            options-&gt;ciphername, options-&gt;ncp_ciphers);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(D_TLS_ERRORS, &quot;Error: negotiated cipher not allowed - %s n=
ot in %s%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          options-&gt;ciphername, options-&gt;ncp_ciphers_conf,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            ncp_expanded_cipher=
s(options, &amp;gc));</span><br><span>         /* undo cipher push, abort c=
onnection setup */</span><br><span>         options-&gt;ciphername =3D sess=
ion-&gt;opt-&gt;config_ciphername;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        gc_free(&amp;gc);</span><br><span>         return fa=
lse;</span><br><span>     }</span><br><span>     else</span><br><span>@@ -5=
28,3 +533,100 @@</span><br><span>         return true;</span><br><span>    =
 }</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Replaces the string DEFAULT wi=
th the string \c replace.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param o=
         Options struct to modify and to use the gc from</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param replace   string used to rep=
lace the DEFAULT string</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+replace_default_in_n=
cp_ciphers_option(struct options *o, const char *replace)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *search =3D &quot;DEFAULT&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const int ncp_ciphers_l=
en =3D strlen(o-&gt;ncp_ciphers) + strlen(replace) - strlen(search) + 1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t *ncp_ciphers =3D gc_malloc(nc=
p_ciphers_len, true, &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct buffer ncp_ciphers_buf;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf_set_write(&amp;ncp_ciphers_buf, ncp_ciphers, ncp_ciphe=
rs_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const char *def =3D strstr=
(o-&gt;ncp_ciphers, search);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Cop=
y everything before the DEFAULT string */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    buf_write(&amp;ncp_ciphers_buf, o-&gt;ncp_ciphers=
, def - o-&gt;ncp_ciphers);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* copy=
 the default string. */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    buf_write(&amp;ncp_ciphers_buf, replace, strlen(replace));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* copy the rest of the ncp cipher string *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *af=
ter_default =3D def + strlen(search);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    buf_write(&amp;ncp_ciphers_buf, after_default, strlen=
(after_default));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;ncp_ciphers=
 =3D (char *) ncp_ciphers;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Checks for availibility of Chacha20-Poly130=
5 and sets</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the nc=
p_cipher to either AES-256-GCM:AES-128-GCM or</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+options_postprocess_setdefault_ncpciphers(struct optio=
ns *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool default_in_cipher_list=
 =3D o-&gt;ncp_ciphers</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                  &amp;&amp; tls_item_in_cipher_list(&qu=
ot;DEFAULT&quot;, o-&gt;ncp_ciphers);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* preserve the values that the user put into the configuration */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;ncp_ciphers_con=
f =3D o-&gt;ncp_ciphers;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check i=
f crypto library supports chacha */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool can_do_chacha =3D cipher_valid(&quot;CHACHA20-POLY=
1305&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (can_do_chacha &amp=
;&amp; dco_enabled(o))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
also make sure that dco supports chacha */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        can_do_chacha =3D tls_item_in_cipher_list(&q=
uot;CHACHA20-POLY1305&quot;, dco_get_supported_ciphers());</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *default_ciphers =3D &quot;AES-256-GCM:AES-128-GCM:CHA=
CHA20-POLY1305&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!can_do_c=
hacha)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        default_ciphers =3D=
 &quot;AES-256-GCM:AES-128-GCM&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* want to =
rather print DEFAULT instead of a manually set default list */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;ncp_ciphers_conf =
|| !strcmp(default_ciphers, o-&gt;ncp_ciphers_conf))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        o-&gt;ncp_ciphers =3D default_ciphers;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;ncp_ciphers_co=
nf =3D &quot;DEFAULT&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (!default_in_cipher_list)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* custom cipher list without DEFAULT string in it,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * nothing to replace/mutate =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        replace_default_in_ncp_ciphers_option(o, default_cip=
hers);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ncp_expanded_ciphers(struct options *o, struct gc_arena *gc)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!strcmp(o-&gt;ncp_ciphers, o-&gt;ncp_cip=
hers_conf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* expanded ci=
phers and user set ciphers are identical, no need to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * add an expanded version */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return &quot;&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* two extra brackets, one space, NUL byte =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 expanded_ciphers_buf =3D alloc_buf_gc(strlen(o-&gt;ncp_ciphers) + 4, gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;expanded_ciphers_bu=
f, &quot; (%s)&quot;, o-&gt;ncp_ciphers);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return BSTR(&amp;expanded_ciphers_buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git =
a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h</span><br><span>index 0bdb6=
a0..36be65b 100644</span><br><span>--- a/src/openvpn/ssl_ncp.h</span><br><s=
pan>+++ b/src/openvpn/ssl_ncp.h</span><br><span>@@ -157,4 +157,23 @@</span>=
<br><span> bool</span><br><span> check_session_cipher(struct tls_session *s=
ession, struct options *options);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Checks for availability of Chacha20-Poly1305 and sets<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the ncp_cipher to=
 either AES-256-GCM:AES-128-GCM or</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305 if not set.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * If DEFAULT is in the ncp_cipher strin=
g, it will be replaced</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * by the default cipher string as defined above.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+options_postprocess_setdefault_ncpciphers(struct options *o);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/** returns the o-&gt;ncp_ciphers in brackets, e.=
g.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  (AES-256-GCM:=
CHACHA20-POLY1305) if o-&gt;ncp_ciphers_conf</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  and o-&gt;ncp_ciphers differ, otherwise an emp=
ty string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  The returned string wil=
l be allocated in the passed \c gc</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
onst char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ncp_expa=
nded_ciphers(struct options *o, struct gc_arena *gc);</span><br><span> #end=
if /* ifndef OPENVPN_SSL_NCP_H */</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c</span><br><sp=
an>index a8e1021..b744e96 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/test_ncp.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ncp.c</=
span><br><span>@@ -54,6 +54,17 @@</span><br><span>     ASSERT(0);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define a=
 dummy dco cipher option to avoid linking against all the DCO</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * units */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+const char *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dco_get_supported_ciphers(void)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return &quot;AES-192-GCM:AES-128-CBC:AES-256-G=
CM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> static void</span><br><span> test_check_ncp_ciphers_list(void **stat=
e)</span><br><span> {</span><br><span>@@ -260,13 +271,135 @@</span><br><spa=
n>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_ncp_default(void **state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool have_chacha =3D cipher_valid(&quot;CHAC=
HA20-POLY1305&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct option=
s o =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    o.gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* no user specified string */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    o.ncp_ciphers =3D NUL=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    options_postp=
rocess_setdefault_ncpciphers(&amp;o);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (have_chacha)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert=
_string_equal(o.ncp_ciphers, &quot;AES-256-GCM:AES-128-GCM:CHACHA20-POLY130=
5&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        assert_string_equal(o.ncp_ciphers, &quot;=
AES-256-GCM:AES-128-GCM&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(o.ncp_ciphers_conf, &quot;DEFAULT&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* check that a default string is replaced wit=
h DEFAULT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(have_chacha)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o.ncp_cipher=
s =3D &quot;AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        o.ncp_ciphers =3D &quot;AES-256-GCM:AES-128-GCM&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    options_postprocess_setdefault_ncpciphers(&amp;o);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(o.nc=
p_ciphers_conf, &quot;DEFAULT&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* test default in the middle of the string */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    o.ncp_ciphers =3D &quot;BF-CBC:DEFAULT:AE=
S-128-CBC:AES-256-CBC&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    options_postprocess_setdefault_ncpciphers(&amp;o);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (have_chacha)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        assert_string_equal(o.ncp_ciphers, &quot;BF-CBC:AES-256=
-GCM:AES-128-GCM:CHACHA20-POLY1305:AES-128-CBC:AES-256-CBC&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        assert_string_equal(o.ncp_ciphers, &quot;BF-CBC:AES-256-GC=
M:AES-128-GCM:AES-128-CBC:AES-256-CBC&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_string_equal(o.ncp_ciphers_conf, &quot;BF-CBC:DEFAUL=
T:AES-128-CBC:AES-256-CBC&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* string at the beginning */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    o.ncp_ciphers =3D &quot;DEFAULT:AES-128-CBC:AES-192-CBC&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    options_postpro=
cess_setdefault_ncpciphers(&amp;o);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (have_chacha)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_s=
tring_equal(o.ncp_ciphers, &quot;AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305:=
AES-128-CBC:AES-192-CBC&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_string_equal=
(o.ncp_ciphers, &quot;AES-256-GCM:AES-128-GCM:AES-128-CBC:AES-192-CBC&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(o.ncp_c=
iphers_conf, &quot;DEFAULT:AES-128-CBC:AES-192-CBC&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* DEFAULT at the end */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    o.ncp_ciphers =3D &quot;AES-192-GCM:AES-12=
8-CBC:DEFAULT&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    options_postprocess_setdefault_ncpciphers(&amp;o);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (have_chacha)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        assert_string_equal(o.ncp_ciphers, &quot;AES-192-GCM:AES-128-CB=
C:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   assert_string_equal(o.ncp_ciphers, &quot;AES-192-GCM:AES-128-CBC:AES-256=
-GCM:AES-128-GCM&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_string_equal(o.ncp_ciphers_conf, &quot;AES-192-GCM:AES-128-CBC:DEFAULT&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;o.gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_ncp_expand(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    boo=
l have_chacha =3D cipher_valid(&quot;CHACHA20-POLY1305&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct options o =3D {0};</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    o.gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* no user specified string */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    o.ncp_ciphers =3D NUL=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    options_postp=
rocess_setdefault_ncpciphers(&amp;o);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char *expanded =3D ncp_expanded_ciphers(&amp;o, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* user specificed string with DEFAULT in i=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o.ncp_ciphe=
rs =3D &quot;AES-192-GCM:DEFAULT&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    options_postprocess_setdefault_ncpciphers(&amp;o);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *expa=
nded2 =3D ncp_expanded_ciphers(&amp;o, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (have_chacha)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     assert_string_equal(expanded, &quot; (AES-256-GCM:AES-128-GCM:CHACHA20=
-POLY1305)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       assert_string_equal(expanded2, &quot; (AES-192-GCM:AES-256-GCM:AES-1=
28-GCM:CHACHA20-POLY1305)&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_string_equ=
al(expanded, &quot; (AES-256-GCM:AES-128-GCM)&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_string_equal(expanded2, &q=
uot; (AES-192-GCM:AES-256-GCM:AES-128-GCM)&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  o.ncp_ciphers =3D &quot;AES-192-GCM:BF-CBC&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    options_postprocess_setdefault_ncpcip=
hers(&amp;o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(n=
cp_expanded_ciphers(&amp;o, &amp;gc), &quot;&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;o.gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span> </span><br><span> </span><br><span>=
 const struct CMUnitTest ncp_tests[] =3D {</span><br><span>     cmocka_unit=
_test(test_check_ncp_ciphers_list),</span><br><span>     cmocka_unit_test(t=
est_extract_client_ciphers),</span><br><span>     cmocka_unit_test(test_poo=
r_man),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cmocka_uni=
t_test(test_ncp_best)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    cmocka_unit_test(test_ncp_best),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    cmocka_unit_test(test_ncp_default),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_ncp_expand=
),</span><br><span> };</span><br><span> </span><br><span> </span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/828?usp=3Demail">change 828</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/828?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia1c5209022d3ab4c0dac6438c41=
891c7d059f812 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 828 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--JGjh1ZVQUnY=--

