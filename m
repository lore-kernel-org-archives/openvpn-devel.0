From: "MaxF (Code Review)" <gerrit@...515...>
Date: Tue, 18 Jun 2024 12:41:52 +0000
In-Reply-To: <gerrit.1718271320000.If96c2ebd2af16b18ed34820e8c0531547e2076d9@...2715...>
References: <gerrit.1718271320000.If96c2ebd2af16b18ed34820e8c0531547e2076d9@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 rein.vanbaaren@...1435..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d964ea9dde4439185c8db0ed4a28e4b112a16adc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4yM6A2UsbzU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix
 MBEDTLS_DEPRECATED_REMOVED build errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: comododragon <rein.vanbaaren@...1435...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4yM6A2UsbzU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

MaxF has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/681=
?usp=3Demail )

Change subject: Fix MBEDTLS_DEPRECATED_REMOVED build errors
......................................................................

Fix MBEDTLS_DEPRECATED_REMOVED build errors

This commit allows compiling OpenVPN with recent versions of mbed TLS
if MBEDTLS_DEPRECATED_REMOVED is defined.

Change-Id: If96c2ebd2af16b18ed34820e8c0531547e2076d9
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Reviewed-on: http://gerrit.openvpn.net/c/openvpn/+/681
Reviewed-by: plaisthos <arne-openvpn@...1227...>
---
M src/openvpn/mbedtls_compat.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
3 files changed, 75 insertions(+), 29 deletions(-)

Approvals:
  plaisthos: Looks good to me, approved




diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index d742b54..8559c2e 100644
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
index ec9ec13..bb88da9 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -402,7 +402,7 @@

     /* Get number of groups and allocate an array in ctx */
     int groups_count =3D get_num_elements(groups, ':');
-    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_ecp_group_id, groups_count + 1)
+    ALLOC_ARRAY_CLEAR(ctx->groups, mbedtls_compat_group_id, groups_count +=
 1)

     /* Parse allowed ciphers, getting IDs */
     int i =3D 0;
@@ -419,11 +419,15 @@
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
@@ -1046,33 +1050,30 @@
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

