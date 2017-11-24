From: "Jim Carroll" <jim@...2322...>
Date: Fri, 24 Nov 2017 12:09:13 -0500
Message-ID: <040701d36546$f3cc1270$db643750$@carroll.com>
Content-Language: en-us
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=SHA1; boundary="----=_NextPart_000_03FF_01D3651D.09DA6140"
Subject: [Openvpn-devel] [PATCH] Added OpenSSL FIPS 2.0 support to OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.

------=_NextPart_000_03FF_01D3651D.09DA6140
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0400_01D3651D.09DA6140"

------=_NextPart_001_0400_01D3651D.09DA6140
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Modified the autoconf, automake and code to support building OpenVPN with

OpenSSL FIPS Object Module v2.0 validated encryption.

 

        * Adds: --enable-fips-mode switch to configure.ac

        * Adds: --enable-fips-mode command line switch to openvpn

---

INSTALL                      | 72
++++++++++++++++++++++++++++++++++++++++++++

Makefile.am                  |  5 +++

configure.ac                 | 42 ++++++++++++++++++++++++++

src/openvpn/crypto.c         |  2 +-

src/openvpn/crypto_backend.h |  3 +-

src/openvpn/crypto_openssl.c | 15 ++++++++-

src/openvpn/crypto_openssl.h |  8 +++++

src/openvpn/ntlm.c           |  2 +-

src/openvpn/openvpn.c        |  7 +++++

src/openvpn/options.c        | 16 ++++++++++

src/openvpn/options.h        |  1 +

src/openvpn/ssl.c            | 12 ++++++--

src/openvpn/ssl.h            |  4 +++

13 files changed, 183 insertions(+), 6 deletions(-)

 

diff --git a/INSTALL b/INSTALL

index 3a31e6f..adb3df8 100644

--- a/INSTALL

+++ b/INSTALL

@@ -305,6 +305,78 @@ TUN/TAP Driver Configuration:

 *************************************************************************

+OpenSSL FIPS Object Module v2.0 Configuration:

+

+These instructions were adapted from 

+

+    https://www.openssl.org/docs/fipsnotes.html

+

+Requirements:

+

+    * OpenSSL 1.0.2m

+    * openssl-fips-2.0.2

+

+WARNING

+

+To install FIPS Validated encryption, you must follow the instructions in
the

+FIPS 2.0 User's Guide precisely. You are not permitted to modify any of the
FIPS

+build artifacts, makefiles or scripts. The FIPS 2.0 module is only
compatible with

+OpenSSL 1.0.1 and 1.0.2. 

+

+These instructions describe the use of OpenSSL 1.0.2m.

+

+INSTALLATION:

+

+    1. Surf to https://www.openssl.org/source/

+    2. Download source AND validate the download was correct (preferably
using PGP)

+    3. Untar and uncompress tarball

+    4. You must build using this precise command (do NOT choose any other
options):

+

+            # ./config && make install

+

+            (you may optionally pass 'no-asm' to config)

+

+       If the above procedure does not build on your system -- STOP. You
are not

+       building on a FIPS supported platform, and therefore will not have a

+       FIPS validated encryption environment. See chapter 3 of the FIPS 2.0

+       User's Guide for the complete list of supported platforms:

+

+            https://openssl.org/docs/fips/UserGuide-2.0.pdf

+

+    5. Download, build & install openssl 1.0.2m (you are permitted to

+       modify this step to suite your preferences):

+

+            # git clone https://github.com/openssl/openssl.git

+            # (cd openssl && \

+                    git checkout OpenSSL_1_0_2m && \

+                    ./config fips && \

+                    make depend && \

+                    make install)

+

+    6. Now build openvpn and tell it where to find you're recently
installed OpenSSL

+

+            # ./configure --enable-fips-mode \

+                    OPENSSL_CFLAGS=-/usr/local/ss/include \

+                    OPENSSL_LIBS="-ldl -L/usr/local/ssl/lib -lssl -lcrypto"

+

+            # make install

+

+    7. You can confirm FIPS mode is available with the command

+

+            # ./openvpn --version | grep 'library version'

+            library versions: OpenSSL 1.0.2m-fips  2 Nov 2017, LZO 2.08

+

+USAGE:

+

+The above adds a new '--enable-fips-mode' command line option to OpenVPN.
Add this to your

+invocation statement. If you've successfully configured OpenVPN for FIPS
mode, check your

+OpenVPN logs for the statement:

+

+    *** FIPS MODE ENABLE ***

+

+

+*************************************************************************

+

CAVEATS & BUGS:

 * I have noticed cases where TCP sessions tunneled over the Linux

diff --git a/Makefile.am b/Makefile.am

index 773b786..6d571ec 100644

--- a/Makefile.am

+++ b/Makefile.am

@@ -83,6 +83,11 @@ rootdir=$(prefix)

root_DATA = version.sh

endif

+if FIPSMODE

+export CC

+export FIPSLD_CC

+endif

+

config-version.h:

    @CONFIGURE_GIT_CHFILES="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT)
diff-files --name-status -r --ignore-submodules --quiet -- || echo \"+\"`";
\

    CONFIGURE_GIT_UNCOMMITTED="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT)
diff-index --cached  --quiet --ignore-submodules HEAD || echo \"*\"`"; \

diff --git a/configure.ac b/configure.ac

index 7f2e34f..83ac18d 100644

--- a/configure.ac

+++ b/configure.ac

@@ -293,6 +293,17 @@ AC_ARG_WITH(

    [with_crypto_library="openssl"]

)

+AC_ARG_ENABLE(

+    [fips-mode],

+    [AS_HELP_STRING([--enable-fips-mode], [OpenSSL FIPS Object Module 2.0
@<:@default=no@:>@])],

+    [

+        if test "${with_crypto_library}" != "openssl"; then

+            AC_MSG_ERROR([enable_fips_mode requires
--with_crypto_library=openssl])

+        fi

+    ],

+    [enable_fips_mode="no"]

+)

+

AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory
@<:@default=LIBDIR/openvpn/plugins@:>@])

if test -n "${PLUGINDIR}"; then

    plugindir="${PLUGINDIR}"

@@ -954,6 +965,35 @@ if test "${enable_crypto}" = "yes" -a
"${with_crypto_library}" = "openssl"; then

         ]

    )

+    if test "${enable_fips_mode}" = "yes"; then

+        AC_CHECK_FUNCS(

+            [ \

+                FIPS_mode \

+                FIPS_mode_set \

+                SSLeay_version

+            ],

+            [],

+            [AC_MSG_ERROR([Incorrect version of OpenSSL, require 1.0.2])]

+            )

+        AC_RUN_IFELSE(

+            [AC_LANG_PROGRAM(

+                [[#include <openssl/crypto.h>]],

+                [[printf("%s\n", SSLeay_version(SSLEAY_DIR));]])

+            ],

+            [AC_SUBST(OPENSSLDIR,

+                [[`./conftest$EXEEXT | $SED -n 's/.*"\(.*\)".*/\1/p'`]])

+            ]

+        )

+        if ! test -x "${OPENSSLDIR}/fips-2.0/bin/fipsld"; then

+            AC_MSG_ERROR([Incomplete OpenSSL FIPS installation; missing
fipsld])

+        fi

+        AC_SUBST([FIPSLD_CC], ["${CC}"])

+        AC_SUBST([CC], ["${OPENSSLDIR}/fips-2.0/bin/fipsld"])

+        export CC

+        export FIPSLD_CC

+        AC_DEFINE([ENABLE_FIPS], [1], [Enable OpenSSL FIPS 2.0 Options])

+    fi

+

    CFLAGS="${saved_CFLAGS}"

    LIBS="${saved_LIBS}"

@@ -1373,6 +1413,7 @@ AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test
"${enable_plugin_auth_pam}" = "ye

AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}"
= "yes"])

AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" = "yes"])

AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" =
"yes"])

+AM_CONDITIONAL([FIPSMODE], [test "${enable_fips_mode}" = "yes"])

 sampledir="\$(docdir)/sample"

AC_SUBST([plugindir])

@@ -1441,4 +1482,5 @@ AC_CONFIG_FILES([

    sample/Makefile

])

AC_CONFIG_FILES([tests/t_client.sh], [chmod +x tests/t_client.sh])

+

