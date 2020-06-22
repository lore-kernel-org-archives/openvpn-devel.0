From: James Bottomley <James.Bottomley@...2316...>
Date: Mon, 22 Jun 2020 16:23:19 -0700
Message-Id: <20200622232319.8143-2-James.Bottomley@...2316...>
In-Reply-To: <20200622232319.8143-1-James.Bottomley@...2316...>
References: <20200622232319.8143-1-James.Bottomley@...2316...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v8 1/1] Add unit tests for engine keys
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

Testing engines is problematic, so one of the prerequisites built for
the tests is a simple openssl engine that reads a non-standard PEM
guarded key.  The test is simply can we run a client/server
configuration with the usual sample key replaced by an engine key.
The trivial engine prints out some operations and we check for these
in the log to make sure the engine was used to load the key and that
it correctly got the password.

Signed-off-by: James Bottomley <James.Bottomley@...2316...>

---
v8: Fix openssl.cnf.in build rule for BSD
v7: Hard code .so for dll
v6: add absolute path instead of env variable in openssl.cnf (MacOS)
v5: do not hard code dynamic library extension into openssl.cnf (MacOS)
v4: add OPENSSL_config(NULL) so debian checks will work
v3: added this patch
---
 configure.ac                                  |   2 +
 tests/unit_tests/Makefile.am                  |   3 +
 tests/unit_tests/engine-key/Makefile.am       |  24 +++++
 .../engine-key/check_engine_keys.sh           |  30 ++++++
 tests/unit_tests/engine-key/libtestengine.c   | 101 ++++++++++++++++++
 tests/unit_tests/engine-key/openssl.cnf.in    |  12 +++
 6 files changed, 172 insertions(+)
 create mode 100644 tests/unit_tests/engine-key/Makefile.am
 create mode 100755 tests/unit_tests/engine-key/check_engine_keys.sh
 create mode 100644 tests/unit_tests/engine-key/libtestengine.c
 create mode 100644 tests/unit_tests/engine-key/openssl.cnf.in

diff --git a/configure.ac b/configure.ac
index 273a8d1b..53b7a967 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1387,6 +1387,7 @@ AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "yes"])
 AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" = "yes"])
+AM_CONDITIONAL([OPENSSL_ENGINE], [test "${have_openssl_engine}" = "yes"])
 
 sampledir="\$(docdir)/sample"
 AC_SUBST([plugindir])
@@ -1448,6 +1449,7 @@ AC_CONFIG_FILES([
         tests/unit_tests/openvpn/Makefile
         tests/unit_tests/plugins/Makefile
         tests/unit_tests/plugins/auth-pam/Makefile
+	tests/unit_tests/engine-key/Makefile
 	sample/Makefile
 ])
 AC_CONFIG_FILES([tests/t_client.sh], [chmod +x tests/t_client.sh])
diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index 33fefaac..f27cd90f 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -2,4 +2,7 @@ AUTOMAKE_OPTIONS = foreign
 
 if ENABLE_UNITTESTS
 SUBDIRS = example_test openvpn plugins
+if OPENSSL_ENGINE
+SUBDIRS += engine-key
+endif
 endif
