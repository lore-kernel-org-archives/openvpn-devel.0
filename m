From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 10 Dec 2024 12:18:07 +0000
References: <gerrit.1733833084000.Ia1c5209022d3ab4c0dac6438c41891c7d059f812@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <b110c21aa191c98049655e2fe4b85a006e7a0cd7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GVeQOrMu33c="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GVeQOrMu33c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/828?usp=3Demail

to review the following change.


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
---
M Changes.rst
M doc/man-sections/protocol-options.rst
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_ncp.h
M tests/unit_tests/openvpn/test_ncp.c
8 files changed, 276 insertions(+), 48 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/828/1

diff --git a/Changes.rst b/Changes.rst
index a6cc3be..0bb2e1c 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -22,6 +22,11 @@

     For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/l=
wipovpn).

+Default ciphers in ``--data-ciphers``
+    Ciphers in ``--data-ciphers`` can contain the string DEFAULT that is
+    replaced by the default ciphers used by OpenVPN, making it easier to
+    add an allowed cipher without having to spell out the default ciphers.
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/proto=
col-options.rst
index 05f87cc..fc7648d 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -178,6 +178,12 @@
   Chacha20-Poly1305 if the underlying SSL library (and its configuration)
   supports it.

+  Starting with OpenVPN 2.7 the special keyword DEFAULT can be used in the
+  string and is replaced by the default ciphers.  This can be used add
+  an additional allowed cipher to the allowed ciphers, e.g.
+  :code:`DEFAULT:AES-192-CBC` to use the default ciphers but also allow
+  :code:`AES-192-CBC`.
+
   Cipher negotiation is enabled in client-server mode only. I.e. if
   ``--mode`` is set to `server` (server-side, implied by setting
   ``--server`` ), or if ``--pull`` is specified (client-side, implied by
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 45b3cfa..449dcb2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1896,14 +1896,15 @@
     if (strlen(peer_ciphers) > 0)
     {
         msg(M_INFO, "PUSH: No common cipher between server and client. "
-            "Server data-ciphers: '%s', client supported ciphers '%s'",
-            o->ncp_ciphers, peer_ciphers);
+            "Server data-ciphers: '%s%s', client supported ciphers '%s'",
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
index d8dd518..6ea2928 100644
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
index 968858e..27db2b1 100644
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

     return token !=3D NULL;
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
@@ -527,3 +532,99 @@
         return true;
     }
 }
