From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 14 Jan 2026 11:15:01 +0000
In-Reply-To: <gerrit.1765800034000.I3f661cf305c52652e430b8d219df5186dd8ea4f7@...2715...>
References: <gerrit.1765800034000.I3f661cf305c52652e430b8d219df5186dd8ea4f7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d773c63222d61d69778c12f436731dc1316e8609-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CK6deYukc4Q="; charset=UTF-8
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

--CK6deYukc4Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1442?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1442
Message-Id: <20260114110452.4976-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
237.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M Changes.rst
M config.h.cmake.in
M configure.ac
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/ssl_common.h
M src/openvpn/ssl_verify_backend.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
11 files changed, 10 insertions(+), 50 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1442/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index bdad173..e25ecae 100644
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
diff --git a/Changes.rst b/Changes.rst
index c8a3058..18d601f 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -346,6 +346,9 @@
 - The ``test-crypto`` option no longer requires a ``--secret`` argument and
   will automatically generate a random key.

+- The configure-time option ``--enable-x509-alt-username`` is no longer
+  conditional, and always-on (GH: OpenVPN/openvpn#917).
+

 Deprecated features
 -------------------
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 53976a7..ddf6174 100644
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
index 63d4d6e..2d8de7c 100644
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
@@ -1172,15 +1165,6 @@
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
index 4c23170..70c0b5d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3358,11 +3358,7 @@
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
index 3d86fc4..cede758 100644
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
@@ -9069,7 +9065,6 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         x509_track_add(&options->x509_track, p[1], msglevel, &options->gc);
     }
-#ifdef ENABLE_X509ALTUSERNAME
     else if (streq(p[0], "x509-username-field") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
@@ -9084,7 +9079,6 @@
             options->x509_username_field[j - 1] =3D p[j];
         }
     }
-#endif /* ENABLE_X509ALTUSERNAME */
 #ifdef ENABLE_PKCS11
     else if (streq(p[0], "show-pkcs11-ids") && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 9d89426..16cfdb5 100644
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
index 1cf254f..fba01bb 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -362,11 +362,7 @@
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
index 9cad320..0a2de03 100644
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
index 74b21b0..80396f8 100644
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
index 32e55e6..4f6573d 100644
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f661cf305c52652e430b8d219df5186dd8ea4f7
Gerrit-Change-Number: 1442
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CK6deYukc4Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change.</p><p><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1442?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">remove ENABLE_X509ALTUSERNAME c=
onditional<br><br>This is one of the #ifdef producing compile-time variants=
 that make the<br>code harder to read and harder to test.  The extra code s=
ize due to<br>turning it on is marginal.<br><br>The mbedTLS backend does no=
t (yet) support it.  To cope with that,<br>add a minimum function x509_user=
name_field_ext_supported() that always<br>returns &quot;false&quot;, and om=
it the --x509-username-field from the help<br>text if ENABLE_CRYPTO_MBEDTLS=
.  Implement this on another day.<br><br>Github: closes OpenVPN/openvpn#917=
<br><br>Change-Id: I3f661cf305c52652e430b8d219df5186dd8ea4f7<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Arne Schwabe &lt;arne=
-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn=
/+/1442<br>Message-Id: &lt;20260114110452.4976-1-gert@...1296...&gt;<br>URL=
: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35237=
.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CM=
akeLists.txt<br>M Changes.rst<br>M config.h.cmake.in<br>M configure.ac<br>M=
 src/openvpn/init.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<b=
r>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl_verify_backend.h<br>M src=
/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn/ssl_verify_openssl.c<br>11 f=
iles changed, 10 insertions(+), 50 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1442/2</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index bdad=
173..e25ecae 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>++=
+ b/CMakeLists.txt</span><br><span>@@ -325,8 +325,6 @@</span><br><span>    =
     target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})</spa=
n><br><span>         target_include_directories(${target} PRIVATE ${wolfssl=
_INCLUDE_DIRS}/wolfssl)</span><br><span>     else ()</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        set(ENABLE_X509ALTUSERNAME YES)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>        =
 find_package(OpenSSL REQUIRED)</span><br><span>         target_link_librar=
