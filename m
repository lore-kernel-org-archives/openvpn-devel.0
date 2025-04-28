From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 28 Apr 2025 16:24:41 +0000
References: <gerrit.1745857478000.If96c2ebd2af16b18ed34820e8c0531547e2076d9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 rein.vanbaaren@...1435..., openvpn-devel@lists.sourceforge.net,
 gert@...1296...
Message-ID: <1ac8ee769c06755338f3d0c13ee935904efc49b4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="95CWvzLIHXI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Fix
 MBEDTLS_DEPRECATED_REMOVED build errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, comododragon <rein.vanbaaren@...1435...>, plaisthos <arne-openvpn@...1227...>

--95CWvzLIHXI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has uploaded this change for review. ( http://gerrit.openvpn.n=
et/c/openvpn/+/946?usp=3Demail )


Change subject: Fix MBEDTLS_DEPRECATED_REMOVED build errors
......................................................................

Fix MBEDTLS_DEPRECATED_REMOVED build errors

This commit allows compiling OpenVPN with recent versions of mbed TLS
if MBEDTLS_DEPRECATED_REMOVED is defined.

Change-Id: If96c2ebd2af16b18ed34820e8c0531547e2076d9
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240618120127.4564-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
771.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit 8eb397de3656402872f9c9584c6f703b87b50762)
---
M src/openvpn/mbedtls_compat.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
3 files changed, 75 insertions(+), 29 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/946/1

diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 610215b..46e082f 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -40,6 +40,7 @@
 #include <mbedtls/cipher.h>
 #include <mbedtls/ctr_drbg.h>
 #include <mbedtls/dhm.h>
+#include <mbedtls/ecp.h>
 #include <mbedtls/md.h>
 #include <mbedtls/pem.h>
 #include <mbedtls/pk.h>
@@ -51,6 +52,12 @@
     #include <psa/crypto.h>
 #endif

+#if MBEDTLS_VERSION_NUMBER >=3D 0x03000000
+typedef uint16_t mbedtls_compat_group_id;
+#else
+typedef mbedtls_ecp_group_id mbedtls_compat_group_id;
+#endif
+
 static inline void
 mbedtls_compat_psa_crypto_init(void)
 {
@@ -64,6 +71,16 @@
 #endif /* HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
 }

+static inline mbedtls_compat_group_id
+mbedtls_compat_get_group_id(const mbedtls_ecp_curve_info *curve_info)
+{
+#if MBEDTLS_VERSION_NUMBER >=3D 0x03000000
+    return curve_info->tls_id;
+#else
+    return curve_info->grp_id;
+#endif
+}
+
 /*
  * In older versions of mbedtls, mbedtls_ctr_drbg_update() did not return =
an
  * error code, and it was deprecated in favor of mbedtls_ctr_drbg_update_r=
et()
@@ -124,6 +141,34 @@
 }

 #if MBEDTLS_VERSION_NUMBER < 0x03020100
+typedef enum {
+    MBEDTLS_SSL_VERSION_UNKNOWN, /*!< Context not in use or version not ye=
t negotiated. */
+    MBEDTLS_SSL_VERSION_TLS1_2 =3D 0x0303, /*!< (D)TLS 1.2 */
+    MBEDTLS_SSL_VERSION_TLS1_3 =3D 0x0304, /*!< (D)TLS 1.3 */
+} mbedtls_ssl_protocol_version;
+
+static inline void
+mbedtls_ssl_conf_min_tls_version(mbedtls_ssl_config *conf, mbedtls_ssl_pro=
tocol_version tls_version)
+{
+    int major =3D (tls_version >> 8) & 0xff;
+    int minor =3D tls_version & 0xff;
+    mbedtls_ssl_conf_min_version(conf, major, minor);
+}
+
+static inline void
+mbedtls_ssl_conf_max_tls_version(mbedtls_ssl_config *conf, mbedtls_ssl_pro=
tocol_version tls_version)
+{
+    int major =3D (tls_version >> 8) & 0xff;
+    int minor =3D tls_version & 0xff;
+    mbedtls_ssl_conf_max_version(conf, major, minor);
+}
+
+static inline void
+mbedtls_ssl_conf_groups(mbedtls_ssl_config *conf, mbedtls_compat_group_id =
*groups)
+{
+    mbedtls_ssl_conf_curves(conf, groups);
+}
+
 static inline size_t
 mbedtls_cipher_info_get_block_size(const mbedtls_cipher_info_t *cipher)
 {
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 7e29bd2..35313c5 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -401,7 +401,7 @@

     /* Get number of groups and allocate an array in ctx */
     int groups_count =3D get_num_elements(groups, ':');
-    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_ecp_group_id, groups_count + 1)
+    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_compat_group_id, groups_count +=
 1)

     /* Parse allowed ciphers, getting IDs */
     int i =3D 0;
