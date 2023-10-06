From: Arne Schwabe <arne@...1227...>
Date: Fri,  6 Oct 2023 13:19:10 +0200
Message-Id: <20231006111910.3541180-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove openssl engine method for loading
 the key
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

This is a contribution for loading engine key. OpenSSL engine is
deprecated since OpenSSL 3.0 and James Bottomlehy has not agreed
to the proposed license chagne. He is also okay with removing
with the feature from the current code base as it is obsolete with
OpenSSL 3.0.

Change-Id: I2d353a0cea0a62f289b8c1060244df66dd7a14cb
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .gitignore                                    |   4 -
 configure.ac                                  |   1 -
 src/openvpn/crypto_openssl.c                  |  60 ---------
 src/openvpn/crypto_openssl.h                  |  12 --
 src/openvpn/ssl_openssl.c                     |   4 -
 tests/unit_tests/Makefile.am                  |   3 -
 tests/unit_tests/engine-key/Makefile.am       |  31 -----
 .../engine-key/check_engine_keys.sh           |  36 ------
 tests/unit_tests/engine-key/libtestengine.c   | 116 ------------------
 tests/unit_tests/engine-key/openssl.cnf.in    |  12 --
 10 files changed, 279 deletions(-)
 delete mode 100644 tests/unit_tests/engine-key/Makefile.am
 delete mode 100755 tests/unit_tests/engine-key/check_engine_keys.sh
 delete mode 100644 tests/unit_tests/engine-key/libtestengine.c
 delete mode 100644 tests/unit_tests/engine-key/openssl.cnf.in

diff --git a/.gitignore b/.gitignore
index ed03aaa95..a1da36672 100644
--- a/.gitignore
+++ b/.gitignore
@@ -57,10 +57,6 @@ tests/t_client-*-20??????-??????/
 t_client.rc
 t_client_ips.rc
 tests/unit_tests/**/*_testdriver
-tests/unit_tests/engine-key/client.key
-tests/unit_tests/engine-key/log.txt
-tests/unit_tests/engine-key/openssl.cnf
-tests/unit_tests/engine-key/passwd
 
 src/openvpn/openvpn
 include/openvpn-plugin.h
diff --git a/configure.ac b/configure.ac
index 266b66f0f..128ab86f7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1532,7 +1532,6 @@ AC_CONFIG_FILES([
         tests/unit_tests/openvpn/Makefile
         tests/unit_tests/plugins/Makefile
         tests/unit_tests/plugins/auth-pam/Makefile
-	tests/unit_tests/engine-key/Makefile
 	sample/Makefile
 ])
 AC_CONFIG_FILES([tests/t_client.sh], [chmod +x tests/t_client.sh])
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 22c6d6840..fe1254f89 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1374,66 +1374,6 @@ memcmp_constant_time(const void *a, const void *b, size_t size)
     return CRYPTO_memcmp(a, b, size);
 }
 
-#if HAVE_OPENSSL_ENGINE
-static int
-ui_reader(UI *ui, UI_STRING *uis)
-{
-    SSL_CTX *ctx = UI_get0_user_data(ui);
-
-    if (UI_get_string_type(uis) == UIT_PROMPT)
-    {
-        pem_password_cb *cb = SSL_CTX_get_default_passwd_cb(ctx);
-        void *d = SSL_CTX_get_default_passwd_cb_userdata(ctx);
-        char password[64];
-
-        cb(password, sizeof(password), 0, d);
-        UI_set_result(ui, uis, password);
-
-        return 1;
-    }
-    return 0;
-}
-#endif
-
-EVP_PKEY *
-engine_load_key(const char *file, SSL_CTX *ctx)
-{
-#if HAVE_OPENSSL_ENGINE
-    UI_METHOD *ui;
-    EVP_PKEY *pkey;
-
-    if (!engine_persist)
-    {
-        return NULL;
-    }
-
-    /* this will print out the error from BIO_read */
-    crypto_msg(M_INFO, "PEM_read_bio failed, now trying engine method to load private key");
-
-    ui = UI_create_method("openvpn");
-    if (!ui)
-    {
-        crypto_msg(M_FATAL, "Engine UI creation failed");
-        return NULL;
-    }
-
-    UI_method_set_reader(ui, ui_reader);
-
-    ENGINE_init(engine_persist);
-    pkey = ENGINE_load_private_key(engine_persist, file, ui, ctx);
-    ENGINE_finish(engine_persist);
-    if (!pkey)
-    {
-        crypto_msg(M_FATAL, "Engine could not load key file");
-    }
-
-    UI_destroy_method(ui);
-    return pkey;
-#else  /* if HAVE_OPENSSL_ENGINE */
-    return NULL;
-#endif /* if HAVE_OPENSSL_ENGINE */
-}
-
 #if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(LIBRESSL_VERSION_NUMBER)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 32849fd3f..c5a539345 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -118,16 +118,4 @@ void crypto_print_openssl_errors(const unsigned int flags);
         msg((flags), __VA_ARGS__); \
     } while (false)
 
