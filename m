From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 29 Apr 2025 11:08:51 +0000
In-Reply-To: <gerrit.1745857478000.If96c2ebd2af16b18ed34820e8c0531547e2076d9@...2715...>
References: <gerrit.1745857478000.If96c2ebd2af16b18ed34820e8c0531547e2076d9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 rein.vanbaaren@...1435..., openvpn-devel@lists.sourceforge.net,
 gert@...1296...
Message-ID: <374744a486ca2e990a536a404561b34111f80910-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t/9Ww/X93lo="; charset=UTF-8
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
To: comododragon <rein.vanbaaren@...1435...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--t/9Ww/X93lo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/946?usp=3Demail

to look at the new patch set (#2).


Change subject: Fix MBEDTLS_DEPRECATED_REMOVED build errors
......................................................................

Fix MBEDTLS_DEPRECATED_REMOVED build errors

This commit allows compiling OpenVPN with recent versions of mbed TLS
if MBEDTLS_DEPRECATED_REMOVED is defined.

Cherry-pick note:
- Adapt to still support TLS 1.0 and 1.1 which were removed in
  master.

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
3 files changed, 79 insertions(+), 35 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/946/2

diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 610215b..5705706 100644
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
@@ -124,6 +141,36 @@
 }

 #if MBEDTLS_VERSION_NUMBER < 0x03020100
