From: "MaxF (Code Review)" <gerrit@...515...>
Date: Thu, 22 May 2025 18:18:04 +0000
References: <gerrit.1747937881000.Icbfffae877f8eca8d94721a4d54e140c50d4a550@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e5e717c0038395109764ca76157f8a0ff7643b52-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R5Zf2t9krFg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove
 HAVE_EXPORT_KEYING_MATERIAL macro
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

--R5Zf2t9krFg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1043?usp=3Demail

to review the following change.


Change subject: Remove HAVE_EXPORT_KEYING_MATERIAL macro
......................................................................

Remove HAVE_EXPORT_KEYING_MATERIAL macro

This was always defined in all supported versions of OpenSSL and
WolfSSL. EKM should be available in supported mbed TLS versions, too.

This commit includes some style changes required by uncrustify.

Change-Id: Icbfffae877f8eca8d94721a4d54e140c50d4a550
---
M config.h.cmake.in
M configure.ac
M src/openvpn/init.c
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/ssl.c
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
M src/openvpn/ssl_ncp.c
10 files changed, 10 insertions(+), 67 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/1043/1

diff --git a/config.h.cmake.in b/config.h.cmake.in
index 5164ce3..5df0ac8 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -120,9 +120,6 @@
 /* Define to 1 if you have the <err.h> header file. */
 #cmakedefine HAVE_ERR_H

-/* Crypto library supports keying material exporter */
-#define HAVE_EXPORT_KEYING_MATERIAL 1
-
 /* Define to 1 if you have the <fcntl.h> header file. */
 #cmakedefine HAVE_FCNTL_H

diff --git a/configure.ac b/configure.ac
index 75367e8..1b908e6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -988,10 +988,6 @@
 		[AC_MSG_ERROR([OpenSSL check for AES-256-GCM support failed])]
 	)

-	# All supported OpenSSL versions (>=3D 1.1.0)
-	# have this feature
-	have_export_keying_material=3D"yes"
-
 	CFLAGS=3D"${saved_CFLAGS}"
 	LIBS=3D"${saved_LIBS}"

@@ -1064,7 +1060,6 @@
 		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]
 	)

-	have_export_keying_material=3D"yes"
 	AC_CHECK_FUNC(
 		[mbedtls_ssl_conf_export_keys_ext_cb],
 		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],
@@ -1077,7 +1072,7 @@
 			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
 		)
 		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" !=3D xyes; then
-			have_export_keying_material=3D"no"
+			AC_MSG_ERROR(This version of mbed TLS has no support for exporting key =
material.)
 		fi
 	fi

@@ -1132,17 +1127,12 @@
 	)
 	AC_CHECK_HEADER([wolfssl/options.h],,[AC_MSG_ERROR([wolfSSL header wolfss=
l/options.h not found!])])

-	# wolfSSL signal EKM support
-	have_export_keying_material=3D"yes"
-
 	if test "${enable_wolfssl_options_h}" =3D "yes"; then
 		AC_DEFINE([EXTERNAL_OPTS_OPENVPN], [1], [Include options.h from wolfSSL =
library])
 	else
 		AC_DEFINE([WOLFSSL_USER_SETTINGS], [1], [Use custom user_settings.h file=
 for wolfSSL library])
 	fi

-	have_export_keying_material=3D"yes"
-
 	CFLAGS=3D"${saved_CFLAGS}"
 	LIBS=3D"${saved_LIBS}"

@@ -1346,12 +1336,6 @@
 test "${enable_dns_updown_by_default}" =3D "yes" && AC_DEFINE([ENABLE_DNS_=
UPDOWN_BY_DEFAULT], [1], [Enable dns-updown hook by default])
 test "${enable_ntlm}" =3D "yes" && AC_DEFINE([ENABLE_NTLM], [1], [Enable N=
TLMv2 proxy support])
 test "${enable_crypto_ofb_cfb}" =3D "yes" && AC_DEFINE([ENABLE_OFB_CFB_MOD=
E], [1], [Enable OFB and CFB cipher modes])
-if test "${have_export_keying_material}" =3D "yes"; then
-	AC_DEFINE(
-		[HAVE_EXPORT_KEYING_MATERIAL], [1],
-		[Crypto library supports keying material exporter]
-	)
-fi
 OPTIONAL_CRYPTO_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}"
 OPTIONAL_CRYPTO_LIBS=3D"${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}"

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e0ba255..15eacab 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3483,7 +3483,6 @@
     to.comp_options =3D options->comp;
 #endif