+
+/**
+ * Replaces the string DEFAULT with the string \param replace. The
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
index afbe331..2378221 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -156,4 +156,24 @@
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
+ *  The returned string will be allocated in the passed \param gc
+ *
+ */
+const char *
+ncp_expanded_ciphers(struct options *o, struct gc_arena *gc);
 #endif /* ifndef OPENVPN_SSL_NCP_H */
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn=
/test_ncp.c
index a8e1021..0b763e4 100644
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
@@ -260,13 +271,128 @@
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
+    if (have_chacha)
+    {
+        assert_string_equal(expanded, " (AES-256-GCM:AES-128-GCM:CHACHA20-=
POLY1305)");
+    }
+    else
+    {
+        assert_string_equal(expanded, " (AES-256-GCM:AES-128-GCM)");
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
=20


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/828?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1c5209022d3ab4c0dac6438c41891c7d059f812
Gerrit-Change-Number: 828
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--GVeQOrMu33c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/828?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Allow DEFAULT in data-ciphers and report both expanded and us=
er set option<br><br>This adds support for parsing DEFAULT in data-ciphers,=
 the idea is that people<br>can modify the default without repeating the de=
fault ciphers.<br><br>In the past we have seem that people will use data-ci=
phers BF-CBC or<br>data-ciphers AES-128-CBC when getting the warning that t=
he cipher is not<br>supported by the server.  This commit aims to provide a=
 better way for<br>these situation as we still want people to rely on defau=
lt cipher selection<br>from OpenVPN when possible.<br><br>Change-Id: Ia1c52=
09022d3ab4c0dac6438c41891c7d059f812<br>---<br>M Changes.rst<br>M doc/man-se=
ctions/protocol-options.rst<br>M src/openvpn/multi.c<br>M src/openvpn/optio=
ns.c<br>M src/openvpn/options.h<br>M src/openvpn/ssl_ncp.c<br>M src/openvpn=
/ssl_ncp.h<br>M tests/unit_tests/openvpn/test_ncp.c<br>8 files changed, 276=
 insertions(+), 48 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/28/828/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Cha=
nges.rst</span><br><span>index a6cc3be..0bb2e1c 100644</span><br><span>--- =
a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -22,6 +2=
2,11 @@</span><br><span> </span><br><span>     For more details see [lwipov=
pn on Gihtub](https://github.com/OpenVPN/lwipovpn).</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+Default ciphers in ``--da=
ta-ciphers``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Cip=
hers in ``--data-ciphers`` can contain the string DEFAULT that is</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    replaced by the default c=
iphers used by OpenVPN, making it easier to</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    add an allowed cipher without having to spell o=
ut the default ciphers.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> Deprecated features</span><br><span> ----------------=
---</span><br><span> ``secret`` support has been removed by default.</span>=
<br><span>diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sect=
ions/protocol-options.rst</span><br><span>index 05f87cc..fc7648d 100644</sp=
an><br><span>--- a/doc/man-sections/protocol-options.rst</span><br><span>++=
+ b/doc/man-sections/protocol-options.rst</span><br><span>@@ -178,6 +178,12=
 @@</span><br><span>   Chacha20-Poly1305 if the underlying SSL library (and=
 its configuration)</span><br><span>   supports it.</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  Starting with OpenVPN 2=
.7 the special keyword DEFAULT can be used in the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  string and is replaced by the default ciphe=
rs.  This can be used add</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  an additional allowed cipher to the allowed ciphers, e.g.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`DEFAULT:AES-192-CBC`=
 to use the default ciphers but also allow</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  :code:`AES-192-CBC`.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>   Cipher negotiation is enabled=
 in client-server mode only. I.e. if</span><br><span>   ``--mode`` is set t=
o `server` (server-side, implied by setting</span><br><span>   ``--server``=
 ), or if ``--pull`` is specified (client-side, implied by</span><br><span>=
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>inde=
x 45b3cfa..449dcb2 100644</span><br><span>--- a/src/openvpn/multi.c</span><=
br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1896,14 +1896,15 @@<=
/span><br><span>     if (strlen(peer_ciphers) &gt; 0)</span><br><span>     =
{</span><br><span>         msg(M_INFO, &quot;PUSH: No common cipher between=
 server and client. &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            &quot;Server data-ciphers: &#39;%s&#39;, client supported =
ciphers &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            o-&gt;ncp_ciphers, peer_ciphers);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;Server data-ciphers: &#=
39;%s%s&#39;, client supported ciphers &#39;%s&#39;&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;ncp_ciphers_conf, =
ncp_expanded_ciphers(o, &amp;gc), peer_ciphers);</span><br><span>     }</sp=
an><br><span>     else if (tls_multi-&gt;remote_ciphername)</span><br><span=
>     {</span><br><span>         msg(M_INFO, &quot;PUSH: No common cipher b=
etween server and client. &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            &quot;Server data-ciphers: &#39;%s&#39;, client supp=
orts cipher &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            o-&gt;ncp_ciphers, tls_multi-&gt;remote_ciphername);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;Se=
rver data-ciphers: &#39;%s&#39;%s, client supports cipher &#39;%s&#39;&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt=
;ncp_ciphers_conf, ncp_expanded_ciphers(o, &amp;gc),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            tls_multi-&gt;remote_cipherna=
me);</span><br><span>     }</span><br><span>     else</span><br><span>     =
{</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.=
c</span><br><span>index d8dd518..6ea2928 100644</span><br><span>--- a/src/o=
penvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><spa=
n>@@ -3486,40 +3486,6 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Checks for availibility of Chacha20-Poly1305 and=
 sets</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the ncp_ciphe=
r to either AES-256-GCM:AES-128-GCM or</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-options_postprocess_setdefault_ncpciphers(struct options *o)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;ncp_ciphers)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* custom --data-ciphers set, keep list */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* check if crypto library supports chacha */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    bool can_do_chacha =3D cipher_valid(=
&quot;CHACHA20-POLY1305&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (can=
_do_chacha &amp;&amp; dco_enabled(o))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /* also make sure that dco supports chacha */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        can_do_chacha =3D tls_item_in_ciphe=
r_list(&quot;CHACHA20-POLY1305&quot;, dco_get_supported_ciphers());</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (can_do_chacha)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    o-&gt;ncp_ciphers =3D &quot;AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&q=
uot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        o-&gt;ncp_ciphers =3D &quot;AES-256-GCM:AES-128-GCM=
&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> opt=
ions_postprocess_cipher(struct options *o)</span><br><span> {</span><br><sp=
an>@@ -3550,7 +3516,8 @@</span><br><span>             &quot;defaulted to BF=
-CBC as fallback when cipher negotiation &quot;</span><br><span>           =
  &quot;failed in this case. If you need this fallback please add &quot;</s=
pan><br><span>             &quot;&#39;--data-ciphers-fallback BF-CBC&#39; t=
o your configuration &quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            &quot;and/or add BF-CBC to --data-ciphers.&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;and/or a=
dd BF-CBC to --data-ciphers. E.g. &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &quot;--data-ciphers %s:BF-CBC&quot;, o-&g=
t;ncp_ciphers_conf);</span><br><span>     }</span><br><span>     else if (!=
o-&gt;enable_ncp_fallback</span><br><span>              &amp;&amp; !tls_ite=
m_in_cipher_list(o-&gt;ciphername, o-&gt;ncp_ciphers))</span><br><span>@@ -=
3558,7 +3525,7 @@</span><br><span>         msg(M_WARN, &quot;DEPRECATED OPT=
ION: --cipher set to &#39;%s&#39; but missing in &quot;</span><br><span>   =
          &quot;--data-ciphers (%s). OpenVPN ignores --cipher for cipher &q=
uot;</span><br><span>             &quot;negotiations. &quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;ciphername, o-&gt=
;ncp_ciphers);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       o-&gt;ciphername, o-&gt;ncp_ciphers_conf);</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn=
/options.h b/src/openvpn/options.h</span><br><span>index 6ab92e2..55f12dd 1=
00644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src=
/openvpn/options.h</span><br><span>@@ -559,6 +559,8 @@</span><br><span>    =
 const char *ciphername;</span><br><span>     bool enable_ncp_fallback;    =
  /**&lt; If defined fall back to</span><br><span>                         =
           * ciphername if NCP fails */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /** The original ncp_ciphers specified by the user =
in the configuration*/</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *ncp_ciphers_conf;</span><br><span>     const char *ncp_c=
iphers;</span><br><span>     const char *authname;</span><br><span>     con=
st char *engine;</span><br><span>diff --git a/src/openvpn/ssl_ncp.c b/src/o=
penvpn/ssl_ncp.c</span><br><span>index 968858e..27db2b1 100644</span><br><s=
pan>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c=
</span><br><span>@@ -39,6 +39,8 @@</span><br><span> #include &quot;config.h=
&quot;</span><br><span> #endif</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &quot;syshead=
.h&quot;</span><br><span> #include &quot;win32.h&quot;</span><br><span> </s=
pan><br><span>@@ -222,7 +224,6 @@</span><br><span> </span><br><span>     re=
turn token !=3D NULL;</span><br><span> }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> const char *</span><br><span> tls_peer=
_ncp_list(const char *peer_info, struct gc_arena *gc)</span><br><span> {</s=
pan><br><span>@@ -334,15 +335,16 @@</span><br><span>         return true;</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* We failed negotiation, give appropiate error messa=
ge */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We fail=
ed negotiation, give appropriate error message */</span><br><span>     if (=
c-&gt;c2.tls_multi-&gt;remote_ciphername)</span><br><span>     {</span><br>=
<span>         msg(D_TLS_ERRORS, &quot;OPTIONS ERROR: failed to negotiate &=
quot;</span><br><span>             &quot;cipher with server.  Add the serve=
r&#39;s &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     &quot;cipher (&#39;%s&#39;) to --data-ciphers (currently &#39;%s&#39;)=
 if &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 &quot;you want to connect to this server.&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;cipher (&#39;%s&#39;) to --=
data-ciphers (currently &#39;%s&#39;), e.g.&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;--data-ciphers %s:%s if you=
 want to connect to this server.&quot;,</span><br><span>             c-&gt;=
c2.tls_multi-&gt;remote_ciphername,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            c-&gt;options.ncp_ciphers);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            c-&gt;options.ncp_ciphers_con=
f, c-&gt;options.ncp_ciphers_conf,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            c-&gt;c2.tls_multi-&gt;remote_ciphername);</span=
><br><span>         return false;</span><br><span> </span><br><span>     }<=
/span><br><span>@@ -516,10 +518,13 @@</span><br><span>     if (!session-&gt=
;opt-&gt;server &amp;&amp; !cipher_allowed_as_fallback</span><br><span>    =
     &amp;&amp; !tls_item_in_cipher_list(options-&gt;ciphername, options-&g=
t;ncp_ciphers))</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(D_TLS_ERRORS, &quot;Error: negotiated cipher n=
ot allowed - %s not in %s&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            options-&gt;ciphername, options-&gt;ncp_ciphers);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(D_TLS_ERRORS, &quot;Error: negotiated cipher not allowed - %s no=
t in %s%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         options-&gt;ciphername, options-&gt;ncp_ciphers_conf,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            ncp_expanded_ciphers=
(options, &amp;gc));</span><br><span>         /* undo cipher push, abort co=
nnection setup */</span><br><span>         options-&gt;ciphername =3D sessi=
on-&gt;opt-&gt;config_ciphername;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        gc_free(&amp;gc);</span><br><span>         return fal=
se;</span><br><span>     }</span><br><span>     else</span><br><span>@@ -52=
7,3 +532,99 @@</span><br><span>         return true;</span><br><span>     }=
</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Replaces the string DEFAULT with=
 the string \param replace. The</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param o         Options struct to modify and to use the gc =
