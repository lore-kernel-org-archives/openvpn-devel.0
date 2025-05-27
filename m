From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 27 May 2025 16:42:14 +0000
In-Reply-To: <gerrit.1747937881000.Icbfffae877f8eca8d94721a4d54e140c50d4a550@...2715...>
References: <gerrit.1747937881000.Icbfffae877f8eca8d94721a4d54e140c50d4a550@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <3796dca2a1683eda2b27addce8a565c2c66d0afc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y0Rh4YO1cYk="; charset=UTF-8
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
To: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Y0Rh4YO1cYk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 MaxF. ( http://gerrit.openvpn.net/c/openvpn/+/1043?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Remove HAVE_EXPORT_KEYING_MATERIAL macro
......................................................................

Remove HAVE_EXPORT_KEYING_MATERIAL macro

This was always defined in all supported versions of OpenSSL and
WolfSSL. EKM is available in mbedtls versions from 2.18.0 onwards.

This commit breaks builds on Debian 11 with the stock mbed TLS package.

Change-Id: Icbfffae877f8eca8d94721a4d54e140c50d4a550
Signed-off-by: MaxF <max@...2606...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250527160356.10871-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
799.html
Signed-off-by: Gert Doering <gert@...1296...>
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
10 files changed, 2 insertions(+), 59 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/1043/4

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
=20
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
=20
     /* TLS handshake authentication (--tls-auth) */
     if (options->ce.tls_auth_file)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8b5900f..b638fe8 100644
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
index bcc18a5..937b74f 100644
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
@@ -3595,10 +3593,6 @@
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
@@ -8664,13 +8658,11 @@
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
@@ -8687,7 +8679,6 @@
             {
                 options->imported_protocol_flags |=3D CO_USE_CC_EXIT_NOTIF=
Y;
             }
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
             else if (streq(p[j], "tls-ekm"))
             {
                 options->imported_protocol_flags |=3D CO_USE_TLS_KEY_MATER=
IAL_EXPORT;
@@ -8696,7 +8687,6 @@
             {
                 options->imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_C=
RYPT;
             }
-#endif
             else if (streq(p[j], "aead-epoch"))
             {
                 options->imported_protocol_flags |=3D CO_EPOCH_DATA_KEY_FO=
RMAT;
@@ -9453,7 +9443,6 @@
         options->use_peer_id =3D true;
         options->peer_id =3D atoi_warn(p[1], msglevel);
     }
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
     else if (streq(p[0], "keying-material-exporter") && p[1] && p[2])
     {
         int ekm_length =3D positive_atoi(p[2], msglevel);
@@ -9480,7 +9469,6 @@
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
Gerrit-PatchSet: 4
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--Y0Rh4YO1cYk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by MaxF.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1043?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Remove HAVE_EXPORT_KEYING_MATERIAL macro<br><=
br>This was always defined in all supported versions of OpenSSL and<br>Wolf=
SSL. EKM is available in mbedtls versions from 2.18.0 onwards.<br><br>This =
commit breaks builds on Debian 11 with the stock mbed TLS package.<br><br>C=
hange-Id: Icbfffae877f8eca8d94721a4d54e140c50d4a550<br>Signed-off-by: MaxF =
&lt;max@...2606...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>Message-Id: &lt;20250527160356.10871-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31799.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M confi=
g.h.cmake.in<br>M configure.ac<br>M src/openvpn/init.c<br>M src/openvpn/mul=
ti.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn=
/ssl.c<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_mbedtls.h<br>M s=
rc/openvpn/ssl_ncp.c<br>10 files changed, 2 insertions(+), 59 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/1=
043/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br>=
<span>index 5164ce3..5df0ac8 100644</span><br><span>--- a/config.h.cmake.in=
</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -120,9 +120,6 @=
@</span><br><span> /* Define to 1 if you have the &lt;err.h&gt; header file=
. */</span><br><span> #cmakedefine HAVE_ERR_H</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/* Crypto library supports keying=
 material exporter */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define HAVE_EXPORT_KEYING_MATERIAL 1</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> /* Define to 1 if you have the &lt;fcntl.=
h&gt; header file. */</span><br><span> #cmakedefine HAVE_FCNTL_H</span><br>=
<span> </span><br><span>diff --git a/configure.ac b/configure.ac</span><br>=
<span>index 75367e8..1b908e6 100644</span><br><span>--- a/configure.ac</spa=
n><br><span>+++ b/configure.ac</span><br><span>@@ -988,10 +988,6 @@</span><=
br><span> 		[AC_MSG_ERROR([OpenSSL check for AES-256-GCM support failed])]<=
/span><br><span> 	)</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	# All supported OpenSSL versions (&gt;=3D 1.1.0)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	# have this feature</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	have_export_keying_material=3D&=
quot;yes&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> 	CFLAGS=3D&quot;${saved_CFLAGS}&quot;</span><br><span> 	LIBS=3D&=
quot;${saved_LIBS}&quot;</span><br><span> </span><br><span>@@ -1064,7 +1060=
,6 @@</span><br><span> 		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]=
</span><br><span> 	)</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	have_export_keying_material=3D&quot;yes&quot;</span><br><=
span> 	AC_CHECK_FUNC(</span><br><span> 		[mbedtls_ssl_conf_export_keys_ext_=
cb],</span><br><span> 		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_C=
B], [1], [yes])],</span><br><span>@@ -1077,7 +1072,7 @@</span><br><span> 		=
	[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]</span><br><s=
