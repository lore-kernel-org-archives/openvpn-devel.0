From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 22 Apr 2026 13:21:08 +0000
References: <gerrit.1776864065000.I88254e985d67234d827b92908079795df23daf20@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <ebefa57d452da1bc7cba64be1af4ffda8868e1ed-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Lx1sGIZvpSw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: AWS-LC: Add casts
 and openssl_opt_t typdef to allow AWS-LC with -Werror
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Lx1sGIZvpSw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1637?usp=3Demail )


Change subject: AWS-LC: Add casts and openssl_opt_t typdef to allow AWS-LC =
with -Werror
......................................................................

AWS-LC: Add casts and openssl_opt_t typdef to allow AWS-LC with -Werror

Change-Id: I88254e985d67234d827b92908079795df23daf20
---
M .github/workflows/build.yaml
M src/openvpn/crypto_openssl.c
M src/openvpn/openssl_compat.h
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_verify_openssl.c
5 files changed, 16 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/1637/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index e4cb799..5cc1a7d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -347,6 +347,4 @@
       gitref: v1.70.0
       libconfigure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=3DRelease -D=
CMAKE_INSTALL_PREFIX=3D"$LIBPREFIX" -DBUILD_SHARED_LIBS=3D1
       libmake: cmake --build build
-      libinstall: sudo cmake --install build
-      # not ready for --enable-werror
-      ovpnconfigureflags:
+      libinstall: sudo cmake --install build
\ No newline at end of file
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index c11cfd8..fa9eb67 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -425,7 +425,7 @@
 print_digest(EVP_MD *digest, void *unused)
 {
     printf("%s %d bit digest size\n", md_kt_name(EVP_MD_get0_name(digest)),
-           EVP_MD_size(digest) * 8);
+           (int)EVP_MD_size(digest) * 8);
 }

 void
@@ -1025,7 +1025,7 @@
                    "Message hash algorithm '%s' uses a default hash "
                    "size (%d bytes) which is larger than " PACKAGE_NAME "'=
s current "
                    "maximum hash size (%d bytes)",
-                   digest, EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);
+                   digest, (int)EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);
     }
     return md;
 }
@@ -1144,7 +1144,7 @@
 int
 md_ctx_size(const EVP_MD_CTX *ctx)
 {
-    return EVP_MD_CTX_size(ctx);
+    return (int)EVP_MD_CTX_size(ctx);
 }

 void
@@ -1188,7 +1188,7 @@
     evp_md_type *kt =3D md_get(mdname);
     ASSERT(NULL !=3D kt && NULL !=3D ctx);

-    int key_len =3D EVP_MD_size(kt);
+    int key_len =3D (int)EVP_MD_size(kt);
     HMAC_CTX_reset(ctx);
     if (!HMAC_Init_ex(ctx, key, key_len, kt, NULL))
     {
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index ec059ac..b61bcbf 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -51,10 +51,14 @@
 typedef uint32_t openssl_err_t;
 typedef size_t openssl_stack_size_t;
 #define PRI_OPENSSL_STACK "zu"
+typedef uint32_t openssl_opt_t;
 #else
 typedef unsigned long openssl_err_t;
 typedef int openssl_stack_size_t;
 #define PRI_OPENSSL_STACK "d"
+/* OpenSSL 4.0 actually uses bits in the upper half of the uint64_t (e.g.
+ * SSL_OP_PREFER_NO_DHE_KEX), so we really should use an uint64_t here */
+typedef uint64_t openssl_opt_t;
 #endif


diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 6ce5f3f..ef99b22 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -328,7 +328,7 @@
     ASSERT(NULL !=3D ctx);

     /* process SSL options */
-    uint64_t sslopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
+    openssl_opt_t sslopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
 #ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
     sslopt |=3D SSL_OP_CIPHER_SERVER_PREFERENCE;
 #endif
@@ -1656,7 +1656,7 @@
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
@@ -1672,12 +1672,14 @@
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
@@ -1688,7 +1690,7 @@
                EC_KEY *ec)
 {
     ECDSA_SIG *ecsig =3D NULL;
-    unsigned int len =3D ECDSA_size(ec);
+    unsigned int len =3D (unsigned int)ECDSA_size(ec);
     struct gc_arena gc =3D gc_new();

     unsigned char *buf =3D gc_malloc(len, false, &gc);
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 6bb61b6..b8648fd 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -357,7 +357,7 @@
     const EVP_MD *sha1 =3D EVP_sha1();
     struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha1), gc);
     X509_digest(cert, EVP_sha1(), BPTR(&hash), NULL);