@@ -418,11 +418,15 @@
         }
         else
         {
-            ctx->groups[i] =3D ci->grp_id;
+            ctx->groups[i] =3D mbedtls_compat_get_group_id(ci);
             i++;
         }
     }
-    ctx->groups[i] =3D MBEDTLS_ECP_DP_NONE;
+
+    /* Recent mbedtls versions state that the list of groups must be termi=
nated
+     * with 0. Older versions state that it must be terminated with MBEDTL=
S_ECP_DP_NONE
+     * which is also 0, so this works either way. */
+    ctx->groups[i] =3D 0;

     gc_free(&gc);
 }
@@ -1049,21 +1053,15 @@
 }

 /**
- * Convert an OpenVPN tls-version variable to mbed TLS format (i.e. a majo=
r and
- * minor ssl version number).
+ * Convert an OpenVPN tls-version variable to mbed TLS format
  *
  * @param tls_ver       The tls-version variable to convert.
- * @param major         Returns the TLS major version in mbed TLS format.
- *                      Must be a valid pointer.
- * @param minor         Returns the TLS minor version in mbed TLS format.
- *                      Must be a valid pointer.
+ *
+ * @return Translated mbedTLS SSL version from OpenVPN TLS version.
  */
-static void
-tls_version_to_major_minor(int tls_ver, int *major, int *minor)
+mbedtls_ssl_protocol_version
+tls_version_to_ssl_version(int tls_ver)
 {
-    ASSERT(major);
-    ASSERT(minor);
-
     switch (tls_ver)
     {
 #if defined(MBEDTLS_SSL_PROTO_TLS1)
@@ -1082,14 +1080,17 @@

 #if defined(MBEDTLS_SSL_PROTO_TLS1_2)
         case TLS_VER_1_2:
-            *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_3;
-            break;
+            return MBEDTLS_SSL_VERSION_TLS1_2;
+#endif
+
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
+        case TLS_VER_1_3:
+            return MBEDTLS_SSL_VERSION_TLS1_3;
 #endif

         default:
             msg(M_FATAL, "%s: invalid or unsupported TLS version %d", __fu=
nc__, tls_ver);
-            break;
+            return MBEDTLS_SSL_VERSION_UNKNOWN;
     }
 }

@@ -1170,7 +1171,7 @@

     if (ssl_ctx->groups)
     {
-        mbedtls_ssl_conf_curves(ks_ssl->ssl_config, ssl_ctx->groups);
+        mbedtls_ssl_conf_groups(ks_ssl->ssl_config, ssl_ctx->groups);
     }

     /* Disable TLS renegotiations if the mbedtls library supports that fea=
ture.
@@ -1220,15 +1221,14 @@
             &SSLF_TLS_VERSION_MIN_MASK;

         /* default to TLS 1.2 */
-        int major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
-        int minor =3D MBEDTLS_SSL_MINOR_VERSION_3;
+        mbedtls_ssl_protocol_version version =3D MBEDTLS_SSL_VERSION_TLS1_=
2;

         if (configured_tls_version_min > TLS_VER_UNSPEC)
         {
-            tls_version_to_major_minor(configured_tls_version_min, &major,=
 &minor);
+            version =3D tls_version_to_ssl_version(configured_tls_version_=
min);
         }

-        mbedtls_ssl_conf_min_version(ks_ssl->ssl_config, major, minor);
+        mbedtls_ssl_conf_min_tls_version(ks_ssl->ssl_config, version);
     }

     /* Initialize maximum TLS version */
@@ -1237,20 +1237,19 @@
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
             &SSLF_TLS_VERSION_MAX_MASK;

-        int major =3D 0;
-        int minor =3D 0;
+        mbedtls_ssl_protocol_version version =3D MBEDTLS_SSL_VERSION_UNKNO=
WN;

         if (configured_tls_version_max > TLS_VER_UNSPEC)
         {
-            tls_version_to_major_minor(configured_tls_version_max, &major,=
 &minor);
+            version =3D tls_version_to_ssl_version(configured_tls_version_=
max);
         }
         else
         {
             /* Default to tls_version_max(). */
-            tls_version_to_major_minor(tls_version_max(), &major, &minor);
+            version =3D tls_version_to_ssl_version(tls_version_max());
         }

