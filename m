From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 12:00:39 +0000
References: <gerrit.1765800034000.I3f661cf305c52652e430b8d219df5186dd8ea4f7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4da7769a92d8688b3ce7e8f00d2de9fa241fde8a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P/NNydLroSw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: remove
 ENABLE_X509ALTUSERNAME conditional
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--P/NNydLroSw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1442?usp=3Demail

to review the following change.


Change subject: remove ENABLE_X509ALTUSERNAME conditional
......................................................................

remove ENABLE_X509ALTUSERNAME conditional

This is one of the #ifdef producing compile-time variants that make the
code harder to read and harder to test.  The extra code size due to
turning it on is marginal.

The mbedTLS backend does not (yet) support it.  To cope with that,
add a minimum function x509_username_field_ext_supported() that always
returns "false", and omit the --x509-username-field from the help
text if ENABLE_CRYPTO_MBEDTLS.  Implement this on another day.

Github: closes OpenVPN/openvpn#917

Change-Id: I3f661cf305c52652e430b8d219df5186dd8ea4f7
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/ssl_common.h
M src/openvpn/ssl_verify_backend.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
10 files changed, 7 insertions(+), 50 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1442/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index bdb1904..181c112 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -325,8 +325,6 @@
         target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})
         target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIR=
S}/wolfssl)
     else ()
-        set(ENABLE_X509ALTUSERNAME YES)
-
         find_package(OpenSSL REQUIRED)
         target_link_libraries(${target} PUBLIC OpenSSL::SSL OpenSSL::Crypt=
o)
         if (WIN32)
@@ -365,10 +363,8 @@
 elseif (${WOLFSSL})
     set(ENABLE_CRYPTO_OPENSSL YES)
     set(ENABLE_CRYPTO_WOLFSSL YES)
-    set(ENABLE_X509ALTUSERNAME YES)
 else ()
     set(ENABLE_CRYPTO_OPENSSL YES)
-    set(ENABLE_X509ALTUSERNAME YES)
 endif ()

 include_directories(${CMAKE_CURRENT_SOURCE_DIR} src/compat include)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 53c3598..ee5936a 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -62,9 +62,6 @@
 /* Enable systemd integration */
 /* #undef ENABLE_SYSTEMD */

-/* Enable --x509-username-field feature */
-#cmakedefine ENABLE_X509ALTUSERNAME
-
 /* Define to 1 if you have the <arpa/inet.h> header file. */
 #cmakedefine HAVE_ARPA_INET_H 1

diff --git a/configure.ac b/configure.ac
index d5a0c70..9beae5a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -88,13 +88,6 @@
 )

 AC_ARG_ENABLE(
-	[x509-alt-username],
-	[AS_HELP_STRING([--enable-x509-alt-username], [enable the --x509-username=
-field feature @<:@default=3Dno@:>@])],
-	,
-	[enable_x509_alt_username=3D"no"]
-)
-
-AC_ARG_ENABLE(
 	[dns-updown-by-default],
 	[AS_HELP_STRING([--disable-dns-updown-by-default], [disable running --dns=
-updown by default @<:@default=3Dyes@:>@])],
 	,
@@ -1186,15 +1179,6 @@
 fi
 AC_MSG_RESULT([${GIT_CHECKOUT}])

-dnl enable --x509-username-field feature if requested
-if test "${enable_x509_alt_username}" =3D "yes"; then
-	if test "${with_crypto_library}" =3D "mbedtls" ; then
-		AC_MSG_ERROR([mbed TLS does not support the --x509-username-field featur=
e])
-	fi
-
-	AC_DEFINE([ENABLE_X509ALTUSERNAME], [1], [Enable --x509-username-field fe=
ature])
-fi
-
 test "${enable_management}" =3D "yes" && AC_DEFINE([ENABLE_MANAGEMENT], [1=
], [Enable management server capability])
 test "${enable_debug}" =3D "yes" && AC_DEFINE([ENABLE_DEBUG], [1], [Enable=
 debugging support])
 test "${enable_small}" =3D "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable=
 smaller executable size])
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cd01520..52e7592 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3328,11 +3328,7 @@
     to.verify_hash_algo =3D options->verify_hash_algo;
     to.verify_hash_depth =3D options->verify_hash_depth;
     to.verify_hash_no_ca =3D options->verify_hash_no_ca;
