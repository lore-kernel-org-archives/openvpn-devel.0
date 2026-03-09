From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 9 Mar 2026 15:58:20 +0000
In-Reply-To: <gerrit.1772798203000.I777a3a5f4f137432a19746972e2aad1732184feb@...2715...>
References: <gerrit.1772798203000.I777a3a5f4f137432a19746972e2aad1732184feb@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <87416bbdc0e44d82cb0d6e1e45482c44042962ce-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DXuQstM8KG8="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DXuQstM8KG8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1559?usp=3Demail

to look at the new patch set (#2).


Change subject: ssl_mbedtls: Avoid conversion and sign-compare warnings
......................................................................

ssl_mbedtls: Avoid conversion and sign-compare warnings

Change-Id: I777a3a5f4f137432a19746972e2aad1732184feb
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_verify_mbedtls.c
2 files changed, 17 insertions(+), 31 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1559/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I777a3a5f4f137432a19746972e2aad1732184feb
Gerrit-Change-Number: 1559
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--DXuQstM8KG8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1559?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_mbedtls: Avoid conversion and sign-compare w=
arnings<br><br>Change-Id: I777a3a5f4f137432a19746972e2aad1732184feb<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openv=
pn/ssl_mbedtls.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>2 files changed, =
17 insertions(+), 31 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/59/1559/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span=
>index a9506ef..d0c481e 100644</span><br><span>--- a/src/openvpn/ssl_mbedtl=
s.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -624=
,12 +624,6 @@</span><br><span>     return 0;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignor=
ed &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> #if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span> /**<=
/span><br><span>  * external_pkcs1_sign implements a mbed TLS rsa_sign_func=
 callback, that uses</span><br><span>@@ -656,7 +650,6 @@</span><br><span> {=
</span><br><span>     struct external_context *const ctx =3D ctx_voidptr;</=
span><br><span>     int rv;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    uint8_t *to_sign =3D NULL;</span><br><span>     size_t asn_len =
=3D 0, oid_size =3D 0;</span><br><span>     const char *oid =3D NULL;</span=
><br><span> </span><br><span>@@ -688,11 +681,13 @@</span><br><span>        =
 asn_len =3D 10 + oid_size;</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((SIZE_MAX - hashlen)=
 &lt; asn_len || ctx-&gt;signature_length &lt; (asn_len + hashlen))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ctx-&gt;signature_l=
ength &lt; (asn_len + hashlen)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        || (asn_len + hashlen) &gt; UINT8_MAX)</span><br><span> =
    {</span><br><span>         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint8_t *to_sign =3D NULL;</span><br><span>     ALLOC_A=
RRAY_CLEAR(to_sign, uint8_t, asn_len + hashlen);</span><br><span>     uint8=
_t *p =3D to_sign;</span><br><span>     if (md_alg !=3D MBEDTLS_MD_NONE)</s=
pan><br><span>@@ -707,20 +702,20 @@</span><br><span>          * Digest ::=
=3D OCTET STRING</span><br><span>          */</span><br><span>         *p++=
 =3D MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D (unsigned char)(0x08 + oi=
d_size + hashlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       *p++ =3D (uint8_t)(0x08 + oid_size + hashlen);</span><br><span>     =
    *p++ =3D MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D (unsigned char)(0=
x04 + oid_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     *p++ =3D (uint8_t)(0x04 + oid_size);</span><br><span>         *p++ =3D=
 MBEDTLS_ASN1_OID;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     *p++ =3D oid_size &amp; 0xFF;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        *p++ =3D (uint8_t)oid_size;</span><br><span>        =
 memcpy(p, oid, oid_size);</span><br><span>         p +=3D oid_size;</span>=
<br><span>         *p++ =3D MBEDTLS_ASN1_NULL;</span><br><span>         *p+=
+ =3D 0x00;</span><br><span>         *p++ =3D MBEDTLS_ASN1_OCTET_STRING;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D hashlen=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *p++ =3D (=
uint8_t)hashlen;</span><br><span> </span><br><span>         /* Double-check=
 ASN length */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 ASSERT(asn_len =3D=3D p - to_sign);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        ASSERT(asn_len =3D=3D (uintptr_t)(p - to_sign));</=
span><br><span>     }</span><br><span> </span><br><span>     /* Copy the ha=
sh to be signed */</span><br><span>@@ -810,7 +805,7 @@</span><br><span>    =
     goto cleanup;</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (openvpn_base64_decode(dst_b64=
, dst, (int)dst_len) !=3D dst_len)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (openvpn_base64_decode(dst_b64, dst, (int)dst_len) !=
=3D (int)dst_len)</span><br><span>     {</span><br><span>         goto clea=
nup;</span><br><span>     }</span><br><span>@@ -923,6 +918,8 @@</span><br><=
span> {</span><br><span>     size_t read_len =3D 0;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(out_len &lt;=
=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     if (in-&gt;first_block =3D=3D NULL)</span><br><span>     {<=
/span><br><span>         return MBEDTLS_ERR_SSL_WANT_READ;</span><br><span>=
@@ -930,7 +927,7 @@</span><br><span> </span><br><span>     while (in-&gt;fi=
rst_block !=3D NULL &amp;&amp; read_len &lt; out_len)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int block_le=
n =3D in-&gt;first_block-&gt;length - in-&gt;data_start;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        size_t block_len =3D in-&gt;fi=
rst_block-&gt;length - in-&gt;data_start;</span><br><span>         if (bloc=
k_len &lt;=3D out_len - read_len)</span><br><span>         {</span><br><spa=
n>             buffer_entry *cur_entry =3D in-&gt;first_block;</span><br><s=
pan>@@ -956,7 +953,7 @@</span><br><span>         }</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn read_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return (int)read_len;</span><br><span> }</span><br><span> </span><br><span>=
 static int</span><br><span>@@ -975,6 +972,8 @@</span><br><span>         re=
turn MBEDTLS_ERR_NET_SEND_FAILED;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(len &lt;=
=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     new_block-&gt;length =3D len;</span><br><span>     new_bloc=
k-&gt;next_block =3D NULL;</span><br><span> </span><br><span>@@ -992,7 +991=
,7 @@</span><br><span> </span><br><span>     out-&gt;last_block =3D new_blo=
ck;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return (int)len;</span><br><span> }</span><br><span> </span><br><span> stat=
ic int</span><br><span>@@ -1012,7 +1011,7 @@</span><br><span> static void</=
span><br><span> my_debug(void *ctx, int level, const char *file, int line, =
const char *str)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int my_loglevel =3D (level &lt; 3) ? D_TLS_DEBUG_MED : D_=
TLS_DEBUG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msglv=
l_t my_loglevel =3D (level &lt; 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;</span><=
br><span>     msg(my_loglevel, &quot;mbed TLS msg (%s:%d): %s&quot;, file, =
line, str);</span><br><span> }</span><br><span> </span><br><span>@@ -1048,1=
0 +1047,6 @@</span><br><span> #endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000=
0 */</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> tls_=
version_max(void)</span><br><span> {</span><br><span>diff --git a/src/openv=
pn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>=
index 7495085..ad5479c 100644</span><br><span>--- a/src/openvpn/ssl_verify_=
mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.c</span><br>=
<span>@@ -565,11 +565,6 @@</span><br><span>     gc_free(&amp;gc);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsi=
gn-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*=
</span><br><span>  * Save X509 fields to environment, using the naming conv=
ention:</span><br><span>  *</span><br><span>@@ -678,10 +673,6 @@</span><br>=
<span>     return fFound;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> resu=
lt_t</span><br><span> x509_verify_cert_eku(mbedtls_x509_crt *cert, const ch=
ar *const expected_oid)</span><br><span> {</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1559?us=
p=3Demail">change 1559</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1559?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I777a3a5f4f137432a19746972e2=
aad1732184feb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1559 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--DXuQstM8KG8=--

