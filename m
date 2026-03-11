From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 16:50:59 +0000
References: <gerrit.1773247857000.I8ff30785f78fdcda136ef3fe982f8cda2edec059@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <12fb9b9f671f97f651a1a591f981855b06f9530a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KF3Qm+Mom/8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make aws-lc -Werrror
 clean
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KF3Qm+Mom/8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1569?usp=3Demail )


Change subject: Make aws-lc -Werrror clean
......................................................................

Make aws-lc -Werrror clean

Change-Id: I8ff30785f78fdcda136ef3fe982f8cda2edec059
---
M .github/workflows/build.yaml
M src/openvpn/crypto_openssl.c
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_verify_openssl.c
5 files changed, 42 insertions(+), 33 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/1569/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 4207606..48373f9 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -498,7 +498,7 @@
           OPENSSL_CFLAGS=3D"-I${{ env.AWS_LC_INSTALL }}/include" \
           OPENSSL_LIBS=3D"-L${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto" \
           LDFLAGS=3D"-Wl,-rpath=3D${{ env.AWS_LC_INSTALL }}/lib" \
-          ./configure --with-crypto-library=3Dopenssl
+          ./configure --with-crypto-library=3Dopenssl --enable-werror
       - name: make all
         run: make -j3
       - name: Ensure the build uses AWS-LC
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index b6e2106..9beaf95 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -229,7 +229,7 @@
 void
 crypto_print_openssl_errors(const unsigned int flags)
 {
-    unsigned long err =3D 0;
+    openssl_err_t err =3D 0;
     int line, errflags;
     const char *file, *data, *func;

@@ -425,7 +425,7 @@
 print_digest(EVP_MD *digest, void *unused)
 {
     printf("%s %d bit digest size\n", md_kt_name(EVP_MD_get0_name(digest)),
-           EVP_MD_size(digest) * 8);
+           (int)EVP_MD_size(digest) * 8);
 }

 void
@@ -1022,7 +1022,7 @@
                    "Message hash algorithm '%s' uses a default hash "
                    "size (%d bytes) which is larger than " PACKAGE_NAME "'=
s current "
                    "maximum hash size (%d bytes)",
-                   digest, EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);
+                   digest, (int)EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);
     }
     return md;
 }
@@ -1152,7 +1152,7 @@
 int
 md_ctx_size(const EVP_MD_CTX *ctx)
 {
-    return EVP_MD_CTX_size(ctx);
+    return (int)EVP_MD_CTX_size(ctx);
 }

 void
@@ -1201,7 +1201,7 @@
     evp_md_type *kt =3D md_get(mdname);
     ASSERT(NULL !=3D kt && NULL !=3D ctx);

-    int key_len =3D EVP_MD_size(kt);
+    size_t key_len =3D EVP_MD_size(kt);
     HMAC_CTX_reset(ctx);
     if (!HMAC_Init_ex(ctx, key, key_len, kt, NULL))
     {
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index ab011d3..8fdb39a 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -45,6 +45,15 @@
 #include <openssl/x509.h>
 #include <openssl/err.h>

+/* Define the type of error. This is something that is less
+ * intrusive than casts everywhere */
+#if defined(OPENSSL_IS_AWSLC)
+typedef uint32_t openssl_err_t;
+#else
+typedef unsigned long openssl_err_t;
+#endif
+
+
 /* Functionality missing in 1.1.0 */
 #if OPENSSL_VERSION_NUMBER < 0x10101000L && !defined(ENABLE_CRYPTO_WOLFSSL)
 #define SSL_CTX_set1_groups SSL_CTX_set1_curves
@@ -157,12 +166,12 @@
     /* OpenSSL 1.1.1 and lower use only const EVP_MD, nothing to free */
 }

-static inline unsigned long
+static inline openssl_err_t
 ERR_get_error_all(const char **file, int *line, const char **func, const c=
har **data, int *flags)
 {
     static const char *empty =3D "";
     *func =3D empty;
-    unsigned long err =3D ERR_get_error_line_data(file, line, data, flags);
+    openssl_err_t err =3D ERR_get_error_line_data(file, line, data, flags);
     return err;
 }

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 48cbaa8..066ebab 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -518,8 +518,9 @@
 void
 tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
 {
-#if OPENSSL_VERSION_NUMBER > 0x10100000L \
-    && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3=
060000fL)
+#if OPENSSL_VERSION_NUMBER > 0x10100000L                                  =
          \