from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param repla=
ce   string used to replace the DEFAULT string</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+replace_default_in_ncp_ciphers_option(struct options *o, const char *rep=
lace)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *search =3D &quot=
;DEFAULT&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const int ncp_ciphers_len =3D strlen(o-&gt;ncp_ciphers) + strlen(replace) -=
 strlen(search) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *ncp_c=
iphers =3D gc_malloc(ncp_ciphers_len, true, &amp;o-&gt;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer ncp_ciphers_buf;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    buf_set_write(&amp;ncp_ciphers_buf,=
 ncp_ciphers, ncp_ciphers_len);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *def =3D strstr(o-&gt;ncp_ciphers, search);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Copy everything before the DEFAULT string */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;ncp_ciphe=
rs_buf, o-&gt;ncp_ciphers, def - o-&gt;ncp_ciphers);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* copy the default string. */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buf_write(&amp;ncp_ciphers_buf, replace, =
strlen(replace));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* copy the rest =
of the ncp cipher string */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *after_default =3D def + strlen(search);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;ncp_ciphers_=
buf, after_default, strlen(after_default));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    o-&gt;ncp_ciphers =3D (char *) ncp_ciphers;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Checks for avail=
ibility of Chacha20-Poly1305 and sets</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * the ncp_cipher to either AES-256-GCM:AES-128-GCM or</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * AES-256-GCM:AES-128=
-GCM:CHACHA20-POLY1305.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+options_postprocess_setdefa=
ult_ncpciphers(struct options *o)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
bool default_in_cipher_list =3D o-&gt;ncp_ciphers</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                  &amp;&amp; =
tls_item_in_cipher_list(&quot;DEFAULT&quot;, o-&gt;ncp_ciphers);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* preserve the values that the user put into=
 the configuration */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    o-&gt;ncp_ciphers_conf =3D o-&gt;ncp_ciphers;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* check if crypto library supports chacha */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool can_do_chacha =3D cip=
