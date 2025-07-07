From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 7 Jul 2025 14:19:35 +0000
In-Reply-To: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
References: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 rein.vanbaaren@...1435..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a2a3bc2d64dd91fc4a55ff75f839cfdf2589fc0d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EEnCN7x3bzM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Added PQE to WolfSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: comododragon <rein.vanbaaren@...1435...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EEnCN7x3bzM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 comododragon. ( http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Added PQE to WolfSSL
......................................................................

Added PQE to WolfSSL

Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
Signed-off-by: comododragon <rein.vanbaaren@...1435...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250707133447.12404-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
043.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M README.wolfssl
M src/openvpn/ssl_openssl.c
2 files changed, 31 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1046/7

diff --git a/README.wolfssl b/README.wolfssl
index a5dfe31..3918d0f 100644
--- a/README.wolfssl
+++ b/README.wolfssl
@@ -28,3 +28,33 @@
  * blowfish support (BF-CBC), you must use something like
    cipher AES-128-CBC to avoid trying to use BF-CBC
  * Windows CryptoAPI support
+
+*************************************************************************
+To build WolfSSL with post-quantum KEMs built in, the following command is=
 used:
+
+./configure --enable-openvpn --enable-kyber=3Dall --enable-curve25519
+
+WolfSSL supports the following post-quantum KEMs and post-quantum hybrid K=
EMs which must be specified
+using the tls-groups option in an OpenVPN config. Unlike OpenSSL, which in=
cludes X25519MLKEM768
+in the default config, WolfSSL requires explicit configuration of tls-grou=
ps to include
+at least one post-quantum KEM.
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
+
+The naming conventions of algorithms differ between WolfSSL and OpenSSL. A=
n example is that
+OpenSSL omits underscores for their naming notation whereas WolfSSL expect=
s them. Additionally,
+OpenSSL does not accept the P curve notation and instead uses the equivale=
nt secp notation.
+A specific example is that WolfSSL expects P384_ML_KEM_1024, while OpenSSL=
 expects secp384r1MLKEM1024.
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
Gerrit-PatchSet: 7
Gerrit-Owner: comododragon <rein.vanbaaren@...1435...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--EEnCN7x3bzM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #7</strong> to the change originally cr=
eated by comododragon.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1046?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Added PQE to WolfSSL<br><br>Change-Id: Ie0529c20=
74964b3be034f01e0ef53090a6edbd35<br>Signed-off-by: comododragon &lt;rein.va=
nbaaren@...1435...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...2477...=
.&gt;<br>Message-Id: &lt;20250707133447.12404-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32043.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M REA=
DME.wolfssl<br>M src/openvpn/ssl_openssl.c<br>2 files changed, 31 insertion=
s(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/46/1046/7</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/README.wolfssl b/README.wolf=
ssl</span><br><span>index a5dfe31..3918d0f 100644</span><br><span>--- a/REA=
DME.wolfssl</span><br><span>+++ b/README.wolfssl</span><br><span>@@ -28,3 +=
28,33 @@</span><br><span>  * blowfish support (BF-CBC), you must use someth=
ing like</span><br><span>    cipher AES-128-CBC to avoid trying to use BF-C=
BC</span><br><span>  * Windows CryptoAPI support</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+*****************************************************************=
********</span><br><span style=3D"color: hsl(120, 100%, 40%);">+To build Wo=
lfSSL with post-quantum KEMs built in, the following command is used:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+./configure --enable-openvpn --enable-kyber=
=3Dall --enable-curve25519</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+WolfSSL supp=
orts the following post-quantum KEMs and post-quantum hybrid KEMs which mus=
t be specified</span><br><span style=3D"color: hsl(120, 100%, 40%);">+using=
 the tls-groups option in an OpenVPN config. Unlike OpenSSL, which includes=
 X25519MLKEM768</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in t=
he default config, WolfSSL requires explicit configuration of tls-groups to=
 include</span><br><span style=3D"color: hsl(120, 100%, 40%);">+at least on=
e post-quantum KEM.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ML_KEM_512</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ML_KEM_768</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ML_KEM_1024</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+P256_ML_KEM_512</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+X25519_ML_KEM_512</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+P384_ML_KEM_76=
8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+P256_ML_KEM_768</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+X448_ML_KEM_768</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+X25519_ML_KEM_768</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+P384_ML_KEM_1024</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+P521_ML_KEM_1024</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+The naming conventions of algorithms differ between WolfSSL and OpenSSL.=
 An example is that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
OpenSSL omits underscores for their naming notation whereas WolfSSL expects=
 them. Additionally,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+OpenSSL does not accept the P curve notation and instead uses the equivale=
nt secp notation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+A =
specific example is that WolfSSL expects P384_ML_KEM_1024, while OpenSSL ex=
pects secp384r1MLKEM1024.</span><br><span>diff --git a/src/openvpn/ssl_open=
ssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 2fc77d8..4c11cd4 10=
0644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/=
src/openvpn/ssl_openssl.c</span><br><span>@@ -560,7 +560,7 @@</span><br><sp=
an> tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)</s=
pan><br><span> {</span><br><span>     ASSERT(ctx);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x30000000L</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NU=
MBER &lt; 0x30000000L &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br>=
<span>     struct gc_arena gc =3D gc_new();</span><br><span>     /* This me=
thod could be as easy as</span><br><span>      *  SSL_CTX_set1_groups_list(=
ctx-&gt;ctx, groups)</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">change 1046=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef=
53090a6edbd35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--EEnCN7x3bzM=--

