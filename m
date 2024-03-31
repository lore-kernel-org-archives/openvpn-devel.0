From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 31 Mar 2024 14:17:50 +0000
In-Reply-To: <gerrit.1711377047000.If0dcdde30879fd6185efb2ad31399c1629c04d22@...2715...>
References: <gerrit.1711377047000.If0dcdde30879fd6185efb2ad31399c1629c04d22@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <93c122aa60b1ea3466a078589bb14b03f39151a4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Pd4QB1DNOSE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto_backend: fix
 type of enc parameter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Pd4QB1DNOSE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/548?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: crypto_backend: fix type of enc parameter
......................................................................

crypto_backend: fix type of enc parameter

We had parts of a abstraction, but it wasn't consistent.
GCC 13 now complains about the type mismatch with mbedtls now:

crypto_mbedtls.c:568:1: error:
conflicting types for =E2=80=98cipher_ctx_init=E2=80=99 due to enum/integer=
 mismatch;
have =E2=80=98void(mbedtls_cipher_context_t *, const uint8_t *, const char =
*, const mbedtls_operation_t)=E2=80=99
[...] [-Werror=3Denum-int-mismatch]
crypto_backend.h:341:6: note:
previous declaration of =E2=80=98cipher_ctx_init=E2=80=99 with type
=E2=80=98void(cipher_ctx_t *, const uint8_t *, const char *, int)=E2=80=99 =
[...]

Previous compiler versions did not complain.

v2:
 - clean solution instead of quick solution. Fix the actual API
   definition

Change-Id: If0dcdde30879fd6185efb2ad31399c1629c04d22
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240327162621.1792414-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
498.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls.h
M src/openvpn/crypto_openssl.c
M src/openvpn/crypto_openssl.h
5 files changed, 9 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/548/4

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 8d37e64..c454c64 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -336,10 +336,10 @@
  * @param key           Buffer containing the key to use
  * @param ciphername    Ciphername of the cipher to use
  * @param enc           Whether to encrypt or decrypt (either
- *                      \c MBEDTLS_OP_ENCRYPT or \c MBEDTLS_OP_DECRYPT).
+ *                      \c OPENVPN_OP_ENCRYPT or \c OPENVPN_OP_DECRYPT).
  */
 void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key,
-                     const char *cipername, int enc);
+                     const char *cipername, crypto_operation_t enc);

 /**
  * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV =
is
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 1a39752..c230292 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -566,7 +566,7 @@

 void
 cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key,
-                const char *ciphername, const mbedtls_operation_t operatio=
n)
+                const char *ciphername, crypto_operation_t enc)
 {
     ASSERT(NULL !=3D ciphername && NULL !=3D ctx);
     CLEAR(*ctx);
@@ -580,7 +580,7 @@
         msg(M_FATAL, "mbed TLS cipher context init #1");
     }

-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, operatio=
n)))
+    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, enc)))
     {
         msg(M_FATAL, "mbed TLS cipher set key");
     }
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 46f76e2..48d1e20 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -63,6 +63,8 @@
 /** Cipher is in GCM mode */
 #define OPENVPN_MODE_GCM        MBEDTLS_MODE_GCM

+typedef mbedtls_operation_t crypto_operation_t;
+
 /** Cipher should encrypt */
 #define OPENVPN_OP_ENCRYPT      MBEDTLS_ENCRYPT

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 50683b6..bfc5e37 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -840,7 +840,7 @@

 void
 cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t *key,
-                const char *ciphername, int enc)
+                const char *ciphername, crypto_operation_t enc)
 {
     ASSERT(NULL !=3D ciphername && NULL !=3D ctx);
     evp_cipher_type *kt =3D cipher_get(ciphername);
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index c0e95b4..4cd988a 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -85,6 +85,8 @@
 /** Cipher is in GCM mode */
 #define OPENVPN_MODE_GCM        EVP_CIPH_GCM_MODE

+typedef int crypto_operation_t;
+
 /** Cipher should encrypt */
 #define OPENVPN_OP_ENCRYPT      1


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/548?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If0dcdde30879fd6185efb2ad31399c1629c04d22
Gerrit-Change-Number: 548
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--Pd4QB1DNOSE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/548?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">crypto_backend: fix type of enc parameter<br><br=
>We had parts of a abstraction, but it wasn&#39;t consistent.<br>GCC 13 now=
 complains about the type mismatch with mbedtls now:<br><br>crypto_mbedtls.=
c:568:1: error:<br>conflicting types for =E2=80=98cipher_ctx_init=E2=80=99 =
due to enum/integer mismatch;<br>have =E2=80=98void(mbedtls_cipher_context_=
t *, const uint8_t *, const char *, const mbedtls_operation_t)=E2=80=99<br>=
[...] [-Werror=3Denum-int-mismatch]<br>crypto_backend.h:341:6: note:<br>pre=
vious declaration of =E2=80=98cipher_ctx_init=E2=80=99 with type<br>=E2=80=
=98void(cipher_ctx_t *, const uint8_t *, const char *, int)=E2=80=99 [...]<=
br><br>Previous compiler versions did not complain.<br><br>v2:<br> - clean =
solution instead of quick solution. Fix the actual API<br>   definition<br>=
<br>Change-Id: If0dcdde30879fd6185efb2ad31399c1629c04d22<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;ar=
ne-openvpn@...1227...&gt;<br>Message-Id: &lt;20240327162621.1792414-1-frank=
@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg28498.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/openvpn/crypto_backend.h<br>M src/openvpn/crypto_mb=
edtls.c<br>M src/openvpn/crypto_mbedtls.h<br>M src/openvpn/crypto_openssl.c=
<br>M src/openvpn/crypto_openssl.h<br>5 files changed, 9 insertions(+), 5 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/48/548/4</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_backend.h b/src/op=
envpn/crypto_backend.h</span><br><span>index 8d37e64..c454c64 100644</span>=
<br><span>--- a/src/openvpn/crypto_backend.h</span><br><span>+++ b/src/open=
vpn/crypto_backend.h</span><br><span>@@ -336,10 +336,10 @@</span><br><span>=
  * @param key           Buffer containing the key to use</span><br><span> =
 * @param ciphername    Ciphername of the cipher to use</span><br><span>  *=
 @param enc           Whether to encrypt or decrypt (either</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *                      \c MBEDTLS_OP=
_ENCRYPT or \c MBEDTLS_OP_DECRYPT).</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *                      \c OPENVPN_OP_ENCRYPT or \c OPENVPN=
_OP_DECRYPT).</span><br><span>  */</span><br><span> void cipher_ctx_init(ci=
pher_ctx_t *ctx, const uint8_t *key,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                     const char *cipername, int enc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                     const=
 char *cipername, crypto_operation_t enc);</span><br><span> </span><br><spa=
