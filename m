From: "comododragon (Code Review)" <gerrit@...515...>
Date: Mon, 23 Jun 2025 10:50:39 +0000
In-Reply-To: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
References: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
Reply-To: rein.vanbaaren@...1435..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a4d4afa6cda88858abfede5d8b89f3005471eed4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KMS3T2ufo8U="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Added PQE to WolfSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KMS3T2ufo8U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: comododragon, flichtenheld.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail

to look at the new patch set (#3).


Change subject: Added PQE to WolfSSL
......................................................................

Added PQE to WolfSSL

Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
---
M README.wolfssl
M src/openvpn/ssl_openssl.c
2 files changed, 45 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1046/3

diff --git a/README.wolfssl b/README.wolfssl
index a5dfe31..27b9087 100644
--- a/README.wolfssl
+++ b/README.wolfssl
@@ -28,3 +28,40 @@
  * blowfish support (BF-CBC), you must use something like
    cipher AES-128-CBC to avoid trying to use BF-CBC
  * Windows CryptoAPI support
+
+*************************************************************************
+To build WolfSSL with these PQE, you'll want to configure it like this:
+
+```bash
+./configure --enable-openvpn --enable-kyber --enable-mlkem --enable-curve2=
5519
+```
+
+WolfSSL supports the following Quantum Safe algorithms by specifying them =
using the `tls-groups`
+option in a config.
+
+```
+ML_KEM_512
+ML_KEM_768
+ML_KEM_1024
+P256_ML_KEM_512
+P384_ML_KEM_768
+P256_ML_KEM_768
+P521_ML_KEM_1024
+P384_ML_KEM_1024
+X25519_ML_KEM_512
+X448_ML_KEM_768
+X25519_ML_KEM_768
+
+KYBER_LEVEL1
+KYBER_LEVEL3
+KYBER_LEVEL5
+
+P256_KYBER_LEVEL1
+P384_KYBER_LEVEL3
+P256_KYBER_LEVEL3
+P521_KYBER_LEVEL5
+
+X25519_KYBER_LEVEL1
+X448_KYBER_LEVEL3
+X25519_KYBER_LEVEL3
+```
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 2fc77d8..b873e54 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -560,7 +560,13 @@
 tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
 {
     ASSERT(ctx);
-#if OPENSSL_VERSION_NUMBER < 0x30000000L
+#if defined(ENABLE_CRYPTO_WOLFSSL) || OPENSSL_VERSION_NUMBER >=3D 0x300000=
00L
+    if (!SSL_CTX_set1_groups_list(ctx->ctx, groups))
+    {
+        crypto_msg(M_FATAL, "Failed to set allowed TLS group list: %s",
+                groups);
+    }
+#else
     struct gc_arena gc =3D gc_new();
     /* This method could be as easy as
      *  SSL_CTX_set1_groups_list(ctx->ctx, groups)
@@ -607,13 +613,7 @@
                    groups);
     }
     gc_free(&gc);
-#else  /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
-    if (!SSL_CTX_set1_groups_list(ctx->ctx, groups))
-    {
-        crypto_msg(M_FATAL, "Failed to set allowed TLS group list: %s",
-                   groups);
-    }
-#endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
+#endif
 }

 void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
Gerrit-Change-Number: 1046
Gerrit-PatchSet: 3
Gerrit-Owner: comododragon <rein.vanbaaren@...1435...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: comododragon <rein.vanbaaren@...1435...>
Gerrit-MessageType: newpatchset

--KMS3T2ufo8U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: comododragon, flichtenheld. </p>
<p>comododragon <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Added PQE to WolfSSL<br><br>Change-Id: Ie0529c2074964b3be034f01e0=
ef53090a6edbd35<br>---<br>M README.wolfssl<br>M src/openvpn/ssl_openssl.c<b=
r>2 files changed, 45 insertions(+), 8 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/46/1046/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/README.wolfssl b/README.wolfssl</span><br><span>index a5dfe31..27b908=
7 100644</span><br><span>--- a/README.wolfssl</span><br><span>+++ b/README.=
wolfssl</span><br><span>@@ -28,3 +28,40 @@</span><br><span>  * blowfish sup=
port (BF-CBC), you must use something like</span><br><span>    cipher AES-1=
28-CBC to avoid trying to use BF-CBC</span><br><span>  * Windows CryptoAPI =
support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+*******************************=
******************************************</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+To build WolfSSL with these PQE, you&#39;ll want to =
configure it like this:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+```bash</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+./configure --enable-openvp=
n --enable-kyber --enable-mlkem --enable-curve25519</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+```</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+W=
olfSSL supports the following Quantum Safe algorithms by specifying them us=
ing the `tls-groups` </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+option in a config.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+```</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ML_KEM_512</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ML_KEM_768</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ML_KEM_1024</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+P256_ML_KEM_512</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+P384_ML_KEM_768</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+P256_ML_KEM_768</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+P521_ML_KEM_1024</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+P384_ML_KEM_1024</span><br><span style=3D"color: hsl(120, 100%, 40%);">+X=
25519_ML_KEM_512</span><br><span style=3D"color: hsl(120, 100%, 40%);">+X44=
8_ML_KEM_768</span><br><span style=3D"color: hsl(120, 100%, 40%);">+X25519_=
ML_KEM_768</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+KYBER_LEVEL1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+KYBER_LEVEL3</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+KYBER_LEVEL5</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+P256_KYBER_LEVEL1</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+P384_KYBER_LEVEL3</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+P256_KYBER_LEVEL3</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+P521_KYBER_LEVEL5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+X25519_KYBER_LEVEL1=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+X448_KYBER_LEVEL3</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+X25519_KYBER_LEVEL3</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+```</span><br><span>d=
iff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br=
><span>index 2fc77d8..b873e54 100644</span><br><span>--- a/src/openvpn/ssl_=
openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@=
@ -560,7 +560,13 @@</span><br><span> tls_ctx_set_tls_groups(struct tls_root=
_ctx *ctx, const char *groups)</span><br><span> {</span><br><span>     ASSE=
RT(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_V=
ERSION_NUMBER &lt; 0x30000000L</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(ENABLE_CRYPTO_WOLFSSL) || OPENSSL_VERSION_NUMBER &gt=
;=3D 0x30000000L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!SSL_CTX_set1_groups_list(ctx-&gt;ctx, groups))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        crypto_msg(M_FATAL, &quot;Failed to set allowed=
 TLS group list: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                groups);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
lse</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> =
    /* This method could be as easy as</span><br><span>      *  SSL_CTX_set=
1_groups_list(ctx-&gt;ctx, groups)</span><br><span>@@ -607,13 +613,7 @@</sp=
an><br><span>                    groups);</span><br><span>     }</span><br>=
<span>     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#else  /* if OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (!SSL_CTX_set1_groups_list(=
ctx-&gt;ctx, groups))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypto_m=
sg(M_FATAL, &quot;Failed to set allowed TLS group list: %s&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                   groups);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif /* if OPENSSL_VERSION_NUMBER &lt; =
0x30000000L */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1046?usp=3Demail">change 1046</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef=
53090a6edbd35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: comododragon &lt;rein.vanbaaren@=
...1435...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: comododragon &lt;rein.vanbaa=
ren@...1435...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--KMS3T2ufo8U=--