-#ifdef HAVE_EXPORT_KEYING_MATERIAL
     if (options->keying_material_exporter_label)
     {
         to.ekm_size =3D options->keying_material_exporter_length;
@@ -3499,7 +3498,6 @@
     {
         to.ekm_size =3D 0;
     }
-#endif /* HAVE_EXPORT_KEYING_MATERIAL */

     /* TLS handshake authentication (--tls-auth) */
     if (options->ce.tls_auth_file)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 80dd0c0..a5eee01 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1837,7 +1837,6 @@
         c->c2.push_request_received =3D true;
     }

-#ifdef HAVE_EXPORT_KEYING_MATERIAL
     if (proto & IV_PROTO_TLS_KEY_EXPORT)
     {
         o->imported_protocol_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
@@ -1856,7 +1855,6 @@
     {
         o->imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;
     }
-#endif

     if (proto & IV_PROTO_CC_EXIT_NOTIFY)
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6672b5c..831eeb0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -664,10 +664,8 @@
 #endif
     "--x509-track x  : Save peer X509 attribute x in environment for use b=
y\n"
     "                  plugins and management interface.\n"
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
     "--keying-material-exporter label len : Save Exported Keying Material =
(RFC5705)\n"
     "                  of len bytes (min. 16 bytes) using label in environ=
ment for use by plugins.\n"
-#endif
     "--remote-cert-ku v ... : Require that the peer certificate was signed=
 with\n"
     "                  explicit key usage, you can specify more than one v=
alue.\n"
     "                  value should be given in hex format.\n"
@@ -2394,9 +2392,9 @@
 }

 #define MUST_BE_UNDEF(parm, parm_name) \
-    if (options->parm !=3D defaults.parm) { msg(M_USAGE, use_err, parm_nam=
e); }
+        if (options->parm !=3D defaults.parm) { msg(M_USAGE, use_err, parm=
_name); }
 #define MUST_BE_FALSE(condition, parm_name) \
-    if (condition) { msg(M_USAGE, use_err, parm_name); }
+        if (condition) { msg(M_USAGE, use_err, parm_name); }

 static void
 options_postprocess_verify_ce(const struct options *options,
@@ -2644,7 +2642,7 @@
         const char use_err[] =3D "--%s cannot be used with --mode server.";

 #define USAGE_VALID_SERVER_PROTOS "--mode server currently only supports "=
 \
-    "--proto values of udp, tcp-server, tcp4-server, or tcp6-server"
+        "--proto values of udp, tcp-server, tcp4-server, or tcp6-server"
 #ifdef TARGET_ANDROID
         msg(M_FATAL, "--mode server not supported on Android");
 #endif
@@ -3594,10 +3592,6 @@
             "calculation anymore or your security policy (e.g. FIPS 140-2)=
 "
             "forbids it. Connections will only work with peers running "
             "OpenVPN 2.6.0 or higher)");
-#ifndef HAVE_EXPORT_KEYING_MATERIAL
-        msg(M_FATAL, "Keying Material Exporters (RFC 5705) not available e=
ither. "
-            "No way to generate data channel keys left.");
-#endif
         if (o->mode =3D=3D MODE_SERVER)
         {
             msg(M_WARN, "Automatically enabling option "
@@ -5499,11 +5493,11 @@
 }

 #define VERIFY_PERMISSION(mask) {                                         =
   \
-        if (!verify_permission(p[0], file, line, (mask), permission_mask, =
       \
-                               option_types_found, msglevel, options, is_i=
nline)) \
-        {                                                                 =
       \
-            goto err;                                                     =
       \
-        }                                                                 =
       \
+            if (!verify_permission(p[0], file, line, (mask), permission_ma=
sk,        \
+                                   option_types_found, msglevel, options, =
is_inline)) \
+            {                                                             =
           \
+                goto err;                                                 =
           \
+            }                                                             =
           \
 }

 static bool
