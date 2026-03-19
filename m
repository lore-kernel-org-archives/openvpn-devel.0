From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 19 Mar 2026 14:17:13 +0000
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@...2715...>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <1c073c35270b5b53aca966efc874cfe206f725d9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o5GhYkRqtOc="; charset=UTF-8
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

--o5GhYkRqtOc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#4). ( http://gerrit.openvpn.net/c/=
openvpn/+/1572?usp=3Demail )


Change subject: Add aws-lc siphash implementation
......................................................................

Add aws-lc siphash implementation

AWS-LC has a siphash implementation that is just a simple function call
that also performs the same/better than the reference implementation that
it looks to be based on. AWS-lc variant seems to have come from boringssl
according to the Google copyright.

Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/siphash_openssl.c
1 file changed, 40 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1572/4

diff --git a/src/openvpn/siphash_openssl.c b/src/openvpn/siphash_openssl.c
index bb42a38..2a8e64a 100644
--- a/src/openvpn/siphash_openssl.c
+++ b/src/openvpn/siphash_openssl.c
@@ -118,7 +118,47 @@
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
 #else
 /* for now, we only have one implementation of SIPHASH in a libray, so put=
 the
  * dummy functions also here */
@@ -145,6 +185,4 @@
 siphash_cryptolib_uninit(void *sip_context)
 {
 }
-
-
 #endif /* if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER >=3D=
 0x30000000L */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1572?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Gerrit-Change-Number: 1572
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--o5GhYkRqtOc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #4</strong> to this change.</p><p><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1572?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Add aws-lc siphash implementation<br><br>AWS-LC has a siphash implement=
ation that is just a simple function call<br>that also performs the same/be=
tter than the reference implementation that<br>it looks to be based on. AWS=
-lc variant seems to have come from boringssl<br>according to the Google co=
pyright.<br><br>Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6<br>Sig=
ned-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/si=
phash_openssl.c<br>1 file changed, 40 insertions(+), 2 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/72/1572/4</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/siphash_openssl.c b/src/op=
envpn/siphash_openssl.c</span><br><span>index bb42a38..2a8e64a 100644</span=
><br><span>--- a/src/openvpn/siphash_openssl.c</span><br><span>+++ b/src/op=
envpn/siphash_openssl.c</span><br><span>@@ -118,7 +118,47 @@</span><br><spa=
n>     EVP_MAC_free(sip-&gt;mac);</span><br><span>     free(sip_context);</=
span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
lif defined(OPENSSL_IS_AWSLC)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &lt;openssl/siphash.h&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  Computes a SipHash value</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * in: pointer to input data (read-only)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  inlen: input data length in bytes=
 (any size_t value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * k: pointer to the key data (read-only), must be 16 bytes</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * out: pointer to output data (wri=
te-only), outlen bytes must be allocated</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  outlen: length of the output in bytes, must be 8 o=
r 16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+siphash_cryptolib(void *sip_context, const void=
 *in, const size_t inlen,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                  const void *k, uint8_t *out, const size_t outlen)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(outlen =3D=3D sizeof(uint64_=
t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t si=
pout =3D SIPHASH_24(k, in, inlen);</span><br><span> </span><br><span style=
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
%);">+}</span><br><span> #else</span><br><span> /* for now, we only have on=
e implementation of SIPHASH in a libray, so put the</span><br><span>  * dum=
my functions also here */</span><br><span>@@ -145,6 +185,4 @@</span><br><sp=
an> siphash_cryptolib_uninit(void *sip_context)</span><br><span> {</span><b=
r><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* if d=
efined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x3=
0000000L */</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1572?usp=3Demail">change 1572</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1572?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a7=
3e1c7b9101af6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1572 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--o5GhYkRqtOc=--

