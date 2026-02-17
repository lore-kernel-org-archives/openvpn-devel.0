From: "MaxF (Code Review)" <gerrit@...515...>
Date: Tue, 17 Feb 2026 11:56:29 +0000
References: <gerrit.1771329387000.Ia5d330fe5c922aaa6948c1fb05c9a4947c833311@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e8868578fd0bb7df93ab5d97ca596831f7ff3fb4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dw7U1h9Ap34="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Unbreak Mbed TLS 4
 build
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

--dw7U1h9Ap34=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1538?usp=3Demail

to review the following change.


Change subject: Unbreak Mbed TLS 4 build
......................................................................

Unbreak Mbed TLS 4 build

The previous Mbed TLS 4 change removed the mbedtls/version.h include
from syshead.h. But this include in mbedtls_compat.h where it's needed.

Also fix a warning by removing a size_t < 0 comparison.

Change-Id: Ia5d330fe5c922aaa6948c1fb05c9a4947c833311
---
M src/openvpn/crypto_mbedtls.c
M src/openvpn/mbedtls_compat.h
2 files changed, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1538/1

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index cba6bb5..e8931d7 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -700,7 +700,7 @@
 md_full(const char *mdname, const uint8_t *src, size_t src_len, uint8_t *d=
st)
 {
     const md_info_t *md =3D md_get(mdname);
-    if (md =3D=3D NULL || src_len < 0)
+    if (md =3D=3D NULL)
     {
         return false;
     }
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 667529e..50739b6 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -36,6 +36,7 @@

 #include <mbedtls/asn1.h>
 #include <mbedtls/pk.h>
+#include <mbedtls/version.h>

 #if MBEDTLS_VERSION_NUMBER < 0x04000000
 #include <mbedtls/ctr_drbg.h>

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1538?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia5d330fe5c922aaa6948c1fb05c9a4947c833311
Gerrit-Change-Number: 1538
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--dw7U1h9Ap34=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>MaxF would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1538?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Unbreak Mbed TLS 4 build<br><br>The previou=
s Mbed TLS 4 change removed the mbedtls/version.h include<br>from syshead.h=
. But this include in mbedtls_compat.h where it&#39;s needed.<br><br>Also f=
ix a warning by removing a size_t &lt; 0 comparison.<br><br>Change-Id: Ia5d=
330fe5c922aaa6948c1fb05c9a4947c833311<br>---<br>M src/openvpn/crypto_mbedtl=
s.c<br>M src/openvpn/mbedtls_compat.h<br>2 files changed, 2 insertions(+), =
1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/38/1538/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypt=
o_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index cba6bb5..e=
8931d7 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br>=
<span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -700,7 +700,7 @=
@</span><br><span> md_full(const char *mdname, const uint8_t *src, size_t s=
rc_len, uint8_t *dst)</span><br><span> {</span><br><span>     const md_info=
_t *md =3D md_get(mdname);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (md =3D=3D NULL || src_len &lt; 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (md =3D=3D NULL)</span><br><span>     {</=
span><br><span>         return false;</span><br><span>     }</span><br><spa=
n>diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h<=
/span><br><span>index 667529e..50739b6 100644</span><br><span>--- a/src/ope=
nvpn/mbedtls_compat.h</span><br><span>+++ b/src/openvpn/mbedtls_compat.h</s=
pan><br><span>@@ -36,6 +36,7 @@</span><br><span> </span><br><span> #include=
 &lt;mbedtls/asn1.h&gt;</span><br><span> #include &lt;mbedtls/pk.h&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/ver=
sion.h&gt;</span><br><span> </span><br><span> #if MBEDTLS_VERSION_NUMBER &l=
t; 0x04000000</span><br><span> #include &lt;mbedtls/ctr_drbg.h&gt;</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1538?usp=3Demail">change 1538</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1538?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia5d330fe5c922aaa6948c1fb05c=
9a4947c833311 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1538 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--dw7U1h9Ap34=--