@@ -8663,13 +8657,11 @@
         /* NCP only option that is pushed by the server to enable EKM,
          * should not be used by normal users in config files*/
         VERIFY_PERMISSION(OPT_P_NCP)
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
         if (streq(p[1], "tls-ekm"))
         {
             options->imported_protocol_flags |=3D CO_USE_TLS_KEY_MATERIAL_=
EXPORT;
         }
         else
-#endif
         {
             msg(msglevel, "Unknown key-derivation method %s", p[1]);
         }
@@ -8686,7 +8678,6 @@
             {
                 options->imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIF=
Y;
             }
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
             else if (streq(p[j], "tls-ekm"))
             {
                 options->imported_protocol_flags |=3D CO_USE_TLS_KEY_MATER=
IAL_EXPORT;
@@ -8695,7 +8686,6 @@
             {
                 options->imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_C=
RYPT;
             }
-#endif
             else if (streq(p[j], "aead-epoch"))
             {
                 options->imported_protocol_flags |=3D CO_EPOCH_DATA_KEY_FO=
RMAT;
@@ -9452,7 +9442,6 @@
         options->use_peer_id =3D true;
         options->peer_id =3D atoi_warn(p[1], msglevel);
     }
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
     else if (streq(p[0], "keying-material-exporter") && p[1] && p[2])
     {
         int ekm_length =3D positive_atoi(p[2], msglevel);
@@ -9479,7 +9468,6 @@
         options->keying_material_exporter_label =3D p[1];
         options->keying_material_exporter_length =3D ekm_length;
     }
-#endif /* HAVE_EXPORT_KEYING_MATERIAL */
     else if (streq(p[0], "allow-recursive-routing") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 8d1ef6c..b0b8d96 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -701,11 +701,9 @@
     bool use_peer_id;
     uint32_t peer_id;

-#ifdef HAVE_EXPORT_KEYING_MATERIAL
     /* Keying Material Exporters [RFC 5705] */
     const char *keying_material_exporter_label;
     int keying_material_exporter_length;
-#endif
     /* force using TLS key material export for data channel key generation=
 */
     bool force_key_material_export;

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index fd299ef..5ecf42b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2034,10 +2034,8 @@

         buf_printf(&out, "IV_CIPHERS=3D%s\n", session->opt->config_ncp_cip=
hers);

-#ifdef HAVE_EXPORT_KEYING_MATERIAL
         iv_proto |=3D IV_PROTO_TLS_KEY_EXPORT;
         iv_proto |=3D IV_PROTO_DYN_TLS_CRYPT;
-#endif

         buf_printf(&out, "IV_PROTO=3D%d\n", iv_proto);

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ec3135a..6474f80 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -174,8 +174,6 @@
     return ctx->initialised;
 }

-#ifdef HAVE_EXPORT_KEYING_MATERIAL
-
 #if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
 /*
  * Key export callback for older versions of mbed TLS, to be used with
@@ -254,7 +252,7 @@
     cache->tls_prf_type =3D tls_prf_type;
 }
 #else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
-#error either HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB or HAVE_MBEDTLS_SSL=
_SET_EXPORT_KEYS_CB must be defined when HAVE_EXPORT_KEYING_MATERIAL is def=
ined
+#error either mbedtls_ssl_conf_export_keys_ext_cb or mbedtls_ssl_set_expor=
t_keys_cb must be available in mbed TLS
 #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */

 bool
@@ -289,16 +287,6 @@
         return false;
     }
 }
