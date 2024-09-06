From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 6 Sep 2024 11:55:12 +0000
References: <gerrit.1725623710000.I37a3a316027197ab336f05a0ee674310fc3df57d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9c69a319f625bc0da974cfa599bef4076499f47c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LWBVfnT8lUg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto_openssl:
 Suppress deprecation warnings with OpenSSL 3 for GCC ...
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

--LWBVfnT8lUg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/735?usp=3Demail

to review the following change.


Change subject: crypto_openssl: Suppress deprecation warnings with OpenSSL =
3 for GCC as well
......................................................................

crypto_openssl: Suppress deprecation warnings with OpenSSL 3 for GCC as well

When a user explicitly wants to use OpenSSL engine support with
OpenSSL 3 (we will disable it by default), then allow them to use
-Werror.

We already had code for MSVC, add GCC as well.

Change-Id: I37a3a316027197ab336f05a0ee674310fc3df57d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 14 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/735/1

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index fbd38f3..295fd47 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -61,9 +61,14 @@
 #error Windows build with OPENSSL_NO_EC: disabling EC key is not supported.
 #endif

+#if HAVE_OPENSSL_ENGINE && OPENSSL_VERSION_NUMBER >=3D 0x30000000L
+/* mute ossl3 deprecation warnings */
 #ifdef _MSC_VER
-/* mute ossl3 deprecation warnings treated as errors in msvc */
 #pragma warning(disable: 4996)
+#else
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+#endif
 #endif

 /*
@@ -1454,4 +1459,12 @@
     return false;
 }
 #endif /* if LIBRESSL_VERSION_NUMBER */
+
+#if HAVE_OPENSSL_ENGINE && OPENSSL_VERSION_NUMBER >=3D 0x30000000L
+/* mute ossl3 deprecation warnings */
+#ifndef _MSC_VER
+#pragma GCC diagnostic pop
+#endif
+#endif
+
 #endif /* ENABLE_CRYPTO_OPENSSL */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/735?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I37a3a316027197ab336f05a0ee674310fc3df57d
Gerrit-Change-Number: 735
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--LWBVfnT8lUg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/735?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">crypto_openssl: Suppress deprecation warnings with OpenSSL 3 =
for GCC as well<br><br>When a user explicitly wants to use OpenSSL engine s=
upport with<br>OpenSSL 3 (we will disable it by default), then allow them t=
o use<br>-Werror.<br><br>We already had code for MSVC, add GCC as well.<br>=
<br>Change-Id: I37a3a316027197ab336f05a0ee674310fc3df57d<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/crypto_o=
penssl.c<br>1 file changed, 14 insertions(+), 1 deletion(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/735/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</spa=
n><br><span>index fbd38f3..295fd47 100644</span><br><span>--- a/src/openvpn=
/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.c</span>=
<br><span>@@ -61,9 +61,14 @@</span><br><span> #error Windows build with OPE=
NSSL_NO_EC: disabling EC key is not supported.</span><br><span> #endif</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if HA=
VE_OPENSSL_ENGINE &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* mute ossl3 deprecati=
on warnings */</span><br><span> #ifdef _MSC_VER</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/* mute ossl3 deprecation warnings treated as err=
ors in msvc */</span><br><span> #pragma warning(disable: 4996)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-=
Wdeprecated-declarations&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span> #endif</span><br><span> </span><br><span=
> /*</span><br><span>@@ -1454,4 +1459,12 @@</span><br><span>     return fal=
se;</span><br><span> }</span><br><span> #endif /* if LIBRESSL_VERSION_NUMBE=
R */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_OPENSSL_ENGINE &amp;&amp;=
 OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* mute ossl3 deprecation warnings */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifndef _MSC_VER</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> #endif /* ENABLE_CRYPTO_OPENSSL */</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/735?usp=3Demail">change 735</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/735?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I37a3a316027197ab336f05a0ee6=
74310fc3df57d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 735 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--LWBVfnT8lUg=--