+    && (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3=
060000fL) \
+    && !defined(OPENSSL_IS_AWSLC)
     /* OpenSSL does not have certificate profiles, but a complex set of
      * callbacks that we could try to implement to achieve something simil=
ar.
      * For now, use OpenSSL's security levels to achieve similar (but not =
equal)
@@ -549,7 +550,7 @@
     if (profile)
     {
         msg(M_WARN,
-            "WARNING: OpenSSL 1.1.0 and LibreSSL do not support "
+            "WARNING: OpenSSL 1.1.0, aws-lc and LibreSSL do not support "
             "--tls-cert-profile, ignoring user-set profile: '%s'",
             profile);
     }
@@ -906,7 +907,6 @@
     X509 *cert;
     STACK_OF(X509) *ca =3D NULL;
     PKCS12 *p12;
-    int i;
     char password[256];

     ASSERT(NULL !=3D ctx);
@@ -990,7 +990,7 @@
          */
         if (ca && sk_X509_num(ca))
         {
-            for (i =3D 0; i < sk_X509_num(ca); i++)
+            for (size_t i =3D 0; i < (size_t)sk_X509_num(ca); i++)
             {
                 X509_STORE *cert_store =3D SSL_CTX_get_cert_store(ctx->ctx=
);
                 if (!X509_STORE_add_cert(cert_store, sk_X509_value(ca, i)))
@@ -1015,7 +1015,7 @@
          */
         if (ca && sk_X509_num(ca))
         {
-            for (i =3D 0; i < sk_X509_num(ca); i++)
+            for (size_t i =3D 0; i < (size_t)sk_X509_num(ca); i++)
             {
                 if (!SSL_CTX_add_extra_chain_cert(ctx->ctx, sk_X509_value(=
ca, i)))
                 {
@@ -1331,7 +1331,7 @@
      * we need to manually find the CRL object from the stack
      * and remove it */
     STACK_OF(X509_OBJECT) *objs =3D X509_STORE_get0_objects(store);
-    for (int i =3D 0; i < sk_X509_OBJECT_num(objs); i++)
+    for (size_t i =3D 0; i < (size_t)sk_X509_OBJECT_num(objs); i++)
     {
         X509_OBJECT *obj =3D sk_X509_OBJECT_value(objs, i);
         ASSERT(obj);
@@ -1591,7 +1591,7 @@
 ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned char=
 *sig,
            unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r, EC_K=
EY *ec)
 {
-    int capacity =3D ECDSA_size(ec);
+    int capacity =3D (int)ECDSA_size(ec);
     /*
      * ECDSA does not seem to have proper constants for paddings since
      * there are only signatures without padding at the moment, use
@@ -1607,12 +1607,14 @@
     return 0;
 }

+#ifndef OPENSSL_IS_AWSLC
 /* EC_KEY_METHOD callback: sign_setup(). We do no precomputations */
 static int
 ecdsa_sign_setup(EC_KEY *ec, BN_CTX *ctx_in, BIGNUM **kinvp, BIGNUM **rp)
 {
     return 1;
 }
+#endif

 /* EC_KEY_METHOD callback: sign_sig().
  * Sign the hash and return the result as a newly allocated ECDS_SIG
@@ -1623,7 +1625,7 @@
                EC_KEY *ec)
 {
     ECDSA_SIG *ecsig =3D NULL;
-    unsigned int len =3D ECDSA_size(ec);
+    unsigned int len =3D (unsigned int)ECDSA_size(ec);
     struct gc_arena gc =3D gc_new();

     unsigned char *buf =3D gc_malloc(len, false, &gc);
@@ -1790,7 +1792,7 @@
     X509_STORE *store =3D NULL;
     X509_NAME *xn =3D NULL;
     BIO *in =3D NULL;
-    int i, added =3D 0, prev =3D 0;
+    size_t added =3D 0, prev =3D 0;

     ASSERT(NULL !=3D ctx);

@@ -1819,7 +1821,7 @@

         if (info_stack)
         {
-            for (i =3D 0; i < sk_X509_INFO_num(info_stack); i++)
+            for (size_t i =3D 0; i < (size_t)sk_X509_INFO_num(info_stack);=
 i++)
             {
                 X509_INFO *info =3D sk_X509_INFO_value(info_stack, i);
                 if (info->crl)
@@ -1872,11 +1874,11 @@

                 if (tls_server)
                 {
-                    int cnum =3D sk_X509_NAME_num(cert_names);
+                    size_t cnum =3D sk_X509_NAME_num(cert_names);
                     if (cnum !=3D (prev + 1))
                     {
                         crypto_msg(M_WARN,
-                                   "Cannot load CA certificate file %s (en=
try %d did not validate)",
+                                   "Cannot load CA certificate file %s (en=
try %zu did not validate)",
                                    print_key_filename(ca_file, ca_file_inl=
ine), added);
                     }
                     prev =3D cnum;
@@ -1884,7 +1886,7 @@
             }
             sk_X509_INFO_pop_free(info_stack, X509_INFO_free);
         }
-        int cnum;
+        size_t cnum;
         if (tls_server)
         {
             cnum =3D sk_X509_NAME_num(cert_names);
@@ -1902,8 +1904,8 @@
             if (cnum !=3D added)
             {
                 crypto_msg(M_FATAL,
-                           "Cannot load CA certificate file %s (only %d "
-                           "of %d entries were valid X509 names)",
+                           "Cannot load CA certificate file %s (only %zu "
+                           "of %zu entries were valid X509 names)",
                            print_key_filename(ca_file, ca_file_inline), cn=
um, added);
             }
         }
@@ -2552,7 +2554,7 @@
 #else
     STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_supported_ciphers(ssl);
 #endif
-    for (int i =3D 0; i < sk_SSL_CIPHER_num(sk); i++)
+    for (size_t i =3D 0; i < (size_t)sk_SSL_CIPHER_num(sk); i++)
     {
         const SSL_CIPHER *c =3D sk_SSL_CIPHER_value(sk, i);

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 46401cd..a8139ea 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -138,10 +138,10 @@
          * one, but we don't depend on it...
          */

-        int numalts =3D sk_GENERAL_NAME_num(extensions);
+        size_t numalts =3D sk_GENERAL_NAME_num(extensions);

         /* loop through all alternatives */
-        for (int i =3D 0; i < numalts; i++)
+        for (size_t i =3D 0; i < numalts; i++)
         {
             /* get a handle to alternative name number i */
             const GENERAL_NAME *name =3D sk_GENERAL_NAME_value(extensions,=
 i);
@@ -344,7 +344,7 @@
     const EVP_MD *sha1 =3D EVP_sha1();
     struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha1), gc);
     X509_digest(cert, EVP_sha1(), BPTR(&hash), NULL);
-    ASSERT(buf_inc_len(&hash, EVP_MD_size(sha1)));
+    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha1)));
     return hash;
 }

@@ -354,7 +354,7 @@
     const EVP_MD *sha256 =3D EVP_sha256();
     struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha256), gc);
     X509_digest(cert, EVP_sha256(), BPTR(&hash), NULL);