-#else  /* ifdef HAVE_EXPORT_KEYING_MATERIAL */
-bool
-key_state_export_keying_material(struct tls_session *session,
-                                 const char *label, size_t label_size,
-                                 void *ekm, size_t ekm_size)
-{
-    /* Dummy function to avoid ifdefs in the common code */
-    return false;
-}
-#endif /* HAVE_EXPORT_KEYING_MATERIAL */

 bool
 tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index ec30bb5..9ebb2ce 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -85,7 +85,6 @@
     void *sign_ctx;
 };

-#ifdef HAVE_EXPORT_KEYING_MATERIAL
 /** struct to cache TLS secrets for keying material exporter (RFC 5705).
  * The constants (64 and 48) are inherent to TLS version and
  * the whole keying material export will likely change when they change */
@@ -94,9 +93,6 @@
     mbedtls_tls_prf_types tls_prf_type;
     unsigned char master_secret[48];
 };
-#else  /* ifdef HAVE_EXPORT_KEYING_MATERIAL */
-struct tls_key_cache { };
-#endif

 /**
  * Structure that wraps the TLS context. Contents differ depending on the
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index ead91da..a9cd470 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -446,7 +446,6 @@
         session->opt->crypto_flags &=3D ~CO_EPOCH_DATA_KEY_FORMAT;
     }

-#if defined(HAVE_EXPORT_KEYING_MATERIAL)
     if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
         session->opt->crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
@@ -479,7 +478,6 @@
     {
         session->opt->crypto_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;
     }
-#endif /* if defined(HAVE_EXPORT_KEYING_MATERIAL) */
 }

 void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1043?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icbfffae877f8eca8d94721a4d54e140c50d4a550
Gerrit-Change-Number: 1043
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--R5Zf2t9krFg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1043?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Remove HAVE_EXPORT_KEYING_MATERIAL macro<br><br>This was alw=
ays defined in all supported versions of OpenSSL and<br>WolfSSL. EKM should=
 be available in supported mbed TLS versions, too.<br><br>This commit inclu=
des some style changes required by uncrustify.<br><br>Change-Id: Icbfffae87=
7f8eca8d94721a4d54e140c50d4a550<br>---<br>M config.h.cmake.in<br>M configur=
e.ac<br>M src/openvpn/init.c<br>M src/openvpn/multi.c<br>M src/openvpn/opti=
ons.c<br>M src/openvpn/options.h<br>M src/openvpn/ssl.c<br>M src/openvpn/ss=
l_mbedtls.c<br>M src/openvpn/ssl_mbedtls.h<br>M src/openvpn/ssl_ncp.c<br>10=
 files changed, 10 insertions(+), 67 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/43/1043/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/config.h.cmake.in b/config.h.cmake.in</span><br><span>index 5164ce3..=
5df0ac8 100644</span><br><span>--- a/config.h.cmake.in</span><br><span>+++ =
b/config.h.cmake.in</span><br><span>@@ -120,9 +120,6 @@</span><br><span> /*=
 Define to 1 if you have the &lt;err.h&gt; header file. */</span><br><span>=
 #cmakedefine HAVE_ERR_H</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-/* Crypto library supports keying material exporter */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_EXPORT_K=
EYING_MATERIAL 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> /* Define to 1 if you have the &lt;fcntl.h&gt; header file. */=
</span><br><span> #cmakedefine HAVE_FCNTL_H</span><br><span> </span><br><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index 75367e8..=
1b908e6 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -988,10 +988,6 @@</span><br><span> 		[AC_MSG_E=
RROR([OpenSSL check for AES-256-GCM support failed])]</span><br><span> 	)</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	# Al=
l supported OpenSSL versions (&gt;=3D 1.1.0)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	# have this feature</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	have_export_keying_material=3D&quot;yes&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> 	CFLAGS=3D=
&quot;${saved_CFLAGS}&quot;</span><br><span> 	LIBS=3D&quot;${saved_LIBS}&qu=
ot;</span><br><span> </span><br><span>@@ -1064,7 +1060,6 @@</span><br><span=
> 		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]</span><br><span> 	)<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	hav=
e_export_keying_material=3D&quot;yes&quot;</span><br><span> 	AC_CHECK_FUNC(=
</span><br><span> 		[mbedtls_ssl_conf_export_keys_ext_cb],</span><br><span>=
 		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],</sp=