-#ifdef ENABLE_X509ALTUSERNAME
     memcpy(to.x509_username_field, options->x509_username_field, sizeof(to=
.x509_username_field));
-#else
-    to.x509_username_field[0] =3D X509_USERNAME_FIELD_DEFAULT;
-#endif
     to.es =3D c->c2.es;
     to.net_ctx =3D &c->net_ctx;

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 34af0d3..ead6c73 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -595,8 +595,6 @@
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--pkcs12 file   : PKCS#12 file containing local private key, local ce=
rtificate\n"
     "                  and optionally the root CA certificate.\n"
-#endif
-#ifdef ENABLE_X509ALTUSERNAME
     "--x509-username-field : Field in x509 certificate containing the user=
name.\n"
     "                        Default is CN in the Subject field.\n"
 #endif
@@ -885,9 +883,7 @@
     o->transition_window =3D 3600;
     o->tls_cert_profile =3D NULL;
     o->ecdh_curve =3D NULL;
-#ifdef ENABLE_X509ALTUSERNAME
     o->x509_username_field[0] =3D X509_USERNAME_FIELD_DEFAULT;
-#endif
 #ifdef ENABLE_PKCS11
     o->pkcs11_pin_cache_period =3D -1;
 #endif /* ENABLE_PKCS11 */
@@ -9073,7 +9069,6 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         x509_track_add(&options->x509_track, p[1], msglevel, &options->gc);
     }
-#ifdef ENABLE_X509ALTUSERNAME
     else if (streq(p[0], "x509-username-field") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
@@ -9088,7 +9083,6 @@
             options->x509_username_field[j - 1] =3D p[j];
         }
     }
-#endif /* ENABLE_X509ALTUSERNAME */
 #ifdef ENABLE_PKCS11
     else if (streq(p[0], "show-pkcs11-ids") && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 0561c25..8fab922 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -651,10 +651,8 @@
      * within n seconds of handshake initiation. */
     int handshake_window;

-#ifdef ENABLE_X509ALTUSERNAME
     /* Field list used to be the username in X509 cert. */
     char *x509_username_field[MAX_PARMS];
-#endif

     /* Old key allowed to live n seconds after new key goes active */
     int transition_window;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 3129299..3e2a4e8 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -360,11 +360,7 @@
     int verify_hash_depth;
     bool verify_hash_no_ca;
     hash_algo_type verify_hash_algo;
-#ifdef ENABLE_X509ALTUSERNAME
     char *x509_username_field[MAX_PARMS];
-#else
-    char *x509_username_field[2];
-#endif

     /* struct crypto_option flags */
     unsigned int crypto_flags;
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
index 1d56533..09fcadf 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -113,7 +113,7 @@
 /*
  * Retrieve the certificate's username from the specified field.
  *
- * If the field is prepended with ext: and ENABLE_X509ALTUSERNAME is enabl=
ed,
+ * If the field is prepended with ext: is enabled,
  * it will be loaded from an X.509 extension
  *
  * @param cn                    Buffer to return the common name in.
@@ -126,15 +126,12 @@
 result_t backend_x509_get_username(char *common_name, size_t cn_len, char =
*x509_username_field,
                                    openvpn_x509_cert_t *peer_cert);

-#ifdef ENABLE_X509ALTUSERNAME
 /**
  * Return true iff the supplied extension field is supported by the
  * --x509-username-field option.
  */
 bool x509_username_field_ext_supported(const char *extname);

-#endif
-
 /*
  * Return the certificate's serial number in decimal string representation.
  *
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 250c806..393e7da 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -123,9 +123,12 @@
     return 0;
 }

-#ifdef ENABLE_X509ALTUSERNAME
-#warning "X509 alt user name not yet supported for mbed TLS"
-#endif
+/* not supported for mbedTLS yet */
+bool
+x509_username_field_ext_supported(const char *fieldname)
+{
+    return false;
+}

 result_t
 backend_x509_get_username(char *cn, size_t cn_len, char *x509_username_fie=
ld, mbedtls_x509_crt *cert)
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 6cb04ee..9fdbe70 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -111,7 +111,6 @@
     return ret;
 }

-#ifdef ENABLE_X509ALTUSERNAME
 bool
 x509_username_field_ext_supported(const char *fieldname)
 {
@@ -180,7 +179,6 @@
     }
     return retval;
 }
