From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 16 Mar 2026 15:03:46 +0000
In-Reply-To: <gerrit.1772798203000.I777a3a5f4f137432a19746972e2aad1732184feb@...2715...>
References: <gerrit.1772798203000.I777a3a5f4f137432a19746972e2aad1732184feb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b97eb2e12216c8ad822f17f04d8c6f8cfc6b8764-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jVA0Tfi7aJk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_mbedtls: Avoid
 conversion and sign-compare warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jVA0Tfi7aJk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
59?usp=3Demail )

Change subject: ssl_mbedtls: Avoid conversion and sign-compare warnings
......................................................................

ssl_mbedtls: Avoid conversion and sign-compare warnings

Change-Id: I777a3a5f4f137432a19746972e2aad1732184feb
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1559
Message-Id: <20260314170948.2898-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
137.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_verify_mbedtls.c
2 files changed, 17 insertions(+), 31 deletions(-)




diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a9506ef..d0c481e 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -624,12 +624,6 @@
     return 0;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 #if MBEDTLS_VERSION_NUMBER < 0x04000000
 /**
  * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that =
uses
@@ -656,7 +650,6 @@
 {
     struct external_context *const ctx =3D ctx_voidptr;
     int rv;
-    uint8_t *to_sign =3D NULL;
     size_t asn_len =3D 0, oid_size =3D 0;
     const char *oid =3D NULL;

@@ -688,11 +681,13 @@
         asn_len =3D 10 + oid_size;
     }

-    if ((SIZE_MAX - hashlen) < asn_len || ctx->signature_length < (asn_len=
 + hashlen))
+    if (ctx->signature_length < (asn_len + hashlen)
+        || (asn_len + hashlen) > UINT8_MAX)
     {
         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
     }

+    uint8_t *to_sign =3D NULL;
     ALLOC_ARRAY_CLEAR(to_sign, uint8_t, asn_len + hashlen);
     uint8_t *p =3D to_sign;
     if (md_alg !=3D MBEDTLS_MD_NONE)
@@ -707,20 +702,20 @@
          * Digest ::=3D OCTET STRING
          */
         *p++ =3D MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
-        *p++ =3D (unsigned char)(0x08 + oid_size + hashlen);
+        *p++ =3D (uint8_t)(0x08 + oid_size + hashlen);
         *p++ =3D MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
-        *p++ =3D (unsigned char)(0x04 + oid_size);
+        *p++ =3D (uint8_t)(0x04 + oid_size);
         *p++ =3D MBEDTLS_ASN1_OID;
-        *p++ =3D oid_size & 0xFF;
+        *p++ =3D (uint8_t)oid_size;
         memcpy(p, oid, oid_size);
         p +=3D oid_size;
         *p++ =3D MBEDTLS_ASN1_NULL;
         *p++ =3D 0x00;
         *p++ =3D MBEDTLS_ASN1_OCTET_STRING;
-        *p++ =3D hashlen;
+        *p++ =3D (uint8_t)hashlen;

         /* Double-check ASN length */
-        ASSERT(asn_len =3D=3D p - to_sign);
+        ASSERT(asn_len =3D=3D (uintptr_t)(p - to_sign));
     }

     /* Copy the hash to be signed */
@@ -810,7 +805,7 @@
         goto cleanup;
     }

-    if (openvpn_base64_decode(dst_b64, dst, (int)dst_len) !=3D dst_len)
+    if (openvpn_base64_decode(dst_b64, dst, (int)dst_len) !=3D (int)dst_le=
n)
     {
         goto cleanup;
     }
@@ -923,6 +918,8 @@
 {
     size_t read_len =3D 0;

+    ASSERT(out_len <=3D INT_MAX);
+
     if (in->first_block =3D=3D NULL)
     {
         return MBEDTLS_ERR_SSL_WANT_READ;
@@ -930,7 +927,7 @@

     while (in->first_block !=3D NULL && read_len < out_len)
     {
-        int block_len =3D in->first_block->length - in->data_start;
+        size_t block_len =3D in->first_block->length - in->data_start;
         if (block_len <=3D out_len - read_len)
         {
             buffer_entry *cur_entry =3D in->first_block;
@@ -956,7 +953,7 @@
         }
     }

-    return read_len;
+    return (int)read_len;
 }

 static int
@@ -975,6 +972,8 @@
         return MBEDTLS_ERR_NET_SEND_FAILED;
     }

