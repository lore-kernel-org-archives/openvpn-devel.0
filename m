From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 27 Mar 2024 11:05:07 +0000
In-Reply-To: <gerrit.1711377047000.If0dcdde30879fd6185efb2ad31399c1629c04d22@...2715...>
References: <gerrit.1711377047000.If0dcdde30879fd6185efb2ad31399c1629c04d22@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <078d6eb7ac328dd03f435133cf3aeedaf487bf52-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9wfXTLOWo4E="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9wfXTLOWo4E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/548?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by plaisthos


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

Change-Id: If0dcdde30879fd6185efb2ad31399c1629c04d22
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls.h
M src/openvpn/crypto_openssl.h
4 files changed, 8 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/548/2

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
index 1a39752..91485cb 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -566,11 +566,12 @@

 void
 cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key,
-                const char *ciphername, const mbedtls_operation_t operatio=
n)
+                const char *ciphername, int enc)
 {
     ASSERT(NULL !=3D ciphername && NULL !=3D ctx);
     CLEAR(*ctx);

+    const mbedtls_operation_t operation =3D (mbedtls_operation_t)enc;
     const mbedtls_cipher_info_t *kt =3D cipher_get(ciphername);
     ASSERT(kt);
     size_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(kt);
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--9wfXTLOWo4E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/548?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">crypto_backend: fix type of enc parameter<br><br=
>We had parts of a abstraction, but it wasn&#39;t consistent.<br>GCC 13 now=
 complains about the type mismatch with mbedtls now:<br><br>crypto_mbedtls.=
c:568:1: error:<br>conflicting types for =E2=80=98cipher_ctx_init=E2=80=99 =
due to enum/integer mismatch;<br>have =E2=80=98void(mbedtls_cipher_context_=
t *, const uint8_t *, const char *, const mbedtls_operation_t)=E2=80=99<br>=
[...] [-Werror=3Denum-int-mismatch]<br>crypto_backend.h:341:6: note:<br>pre=
vious declaration of =E2=80=98cipher_ctx_init=E2=80=99 with type<br>=E2=80=
=98void(cipher_ctx_t *, const uint8_t *, const char *, int)=E2=80=99 [...]<=
br><br>Previous compiler versions did not complain.<br><br>Change-Id: If0dc=
dde30879fd6185efb2ad31399c1629c04d22<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>---<br>M src/openvpn/crypto_backend.h<br>M src/op=
envpn/crypto_mbedtls.c<br>M src/openvpn/crypto_mbedtls.h<br>M src/openvpn/c=
rypto_openssl.h<br>4 files changed, 8 insertions(+), 3 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/548/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backen=
d.h</span><br><span>index 8d37e64..c454c64 100644</span><br><span>--- a/src=
/openvpn/crypto_backend.h</span><br><span>+++ b/src/openvpn/crypto_backend.=
h</span><br><span>@@ -336,10 +336,10 @@</span><br><span>  * @param key     =
      Buffer containing the key to use</span><br><span>  * @param ciphernam=
e    Ciphername of the cipher to use</span><br><span>  * @param enc        =
   Whether to encrypt or decrypt (either</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *                      \c MBEDTLS_OP_ENCRYPT or \c MBED=
TLS_OP_DECRYPT).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
                     \c OPENVPN_OP_ENCRYPT or \c OPENVPN_OP_DECRYPT).</span=
><br><span>  */</span><br><span> void cipher_ctx_init(cipher_ctx_t *ctx, co=
nst uint8_t *key,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                 const char *cipername, int enc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                     const char *cipername, c=
rypto_operation_t enc);</span><br><span> </span><br><span> /**</span><br><s=
pan>  * Returns the size of the IV used by the cipher, in bytes, or 0 if no=
 IV is</span><br><span>diff --git a/src/openvpn/crypto_mbedtls.c b/src/open=
vpn/crypto_mbedtls.c</span><br><span>index 1a39752..91485cb 100644</span><b=
r><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><span>+++ b/src/openvp=
n/crypto_mbedtls.c</span><br><span>@@ -566,11 +566,12 @@</span><br><span> <=
/span><br><span> void</span><br><span> cipher_ctx_init(mbedtls_cipher_conte=
xt_t *ctx, const uint8_t *key,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                const char *ciphername, const mbedtls_operation_t =
operation)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       const char *ciphername, int enc)</span><br><span> {</span><br><span>=
     ASSERT(NULL !=3D ciphername &amp;&amp; NULL !=3D ctx);</span><br><span=
>     CLEAR(*ctx);</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const mbedtls_operation_t operation =3D (mbedtls_opera=
tion_t)enc;</span><br><span>     const mbedtls_cipher_info_t *kt =3D cipher=
_get(ciphername);</span><br><span>     ASSERT(kt);</span><br><span>     siz=
e_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(kt);</span><br><span>=
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h</s=
pan><br><span>index 46f76e2..48d1e20 100644</span><br><span>--- a/src/openv=
pn/crypto_mbedtls.h</span><br><span>+++ b/src/openvpn/crypto_mbedtls.h</spa=
n><br><span>@@ -63,6 +63,8 @@</span><br><span> /** Cipher is in GCM mode */=
</span><br><span> #define OPENVPN_MODE_GCM        MBEDTLS_MODE_GCM</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef mb=
edtls_operation_t crypto_operation_t;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> /** Cipher should encrypt */</span><br>=
<span> #define OPENVPN_OP_ENCRYPT      MBEDTLS_ENCRYPT</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypt=
o_openssl.h</span><br><span>index c0e95b4..4cd988a 100644</span><br><span>-=
-- a/src/openvpn/crypto_openssl.h</span><br><span>+++ b/src/openvpn/crypto_=
openssl.h</span><br><span>@@ -85,6 +85,8 @@</span><br><span> /** Cipher is =
in GCM mode */</span><br><span> #define OPENVPN_MODE_GCM        EVP_CIPH_GC=
M_MODE</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+typedef int crypto_operation_t;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> /** Cipher should encrypt */</span><br><=
span> #define OPENVPN_OP_ENCRYPT      1</span><br><span> </span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/548?usp=3Demail">change 548</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/548?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If0dcdde30879fd6185efb2ad313=
99c1629c04d22 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 548 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--9wfXTLOWo4E=--