-#endif /* ENABLE_X509ALTUSERNAME */

 /*
  * Extract a field from an X509 subject name.
@@ -252,7 +250,6 @@
 result_t
 backend_x509_get_username(char *common_name, size_t cn_len, char *x509_use=
rname_field, X509 *peer_cert)
 {
-#ifdef ENABLE_X509ALTUSERNAME
     if (strncmp("ext:", x509_username_field, 4) =3D=3D 0)
     {
         if (!extract_x509_extension(peer_cert, x509_username_field + 4, co=
mmon_name, cn_len))
@@ -275,7 +272,6 @@
         gc_free(&gc);
     }
     else
-#endif /* ifdef ENABLE_X509ALTUSERNAME */
     {
         X509_NAME *x509_subject_name =3D X509_get_subject_name(peer_cert);
         if (x509_subject_name =3D=3D NULL)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1442?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f661cf305c52652e430b8d219df5186dd8ea4f7
Gerrit-Change-Number: 1442
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--P/NNydLroSw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1442?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">remove ENABLE_X509ALTUSERNAME conditional<b=
r><br>This is one of the #ifdef producing compile-time variants that make t=
he<br>code harder to read and harder to test.  The extra code size due to<b=
r>turning it on is marginal.<br><br>The mbedTLS backend does not (yet) supp=
ort it.  To cope with that,<br>add a minimum function x509_username_field_e=
xt_supported() that always<br>returns &quot;false&quot;, and omit the --x50=
9-username-field from the help<br>text if ENABLE_CRYPTO_MBEDTLS.  Implement=
 this on another day.<br><br>Github: closes OpenVPN/openvpn#917<br><br>Chan=
ge-Id: I3f661cf305c52652e430b8d219df5186dd8ea4f7<br>Signed-off-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M config.h.cmake=
.in<br>M configure.ac<br>M src/openvpn/init.c<br>M src/openvpn/options.c<br=
>M src/openvpn/options.h<br>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl=
_verify_backend.h<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn/ss=
l_verify_openssl.c<br>10 files changed, 7 insertions(+), 50 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/42/1442/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</=
span><br><span>index bdb1904..181c112 100644</span><br><span>--- a/CMakeLis=
ts.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -325,8 +325,=
6 @@</span><br><span>         target_link_libraries(${target} PUBLIC ${wolf=
ssl_LINK_LIBRARIES})</span><br><span>         target_include_directories(${=
target} PRIVATE ${wolfssl_INCLUDE_DIRS}/wolfssl)</span><br><span>     else =
()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        set(ENABLE_=
X509ALTUSERNAME YES)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span>         find_package(OpenSSL REQUIRED)</span><br><span>   =
      target_link_libraries(${target} PUBLIC OpenSSL::SSL OpenSSL::Crypto)<=
/span><br><span>         if (WIN32)</span><br><span>@@ -365,10 +363,8 @@</s=
pan><br><span> elseif (${WOLFSSL})</span><br><span>     set(ENABLE_CRYPTO_O=
PENSSL YES)</span><br><span>     set(ENABLE_CRYPTO_WOLFSSL YES)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    set(ENABLE_X509ALTUSERNAME YE=
S)</span><br><span> else ()</span><br><span>     set(ENABLE_CRYPTO_OPENSSL =
YES)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set(ENABLE_X5=
09ALTUSERNAME YES)</span><br><span> endif ()</span><br><span> </span><br><s=
pan> include_directories(${CMAKE_CURRENT_SOURCE_DIR} src/compat include)</s=
pan><br><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br>=
<span>index 53c3598..ee5936a 100644</span><br><span>--- a/config.h.cmake.in=
</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -62,9 +62,6 @@<=
/span><br><span> /* Enable systemd integration */</span><br><span> /* #unde=
f ENABLE_SYSTEMD */</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-/* Enable --x509-username-field feature */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#cmakedefine ENABLE_X509ALTUSERNAME</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Def=
ine to 1 if you have the &lt;arpa/inet.h&gt; header file. */</span><br><spa=
n> #cmakedefine HAVE_ARPA_INET_H 1</span><br><span> </span><br><span>diff -=
-git a/configure.ac b/configure.ac</span><br><span>index d5a0c70..9beae5a 1=
00644</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac=
</span><br><span>@@ -88,13 +88,6 @@</span><br><span> )</span><br><span> </s=
pan><br><span> AC_ARG_ENABLE(</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	[x509-alt-username],</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	[AS_HELP_STRING([--enable-x509-alt-username], [enable the --x509-u=
sername-field feature @&lt;:@default=3Dno@:&gt;@])],</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	[enable_x509_alt_username=3D&quot;no&quot;]</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_AR=
G_ENABLE(</span><br><span> 	[dns-updown-by-default],</span><br><span> 	[AS_=
HELP_STRING([--disable-dns-updown-by-default], [disable running --dns-updow=
n by default @&lt;:@default=3Dyes@:&gt;@])],</span><br><span> 	,</span><br>=
<span>@@ -1186,15 +1179,6 @@</span><br><span> fi</span><br><span> AC_MSG_RE=
SULT([${GIT_CHECKOUT}])</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-dnl enable --x509-username-field feature if requested</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-if test &quot;${enable_=
x509_alt_username}&quot; =3D &quot;yes&quot;; then</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	if test &quot;${with_crypto_library}&quot; =
=3D &quot;mbedtls&quot; ; then</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-		AC_MSG_ERROR([mbed TLS does not support the --x509-username-fiel=
d feature])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	AC_DEFINE([ENABLE_X509ALTUSERNAME], [1], [Enable=
 --x509-username-field feature])</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> test &quot;${enable_management}&quot; =3D &quot;yes&quot; &amp;&a=
mp; AC_DEFINE([ENABLE_MANAGEMENT], [1], [Enable management server capabilit=
y])</span><br><span> test &quot;${enable_debug}&quot; =3D &quot;yes&quot; &=
amp;&amp; AC_DEFINE([ENABLE_DEBUG], [1], [Enable debugging support])</span>=
<br><span> test &quot;${enable_small}&quot; =3D &quot;yes&quot; &amp;&amp; =
AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])</span><br>=
<span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>=
index cd01520..52e7592 100644</span><br><span>--- a/src/openvpn/init.c</spa=
n><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -3328,11 +3328,7 @@=
</span><br><span>     to.verify_hash_algo =3D options-&gt;verify_hash_algo;=
</span><br><span>     to.verify_hash_depth =3D options-&gt;verify_hash_dept=
h;</span><br><span>     to.verify_hash_no_ca =3D options-&gt;verify_hash_no=
_ca;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_X50=
9ALTUSERNAME</span><br><span>     memcpy(to.x509_username_field, options-&g=
t;x509_username_field, sizeof(to.x509_username_field));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    to.x509_username_field[0] =3D X509_USERNAME_FIELD_DEF=
AULT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span>     to.es =3D c-&gt;c2.es;</span><br><span>     to.net_ctx =3D &amp=
;c-&gt;net_ctx;</span><br><span> </span><br><span>diff --git a/src/openvpn/=
options.c b/src/openvpn/options.c</span><br><span>index 34af0d3..ead6c73 10=
0644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/=
openvpn/options.c</span><br><span>@@ -595,8 +595,6 @@</span><br><span> #ifn=
def ENABLE_CRYPTO_MBEDTLS</span><br><span>     &quot;--pkcs12 file   : PKCS=
#12 file containing local private key, local certificate\n&quot;</span><br>=
<span>     &quot;                  and optionally the root CA certificate.\=
n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME=
</span><br><span>     &quot;--x509-username-field : Field in x509 certifica=
te containing the username.\n&quot;</span><br><span>     &quot;            =
            Default is CN in the Subject field.\n&quot;</span><br><span> #e=