AC_OUTPUT

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c

index 3f3caa1..0c05859 100644

--- a/src/openvpn/crypto.c

+++ b/src/openvpn/crypto.c

@@ -854,7 +854,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,

     if (kt->digest && kt->hmac_length > 0)

     {

         ctx->hmac = hmac_ctx_new();

-        hmac_ctx_init(ctx->hmac, key->hmac, kt->hmac_length, kt->digest);

+        hmac_ctx_init(ctx->hmac, key->hmac, kt->hmac_length, kt->digest,
false);

         msg(D_HANDSHAKE,

             "%s: Using %d bit message hash '%s' for HMAC authentication",

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h

index 567fd9b..d92ab7c 100644

--- a/src/openvpn/crypto_backend.h

+++ b/src/openvpn/crypto_backend.h

@@ -604,10 +604,11 @@ void hmac_ctx_free(hmac_ctx_t *ctx);

  * @param key           The key to use for the HMAC

  * @param key_len       The key length to use

  * @param kt            Static message digest parameters

+ * @param prf_use       Intended use for PRF in TLS protocol

  *

  */

void hmac_ctx_init(hmac_ctx_t *ctx, const uint8_t *key, int key_length,

-                   const md_kt_t *kt);

+                   const md_kt_t *kt, bool prf_use);

 /*

  * Free the given HMAC context.

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c

index 0134e55..caef17b 100644

--- a/src/openvpn/crypto_openssl.c

+++ b/src/openvpn/crypto_openssl.c

@@ -159,6 +159,17 @@ crypto_init_lib(void)

#endif

}

+int

+crypto_enable_fips_mode(int mode)

+{

+    if (!FIPS_mode_set(mode)) {

+         ERR_print_errors_fp(stderr);

+         return 1;

+         }

+    msg(M_INFO, "*** IN FIPS MODE ***\n");

+    return 0;

+}

+

void

crypto_uninit_lib(void)

{

@@ -926,11 +937,13 @@ hmac_ctx_free(HMAC_CTX *ctx)

 void

hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, int key_len,

-              const EVP_MD *kt)

+              const EVP_MD *kt, bool prf_use)

{

     ASSERT(NULL != kt && NULL != ctx);

     HMAC_CTX_reset(ctx);

+    if (kt == EVP_md5() && prf_use)

+         HMAC_CTX_set_flags(ctx, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);

     HMAC_Init_ex(ctx, key, key_len, kt, NULL);

     /* make sure we used a big enough key */

diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h

index 60a2812..11f3378 100644

--- a/src/openvpn/crypto_openssl.h

+++ b/src/openvpn/crypto_openssl.h

@@ -102,4 +102,12 @@ void crypto_print_openssl_errors(const unsigned int
flags);

     } while (false)

 

+/**

+ * Enable FIPS Mode. Returns non-zero to indicate an error.

+ *

+ * @param mode         Should be 1. Future versions of OpenSSL FIPS

+ *                        code are expected to accept extended modes.

+ */

+int crypto_enable_fips_mode(int mode);

+

#endif /* CRYPTO_OPENSSL_H_ */

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c

index 077fa3e..fe39ab1 100644

--- a/src/openvpn/ntlm.c

+++ b/src/openvpn/ntlm.c

