From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 17 Feb 2026 21:29:08 +0000
In-Reply-To: <gerrit.1771329387000.Ia5d330fe5c922aaa6948c1fb05c9a4947c833311@...2715...>
References: <gerrit.1771329387000.Ia5d330fe5c922aaa6948c1fb05c9a4947c833311@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <51cb3a447a57f1a94955de6a4d895fdca3d8de16-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AN5vauLhpWI="; charset=UTF-8
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
To: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AN5vauLhpWI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 MaxF. ( http://gerrit.openvpn.net/c/openvpn/+/1538?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Unbreak Mbed TLS 4 build
......................................................................

Unbreak Mbed TLS 4 build

The previous Mbed TLS 4 change removed the mbedtls/version.h include
from syshead.h. But this include in mbedtls_compat.h where it's needed.

Also fix a warning by removing a size_t < 0 comparison.

Change-Id: Ia5d330fe5c922aaa6948c1fb05c9a4947c833311
Signed-off-by: Max Fillinger <maximilian.fillinger@...2918...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1538
Message-Id: <20260217171306.31229-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
701.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_mbedtls.c
M src/openvpn/mbedtls_compat.h
2 files changed, 2 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1538/3

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia5d330fe5c922aaa6948c1fb05c9a4947c833311
Gerrit-Change-Number: 1538
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AN5vauLhpWI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by MaxF.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1538?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Unbreak Mbed TLS 4 build<br>=
<br>The previous Mbed TLS 4 change removed the mbedtls/version.h include<br=
>from syshead.h. But this include in mbedtls_compat.h where it&#39;s needed=
.<br><br>Also fix a warning by removing a size_t &lt; 0 comparison.<br><br>=
Change-Id: Ia5d330fe5c922aaa6948c1fb05c9a4947c833311<br>Signed-off-by: Max =
Fillinger &lt;maximilian.fillinger@...2918...&gt;<br>Acked-by: Frank Lichte=
nheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/=
openvpn/+/1538<br>Message-Id: &lt;20260217171306.31229-1-gert@...1296...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg35701.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M src/openvpn/crypto_mbedtls.c<br>M src/openvpn/mbedtls_compat.h<br>2 f=
iles changed, 2 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1538/3</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</=
span><br><span>index cba6bb5..e8931d7 100644</span><br><span>--- a/src/open=
vpn/crypto_mbedtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</sp=
an><br><span>@@ -700,7 +700,7 @@</span><br><span> md_full(const char *mdnam=
e, const uint8_t *src, size_t src_len, uint8_t *dst)</span><br><span> {</sp=
an><br><span>     const md_info_t *md =3D md_get(mdname);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (md =3D=3D NULL || src_len &lt; =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (md =3D=3D=
 NULL)</span><br><span>     {</span><br><span>         return false;</span>=
<br><span>     }</span><br><span>diff --git a/src/openvpn/mbedtls_compat.h =
b/src/openvpn/mbedtls_compat.h</span><br><span>index 667529e..50739b6 10064=
4</span><br><span>--- a/src/openvpn/mbedtls_compat.h</span><br><span>+++ b/=
src/openvpn/mbedtls_compat.h</span><br><span>@@ -36,6 +36,7 @@</span><br><s=
pan> </span><br><span> #include &lt;mbedtls/asn1.h&gt;</span><br><span> #in=
clude &lt;mbedtls/pk.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;mbedtls/version.h&gt;</span><br><span> </span><br><span=
> #if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span> #include &lt;=
mbedtls/ctr_drbg.h&gt;</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1538?usp=3Demail">change 15=
38</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1538?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia5d330fe5c922aaa6948c1fb05c=
9a4947c833311 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1538 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--AN5vauLhpWI=--