an><br><span>@@ -1077,7 +1072,7 @@</span><br><span> 			[AC_DEFINE([HAVE_MBE=
DTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]</span><br><span> 		)</span><br><s=
pan> 		if test &quot;x$ac_cv_func_mbedtls_ssl_set_export_keys_cb&quot; !=3D=
 xyes; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			have_ex=
port_keying_material=3D&quot;no&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+			AC_MSG_ERROR(This version of mbed TLS has no support f=
or exporting key material.)</span><br><span> 		fi</span><br><span> 	fi</spa=
n><br><span> </span><br><span>@@ -1132,17 +1127,12 @@</span><br><span> 	)</=
span><br><span> 	AC_CHECK_HEADER([wolfssl/options.h],,[AC_MSG_ERROR([wolfSS=
L header wolfssl/options.h not found!])])</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	# wolfSSL signal EKM support</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	have_export_keying_material=
=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> 	if test &quot;${enable_wolfssl_options_h}&quot; =3D &quot;y=
es&quot;; then</span><br><span> 		AC_DEFINE([EXTERNAL_OPTS_OPENVPN], [1], [=
Include options.h from wolfSSL library])</span><br><span> 	else</span><br><=
span> 		AC_DEFINE([WOLFSSL_USER_SETTINGS], [1], [Use custom user_settings.h=
 file for wolfSSL library])</span><br><span> 	fi</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	have_export_keying_material=
