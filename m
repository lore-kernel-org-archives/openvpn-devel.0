From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 11:43:36 +0000
References: <gerrit.1697629414000.I2d353a0cea0a62f289b8c1060244df66dd7a14cb@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <8b4ada7c5b95cbdc9360a721a25529bf713f2189-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VNNov3b7ujw="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove openssl
 engine method for loading the key
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

--VNNov3b7ujw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/373?usp=3Demail

to review the following change.


Change subject: Remove openssl engine method for loading the key
......................................................................

Remove openssl engine method for loading the key

This is a contribution for loading engine key. OpenSSL engine is
deprecated since OpenSSL 3.0 and James Bottomlehy has not agreed
to the proposed license chagne. He is also okay with removing
with the feature from the current code base as it is obsolete with
OpenSSL 3.0.

Change-Id: I2d353a0cea0a62f289b8c1060244df66dd7a14cb
---
M .gitignore
M configure.ac
M src/openvpn/crypto_openssl.c
M src/openvpn/crypto_openssl.h
M src/openvpn/ssl_openssl.c
M tests/unit_tests/Makefile.am
D tests/unit_tests/engine-key/Makefile.am
D tests/unit_tests/engine-key/check_engine_keys.sh
D tests/unit_tests/engine-key/libtestengine.c
D tests/unit_tests/engine-key/openssl.cnf.in
10 files changed, 0 insertions(+), 279 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/373/1

diff --git a/.gitignore b/.gitignore
index ed03aaa..a1da366 100644
--- a/.gitignore
+++ b/.gitignore
@@ -57,10 +57,6 @@
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
index 266b66f..128ab86 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1532,7 +1532,6 @@
         tests/unit_tests/openvpn/Makefile
         tests/unit_tests/plugins/Makefile
         tests/unit_tests/plugins/auth-pam/Makefile
-	tests/unit_tests/engine-key/Makefile
 	sample/Makefile
 ])
 AC_CONFIG_FILES([tests/t_client.sh], [chmod +x tests/t_client.sh])
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 22c6d68..fe1254f 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1374,66 +1374,6 @@
     return CRYPTO_memcmp(a, b, size);
 }