@@ -88,7 +88,7 @@ gen_hmac_md5(const uint8_t *data, int data_len, const
uint8_t *key, int key_len,

     const md_kt_t *md5_kt = md_kt_get("MD5");

     hmac_ctx_t *hmac_ctx = hmac_ctx_new();

-    hmac_ctx_init(hmac_ctx, key, key_len, md5_kt);

+    hmac_ctx_init(hmac_ctx, key, key_len, md5_kt, false);

     hmac_ctx_update(hmac_ctx, data, data_len);

     hmac_ctx_final(hmac_ctx, result);

     hmac_ctx_cleanup(hmac_ctx);

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c

index e237ee5..beb1d2a 100644

--- a/src/openvpn/openvpn.c

+++ b/src/openvpn/openvpn.c

@@ -210,6 +210,13 @@ openvpn_main(int argc, char *argv[])

             /* parse command line options, and read configuration file */

             parse_argv(&c.options, argc, argv, M_USAGE, OPT_P_DEFAULT,
NULL, c.es);

+#if ENABLE_FIPS

+             if (c.options.fips_mode) {

+                  if (enable_fips_mode(c.options.fips_mode)) {

+                       break;

+                       }

+                  }

+#endif

#ifdef ENABLE_PLUGIN

             /* plugins may contribute options configuration */

             init_verb_mute(&c, IVM_LEVEL_1);

diff --git a/src/openvpn/options.c b/src/openvpn/options.c

index 8e5cdf7..8a1501c 100644

--- a/src/openvpn/options.c

+++ b/src/openvpn/options.c

@@ -522,6 +522,11 @@ static const char usage_message[] =

     "\n"

     "Data Channel Encryption Options (must be compatible between peers):\n"

     "(These options are meaningful for both Static Key & TLS-mode)\n"

+#ifdef ENABLE_FIPS

+    "--enable-fips-mode : Enable OpenSSL FIPS Object Module v2.0.\n"

+    "                  Setting this on the server will enforce FIPS
validated\n"

+    "                  encryption on both client and server.\n"

+#endif

     "--secret f [d]  : Enable Static Key encryption mode (non-TLS).\n"

     "                  Use shared secret file f, generate with --genkey.\n"

     "                  The optional d parameter controls key
directionality.\n"

@@ -854,6 +859,9 @@ init_options(struct options *o, const bool init_gc)

#endif

#ifdef ENABLE_CRYPTO

     o->ciphername = "BF-CBC";

+#ifdef ENABLE_FIPS

+    o->fips_mode = 0;

+#endif

#ifdef HAVE_AEAD_CIPHER_MODES /* IV_NCP=2 requires GCM support */

     o->ncp_enabled = true;

#else

@@ -1561,6 +1569,7 @@ show_settings(const struct options *o)

#endif

 #ifdef ENABLE_CRYPTO

+    SHOW_INT(fips_mode);

     SHOW_BOOL(show_ciphers);

     SHOW_BOOL(show_digests);

     SHOW_BOOL(show_engines);

@@ -7442,6 +7451,13 @@ add_option(struct options *options,

     }

#endif /* USE_COMP */

#ifdef ENABLE_CRYPTO

+#ifdef ENABLE_FIPS

+    else if (streq(p[0], "enable-fips-mode") && !p[1])

+    {

+        VERIFY_PERMISSION(OPT_P_GENERAL);

+         options->fips_mode = 1;

+    }

+#endif

     else if (streq(p[0], "show-ciphers") && !p[1])

     {

         VERIFY_PERMISSION(OPT_P_GENERAL);

diff --git a/src/openvpn/options.h b/src/openvpn/options.h

index 035c6d1..55d2248 100644

--- a/src/openvpn/options.h

+++ b/src/openvpn/options.h

@@ -189,6 +189,7 @@ struct options

     int persist_mode;

 #ifdef ENABLE_CRYPTO

+    int fips_mode;

     const char *key_pass_file;

     bool show_ciphers;

     bool show_digests;

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c

index 843bc39..6a212b8 100644

--- a/src/openvpn/ssl.c

+++ b/src/openvpn/ssl.c

@@ -354,6 +354,14 @@ init_ssl_lib(void)

     crypto_init_lib();

}

+#if ENABLE_FIPS

+int

+enable_fips_mode(int mode)

+{

+    return crypto_enable_fips_mode(mode);

+}

+#endif

+

void

free_ssl_lib(void)

{

@@ -1640,8 +1648,8 @@ tls1_P_hash(const md_kt_t *md_kt,

     chunk = md_kt_size(md_kt);

     A1_len = md_kt_size(md_kt);

-    hmac_ctx_init(ctx, sec, sec_len, md_kt);

-    hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt);

+    hmac_ctx_init(ctx, sec, sec_len, md_kt, true);

+    hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt, true);

     hmac_ctx_update(ctx,seed,seed_len);

     hmac_ctx_final(ctx, A1);

diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h

index 0e0f68f..ae23423 100644

--- a/src/openvpn/ssl.h

+++ b/src/openvpn/ssl.h

@@ -600,6 +600,10 @@ bool is_hard_reset(int op, int key_method);

 void delayed_auth_pass_purge(void);

+#if ENABLE_FIPS

+int enable_fips_mode(int mode);

+#endif

+

#endif /* ENABLE_CRYPTO */

 #endif /* ifndef OPENVPN_SSL_H */

-- 

2.1.4

 

 


------=_NextPart_001_0400_01D3651D.09DA6140
Content-Type: text/html; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Courier New";
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Courier New";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoPlainText>Modified the =
autoconf, automake and code to support building OpenVPN with<o:p></o:p></p>=
<p class=3DMsoPlainText>OpenSSL FIPS Object Module v2.0 validated encryptio=
n.<o:p></o:p></p><p class=3DMsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMs=
oPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Adds: --enable-fips=
-mode switch to configure.ac<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Adds: --enable-fips-mode command line =
switch to openvpn<o:p></o:p></p><p class=3DMsoPlainText>---<o:p></o:p></p><=
p class=3DMsoPlainText> INSTALL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; | 72 ++++++++++++++++++++++++++++++++++++++++++++<o:p></o:p></p><p =
class=3DMsoPlainText> Makefile.am&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 +++<=
o:p></o:p></p><p class=3DMsoPlainText> configure.ac&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | =
42 ++++++++++++++++++++++++++<o:p></o:p></p><p class=3DMsoPlainText> src/op=
envpn/crypto.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-=
<o:p></o:p></p><p class=3DMsoPlainText> src/openvpn/crypto_backend.h |&nbsp=
; 3 +-<o:p></o:p></p><p class=3DMsoPlainText> src/openvpn/crypto_openssl.c =
| 15 ++++++++-<o:p></o:p></p><p class=3DMsoPlainText> src/openvpn/crypto_op=
enssl.h |&nbsp; 8 +++++<o:p></o:p></p><p class=3DMsoPlainText> src/openvpn/=
ntlm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; =
2 +-<o:p></o:p></p><p class=3DMsoPlainText> src/openvpn/openvpn.c&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 +++++<o:p></o:p></p><p class=3DM=
soPlainText> src/openvpn/options.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 16 ++++++++++<o:p></o:p></p><p class=3DMsoPlainText> src/openvpn/option=
s.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<o:p></o:p></p><p =
class=3DMsoPlainText> src/openvpn/ssl.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 12 ++++++--<o:p></o:p></p><p class=3DMsoPl=
ainText> src/openvpn/ssl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 4 +++<o:p></o:p></p><p class=3DMsoPlainText> 13 f=
iles changed, 183 insertions(+), 6 deletions(-)<o:p></o:p></p><p class=3DMs=
oPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoPlainText>diff --git a/INSTAL=
L b/INSTALL<o:p></o:p></p><p class=3DMsoPlainText>index 3a31e6f..adb3df8 10=
0644<o:p></o:p></p><p class=3DMsoPlainText>--- a/INSTALL<o:p></o:p></p><p c=
lass=3DMsoPlainText>+++ b/INSTALL<o:p></o:p></p><p class=3DMsoPlainText>@@ =
-305,6 +305,78 @@ TUN/TAP Driver Configuration:<o:p></o:p></p><p class=3DMs=
oPlainText> <o:p></o:p></p><p class=3DMsoPlainText>&nbsp;******************=
*******************************************************<o:p></o:p></p><p cl=
ass=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>+OpenSSL FIPS Ob=
ject Module v2.0 Configuration:<o:p></o:p></p><p class=3DMsoPlainText>+<o:p=
></o:p></p><p class=3DMsoPlainText>+These instructions were adapted from <o=
:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainTex=
t>+&nbsp;&nbsp;&nbsp; <a href=3D"https://www.openssl.org/docs/fipsnotes.htm=
l">https://www.openssl.org/docs/fipsnotes.html</a><o:p></o:p></p><p class=
=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText>+Requirements:<o:p>=
</o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText>+=
&nbsp;&nbsp;&nbsp; * OpenSSL 1.0.2m<o:p></o:p></p><p class=3DMsoPlainText>+=
&nbsp;&nbsp;&nbsp; * openssl-fips-2.0.2<o:p></o:p></p><p class=3DMsoPlainTe=
xt>+<o:p></o:p></p><p class=3DMsoPlainText>+WARNING<o:p></o:p></p><p class=
=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText>+To install FIPS Va=
lidated encryption, you must follow the instructions in the<o:p></o:p></p><=
p class=3DMsoPlainText>+FIPS 2.0 User's Guide precisely. You are not permit=
ted to modify any of the FIPS<o:p></o:p></p><p class=3DMsoPlainText>+build =
artifacts, makefiles or scripts. The FIPS 2.0 module is only compatible wit=
h<o:p></o:p></p><p class=3DMsoPlainText>+OpenSSL 1.0.1 and 1.0.2. <o:p></o:=
p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText>+Thes=
e instructions describe the use of OpenSSL 1.0.2m.<o:p></o:p></p><p class=
=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText>+INSTALLATION:<o:p>=
</o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText>+=
&nbsp;&nbsp;&nbsp; 1. Surf to <a href=3D"https://www.openssl.org/source/">h=
ttps://www.openssl.org/source/</a><o:p></o:p></p><p class=3DMsoPlainText>+&=
nbsp;&nbsp;&nbsp; 2. Download source AND validate the download was correct =
(preferably using PGP)<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&=
nbsp; 3. Untar and uncompress tarball<o:p></o:p></p><p class=3DMsoPlainText=
>+&nbsp;&nbsp;&nbsp; 4. You must build using this precise command (do NOT c=
hoose any other options):<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p=
></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; # ./config &amp;&amp; make install<o:p></o:p></p><p c=
lass=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (you may optionally pa=
ss 'no-asm' to config)<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p></=
p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If the abov=
e procedure does not build on your system -- STOP. You are not<o:p></o:p></=
p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; building on=
 a FIPS supported platform, and therefore will not have a<o:p></o:p></p><p =
class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FIPS validated e=
ncryption environment. See chapter 3 of the FIPS 2.0<o:p></o:p></p><p class=
=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; User's Guide for the =
complete list of supported platforms:<o:p></o:p></p><p class=3DMsoPlainText=
>+<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://openssl.org/docs/fips/=
UserGuide-2.0.pdf">https://openssl.org/docs/fips/UserGuide-2.0.pdf</a><o:p>=
</o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText>+=
&nbsp;&nbsp;&nbsp; 5. Download, build &amp; install openssl 1.0.2m (you are=
 permitted to<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; modify this step to suite your preferences):<o:p></o:p></p><=
p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # git clone <a href=
=3D"https://github.com/openssl/openssl.git">https://github.com/openssl/open=
ssl.git</a><o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # (cd openssl &amp;&amp; \<o:p><=
/o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g=
it checkout OpenSSL_1_0_2m &amp;&amp; \<o:p></o:p></p><p class=3DMsoPlainTe=
xt>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ./config fips &amp;&amp; \<o:p>=
</o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
make depend &amp;&amp; \<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; make install)<o:p></o:p></p><p class=3DMsoPlai=
nText>+<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; 6. Now bu=
ild openvpn and tell it where to find you&#8217;re recently installed OpenS=
SL<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlai=
nText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #=
 ./configure --enable-fips-mode \<o:p></o:p></p><p class=3DMsoPlainText>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPENSSL_CFLAGS=3D-/usr/local/ss/inclu=
