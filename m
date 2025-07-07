From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 7 Jul 2025 14:19:37 +0000
In-Reply-To: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
References: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 rein.vanbaaren@...1435..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a2a3bc2d64dd91fc4a55ff75f839cfdf2589fc0d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1PWKSB0WInQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Added PQE to WolfSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: comododragon <rein.vanbaaren@...1435...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1PWKSB0WInQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
46?usp=3Demail )

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
Gerrit-MessageType: merged

--1PWKSB0WInQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Added PQE to WolfSSL<br><br>Change-Id: Ie0529=
c2074964b3be034f01e0ef53090a6edbd35<br>Signed-off-by: comododragon &lt;rein=
.vanbaaren@...1435...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...2068...=
7...&gt;<br>Message-Id: &lt;20250707133447.12404-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg320=
43.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
README.wolfssl<br>M src/openvpn/ssl_openssl.c<br>2 files changed, 31 insert=
ions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/README.wolfssl b/README.wolfssl</span><br><span>index a5dfe=
31..3918d0f 100644</span><br><span>--- a/README.wolfssl</span><br><span>+++=
 b/README.wolfssl</span><br><span>@@ -28,3 +28,33 @@</span><br><span>  * bl=
owfish support (BF-CBC), you must use something like</span><br><span>    ci=
pher AES-128-CBC to avoid trying to use BF-CBC</span><br><span>  * Windows =
CryptoAPI support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+*********************=
****************************************************</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+To build WolfSSL with post-quantum KEMs b=
uilt in, the following command is used:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+./configure --enable-openvpn --enable-kyber=3Dall --enable-curve25519</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+WolfSSL supports the following post-quant=
um KEMs and post-quantum hybrid KEMs which must be specified</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+using the tls-groups option in an =
OpenVPN config. Unlike OpenSSL, which includes X25519MLKEM768</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+in the default config, WolfSSL re=
quires explicit configuration of tls-groups to include</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+at least one post-quantum KEM.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ML_KEM_512</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ML_KEM_768</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ML_KEM_1024</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+P256_ML_KEM_512</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+X25519_ML_KEM_512</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+P384_ML_KEM_768</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+P256_ML_KEM_768</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+X448_ML_KEM_768</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+X25519_ML_KEM_768</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+P384_ML_KEM_1024</span><br><span style=3D"color: hsl(120, 100%, 40%);">+P5=
21_ML_KEM_1024</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+The naming conventions o=
f algorithms differ between WolfSSL and OpenSSL. An example is that</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+OpenSSL omits underscores f=
or their naming notation whereas WolfSSL expects them. Additionally,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+OpenSSL does not accept th=
e P curve notation and instead uses the equivalent secp notation.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+A specific example is that Wo=
lfSSL expects P384_ML_KEM_1024, while OpenSSL expects secp384r1MLKEM1024.</=
span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_ope=
nssl.c</span><br><span>index 2fc77d8..4c11cd4 100644</span><br><span>--- a/=
src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</=
span><br><span>@@ -560,7 +560,7 @@</span><br><span> tls_ctx_set_tls_groups(=
struct tls_root_ctx *ctx, const char *groups)</span><br><span> {</span><br>=
<span>     ASSERT(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if OPENSSL_VERSION_NUMBER &lt; 0x30000000L</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &lt; 0x30000000L &amp;=
&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span>     struct gc_arena =
gc =3D gc_new();</span><br><span>     /* This method could be as easy as</s=
pan><br><span>      *  SSL_CTX_set1_groups_list(ctx-&gt;ctx, groups)</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1046?usp=3Demail">change 1046</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1046?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--1PWKSB0WInQ=--