-#if HAVE_OPENSSL_ENGINE
-static int
-ui_reader(UI *ui, UI_STRING *uis)
-{
-    SSL_CTX *ctx =3D UI_get0_user_data(ui);
-
-    if (UI_get_string_type(uis) =3D=3D UIT_PROMPT)
-    {
-        pem_password_cb *cb =3D SSL_CTX_get_default_passwd_cb(ctx);
-        void *d =3D SSL_CTX_get_default_passwd_cb_userdata(ctx);
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
-    crypto_msg(M_INFO, "PEM_read_bio failed, now trying engine method to l=
oad private key");
-
-    ui =3D UI_create_method("openvpn");
-    if (!ui)
-    {
-        crypto_msg(M_FATAL, "Engine UI creation failed");
-        return NULL;
-    }
-
-    UI_method_set_reader(ui, ui_reader);
-
-    ENGINE_init(engine_persist);
-    pkey =3D ENGINE_load_private_key(engine_persist, file, ui, ctx);
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
 #if (OPENSSL_VERSION_NUMBER >=3D 0x10100000L) && !defined(LIBRESSL_VERSION=
_NUMBER)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 32849fd..c5a5393 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -118,16 +118,4 @@
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
index 4c08add..23e7623 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1057,10 +1057,6 @@
     pkey =3D PEM_read_bio_PrivateKey(in, NULL,
                                    SSL_CTX_get_default_passwd_cb(ctx->ctx),
                                    SSL_CTX_get_default_passwd_cb_userdata(=
ctx->ctx));
-    if (!pkey)
-    {
-        pkey =3D engine_load_key(priv_key_file, ctx->ctx);
-    }

     if (!pkey || !SSL_CTX_use_PrivateKey(ssl_ctx, pkey))
     {
diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index f27cd90..33fefaa 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -2,7 +2,4 @@

 if ENABLE_UNITTESTS
 SUBDIRS =3D example_test openvpn plugins
-if OPENSSL_ENGINE
-SUBDIRS +=3D engine-key
-endif
 endif
diff --git a/tests/unit_tests/engine-key/Makefile.am b/tests/unit_tests/eng=
ine-key/Makefile.am
deleted file mode 100644
index 0c28885..0000000
--- a/tests/unit_tests/engine-key/Makefile.am
+++ /dev/null
@@ -1,31 +0,0 @@
-AUTOMAKE_OPTIONS =3D foreign
-
-check_LTLIBRARIES =3D libtestengine.la
-conffiles =3D openssl.cnf
-EXTRA_DIST =3D \
-	openssl.cnf.in \
-	check_engine_keys.sh
-
-TESTS_ENVIRONMENT =3D srcdir=3D"$(abs_srcdir)"; \
-	builddir=3D"$(abs_builddir)"; \
-	top_builddir=3D"$(top_builddir)"; \
-	top_srcdir=3D"$(top_srcdir)"; \
-	export srcdir builddir top_builddir top_srcdir;
-
-if !CROSS_COMPILING
-TESTS =3D check_engine_keys.sh
-endif
-check_engine_keys.sh: $(conffiles)
-
-CLEANFILES =3D \
-	client.key \
-	passwd \
-	log.txt \
-	$(conffiles)
-
-openssl.cnf: $(srcdir)/openssl.cnf.in
-	sed "s|ABSBUILDDIR|$(abs_builddir)|" < $(srcdir)/openssl.cnf.in > $@
-
-libtestengine_la_SOURCES =3D libtestengine.c
-libtestengine_la_LDFLAGS =3D @TEST_LDFLAGS@ -rpath /lib -shrext .so
-libtestengine_la_CFLAGS =3D @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_s=
rcdir)
diff --git a/tests/unit_tests/engine-key/check_engine_keys.sh b/tests/unit_=
tests/engine-key/check_engine_keys.sh
deleted file mode 100755
index 12dd230..0000000
--- a/tests/unit_tests/engine-key/check_engine_keys.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-
-OPENSSL_CONF=3D"${builddir}/openssl.cnf"
-export OPENSSL_CONF
-
-password=3D'AT3S4PASSWD'
-
-key=3D"${builddir}/client.key"
-pwdfile=3D"${builddir}/passwd"
-
-# create an engine key for us
-sed 's/PRIVATE KEY/TEST ENGINE KEY/' < ${top_srcdir}/sample/sample-keys/cl=
ient.key > ${key}
-echo "$password" > $pwdfile
-
-# our version of grep to output log.txt on failure in case it's an openssl
-# error mismatch and the grep expression needs updating
-loggrep() {
-    egrep -q "$1" log.txt || { echo '---- begin log.txt ----'; cat log.txt=
; echo '--- end log.txt ---'; return 1; }
-}
-
-# note here we've induced a mismatch in the client key and the server
-# cert which openvpn should report and die.  Check that it does.  Note
-# also that this mismatch depends on openssl not openvpn, so it is
-# somewhat fragile
-${top_builddir}/src/openvpn/openvpn --cd ${top_srcdir}/sample --config sam=
ple-config-files/loopback-server --engine testengine --key ${key} --askpass=
 $pwdfile > log.txt 2>&1
-
-# first off check we died because of a key mismatch.  If this doesn't
-# pass, suspect openssl of returning different messages and update the
-# test accordingly
-loggrep '(x509 certificate routines:(X509_check_private_key)?:key values m=
ismatch|func\(128\):reason\(116\))' log.txt || { echo "Key mismatch not det=
ected"; exit 1; }
-
-# now look for the engine prints (these are under our control)
-loggrep 'ENGINE: engine_init called' || { echo "Engine initialization not =
detected"; exit 1; }
-loggrep 'ENGINE: engine_load_key called' || { echo "Key was not loaded fro=
m engine"; exit 1; }
-loggrep "ENGINE: engine_load_key got password ${password}" || { echo "Key =
password was not retrieved by the engine"; exit 1; }
-exit 0
diff --git a/tests/unit_tests/engine-key/libtestengine.c b/tests/unit_tests=
/engine-key/libtestengine.c
deleted file mode 100644
index 8bcfa92..0000000
--- a/tests/unit_tests/engine-key/libtestengine.c
+++ /dev/null
@@ -1,116 +0,0 @@
-#include <string.h>
-#include <openssl/engine.h>
-#include <openssl/evp.h>
-#include <openssl/pem.h>
-
-static char *engine_id =3D "testengine";
-static char *engine_name =3D "Engine for testing openvpn engine key suppor=
t";
-
-static int is_initialized =3D 0;
-
-static int
-engine_init(ENGINE *e)
-{
-    is_initialized =3D 1;
-    fprintf(stderr, "ENGINE: engine_init called\n");
-    return 1;
-}
-
-static int
-engine_finish(ENGINE *e)
-{
-    fprintf(stderr, "ENGINE: engine_finsh called\n");
-    is_initialized =3D 0;
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
-        fprintf(stderr, "Load Key called without correct initialization\n"=
);
-        return NULL;
-    }
-    b =3D BIO_new_file(key_id, "r");
-    if (!b)
-    {
-        fprintf(stderr, "File %s does not exist or cannot be read\n", key_=
id);
-        return 0;
-    }
-    /* Basically read an EVP_PKEY private key file with different
-     * PEM guards --- we are a test engine */
-    p8inf =3D PEM_ASN1_read_bio((d2i_of_void *)d2i_PKCS8_PRIV_KEY_INFO,
-                              "TEST ENGINE KEY", b,
-                              NULL, NULL, NULL);
-    BIO_free(b);
-    if (!p8inf)
-    {
-        fprintf(stderr, "Failed to read engine private key\n");
-        return NULL;
-    }
-    pkey =3D EVP_PKCS82PKEY(p8inf);
-
-    /* now we have a private key, pretend it had a password
-     * this verifies the password makes it through openvpn OK */
-    ui =3D UI_new();
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
-                            auth, 0, sizeof(auth)) =3D=3D 0)
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
-    if (id && strcmp(id, engine_id) !=3D 0)
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
diff --git a/tests/unit_tests/engine-key/openssl.cnf.in b/tests/unit_tests/=
engine-key/openssl.cnf.in
deleted file mode 100644
index 5eda9fa..0000000
--- a/tests/unit_tests/engine-key/openssl.cnf.in
+++ /dev/null
@@ -1,12 +0,0 @@
-HOME		=3D .
-openssl_conf	=3D openssl_init
-
-[req]
-[openssl_init]
-engines		=3D engines_section
-
-[engines_section]
-testengine	=3D testengine_section
-
-[testengine_section]
-dynamic_path	=3D ABSBUILDDIR/.libs/libtestengine.so

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/373?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d353a0cea0a62f289b8c1060244df66dd7a14cb
Gerrit-Change-Number: 373
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--VNNov3b7ujw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/373?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove openssl engine method for loading the key<br><br>This =
is a contribution for loading engine key. OpenSSL engine is<br>deprecated s=
ince OpenSSL 3.0 and James Bottomlehy has not agreed<br>to the proposed lic=
ense chagne. He is also okay with removing<br>with the feature from the cur=
rent code base as it is obsolete with<br>OpenSSL 3.0.<br><br>Change-Id: I2d=
353a0cea0a62f289b8c1060244df66dd7a14cb<br>---<br>M .gitignore<br>M configur=
e.ac<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/crypto_openssl.h<br=
>M src/openvpn/ssl_openssl.c<br>M tests/unit_tests/Makefile.am<br>D tests/u=
nit_tests/engine-key/Makefile.am<br>D tests/unit_tests/engine-key/check_eng=
ine_keys.sh<br>D tests/unit_tests/engine-key/libtestengine.c<br>D tests/uni=
t_tests/engine-key/openssl.cnf.in<br>10 files changed, 0 insertions(+), 279=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/73/373/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/.gitignore b/.gitignore</span><br><=
span>index ed03aaa..a1da366 100644</span><br><span>--- a/.gitignore</span><=
br><span>+++ b/.gitignore</span><br><span>@@ -57,10 +57,6 @@</span><br><spa=
n> t_client.rc</span><br><span> t_client_ips.rc</span><br><span> tests/unit=
_tests/**/*_testdriver</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-tests/unit_tests/engine-key/client.key</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-tests/unit_tests/engine-key/log.txt</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tests/unit_tests/engine-key/openssl.cnf</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-tests/unit_tests/engine-k=
ey/passwd</span><br><span> </span><br><span> src/openvpn/openvpn</span><br>=
<span> include/openvpn-plugin.h</span><br><span>diff --git a/configure.ac b=
/configure.ac</span><br><span>index 266b66f..128ab86 100644</span><br><span=
>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -=
1532,7 +1532,6 @@</span><br><span>         tests/unit_tests/openvpn/Makefil=
e</span><br><span>         tests/unit_tests/plugins/Makefile</span><br><spa=
n>         tests/unit_tests/plugins/auth-pam/Makefile</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	tests/unit_tests/engine-key/Makefile</span=
><br><span> 	sample/Makefile</span><br><span> ])</span><br><span> AC_CONFIG=
_FILES([tests/t_client.sh], [chmod +x tests/t_client.sh])</span><br><span>d=
iff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</sp=
an><br><span>index 22c6d68..fe1254f 100644</span><br><span>--- a/src/openvp=
n/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.c</span=
><br><span>@@ -1374,66 +1374,6 @@</span><br><span>     return CRYPTO_memcmp=
(a, b, size);</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if HAVE_OPENSSL_ENGINE</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-ui_reader(UI *ui, UI_STRING *uis)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    SSL_CTX *ctx =3D UI_get0_user_data(ui);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (UI_get_string_type(uis) =3D=3D UIT_PROMPT)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        pem_password_cb *cb =3D SSL_CTX_get_defa=
ult_passwd_cb(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      void *d =3D SSL_CTX_get_default_passwd_cb_userdata(ctx);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        char password[64];</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        cb(password, sizeof(password), 0, d);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        UI_set_result(ui, =
uis, password);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 1;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-EVP_PKEY *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-engine_load_key(const char *file, SSL_CTX *ctx)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if HAVE_OPENSSL_ENGINE</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    UI_METHOD *ui;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    EVP_PKEY *pkey;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!engine_persist)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* this will print out the error fro=
m BIO_read */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cryp=
to_msg(M_INFO, &quot;PEM_read_bio failed, now trying engine method to load =
private key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ui =3D UI_create_me=
thod(&quot;openvpn&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!ui)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M=
_FATAL, &quot;Engine UI creation failed&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return NULL;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    UI_metho=
d_set_reader(ui, ui_reader);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ENGINE_ini=
t(engine_persist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 pkey =3D ENGINE_load_private_key(engine_persist, file, ui, ctx);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ENGINE_finish(engine_persis=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!pkey)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;Engine =
could not load key file&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    UI_destroy_method(ui);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return pkey;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if HAVE_OPENSSL_E=
NGINE */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return NU=
LL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if HAVE_=
OPENSSL_ENGINE */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #if (O=
PENSSL_VERSION_NUMBER &gt;=3D 0x10100000L) &amp;&amp; !defined(LIBRESSL_VER=
SION_NUMBER)</span><br><span> bool</span><br><span> ssl_tls1_PRF(const uint=
8_t *seed, int seed_len, const uint8_t *secret,</span><br><span>diff --git =
a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h</span><br><sp=
an>index 32849fd..c5a5393 100644</span><br><span>--- a/src/openvpn/crypto_o=
penssl.h</span><br><span>+++ b/src/openvpn/crypto_openssl.h</span><br><span=
>@@ -118,16 +118,4 @@</span><br><span>         msg((flags), __VA_ARGS__); \=
</span><br><span>     } while (false)</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Load a key file from an engine</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @param file  The engine file to load</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * @param ui    The UI method for the password p=
rompt</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param data  =
The data to pass to the UI method</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ret=
urn      The private key if successful or NULL if not</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-EVP_PKEY *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-engine_load_key(const char *file, SSL_CTX *ctx);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* CRYPTO_OPENSSL_=
H_ */</span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/=
ssl_openssl.c</span><br><span>index 4c08add..23e7623 100644</span><br><span=
>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_open=
ssl.c</span><br><span>@@ -1057,10 +1057,6 @@</span><br><span>     pkey =3D =
PEM_read_bio_PrivateKey(in, NULL,</span><br><span>                         =
           SSL_CTX_get_default_passwd_cb(ctx-&gt;ctx),</span><br><span>    =
                                SSL_CTX_get_default_passwd_cb_userdata(ctx-=
&gt;ctx));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!pk=
ey)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        pkey =3D engine_load_key(p=
riv_key_file, ctx-&gt;ctx);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span> </span><br><span>     if (!pkey || !SSL_CTX_us=
e_PrivateKey(ssl_ctx, pkey))</span><br><span>     {</span><br><span>diff --=
git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am</span><br=
><span>index f27cd90..33fefaa 100644</span><br><span>--- a/tests/unit_tests=
/Makefile.am</span><br><span>+++ b/tests/unit_tests/Makefile.am</span><br><=
span>@@ -2,7 +2,4 @@</span><br><span> </span><br><span> if ENABLE_UNITTESTS=
</span><br><span> SUBDIRS =3D example_test openvpn plugins</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-if OPENSSL_ENGINE</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-SUBDIRS +=3D engine-key</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-endif</span><br><span> endif</span><br><=
span>diff --git a/tests/unit_tests/engine-key/Makefile.am b/tests/unit_test=
s/engine-key/Makefile.am</span><br><span>deleted file mode 100644</span><br=
><span>index 0c28885..0000000</span><br><span>--- a/tests/unit_tests/engine=
-key/Makefile.am</span><br><span>+++ /dev/null</span><br><span>@@ -1,31 +0,=
0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AUTOMAKE_OPTIONS =
=3D foreign</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-check_LTLIBRARIES =3D libtesten=
gine.la</span><br><span style=3D"color: hsl(0, 100%, 40%);">-conffiles =3D =
openssl.cnf</span><br><span style=3D"color: hsl(0, 100%, 40%);">-EXTRA_DIST=
 =3D \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	openssl.cnf.in=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	check_engine_keys.=
sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-TESTS_ENVIRONMENT =3D srcdir=3D&quot;$(a=
bs_srcdir)&quot;; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	b=
uilddir=3D&quot;$(abs_builddir)&quot;; \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	top_builddir=3D&quot;$(top_builddir)&quot;; \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	top_srcdir=3D&quot;$(top_srcdi=
r)&quot;; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	export sr=
cdir builddir top_builddir top_srcdir;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if !=
CROSS_COMPILING</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TESTS =
=3D check_engine_keys.sh</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_engine_=
keys.sh: $(conffiles)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CLEANFILES =3D \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	client.key \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	passwd \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	log.txt \</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	$(conffiles)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openssl.cnf=
: $(srcdir)/openssl.cnf.in</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	sed &quot;s|ABSBUILDDIR|$(abs_builddir)|&quot; &lt; $(srcdir)/openssl=
.cnf.in &gt; $@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-libtestengine_la_SOURCES =
=3D libtestengine.c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-li=
btestengine_la_LDFLAGS =3D @TEST_LDFLAGS@ -rpath /lib -shrext .so</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-libtestengine_la_CFLAGS =3D @TE=
ST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)</span><br><span>diff --gi=
t a/tests/unit_tests/engine-key/check_engine_keys.sh b/tests/unit_tests/eng=
ine-key/check_engine_keys.sh</span><br><span>deleted file mode 100755</span=
><br><span>index 12dd230..0000000</span><br><span>--- a/tests/unit_tests/en=
gine-key/check_engine_keys.sh</span><br><span>+++ /dev/null</span><br><span=
>@@ -1,36 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/b=
in/sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-OPENSSL_CONF=3D&quot;${builddir}/open=
ssl.cnf&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-export O=
PENSSL_CONF</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-password=3D&#39;AT3S4PASSWD&#39=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-key=3D&quot;${builddir}/client.key&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-pwdfile=3D&quot;${buil=
ddir}/passwd&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# create an engine key f=
or us</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sed &#39;s/PRIVA=
TE KEY/TEST ENGINE KEY/&#39; &lt; ${top_srcdir}/sample/sample-keys/client.k=
ey &gt; ${key}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo &q=
uot;$password&quot; &gt; $pwdfile</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# our ver=
sion of grep to output log.txt on failure in case it&#39;s an openssl</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-# error mismatch and the gr=
ep expression needs updating</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-loggrep() {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 egrep -q &quot;$1&quot; log.txt || { echo &#39;---- begin log.txt ----&#39=
;; cat log.txt; echo &#39;--- end log.txt ---&#39;; return 1; }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# note here we&#39;ve induced a mismatch in the client key and the server<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-# cert which openvpn s=
hould report and die.  Check that it does.  Note</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# also that this mismatch depends on openssl not=
 openvpn, so it is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# s=
omewhat fragile</span><br><span style=3D"color: hsl(0, 100%, 40%);">-${top_=
builddir}/src/openvpn/openvpn --cd ${top_srcdir}/sample --config sample-con=
fig-files/loopback-server --engine testengine --key ${key} --askpass $pwdfi=
le &gt; log.txt 2&gt;&amp;1</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# first off che=
ck we died because of a key mismatch.  If this doesn&#39;t</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-# pass, suspect openssl of returning d=
ifferent messages and update the</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# test accordingly</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-loggrep &#39;(x509 certificate routines:(X509_check_private_key)?:k=
ey values mismatch|func\(128\):reason\(116\))&#39; log.txt || { echo &quot;=
Key mismatch not detected&quot;; exit 1; }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# now look for the engine prints (these are under our control)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-loggrep &#39;ENGINE: engine_init c=
alled&#39; || { echo &quot;Engine initialization not detected&quot;; exit 1=
; }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-loggrep &#39;ENGIN=
E: engine_load_key called&#39; || { echo &quot;Key was not loaded from engi=
ne&quot;; exit 1; }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-lo=
ggrep &quot;ENGINE: engine_load_key got password ${password}&quot; || { ech=
o &quot;Key password was not retrieved by the engine&quot;; exit 1; }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-exit 0</span><br><span>diff=
 --git a/tests/unit_tests/engine-key/libtestengine.c b/tests/unit_tests/eng=