+typedef enum {
+    MBEDTLS_SSL_VERSION_UNKNOWN, /*!< Context not in use or version not ye=
t negotiated. */
+    MBEDTLS_SSL_VERSION_TLS1_0 =3D 0x0301, /*!< (D)TLS 1.0 */
+    MBEDTLS_SSL_VERSION_TLS1_1 =3D 0x0302, /*!< (D)TLS 1.1 */
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
index 7e29bd2..8fb69c3 100644
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
@@ -1049,47 +1053,40 @@
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
+static mbedtls_ssl_protocol_version
+tls_version_to_ssl_version(int tls_ver)
 {
-    ASSERT(major);
-    ASSERT(minor);
-
     switch (tls_ver)
     {
 #if defined(MBEDTLS_SSL_PROTO_TLS1)
         case TLS_VER_1_0:
-            *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_1;
-            break;
+            return MBEDTLS_SSL_VERSION_TLS1_0;
 #endif

 #if defined(MBEDTLS_SSL_PROTO_TLS1_1)
         case TLS_VER_1_1:
-            *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_2;
-            break;
+            return MBEDTLS_SSL_VERSION_TLS1_1;
 #endif

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

@@ -1170,7 +1167,7 @@

     if (ssl_ctx->groups)
     {
-        mbedtls_ssl_conf_curves(ks_ssl->ssl_config, ssl_ctx->groups);
+        mbedtls_ssl_conf_groups(ks_ssl->ssl_config, ssl_ctx->groups);
     }

     /* Disable TLS renegotiations if the mbedtls library supports that fea=
ture.
@@ -1220,15 +1217,14 @@
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
@@ -1237,20 +1233,19 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: comododragon <rein.vanbaaren@...1435...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--t/9Ww/X93lo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/946?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Fix MBEDTLS_DEPRECATED_REMOVED build errors<br><br>This commit all=
ows compiling OpenVPN with recent versions of mbed TLS<br>if MBEDTLS_DEPREC=
ATED_REMOVED is defined.<br><br>Cherry-pick note:<br>- Adapt to still suppo=
rt TLS 1.0 and 1.1 which were removed in<br>  master.<br><br>Change-Id: If9=
6c2ebd2af16b18ed34820e8c0531547e2076d9<br>Signed-off-by: Max Fillinger &lt;=
maximilian.fillinger@...2507...&gt;<br>Acked-by: Arne Schwabe &lt;arne-open=
vpn@...1227...&gt;<br>Message-Id: &lt;20240618120127.4564-1-gert@...1296...=
&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1223...=
et/msg28771.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
(cherry picked from commit 8eb397de3656402872f9c9584c6f703b87b50762)<br>---=
<br>M src/openvpn/mbedtls_compat.h<br>M src/openvpn/ssl_mbedtls.c<br>M src/=
openvpn/ssl_mbedtls.h<br>3 files changed, 79 insertions(+), 35 deletions(-)=
<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/=
946/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedt=
ls_compat.h</span><br><span>index 610215b..5705706 100644</span><br><span>-=
-- a/src/openvpn/mbedtls_compat.h</span><br><span>+++ b/src/openvpn/mbedtls=
_compat.h</span><br><span>@@ -40,6 +40,7 @@</span><br><span> #include &lt;m=
bedtls/cipher.h&gt;</span><br><span> #include &lt;mbedtls/ctr_drbg.h&gt;</s=
pan><br><span> #include &lt;mbedtls/dhm.h&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;mbedtls/ecp.h&gt;</span><br><span> #=
include &lt;mbedtls/md.h&gt;</span><br><span> #include &lt;mbedtls/pem.h&gt=
;</span><br><span> #include &lt;mbedtls/pk.h&gt;</span><br><span>@@ -51,6 +=
52,12 @@</span><br><span>     #include &lt;psa/crypto.h&gt;</span><br><span=
> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+typedef uint16_t mbedtls_compat_group_id;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+typedef mbedtls_ecp_group_id mbed=
tls_compat_group_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> static inline void</span><br><span> mbedtls_compat_psa_crypto_init(vo=
id)</span><br><span> {</span><br><span>@@ -64,6 +71,16 @@</span><br><span> =
#endif /* HAVE_MBEDTLS_PSA_CRYPTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C=
) */</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static inline mbedtls_compat_group_id</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+mbedtls_compat_get_group_id(const m=
bedtls_ecp_curve_info *curve_info)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return curve_info-&gt;tls_id;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return curve_info-&gt;grp_id;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /*</span><br><span>  * In older versions of mbedtls=
, mbedtls_ctr_drbg_update() did not return an</span><br><span>  * error cod=
e, and it was deprecated in favor of mbedtls_ctr_drbg_update_ret()</span><b=
r><span>@@ -124,6 +141,36 @@</span><br><span> }</span><br><span> </span><br=
><span> #if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+typedef enum {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    MBEDTLS_SSL_VERSION_UNKNOWN, /*!&lt; Context =
not in use or version not yet negotiated. */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    MBEDTLS_SSL_VERSION_TLS1_0 =3D 0x0301, /*!&lt;=
 (D)TLS 1.0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    M=
BEDTLS_SSL_VERSION_TLS1_1 =3D 0x0302, /*!&lt; (D)TLS 1.1 */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    MBEDTLS_SSL_VERSION_TLS1_2 =3D =
0x0303, /*!&lt; (D)TLS 1.2 */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    MBEDTLS_SSL_VERSION_TLS1_3 =3D 0x0304, /*!&lt; (D)TLS 1.3 */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+} mbedtls_ssl_protoc=
ol_version;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static inline void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_ssl_conf_min_tls_ver=
sion(mbedtls_ssl_config *conf, mbedtls_ssl_protocol_version tls_version)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int major =3D (tls_version &gt;&gt; =
8) &amp; 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt minor =3D tls_version &amp; 0xff;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    mbedtls_ssl_conf_min_version(conf, major, minor);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+mbedtls_ssl_conf_max_tls_version(mbedtls_ssl_config *conf, mb=
edtls_ssl_protocol_version tls_version)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int major =3D (tls_version &gt;&gt; 8) &amp; 0xff;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int minor =3D tls_version &amp; 0x=
ff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_ssl_=
conf_max_version(conf, major, minor);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_ssl_conf_gro=
ups(mbedtls_ssl_config *conf, mbedtls_compat_group_id *groups)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    mbedtls_ssl_conf_curves(conf, groups);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> static inline size_t</span>=
<br><span> mbedtls_cipher_info_get_block_size(const mbedtls_cipher_info_t *=
cipher)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_mbe=
dtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 7e29bd2..8fb69c3 1=
00644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b=
/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -401,7 +401,7 @@</span><br><s=
pan> </span><br><span>     /* Get number of groups and allocate an array in=
 ctx */</span><br><span>     int groups_count =3D get_num_elements(groups, =
&#39;:&#39;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLO=
C_ARRAY_CLEAR(ctx-&gt;groups, mbedtls_ecp_group_id, groups_count + 1)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY_CLEAR(ctx=
-&gt;groups, mbedtls_compat_group_id, groups_count + 1)</span><br><span> </=
span><br><span>     /* Parse allowed ciphers, getting IDs */</span><br><spa=
n>     int i =3D 0;</span><br><span>@@ -418,11 +418,15 @@</span><br><span> =
        }</span><br><span>         else</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            ctx-&gt;groups[i] =
=3D ci-&gt;grp_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           ctx-&gt;groups[i] =3D mbedtls_compat_get_group_id(ci);</span><br=
><span>             i++;</span><br><span>         }</span><br><span>     }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;groups[i] =
=3D MBEDTLS_ECP_DP_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Recent =
mbedtls versions state that the list of groups must be terminated</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * with 0. Older versions=
 state that it must be terminated with MBEDTLS_ECP_DP_NONE</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * which is also 0, so this work=
