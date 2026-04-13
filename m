From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 13 Apr 2026 11:55:29 +0000
References: <gerrit.1776081318000.I232fba91cfcca6c35d37696bc86890a366f5967f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <769415911ec44a3bfc9bbd24a5db746e2f6d382a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m5z/IYRvfmA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_mbedtls: Fix
 format string in get_ssl_library_version
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

--m5z/IYRvfmA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1626?usp=3Demail

to review the following change.


Change subject: ssl_mbedtls: Fix format string in get_ssl_library_version
......................................................................

ssl_mbedtls: Fix format string in get_ssl_library_version

These are unsigned values, so treat them as such.

Identified by cppcheck.

Change-Id: I232fba91cfcca6c35d37696bc86890a366f5967f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1626/1

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a62ff76..85c771a 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1572,7 +1572,7 @@
 {
     static char mbedtls_version[30];
     unsigned int pv =3D mbedtls_version_get_number();
-    snprintf(mbedtls_version, sizeof(mbedtls_version), "mbed TLS %d.%d.%d"=
, (pv >> 24) & 0xff,
+    snprintf(mbedtls_version, sizeof(mbedtls_version), "mbed TLS %u.%u.%u"=
, (pv >> 24) & 0xff,
              (pv >> 16) & 0xff, (pv >> 8) & 0xff);
     return mbedtls_version;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1626?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I232fba91cfcca6c35d37696bc86890a366f5967f
Gerrit-Change-Number: 1626
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--m5z/IYRvfmA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1626?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl_mbedtls: Fix format string in get_ssl_l=
ibrary_version<br><br>These are unsigned values, so treat them as such.<br>=
<br>Identified by cppcheck.<br><br>Change-Id: I232fba91cfcca6c35d37696bc868=
90a366f5967f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>---<br>M src/openvpn/ssl_mbedtls.c<br>1 file changed, 1 insertion(+), 1 d=
eletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/26/1626/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_mbed=
tls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index a62ff76..85c771a 10=
0644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/=
src/openvpn/ssl_mbedtls.c</span><br><span>@@ -1572,7 +1572,7 @@</span><br><=
span> {</span><br><span>     static char mbedtls_version[30];</span><br><sp=
an>     unsigned int pv =3D mbedtls_version_get_number();</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    snprintf(mbedtls_version, sizeof(mb=
edtls_version), &quot;mbed TLS %d.%d.%d&quot;, (pv &gt;&gt; 24) &amp; 0xff,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(mbedtl=
s_version, sizeof(mbedtls_version), &quot;mbed TLS %u.%u.%u&quot;, (pv &gt;=
&gt; 24) &amp; 0xff,</span><br><span>              (pv &gt;&gt; 16) &amp; 0=
xff, (pv &gt;&gt; 8) &amp; 0xff);</span><br><span>     return mbedtls_versi=
on;</span><br><span> }</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1626?usp=3Demail">change 16=
26</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1626?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I232fba91cfcca6c35d37696bc86=
890a366f5967f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1626 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--m5z/IYRvfmA=--