-/**
- * Load a key file from an engine
- *
- * @param file  The engine file to load
- * @param ui    The UI method for the password prompt
- * @param data  The data to pass to the UI method
- *
- * @return      The private key if successful or NULL if not
- */
-EVP_PKEY *
-engine_load_key(const char *file, SSL_CTX *ctx);
-
 #endif /* CRYPTO_OPENSSL_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b5cc9a7f1..3548cd5d6 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1057,10 +1057,6 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
     pkey = PEM_read_bio_PrivateKey(in, NULL,
                                    SSL_CTX_get_default_passwd_cb(ctx->ctx),
                                    SSL_CTX_get_default_passwd_cb_userdata(ctx->ctx));
-    if (!pkey)
-    {
-        pkey = engine_load_key(priv_key_file, ctx->ctx);
-    }
 
     if (!pkey || !SSL_CTX_use_PrivateKey(ssl_ctx, pkey))
     {
diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index f27cd90fd..33fefaacb 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -2,7 +2,4 @@ AUTOMAKE_OPTIONS = foreign
 
 if ENABLE_UNITTESTS
 SUBDIRS = example_test openvpn plugins
-if OPENSSL_ENGINE
-SUBDIRS += engine-key
-endif
 endif
diff --git a/tests/unit_tests/engine-key/Makefile.am b/tests/unit_tests/engine-key/Makefile.am
deleted file mode 100644
index 0c2888576..000000000
--- a/tests/unit_tests/engine-key/Makefile.am
+++ /dev/null
@@ -1,31 +0,0 @@
-AUTOMAKE_OPTIONS = foreign
-
-check_LTLIBRARIES = libtestengine.la
-conffiles = openssl.cnf
-EXTRA_DIST = \
-	openssl.cnf.in \
-	check_engine_keys.sh
-
-TESTS_ENVIRONMENT = srcdir="$(abs_srcdir)"; \
-	builddir="$(abs_builddir)"; \
-	top_builddir="$(top_builddir)"; \
-	top_srcdir="$(top_srcdir)"; \
-	export srcdir builddir top_builddir top_srcdir;
-
-if !CROSS_COMPILING
-TESTS = check_engine_keys.sh
-endif
-check_engine_keys.sh: $(conffiles)
-
-CLEANFILES = \
-	client.key \
-	passwd \
-	log.txt \
-	$(conffiles)
-
-openssl.cnf: $(srcdir)/openssl.cnf.in
-	sed "s|ABSBUILDDIR|$(abs_builddir)|" < $(srcdir)/openssl.cnf.in > $@
-
-libtestengine_la_SOURCES = libtestengine.c
-libtestengine_la_LDFLAGS = @TEST_LDFLAGS@ -rpath /lib -shrext .so
-libtestengine_la_CFLAGS = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
diff --git a/tests/unit_tests/engine-key/check_engine_keys.sh b/tests/unit_tests/engine-key/check_engine_keys.sh
deleted file mode 100755
index 12dd23017..000000000
--- a/tests/unit_tests/engine-key/check_engine_keys.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-
-OPENSSL_CONF="${builddir}/openssl.cnf"
-export OPENSSL_CONF
-
-password='AT3S4PASSWD'
-
-key="${builddir}/client.key"
-pwdfile="${builddir}/passwd"
-
-# create an engine key for us
-sed 's/PRIVATE KEY/TEST ENGINE KEY/' < ${top_srcdir}/sample/sample-keys/client.key > ${key}
-echo "$password" > $pwdfile
-
-# our version of grep to output log.txt on failure in case it's an openssl
-# error mismatch and the grep expression needs updating
-loggrep() {
-    egrep -q "$1" log.txt || { echo '---- begin log.txt ----'; cat log.txt; echo '--- end log.txt ---'; return 1; }
-}
-
-# note here we've induced a mismatch in the client key and the server
-# cert which openvpn should report and die.  Check that it does.  Note
-# also that this mismatch depends on openssl not openvpn, so it is
-# somewhat fragile
-${top_builddir}/src/openvpn/openvpn --cd ${top_srcdir}/sample --config sample-config-files/loopback-server --engine testengine --key ${key} --askpass $pwdfile > log.txt 2>&1
-
-# first off check we died because of a key mismatch.  If this doesn't
-# pass, suspect openssl of returning different messages and update the
-# test accordingly
-loggrep '(x509 certificate routines:(X509_check_private_key)?:key values mismatch|func\(128\):reason\(116\))' log.txt || { echo "Key mismatch not detected"; exit 1; }
-
-# now look for the engine prints (these are under our control)
-loggrep 'ENGINE: engine_init called' || { echo "Engine initialization not detected"; exit 1; }
-loggrep 'ENGINE: engine_load_key called' || { echo "Key was not loaded from engine"; exit 1; }
-loggrep "ENGINE: engine_load_key got password ${password}" || { echo "Key password was not retrieved by the engine"; exit 1; }
-exit 0
diff --git a/tests/unit_tests/engine-key/libtestengine.c b/tests/unit_tests/engine-key/libtestengine.c
deleted file mode 100644
index 8bcfa92ed..000000000
--- a/tests/unit_tests/engine-key/libtestengine.c
+++ /dev/null
@@ -1,116 +0,0 @@
-#include <string.h>
-#include <openssl/engine.h>
-#include <openssl/evp.h>
-#include <openssl/pem.h>
-
-static char *engine_id = "testengine";
-static char *engine_name = "Engine for testing openvpn engine key support";
-
-static int is_initialized = 0;
-
-static int
-engine_init(ENGINE *e)
-{
-    is_initialized = 1;
-    fprintf(stderr, "ENGINE: engine_init called\n");
-    return 1;
-}
-
-static int
-engine_finish(ENGINE *e)
-{
-    fprintf(stderr, "ENGINE: engine_finsh called\n");
-    is_initialized = 0;
-    return 1;
-}
-
-static EVP_PKEY *
-engine_load_key(ENGINE *e, const char *key_id,
-                UI_METHOD *ui_method, void *cb_data)
-{
-    BIO *b;
-    EVP_PKEY *pkey;
-    PKCS8_PRIV_KEY_INFO *p8inf;
-    UI *ui;
-    char auth[256];
-
-    fprintf(stderr, "ENGINE: engine_load_key called\n");
-
-    if (!is_initialized)
-    {
-        fprintf(stderr, "Load Key called without correct initialization\n");
-        return NULL;
-    }
-    b = BIO_new_file(key_id, "r");
-    if (!b)
-    {
-        fprintf(stderr, "File %s does not exist or cannot be read\n", key_id);
-        return 0;
-    }
-    /* Basically read an EVP_PKEY private key file with different
-     * PEM guards --- we are a test engine */
-    p8inf = PEM_ASN1_read_bio((d2i_of_void *)d2i_PKCS8_PRIV_KEY_INFO,
-                              "TEST ENGINE KEY", b,
-                              NULL, NULL, NULL);
-    BIO_free(b);
-    if (!p8inf)
-    {
-        fprintf(stderr, "Failed to read engine private key\n");
-        return NULL;
-    }
-    pkey = EVP_PKCS82PKEY(p8inf);
-
-    /* now we have a private key, pretend it had a password
-     * this verifies the password makes it through openvpn OK */
-    ui = UI_new();
-
-    if (ui_method)
-    {
-        UI_set_method(ui, ui_method);
-    }
-
-    UI_add_user_data(ui, cb_data);
-
-    if (UI_add_input_string(ui, "enter test engine key",
-                            UI_INPUT_FLAG_DEFAULT_PWD,
-                            auth, 0, sizeof(auth)) == 0)
-    {
-        fprintf(stderr, "UI_add_input_string failed\n");
-        goto out;
-    }
-
-    if (UI_process(ui))
-    {
-        fprintf(stderr, "UI_process failed\n");
-        goto out;
-    }
-
-    fprintf(stderr, "ENGINE: engine_load_key got password %s\n", auth);
-
-out:
-    UI_free(ui);
-
-    return pkey;
-}
-
-
-static int
-engine_bind_fn(ENGINE *e, const char *id)
-{
-    if (id && strcmp(id, engine_id) != 0)
-    {
-        return 0;
-    }
-    if (!ENGINE_set_id(e, engine_id)
-        || !ENGINE_set_name(e, engine_name)
-        || !ENGINE_set_init_function(e, engine_init)
-        || !ENGINE_set_finish_function(e, engine_finish)
-        || !ENGINE_set_load_privkey_function(e, engine_load_key))
-    {
-        return 0;
-    }
-    return 1;
-}
-
-IMPLEMENT_DYNAMIC_CHECK_FN()
-IMPLEMENT_DYNAMIC_BIND_FN(engine_bind_fn)
diff --git a/tests/unit_tests/engine-key/openssl.cnf.in b/tests/unit_tests/engine-key/openssl.cnf.in
deleted file mode 100644
index 5eda9fa94..000000000
--- a/tests/unit_tests/engine-key/openssl.cnf.in
+++ /dev/null
@@ -1,12 +0,0 @@
-HOME		= .
-openssl_conf	= openssl_init
-
-[req]
-[openssl_init]
-engines		= engines_section
-
-[engines_section]
-testengine	= testengine_section
-
-[testengine_section]
-dynamic_path	= ABSBUILDDIR/.libs/libtestengine.so
-- 
2.39.3 (Apple Git-145)