-        mbedtls_ssl_conf_max_version(ks_ssl->ssl_config, major, minor);
+        mbedtls_ssl_conf_max_tls_version(ks_ssl->ssl_config, version);
     }

 #if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 1fd0ce8..34b4f02 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -39,6 +39,8 @@
 #include <pkcs11-helper-1.0/pkcs11h-certificate.h>
 #endif

+#include "mbedtls_compat.h"
+
 typedef struct _buffer_entry buffer_entry;

 struct _buffer_entry {
@@ -118,7 +120,7 @@
 #endif
     struct external_context external_key; /**< External key context */
     int *allowed_ciphers;       /**< List of allowed ciphers for this conn=
ection */
-    mbedtls_ecp_group_id *groups;     /**< List of allowed groups for this=
 connection */
+    mbedtls_compat_group_id *groups;     /**< List of allowed groups for t=
his connection */
     mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate types =
*/
 };


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/946?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: If96c2ebd2af16b18ed34820e8c0531547e2076d9
Gerrit-Change-Number: 946
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: comododragon <rein.vanbaaren@...1435...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-MessageType: newchange

--95CWvzLIHXI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>flichtenheld has uploaded this change for <strong>review</strong>.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/946?usp=3Demail">View Cha=
nge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">Fix MBEDTLS_DEPRECATED_REMOVED build errors<br><br>This commit allo=
ws compiling OpenVPN with recent versions of mbed TLS<br>if MBEDTLS_DEPRECA=
TED_REMOVED is defined.<br><br>Change-Id: If96c2ebd2af16b18ed34820e8c053154=
7e2076d9<br>Signed-off-by: Max Fillinger &lt;maximilian.fillinger@...2782...=
.&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-=
Id: &lt;20240618120127.4564-1-gert@...1296...&gt;<br>URL: https://www.mail-=
archive.com/openvpn-devel@lists.sourceforge.net/msg28771.html<br>Signed-off=
-by: Gert Doering &lt;gert@...1296...&gt;<br>(cherry picked from commit 8eb=
397de3656402872f9c9584c6f703b87b50762)<br>---<br>M src/openvpn/mbedtls_comp=
at.h<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_mbedtls.h<br>3 fil=
es changed, 75 insertions(+), 29 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/46/946/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h</span><br><span>in=
dex 610215b..46e082f 100644</span><br><span>--- a/src/openvpn/mbedtls_compa=
t.h</span><br><span>+++ b/src/openvpn/mbedtls_compat.h</span><br><span>@@ -=
40,6 +40,7 @@</span><br><span> #include &lt;mbedtls/cipher.h&gt;</span><br>=
<span> #include &lt;mbedtls/ctr_drbg.h&gt;</span><br><span> #include &lt;mb=
edtls/dhm.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;mbedtls/ecp.h&gt;</span><br><span> #include &lt;mbedtls/md.h&gt;</=
span><br><span> #include &lt;mbedtls/pem.h&gt;</span><br><span> #include &l=
t;mbedtls/pk.h&gt;</span><br><span>@@ -51,6 +52,12 @@</span><br><span>     =
#include &lt;psa/crypto.h&gt;</span><br><span> #endif</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUM=
BER &gt;=3D 0x03000000</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+typedef uint16_t mbedtls_compat_group_id;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+typedef mbedtls_ecp_group_id mbedtls_compat_group_id;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inline void</spa=
n><br><span> mbedtls_compat_psa_crypto_init(void)</span><br><span> {</span>=
<br><span>@@ -64,6 +71,16 @@</span><br><span> #endif /* HAVE_MBEDTLS_PSA_CR=
YPTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C) */</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
inline mbedtls_compat_group_id</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+mbedtls_compat_get_group_id(const mbedtls_ecp_curve_info *curve_=
info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=
=3D 0x03000000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn curve_info-&gt;tls_id;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn curve_info-&gt;grp_id;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</=
span><br><span>  * In older versions of mbedtls, mbedtls_ctr_drbg_update() =
did not return an</span><br><span>  * error code, and it was deprecated in =
favor of mbedtls_ctr_drbg_update_ret()</span><br><span>@@ -124,6 +141,34 @@=
</span><br><span> }</span><br><span> </span><br><span> #if MBEDTLS_VERSION_=
NUMBER &lt; 0x03020100</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+typedef enum {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  MBEDTLS_SSL_VERSION_UNKNOWN, /*!&lt; Context not in use or version not ye=
t negotiated. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 MBEDTLS_SSL_VERSION_TLS1_2 =3D 0x0303, /*!&lt; (D)TLS 1.2 */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    MBEDTLS_SSL_VERSION_TLS1_3 =
=3D 0x0304, /*!&lt; (D)TLS 1.3 */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+} mbedtls_ssl_protocol_version;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static inline void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+mbedtls_ssl_conf_min_tls_version(mbedtls_ssl_config *conf, mbedtls_ss=
l_protocol_version tls_version)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t major =3D (tls_version &gt;&gt; 8) &amp; 0xff;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int minor =3D tls_version &amp; 0xff;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_ssl_conf_min=
_version(conf, major, minor);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static inline void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_ssl_conf_max_tls_ver=
sion(mbedtls_ssl_config *conf, mbedtls_ssl_protocol_version tls_version)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int major =3D (tls_version &gt;&gt; =
8) &amp; 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt minor =3D tls_version &amp; 0xff;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    mbedtls_ssl_conf_max_version(conf, major, minor);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+mbedtls_ssl_conf_groups(mbedtls_ssl_config *conf, mbedtls_com=
pat_group_id *groups)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_ssl_=
conf_curves(conf, groups);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> static inline size_t</span><br><span> mbedtls_cipher_info_get_block_=
size(const mbedtls_cipher_info_t *cipher)</span><br><span> {</span><br><spa=
n>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span>=
<br><span>index 7e29bd2..35313c5 100644</span><br><span>--- a/src/openvpn/s=
sl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><spa=
n>@@ -401,7 +401,7 @@</span><br><span> </span><br><span>     /* Get number =
of groups and allocate an array in ctx */</span><br><span>     int groups_c=
ount =3D get_num_elements(groups, &#39;:&#39;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ALLOC_ARRAY_CLEAR(ctx-&gt;groups, mbedtls_ecp=
_group_id, groups_count + 1)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ALLOC_ARRAY_CLEAR(ctx-&gt;groups, mbedtls_compat_group_id, gro=
ups_count + 1)</span><br><span> </span><br><span>     /* Parse allowed ciph=
ers, getting IDs */</span><br><span>     int i =3D 0;</span><br><span>@@ -4=
18,11 +418,15 @@</span><br><span>         }</span><br><span>         else</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            ctx-&gt;groups[i] =3D ci-&gt;grp_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ctx-&gt;groups[i] =3D mbedtls=
_compat_get_group_id(ci);</span><br><span>             i++;</span><br><span=
>         }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ctx-&gt;groups[i] =3D MBEDTLS_ECP_DP_NONE;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Recent mbedtls versions state that the list of =
groups must be terminated</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * with 0. Older versions state that it must be terminated with M=
BEDTLS_ECP_DP_NONE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * which is also 0, so this works either way. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;groups[i] =3D 0;</span><br><s=
pan> </span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><=
span>@@ -1049,21 +1053,15 @@</span><br><span> }</span><br><span> </span><br=
><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Convert=
 an OpenVPN tls-version variable to mbed TLS format (i.e. a major and</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * minor ssl version number=
).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Convert an Ope=
nVPN tls-version variable to mbed TLS format</span><br><span>  *</span><br>=
<span>  * @param tls_ver       The tls-version variable to convert.</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param major         Retur=
ns the TLS major version in mbed TLS format.</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *                      Must be a valid pointer.</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param minor         R=
eturns the TLS minor version in mbed TLS format.</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *                      Must be a valid pointer.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @return Translated mbedTLS SSL ve=
rsion from OpenVPN TLS version.</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-tls_version_to_major_minor(int tls_ver, int *major, i=
nt *minor)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_s=
sl_protocol_version</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
tls_version_to_ssl_version(int tls_ver)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(major);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ASSERT(minor);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     switch (tls_ver)</spa=
n><br><span>     {</span><br><span> #if defined(MBEDTLS_SSL_PROTO_TLS1)</sp=
an><br><span>@@ -1082,14 +1080,17 @@</span><br><span> </span><br><span> #if=
 defined(MBEDTLS_SSL_PROTO_TLS1_2)</span><br><span>         case TLS_VER_1_=
2:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *major =
=3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_3;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return MBEDTLS_SSL_VERS=
ION_TLS1_2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TLS_VER_1=
_3:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn MBEDTLS_SSL_VERSION_TLS1_3;</span><br><span> #endif</span><br><span> </s=
pan><br><span>         default:</span><br><span>             msg(M_FATAL, &=
quot;%s: invalid or unsupported TLS version %d&quot;, __func__, tls_ver);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return MBEDT=
LS_SSL_VERSION_UNKNOWN;</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span>@@ -1170,7 +1171,7 @@</span><br><span> </span><br>=
<span>     if (ssl_ctx-&gt;groups)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        mbedtls_ssl_conf_curves(ks_ssl-=
&gt;ssl_config, ssl_ctx-&gt;groups);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        mbedtls_ssl_conf_groups(ks_ssl-&gt;ssl_config, ssl=
_ctx-&gt;groups);</span><br><span>     }</span><br><span> </span><br><span>=
     /* Disable TLS renegotiations if the mbedtls library supports that fea=
ture.</span><br><span>@@ -1220,15 +1221,14 @@</span><br><span>             =
&amp;SSLF_TLS_VERSION_MIN_MASK;</span><br><span> </span><br><span>         =
/* default to TLS 1.2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        int minor =3D MBEDTLS_SSL_MINOR_VER=
SION_3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbed=
tls_ssl_protocol_version version =3D MBEDTLS_SSL_VERSION_TLS1_2;</span><br>=
<span> </span><br><span>         if (configured_tls_version_min &gt; TLS_VE=
R_UNSPEC)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            tls_version_to_major_minor(configured_tls_versio=
n_min, &amp;major, &amp;minor);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            version =3D tls_version_to_ssl_version(configured_t=
ls_version_min);</span><br><span>         }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        mbedtls_ssl_conf_min_versio=
n(ks_ssl-&gt;ssl_config, major, minor);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        mbedtls_ssl_conf_min_tls_version(ks_ssl-&gt;ssl=
_config, version);</span><br><span>     }</span><br><span> </span><br><span=
>     /* Initialize maximum TLS version */</span><br><span>@@ -1237,20 +123=
7,19 @@</span><br><span>             (session-&gt;opt-&gt;ssl_flags &gt;&gt=
; SSLF_TLS_VERSION_MAX_SHIFT)</span><br><span>             &amp;SSLF_TLS_VE=
RSION_MAX_MASK;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        int major =3D 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        int minor =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        mbedtls_ssl_protocol_version version =3D MBEDTL=
S_SSL_VERSION_UNKNOWN;</span><br><span> </span><br><span>         if (confi=
gured_tls_version_max &gt; TLS_VER_UNSPEC)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            tls_version_to_=
major_minor(configured_tls_version_max, &amp;major, &amp;minor);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            version =3D tls_ve=
rsion_to_ssl_version(configured_tls_version_max);</span><br><span>         =
}</span><br><span>         else</span><br><span>         {</span><br><span>=
             /* Default to tls_version_max(). */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            tls_version_to_major_minor(tls_versi=
on_max(), &amp;major, &amp;minor);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            version =3D tls_version_to_ssl_version(tls_versi=
on_max());</span><br><span>         }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        mbedtls_ssl_conf_max_version(ks_s=
sl-&gt;ssl_config, major, minor);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        mbedtls_ssl_conf_max_tls_version(ks_ssl-&gt;ssl_confi=
g, version);</span><br><span>     }</span><br><span> </span><br><span> #if =
HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</span><br><span>diff --git a/src/o=
penvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h</span><br><span>index 1fd0=
ce8..34b4f02 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.h</span><=
br><span>+++ b/src/openvpn/ssl_mbedtls.h</span><br><span>@@ -39,6 +39,8 @@<=
/span><br><span> #include &lt;pkcs11-helper-1.0/pkcs11h-certificate.h&gt;</=
span><br><span> #endif</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;mbedtls_compat.h&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef struct _bu=
ffer_entry buffer_entry;</span><br><span> </span><br><span> struct _buffer_=
entry {</span><br><span>@@ -118,7 +120,7 @@</span><br><span> #endif</span><=
br><span>     struct external_context external_key; /**&lt; External key co=
ntext */</span><br><span>     int *allowed_ciphers;       /**&lt; List of a=
llowed ciphers for this connection */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    mbedtls_ecp_group_id *groups;     /**&lt; List of allow=
ed groups for this connection */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    mbedtls_compat_group_id *groups;     /**&lt; List of allow=
ed groups for this connection */</span><br><span>     mbedtls_x509_crt_prof=
ile cert_profile; /**&lt; Allowed certificate types */</span><br><span> };<=
/span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/946?usp=3Demail">change 946</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/946?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: If96c2ebd2af16b18ed34820e8c0=
531547e2076d9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 946 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: comododragon &lt;rein.vanbaaren@...493...=
1435...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--95CWvzLIHXI=--

