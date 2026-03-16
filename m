From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 16 Mar 2026 11:56:47 +0000
In-Reply-To: <gerrit.1772798203000.I777a3a5f4f137432a19746972e2aad1732184feb@...2715...>
References: <gerrit.1772798203000.I777a3a5f4f137432a19746972e2aad1732184feb@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <f7ce6fe78873f86886948cb00c598225e7255524-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nCD9YuWbjmE="; charset=UTF-8
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

--nCD9YuWbjmE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1559?usp=3Demail

to look at the new patch set (#5).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: ssl_mbedtls: Avoid conversion and sign-compare warnings
......................................................................

ssl_mbedtls: Avoid conversion and sign-compare warnings

Change-Id: I777a3a5f4f137432a19746972e2aad1732184feb
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_verify_mbedtls.c
2 files changed, 17 insertions(+), 31 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1559/5

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
=20
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
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--nCD9YuWbjmE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #5</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1559?usp=3Demail">View C=
hange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRul=
e is unsatisfied now.</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">ssl_mbedtls: Avoid conversion and si=
gn-compare warnings<br><br>Change-Id: I777a3a5f4f137432a19746972e2aad173218=
4feb<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br=
>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>2 fil=
es changed, 17 insertions(+), 31 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1559/5</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span>=
<br><span>index a9506ef..d0c481e 100644</span><br><span>--- a/src/openvpn/s=
sl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><spa=
n>@@ -624,12 +624,6 @@</span><br><span>     return 0;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> #if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><s=
pan> /**</span><br><span>  * external_pkcs1_sign implements a mbed TLS rsa_=
sign_func callback, that uses</span><br><span>@@ -656,7 +650,6 @@</span><br=
><span> {</span><br><span>     struct external_context *const ctx =3D ctx_v=
oidptr;</span><br><span>     int rv;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    uint8_t *to_sign =3D NULL;</span><br><span>     size_t a=
sn_len =3D 0, oid_size =3D 0;</span><br><span>     const char *oid =3D NULL=
;</span><br><span> </span><br><span>@@ -688,11 +681,13 @@</span><br><span> =
        asn_len =3D 10 + oid_size;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((SIZE_MAX - h=
ashlen) &lt; asn_len || ctx-&gt;signature_length &lt; (asn_len + hashlen))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ctx-&gt;sign=
ature_length &lt; (asn_len + hashlen)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        || (asn_len + hashlen) &gt; UINT8_MAX)</span><br>=
<span>     {</span><br><span>         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint8_t *to_sign =3D NULL;</span><br><span>     =
ALLOC_ARRAY_CLEAR(to_sign, uint8_t, asn_len + hashlen);</span><br><span>   =
  uint8_t *p =3D to_sign;</span><br><span>     if (md_alg !=3D MBEDTLS_MD_N=
ONE)</span><br><span>@@ -707,20 +702,20 @@</span><br><span>          * Dige=
st ::=3D OCTET STRING</span><br><span>          */</span><br><span>        =
 *p++ =3D MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D (unsigned char)(0x08=
 + oid_size + hashlen);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        *p++ =3D (uint8_t)(0x08 + oid_size + hashlen);</span><br><span>=
         *p++ =3D MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D (unsigned ch=
ar)(0x04 + oid_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        *p++ =3D (uint8_t)(0x04 + oid_size);</span><br><span>         *p+=
+ =3D MBEDTLS_ASN1_OID;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        *p++ =3D oid_size &amp; 0xFF;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *p++ =3D (uint8_t)oid_size;</span><br><span>   =
      memcpy(p, oid, oid_size);</span><br><span>         p +=3D oid_size;</=
span><br><span>         *p++ =3D MBEDTLS_ASN1_NULL;</span><br><span>       =
  *p++ =3D 0x00;</span><br><span>         *p++ =3D MBEDTLS_ASN1_OCTET_STRIN=
G;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D ha=
shlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *p++ =
=3D (uint8_t)hashlen;</span><br><span> </span><br><span>         /* Double-=
check ASN length */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      ASSERT(asn_len =3D=3D p - to_sign);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        ASSERT(asn_len =3D=3D (uintptr_t)(p - to_sign=
));</span><br><span>     }</span><br><span> </span><br><span>     /* Copy t=
he hash to be signed */</span><br><span>@@ -810,7 +805,7 @@</span><br><span=
>         goto cleanup;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (openvpn_base64_decode(ds=
t_b64, dst, (int)dst_len) !=3D dst_len)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (openvpn_base64_decode(dst_b64, dst, (int)dst_le=
n) !=3D (int)dst_len)</span><br><span>     {</span><br><span>         goto =
cleanup;</span><br><span>     }</span><br><span>@@ -923,6 +918,8 @@</span><=
br><span> {</span><br><span>     size_t read_len =3D 0;</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(out_len &l=
t;=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     if (in-&gt;first_block =3D=3D NULL)</span><br><span>     =
{</span><br><span>         return MBEDTLS_ERR_SSL_WANT_READ;</span><br><spa=
n>@@ -930,7 +927,7 @@</span><br><span> </span><br><span>     while (in-&gt;=
first_block !=3D NULL &amp;&amp; read_len &lt; out_len)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int block_=
len =3D in-&gt;first_block-&gt;length - in-&gt;data_start;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        size_t block_len =3D in-&gt;=
first_block-&gt;length - in-&gt;data_start;</span><br><span>         if (bl=
ock_len &lt;=3D out_len - read_len)</span><br><span>         {</span><br><s=
pan>             buffer_entry *cur_entry =3D in-&gt;first_block;</span><br>=
<span>@@ -956,7 +953,7 @@</span><br><span>         }</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return read_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return (int)read_len;</span><br><span> }</span><br><span> </span><br><spa=
n> static int</span><br><span>@@ -975,6 +972,8 @@</span><br><span>         =
return MBEDTLS_ERR_NET_SEND_FAILED;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(len &lt=
;=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     new_block-&gt;length =3D len;</span><br><span>     new_blo=
ck-&gt;next_block =3D NULL;</span><br><span> </span><br><span>@@ -992,7 +99=
1,7 @@</span><br><span> </span><br><span>     out-&gt;last_block =3D new_bl=
ock;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return (int)len;</span><br><span> }</span><br><span> </span><br><span> sta=
tic int</span><br><span>@@ -1012,7 +1011,7 @@</span><br><span> static void<=
/span><br><span> my_debug(void *ctx, int level, const char *file, int line,=
 const char *str)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int my_loglevel =3D (level &lt; 3) ? D_TLS_DEBUG_MED : D=
_TLS_DEBUG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msgl=
vl_t my_loglevel =3D (level &lt; 3) ? D_TLS_DEBUG_MED : D_TLS_DEBUG;</span>=
<br><span>     msg(my_loglevel, &quot;mbed TLS msg (%s:%d): %s&quot;, file,=
 line, str);</span><br><span> }</span><br><span> </span><br><span>@@ -1048,=
10 +1047,6 @@</span><br><span> #endif /* MBEDTLS_VERSION_NUMBER &lt; 0x0400=
00 */</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> tls=
_version_max(void)</span><br><span> {</span><br><span>diff --git a/src/open=
vpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</span><br><span=
>index 7495085..ad5479c 100644</span><br><span>--- a/src/openvpn/ssl_verify=
_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.c</span><br=
><span>@@ -565,11 +565,6 @@</span><br><span>     gc_free(&amp;gc);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Ws=
ign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /=
*</span><br><span>  * Save X509 fields to environment, using the naming con=
vention:</span><br><span>  *</span><br><span>@@ -678,10 +673,6 @@</span><br=
><span>     return fFound;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> res=
ult_t</span><br><span> x509_verify_cert_eku(mbedtls_x509_crt *cert, const c=
har *const expected_oid)</span><br><span> {</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1559?u=
sp=3Demail">change 1559</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1559?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I777a3a5f4f137432a19746972e2=
aad1732184feb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1559 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--nCD9YuWbjmE=--