ndif</span><br><span>@@ -885,9 +883,7 @@</span><br><span>     o-&gt;transit=
ion_window =3D 3600;</span><br><span>     o-&gt;tls_cert_profile =3D NULL;<=
/span><br><span>     o-&gt;ecdh_curve =3D NULL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</span><br><span>   =
  o-&gt;x509_username_field[0] =3D X509_USERNAME_FIELD_DEFAULT;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> #ifdef EN=
ABLE_PKCS11</span><br><span>     o-&gt;pkcs11_pin_cache_period =3D -1;</spa=
n><br><span> #endif /* ENABLE_PKCS11 */</span><br><span>@@ -9073,7 +9069,6 =
@@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><sp=
an>         x509_track_add(&amp;options-&gt;x509_track, p[1], msglevel, &am=
p;options-&gt;gc);</span><br><span>     }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</span><br><span>     else=
 if (streq(p[0], &quot;x509-username-field&quot;) &amp;&amp; p[1])</span><b=
r><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</=
span><br><span>@@ -9088,7 +9083,6 @@</span><br><span>             options-&=
gt;x509_username_field[j - 1] =3D p[j];</span><br><span>         }</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif =
/* ENABLE_X509ALTUSERNAME */</span><br><span> #ifdef ENABLE_PKCS11</span><b=
r><span>     else if (streq(p[0], &quot;show-pkcs11-ids&quot;) &amp;&amp; !=
p[3])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/optio=
ns.h b/src/openvpn/options.h</span><br><span>index 0561c25..8fab922 100644<=
/span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openv=
pn/options.h</span><br><span>@@ -651,10 +651,8 @@</span><br><span>      * w=
ithin n seconds of handshake initiation. */</span><br><span>     int handsh=
ake_window;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifdef ENABLE_X509ALTUSERNAME</span><br><span>     /* Field list us=
ed to be the username in X509 cert. */</span><br><span>     char *x509_user=
name_field[MAX_PARMS];</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span> </span><br><span>     /* Old key allowed to live n=
 seconds after new key goes active */</span><br><span>     int transition_w=
