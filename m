From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 17:48:50 +0000
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <2c45da7d4ae697eaacfe6bd6f15239c10d33a10c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bw6kqSGEgZc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add aws-lc siphash
 implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Bw6kqSGEgZc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1572?usp=3Demail )


Change subject: Add aws-lc siphash implementation
......................................................................

Add aws-lc siphash implementation

AWS-LC has a siphash implementation that is just a simple function call
that also performs the same/better than the reference implementation that
it looks to be based on. AWS-lc variant seems to have come from boringssl
according to the Google copyright.

Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
---
M src/openvpn/siphash_openssl.c
1 file changed, 41 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1572/1

diff --git a/src/openvpn/siphash_openssl.c b/src/openvpn/siphash_openssl.c
index 61d9501..5095e4f 100644
--- a/src/openvpn/siphash_openssl.c
+++ b/src/openvpn/siphash_openssl.c
@@ -119,7 +119,48 @@
     EVP_MAC_free(sip->mac);
     free(sip_context);
 }
+#elif defined(OPENSSL_IS_AWSLC)
+#include <openssl/siphash.h>

+/*
+ *  Computes a SipHash value
+ * in: pointer to input data (read-only)
+ *  inlen: input data length in bytes (any size_t value)
+ * k: pointer to the key data (read-only), must be 16 bytes
+ * out: pointer to output data (write-only), outlen bytes must be allocated
+ *  outlen: length of the output in bytes, must be 8 or 16
+ */
+int
+siphash_cryptolib(void *sip_context, const void *in, const size_t inlen,
+                  const void *k, uint8_t *out, const size_t outlen)
+{
+    ASSERT(outlen =3D=3D sizeof(uint64_t));
+    uint64_t sipout =3D SIPHASH_24(k, in, inlen);
+
+    memcpy(out, &sipout, sizeof(uint64_t));
+    return 0;
+}
+
+void *
+siphash_cryptolib_init(size_t hash_size)
+{
+    /* This library only supports 64 bit */
+    ASSERT(hash_size =3D=3D sizeof(uint64_t));
+    /* AWS LC does not need a context */
+    return NULL;
+}
+
+bool
+siphash_cryptolib_available(void *sip_context)
+{
+    return true;
+}
+
+void
+siphash_cryptolib_uninit(void *sip_context)
+{
+    /* The context is already NULL */
+}
 #else /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D =
0x30000000L */
 /* for now, we only have one implementation of SIPHASH in a libray, so put=
 the
  * dummy functions also here */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1572?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Gerrit-Change-Number: 1572
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Bw6kqSGEgZc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1572?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Add aws-lc siphash implementation<br><br>AWS-LC has a siphash implement=
ation that is just a simple function call<br>that also performs the same/be=
tter than the reference implementation that<br>it looks to be based on. AWS=
-lc variant seems to have come from boringssl<br>according to the Google co=
pyright.<br><br>Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6<br>---=
<br>M src/openvpn/siphash_openssl.c<br>1 file changed, 41 insertions(+), 0 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/72/1572/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/siphas=
h_openssl.c b/src/openvpn/siphash_openssl.c</span><br><span>index 61d9501..=
5095e4f 100644</span><br><span>--- a/src/openvpn/siphash_openssl.c</span><b=
r><span>+++ b/src/openvpn/siphash_openssl.c</span><br><span>@@ -119,7 +119,=
48 @@</span><br><span>     EVP_MAC_free(sip-&gt;mac);</span><br><span>     =
free(sip_context);</span><br><span> }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#elif defined(OPENSSL_IS_AWSLC)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;openssl/siphash.h&gt;</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  Computes a SipHash value<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in: pointer to in=
put data (read-only)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  inlen: input data length in bytes (any size_t value)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * k: pointer to the key data (read-o=
nly), must be 16 bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * out: pointer to output data (write-only), outlen bytes must be alloca=
ted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  outlen: leng=
th of the output in bytes, must be 8 or 16</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_c=
ryptolib(void *sip_context, const void *in, const size_t inlen,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                  const void *k=
, uint8_t *out, const size_t outlen)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(outlen =3D=3D sizeof(uint64_t));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint64_t sipout =3D SIPHASH_24(k, in, inlen);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    memcpy(out, &amp;sipout, sizeof(uint6=
4_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+siphash_cryptolib_init(size_t hash_size)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* This library only supports 64 bit */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_size =3D=3D sizeof(uint64=
_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* AWS LC =
does not need a context */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+siphash_cryptolib_available(void *sip_context)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_cryptolib_=
uninit(void *sip_context)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The c=
ontext is already NULL */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span> #else /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&a=
mp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L */</span><br><span> /* for n=
ow, we only have one implementation of SIPHASH in a libray, so put the</spa=
n><br><span>  * dummy functions also here */</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1572?=
usp=3Demail">change 1572</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1572?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a7=
3e1c7b9101af6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1572 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Bw6kqSGEgZc=--