-    ASSERT(buf_inc_len(&hash, EVP_MD_size(sha1)));
+    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha1)));
     return hash;
 }

@@ -367,7 +367,7 @@
     const EVP_MD *sha256 =3D EVP_sha256();
     struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha256), gc);
     X509_digest(cert, EVP_sha256(), BPTR(&hash), NULL);
-    ASSERT(buf_inc_len(&hash, EVP_MD_size(sha256)));
+    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha256)));
     return hash;
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1637?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I88254e985d67234d827b92908079795df23daf20
Gerrit-Change-Number: 1637
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Lx1sGIZvpSw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1637?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">AWS-LC: Add casts and openssl_opt_t typdef to allow AWS-LC with -Werror=
<br><br>Change-Id: I88254e985d67234d827b92908079795df23daf20<br>---<br>M .g=
ithub/workflows/build.yaml<br>M src/openvpn/crypto_openssl.c<br>M src/openv=
pn/openssl_compat.h<br>M src/openvpn/ssl_openssl.c<br>M src/openvpn/ssl_ver=
ify_openssl.c<br>5 files changed, 16 insertions(+), 12 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/37/1637/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github=
/workflows/build.yaml</span><br><span>index e4cb799..5cc1a7d 100644</span><=
br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/w=
orkflows/build.yaml</span><br><span>@@ -347,6 +347,4 @@</span><br><span>   =
    gitref: v1.70.0</span><br><span>       libconfigure: cmake -B build -GN=
inja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D&quot;$LIBPREFIX=
&quot; -DBUILD_SHARED_LIBS=3D1</span><br><span>       libmake: cmake --buil=
d build</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      libinsta=
ll: sudo cmake --install build</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      # not ready for --enable-werror</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      ovpnconfigureflags:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      libinstall: sudo cmake --install build=
</span><br><span>\ No newline at end of file</span><br><span>diff --git a/s=
rc/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</span><br><span>=
index c11cfd8..fa9eb67 100644</span><br><span>--- a/src/openvpn/crypto_open=
ssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.c</span><br><span>@@=
 -425,7 +425,7 @@</span><br><span> print_digest(EVP_MD *digest, void *unuse=
d)</span><br><span> {</span><br><span>     printf(&quot;%s %d bit digest si=
ze\n&quot;, md_kt_name(EVP_MD_get0_name(digest)),</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-           EVP_MD_size(digest) * 8);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+           (int)EVP_MD_size(di=
gest) * 8);</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span>@@ -1025,7 +1025,7 @@</span><br><span>                    &quot=
;Message hash algorithm &#39;%s&#39; uses a default hash &quot;</span><br><=
span>                    &quot;size (%d bytes) which is larger than &quot; =
PACKAGE_NAME &quot;&#39;s current &quot;</span><br><span>                  =
  &quot;maximum hash size (%d bytes)&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                   digest, EVP_MD_size(md), MAX_HMAC_=
KEY_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
            digest, (int)EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);</span><br><=