diff --git a/tests/unit_tests/engine-key/Makefile.am b/tests/unit_tests/engine-key/Makefile.am
new file mode 100644
index 00000000..39bed743
--- /dev/null
+++ b/tests/unit_tests/engine-key/Makefile.am
@@ -0,0 +1,24 @@
+AUTOMAKE_OPTIONS = foreign
+
+check_LTLIBRARIES = libtestengine.la
+conffiles = openssl.cnf
+
+TESTS_ENVIRONMENT = srcdir="$(abs_srcdir)"; \
+	builddir="$(abs_builddir)"; \
+	top_builddir="$(top_builddir)"; \
+	top_srcdir="$(top_srcdir)"; \
+	export srcdir builddir top_builddir top_srcdir;
+
+TESTS = check_engine_keys.sh
+check_engine_keys.sh: $(conffiles)
+
+clean-local:
+	rm -f $(conffiles)
+
+$(builddir)/openssl.cnf: $(srcdir)/openssl.cnf.in
+	sed "s|ABSBUILDDIR|$(abs_builddir)|" < $< > $@
+
+libtestengine_la_SOURCES = libtestengine.c
+libtestengine_la_LDFLAGS = @TEST_LDFLAGS@ -rpath /lib -shrext .so
+libtestengine_la_CFLAGS = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
+
diff --git a/tests/unit_tests/engine-key/check_engine_keys.sh b/tests/unit_tests/engine-key/check_engine_keys.sh
new file mode 100755
index 00000000..e0c9d7b0
--- /dev/null
+++ b/tests/unit_tests/engine-key/check_engine_keys.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+OPENSSL_CONF="${builddir}/openssl.cnf"
+export OPENSSL_CONF
+
+password='AT3S4PASSWD'
+
+key="${builddir}/client.key"
+pwdfile="${builddir}/passwd"
+
+# create an engine key for us
+sed 's/PRIVATE KEY/TEST ENGINE KEY/' < ${top_srcdir}/sample/sample-keys/client.key > ${key}
+echo "$password" > $pwdfile
+
+# note here we've induced a mismatch in the client key and the server
+# cert which openvpn should report and die.  Check that it does.  Note
+# also that this mismatch depends on openssl not openvpn, so it is
+# somewhat fragile
+${top_builddir}/src/openvpn/openvpn --cd ${top_srcdir}/sample --config sample-config-files/loopback-server --engine testengine --key ${key} --askpass $pwdfile > log.txt 2>&1
+
+# first off check we died because of a key mismatch.  If this doesn't
+# pass, suspect openssl of returning different messages and update the
+# test accordingly
+grep -q 'X509_check_private_key:key values mismatch' log.txt || { echo "Key mismatch not detected"; exit 1; }
+
+# now look for the engine prints (these are under our control)
+grep -q 'ENGINE: engine_init called' log.txt || { echo "Engine initialization not detected"; exit 1; }
+grep -q 'ENGINE: engine_load_key called' log.txt || { echo "Key was not loaded from engine"; exit 1; }
+grep -q "ENGINE: engine_load_key got password ${password}" log.txt || { echo "Key password was not retrieved by the engine"; exit 1; }
+exit 0
diff --git a/tests/unit_tests/engine-key/libtestengine.c b/tests/unit_tests/engine-key/libtestengine.c
new file mode 100644
index 00000000..46ec1e33
--- /dev/null
+++ b/tests/unit_tests/engine-key/libtestengine.c
@@ -0,0 +1,101 @@
+#include <string.h>
+#include <openssl/engine.h>
+#include <openssl/evp.h>
+#include <openssl/pem.h>
+
+static char *engine_id = "testengine";
+static char *engine_name = "Engine for testing openvpn engine key support";
+
+static int is_initialized = 0;
+
+static int engine_init(ENGINE *e)
+{
+	is_initialized = 1;
+	fprintf(stderr, "ENGINE: engine_init called\n");
+	return 1;
+}
+
+static int engine_finish(ENGINE *e)
+{
+	fprintf(stderr, "ENGINE: engine_finsh called\n");
+	is_initialized = 0;
+	return 1;
+}
+
+static EVP_PKEY *engine_load_key(ENGINE *e, const char *key_id,
+				 UI_METHOD *ui_method, void *cb_data)
+{
+	BIO *b;
+	EVP_PKEY *pkey;
+	PKCS8_PRIV_KEY_INFO *p8inf;
+	UI *ui;
+	char auth[256];
+
+	fprintf(stderr, "ENGINE: engine_load_key called\n");
+
+	if (!is_initialized) {
+		fprintf(stderr, "Load Key called without correct initialization\n");
+		return NULL;
+	}
+	b = BIO_new_file(key_id, "r");
+	if (!b) {
+		fprintf(stderr, "File %s does not exist or cannot be read\n", key_id);
+		return 0;
+	}
+	/* Basically read an EVP_PKEY private key file with different
+	 * PEM guards --- we are a test engine */
+	p8inf = PEM_ASN1_read_bio((d2i_of_void *)d2i_PKCS8_PRIV_KEY_INFO,
+				 "TEST ENGINE KEY", b,
+				 NULL, NULL, NULL);
+	BIO_free(b);
+	if (!p8inf) {
+		fprintf(stderr, "Failed to read engine private key\n");
+		return NULL;
+	}
+	pkey = EVP_PKCS82PKEY(p8inf);
+
+	/* now we have a private key, pretend it had a password
+	 * this verifies the password makes it through openvpn OK */
+	ui = UI_new();
+
+	if (ui_method)
+		UI_set_method(ui, ui_method);
+
+	UI_add_user_data(ui, cb_data);
+
+	if (UI_add_input_string(ui, "enter test engine key",
+				UI_INPUT_FLAG_DEFAULT_PWD,
+				auth, 0, sizeof(auth)) == 0) {
+		fprintf(stderr, "UI_add_input_string failed\n");
+		goto out;
+	}
+
+	if (UI_process(ui)) {
+		fprintf(stderr, "UI_process failed\n");
+		goto out;
+	}
+
+	fprintf(stderr, "ENGINE: engine_load_key got password %s\n", auth);
+
+ out:
+	UI_free(ui);
+
+	return pkey;
+}
+
+
+static int engine_bind_fn(ENGINE *e, const char *id)
+{
+	if (id && strcmp(id, engine_id) != 0)
+		return 0;
+	if (!ENGINE_set_id(e, engine_id) ||
+	    !ENGINE_set_name(e, engine_name) ||
+	    !ENGINE_set_init_function(e, engine_init) ||
+	    !ENGINE_set_finish_function(e, engine_finish) ||
+	    !ENGINE_set_load_privkey_function(e, engine_load_key))
+		return 0;
+	return 1;
+}
+
+IMPLEMENT_DYNAMIC_CHECK_FN()
+IMPLEMENT_DYNAMIC_BIND_FN(engine_bind_fn)
diff --git a/tests/unit_tests/engine-key/openssl.cnf.in b/tests/unit_tests/engine-key/openssl.cnf.in
new file mode 100644
index 00000000..5eda9fa9
--- /dev/null
+++ b/tests/unit_tests/engine-key/openssl.cnf.in
@@ -0,0 +1,12 @@
+HOME		= .
+openssl_conf	= openssl_init
+
+[req]
+[openssl_init]
+engines		= engines_section
+
+[engines_section]
+testengine	= testengine_section
+
+[testengine_section]
+dynamic_path	= ABSBUILDDIR/.libs/libtestengine.so
-- 
2.26.2