indow;</span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/=
ssl_common.h</span><br><span>index 3129299..3e2a4e8 100644</span><br><span>=
--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common=
.h</span><br><span>@@ -360,11 +360,7 @@</span><br><span>     int verify_has=
h_depth;</span><br><span>     bool verify_hash_no_ca;</span><br><span>     =
hash_algo_type verify_hash_algo;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</span><br><span>     char *x509_us=
ername_field[MAX_PARMS];</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *x50=
9_username_field[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span> </span><br><span>     /* struct crypto_option flags =
*/</span><br><span>     unsigned int crypto_flags;</span><br><span>diff --g=
it a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h</s=
pan><br><span>index 1d56533..09fcadf 100644</span><br><span>--- a/src/openv=
pn/ssl_verify_backend.h</span><br><span>+++ b/src/openvpn/ssl_verify_backen=
d.h</span><br><span>@@ -113,7 +113,7 @@</span><br><span> /*</span><br><span=
>  * Retrieve the certificate&#39;s username from the specified field.</spa=
n><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If =
the field is prepended with ext: and ENABLE_X509ALTUSERNAME is enabled,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If the field is prep=
ended with ext: is enabled,</span><br><span>  * it will be loaded from an X=
.509 extension</span><br><span>  *</span><br><span>  * @param cn           =
         Buffer to return the common name in.</span><br><span>@@ -126,15 +1=
26,12 @@</span><br><span> result_t backend_x509_get_username(char *common_n=
ame, size_t cn_len, char *x509_username_field,</span><br><span>            =
                        openvpn_x509_cert_t *peer_cert);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_X509ALTU=
SERNAME</span><br><span> /**</span><br><span>  * Return true iff the suppli=
ed extension field is supported by the</span><br><span>  * --x509-username-=
field option.</span><br><span>  */</span><br><span> bool x509_username_fiel=
d_ext_supported(const char *extname);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Return the cert=
ificate&#39;s serial number in decimal string representation.</span><br><sp=
an>  *</span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/=
openvpn/ssl_verify_mbedtls.c</span><br><span>index 250c806..393e7da 100644<=
/span><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ =
b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -123,9 +123,12 @@</sp=
an><br><span>     return 0;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#warning &quot;X509 alt =
user name not yet supported for mbed TLS&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* not supported for mbedTLS yet */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+x509_username_field_ext_supported(const char *fieldname)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> resu=
lt_t</span><br><span> backend_x509_get_username(char *cn, size_t cn_len, ch=
ar *x509_username_field, mbedtls_x509_crt *cert)</span><br><span>diff --git=
 a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</spa=
n><br><span>index 6cb04ee..9fdbe70 100644</span><br><span>--- a/src/openvpn=
/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_openssl.=
c</span><br><span>@@ -111,7 +111,6 @@</span><br><span>     return ret;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</span><br><span> bool</span><br><s=
pan> x509_username_field_ext_supported(const char *fieldname)</span><br><sp=
an> {</span><br><span>@@ -180,7 +179,6 @@</span><br><span>     }</span><br>=
<span>     return retval;</span><br><span> }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif /* ENABLE_X509ALTUSERNAME */</span><br><span>=
 </span><br><span> /*</span><br><span>  * Extract a field from an X509 subj=
ect name.</span><br><span>@@ -252,7 +250,6 @@</span><br><span> result_t</sp=
an><br><span> backend_x509_get_username(char *common_name, size_t cn_len, c=
har *x509_username_field, X509 *peer_cert)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</span=
><br><span>     if (strncmp(&quot;ext:&quot;, x509_username_field, 4) =3D=
=3D 0)</span><br><span>     {</span><br><span>         if (!extract_x509_ex=
tension(peer_cert, x509_username_field + 4, common_name, cn_len))</span><br=
><span>@@ -275,7 +272,6 @@</span><br><span>         gc_free(&amp;gc);</span=
><br><span>     }</span><br><span>     else</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_X509ALTUSERNAME */</span><br><=
span>     {</span><br><span>         X509_NAME *x509_subject_name =3D X509_=
get_subject_name(peer_cert);</span><br><span>         if (x509_subject_name=
 =3D=3D NULL)</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1442?usp=3Demail">change 1442</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1442?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f661cf305c52652e430b8d219d=
f5186dd8ea4f7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1442 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--P/NNydLroSw=--

