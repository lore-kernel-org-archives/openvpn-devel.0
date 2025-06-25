From: "comododragon (Code Review)" <gerrit@...515...>
Date: Wed, 25 Jun 2025 11:23:47 +0000
In-Reply-To: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
References: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
Reply-To: rein.vanbaaren@...1435..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <3efe0485c9b6b744a3673813133624c64797e4c2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yIYf/zn8VDo="; charset=UTF-8
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

--yIYf/zn8VDo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: comododragon, cron2, flichtenheld.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: Added PQE to WolfSSL
......................................................................

Added PQE to WolfSSL

Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
---
M README.wolfssl
M src/openvpn/ssl_openssl.c
2 files changed, 25 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1046/4

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
index 2fc77d8..ec5419c 100644
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
@@ -608,6 +608,7 @@
     }
     gc_free(&gc);
 #else  /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
+    msg(M_WARN, "Hells yeah");
     if (!SSL_CTX_set1_groups_list(ctx->ctx, groups))
     {
         crypto_msg(M_FATAL, "Failed to set allowed TLS group list: %s",

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
Gerrit-Change-Number: 1046
Gerrit-PatchSet: 4
Gerrit-Owner: comododragon <rein.vanbaaren@...1435...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: comododragon <rein.vanbaaren@...1435...>
Gerrit-MessageType: newpatchset

--yIYf/zn8VDo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: comododragon, cron2, flichtenheld=
. </p>
<p>comododragon <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Added PQE to WolfSSL<br><br>Change-Id: Ie0529c207496=
4b3be034f01e0ef53090a6edbd35<br>---<br>M README.wolfssl<br>M src/openvpn/ss=
l_openssl.c<br>2 files changed, 25 insertions(+), 1 deletion(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1046/4</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/README.wolfssl b/README.wolfssl</span><br><span>index a5dfe=
31..46b080c 100644</span><br><span>--- a/README.wolfssl</span><br><span>+++=
 b/README.wolfssl</span><br><span>@@ -28,3 +28,26 @@</span><br><span>  * bl=
owfish support (BF-CBC), you must use something like</span><br><span>    ci=
pher AES-128-CBC to avoid trying to use BF-CBC</span><br><span>  * Windows =
CryptoAPI support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+*********************=
****************************************************</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+To build WolfSSL with support for post-qu=
antum KEMs, the following command is used:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+./configure --enable-openvpn --enable-kyber=3Dall --enable-curve25519</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+WolfSSL supports the following post-quan=
tum KEMs or post-quantum hybrid KEMs by specifying them using the `tls-grou=
ps` </span><br><span style=3D"color: hsl(120, 100%, 40%);">+option in an Op=
enVPN config.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ML_KEM_512</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ML_KEM_768</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ML_KEM_1024</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+P256_ML_KEM_512</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+X25519_ML_KEM_512</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+P384_ML_KEM_768</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+P256_ML_KEM_768</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+X448_ML_KEM_768</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+X25519_ML_KEM_768</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+P384_ML_KEM_1024</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+P521_ML_KEM_1024</span><br><span>diff --git a/src/open=
vpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 2fc77d8=
..ec5419c 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br>=
<span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -560,7 +560,7 @@</=
span><br><span> tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char=
 *groups)</span><br><span> {</span><br><span>     ASSERT(ctx);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x=
30000000L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSS=
L_VERSION_NUMBER &lt; 0x30000000L &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL=
)</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>   =
  /* This method could be as easy as</span><br><span>      *  SSL_CTX_set1_=
groups_list(ctx-&gt;ctx, groups)</span><br><span>@@ -608,6 +608,7 @@</span>=
<br><span>     }</span><br><span>     gc_free(&amp;gc);</span><br><span> #e=
lse  /* if OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(M_WARN, &quot;Hells yeah&quot;);<=
/span><br><span>     if (!SSL_CTX_set1_groups_list(ctx-&gt;ctx, groups))</s=
pan><br><span>     {</span><br><span>         crypto_msg(M_FATAL, &quot;Fai=
led to set allowed TLS group list: %s&quot;,</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?=
usp=3Demail">change 1046</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef=
53090a6edbd35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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


--yIYf/zn8VDo=--