pan> 		)</span><br><span> 		if test &quot;x$ac_cv_func_mbedtls_ssl_set_expo=
rt_keys_cb&quot; !=3D xyes; then</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-			have_export_keying_material=3D&quot;no&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+			AC_MSG_ERROR(This version of mbed=
 TLS has no support for exporting key material.)</span><br><span> 		fi</spa=
n><br><span> 	fi</span><br><span> </span><br><span>@@ -1132,17 +1127,12 @@<=
/span><br><span> 	)</span><br><span> 	AC_CHECK_HEADER([wolfssl/options.h],,=
[AC_MSG_ERROR([wolfSSL header wolfssl/options.h not found!])])</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	# wolfSSL signa=
l EKM support</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	have_ex=
port_keying_material=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> 	if test &quot;${enable_wolfssl_options_=
h}&quot; =3D &quot;yes&quot;; then</span><br><span> 		AC_DEFINE([EXTERNAL_O=
PTS_OPENVPN], [1], [Include options.h from wolfSSL library])</span><br><spa=
n> 	else</span><br><span> 		AC_DEFINE([WOLFSSL_USER_SETTINGS], [1], [Use cu=
stom user_settings.h file for wolfSSL library])</span><br><span> 	fi</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	have_expo=
rt_keying_material=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> 	CFLAGS=3D&quot;${saved_CFLAGS}&quot;</spa=
n><br><span> 	LIBS=3D&quot;${saved_LIBS}&quot;</span><br><span> </span><br>=
<span>@@ -1346,12 +1336,6 @@</span><br><span> test &quot;${enable_dns_updow=
n_by_default}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([ENABLE_DNS_UP=
DOWN_BY_DEFAULT], [1], [Enable dns-updown hook by default])</span><br><span=
> test &quot;${enable_ntlm}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE(=
[ENABLE_NTLM], [1], [Enable NTLMv2 proxy support])</span><br><span> test &q=
uot;${enable_crypto_ofb_cfb}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE=
([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-if test &quot;${have_export_keyin=
g_material}&quot; =3D &quot;yes&quot;; then</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	AC_DEFINE(</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-		[HAVE_EXPORT_KEYING_MATERIAL], [1],</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-		[Crypto library supports keying material expo=
rter]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span> OPTIONAL_CRYPTO=
_CFLAGS=3D&quot;${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}&quot;</span><br>=
<span> OPTIONAL_CRYPTO_LIBS=3D&quot;${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}&=
quot;</span><br><span> </span><br><span>diff --git a/src/openvpn/init.c b/s=
rc/openvpn/init.c</span><br><span>index e0ba255..15eacab 100644</span><br><=
span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</spa=
n><br><span>@@ -3483,7 +3483,6 @@</span><br><span>     to.comp_options =3D =
options-&gt;comp;</span><br><span> #endif</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</s=
pan><br><span>     if (options-&gt;keying_material_exporter_label)</span><b=
r><span>     {</span><br><span>         to.ekm_size =3D options-&gt;keying_=
material_exporter_length;</span><br><span>@@ -3499,7 +3498,6 @@</span><br><=
span>     {</span><br><span>         to.ekm_size =3D 0;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_EXP=
ORT_KEYING_MATERIAL */</span><br><span> </span><br><span>     /* TLS handsh=
ake authentication (--tls-auth) */</span><br><span>     if (options-&gt;ce.=
tls_auth_file)</span><br><span>diff --git a/src/openvpn/multi.c b/src/openv=
pn/multi.c</span><br><span>index 8b5900f..b638fe8 100644</span><br><span>--=
- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br=
><span>@@ -1837,7 +1837,6 @@</span><br><span>         c-&gt;c2.push_request=
_received =3D true;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</=
span><br><span>     if (proto &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><spa=
n>     {</span><br><span>         o-&gt;imported_protocol_flags |=3D CO_USE=
_TLS_KEY_MATERIAL_EXPORT;</span><br><span>@@ -1856,7 +1855,6 @@</span><br><=
span>     {</span><br><span>         o-&gt;imported_protocol_flags |=3D CO_=
USE_DYNAMIC_TLS_CRYPT;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br><span>     if (p=
roto &amp; IV_PROTO_CC_EXIT_NOTIFY)</span><br><span>     {</span><br><span>=
diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>=
index bcc18a5..937b74f 100644</span><br><span>--- a/src/openvpn/options.c</=
span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -664,10 +664,=
8 @@</span><br><span> #endif</span><br><span>     &quot;--x509-track x  : S=
ave peer X509 attribute x in environment for use by\n&quot;</span><br><span=
>     &quot;                  plugins and management interface.\n&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING=
_MATERIAL</span><br><span>     &quot;--keying-material-exporter label len :=
 Save Exported Keying Material (RFC5705)\n&quot;</span><br><span>     &quot=
;                  of len bytes (min. 16 bytes) using label in environment =
for use by plugins.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span>     &quot;--remote-cert-ku v ... : Require th=
at the peer certificate was signed with\n&quot;</span><br><span>     &quot;=
                  explicit key usage, you can specify more than one value.\=
n&quot;</span><br><span>     &quot;                  value should be given =
in hex format.\n&quot;</span><br><span>@@ -3595,10 +3593,6 @@</span><br><sp=
an>             &quot;calculation anymore or your security policy (e.g. FIP=
S 140-2) &quot;</span><br><span>             &quot;forbids it. Connections =
will only work with peers running &quot;</span><br><span>             &quot=
;OpenVPN 2.6.0 or higher)&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifndef HAVE_EXPORT_KEYING_MATERIAL</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;Keying Material Export=
ers (RFC 5705) not available either. &quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            &quot;No way to generate data channel key=
s left.&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span>         if (o-&gt;mode =3D=3D MODE_SERVER)</span><br><spa=
n>         {</span><br><span>             msg(M_WARN, &quot;Automatically e=
nabling option &quot;</span><br><span>@@ -8664,13 +8658,11 @@</span><br><sp=
an>         /* NCP only option that is pushed by the server to enable EKM,<=
/span><br><span>          * should not be used by normal users in config fi=
les*/</span><br><span>         VERIFY_PERMISSION(OPT_P_NCP)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</s=
pan><br><span>         if (streq(p[1], &quot;tls-ekm&quot;))</span><br><spa=
n>         {</span><br><span>             options-&gt;imported_protocol_fla=
gs |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span><br><span>         }</span><b=
r><span>         else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span>         {</span><br><span>             msg(msglevel=
, &quot;Unknown key-derivation method %s&quot;, p[1]);</span><br><span>    =
     }</span><br><span>@@ -8687,7 +8679,6 @@</span><br><span>             {=
</span><br><span>                 options-&gt;imported_protocol_flags |=3D =
CO_USE_CC_EXIT_NOTIFY;</span><br><span>             }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><b=
r><span>             else if (streq(p[j], &quot;tls-ekm&quot;))</span><br><=
span>             {</span><br><span>                 options-&gt;imported_p=
rotocol_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span><br><span>@@ -8696=
,7 +8687,6 @@</span><br><span>             {</span><br><span>              =
   options-&gt;imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;</span=
><br><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span>             else if (streq(p[j], &quot;aead-epo=
ch&quot;))</span><br><span>             {</span><br><span>                 =
options-&gt;imported_protocol_flags |=3D CO_EPOCH_DATA_KEY_FORMAT;</span><b=
r><span>@@ -9453,7 +9443,6 @@</span><br><span>         options-&gt;use_peer=
_id =3D true;</span><br><span>         options-&gt;peer_id =3D atoi_warn(p[=
1], msglevel);</span><br><span>     }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span>     els=
e if (streq(p[0], &quot;keying-material-exporter&quot;) &amp;&amp; p[1] &am=
p;&amp; p[2])</span><br><span>     {</span><br><span>         int ekm_lengt=
h =3D positive_atoi(p[2], msglevel);</span><br><span>@@ -9480,7 +9469,6 @@<=
/span><br><span>         options-&gt;keying_material_exporter_label =3D p[1=
];</span><br><span>         options-&gt;keying_material_exporter_length =3D=
 ekm_length;</span><br><span>     }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif /* HAVE_EXPORT_KEYING_MATERIAL */</span><br><span>    =
 else if (streq(p[0], &quot;allow-recursive-routing&quot;) &amp;&amp; !p[1]=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_G=
ENERAL);</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/o=
ptions.h</span><br><span>index 8d1ef6c..b0b8d96 100644</span><br><span>--- =
a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><=
br><span>@@ -701,11 +701,9 @@</span><br><span>     bool use_peer_id;</span>=
<br><span>     uint32_t peer_id;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><=
span>     /* Keying Material Exporters [RFC 5705] */</span><br><span>     c=
onst char *keying_material_exporter_label;</span><br><span>     int keying_=
material_exporter_length;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span>     /* force using TLS key material export for =
data channel key generation */</span><br><span>     bool force_key_material=
_export;</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl.c b=
/src/openvpn/ssl.c</span><br><span>index fd299ef..5ecf42b 100644</span><br>=
<span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span=
><br><span>@@ -2034,10 +2034,8 @@</span><br><span> </span><br><span>       =
  buf_printf(&amp;out, &quot;IV_CIPHERS=3D%s\n&quot;, session-&gt;opt-&gt;c=
onfig_ncp_ciphers);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span>        =
 iv_proto |=3D IV_PROTO_TLS_KEY_EXPORT;</span><br><span>         iv_proto |=
=3D IV_PROTO_DYN_TLS_CRYPT;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span> </span><br><span>         buf_printf(&amp;out=
, &quot;IV_PROTO=3D%d\n&quot;, iv_proto);</span><br><span> </span><br><span=
>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><=
br><span>index ec3135a..6474f80 100644</span><br><span>--- a/src/openvpn/ss=
l_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span=
>@@ -174,8 +174,6 @@</span><br><span>     return ctx-&gt;initialised;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> #if HAVE_MBEDTLS_SSL_CONF_EXPORT_K=
EYS_EXT_CB</span><br><span> /*</span><br><span>  * Key export callback for =
older versions of mbed TLS, to be used with</span><br><span>@@ -254,7 +252,=
7 @@</span><br><span>     cache-&gt;tls_prf_type =3D tls_prf_type;</span><b=
r><span> }</span><br><span> #else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_=
EXT_CB */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#error eithe=
r HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB or HAVE_MBEDTLS_SSL_SET_EXPORT_K=
EYS_CB must be defined when HAVE_EXPORT_KEYING_MATERIAL is defined</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#error either mbedtls_ssl_co=
nf_export_keys_ext_cb or mbedtls_ssl_set_export_keys_cb must be available i=
n mbed TLS</span><br><span> #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT=
_CB */</span><br><span> </span><br><span> bool</span><br><span>@@ -289,16 +=
287,6 @@</span><br><span>         return false;</span><br><span>     }</spa=
n><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  =
/* ifdef HAVE_EXPORT_KEYING_MATERIAL */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-key_state_export_keying_material(struct tls_session *session,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                 c=
onst char *label, size_t label_size,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                 void *ekm, size_t ekm_size)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* Dummy function to avoid ifdefs in =
the common code */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_EXPORT_KEYIN=
G_MATERIAL */</span><br><span> </span><br><span> bool</span><br><span> tls_=
ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)</span><br=
><span>diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h</=
span><br><span>index ec30bb5..9ebb2ce 100644</span><br><span>--- a/src/open=
vpn/ssl_mbedtls.h</span><br><span>+++ b/src/openvpn/ssl_mbedtls.h</span><br=
><span>@@ -85,7 +85,6 @@</span><br><span>     void *sign_ctx;</span><br><sp=
an> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span> /** struct to cache =
TLS secrets for keying material exporter (RFC 5705).</span><br><span>  * Th=
e constants (64 and 48) are inherent to TLS version and</span><br><span>  *=
 the whole keying material export will likely change when they change */</s=
pan><br><span>@@ -94,9 +93,6 @@</span><br><span>     mbedtls_tls_prf_types =
tls_prf_type;</span><br><span>     unsigned char master_secret[48];</span><=
br><span> };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /*=
 ifdef HAVE_EXPORT_KEYING_MATERIAL */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-struct tls_key_cache { };</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span> </span><br><span> /**</span><br=
><span>  * Structure that wraps the TLS context. Contents differ depending =
on the</span><br><span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl=
_ncp.c</span><br><span>index ead91da..a9cd470 100644</span><br><span>--- a/=
src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br=
><span>@@ -446,7 +446,6 @@</span><br><span>         session-&gt;opt-&gt;cry=
pto_flags &amp;=3D ~CO_EPOCH_DATA_KEY_FORMAT;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(HAVE_EXPORT_KEYING_MATERIAL)</span><br><span>     if (iv_proto_peer &amp;=
 IV_PROTO_TLS_KEY_EXPORT)</span><br><span>     {</span><br><span>         s=
ession-&gt;opt-&gt;crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span>=
<br><span>@@ -479,7 +478,6 @@</span><br><span>     {</span><br><span>      =
   session-&gt;opt-&gt;crypto_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif =
/* if defined(HAVE_EXPORT_KEYING_MATERIAL) */</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1043?usp=3Demail">ch=
ange 1043</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1043?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icbfffae877f8eca8d94721a4d54=
e140c50d4a550 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1043 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Y0Rh4YO1cYk=--