ies(${target} PUBLIC OpenSSL::SSL OpenSSL::Crypto)</span><br><span>        =
 if (WIN32)</span><br><span>@@ -365,10 +363,8 @@</span><br><span> elseif ($=
{WOLFSSL})</span><br><span>     set(ENABLE_CRYPTO_OPENSSL YES)</span><br><s=
pan>     set(ENABLE_CRYPTO_WOLFSSL YES)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    set(ENABLE_X509ALTUSERNAME YES)</span><br><span> else=
 ()</span><br><span>     set(ENABLE_CRYPTO_OPENSSL YES)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    set(ENABLE_X509ALTUSERNAME YES)</span=
><br><span> endif ()</span><br><span> </span><br><span> include_directories=
(${CMAKE_CURRENT_SOURCE_DIR} src/compat include)</span><br><span>diff --git=
 a/Changes.rst b/Changes.rst</span><br><span>index c8a3058..18d601f 100644<=
/span><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><=
br><span>@@ -346,6 +346,9 @@</span><br><span> - The ``test-crypto`` option =
no longer requires a ``--secret`` argument and</span><br><span>   will auto=
matically generate a random key.</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+- The configure-time option ``--enable-x509-=
alt-username`` is no longer</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  conditional, and always-on (GH: OpenVPN/openvpn#917).</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><s=
pan> Deprecated features</span><br><span> -------------------</span><br><sp=
an>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><span>index=
 53976a7..ddf6174 100644</span><br><span>--- a/config.h.cmake.in</span><br>=
<span>+++ b/config.h.cmake.in</span><br><span>@@ -62,9 +62,6 @@</span><br><=
span> /* Enable systemd integration */</span><br><span> /* #undef ENABLE_SY=
STEMD */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/* Enable --x509-username-field feature */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#cmakedefine ENABLE_X509ALTUSERNAME</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Define to 1 if=
 you have the &lt;arpa/inet.h&gt; header file. */</span><br><span> #cmakede=
fine HAVE_ARPA_INET_H 1</span><br><span> </span><br><span>diff --git a/conf=
igure.ac b/configure.ac</span><br><span>index 63d4d6e..2d8de7c 100644</span=
><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br>=
<span>@@ -88,13 +88,6 @@</span><br><span> )</span><br><span> </span><br><sp=
an> AC_ARG_ENABLE(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[x=
509-alt-username],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[A=
S_HELP_STRING([--enable-x509-alt-username], [enable the --x509-username-fie=
ld feature @&lt;:@default=3Dno@:&gt;@])],</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	[enable_x509_alt_username=3D&quot;no&quot;]</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_ARG_ENABLE(</s=
pan><br><span> 	[dns-updown-by-default],</span><br><span> 	[AS_HELP_STRING(=
[--disable-dns-updown-by-default], [disable running --dns-updown by default=
 @&lt;:@default=3Dyes@:&gt;@])],</span><br><span> 	,</span><br><span>@@ -11=
72,15 +1165,6 @@</span><br><span> fi</span><br><span> AC_MSG_RESULT([${GIT_=
CHECKOUT}])</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-dnl enable --x509-username-field feature if requested</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-if test &quot;${enable_x509_alt_use=
rname}&quot; =3D &quot;yes&quot;; then</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	if test &quot;${with_crypto_library}&quot; =3D &quot;mbed=
tls&quot; ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		AC_=
MSG_ERROR([mbed TLS does not support the --x509-username-field feature])</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	fi</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	AC_DEFINE([ENABLE_X509ALTUSERNAME], [1], [Enable --x509-userna=
me-field feature])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> test=
 &quot;${enable_management}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE(=
[ENABLE_MANAGEMENT], [1], [Enable management server capability])</span><br>=
<span> test &quot;${enable_debug}&quot; =3D &quot;yes&quot; &amp;&amp; AC_D=
EFINE([ENABLE_DEBUG], [1], [Enable debugging support])</span><br><span> tes=
t &quot;${enable_small}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([ENA=
BLE_SMALL], [1], [Enable smaller executable size])</span><br><span>diff --g=
it a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 4c23170.=
.70c0b5d 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>++=
+ b/src/openvpn/init.c</span><br><span>@@ -3358,11 +3358,7 @@</span><br><sp=
an>     to.verify_hash_algo =3D options-&gt;verify_hash_algo;</span><br><sp=
an>     to.verify_hash_depth =3D options-&gt;verify_hash_depth;</span><br><=
span>     to.verify_hash_no_ca =3D options-&gt;verify_hash_no_ca;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</=
span><br><span>     memcpy(to.x509_username_field, options-&gt;x509_usernam=
e_field, sizeof(to.x509_username_field));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    to.x509_username_field[0] =3D X509_USERNAME_FIELD_DEFAULT;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     to=
.es =3D c-&gt;c2.es;</span><br><span>     to.net_ctx =3D &amp;c-&gt;net_ctx=
;</span><br><span> </span><br><span>diff --git a/src/openvpn/options.c b/sr=
c/openvpn/options.c</span><br><span>index 3d86fc4..cede758 100644</span><br=
><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/option=
s.c</span><br><span>@@ -595,8 +595,6 @@</span><br><span> #ifndef ENABLE_CRY=
PTO_MBEDTLS</span><br><span>     &quot;--pkcs12 file   : PKCS#12 file conta=
ining local private key, local certificate\n&quot;</span><br><span>     &qu=
ot;                  and optionally the root CA certificate.\n&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</span><br><sp=
an>     &quot;--x509-username-field : Field in x509 certificate containing =
the username.\n&quot;</span><br><span>     &quot;                        De=
fault is CN in the Subject field.\n&quot;</span><br><span> #endif</span><br=
><span>@@ -885,9 +883,7 @@</span><br><span>     o-&gt;transition_window =3D=
 3600;</span><br><span>     o-&gt;tls_cert_profile =3D NULL;</span><br><spa=
n>     o-&gt;ecdh_curve =3D NULL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</span><br><span>     o-&gt;x509_u=
sername_field[0] =3D X509_USERNAME_FIELD_DEFAULT;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span> #ifdef ENABLE_PKCS11</s=
pan><br><span>     o-&gt;pkcs11_pin_cache_period =3D -1;</span><br><span> #=
endif /* ENABLE_PKCS11 */</span><br><span>@@ -9069,7 +9065,6 @@</span><br><=
span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         x5=
09_track_add(&amp;options-&gt;x509_track, p[1], msglevel, &amp;options-&gt;=
gc);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef ENABLE_X509ALTUSERNAME</span><br><span>     else if (streq(p[0=
], &quot;x509-username-field&quot;) &amp;&amp; p[1])</span><br><span>     {=
</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span=
>@@ -9084,7 +9079,6 @@</span><br><span>             options-&gt;x509_userna=
me_field[j - 1] =3D p[j];</span><br><span>         }</span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_X509=
ALTUSERNAME */</span><br><span> #ifdef ENABLE_PKCS11</span><br><span>     e=
lse if (streq(p[0], &quot;show-pkcs11-ids&quot;) &amp;&amp; !p[3])</span><b=
r><span>     {</span><br><span>diff --git a/src/openvpn/options.h b/src/ope=
nvpn/options.h</span><br><span>index 9d89426..16cfdb5 100644</span><br><spa=
n>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</=
span><br><span>@@ -651,10 +651,8 @@</span><br><span>      * within n second=
s of handshake initiation. */</span><br><span>     int handshake_window;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_X509ALTUSERNAME</span><br><span>     /* Field list used to be the u=
sername in X509 cert. */</span><br><span>     char *x509_username_field[MAX=
_PARMS];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span> </span><br><span>     /* Old key allowed to live n seconds after=
 new key goes active */</span><br><span>     int transition_window;</span><=
br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</=
span><br><span>index 1cf254f..fba01bb 100644</span><br><span>--- a/src/open=
vpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.h</span><br><=
span>@@ -362,11 +362,7 @@</span><br><span>     int verify_hash_depth;</span=
><br><span>     bool verify_hash_no_ca;</span><br><span>     hash_algo_type=
 verify_hash_algo;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
def ENABLE_X509ALTUSERNAME</span><br><span>     char *x509_username_field[M=
AX_PARMS];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *x509_username_fie=
ld[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span> </span><br><span>     /* struct crypto_option flags */</span><br><=
span>     unsigned int crypto_flags;</span><br><span>diff --git a/src/openv=
pn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h</span><br><span>=
index 9cad320..0a2de03 100644</span><br><span>--- a/src/openvpn/ssl_verify_=
backend.h</span><br><span>+++ b/src/openvpn/ssl_verify_backend.h</span><br>=
<span>@@ -113,7 +113,7 @@</span><br><span> /*</span><br><span>  * Retrieve =
the certificate&#39;s username from the specified field.</span><br><span>  =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If the field is p=
repended with ext: and ENABLE_X509ALTUSERNAME is enabled,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * If the field is prepended with ext=
: is enabled,</span><br><span>  * it will be loaded from an X.509 extension=
</span><br><span>  *</span><br><span>  * @param cn                    Buffe=
r to return the common name in.</span><br><span>@@ -126,15 +126,12 @@</span=
><br><span> result_t backend_x509_get_username(char *common_name, size_t cn=
_len, char *x509_username_field,</span><br><span>                          =
          openvpn_x509_cert_t *peer_cert);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</span>=
<br><span> /**</span><br><span>  * Return true iff the supplied extension f=
ield is supported by the</span><br><span>  * --x509-username-field option.<=
/span><br><span>  */</span><br><span> bool x509_username_field_ext_supporte=
d(const char *extname);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> /*</span><br><span>  * Return the certificate&#39;s =
serial number in decimal string representation.</span><br><span>  *</span><=
br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_ve=
rify_mbedtls.c</span><br><span>index 74b21b0..80396f8 100644</span><br><spa=
n>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/=
ssl_verify_mbedtls.c</span><br><span>@@ -123,9 +123,12 @@</span><br><span> =
    return 0;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#warning &quot;X509 alt user name not =
yet supported for mbed TLS&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 not supported for mbedTLS yet */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+x=
509_username_field_ext_supported(const char *fieldname)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span> </span><br><span> result_t</span><br><sp=
an> backend_x509_get_username(char *cn, size_t cn_len, char *x509_username_=
field, mbedtls_x509_crt *cert)</span><br><span>diff --git a/src/openvpn/ssl=
_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</span><br><span>index =
32e55e6..4f6573d 100644</span><br><span>--- a/src/openvpn/ssl_verify_openss=
l.c</span><br><span>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span>=
@@ -111,7 +111,6 @@</span><br><span>     return ret;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef =
ENABLE_X509ALTUSERNAME</span><br><span> bool</span><br><span> x509_username=
_field_ext_supported(const char *fieldname)</span><br><span> {</span><br><s=
pan>@@ -180,7 +179,6 @@</span><br><span>     }</span><br><span>     return =
retval;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif /* ENABLE_X509ALTUSERNAME */</span><br><span> </span><br><span>=
 /*</span><br><span>  * Extract a field from an X509 subject name.</span><b=
r><span>@@ -252,7 +250,6 @@</span><br><span> result_t</span><br><span> back=
end_x509_get_username(char *common_name, size_t cn_len, char *x509_username=
_field, X509 *peer_cert)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef ENABLE_X509ALTUSERNAME</span><br><span>     if=
 (strncmp(&quot;ext:&quot;, x509_username_field, 4) =3D=3D 0)</span><br><sp=
an>     {</span><br><span>         if (!extract_x509_extension(peer_cert, x=
509_username_field + 4, common_name, cn_len))</span><br><span>@@ -275,7 +27=
2,6 @@</span><br><span>         gc_free(&amp;gc);</span><br><span>     }</s=
pan><br><span>     else</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif /* ifdef ENABLE_X509ALTUSERNAME */</span><br><span>     {</span><b=
r><span>         X509_NAME *x509_subject_name =3D X509_get_subject_name(pee=
r_cert);</span><br><span>         if (x509_subject_name =3D=3D NULL)</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1442?usp=3Demail">change 1442</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1442?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f661cf305c52652e430b8d219d=
f5186dd8ea4f7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1442 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--CK6deYukc4Q=--