n> /**</span><br><span>  * Returns the size of the IV used by the cipher, i=
n bytes, or 0 if no IV is</span><br><span>diff --git a/src/openvpn/crypto_m=
bedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index 1a39752..c230=
292 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><sp=
an>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -566,7 +566,7 @@</=
span><br><span> </span><br><span> void</span><br><span> cipher_ctx_init(mbe=
dtls_cipher_context_t *ctx, const uint8_t *key,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                const char *ciphername, const mbe=
dtls_operation_t operation)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                const char *ciphername, crypto_operation_t enc)</sp=
an><br><span> {</span><br><span>     ASSERT(NULL !=3D ciphername &amp;&amp;=
 NULL !=3D ctx);</span><br><span>     CLEAR(*ctx);</span><br><span>@@ -580,=
7 +580,7 @@</span><br><span>         msg(M_FATAL, &quot;mbed TLS cipher con=
text init #1&quot;);</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_set=
key(ctx, key, (int)key_bitlen, operation)))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (i=
nt)key_bitlen, enc)))</span><br><span>     {</span><br><span>         msg(M=
_FATAL, &quot;mbed TLS cipher set key&quot;);</span><br><span>     }</span>=
<br><span>diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mb=
edtls.h</span><br><span>index 46f76e2..48d1e20 100644</span><br><span>--- a=
/src/openvpn/crypto_mbedtls.h</span><br><span>+++ b/src/openvpn/crypto_mbed=
tls.h</span><br><span>@@ -63,6 +63,8 @@</span><br><span> /** Cipher is in G=
CM mode */</span><br><span> #define OPENVPN_MODE_GCM        MBEDTLS_MODE_GC=
M</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
typedef mbedtls_operation_t crypto_operation_t;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /** Cipher should encrypt */<=
/span><br><span> #define OPENVPN_OP_ENCRYPT      MBEDTLS_ENCRYPT</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/crypto_openssl.c b/src/ope=
nvpn/crypto_openssl.c</span><br><span>index 50683b6..bfc5e37 100644</span><=
br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openv=
pn/crypto_openssl.c</span><br><span>@@ -840,7 +840,7 @@</span><br><span> </=
span><br><span> void</span><br><span> cipher_ctx_init(EVP_CIPHER_CTX *ctx, =
const uint8_t *key,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              const char *ciphername, int enc)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                const char *ciphername, crypto_o=
peration_t enc)</span><br><span> {</span><br><span>     ASSERT(NULL !=3D ci=
phername &amp;&amp; NULL !=3D ctx);</span><br><span>     evp_cipher_type *k=
t =3D cipher_get(ciphername);</span><br><span>diff --git a/src/openvpn/cryp=
to_openssl.h b/src/openvpn/crypto_openssl.h</span><br><span>index c0e95b4..=
4cd988a 100644</span><br><span>--- a/src/openvpn/crypto_openssl.h</span><br=
><span>+++ b/src/openvpn/crypto_openssl.h</span><br><span>@@ -85,6 +85,8 @@=
</span><br><span> /** Cipher is in GCM mode */</span><br><span> #define OPE=
NVPN_MODE_GCM        EVP_CIPH_GCM_MODE</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+typedef int crypto_operation_t;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /** Ciph=
er should encrypt */</span><br><span> #define OPENVPN_OP_ENCRYPT      1</sp=
an><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/548?usp=3Demail">change 548</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/548?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If0dcdde30879fd6185efb2ad313=
99c1629c04d22 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 548 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Pd4QB1DNOSE=--