+    ASSERT(len <=3D INT_MAX);
+
     new_block->length =3D len;
     new_block->next_block =3D NULL;

@@ -992,7 +991,7 @@

     out->last_block =3D new_block;

-    return len;
+    return (int)len;
 }

 static int
@@ -1012,7 +1011,7 @@
 static void
 my_debug(void *ctx, int level, const char *file, int line, const char *str)
 {
-    int my_loglevel =3D (level < 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;
+    msglvl_t my_loglevel =3D (level < 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;
     msg(my_loglevel, "mbed TLS msg (%s:%d): %s", file, line, str);
 }
=20
@@ -1048,10 +1047,6 @@
 #endif /* MBEDTLS_VERSION_NUMBER < 0x040000 */
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 tls_version_max(void)
 {
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 7495085..ad5479c 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -565,11 +565,6 @@
     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Save X509 fields to environment, using the naming convention:
  *
@@ -678,10 +673,6 @@
     return fFound;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 result_t
 x509_verify_cert_eku(mbedtls_x509_crt *cert, const char *const expected_oi=
d)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1559?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I777a3a5f4f137432a19746972e2aad1732184feb
Gerrit-Change-Number: 1559
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jVA0Tfi7aJk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1559?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_mbedtls: Avoid conversion and sign-compare w=
arnings<br><br>Change-Id: I777a3a5f4f137432a19746972e2aad1732184feb<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/op=
envpn/+/1559<br>Message-Id: &lt;20260314170948.2898-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
36137.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>2 fil=
es changed, 17 insertions(+), 31 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span=
><br><span>index a9506ef..d0c481e 100644</span><br><span>--- a/src/openvpn/=
ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><sp=
an>@@ -624,12 +624,6 @@</span><br><span>     return 0;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> #if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><=
span> /**</span><br><span>  * external_pkcs1_sign implements a mbed TLS rsa=
_sign_func callback, that uses</span><br><span>@@ -656,7 +650,6 @@</span><b=
r><span> {</span><br><span>     struct external_context *const ctx =3D ctx_=
voidptr;</span><br><span>     int rv;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    uint8_t *to_sign =3D NULL;</span><br><span>     size_t =
asn_len =3D 0, oid_size =3D 0;</span><br><span>     const char *oid =3D NUL=
L;</span><br><span> </span><br><span>@@ -688,11 +681,13 @@</span><br><span>=
         asn_len =3D 10 + oid_size;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((SIZE_MAX - =
hashlen) &lt; asn_len || ctx-&gt;signature_length &lt; (asn_len + hashlen))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ctx-&gt;sig=
nature_length &lt; (asn_len + hashlen)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        || (asn_len + hashlen) &gt; UINT8_MAX)</span><br=
><span>     {</span><br><span>         return MBEDTLS_ERR_RSA_BAD_INPUT_DAT=
A;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    uint8_t *to_sign =3D NULL;</span><br><span>    =
 ALLOC_ARRAY_CLEAR(to_sign, uint8_t, asn_len + hashlen);</span><br><span>  =
   uint8_t *p =3D to_sign;</span><br><span>     if (md_alg !=3D MBEDTLS_MD_=
NONE)</span><br><span>@@ -707,20 +702,20 @@</span><br><span>          * Dig=
est ::=3D OCTET STRING</span><br><span>          */</span><br><span>       =
  *p++ =3D MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D (unsigned char)(0x0=
8 + oid_size + hashlen);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        *p++ =3D (uint8_t)(0x08 + oid_size + hashlen);</span><br><span=
>         *p++ =3D MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D (unsigned c=
har)(0x04 + oid_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        *p++ =3D (uint8_t)(0x04 + oid_size);</span><br><span>         *p=
++ =3D MBEDTLS_ASN1_OID;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        *p++ =3D oid_size &amp; 0xFF;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        *p++ =3D (uint8_t)oid_size;</span><br><span>  =
       memcpy(p, oid, oid_size);</span><br><span>         p +=3D oid_size;<=
/span><br><span>         *p++ =3D MBEDTLS_ASN1_NULL;</span><br><span>      =
   *p++ =3D 0x00;</span><br><span>         *p++ =3D MBEDTLS_ASN1_OCTET_STRI=
NG;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D h=
ashlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *p++=
 =3D (uint8_t)hashlen;</span><br><span> </span><br><span>         /* Double=
-check ASN length */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       ASSERT(asn_len =3D=3D p - to_sign);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        ASSERT(asn_len =3D=3D (uintptr_t)(p - to_sig=
n));</span><br><span>     }</span><br><span> </span><br><span>     /* Copy =
the hash to be signed */</span><br><span>@@ -810,7 +805,7 @@</span><br><spa=
n>         goto cleanup;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (openvpn_base64_decode(d=
st_b64, dst, (int)dst_len) !=3D dst_len)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (openvpn_base64_decode(dst_b64, dst, (int)dst_l=
en) !=3D (int)dst_len)</span><br><span>     {</span><br><span>         goto=
 cleanup;</span><br><span>     }</span><br><span>@@ -923,6 +918,8 @@</span>=
<br><span> {</span><br><span>     size_t read_len =3D 0;</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(out_len &=
lt;=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     if (in-&gt;first_block =3D=3D NULL)</span><br><span>    =
 {</span><br><span>         return MBEDTLS_ERR_SSL_WANT_READ;</span><br><sp=
an>@@ -930,7 +927,7 @@</span><br><span> </span><br><span>     while (in-&gt=
;first_block !=3D NULL &amp;&amp; read_len &lt; out_len)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int block=
_len =3D in-&gt;first_block-&gt;length - in-&gt;data_start;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        size_t block_len =3D in-&gt=
;first_block-&gt;length - in-&gt;data_start;</span><br><span>         if (b=
lock_len &lt;=3D out_len - read_len)</span><br><span>         {</span><br><=
span>             buffer_entry *cur_entry =3D in-&gt;first_block;</span><br=
><span>@@ -956,7 +953,7 @@</span><br><span>         }</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return read_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return (int)read_len;</span><br><span> }</span><br><span> </span><br><sp=
an> static int</span><br><span>@@ -975,6 +972,8 @@</span><br><span>        =
 return MBEDTLS_ERR_NET_SEND_FAILED;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(len &l=
t;=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     new_block-&gt;length =3D len;</span><br><span>     new_bl=
ock-&gt;next_block =3D NULL;</span><br><span> </span><br><span>@@ -992,7 +9=
91,7 @@</span><br><span> </span><br><span>     out-&gt;last_block =3D new_b=
lock;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return (int)len;</span><br><span> }</span><br><span> </span><br><span> st=
atic int</span><br><span>@@ -1012,7 +1011,7 @@</span><br><span> static void=
</span><br><span> my_debug(void *ctx, int level, const char *file, int line=
, const char *str)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int my_loglevel =3D (level &lt; 3) ? D_TLS_DEBUG_MED : =
D_TLS_DEBUG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
lvl_t my_loglevel =3D (level &lt; 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;</span=
><br><span>     msg(my_loglevel, &quot;mbed TLS msg (%s:%d): %s&quot;, file=
, line, str);</span><br><span> }</span><br><span> </span><br><span>@@ -1048=
,10 +1047,6 @@</span><br><span> #endif /* MBEDTLS_VERSION_NUMBER &lt; 0x040=
000 */</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> tl=
s_version_max(void)</span><br><span> {</span><br><span>diff --git a/src/ope=
nvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</span><br><spa=
n>index 7495085..ad5479c 100644</span><br><span>--- a/src/openvpn/ssl_verif=
y_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.c</span><b=
r><span>@@ -565,11 +565,6 @@</span><br><span>     gc_free(&amp;gc);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> /*</span><br><span>  * Save X509 fields to environment, using the naming =
convention:</span><br><span>  *</span><br><span>@@ -678,10 +673,6 @@</span>=
<br><span>     return fFound;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
result_t</span><br><span> x509_verify_cert_eku(mbedtls_x509_crt *cert, cons=
t char *const expected_oid)</span><br><span> {</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/155=
9?usp=3Demail">change 1559</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1559?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I777a3a5f4f137432a19746972e2=
aad1732184feb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1559 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--jVA0Tfi7aJk=--