ine-key/libtestengine.c</span><br><span>deleted file mode 100644</span><br>=
<span>index 8bcfa92..0000000</span><br><span>--- a/tests/unit_tests/engine-=
key/libtestengine.c</span><br><span>+++ /dev/null</span><br><span>@@ -1,116=
 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;=
string.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include =
&lt;openssl/engine.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#include &lt;openssl/evp.h&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#include &lt;openssl/pem.h&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static char *engine_id =3D &quot;testengine&quot;;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static char *engine_name =3D &quot;Engine for =
testing openvpn engine key support&quot;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic int is_initialized =3D 0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-engine_init(ENGINE *e)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    is_initialized =3D 1;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    fprintf(stderr, &quot;ENGINE: eng=
ine_init called\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-engine_finish(ENGINE *e)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    fprintf(stderr, &quot;ENGINE: engine_finsh called\n&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    is_initialized =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static EVP_PKEY *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-eng=
ine_load_key(ENGINE *e, const char *key_id,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                UI_METHOD *ui_method, void *cb_data)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    BIO *b;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    EVP_PKEY *pkey;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    PKCS8_PRIV_KEY_INFO *p8inf;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    UI *ui;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    char auth[256];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   fprintf(stderr, &quot;ENGINE: engine_load_key called\n&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!is_initialized)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        fprintf(stderr, &quot;Load Key called without correct ini=
tialization\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    b =3D BIO_new=
_file(key_id, &quot;r&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (!b)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fprintf(st=
derr, &quot;File %s does not exist or cannot be read\n&quot;, key_id);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* Basically read an EVP_PKEY private key =
file with different</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * PEM guards --- we are a test engine */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    p8inf =3D PEM_ASN1_read_bio((d2i_of_void *)d2i_PK=
CS8_PRIV_KEY_INFO,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                           &quot;TEST ENGINE KEY&quot;, b,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                              NULL, NU=
LL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BIO_fre=
e(b);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!p8inf)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        fprintf(stderr, &quot;Failed t=
o read engine private key\n&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        return NULL;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 pkey =3D EVP_PKCS82PKEY(p8inf);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* now=
 we have a private key, pretend it had a password</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     * this verifies the password makes it thro=
ugh openvpn OK */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ui =3D UI_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ui_method)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        UI_set_method(ui, ui_method);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    UI_add_user_data(ui, cb_data);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (UI_add_input_string(ui, &quot;enter test engine key&quot;,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
 UI_INPUT_FLAG_DEFAULT_PWD,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                            auth, 0, sizeof(auth)) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        fprintf(stderr, &quot;UI_add_input_str=
ing failed\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       goto out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (UI_process(ui))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        fprintf(stderr, &quot;UI_process failed\n&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto out;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    fprintf(stderr, &quot;ENGINE: engine_load_key got passwor=
d %s\n&quot;, auth);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-out:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    UI_free(ui);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return pkey;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-engine_bind_fn(ENGINE *e, const char *id)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (id &amp;&amp; strcmp(id, engine_id) !=3D 0)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (!ENGINE_set_id(e, engine_id)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        || !ENGINE_set_name(e, engine_name)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        || !ENGINE_set_init_function=
(e, engine_init)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   || !ENGINE_set_finish_function(e, engine_finish)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        || !ENGINE_set_load_privkey_functio=
n(e, engine_load_key))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return =
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IMPLEMENT=
_DYNAMIC_CHECK_FN()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IM=
PLEMENT_DYNAMIC_BIND_FN(engine_bind_fn)</span><br><span>diff --git a/tests/=
unit_tests/engine-key/openssl.cnf.in b/tests/unit_tests/engine-key/openssl.=
cnf.in</span><br><span>deleted file mode 100644</span><br><span>index 5eda9=
fa..0000000</span><br><span>--- a/tests/unit_tests/engine-key/openssl.cnf.i=
n</span><br><span>+++ /dev/null</span><br><span>@@ -1,12 +0,0 @@</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-HOME		=3D .</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-openssl_conf	=3D openssl_init</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-[req]</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-[openssl_init]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-eng=
ines		=3D engines_section</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-[engines_section]=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-testengine	=3D testen=
gine_section</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-[testengine_section]</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-dynamic_path	=3D ABSBUILDDIR/.l=
ibs/libtestengine.so</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/373?usp=3Demail">change 373</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/373?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2d353a0cea0a62f289b8c106024=
4df66dd7a14cb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 373 </div>
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


--VNNov3b7ujw=--