s either way. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ctx-&gt;groups[i] =3D 0;</span><br><span> </span><br><span>     gc_free(&a=
mp;gc);</span><br><span> }</span><br><span>@@ -1049,47 +1053,40 @@</span><b=
r><span> }</span><br><span> </span><br><span> /**</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Convert an OpenVPN tls-version variable to m=
bed TLS format (i.e. a major and</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * minor ssl version number).</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Convert an OpenVPN tls-version variable to mbed TLS=
 format</span><br><span>  *</span><br><span>  * @param tls_ver       The tl=
s-version variable to convert.</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @param major         Returns the TLS major version in mbed TLS =
format.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *            =
          Must be a valid pointer.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @param minor         Returns the TLS minor version in mbed =
TLS format.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        =
              Must be a valid pointer.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return Translated mbedTLS SSL version from OpenVPN TLS version.</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_version_to_m=
ajor_minor(int tls_ver, int *major, int *minor)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static mbedtls_ssl_protocol_version</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+tls_version_to_ssl_version(int =
tls_ver)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ASSERT(major);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    ASSERT(minor);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>     switch (tls_ver)</span><br><span>     {</span><br><sp=
an> #if defined(MBEDTLS_SSL_PROTO_TLS1)</span><br><span>         case TLS_V=
ER_1_0:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *m=
ajor =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_1;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return MBEDTLS_SSL=
_VERSION_TLS1_0;</span><br><span> #endif</span><br><span> </span><br><span>=
 #if defined(MBEDTLS_SSL_PROTO_TLS1_1)</span><br><span>         case TLS_VE=
R_1_1:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *ma=
jor =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_2;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return MBEDTLS_SSL_=
VERSION_TLS1_1;</span><br><span> #endif</span><br><span> </span><br><span> =
#if defined(MBEDTLS_SSL_PROTO_TLS1_2)</span><br><span>         case TLS_VER=
_1_2:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *maj=
or =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            *minor =3D MBEDTLS_SSL_MINOR_VERSION_3;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return MBEDTLS_SSL_V=
ERSION_TLS1_2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TLS_VE=
R_1_3:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn MBEDTLS_SSL_VERSION_TLS1_3;</span><br><span> #endif</span><br><span> =
</span><br><span>         default:</span><br><span>             msg(M_FATAL=
, &quot;%s: invalid or unsupported TLS version %d&quot;, __func__, tls_ver)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return MB=
EDTLS_SSL_VERSION_UNKNOWN;</span><br><span>     }</span><br><span> }</span>=
<br><span> </span><br><span>@@ -1170,7 +1167,7 @@</span><br><span> </span><=
br><span>     if (ssl_ctx-&gt;groups)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        mbedtls_ssl_conf_curves(ks_s=
sl-&gt;ssl_config, ssl_ctx-&gt;groups);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        mbedtls_ssl_conf_groups(ks_ssl-&gt;ssl_config, =
ssl_ctx-&gt;groups);</span><br><span>     }</span><br><span> </span><br><sp=
an>     /* Disable TLS renegotiations if the mbedtls library supports that =
feature.</span><br><span>@@ -1220,15 +1217,14 @@</span><br><span>          =
   &amp;SSLF_TLS_VERSION_MIN_MASK;</span><br><span> </span><br><span>      =
   /* default to TLS 1.2 */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        int major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        int minor =3D MBEDTLS_SSL_MINOR_=