her_valid(&quot;CHACHA20-POLY1305&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (can_do_chacha &amp;&amp; dco_enabled(o))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* also make sure that dco supports chacha */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        can_do_chacha=
 =3D tls_item_in_cipher_list(&quot;CHACHA20-POLY1305&quot;, dco_get_support=
ed_ciphers());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *default_ciphers =3D &q=
uot;AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!can_do_chacha)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        default_ciphers =3D &quot;AES-256-GCM:AES-128-GCM&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* want to rather print DEFAULT instead of a manually =
set default list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!o-&gt;ncp_ciphers_conf || !strcmp(default_ciphers, o-&gt;ncp_ciphe=
rs_conf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;ncp_cipher=
s =3D default_ciphers;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        o-&gt;ncp_ciphers_conf =3D &quot;DEFAULT&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (!default_in_cipher_list)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* custom cipher list without DEFAULT =
string in it,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * nothing to replace/mutate */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        replace_default_in_nc=
p_ciphers_option(o, default_ciphers);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+const char *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ncp_expanded_ciphers(struct options *o, =
struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!strcmp(o=
-&gt;ncp_ciphers, o-&gt;ncp_ciphers_conf))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* expanded ciphers and user set ciphers are identical, no=
 need to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
add an expanded version */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return &quot;&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* two extra =
brackets, one space, NUL byte */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer expanded_ciphers_buf =3D alloc_buf_gc(strlen=
(o-&gt;ncp_ciphers) + 4, gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_p=
rintf(&amp;expanded_ciphers_buf, &quot; (%s)&quot;, o-&gt;ncp_ciphers);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return BSTR(&amp;ex=
panded_ciphers_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span>diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp=
.h</span><br><span>index afbe331..2378221 100644</span><br><span>--- a/src/=
openvpn/ssl_ncp.h</span><br><span>+++ b/src/openvpn/ssl_ncp.h</span><br><sp=
an>@@ -156,4 +156,24 @@</span><br><span> bool</span><br><span> check_sessio=
n_cipher(struct tls_session *session, struct options *options);</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Checks for availability of=
 Chacha20-Poly1305 and sets</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * the ncp_cipher to either AES-256-GCM:AES-128-GCM or</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * AES-256-GCM:AES-128-GCM:CHACH=
A20-POLY1305 if not set.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If DEFAUL=
T is in the ncp_cipher string, it will be replaced</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * by the default cipher string as defined a=
bove.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+options_postprocess_setdefault_ncpciphers(str=
uct options *o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/** returns the o-&gt;=
ncp_ciphers in brackets, e.g.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  (AES-256-GCM:CHACHA20-POLY1305) if o-&gt;ncp_ciphers_conf</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  and o-&gt;ncp_ciphe=
rs differ, otherwise an empty string</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  The returned string will be allocated in the passed \param gc</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ncp_expanded_ciphers(struct options *o, struct gc_arena *gc);</span><=
br><span> #endif /* ifndef OPENVPN_SSL_NCP_H */</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c=
</span><br><span>index a8e1021..0b763e4 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_ncp.c</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_ncp.c</span><br><span>@@ -54,6 +54,17 @@</span><br><span>     ASSERT=
(0);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Define a dummy dco cipher option to avoid linking against all the DCO=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * units */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dco_get_supported_ciphers(void=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return &quot;AES-192-GCM:AES-128=
-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> static void</span><br><span> test_check_ncp_ciphers_li=
st(void **state)</span><br><span> {</span><br><span>@@ -260,13 +271,128 @@<=
/span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_ncp_default(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool have_chacha =3D cipher_va=
lid(&quot;CHACHA20-POLY1305&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct options o =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o.gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* no user specified =
string */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o.ncp_=
ciphers =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  options_postprocess_setdefault_ncpciphers(&amp;o);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (have_chacha)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        assert_string_equal(o.ncp_ciphers, &quot;AES-256-GCM:AES-128-GCM:=
CHACHA20-POLY1305&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        assert_string_equal(o.ncp=
_ciphers, &quot;AES-256-GCM:AES-128-GCM&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_string_equal(o.ncp_ciphers_conf, &quot;DEFAULT&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* check that a default string=
 is replaced with DEFAULT */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (have_chacha)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    o.ncp_ciphers =3D &quot;AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        o.ncp_ciphers =3D &quot;AES-256-GCM:AES-128-GCM=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    options_postprocess_setdefault_ncpciphers=
(&amp;o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_string_equal(o.ncp_ciphers_conf, &quot;DEFAULT&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* test default in the middle of the string */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    o.ncp_ciphers =3D &quot=
;BF-CBC:DEFAULT:AES-128-CBC:AES-256-CBC&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    options_postprocess_setdefault_ncpciphers(&a=
mp;o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (have_chacha)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        assert_string_equal(o.ncp_ciphers, &q=
uot;BF-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305:AES-128-CBC:AES-256-CB=
C&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        assert_string_equal(o.ncp_ciphers, &quot;=
BF-CBC:AES-256-GCM:AES-128-GCM:AES-128-CBC:AES-256-CBC&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(o.ncp_ciphers_conf, &q=
uot;BF-CBC:DEFAULT:AES-128-CBC:AES-256-CBC&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* string at the beginning */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    o.ncp_ciphers =3D &quot;DEFAULT:AES-128-CBC:A=
ES-192-CBC&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  options_postprocess_setdefault_ncpciphers(&amp;o);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (have_chacha)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        assert_string_equal(o.ncp_ciphers, &quot;AES-256-GCM:AES-128-GCM:=
CHACHA20-POLY1305:AES-128-CBC:AES-192-CBC&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
ssert_string_equal(o.ncp_ciphers, &quot;AES-256-GCM:AES-128-GCM:AES-128-CBC=
:AES-192-CBC&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(o.ncp_ciphers_conf, &quot;DEFAULT:AES-128-CBC:AES-192-CBC&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* DEFAULT at the end */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    o.ncp_ciphers =3D &quot;=
AES-192-GCM:AES-128-CBC:DEFAULT&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    options_postprocess_setdefault_ncpciphers(&amp;o);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (have_chacha)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        assert_string_equal(o.ncp_ciphers, &quot;AES-=
192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        assert_string_equal(o.ncp_ciphers, &quot;AES-192-GCM:AES=
-128-CBC:AES-256-GCM:AES-128-GCM&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_string_equal(o.ncp_ciphers_conf, &quot;AES-192-GCM:AES-12=
8-CBC:DEFAULT&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;=
o.gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_ncp_expand(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool have_chacha =3D cipher_valid(&quot;CHACHA20-POLY1305&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct optio=
ns o =3D {0};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    o.gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* no user specified=
 string */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o.ncp=
_ciphers =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   options_postprocess_setdefault_ncpciphers(&amp;o);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *expanded =3D ncp_expanded_ciphers(&amp;o, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (have_chacha)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        assert_string_equal(expanded, &quot;=
 (AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305)&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   assert_string_equal(expanded, &quot; (AES-256-GCM:AES-128-GCM)&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    o.ncp_ciphers =3D &quot;AES-192-GCM:BF-CBC&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    options_postproc=
ess_setdefault_ncpciphers(&amp;o);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(ncp_expanded_ciphers(&amp;o, &amp;gc), &quot;&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;o.gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><spa=
n> </span><br><span> const struct CMUnitTest ncp_tests[] =3D {</span><br><s=
pan>     cmocka_unit_test(test_check_ncp_ciphers_list),</span><br><span>   =
  cmocka_unit_test(test_extract_client_ciphers),</span><br><span>     cmock=
a_unit_test(test_poor_man),</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    cmocka_unit_test(test_ncp_best)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    cmocka_unit_test(test_ncp_best),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_ncp_defaul=
t),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_=
test(test_ncp_expand),</span><br><span> };</span><br><span> </span><br><spa=
n> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/828?usp=3Demail">change 828</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/828?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia1c5209022d3ab4c0dac6438c41=
891c7d059f812 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 828 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--GVeQOrMu33c=--