=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> 	CFLAGS=3D&quot;${saved_CFLAGS}&quot;</span><br><span> 	LIBS=
=3D&quot;${saved_LIBS}&quot;</span><br><span> </span><br><span>@@ -1346,12 =
+1336,6 @@</span><br><span> test &quot;${enable_dns_updown_by_default}&quot=
; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([ENABLE_DNS_UPDOWN_BY_DEFAULT], =
[1], [Enable dns-updown hook by default])</span><br><span> test &quot;${ena=
ble_ntlm}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([ENABLE_NTLM], [1]=
, [Enable NTLMv2 proxy support])</span><br><span> test &quot;${enable_crypt=
o_ofb_cfb}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([ENABLE_OFB_CFB_M=
ODE], [1], [Enable OFB and CFB cipher modes])</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-if test &quot;${have_export_keying_material}&quot; =
=3D &quot;yes&quot;; then</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	AC_DEFINE(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[HAV=
E_EXPORT_KEYING_MATERIAL], [1],</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-		[Crypto library supports keying material exporter]</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-fi</span><br><span> OPTIONAL_CRYPTO_CFLAGS=3D&quot;${=
OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}&quot;</span><br><span> OPTIONAL_CR=
YPTO_LIBS=3D&quot;${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}&quot;</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c<=
/span><br><span>index e0ba255..15eacab 100644</span><br><span>--- a/src/ope=
nvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -34=
83,7 +3483,6 @@</span><br><span>     to.comp_options =3D options-&gt;comp;<=
/span><br><span> #endif</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span>    =
 if (options-&gt;keying_material_exporter_label)</span><br><span>     {</sp=
an><br><span>         to.ekm_size =3D options-&gt;keying_material_exporter_=
length;</span><br><span>@@ -3499,7 +3498,6 @@</span><br><span>     {</span>=
<br><span>         to.ekm_size =3D 0;</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_EXPORT_KEYING_MATERIA=
L */</span><br><span> </span><br><span>     /* TLS handshake authentication=
 (--tls-auth) */</span><br><span>     if (options-&gt;ce.tls_auth_file)</sp=
an><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><=
br><span>index 80dd0c0..a5eee01 100644</span><br><span>--- a/src/openvpn/mu=
lti.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1837,7 =
+1837,6 @@</span><br><span>         c-&gt;c2.push_request_received =3D true=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span>   =
  if (proto &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span>     {</span><br=
><span>         o-&gt;imported_protocol_flags |=3D CO_USE_TLS_KEY_MATERIAL_=
EXPORT;</span><br><span>@@ -1856,7 +1855,6 @@</span><br><span>     {</span>=
<br><span>         o-&gt;imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CR=
YPT;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span> </span><br><span>     if (proto &amp; IV_PROT=
O_CC_EXIT_NOTIFY)</span><br><span>     {</span><br><span>diff --git a/src/o=
penvpn/options.c b/src/openvpn/options.c</span><br><span>index 6672b5c..831=
eeb0 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++=
 b/src/openvpn/options.c</span><br><span>@@ -664,10 +664,8 @@</span><br><sp=
an> #endif</span><br><span>     &quot;--x509-track x  : Save peer X509 attr=
ibute x in environment for use by\n&quot;</span><br><span>     &quot;      =
            plugins and management interface.\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><b=
r><span>     &quot;--keying-material-exporter label len : Save Exported Key=
ing Material (RFC5705)\n&quot;</span><br><span>     &quot;                 =
 of len bytes (min. 16 bytes) using label in environment for use by plugins=
.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span>     &quot;--remote-cert-ku v ... : Require that the peer certif=
icate was signed with\n&quot;</span><br><span>     &quot;                  =
explicit key usage, you can specify more than one value.\n&quot;</span><br>=
<span>     &quot;                  value should be given in hex format.\n&q=
uot;</span><br><span>@@ -2394,9 +2392,9 @@</span><br><span> }</span><br><sp=
an> </span><br><span> #define MUST_BE_UNDEF(parm, parm_name) \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;parm !=3D defa=
ults.parm) { msg(M_USAGE, use_err, parm_name); }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (options-&gt;parm !=3D defaults.par=
m) { msg(M_USAGE, use_err, parm_name); }</span><br><span> #define MUST_BE_F=
ALSE(condition, parm_name) \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (condition) { msg(M_USAGE, use_err, parm_name); }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (condition) { msg(M_=
USAGE, use_err, parm_name); }</span><br><span> </span><br><span> static voi=
d</span><br><span> options_postprocess_verify_ce(const struct options *opti=
ons,</span><br><span>@@ -2644,7 +2642,7 @@</span><br><span>         const c=
har use_err[] =3D &quot;--%s cannot be used with --mode server.&quot;;</spa=
n><br><span> </span><br><span> #define USAGE_VALID_SERVER_PROTOS &quot;--mo=
de server currently only supports &quot; \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    &quot;--proto values of udp, tcp-server, tcp4-serv=
er, or tcp6-server&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        &quot;--proto values of udp, tcp-server, tcp4-server, or tcp6-=
server&quot;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>       =
  msg(M_FATAL, &quot;--mode server not supported on Android&quot;);</span><=
br><span> #endif</span><br><span>@@ -3594,10 +3592,6 @@</span><br><span>   =
          &quot;calculation anymore or your security policy (e.g. FIPS 140-=
2) &quot;</span><br><span>             &quot;forbids it. Connections will o=
nly work with peers running &quot;</span><br><span>             &quot;OpenV=
PN 2.6.0 or higher)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifndef HAVE_EXPORT_KEYING_MATERIAL</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(M_FATAL, &quot;Keying Material Exporters (R=
FC 5705) not available either. &quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            &quot;No way to generate data channel keys left=
.&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span>         if (o-&gt;mode =3D=3D MODE_SERVER)</span><br><span>    =
     {</span><br><span>             msg(M_WARN, &quot;Automatically enablin=
g option &quot;</span><br><span>@@ -5499,11 +5493,11 @@</span><br><span> }<=
/span><br><span> </span><br><span> #define VERIFY_PERMISSION(mask) {       =
                                     \</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (!verify_permission(p[0], file, line, (mask), p=
ermission_mask,        \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                               option_types_found, msglevel, options, is=
_inline)) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        { =
                                                                       \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto err;   =
                                                         \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }                             =
                                           \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (!verify_permission(p[0], file, lin=
e, (mask), permission_mask,        \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                   option_types_found, msg=
level, options, is_inline)) \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {                                                    =
                    \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                goto err;                                                =
            \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }                                                                    =
    \</span><br><span> }</span><br><span> </span><br><span> static bool</sp=
an><br><span>@@ -8663,13 +8657,11 @@</span><br><span>         /* NCP only o=
ption that is pushed by the server to enable EKM,</span><br><span>         =
 * should not be used by normal users in config files*/</span><br><span>   =
      VERIFY_PERMISSION(OPT_P_NCP)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span>         if=
 (streq(p[1], &quot;tls-ekm&quot;))</span><br><span>         {</span><br><s=
pan>             options-&gt;imported_protocol_flags |=3D CO_USE_TLS_KEY_MA=
TERIAL_EXPORT;</span><br><span>         }</span><br><span>         else</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>  =
       {</span><br><span>             msg(msglevel, &quot;Unknown key-deriv=
ation method %s&quot;, p[1]);</span><br><span>         }</span><br><span>@@=
 -8686,7 +8678,6 @@</span><br><span>             {</span><br><span>        =
         options-&gt;imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIFY;</s=
pan><br><span>             }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span>             else=
 if (streq(p[j], &quot;tls-ekm&quot;))</span><br><span>             {</span=
><br><span>                 options-&gt;imported_protocol_flags |=3D CO_USE=
_TLS_KEY_MATERIAL_EXPORT;</span><br><span>@@ -8695,7 +8686,6 @@</span><br><=
span>             {</span><br><span>                 options-&gt;imported_p=
rotocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;</span><br><span>             }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><spa=
n>             else if (streq(p[j], &quot;aead-epoch&quot;))</span><br><spa=
n>             {</span><br><span>                 options-&gt;imported_prot=
ocol_flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><br><span>@@ -9452,7 +9442,=
6 @@</span><br><span>         options-&gt;use_peer_id =3D true;</span><br><=
span>         options-&gt;peer_id =3D atoi_warn(p[1], msglevel);</span><br>=
<span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HA=
VE_EXPORT_KEYING_MATERIAL</span><br><span>     else if (streq(p[0], &quot;k=
eying-material-exporter&quot;) &amp;&amp; p[1] &amp;&amp; p[2])</span><br><=
span>     {</span><br><span>         int ekm_length =3D positive_atoi(p[2],=
 msglevel);</span><br><span>@@ -9479,7 +9468,6 @@</span><br><span>         =
options-&gt;keying_material_exporter_label =3D p[1];</span><br><span>      =
   options-&gt;keying_material_exporter_length =3D ekm_length;</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* H=
AVE_EXPORT_KEYING_MATERIAL */</span><br><span>     else if (streq(p[0], &qu=
ot;allow-recursive-routing&quot;) &amp;&amp; !p[1])</span><br><span>     {<=
/span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>=
diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>=
index 8d1ef6c..b0b8d96 100644</span><br><span>--- a/src/openvpn/options.h</=
span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -701,11 +701,=
9 @@</span><br><span>     bool use_peer_id;</span><br><span>     uint32_t p=
eer_id;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span>     /* Keying Mater=
ial Exporters [RFC 5705] */</span><br><span>     const char *keying_materia=
l_exporter_label;</span><br><span>     int keying_material_exporter_length;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><spa=
n>     /* force using TLS key material export for data channel key generati=
on */</span><br><span>     bool force_key_material_export;</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span>=
<br><span>index fd299ef..5ecf42b 100644</span><br><span>--- a/src/openvpn/s=
sl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2034,10 +2=
034,8 @@</span><br><span> </span><br><span>         buf_printf(&amp;out, &q=
uot;IV_CIPHERS=3D%s\n&quot;, session-&gt;opt-&gt;config_ncp_ciphers);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HA=
VE_EXPORT_KEYING_MATERIAL</span><br><span>         iv_proto |=3D IV_PROTO_T=
LS_KEY_EXPORT;</span><br><span>         iv_proto |=3D IV_PROTO_DYN_TLS_CRYP=
T;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan> </span><br><span>         buf_printf(&amp;out, &quot;IV_PROTO=3D%d\n&q=
uot;, iv_proto);</span><br><span> </span><br><span>diff --git a/src/openvpn=
/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index ec3135a..6=
474f80 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><sp=
an>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -174,8 +174,6 @@</spa=
n><br><span>     return ctx-&gt;initialised;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXP=
ORT_KEYING_MATERIAL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> #if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</span><br><spa=
n> /*</span><br><span>  * Key export callback for older versions of mbed TL=
S, to be used with</span><br><span>@@ -254,7 +252,7 @@</span><br><span>    =
 cache-&gt;tls_prf_type =3D tls_prf_type;</span><br><span> }</span><br><spa=
n> #else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#error either HAVE_MBEDTLS_SSL_CONF_E=
XPORT_KEYS_EXT_CB or HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB must be defined wh=
en HAVE_EXPORT_KEYING_MATERIAL is defined</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#error either mbedtls_ssl_conf_export_keys_ext_cb or =
mbedtls_ssl_set_export_keys_cb must be available in mbed TLS</span><br><spa=
n> #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><span> <=
/span><br><span> bool</span><br><span>@@ -289,16 +287,6 @@</span><br><span>=
         return false;</span><br><span>     }</span><br><span> }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef HAVE_EXPORT_KEYI=
NG_MATERIAL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-key_state_export_keying_=
material(struct tls_session *session,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                 const char *label, size_t =
label_size,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                       void *ekm, size_t ekm_size)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* Dummy function to avoid ifdefs in the common code */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif /* HAVE_EXPORT_KEYING_MATERIAL */</span><br><=
span> </span><br><span> bool</span><br><span> tls_ctx_set_options(struct tl=
s_root_ctx *ctx, unsigned int ssl_flags)</span><br><span>diff --git a/src/o=
penvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h</span><br><span>index ec30=
bb5..9ebb2ce 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.h</span><=
br><span>+++ b/src/openvpn/ssl_mbedtls.h</span><br><span>@@ -85,7 +85,6 @@<=
/span><br><span>     void *sign_ctx;</span><br><span> };</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEY=
ING_MATERIAL</span><br><span> /** struct to cache TLS secrets for keying ma=
terial exporter (RFC 5705).</span><br><span>  * The constants (64 and 48) a=
re inherent to TLS version and</span><br><span>  * the whole keying materia=
l export will likely change when they change */</span><br><span>@@ -94,9 +9=
3,6 @@</span><br><span>     mbedtls_tls_prf_types tls_prf_type;</span><br><=
span>     unsigned char master_secret[48];</span><br><span> };</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef HAVE_EXPORT_KEYING=
_MATERIAL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct tl=
s_key_cache { };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span> </span><br><span> /**</span><br><span>  * Structure that=
 wraps the TLS context. Contents differ depending on the</span><br><span>di=
ff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><br><span>in=
dex ead91da..a9cd470 100644</span><br><span>--- a/src/openvpn/ssl_ncp.c</sp=
an><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -446,7 +446,6 @=
@</span><br><span>         session-&gt;opt-&gt;crypto_flags &amp;=3D ~CO_EP=
OCH_DATA_KEY_FORMAT;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_EXPORT_KEYING_MATE=
RIAL)</span><br><span>     if (iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)=
</span><br><span>     {</span><br><span>         session-&gt;opt-&gt;crypto=
_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span><br><span>@@ -479,7 +478,=
6 @@</span><br><span>     {</span><br><span>         session-&gt;opt-&gt;cr=
ypto_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;</span><br><span>     }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(HAVE_EXPORT=
_KEYING_MATERIAL) */</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1043?usp=3Demail">change 1043</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1043?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icbfffae877f8eca8d94721a4d54=
e140c50d4a550 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1043 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--R5Zf2t9krFg=--