@@ -1153,7 +1154,7 @@

     if (ssl_ctx->groups)
     {
-        mbedtls_ssl_conf_curves(ks_ssl->ssl_config, ssl_ctx->groups);
+        mbedtls_ssl_conf_groups(ks_ssl->ssl_config, ssl_ctx->groups);
     }

     /* Disable TLS renegotiations if the mbedtls library supports that fea=
ture.
@@ -1203,15 +1204,14 @@
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
@@ -1220,20 +1220,19 @@
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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/681?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If96c2ebd2af16b18ed34820e8c0531547e2076d9
Gerrit-Change-Number: 681
Gerrit-PatchSet: 5
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: comododragon <rein.vanbaaren@...1435...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--4yM6A2UsbzU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>MaxF <strong>submitted</strong> this change.</p><p><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/681?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap">Approvals:
  plaisthos: Looks good to me, approved

</div><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">Fix MBEDTLS_DEPRECATED_REMOVED build errors<br><br>This commit allows co=
mpiling OpenVPN with recent versions of mbed TLS<br>if MBEDTLS_DEPRECATED_R=
EMOVED is defined.<br><br>Change-Id: If96c2ebd2af16b18ed34820e8c0531547e207=
6d9<br>Signed-off-by: Max Fillinger &lt;maximilian.fillinger@...2507...&gt;=
<br>Reviewed-on: http://gerrit.openvpn.net/c/openvpn/+/681<br>Reviewed-by: =
plaisthos &lt;arne-openvpn@...1227...&gt;<br>---<br>M src/openvpn/mbedtls_c=
ompat.h<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_mbedtls.h<br>3 =
files changed, 75 insertions(+), 29 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h=
</span><br><span>index d742b54..8559c2e 100644</span><br><span>--- a/src/op=
envpn/mbedtls_compat.h</span><br><span>+++ b/src/openvpn/mbedtls_compat.h</=
span><br><span>@@ -40,6 +40,7 @@</span><br><span> #include &lt;mbedtls/ciph=
er.h&gt;</span><br><span> #include &lt;mbedtls/ctr_drbg.h&gt;</span><br><sp=
an> #include &lt;mbedtls/dhm.h&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;mbedtls/ecp.h&gt;</span><br><span> #include &lt=
;mbedtls/md.h&gt;</span><br><span> #include &lt;mbedtls/pem.h&gt;</span><br=
><span> #include &lt;mbedtls/pk.h&gt;</span><br><span>@@ -51,6 +52,12 @@</s=
pan><br><span>     #include &lt;psa/crypto.h&gt;</span><br><span> #endif</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+typedef uint16_t mbedtls_compat_group_id;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+typedef mbedtls_ecp_group_id mbedtls_compat_g=
roup_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static=
 inline void</span><br><span> mbedtls_compat_psa_crypto_init(void)</span><b=
r><span> {</span><br><span>@@ -64,6 +71,16 @@</span><br><span> #endif /* HA=
VE_MBEDTLS_PSA_CRYPTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C) */</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static inline mbedtls_compat_group_id</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+mbedtls_compat_get_group_id(const mbedtls_ecp_c=
urve_info *curve_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VER=
SION_NUMBER &gt;=3D 0x03000000</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return curve_info-&gt;tls_id;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return curve_info-&gt;grp_id;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /*</span><br><span>  * In older versions of mbedtls, mbedtls_ct=
r_drbg_update() did not return an</span><br><span>  * error code, and it wa=
s deprecated in favor of mbedtls_ctr_drbg_update_ret()</span><br><span>@@ -=
124,6 +141,34 @@</span><br><span> }</span><br><span> </span><br><span> #if =
MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+typedef enum {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    MBEDTLS_SSL_VERSION_UNKNOWN, /*!&lt; Context not in use o=
r version not yet negotiated. */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    MBEDTLS_SSL_VERSION_TLS1_2 =3D 0x0303, /*!&lt; (D)TLS 1.2 =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    MBEDTLS_SSL_V=
ERSION_TLS1_3 =3D 0x0304, /*!&lt; (D)TLS 1.3 */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+} mbedtls_ssl_protocol_version;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static inline void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+mbedtls_ssl_conf_min_tls_version(mbedtls_ssl_config *co=
nf, mbedtls_ssl_protocol_version tls_version)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int major =3D (tls_version &gt;&gt; 8) &amp; 0xff;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int minor =3D tls_version &a=
mp; 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtl=
s_ssl_conf_min_version(conf, major, minor);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_ssl_co=
nf_max_tls_version(mbedtls_ssl_config *conf, mbedtls_ssl_protocol_version t=
ls_version)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int major =3D (tls_ver=
sion &gt;&gt; 8) &amp; 0xff;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int minor =3D tls_version &amp; 0xff;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    mbedtls_ssl_conf_max_version(conf, major=
, minor);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static inline void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+mbedtls_ssl_conf_groups(mbedtls_ssl_config *conf=
, mbedtls_compat_group_id *groups)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 mbedtls_ssl_conf_curves(conf, groups);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> static inline size_t</span><br><span> mbedtls_cipher_in=
fo_get_block_size(const mbedtls_cipher_info_t *cipher)</span><br><span> {</=
span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbe=
dtls.c</span><br><span>index ec9ec13..bb88da9 100644</span><br><span>--- a/=
src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</=
span><br><span>@@ -402,7 +402,7 @@</span><br><span> </span><br><span>     /=
* Get number of groups and allocate an array in ctx */</span><br><span>    =
 int groups_count =3D get_num_elements(groups, &#39;:&#39;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY_CLEAR(ctx-&gt;groups=
, mbedtls_ecp_group_id, groups_count + 1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ALLOC_ARRAY_CLEAR(ctx-&gt;groups, mbedtls_compat_=
group_id, groups_count + 1)</span><br><span> </span><br><span>     /* Parse=
 allowed ciphers, getting IDs */</span><br><span>     int i =3D 0;</span><b=
r><span>@@ -419,11 +419,15 @@</span><br><span>         }</span><br><span>  =
       else</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            ctx-&gt;groups[i] =3D ci-&gt;grp_id;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            ctx-&gt;groups[i]=
 =3D mbedtls_compat_get_group_id(ci);</span><br><span>             i++;</sp=
an><br><span>         }</span><br><span>     }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ctx-&gt;groups[i] =3D MBEDTLS_ECP_DP_NONE;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Recent mbedtls versions state that=
 the list of groups must be terminated</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * with 0. Older versions state that it must be term=
inated with MBEDTLS_ECP_DP_NONE</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * which is also 0, so this works either way. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;groups[i] =3D 0;</=
span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span> }<=
/span><br><span>@@ -1046,33 +1050,30 @@</span><br><span> }</span><br><span>=
 </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * Convert an OpenVPN tls-version variable to mbed TLS format (i.e. a majo=
r and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * minor ssl ver=
sion number).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Con=
vert an OpenVPN tls-version variable to mbed TLS format</span><br><span>  *=
</span><br><span>  * @param tls_ver       The tls-version variable to conve=
rt.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param major   =
      Returns the TLS major version in mbed TLS format.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *                      Must be a valid p=