VERSION_3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
bedtls_ssl_protocol_version version =3D MBEDTLS_SSL_VERSION_TLS1_2;</span><=
br><span> </span><br><span>         if (configured_tls_version_min &gt; TLS=
_VER_UNSPEC)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            tls_version_to_major_minor(configured_tls_ver=
sion_min, &amp;major, &amp;minor);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            version =3D tls_version_to_ssl_version(configure=
d_tls_version_min);</span><br><span>         }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        mbedtls_ssl_conf_min_ver=
sion(ks_ssl-&gt;ssl_config, major, minor);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        mbedtls_ssl_conf_min_tls_version(ks_ssl-&gt;=
ssl_config, version);</span><br><span>     }</span><br><span> </span><br><s=
pan>     /* Initialize maximum TLS version */</span><br><span>@@ -1237,20 +=
1233,19 @@</span><br><span>             (session-&gt;opt-&gt;ssl_flags &gt;=
&gt; SSLF_TLS_VERSION_MAX_SHIFT)</span><br><span>             &amp;SSLF_TLS=
_VERSION_MAX_MASK;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        int major =3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        int minor =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        mbedtls_ssl_protocol_version version =3D MBE=
DTLS_SSL_VERSION_UNKNOWN;</span><br><span> </span><br><span>         if (co=
nfigured_tls_version_max &gt; TLS_VER_UNSPEC)</span><br><span>         {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            tls_version_=
to_major_minor(configured_tls_version_max, &amp;major, &amp;minor);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            version =3D tls=
_version_to_ssl_version(configured_tls_version_max);</span><br><span>      =
   }</span><br><span>         else</span><br><span>         {</span><br><sp=
an>             /* Default to tls_version_max(). */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            tls_version_to_major_minor(tls_=
version_max(), &amp;major, &amp;minor);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            version =3D tls_version_to_ssl_version(tls_=
version_max());</span><br><span>         }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        mbedtls_ssl_conf_max_version=
(ks_ssl-&gt;ssl_config, major, minor);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        mbedtls_ssl_conf_max_tls_version(ks_ssl-&gt;ssl_=
config, version);</span><br><span>     }</span><br><span> </span><br><span>=
 #if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</span><br><span>diff --git a/=
src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h</span><br><span>index=
 1fd0ce8..34b4f02 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.h</s=
pan><br><span>+++ b/src/openvpn/ssl_mbedtls.h</span><br><span>@@ -39,6 +39,=
8 @@</span><br><span> #include &lt;pkcs11-helper-1.0/pkcs11h-certificate.h&=
gt;</span><br><span> #endif</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;mbedtls_compat.h&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef struc=
t _buffer_entry buffer_entry;</span><br><span> </span><br><span> struct _bu=
ffer_entry {</span><br><span>@@ -118,7 +120,7 @@</span><br><span> #endif</s=
pan><br><span>     struct external_context external_key; /**&lt; External k=
ey context */</span><br><span>     int *allowed_ciphers;       /**&lt; List=
 of allowed ciphers for this connection */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    mbedtls_ecp_group_id *groups;     /**&lt; List of =
allowed groups for this connection */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    mbedtls_compat_group_id *groups;     /**&lt; List of =
allowed groups for this connection */</span><br><span>     mbedtls_x509_crt=
_profile cert_profile; /**&lt; Allowed certificate types */</span><br><span=
> };</span><br><span> </span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/946?usp=3Demail">change 946=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/946?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: If96c2ebd2af16b18ed34820e8c0=
531547e2076d9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 946 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--t/9Ww/X93lo=--