span>     }</span><br><span>     return md;</span><br><span> }</span><br><s=
pan>@@ -1144,7 +1144,7 @@</span><br><span> int</span><br><span> md_ctx_size=
(const EVP_MD_CTX *ctx)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return EVP_MD_CTX_size(ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return (int)EVP_MD_CTX_size(ctx);</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span>@@ =
-1188,7 +1188,7 @@</span><br><span>     evp_md_type *kt =3D md_get(mdname);=
</span><br><span>     ASSERT(NULL !=3D kt &amp;&amp; NULL !=3D ctx);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ke=
y_len =3D EVP_MD_size(kt);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int key_len =3D (int)EVP_MD_size(kt);</span><br><span>     HMAC_=
CTX_reset(ctx);</span><br><span>     if (!HMAC_Init_ex(ctx, key, key_len, k=
t, NULL))</span><br><span>     {</span><br><span>diff --git a/src/openvpn/o=
penssl_compat.h b/src/openvpn/openssl_compat.h</span><br><span>index ec059a=
c..b61bcbf 100644</span><br><span>--- a/src/openvpn/openssl_compat.h</span>=
<br><span>+++ b/src/openvpn/openssl_compat.h</span><br><span>@@ -51,10 +51,=
14 @@</span><br><span> typedef uint32_t openssl_err_t;</span><br><span> typ=
edef size_t openssl_stack_size_t;</span><br><span> #define PRI_OPENSSL_STAC=
K &quot;zu&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typ=
edef uint32_t openssl_opt_t;</span><br><span> #else</span><br><span> typede=
f unsigned long openssl_err_t;</span><br><span> typedef int openssl_stack_s=
ize_t;</span><br><span> #define PRI_OPENSSL_STACK &quot;d&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* OpenSSL 4.0 actually uses bi=
ts in the upper half of the uint64_t (e.g.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * SSL_OP_PREFER_NO_DHE_KEX), so we really should us=
e an uint64_t here */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+typedef uint64_t openssl_opt_t;</span><br><span> #endif</span><br><span> =
</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_openssl.c b=
/src/openvpn/ssl_openssl.c</span><br><span>index 6ce5f3f..ef99b22 100644</s=
pan><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/ope=
nvpn/ssl_openssl.c</span><br><span>@@ -328,7 +328,7 @@</span><br><span>    =
 ASSERT(NULL !=3D ctx);</span><br><span> </span><br><span>     /* process S=
SL options */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint=
64_t sslopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    openssl_opt_t sslopt =3D SSL_OP_SI=
NGLE_DH_USE | SSL_OP_NO_TICKET;</span><br><span> #ifdef SSL_OP_CIPHER_SERVE=
R_PREFERENCE</span><br><span>     sslopt |=3D SSL_OP_CIPHER_SERVER_PREFEREN=
CE;</span><br><span> #endif</span><br><span>@@ -1656,7 +1656,7 @@</span><br=
><span> ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsign=
ed char *sig,</span><br><span>            unsigned int *siglen, const BIGNU=
M *kinv, const BIGNUM *r, EC_KEY *ec)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int capacity =3D ECDSA_size(ec);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int capacity =3D (i=
nt)ECDSA_size(ec);</span><br><span>     /*</span><br><span>      * ECDSA do=
es not seem to have proper constants for paddings since</span><br><span>   =
   * there are only signatures without padding at the moment, use</span><br=
><span>@@ -1672,12 +1672,14 @@</span><br><span>     return 0;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifndef OPENSSL_IS_AWSLC</span><br><span> /* EC_KEY_METHOD callback: si=
gn_setup(). We do no precomputations */</span><br><span> static int</span><=
br><span> ecdsa_sign_setup(EC_KEY *ec, BN_CTX *ctx_in, BIGNUM **kinvp, BIGN=
UM **rp)</span><br><span> {</span><br><span>     return 1;</span><br><span>=
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span> </span><br><span> /* EC_KEY_METHOD callback: sign_sig().</span><br><=
span>  * Sign the hash and return the result as a newly allocated ECDS_SIG<=
/span><br><span>@@ -1688,7 +1690,7 @@</span><br><span>                EC_KE=
Y *ec)</span><br><span> {</span><br><span>     ECDSA_SIG *ecsig =3D NULL;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int len =
=3D ECDSA_size(ec);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    unsigned int len =3D (unsigned int)ECDSA_size(ec);</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     un=
signed char *buf =3D gc_malloc(len, false, &amp;gc);</span><br><span>diff -=
-git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c<=
/span><br><span>index 6bb61b6..b8648fd 100644</span><br><span>--- a/src/ope=
nvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_open=
ssl.c</span><br><span>@@ -357,7 +357,7 @@</span><br><span>     const EVP_MD=
 *sha1 =3D EVP_sha1();</span><br><span>     struct buffer hash =3D alloc_bu=
f_gc((size_t)EVP_MD_size(sha1), gc);</span><br><span>     X509_digest(cert,=
 EVP_sha1(), BPTR(&amp;hash), NULL);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ASSERT(buf_inc_len(&amp;hash, EVP_MD_size(sha1)));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_inc_len(&a=
mp;hash, (int)EVP_MD_size(sha1)));</span><br><span>     return hash;</span>=
<br><span> }</span><br><span> </span><br><span>@@ -367,7 +367,7 @@</span><b=
r><span>     const EVP_MD *sha256 =3D EVP_sha256();</span><br><span>     st=
ruct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha256), gc);</span><=
br><span>     X509_digest(cert, EVP_sha256(), BPTR(&amp;hash), NULL);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_inc_len(&amp=
;hash, EVP_MD_size(sha256)));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(buf_inc_len(&amp;hash, (int)EVP_MD_size(sha256)));</sp=
an><br><span>     return hash;</span><br><span> }</span><br><span> </span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1637?usp=3Demail">change 1637</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1637?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88254e985d67234d827b9290807=
9795df23daf20 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1637 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Lx1sGIZvpSw=--