ointer.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param mino=
r         Returns the TLS minor version in mbed TLS format.</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *                      Must be a val=
id pointer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Translated mbe=
dTLS SSL version from OpenVPN TLS version.</span><br><span>  */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tls_version_to_major_minor(int tls_ver, int=
 *major, int *minor)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+mbedtls_ssl_protocol_version</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+tls_version_to_ssl_version(int tls_ver)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(major);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(minor);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     switch (tls_=
ver)</span><br><span>     {</span><br><span> #if defined(MBEDTLS_SSL_PROTO_=
TLS1_2)</span><br><span>         case TLS_VER_1_2:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            *major =3D MBEDTLS_SSL_MAJOR_VERSI=
ON_3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *min=
or =3D MBEDTLS_SSL_MINOR_VERSION_3;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            return MBEDTLS_SSL_VERSION_TLS1_2;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        case TLS_VER_1_3:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return MBEDTLS_SSL_VERSION_TL=
S1_3;</span><br><span> #endif</span><br><span> </span><br><span>         de=
fault:</span><br><span>             msg(M_FATAL, &quot;%s: invalid or unsup=
ported TLS version %d&quot;, __func__, tls_ver);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return MBEDTLS_SSL_VERSION_UNKNOWN;</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span>=
@@ -1153,7 +1154,7 @@</span><br><span> </span><br><span>     if (ssl_ctx-&g=
t;groups)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        mbedtls_ssl_conf_curves(ks_ssl-&gt;ssl_config, ssl_ctx-&=
gt;groups);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
mbedtls_ssl_conf_groups(ks_ssl-&gt;ssl_config, ssl_ctx-&gt;groups);</span><=
br><span>     }</span><br><span> </span><br><span>     /* Disable TLS reneg=
otiations if the mbedtls library supports that feature.</span><br><span>@@ =
-1203,15 +1204,14 @@</span><br><span>             &amp;SSLF_TLS_VERSION_MIN=
_MASK;</span><br><span> </span><br><span>         /* default to TLS 1.2 */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int major =3D =
MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        int minor =3D MBEDTLS_SSL_MINOR_VERSION_3;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        mbedtls_ssl_protocol_version =
version =3D MBEDTLS_SSL_VERSION_TLS1_2;</span><br><span> </span><br><span> =
        if (configured_tls_version_min &gt; TLS_VER_UNSPEC)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  tls_version_to_major_minor(configured_tls_version_min, &amp;major, &amp;m=
inor);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            v=
ersion =3D tls_version_to_ssl_version(configured_tls_version_min);</span><b=
r><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        mbedtls_ssl_conf_min_version(ks_ssl-&gt;ssl_config, =
major, minor);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   mbedtls_ssl_conf_min_tls_version(ks_ssl-&gt;ssl_config, version);</span>=
<br><span>     }</span><br><span> </span><br><span>     /* Initialize maxim=
um TLS version */</span><br><span>@@ -1220,20 +1220,19 @@</span><br><span> =
            (session-&gt;opt-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX_SH=
IFT)</span><br><span>             &amp;SSLF_TLS_VERSION_MAX_MASK;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int m=
ajor =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
t minor =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   mbedtls_ssl_protocol_version version =3D MBEDTLS_SSL_VERSION_UNKNOWN;</s=
pan><br><span> </span><br><span>         if (configured_tls_version_max &gt=
; TLS_VER_UNSPEC)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            tls_version_to_major_minor(configured_tl=
s_version_max, &amp;major, &amp;minor);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            version =3D tls_version_to_ssl_version(conf=
igured_tls_version_max);</span><br><span>         }</span><br><span>       =
  else</span><br><span>         {</span><br><span>             /* Default t=
o tls_version_max(). */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            tls_version_to_major_minor(tls_version_max(), &amp;major, &am=
p;minor);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  version =3D tls_version_to_ssl_version(tls_version_max());</span><br><spa=
n>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        mbedtls_ssl_conf_max_version(ks_ssl-&gt;ssl_config, major,=
 minor);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mbe=
dtls_ssl_conf_max_tls_version(ks_ssl-&gt;ssl_config, version);</span><br><s=
pan>     }</span><br><span> </span><br><span> #if HAVE_MBEDTLS_SSL_CONF_EXP=
ORT_KEYS_EXT_CB</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.h b/sr=
c/openvpn/ssl_mbedtls.h</span><br><span>index 1fd0ce8..34b4f02 100644</span=
><br><span>--- a/src/openvpn/ssl_mbedtls.h</span><br><span>+++ b/src/openvp=
n/ssl_mbedtls.h</span><br><span>@@ -39,6 +39,8 @@</span><br><span> #include=
 &lt;pkcs11-helper-1.0/pkcs11h-certificate.h&gt;</span><br><span> #endif</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;mbedtls_compat.h&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> typedef struct _buffer_entry buffer_entry;<=
/span><br><span> </span><br><span> struct _buffer_entry {</span><br><span>@=
@ -118,7 +120,7 @@</span><br><span> #endif</span><br><span>     struct exte=
rnal_context external_key; /**&lt; External key context */</span><br><span>=
     int *allowed_ciphers;       /**&lt; List of allowed ciphers for this c=
onnection */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedt=
ls_ecp_group_id *groups;     /**&lt; List of allowed groups for this connec=
tion */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_=
compat_group_id *groups;     /**&lt; List of allowed groups for this connec=
tion */</span><br><span>     mbedtls_x509_crt_profile cert_profile; /**&lt;=
 Allowed certificate types */</span><br><span> };</span><br><span> </span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/681?usp=3Demail">change 681</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/681?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If96c2ebd2af16b18ed34820e8c0=
531547e2076d9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 681 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: comododragon &lt;rein.vanbaaren@...493...=
1435...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--4yM6A2UsbzU=--

