From: "comododragon (Code Review)" <gerrit@...515...>
Date: Wed, 18 Jun 2025 08:27:39 +0000
References: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
Reply-To: rein.vanbaaren@...1435..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b11e869378c37bf3fe90f15e4587408cbf33c2bd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tFOjIir21tU="; charset=UTF-8
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

--tFOjIir21tU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail

to review the following change.


Change subject: Added PQE to WolfSSL
......................................................................

Added PQE to WolfSSL

Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
---
M README.wolfssl
M src/openvpn/ssl_openssl.c
A src/openvpn/wolfssl_compat.h
3 files changed, 92 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1046/1

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
index 2fc77d8..29aa502 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -76,6 +76,8 @@
 #include <openssl/applink.c>
 #endif

+#include "wolfssl_compat.h"
+
 OSSL_LIB_CTX *tls_libctx; /* Global */

 static void unload_xkey_provider(void);
@@ -588,7 +590,12 @@
         {
             token =3D "prime256v1";
         }
+
+#ifdef ENABLE_CRYPTO_WOLFSSL
+        int nid =3D wolfssl_OBJ_sn2nid(token);
+#else
         int nid =3D OBJ_sn2nid(token);
+#endif

         if (nid =3D=3D 0)
         {
diff --git a/src/openvpn/wolfssl_compat.h b/src/openvpn/wolfssl_compat.h
new file mode 100644
index 0000000..a25e5c3
--- /dev/null
+++ b/src/openvpn/wolfssl_compat.h
@@ -0,0 +1,48 @@
+#pragma once
+
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2023 Fox Crypto B.V. <openvpn@...2507...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/**
+ * @file
+ * wolfssl compatibility stub.
+ * This file provide compatibility stubs for the wolfssl libraries
+ */
+
+#ifdef ENABLE_CRYPTO_WOLFSSL
+
+int
+wolfssl_OBJ_sn2nid(const char *sn)
+{
+
+	int nid =3D OBJ_sn2nid(sn);
+
+	if (nid =3D=3D WC_NID_undef)
+	{
+		return wolfSSL_EC_curve_nist2nid(sn);
+	}
+
+	return WC_NID_undef;
+}
+
+#endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
Gerrit-Change-Number: 1046
Gerrit-PatchSet: 1
Gerrit-Owner: comododragon <rein.vanbaaren@...1435...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--tFOjIir21tU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>comododragon would like plaisthos and flichtenheld to <strong>review</st=
rong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Added PQE to WolfSSL<br><br>Change-Id: Ie0529c2074964b3be034=
f01e0ef53090a6edbd35<br>---<br>M README.wolfssl<br>M src/openvpn/ssl_openss=
l.c<br>A src/openvpn/wolfssl_compat.h<br>3 files changed, 92 insertions(+),=
 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/46/1046/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/README.wolfssl b/README.wolfssl<=
/span><br><span>index a5dfe31..27b9087 100644</span><br><span>--- a/README.=
wolfssl</span><br><span>+++ b/README.wolfssl</span><br><span>@@ -28,3 +28,4=
0 @@</span><br><span>  * blowfish support (BF-CBC), you must use something =
like</span><br><span>    cipher AES-128-CBC to avoid trying to use BF-CBC</=
span><br><span>  * Windows CryptoAPI support</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+*********************************************************************=
****</span><br><span style=3D"color: hsl(120, 100%, 40%);">+To build WolfSS=
L with these PQE, you&#39;ll want to configure it like this:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+```bash</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+./configure --enable-openvpn --enable-kyber --enable-mlkem --enab=
le-curve25519</span><br><span style=3D"color: hsl(120, 100%, 40%);">+```</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+WolfSSL supports the following Quantum Sa=
fe algorithms by specifying them using the `tls-groups` </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+option in a config.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+```</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ML_KEM_512</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ML_KEM_=
768</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ML_KEM_1024</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+P256_ML_KEM_512</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+P384_ML_KEM_768</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+P256_ML_KEM_768</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+P521_ML_KEM_1024</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+P384_ML_KEM_1024</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+X25519_ML_KEM_512</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+X448_ML_KEM_768</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+X25519_ML_KEM_768</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+KYBER_LEVEL1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+KYBER_LEVEL3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+KYBER=
_LEVEL5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+P256_KYBER_LEVEL1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+P384_KYBER_LEVEL3</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+P256_KYBER_LEVEL3</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+P521_KYBER_LEVEL5</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+X25519_KYBER_LEVEL1</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+X448_KYBER_LEVEL3</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+X25519_KYBER_LEVEL3</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+```</span><br><span>diff --git a/src/openvpn/ssl_openssl.c b=
/src/openvpn/ssl_openssl.c</span><br><span>index 2fc77d8..29aa502 100644</s=
pan><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/ope=
nvpn/ssl_openssl.c</span><br><span>@@ -76,6 +76,8 @@</span><br><span> #incl=
ude &lt;openssl/applink.c&gt;</span><br><span> #endif</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;wolfssl_=
compat.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> OSSL_LIB_CTX *tls_libctx; /* Global */</span><br><span> </span=
><br><span> static void unload_xkey_provider(void);</span><br><span>@@ -588=
,7 +590,12 @@</span><br><span>         {</span><br><span>             token=
 =3D &quot;prime256v1&quot;;</span><br><span>         }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef ENABLE_CRYPTO_WOLFSSL</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        int nid =3D wolfssl_OBJ_sn2nid(token);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span>=
         int nid =3D OBJ_sn2nid(token);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>         if (n=
id =3D=3D 0)</span><br><span>         {</span><br><span>diff --git a/src/op=
envpn/wolfssl_compat.h b/src/openvpn/wolfssl_compat.h</span><br><span>new f=
ile mode 100644</span><br><span>index 0000000..a25e5c3</span><br><span>--- =
/dev/null</span><br><span>+++ b/src/openvpn/wolfssl_compat.h</span><br><spa=
n>@@ -0,0 +1,48 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma once</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tu=
nnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            over a single TCP/UDP port, with support for SSL/TLS-based</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session a=
uthentication and key exchange,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet encryption, packet authentication, and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023 F=
ox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  This program is free software; you can redistribute it and/or modi=
fy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the =
terms of the GNU General Public License version 2</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundat=
ion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed =
in the hope that it will be useful,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warr=
anty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANT=
ABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more d=
etails.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received =
a copy of the GNU General Public License along</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  with this program; if not, write to the Free=
 Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wolfssl=
 compatibility stub.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * This file provide compatibility stubs for the wolfssl libraries</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef ENABLE_CRYPTO_WOLFSSL</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wolfssl_OBJ=
_sn2nid(const char *sn)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	int nid =3D OBJ_sn2nid(sn);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	if (nid =3D=3D WC_NID_undef)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+		return wolfSSL_EC_curve_nist2nid(sn);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	return WC_NID_undef;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1046?usp=3Demail">change 1046</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef=
53090a6edbd35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: comododragon &lt;rein.vanbaaren@=
...1435...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--tFOjIir21tU=--