-    ASSERT(buf_inc_len(&hash, EVP_MD_size(sha256)));
+    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha256)));
     return hash;
 }

@@ -739,10 +739,8 @@
     }
     else
     {
-        int i;
-
         msg(D_HANDSHAKE, "Validating certificate extended key usage");
-        for (i =3D 0; SUCCESS !=3D fFound && i < sk_ASN1_OBJECT_num(eku); =
i++)
+        for (size_t i =3D 0; SUCCESS !=3D fFound && i < (size_t)sk_ASN1_OB=
JECT_num(eku); i++)
         {
             ASN1_OBJECT *oid =3D sk_ASN1_OBJECT_value(eku, i);
             char szOid[1024];
@@ -791,7 +789,7 @@
     }

     STACK_OF(X509_OBJECT) *objs =3D X509_STORE_get0_objects(store);
-    for (int i =3D 0; i < sk_X509_OBJECT_num(objs); i++)
+    for (size_t i =3D 0; i < (size_t)sk_X509_OBJECT_num(objs); i++)
     {
         X509_OBJECT *obj =3D sk_X509_OBJECT_value(objs, i);
         ASSERT(obj);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1569?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8ff30785f78fdcda136ef3fe982f8cda2edec059
Gerrit-Change-Number: 1569
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KF3Qm+Mom/8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1569?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Make aws-lc -Werrror clean<br><br>Change-Id: I8ff30785f78fdcda136ef3fe9=
82f8cda2edec059<br>---<br>M .github/workflows/build.yaml<br>M src/openvpn/c=
rypto_openssl.c<br>M src/openvpn/openssl_compat.h<br>M src/openvpn/ssl_open=
ssl.c<br>M src/openvpn/ssl_verify_openssl.c<br>5 files changed, 42 insertio=
ns(+), 33 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/69/1569/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/=
workflows/build.yaml b/.github/workflows/build.yaml</span><br><span>index 4=
207606..48373f9 100644</span><br><span>--- a/.github/workflows/build.yaml</=
span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -498,7=
 +498,7 @@</span><br><span>           OPENSSL_CFLAGS=3D&quot;-I${{ env.AWS_=
LC_INSTALL }}/include&quot; \</span><br><span>           OPENSSL_LIBS=3D&qu=
ot;-L${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto&quot; \</span><br><span> =
          LDFLAGS=3D&quot;-Wl,-rpath=3D${{ env.AWS_LC_INSTALL }}/lib&quot; =
\</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          ./configur=
e --with-crypto-library=3Dopenssl</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+          ./configure --with-crypto-library=3Dopenssl --enabl=
e-werror</span><br><span>       - name: make all</span><br><span>         r=
un: make -j3</span><br><span>       - name: Ensure the build uses AWS-LC</s=
pan><br><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypt=
o_openssl.c</span><br><span>index b6e2106..9beaf95 100644</span><br><span>-=
-- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_=
openssl.c</span><br><span>@@ -229,7 +229,7 @@</span><br><span> void</span><=
br><span> crypto_print_openssl_errors(const unsigned int flags)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned l=
ong err =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
penssl_err_t err =3D 0;</span><br><span>     int line, errflags;</span><br>=
<span>     const char *file, *data, *func;</span><br><span> </span><br><spa=
n>@@ -425,7 +425,7 @@</span><br><span> print_digest(EVP_MD *digest, void *u=
nused)</span><br><span> {</span><br><span>     printf(&quot;%s %d bit diges=
t size\n&quot;, md_kt_name(EVP_MD_get0_name(digest)),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-           EVP_MD_size(digest) * 8);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           (int)EVP_MD_siz=
e(digest) * 8);</span><br><span> }</span><br><span> </span><br><span> void<=
/span><br><span>@@ -1022,7 +1022,7 @@</span><br><span>                    &=
quot;Message hash algorithm &#39;%s&#39; uses a default hash &quot;</span><=
br><span>                    &quot;size (%d bytes) which is larger than &qu=
ot; PACKAGE_NAME &quot;&#39;s current &quot;</span><br><span>              =
      &quot;maximum hash size (%d bytes)&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                   digest, EVP_MD_size(md), MAX_H=
MAC_KEY_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                digest, (int)EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);</span><=
br><span>     }</span><br><span>     return md;</span><br><span> }</span><b=
r><span>@@ -1152,7 +1152,7 @@</span><br><span> int</span><br><span> md_ctx_=
size(const EVP_MD_CTX *ctx)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    return EVP_MD_CTX_size(ctx);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return (int)EVP_MD_CTX_size(ctx);=
</span><br><span> }</span><br><span> </span><br><span> void</span><br><span=
>@@ -1201,7 +1201,7 @@</span><br><span>     evp_md_type *kt =3D md_get(mdna=
me);</span><br><span>     ASSERT(NULL !=3D kt &amp;&amp; NULL !=3D ctx);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t key_len =3D EVP_MD_size(kt);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    size_t key_len =3D EVP_MD_size(kt);</span><br><span>     HMA=
C_CTX_reset(ctx);</span><br><span>     if (!HMAC_Init_ex(ctx, key, key_len,=
 kt, NULL))</span><br><span>     {</span><br><span>diff --git a/src/openvpn=
/openssl_compat.h b/src/openvpn/openssl_compat.h</span><br><span>index ab01=
1d3..8fdb39a 100644</span><br><span>--- a/src/openvpn/openssl_compat.h</spa=
n><br><span>+++ b/src/openvpn/openssl_compat.h</span><br><span>@@ -45,6 +45=
,15 @@</span><br><span> #include &lt;openssl/x509.h&gt;</span><br><span> #i=
nclude &lt;openssl/err.h&gt;</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* Define the type of error. This is something t=
hat is less</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * intru=
sive than casts everywhere */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(OPENSSL_IS_AWSLC)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+typedef uint32_t openssl_err_t;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+typedef unsigned long openssl_err_t;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /* Functionality missing in 1.1.0 */</span><br><span=
> #if OPENSSL_VERSION_NUMBER &lt; 0x10101000L &amp;&amp; !defined(ENABLE_CR=
YPTO_WOLFSSL)</span><br><span> #define SSL_CTX_set1_groups SSL_CTX_set1_cur=
ves</span><br><span>@@ -157,12 +166,12 @@</span><br><span>     /* OpenSSL 1=
.1.1 and lower use only const EVP_MD, nothing to free */</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic inline unsigned long</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static inline openssl_err_t</span><br><span> ERR_get_error_all(const c=
har **file, int *line, const char **func, const char **data, int *flags)</s=
pan><br><span> {</span><br><span>     static const char *empty =3D &quot;&q=
uot;;</span><br><span>     *func =3D empty;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    unsigned long err =3D ERR_get_error_line_data(fil=
e, line, data, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    openssl_err_t err =3D ERR_get_error_line_data(file, line, data, flag=
s);</span><br><span>     return err;</span><br><span> }</span><br><span> </=
span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_ope=
nssl.c</span><br><span>index 48cbaa8..066ebab 100644</span><br><span>--- a/=
src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</=
span><br><span>@@ -518,8 +518,9 @@</span><br><span> void</span><br><span> t=
ls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if OPE=
NSSL_VERSION_NUMBER &gt; 0x10100000L \</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &amp;&amp; (!defined(LIBRESSL_VERSION_NUMBER) || LIBRE=
SSL_VERSION_NUMBER &gt; 0x3060000fL)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &gt; 0x10100000L               =
                             \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &amp;&amp; (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VE=
RSION_NUMBER &gt; 0x3060000fL) \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &amp;&amp; !defined(OPENSSL_IS_AWSLC)</span><br><span>    =
 /* OpenSSL does not have certificate profiles, but a complex set of</span>=
<br><span>      * callbacks that we could try to implement to achieve somet=
hing similar.</span><br><span>      * For now, use OpenSSL&#39;s security l=
evels to achieve similar (but not equal)</span><br><span>@@ -549,7 +550,7 @=
@</span><br><span>     if (profile)</span><br><span>     {</span><br><span>=
         msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           &quot;WARNING: OpenSSL 1.1.0 and LibreSSL do not support &quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;WA=
RNING: OpenSSL 1.1.0, aws-lc and LibreSSL do not support &quot;</span><br><=
span>             &quot;--tls-cert-profile, ignoring user-set profile: &#39=
;%s&#39;&quot;,</span><br><span>             profile);</span><br><span>    =
 }</span><br><span>@@ -906,7 +907,6 @@</span><br><span>     X509 *cert;</sp=
an><br><span>     STACK_OF(X509) *ca =3D NULL;</span><br><span>     PKCS12 =
*p12;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span=
><br><span>     char password[256];</span><br><span> </span><br><span>     =
ASSERT(NULL !=3D ctx);</span><br><span>@@ -990,7 +990,7 @@</span><br><span>=
          */</span><br><span>         if (ca &amp;&amp; sk_X509_num(ca))</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            for (i =3D 0; i &lt; sk_X509_num(ca); i++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            for (size_t i =3D 0; i &l=
t; (size_t)sk_X509_num(ca); i++)</span><br><span>             {</span><br><=
span>                 X509_STORE *cert_store =3D SSL_CTX_get_cert_store(ctx=
-&gt;ctx);</span><br><span>                 if (!X509_STORE_add_cert(cert_s=
tore, sk_X509_value(ca, i)))</span><br><span>@@ -1015,7 +1015,7 @@</span><b=
r><span>          */</span><br><span>         if (ca &amp;&amp; sk_X509_num=
(ca))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            for (i =3D 0; i &lt; sk_X509_num(ca); i++)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            for (size_t i =3D=
 0; i &lt; (size_t)sk_X509_num(ca); i++)</span><br><span>             {</sp=
an><br><span>                 if (!SSL_CTX_add_extra_chain_cert(ctx-&gt;ctx=
, sk_X509_value(ca, i)))</span><br><span>                 {</span><br><span=
>@@ -1331,7 +1331,7 @@</span><br><span>      * we need to manually find the=
 CRL object from the stack</span><br><span>      * and remove it */</span><=
br><span>     STACK_OF(X509_OBJECT) *objs =3D X509_STORE_get0_objects(store=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D =
0; i &lt; sk_X509_OBJECT_num(objs); i++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; (size_t)sk_X509_OBJECT=
_num(objs); i++)</span><br><span>     {</span><br><span>         X509_OBJEC=
T *obj =3D sk_X509_OBJECT_value(objs, i);</span><br><span>         ASSERT(o=
bj);</span><br><span>@@ -1591,7 +1591,7 @@</span><br><span> ecdsa_sign(int =
type, const unsigned char *dgst, int dgstlen, unsigned char *sig,</span><br=
><span>            unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *=
r, EC_KEY *ec)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int capacity =3D ECDSA_size(ec);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int capacity =3D (int)ECDSA_size(ec);</spa=
n><br><span>     /*</span><br><span>      * ECDSA does not seem to have pro=
per constants for paddings since</span><br><span>      * there are only sig=
natures without padding at the moment, use</span><br><span>@@ -1607,12 +160=
7,14 @@</span><br><span>     return 0;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OPENSSL_IS_=
AWSLC</span><br><span> /* EC_KEY_METHOD callback: sign_setup(). We do no pr=
ecomputations */</span><br><span> static int</span><br><span> ecdsa_sign_se=
tup(EC_KEY *ec, BN_CTX *ctx_in, BIGNUM **kinvp, BIGNUM **rp)</span><br><spa=
n> {</span><br><span>     return 1;</span><br><span> }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span=
> /* EC_KEY_METHOD callback: sign_sig().</span><br><span>  * Sign the hash =
and return the result as a newly allocated ECDS_SIG</span><br><span>@@ -162=
3,7 +1625,7 @@</span><br><span>                EC_KEY *ec)</span><br><span>=
 {</span><br><span>     ECDSA_SIG *ecsig =3D NULL;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    unsigned int len =3D ECDSA_size(ec);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int len =3D =
(unsigned int)ECDSA_size(ec);</span><br><span>     struct gc_arena gc =3D g=
c_new();</span><br><span> </span><br><span>     unsigned char *buf =3D gc_m=
alloc(len, false, &amp;gc);</span><br><span>@@ -1790,7 +1792,7 @@</span><br=
><span>     X509_STORE *store =3D NULL;</span><br><span>     X509_NAME *xn =
=3D NULL;</span><br><span>     BIO *in =3D NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int i, added =3D 0, prev =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    size_t added =3D 0, prev =3D=
 0;</span><br><span> </span><br><span>     ASSERT(NULL !=3D ctx);</span><br=
><span> </span><br><span>@@ -1819,7 +1821,7 @@</span><br><span> </span><br>=
<span>         if (info_stack)</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            for (i =3D 0; i &lt; sk_X50=
9_INFO_num(info_stack); i++)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            for (size_t i =3D 0; i &lt; (size_t)sk_X509_INFO_num(i=
nfo_stack); i++)</span><br><span>             {</span><br><span>           =
      X509_INFO *info =3D sk_X509_INFO_value(info_stack, i);</span><br><spa=
n>                 if (info-&gt;crl)</span><br><span>@@ -1872,11 +1874,11 @=
@</span><br><span> </span><br><span>                 if (tls_server)</span>=
<br><span>                 {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    int cnum =3D sk_X509_NAME_num(cert_names);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    size_=
t cnum =3D sk_X509_NAME_num(cert_names);</span><br><span>                  =
   if (cnum !=3D (prev + 1))</span><br><span>                     {</span><=
br><span>                         crypto_msg(M_WARN,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                   &quot;Ca=
nnot load CA certificate file %s (entry %d did not validate)&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
        &quot;Cannot load CA certificate file %s (entry %zu did not validat=
e)&quot;,</span><br><span>                                    print_key_fil=
ename(ca_file, ca_file_inline), added);</span><br><span>                   =
  }</span><br><span>                     prev =3D cnum;</span><br><span>@@ =
-1884,7 +1886,7 @@</span><br><span>             }</span><br><span>         =
    sk_X509_INFO_pop_free(info_stack, X509_INFO_free);</span><br><span>    =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int cnu=
m;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t cn=
um;</span><br><span>         if (tls_server)</span><br><span>         {</sp=
an><br><span>             cnum =3D sk_X509_NAME_num(cert_names);</span><br>=
<span>@@ -1902,8 +1904,8 @@</span><br><span>             if (cnum !=3D adde=
d)</span><br><span>             {</span><br><span>                 crypto_m=
sg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                 &quot;Cannot load CA certificate file %s (only %d &quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
    &quot;of %d entries were valid X509 names)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           &quot;Cannot l=
oad CA certificate file %s (only %zu &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                           &quot;of %zu entries wer=
e valid X509 names)&quot;,</span><br><span>                            prin=
t_key_filename(ca_file, ca_file_inline), cnum, added);</span><br><span>    =
         }</span><br><span>         }</span><br><span>@@ -2552,7 +2554,7 @@=
</span><br><span> #else</span><br><span>     STACK_OF(SSL_CIPHER) *sk =3D S=
SL_get1_supported_ciphers(ssl);</span><br><span> #endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; sk_SSL_CIPHE=
R_num(sk); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (size_t i =3D 0; i &lt; (size_t)sk_SSL_CIPHER_num(sk); i++)</span><br><=
span>     {</span><br><span>         const SSL_CIPHER *c =3D sk_SSL_CIPHER_=
value(sk, i);</span><br><span> </span><br><span>diff --git a/src/openvpn/ss=
l_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</span><br><span>index=
 46401cd..a8139ea 100644</span><br><span>--- a/src/openvpn/ssl_verify_opens=
sl.c</span><br><span>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span=
>@@ -138,10 +138,10 @@</span><br><span>          * one, but we don&#39;t de=
pend on it...</span><br><span>          */</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        int numalts =3D sk_GENERAL_N=
AME_num(extensions);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        size_t numalts =3D sk_GENERAL_NAME_num(extensions);</span><br><spa=
n> </span><br><span>         /* loop through all alternatives */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 0; i &lt;=
 numalts; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   for (size_t i =3D 0; i &lt; numalts; i++)</span><br><span>         {</sp=
an><br><span>             /* get a handle to alternative name number i */</=
span><br><span>             const GENERAL_NAME *name =3D sk_GENERAL_NAME_va=
lue(extensions, i);</span><br><span>@@ -344,7 +344,7 @@</span><br><span>   =
  const EVP_MD *sha1 =3D EVP_sha1();</span><br><span>     struct buffer has=
h =3D alloc_buf_gc((size_t)EVP_MD_size(sha1), gc);</span><br><span>     X50=
9_digest(cert, EVP_sha1(), BPTR(&amp;hash), NULL);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ASSERT(buf_inc_len(&amp;hash, EVP_MD_size(=
sha1)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
buf_inc_len(&amp;hash, (int)EVP_MD_size(sha1)));</span><br><span>     retur=
n hash;</span><br><span> }</span><br><span> </span><br><span>@@ -354,7 +354=
,7 @@</span><br><span>     const EVP_MD *sha256 =3D EVP_sha256();</span><br=
><span>     struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha256)=
, gc);</span><br><span>     X509_digest(cert, EVP_sha256(), BPTR(&amp;hash)=
, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(bu=
f_inc_len(&amp;hash, EVP_MD_size(sha256)));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ASSERT(buf_inc_len(&amp;hash, (int)EVP_MD_size(=
sha256)));</span><br><span>     return hash;</span><br><span> }</span><br><=
span> </span><br><span>@@ -739,10 +739,8 @@</span><br><span>     }</span><b=
r><span>     else</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>         msg(D_HANDSHAKE, &quot;Validating cer=
tificate extended key usage&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        for (i =3D 0; SUCCESS !=3D fFound &amp;&amp; i &lt; s=
k_ASN1_OBJECT_num(eku); i++)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        for (size_t i =3D 0; SUCCESS !=3D fFound &amp;&amp; i &lt;=
 (size_t)sk_ASN1_OBJECT_num(eku); i++)</span><br><span>         {</span><br=
><span>             ASN1_OBJECT *oid =3D sk_ASN1_OBJECT_value(eku, i);</spa=
n><br><span>             char szOid[1024];</span><br><span>@@ -791,7 +789,7=
 @@</span><br><span>     }</span><br><span> </span><br><span>     STACK_OF(=
X509_OBJECT) *objs =3D X509_STORE_get0_objects(store);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; sk_X509_OBJEC=
T_num(objs); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  for (size_t i =3D 0; i &lt; (size_t)sk_X509_OBJECT_num(objs); i++)</span>=
<br><span>     {</span><br><span>         X509_OBJECT *obj =3D sk_X509_OBJE=
CT_value(objs, i);</span><br><span>         ASSERT(obj);</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1569?usp=3Demail">change 1569</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1569?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8ff30785f78fdcda136ef3fe982=
f8cda2edec059 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1569 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--KF3Qm+Mom/8=--

