From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 19 Dec 2025 14:51:10 +0100
Message-ID: <20251219135110.166468-1-frank@...2641...>
In-Reply-To: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
References: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] Allow test-crypto to work without the
 --secret argument
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

The --test-crypto still requires the --secret argument. Since --secret
will be removed in OpenVPN 2.8 but we want to keep test-crypt, remove
the dependency of test-crypto on --static.

Instead we will just generate a random key for this selftest method.
This also removes the extra logic that is a leftover from the early
multi-thread implementation attempt.

Change-Id: I72947bd4f0213fd118327f740daeb1d86ae166de
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1435
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1435
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/Changes.rst b/Changes.rst
index 048434d..c8a3058 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -343,6 +343,10 @@
   loading for key/cert files with non-ASCII characters in their file names
   (GH: OpenVPN/openvpn#920).
 
+- The ``test-crypto`` option no longer requires a ``--secret`` argument and
+  will automatically generate a random key.
+
+
 Deprecated features
 -------------------
 ``--opt-verify`` feature removed
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index a9232ce..ed581b1 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -427,13 +427,13 @@
   The typical usage of ``--test-crypto`` would be something like this:
   ::
 
-     openvpn --test-crypto --secret key
+     openvpn --test-crypto
 
   or
 
   ::
 
-     openvpn --test-crypto --secret key --verb 9
+     openvpn --test-crypto --verb 9
 
   This option is very useful to test OpenVPN after it has been ported to a
   new platform, or to isolate problems in the compiler, OpenSSL crypto
@@ -441,6 +441,10 @@
   problems with encryption and authentication can be debugged
   independently of network and tunnel issues.
 
+  Older versions of OpenVPN used the ``--secret`` argument to specify a
+  static key for this test. Newer version generate a random key for the
+  test.
+
 --tmp-dir dir
   Specify a directory ``dir`` for temporary files instead of the default
   :code:`TMPDIR` (or "/tmp" if unset). Note that it must be writable by the main
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e43bc6c..ddf3c17 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1325,6 +1325,18 @@
     secure_memzero(&key2, sizeof(key2));
 }
 
+void
+generate_test_crypto_random_key(const struct key_type *key_type, struct key_ctx_bi *ctx,
+                                const char *key_name)
+{
+    struct key2 key2;
+    key2.n = 2;
+    generate_key_random(&key2.keys[0]);
+    generate_key_random(&key2.keys[1]);
+    init_key_ctx_bi(ctx, &key2, KEY_DIRECTION_BIDIRECTIONAL, key_type, key_name);
+}
+
+
 /* header and footer for static key file */
 static const char static_key_head[] = "-----BEGIN OpenVPN Static key V1-----";
 static const char static_key_foot[] = "-----END OpenVPN Static key V1-----";
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 9424fd7..6670deb 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -632,6 +632,13 @@
                              const char *key_file, bool key_inline, const int key_direction,
                              const char *key_name, const char *opt_name, struct key2 *keydata);
 
+/**
+ * Generate a random key and initialise ctx to be used the in the crypto random
+ * test
+ */
+void generate_test_crypto_random_key(const struct key_type *key_type, struct key_ctx_bi *ctx,
+                                     const char *key_name);
+
 /*
  * Inline functions
  */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ee198ce..c0e4418 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2998,6 +2998,34 @@
 #endif
 }
 
+
+static void
+do_init_crypto_test(struct context *c)
+{
+    const struct options *options = &c->options;
+    ASSERT(options->test_crypto);
+
+    init_crypto_pre(c, 0);
+
+    c->c2.crypto_options.flags |= CO_PACKET_ID_LONG_FORM;
+
+    /* Initialize packet ID tracking */
+    packet_id_init(&c->c2.crypto_options.packet_id, options->replay_window, options->replay_time,
+                   "STATIC", 0);
+
+    ASSERT(!key_ctx_bi_defined(&c->c1.ks.static_key));
+
+    /* Init cipher and hash algorithm */
+    init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
+                  options->test_crypto, true);
+
+    generate_test_crypto_random_key(&c->c1.ks.key_type, &c->c1.ks.static_key,
+                                    "test crypto key");
+
+    /* Get key schedule */
+    c->c2.crypto_options.key_ctx_bi = c->c1.ks.static_key;
+}
+
 /*
  * Static Key Mode (using a pre-shared key)
  */