de \<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; OPENSSL_LIBS=3D&quot;-ldl -L/usr/local/ssl/lib -lssl -lcrypto&quot=
;<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlain=
Text>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # =
make install<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=
=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; 7. You can confirm FIPS mode is availab=
le with the command<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><=
p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; # ./openvpn --version | grep 'library version'<o:p></o:p></=
p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; library versions: OpenSSL 1.0.2m-fips&nbsp; 2 Nov 2017, =
LZO 2.08<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DM=
soPlainText>+USAGE:<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><=
p class=3DMsoPlainText>+The above adds a new '--enable-fips-mode' command l=
ine option to OpenVPN. Add this to your<o:p></o:p></p><p class=3DMsoPlainTe=
xt>+invocation statement. If you've successfully configured OpenVPN for FIP=
S mode, check your<o:p></o:p></p><p class=3DMsoPlainText>+OpenVPN logs for =
the statement:<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p cla=
ss=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; *** FIPS MODE ENABLE ***<o:p></o:p></=
p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o=
:p></p><p class=3DMsoPlainText>+*******************************************=
******************************<o:p></o:p></p><p class=3DMsoPlainText>+<o:p>=
</o:p></p><p class=3DMsoPlainText> CAVEATS &amp; BUGS:<o:p></o:p></p><p cla=
ss=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>&nbsp;* I have no=
ticed cases where TCP sessions tunneled over the Linux<o:p></o:p></p><p cla=
ss=3DMsoPlainText>diff --git a/Makefile.am b/Makefile.am<o:p></o:p></p><p c=
lass=3DMsoPlainText>index 773b786..6d571ec 100644<o:p></o:p></p><p class=3D=
MsoPlainText>--- a/Makefile.am<o:p></o:p></p><p class=3DMsoPlainText>+++ b/=
Makefile.am<o:p></o:p></p><p class=3DMsoPlainText>@@ -83,6 +83,11 @@ rootdi=
r=3D$(prefix)<o:p></o:p></p><p class=3DMsoPlainText> root_DATA =3D version.=
sh<o:p></o:p></p><p class=3DMsoPlainText> endif<o:p></o:p></p><p class=3DMs=
oPlainText> <o:p></o:p></p><p class=3DMsoPlainText>+if FIPSMODE<o:p></o:p><=
/p><p class=3DMsoPlainText>+export CC<o:p></o:p></p><p class=3DMsoPlainText=
>+export FIPSLD_CC<o:p></o:p></p><p class=3DMsoPlainText>+endif<o:p></o:p><=
/p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText> config-=
version.h:<o:p></o:p></p><p class=3DMsoPlainText> &nbsp;&nbsp;&nbsp; @CONFI=
GURE_GIT_CHFILES=3D&quot;`GIT_DIR=3D\&quot;$(top_srcdir)/.git\&quot; $(GIT)=
 diff-files --name-status -r --ignore-submodules --quiet -- || echo \&quot;=
+\&quot;`&quot;; \<o:p></o:p></p><p class=3DMsoPlainText> &nbsp;&nbsp;&nbsp=
; CONFIGURE_GIT_UNCOMMITTED=3D&quot;`GIT_DIR=3D\&quot;$(top_srcdir)/.git\&q=
uot; $(GIT) diff-index --cached&nbsp; --quiet --ignore-submodules HEAD || e=
cho \&quot;*\&quot;`&quot;; \<o:p></o:p></p><p class=3DMsoPlainText>diff --=
git a/configure.ac b/configure.ac<o:p></o:p></p><p class=3DMsoPlainText>ind=
ex 7f2e34f..83ac18d 100644<o:p></o:p></p><p class=3DMsoPlainText>--- a/conf=
igure.ac<o:p></o:p></p><p class=3DMsoPlainText>+++ b/configure.ac<o:p></o:p=
></p><p class=3DMsoPlainText>@@ -293,6 +293,17 @@ AC_ARG_WITH(<o:p></o:p></=
p><p class=3DMsoPlainText> &nbsp;&nbsp;&nbsp; [with_crypto_library=3D&quot;=
openssl&quot;]<o:p></o:p></p><p class=3DMsoPlainText> )<o:p></o:p></p><p cl=
ass=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>+AC_ARG_ENABLE(<=
o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; [fips-mode],<o:p>=
</o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; [AS_HELP_STRING([--en=
able-fips-mode], [OpenSSL FIPS Object Module 2.0 @&lt;:@default=3Dno@:&gt;@=
])],<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; [<o:p></o:p>=
</p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
test &quot;${with_crypto_library}&quot; !=3D &quot;openssl&quot;; then<o:p>=
</o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; AC_MSG_ERROR([enable_fips_mode requires --with_c=
rypto_library=3Dopenssl])<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<o:p></o:p></p><p class=3DMsoPlainText>+=
&nbsp;&nbsp;&nbsp; ],<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&n=
bsp; [enable_fips_mode=3D&quot;no&quot;]<o:p></o:p></p><p class=3DMsoPlainT=
ext>+)<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMso=
PlainText> AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory @&lt;:@defaul=
t=3DLIBDIR/openvpn/plugins@:&gt;@])<o:p></o:p></p><p class=3DMsoPlainText> =
if test -n &quot;${PLUGINDIR}&quot;; then<o:p></o:p></p><p class=3DMsoPlain=
Text> &nbsp;&nbsp;&nbsp; plugindir=3D&quot;${PLUGINDIR}&quot;<o:p></o:p></p=
><p class=3DMsoPlainText>@@ -954,6 +965,35 @@ if test &quot;${enable_crypto=
}&quot; =3D &quot;yes&quot; -a &quot;${with_crypto_library}&quot; =3D &quot=
;openssl&quot;; then<o:p></o:p></p><p class=3DMsoPlainText> &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]<o:p></o:p></p><p class=3DMsoPlainText> =
&nbsp;&nbsp;&nbsp; )<o:p></o:p></p><p class=3DMsoPlainText> <o:p></o:p></p>=
<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; if test &quot;${enable_fips_mod=
e}&quot; =3D &quot;yes&quot;; then<o:p></o:p></p><p class=3DMsoPlainText>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AC_CHECK_FUNCS(<o:p></o:p></p><p =
class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; [ \<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FI=
PS_mode \<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FIPS_mode_=
set \<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SSLeay_version=
<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ],<o:p></o:p></p><p class=3DMsoPlainText>+&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [],<o:p><=
/o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; [AC_MSG_ERROR([Incorrect version of OpenSSL, requ=
ire 1.0.2])]<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<o:p></o:p></p><p class=3DMsoP=
lainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AC_RUN_IFELSE(<o:p></o=
:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; [AC_LANG_PROGRAM(<o:p></o:p></p><p class=3DMsoPlain=
Text>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; [[#include &lt;openssl/crypto.h&gt;]],<o:p></o:p></p>=
<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [[printf(&quot;%s\n&quot;, SSLeay_=
version(SSLEAY_DIR));]])<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ],<o:p></o:p></p><p=
 class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; [AC_SUBST(OPENSSLDIR,<o:p></o:p></p><p class=3DMsoPlainText>=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; [[`./conftest$EXEEXT | $SED -n 's/.*&quot;\(.*\)&quot;.*/\=
1/p'`]])<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]<o:p></o:p></p><p class=3DMsoPlain=
Text>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; )<o:p></o:p></p><p class=
=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ! test -x &q=
uot;${OPENSSLDIR}/fips-2.0/bin/fipsld&quot;; then<o:p></o:p></p><p class=3D=
MsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; AC_MSG_ERROR([Incomplete OpenSSL FIPS installation; missing fipsld])<=
o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; fi<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; AC_SUBST([FIPSLD_CC], [&quot;${CC}&quot;])<o:p></o:p></p><=
p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AC_SUBST=
([CC], [&quot;${OPENSSLDIR}/fips-2.0/bin/fipsld&quot;])<o:p></o:p></p><p cl=
ass=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; export CC<o:=
p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; export FIPSLD_CC<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; AC_DEFINE([ENABLE_FIPS], [1], [Enable OpenSSL =
FIPS 2.0 Options])<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp=
; fi<o:p></o:p></p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPl=
ainText> &nbsp;&nbsp;&nbsp; CFLAGS=3D&quot;${saved_CFLAGS}&quot;<o:p></o:p>=
</p><p class=3DMsoPlainText> &nbsp;&nbsp;&nbsp; LIBS=3D&quot;${saved_LIBS}&=
quot;<o:p></o:p></p><p class=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoP=
lainText>@@ -1373,6 +1413,7 @@ AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [te=
st &quot;${enable_plugin_auth_pam}&quot; =3D &quot;ye<o:p></o:p></p><p clas=
s=3DMsoPlainText> AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test &quot;${e=
nable_plugin_down_root}&quot; =3D &quot;yes&quot;])<o:p></o:p></p><p class=
=3DMsoPlainText> AM_CONDITIONAL([ENABLE_CRYPTO], [test &quot;${enable_crypt=
o}&quot; =3D &quot;yes&quot;])<o:p></o:p></p><p class=3DMsoPlainText> AM_CO=
NDITIONAL([HAVE_LD_WRAP_SUPPORT], [test &quot;${have_ld_wrap_support}&quot;=
 =3D &quot;yes&quot;])<o:p></o:p></p><p class=3DMsoPlainText>+AM_CONDITIONA=
L([FIPSMODE], [test &quot;${enable_fips_mode}&quot; =3D &quot;yes&quot;])<o=
:p></o:p></p><p class=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainTex=
t>&nbsp;sampledir=3D&quot;\$(docdir)/sample&quot;<o:p></o:p></p><p class=3D=
MsoPlainText> AC_SUBST([plugindir])<o:p></o:p></p><p class=3DMsoPlainText>@=
@ -1441,4 +1482,5 @@ AC_CONFIG_FILES([<o:p></o:p></p><p class=3DMsoPlainTex=
t> &nbsp;&nbsp;&nbsp; sample/Makefile<o:p></o:p></p><p class=3DMsoPlainText=
> ])<o:p></o:p></p><p class=3DMsoPlainText> AC_CONFIG_FILES([tests/t_client=
.sh], [chmod +x tests/t_client.sh])<o:p></o:p></p><p class=3DMsoPlainText>+=
<o:p></o:p></p><p class=3DMsoPlainText> AC_OUTPUT<o:p></o:p></p><p class=3D=
MsoPlainText>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c<o:p><=
/o:p></p><p class=3DMsoPlainText>index 3f3caa1..0c05859 100644<o:p></o:p></=
p><p class=3DMsoPlainText>--- a/src/openvpn/crypto.c<o:p></o:p></p><p class=
=3DMsoPlainText>+++ b/src/openvpn/crypto.c<o:p></o:p></p><p class=3DMsoPlai=
nText>@@ -854,7 +854,7 @@ init_key_ctx(struct key_ctx *ctx, const struct ke=
y *key,<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; if (=
kt-&gt;digest &amp;&amp; kt-&gt;hmac_length &gt; 0)<o:p></o:p></p><p class=
=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p><p class=3DMsoPlai=
nText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;hmac =3D hma=
c_ctx_new();<o:p></o:p></p><p class=3DMsoPlainText>-&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hmac_ctx_init(ctx-&gt;hmac, key-&gt;hmac, kt-&gt;hmac_l=
ength, kt-&gt;digest);<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hmac_ctx_init(ctx-&gt;hmac, key-&gt;hmac, kt-=
&gt;hmac_length, kt-&gt;digest, false);<o:p></o:p></p><p class=3DMsoPlainTe=
xt> <o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;msg(D_HANDSHAKE,<o:p></o:p></p><p class=3DMsoPlainTex=
t>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;%s: Using %d bit message hash '%s' for HMAC authentication&quot;,<o:p=
></o:p></p><p class=3DMsoPlainText>diff --git a/src/openvpn/crypto_backend.=
h b/src/openvpn/crypto_backend.h<o:p></o:p></p><p class=3DMsoPlainText>inde=
x 567fd9b..d92ab7c 100644<o:p></o:p></p><p class=3DMsoPlainText>--- a/src/o=
penvpn/crypto_backend.h<o:p></o:p></p><p class=3DMsoPlainText>+++ b/src/ope=
nvpn/crypto_backend.h<o:p></o:p></p><p class=3DMsoPlainText>@@ -604,10 +604=
,11 @@ void hmac_ctx_free(hmac_ctx_t *ctx);<o:p></o:p></p><p class=3DMsoPla=
inText>&nbsp; * @param key&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; The key to use for the HMAC<o:p></o:p></p><p class=3DMsoPlainTe=
xt>&nbsp; * @param key_len&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The key leng=
th to use<o:p></o:p></p><p class=3DMsoPlainText>&nbsp; * @param kt&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Static message di=
gest parameters<o:p></o:p></p><p class=3DMsoPlainText>+ * @param prf_use&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Intended use for PRF in TLS protocol<o:p>=
</o:p></p><p class=3DMsoPlainText>&nbsp; *<o:p></o:p></p><p class=3DMsoPlai=
nText>&nbsp; */<o:p></o:p></p><p class=3DMsoPlainText> void hmac_ctx_init(h=
mac_ctx_t *ctx, const uint8_t *key, int key_length,<o:p></o:p></p><p class=
=3DMsoPlainText>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;const md_kt_t *kt);<o:p>=
</o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const =
md_kt_t *kt, bool prf_use);<o:p></o:p></p><p class=3DMsoPlainText> <o:p></o=
:p></p><p class=3DMsoPlainText>&nbsp;/*<o:p></o:p></p><p class=3DMsoPlainTe=
xt>&nbsp; * Free the given HMAC context.<o:p></o:p></p><p class=3DMsoPlainT=
ext>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.=
c<o:p></o:p></p><p class=3DMsoPlainText>index 0134e55..caef17b 100644<o:p><=
/o:p></p><p class=3DMsoPlainText>--- a/src/openvpn/crypto_openssl.c<o:p></o=
:p></p><p class=3DMsoPlainText>+++ b/src/openvpn/crypto_openssl.c<o:p></o:p=
></p><p class=3DMsoPlainText>@@ -159,6 +159,17 @@ crypto_init_lib(void)<o:p=
></o:p></p><p class=3DMsoPlainText> #endif<o:p></o:p></p><p class=3DMsoPlai=
nText> }<o:p></o:p></p><p class=3DMsoPlainText> <o:p></o:p></p><p class=3DM=
soPlainText>+int<o:p></o:p></p><p class=3DMsoPlainText>+crypto_enable_fips_=
mode(int mode)<o:p></o:p></p><p class=3DMsoPlainText>+{<o:p></o:p></p><p cl=
ass=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; if (!FIPS_mode_set(mode)) {<o:p></o:=
p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ERR_print_errors_fp(stderr);<o:p></o:p></p><p class=3DMsoPlainText>+&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 1;<o:p></o:p></p><p c=
lass=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p=
></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; msg(M_INFO, &quot;**=
* IN FIPS MODE ***\n&quot;);<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&=
nbsp;&nbsp; return 0;<o:p></o:p></p><p class=3DMsoPlainText>+}<o:p></o:p></=
p><p class=3DMsoPlainText>+<o:p></o:p></p><p class=3DMsoPlainText> void<o:p=
></o:p></p><p class=3DMsoPlainText> crypto_uninit_lib(void)<o:p></o:p></p><=
p class=3DMsoPlainText> {<o:p></o:p></p><p class=3DMsoPlainText>@@ -926,11 =
+937,13 @@ hmac_ctx_free(HMAC_CTX *ctx)<o:p></o:p></p><p class=3DMsoPlainTe=
xt> <o:p></o:p></p><p class=3DMsoPlainText>&nbsp;void<o:p></o:p></p><p clas=
s=3DMsoPlainText> hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, int key_=
len,<o:p></o:p></p><p class=3DMsoPlainText>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const EVP_MD *kt)<o:p></o:p=
></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const EVP_MD *kt, bool prf_use)<o:p></o:p=
></p><p class=3DMsoPlainText> {<o:p></o:p></p><p class=3DMsoPlainText>&nbsp=
;&nbsp;&nbsp;&nbsp; ASSERT(NULL !=3D kt &amp;&amp; NULL !=3D ctx);<o:p></o:=
p></p><p class=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;HMAC_CTX_reset(ctx);<o:p></o:p></p><p class=3DMsoP=
lainText>+&nbsp;&nbsp;&nbsp; if (kt =3D=3D EVP_md5() &amp;&amp; prf_use)<o:=
p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; HMAC_CTX_set_flags(ctx, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);<o:p></o=
:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; HMAC_Init_ex(ctx, k=
ey, key_len, kt, NULL);<o:p></o:p></p><p class=3DMsoPlainText> <o:p></o:p><=
/p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* make sure we us=
ed a big enough key */<o:p></o:p></p><p class=3DMsoPlainText>diff --git a/s=
rc/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h<o:p></o:p></p><p=
 class=3DMsoPlainText>index 60a2812..11f3378 100644<o:p></o:p></p><p class=
=3DMsoPlainText>--- a/src/openvpn/crypto_openssl.h<o:p></o:p></p><p class=
=3DMsoPlainText>+++ b/src/openvpn/crypto_openssl.h<o:p></o:p></p><p class=
=3DMsoPlainText>@@ -102,4 +102,12 @@ void crypto_print_openssl_errors(const=
 unsigned int flags);<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nb=
sp;&nbsp; } while (false)<o:p></o:p></p><p class=3DMsoPlainText> <o:p></o:p=
></p><p class=3DMsoPlainText>&nbsp;<o:p></o:p></p><p class=3DMsoPlainText>+=
/**<o:p></o:p></p><p class=3DMsoPlainText>+ * Enable FIPS Mode. Returns non=
-zero to indicate an error.<o:p></o:p></p><p class=3DMsoPlainText>+ *<o:p><=
/o:p></p><p class=3DMsoPlainText>+ * @param mode&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Should be 1. Future versions of OpenSSL FIPS<o:p></o:=
p></p><p class=3DMsoPlainText>+ * &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp;code are expected to accept extended modes.<o:p></o:p></p>=
<p class=3DMsoPlainText>+ */<o:p></o:p></p><p class=3DMsoPlainText>+int cry=
pto_enable_fips_mode(int mode);<o:p></o:p></p><p class=3DMsoPlainText>+<o:p=
></o:p></p><p class=3DMsoPlainText> #endif /* CRYPTO_OPENSSL_H_ */<o:p></o:=
p></p><p class=3DMsoPlainText>diff --git a/src/openvpn/ntlm.c b/src/openvpn=
/ntlm.c<o:p></o:p></p><p class=3DMsoPlainText>index 077fa3e..fe39ab1 100644=
<o:p></o:p></p><p class=3DMsoPlainText>--- a/src/openvpn/ntlm.c<o:p></o:p><=
/p><p class=3DMsoPlainText>+++ b/src/openvpn/ntlm.c<o:p></o:p></p><p class=
=3DMsoPlainText>@@ -88,7 +88,7 @@ gen_hmac_md5(const uint8_t *data, int dat=
a_len, const uint8_t *key, int key_len,<o:p></o:p></p><p class=3DMsoPlainTe=
xt>&nbsp;&nbsp;&nbsp;&nbsp; const md_kt_t *md5_kt =3D md_kt_get(&quot;MD5&q=
uot;);<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; hmac_=
ctx_t *hmac_ctx =3D hmac_ctx_new();<o:p></o:p></p><p class=3DMsoPlainText> =
<o:p></o:p></p><p class=3DMsoPlainText>-&nbsp;&nbsp;&nbsp; hmac_ctx_init(hm=
ac_ctx, key, key_len, md5_kt);<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp=
;&nbsp;&nbsp; hmac_ctx_init(hmac_ctx, key, key_len, md5_kt, false);<o:p></o=
:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; hmac_ctx_update(hma=
c_ctx, data, data_len);<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&=
nbsp;&nbsp; hmac_ctx_final(hmac_ctx, result);<o:p></o:p></p><p class=3DMsoP=
lainText>&nbsp;&nbsp;&nbsp;&nbsp; hmac_ctx_cleanup(hmac_ctx);<o:p></o:p></p=
><p class=3DMsoPlainText>diff --git a/src/openvpn/openvpn.c b/src/openvpn/o=
penvpn.c<o:p></o:p></p><p class=3DMsoPlainText>index e237ee5..beb1d2a 10064=
4<o:p></o:p></p><p class=3DMsoPlainText>--- a/src/openvpn/openvpn.c<o:p></o=
:p></p><p class=3DMsoPlainText>+++ b/src/openvpn/openvpn.c<o:p></o:p></p><p=
 class=3DMsoPlainText>@@ -210,6 +210,13 @@ openvpn_main(int argc, char *arg=
v[])<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* parse command line options, and=
 read configuration file */<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parse_argv(=
&amp;c.options, argc, argv, M_USAGE, OPT_P_DEFAULT, NULL, c.es);<o:p></o:p>=
</p><p class=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>+#if EN=
ABLE_FIPS<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (c.options.fips_mode) {<o=
:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enabl=
e_fips_mode(c.options.fips_mode)) {<o:p></o:p></p><p class=3DMsoPlainText>+=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p>=
</p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; }<o:p></o:p></p><p class=3DMsoPlainText>+#endif<o:p></o:p></p><p clas=
s=3DMsoPlainText> #ifdef ENABLE_PLUGIN<o:p></o:p></p><p class=3DMsoPlainTex=
t>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* plugins may contribute options configuration */<o:p></o:p></p><p class=
=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; init_verb_mute(&amp;c, IVM_LEVEL_1);<o:p></o:p></p><p class=
=3DMsoPlainText>diff --git a/src/openvpn/options.c b/src/openvpn/options.c<=
o:p></o:p></p><p class=3DMsoPlainText>index 8e5cdf7..8a1501c 100644<o:p></o=
:p></p><p class=3DMsoPlainText>--- a/src/openvpn/options.c<o:p></o:p></p><p=
 class=3DMsoPlainText>+++ b/src/openvpn/options.c<o:p></o:p></p><p class=3D=
MsoPlainText>@@ -522,6 +522,11 @@ static const char usage_message[] =3D<o:p=
></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; &quot;\n&quot;<=
o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; &quot;Data C=
hannel Encryption Options (must be compatible between peers):\n&quot;<o:p><=
/o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; &quot;(These opti=
ons are meaningful for both Static Key &amp; TLS-mode)\n&quot;<o:p></o:p></=
p><p class=3DMsoPlainText>+#ifdef ENABLE_FIPS<o:p></o:p></p><p class=3DMsoP=
lainText>+&nbsp;&nbsp;&nbsp; &quot;--enable-fips-mode : Enable OpenSSL FIPS=
 Object Module v2.0.\n&quot;<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&=
nbsp;&nbsp; &quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;Setting this on the server wi=
ll enforce FIPS validated\n&quot;<o:p></o:p></p><p class=3DMsoPlainText>+&n=
bsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encryption on both clien=
t and server.\n&quot;<o:p></o:p></p><p class=3DMsoPlainText>+#endif<o:p></o=
:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; &quot;--secret f [d=
]&nbsp; : Enable Static Key encryption mode (non-TLS).\n&quot;<o:p></o:p></=
p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; Use shared secret file f, generate with --genkey.\n&quot;<o:p></o=
:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; &quot;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; The optional d parameter controls key directionality.\n&quot=
;<o:p></o:p></p><p class=3DMsoPlainText>@@ -854,6 +859,9 @@ init_options(st=
ruct options *o, const bool init_gc)<o:p></o:p></p><p class=3DMsoPlainText>=
 #endif<o:p></o:p></p><p class=3DMsoPlainText> #ifdef ENABLE_CRYPTO<o:p></o=
:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; o-&gt;ciphername =
=3D &quot;BF-CBC&quot;;<o:p></o:p></p><p class=3DMsoPlainText>+#ifdef ENABL=
E_FIPS<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; o-&gt;fips=
_mode =3D 0;<o:p></o:p></p><p class=3DMsoPlainText>+#endif<o:p></o:p></p><p=
 class=3DMsoPlainText> #ifdef HAVE_AEAD_CIPHER_MODES /* IV_NCP=3D2 requires=
 GCM support */<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nb=
sp; o-&gt;ncp_enabled =3D true;<o:p></o:p></p><p class=3DMsoPlainText> #els=
e<o:p></o:p></p><p class=3DMsoPlainText>@@ -1561,6 +1569,7 @@ show_settings=
(const struct options *o)<o:p></o:p></p><p class=3DMsoPlainText> #endif<o:p=
></o:p></p><p class=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>=
&nbsp;#ifdef ENABLE_CRYPTO<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nb=
sp;&nbsp; SHOW_INT(fips_mode);<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;=
&nbsp;&nbsp;&nbsp; SHOW_BOOL(show_ciphers);<o:p></o:p></p><p class=3DMsoPla=
inText>&nbsp;&nbsp;&nbsp;&nbsp; SHOW_BOOL(show_digests);<o:p></o:p></p><p c=
lass=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; SHOW_BOOL(show_engines);<o:p><=
/o:p></p><p class=3DMsoPlainText>@@ -7442,6 +7451,13 @@ add_option(struct o=
ptions *options,<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&n=
bsp; }<o:p></o:p></p><p class=3DMsoPlainText> #endif /* USE_COMP */<o:p></o=
:p></p><p class=3DMsoPlainText> #ifdef ENABLE_CRYPTO<o:p></o:p></p><p class=
=3DMsoPlainText>+#ifdef ENABLE_FIPS<o:p></o:p></p><p class=3DMsoPlainText>+=
&nbsp;&nbsp;&nbsp; else if (streq(p[0], &quot;enable-fips-mode&quot;) &amp;=
&amp; !p[1])<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; {<o:=
p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; VERIFY_PERMISSION(OPT_P_GENERAL);<o:p></o:p></p><p class=3DMsoPlainTex=
t>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; options-&gt;fips_mode =
=3D 1;<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; }<o:p></o:=
p></p><p class=3DMsoPlainText>+#endif<o:p></o:p></p><p class=3DMsoPlainText=
>&nbsp;&nbsp;&nbsp;&nbsp; else if (streq(p[0], &quot;show-ciphers&quot;) &a=
mp;&amp; !p[1])<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nb=
sp; {<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; VERIFY_PERMISSION(OPT_P_GENERAL);<o:p></o:p></p><p class=
=3DMsoPlainText>diff --git a/src/openvpn/options.h b/src/openvpn/options.h<=
o:p></o:p></p><p class=3DMsoPlainText>index 035c6d1..55d2248 100644<o:p></o=
:p></p><p class=3DMsoPlainText>--- a/src/openvpn/options.h<o:p></o:p></p><p=
 class=3DMsoPlainText>+++ b/src/openvpn/options.h<o:p></o:p></p><p class=3D=
MsoPlainText>@@ -189,6 +189,7 @@ struct options<o:p></o:p></p><p class=3DMs=
oPlainText>&nbsp;&nbsp;&nbsp;&nbsp; int persist_mode;<o:p></o:p></p><p clas=
s=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>&nbsp;#ifdef ENABL=
E_CRYPTO<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; int fips=
_mode;<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; const=
 char *key_pass_file;<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nb=
sp;&nbsp; bool show_ciphers;<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&n=
bsp;&nbsp;&nbsp; bool show_digests;<o:p></o:p></p><p class=3DMsoPlainText>d=
iff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c<o:p></o:p></p><p class=3D=
MsoPlainText>index 843bc39..6a212b8 100644<o:p></o:p></p><p class=3DMsoPlai=
nText>--- a/src/openvpn/ssl.c<o:p></o:p></p><p class=3DMsoPlainText>+++ b/s=
rc/openvpn/ssl.c<o:p></o:p></p><p class=3DMsoPlainText>@@ -354,6 +354,14 @@=
 init_ssl_lib(void)<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp=
;&nbsp; crypto_init_lib();<o:p></o:p></p><p class=3DMsoPlainText> }<o:p></o=
:p></p><p class=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>+#if=
 ENABLE_FIPS<o:p></o:p></p><p class=3DMsoPlainText>+int<o:p></o:p></p><p cl=
ass=3DMsoPlainText>+enable_fips_mode(int mode)<o:p></o:p></p><p class=3DMso=
PlainText>+{<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; retu=
rn crypto_enable_fips_mode(mode);<o:p></o:p></p><p class=3DMsoPlainText>+}<=
o:p></o:p></p><p class=3DMsoPlainText>+#endif<o:p></o:p></p><p class=3DMsoP=
lainText>+<o:p></o:p></p><p class=3DMsoPlainText> void<o:p></o:p></p><p cla=
ss=3DMsoPlainText> free_ssl_lib(void)<o:p></o:p></p><p class=3DMsoPlainText=
> {<o:p></o:p></p><p class=3DMsoPlainText>@@ -1640,8 +1648,8 @@ tls1_P_hash=
(const md_kt_t *md_kt,<o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&nbsp;&n=
bsp;&nbsp; chunk =3D md_kt_size(md_kt);<o:p></o:p></p><p class=3DMsoPlainTe=
xt>&nbsp;&nbsp;&nbsp;&nbsp; A1_len =3D md_kt_size(md_kt);<o:p></o:p></p><p =
class=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>-&nbsp;&nbsp;&=
nbsp; hmac_ctx_init(ctx, sec, sec_len, md_kt);<o:p></o:p></p><p class=3DMso=
PlainText>-&nbsp;&nbsp;&nbsp; hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt);<=
o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp; hmac_ctx_init(ctx=
, sec, sec_len, md_kt, true);<o:p></o:p></p><p class=3DMsoPlainText>+&nbsp;=
&nbsp;&nbsp; hmac_ctx_init(ctx_tmp, sec, sec_len, md_kt, true);<o:p></o:p><=
/p><p class=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;hmac_ctx_update(ctx,seed,seed_len);<o:p></o:p></p><p =
class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp; hmac_ctx_final(ctx, A1);<o:p>=
</o:p></p><p class=3DMsoPlainText>diff --git a/src/openvpn/ssl.h b/src/open=
vpn/ssl.h<o:p></o:p></p><p class=3DMsoPlainText>index 0e0f68f..ae23423 1006=
44<o:p></o:p></p><p class=3DMsoPlainText>--- a/src/openvpn/ssl.h<o:p></o:p>=
</p><p class=3DMsoPlainText>+++ b/src/openvpn/ssl.h<o:p></o:p></p><p class=
=3DMsoPlainText>@@ -600,6 +600,10 @@ bool is_hard_reset(int op, int key_met=
hod);<o:p></o:p></p><p class=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoP=
lainText>&nbsp;void delayed_auth_pass_purge(void);<o:p></o:p></p><p class=
=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>+#if ENABLE_FIPS<o:=
p></o:p></p><p class=3DMsoPlainText>+int enable_fips_mode(int mode);<o:p></=
o:p></p><p class=3DMsoPlainText>+#endif<o:p></o:p></p><p class=3DMsoPlainTe=
xt>+<o:p></o:p></p><p class=3DMsoPlainText> #endif /* ENABLE_CRYPTO */<o:p>=
</o:p></p><p class=3DMsoPlainText> <o:p></o:p></p><p class=3DMsoPlainText>&=
nbsp;#endif /* ifndef OPENVPN_SSL_H */<o:p></o:p></p><p class=3DMsoPlainTex=
t>-- <o:p></o:p></p><p class=3DMsoPlainText>2.1.4<o:p></o:p></p><p class=3D=
MsoPlainText><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span style=3D'font-=
family:"Courier New"'><o:p>&nbsp;</o:p></span></p></div></body></html>=

------=_NextPart_001_0400_01D3651D.09DA6140--

------=_NextPart_000_03FF_01D3651D.09DA6140
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIOETCCBDYw
ggMeoAMCAQICAQEwDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UEBhMCU0UxFDASBgNVBAoTC0FkZFRy
dXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5hbCBUVFAgTmV0d29yazEiMCAGA1UEAxMZ
QWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0wMDA1MzAxMDQ4MzhaFw0yMDA1MzAxMDQ4Mzha
MG8xCzAJBgNVBAYTAlNFMRQwEgYDVQQKEwtBZGRUcnVzdCBBQjEmMCQGA1UECxMdQWRkVHJ1c3Qg
RXh0ZXJuYWwgVFRQIE5ldHdvcmsxIjAgBgNVBAMTGUFkZFRydXN0IEV4dGVybmFsIENBIFJvb3Qw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC39xoz5vIABC054E5b7R+8bA/Ntfojts7e
mxEzl6QpTH2Tn71KvJPtAxrjj8/lbVBa1pcplFqAsEl62y6V/bjKvzc4LR4+kUGtcFbH8E8/6DKe
dMrIkFTpxl8PeJ2aQDwOrGGqXhSPnoehalDc15pOrwWzpnGUnHGzUGAKxxOdOAeGAqjpqGkmGJCr
TLBPI6s6T4TY386f4Wlvu9dC12tE5Met7m1BX3JacQg3s3llpFmglDf3AC8NwpJy2tA4ctsUqEXE
XSp9t7TWxO6szRNEt8kr3UMAJfphuWlqWCMRt6czj1Z1WfXNKddGtworZbbTQm8Vsrh7++/pXVPV
NFonAgMBAAGjgdwwgdkwHQYDVR0OBBYEFK29mHo0tCb3+sQmVO8DveAky1QaMAsGA1UdDwQEAwIB
BjAPBgNVHRMBAf8EBTADAQH/MIGZBgNVHSMEgZEwgY6AFK29mHo0tCb3+sQmVO8DveAky1QaoXOk
cTBvMQswCQYDVQQGEwJTRTEUMBIGA1UEChMLQWRkVHJ1c3QgQUIxJjAkBgNVBAsTHUFkZFRydXN0
IEV4dGVybmFsIFRUUCBOZXR3b3JrMSIwIAYDVQQDExlBZGRUcnVzdCBFeHRlcm5hbCBDQSBSb290
ggEBMA0GCSqGSIb3DQEBBQUAA4IBAQCwm+CFJcLWI+IPlgaSnUGYnNmEeYHZHlsUByM2ZY+w2He7
rEFsR2CDUbD5Mj3n/PYmE8eAFqW/WvyHz3h5iSGa4kwHCoY1vPLeUcTSlrfcfk7ucP0cOesMAlEU
LY69FuDB30Z15ySt7PRCtIWTcBBnup0GNUoY0yt6zFFCoXpj0ea7ocUrwja+Ew3mvWN+eXunCQ1A
q2rdj4rD9vaMGkIFUdRF9Z+nYiFoFSBDPJnnfL0k2KmRF3OIP1YbMTgYtHEPms3IDp6OLhvhjJiD
yx8x8URMxgRzSXZgD8f4vReAay7pzEwOWpp5DyAKLtWeYyYeVZKU2IIXWnvQvMePToYEMIIErzCC
A5egAwIBAgIRAOAjyxUSg1OJrWFuelRnayEwDQYJKoZIhvcNAQELBQAwbzELMAkGA1UEBhMCU0Ux
FDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5hbCBUVFAgTmV0
d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0xNDEyMjIwMDAwMDBa
Fw0yMDA1MzAxMDQ4MzhaMIGbMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UE
AxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCJsQ3aelMZTnBSHbxWpgYmt7hJ4Jbn
Uavx8FoTSRWjtIwbYLx6UUKneYykIt8XYU6R1XYjChTTSgJ/th0JgG6lBD3ZursW/qGHqS5DUkMW
fK8yUMimT1rpCNjPkyWce4joMGTmpPhWgP0qJBQzF5msROVpi6NGBkvCM9TpQJ8GsLGsk0C5tQiT
OpwqU6MQ2z0gYTxVA47ZTnYlAiEp+qN8cXZP7uFfgen7VIDbw3s1UreE3iI9LDAtMX9ZvVI3sDNp
LUPr+tal8Zd3Z1GM2e4n67ylBzh2jKSpOP/fjPUDrEm+yvdzmToPMquclToTPQ5GOld0YVC+xkA/
y+Tin6IhAgMBAAGjggEXMIIBEzAfBgNVHSMEGDAWgBStvZh6NLQm9/rEJlTvA73gJMtUGjAdBgNV
HQ4EFgQUkmFrguGioKpP7GfxwqP3tIAAwewwDgYDVR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYB
Af8CAQAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBEGA1UdIAQKMAgwBgYEVR0gADBE
BgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vQWRkVHJ1c3RFeHRlcm5h
bENBUm9vdC5jcmwwNQYIKwYBBQUHAQEEKTAnMCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2Vy
dHJ1c3QuY29tMA0GCSqGSIb3DQEBCwUAA4IBAQAbKm6sVcE6q4jF2O3NVfOqa2ErwAkQI5kPxWZq
b7H1tLV3Xg8CYQDffQX+ErOkgIAA/PsdW2pyAgpBvAW6wVjVJsLq1U2E+/6CmM9YG+MiY5xS+LsF
Nqt9WKXeqztj5drVc+/s4Pt74qP/8EIjnMq2jU0+5EsYA7KoLdTYu0JLkGmFENumNzToe+ABEKWc
yjrHn0+ING6KZdAairup3MrKNtH0/MJkKTWv1rGncRHSA0Oxjz6a7J4yU/R2ksqGNAe5LMrmHErY
mQ3BhuKQkvtaQmojIRDpZcf11bt+6oyFIAJi6tE6ByxZxZkz8jiJ5bbpFnofeRT2ShAaJvp8ivub
MIIFIDCCBAigAwIBAgIRAILNSHab46DG1Bne+wGXvqwwDQYJKoZIhvcNAQELBQAwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xNzAxMTgwMDAwMDBaFw0yMDAx
MTgyMzU5NTlaMCAxHjAcBgkqhkiG9w0BCQEWD2ppbUBjYXJyb2xsLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALebl59lytkEMwbYCpX4f+APmWZ2zYPs/ol2IqDudAEz9bJ6Juzu
jlrxxsK28J4K7Ta1DrGy0C9XA+IZP9ccJk9xjE9+jxiJ3WGnod9BzJCDi4DgRxJ6yurFAesB+U0U
FKXzoUDsZ3KU0EVcK1yF80/VWuHanck5o2NZOdHiul1CHF05L79s56diejh9ukV4xIPiWnJELOUV
SYUvi1UiuwGm+/nRMF+CEOM/ACJoxBr/p3AaOdQCqTY+yGBBKoDE2eCo8hK7sAdomKGbnSsHcYK+
0Fi5LXzOTk7ewdnUvKDbLjUeM9xYHt4ShZgnEDsjHV93sUE56fd26LoCi/TTbG0CAwEAAaOCAdcw
ggHTMB8GA1UdIwQYMBaAFJJha4LhoqCqT+xn8cKj97SAAMHsMB0GA1UdDgQWBBSzewP0b4CAvRYt
sIWY2rg6IXcRSTAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2Ny
bC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVF
bWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMwgYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxD
QS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAaBgNVHREEEzARgQ9q
aW1AY2Fycm9sbC5jb20wDQYJKoZIhvcNAQELBQADggEBAH3TTAUCNH5TyxLPeawmzjgSYVTR5AR2
oCdfKgC9u6XLR4Gb0tkJPdrzcTi6uR4cKFmhmV00Yg8ZG5J3XGtSYOMnmPVM2HBClcNCIL6x1Gcz
m5eVSJcYIoQkWOyicVCVsDlooN7Ypi9a3X3QJZc2o2ehTvmM49cNI4zVBRac25ePxNL86hbA84a8
PKDVZaEqkJYzO06SQaxIBj16Ll7hBN2WL5ZLZ/DSj4AnUjXskMKek/0fqf4OX+GtIK6ldLV4E/JX
+aUNVnqjv7n5jKXPUnIEIQcnIiPYmvcdMF8t8N2KKL7rrtcFosghyWZMdo1A5/n1TwilB7qb3502
6ZX+fdwxggQjMIIEHwIBATCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAgs1IdpvjoMbUGd77AZe+rDAJBgUrDgMCGgUAoIICRjAYBgkqhkiG9w0BCQMxCwYJ
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNzExMjQxNzA5MTFaMCMGCSqGSIb3DQEJBDEWBBSz
RR6hUGs0AetrnFKOTPs61vCy4TBbBgkqhkiG9w0BCQ8xTjBMMAoGCCqGSIb3DQMHMA4GCCqGSIb3
DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAHBgUrDgMCGjCB
wgYJKwYBBAGCNxAEMYG0MIGxMIGbMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8G
A1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQCCzUh2m+OgxtQZ3vsBl76sMIHEBgsqhkiG9w0BCRACCzGBtKCBsTCBmzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBB
dXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAgs1IdpvjoMbUGd77AZe+rDANBgkq
hkiG9w0BAQEFAASCAQBQ0DlRdGEgQoZx9zyEudPTSnuvsp/65tWnS90wosKGTJMDTmbJlesec+Zd
G42nda8LNNqwluA29jI5o/pVD5N63qv/Zgo54ZEjJvr3W4kg2jup74Tym/HGps48yVWXukl2+m6q
mdTsv2QrTdoSxKHCqkyKkj1PvLUiLLY5RW6aitUvyJ/BXrHJJef5crNJOvRD2qqpdGI85xblRLH6
LbolO2gbmLMI17Nu+0x9iIzr49LVk2eRmkwekH+0BYl5RlH8AkMSemyqXOsQhx6lGiJF/wb1ALpw
hN58UxUzBx+ang+zVRVpGLm5IVpsbb9hR6b8ZTqkmU0vXs5OqQMfVpKUAAAAAAAA

------=_NextPart_000_03FF_01D3651D.09DA6140--


