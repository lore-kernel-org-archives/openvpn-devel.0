From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 14 Apr 2026 16:43:29 +0000
In-Reply-To: <gerrit.1776081318000.I232fba91cfcca6c35d37696bc86890a366f5967f@...2715...>
References: <gerrit.1776081318000.I232fba91cfcca6c35d37696bc86890a366f5967f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b20db5d997681a7683af7906789a4607b889d09e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yuW+LYiWxfw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yuW+LYiWxfw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1626?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: ssl_mbedtls: Fix format string in get_ssl_library_version
......................................................................

ssl_mbedtls: Fix format string in get_ssl_library_version

These are unsigned values, so treat them as such.

Identified by cppcheck.

Change-Id: I232fba91cfcca6c35d37696bc86890a366f5967f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1626
Message-Id: <20260414055927.17252-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
607.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1626/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I232fba91cfcca6c35d37696bc86890a366f5967f
Gerrit-Change-Number: 1626
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yuW+LYiWxfw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1626?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">ssl_mbedtls: Fix format string =
in get_ssl_library_version<br><br>These are unsigned values, so treat them =
as such.<br><br>Identified by cppcheck.<br><br>Change-Id: I232fba91cfcca6c3=
5d37696bc86890a366f5967f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Ger=
rit URL: https://gerrit.openvpn.net/c/openvpn/+/1626<br>Message-Id: &lt;202=
60414055927.17252-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.co=
m/openvpn-devel@lists.sourceforge.net/msg36607.html<br>Signed-off-by: Gert =
Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_mbedtls.c<br>1 =
file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/1626/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><b=
r><span>index a62ff76..85c771a 100644</span><br><span>--- a/src/openvpn/ssl=
_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>=
@@ -1572,7 +1572,7 @@</span><br><span> {</span><br><span>     static char m=
bedtls_version[30];</span><br><span>     unsigned int pv =3D mbedtls_versio=
n_get_number();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sn=
printf(mbedtls_version, sizeof(mbedtls_version), &quot;mbed TLS %d.%d.%d&qu=
ot;, (pv &gt;&gt; 24) &amp; 0xff,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    snprintf(mbedtls_version, sizeof(mbedtls_version), &quot;=
mbed TLS %u.%u.%u&quot;, (pv &gt;&gt; 24) &amp; 0xff,</span><br><span>     =
         (pv &gt;&gt; 16) &amp; 0xff, (pv &gt;&gt; 8) &amp; 0xff);</span><b=
r><span>     return mbedtls_version;</span><br><span> }</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1626?usp=3Demail">change 1626</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1626?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I232fba91cfcca6c35d37696bc86=
890a366f5967f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1626 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--yuW+LYiWxfw=--