@@ -5003,17 +5031,18 @@
  * Do a loopback test
  * on the crypto subsystem.
  */
-static void *
-test_crypto_thread(void *arg)
+void
+do_test_crypto(struct context *c)
 {
-    struct context *c = (struct context *)arg;
+    /* print version number */
+    msg(M_INFO, "%s", title_string);
     const struct options *options = &c->options;
 
     ASSERT(options->test_crypto);
     init_verb_mute(c, IVM_LEVEL_1);
     context_init_1(c);
     next_connection_entry(c);
-    do_init_crypto_static(c, 0);
+    do_init_crypto_test(c);
 
     frame_finalize_options(c, options);
 
@@ -5023,25 +5052,4 @@
     packet_id_free(&c->c2.crypto_options.packet_id);
 
     context_gc_free(c);
-    return NULL;
-}
-
-bool
-do_test_crypto(const struct options *o)
-{
-    if (o->test_crypto)
-    {
-        struct context c;
-
-        /* print version number */
-        msg(M_INFO, "%s", title_string);
-
-        context_clear(&c);
-        c.options = *o;
-        options_detach(&c.options);
-        c.first_time = true;
-        test_crypto_thread((void *)&c);
-        return true;
-    }
-    return false;
-}
+}
\ No newline at end of file
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 97318ec..d5c8c04 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -71,7 +71,7 @@
 
 void close_instance(struct context *c);
 
-bool do_test_crypto(const struct options *o);
+void do_test_crypto(struct context *o);
 
 void context_gc_free(struct context *c);
 
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index eaaa59b..0c22e27 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -258,8 +258,9 @@
             pre_setup(&c.options);
 
             /* test crypto? */
-            if (do_test_crypto(&c.options))
+            if (c.options.test_crypto)
             {
+                do_test_crypto(&c);
                 break;
             }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 34af0d3..22ec7fe 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2276,11 +2276,7 @@
 
     init_options(&defaults, true);
 
-    if (options->test_crypto)
-    {
-        notnull(options->shared_secret_file, "key file (--secret)");
-    }
-    else
+    if (!options->test_crypto)
     {
         notnull(options->dev, "TUN/TAP device (--dev)");
     }
@@ -2694,7 +2690,7 @@
         msg(M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
     }
 
-    if (!options->tls_server && !options->tls_client)
+    if (!options->tls_server && !options->tls_client && !options->test_crypto)
     {
         msglvl_t msglevel = M_USAGE;
         if (options->allow_deprecated_insecure_static_crypto)
diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 8ab3973..6802506 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -89,13 +89,12 @@
 # Also test cipher 'none'
 CIPHERS=${CIPHERS}$(printf "\nnone")
 
-"${openvpn}" --genkey secret key.$$
 set +e
 
 for cipher in ${CIPHERS}
 do
     test_start "Testing cipher ${cipher}... "
-    ( "${openvpn}" --test-crypto --secret key.$$  --allow-deprecated-insecure-static-crypto --cipher ${cipher} ) >log.$$ 2>&1
+    ( "${openvpn}" --test-crypto --cipher ${cipher} ) >log.$$ 2>&1
     test_end $? log.$$
 done
 
@@ -126,6 +125,6 @@
     echo "$0: tests passed: $tests_passed  failed: $tests_failed"
 fi
 
-rm key.$$ tc-server-key.$$ tc-client-key.$$ log.$$
+rm tc-server-key.$$ tc-client-key.$$ log.$$
 trap 0
 exit $e

