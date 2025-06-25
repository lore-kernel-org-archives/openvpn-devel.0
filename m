From: "comododragon (Code Review)" <gerrit@...515...>
Date: Wed, 25 Jun 2025 11:24:44 +0000
In-Reply-To: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
References: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
Reply-To: rein.vanbaaren@...1435..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <b3e78e9d25d6721f6c494fa1662c2f434a0afae0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="STmcgScTU5Y="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Added PQE to WolfSSL
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

--STmcgScTU5Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: comododragon, cron2, flichtenheld.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail

to look at the new patch set (#5).


Change subject: Added PQE to WolfSSL
......................................................................

Added PQE to WolfSSL

Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
---
M README.wolfssl
M src/openvpn/ssl_openssl.c
2 files changed, 24 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1046/5

diff --git a/README.wolfssl b/README.wolfssl
index a5dfe31..46b080c 100644
--- a/README.wolfssl
+++ b/README.wolfssl
@@ -28,3 +28,26 @@
  * blowfish support (BF-CBC), you must use something like
    cipher AES-128-CBC to avoid trying to use BF-CBC
  * Windows CryptoAPI support
+
+*************************************************************************
+To build WolfSSL with support for post-quantum KEMs, the following command=
 is used:
+
+./configure --enable-openvpn --enable-kyber=3Dall --enable-curve25519
+
+WolfSSL supports the following post-quantum KEMs or post-quantum hybrid KE=
Ms by specifying them using the `tls-groups`
+option in an OpenVPN config.
+
+ML_KEM_512
+ML_KEM_768
+ML_KEM_1024
+
+P256_ML_KEM_512
+X25519_ML_KEM_512
+
+P384_ML_KEM_768
+P256_ML_KEM_768
+X448_ML_KEM_768
+X25519_ML_KEM_768
+
+P384_ML_KEM_1024
+P521_ML_KEM_1024
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 2fc77d8..4c11cd4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -560,7 +560,7 @@
 tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
 {
     ASSERT(ctx);
-#if OPENSSL_VERSION_NUMBER < 0x30000000L
+#if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(ENABLE_CRYPTO_WOLFSSL)
     struct gc_arena gc =3D gc_new();
     /* This method could be as easy as
      *  SSL_CTX_set1_groups_list(ctx->ctx, groups)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
Gerrit-Change-Number: 1046
Gerrit-PatchSet: 5
Gerrit-Owner: comododragon <rein.vanbaaren@...1435...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: comododragon <rein.vanbaaren@...1435...>
Gerrit-MessageType: newpatchset

--STmcgScTU5Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: comododragon, cron2, flichtenheld=
. </p>
<p>comododragon <strong>uploaded patch set #5</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Added PQE to WolfSSL<br><br>Change-Id: Ie0529c2074964b3be034f01e0=
ef53090a6edbd35<br>---<br>M README.wolfssl<br>M src/openvpn/ssl_openssl.c<b=
r>2 files changed, 24 insertions(+), 1 deletion(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/46/1046/5</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/README.wolfssl b/README.wolfssl</span><br><span>index a5dfe31..46b080=
c 100644</span><br><span>--- a/README.wolfssl</span><br><span>+++ b/README.=
wolfssl</span><br><span>@@ -28,3 +28,26 @@</span><br><span>  * blowfish sup=
port (BF-CBC), you must use something like</span><br><span>    cipher AES-1=
28-CBC to avoid trying to use BF-CBC</span><br><span>  * Windows CryptoAPI =
support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+*******************************=
******************************************</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+To build WolfSSL with support for post-quantum KEMs,=
 the following command is used:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+./confi=
gure --enable-openvpn --enable-kyber=3Dall --enable-curve25519</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+WolfSSL supports the following post-quantum KEMs or=
 post-quantum hybrid KEMs by specifying them using the `tls-groups` </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+option in an OpenVPN confi=
g.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ML_KEM_512</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ML_KEM_768</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ML_KEM_1024</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+P256_M=
L_KEM_512</span><br><span style=3D"color: hsl(120, 100%, 40%);">+X25519_ML_=
KEM_512</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+P384_ML_KEM_768</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+P256_ML_KEM_768</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+X448_ML_KEM_768</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+X25519_ML_KEM_768</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+P384_ML_KEM_1024</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+P521_ML_KEM_1024</span><br><span>diff --git a/src/openvpn/ssl_o=
penssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 2fc77d8..4c11cd4=
 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++=
 b/src/openvpn/ssl_openssl.c</span><br><span>@@ -560,7 +560,7 @@</span><br>=
<span> tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)=
</span><br><span> {</span><br><span>     ASSERT(ctx);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x30000000L=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION=
_NUMBER &lt; 0x30000000L &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><=
br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     /* This=
 method could be as easy as</span><br><span>      *  SSL_CTX_set1_groups_li=
st(ctx-&gt;ctx, groups)</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">change 1=
046</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef=
53090a6edbd35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: comododragon &lt;rein.vanbaaren@=
...1435...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: comododragon &lt;rein.vanbaa=
ren@...1435...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--STmcgScTU5Y=--

