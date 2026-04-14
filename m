From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 14 Apr 2026 16:43:31 +0000
In-Reply-To: <gerrit.1776081318000.I232fba91cfcca6c35d37696bc86890a366f5967f@...2715...>
References: <gerrit.1776081318000.I232fba91cfcca6c35d37696bc86890a366f5967f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b20db5d997681a7683af7906789a4607b889d09e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gDY6cg58jUg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gDY6cg58jUg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
26?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I232fba91cfcca6c35d37696bc86890a366f5967f
Gerrit-Change-Number: 1626
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gDY6cg58jUg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1626?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_mbedtls: Fix format string in get_ssl_librar=
y_version<br><br>These are unsigned values, so treat them as such.<br><br>I=
dentified by cppcheck.<br><br>Change-Id: I232fba91cfcca6c35d37696bc86890a36=
6f5967f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Ack=
ed-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://=
gerrit.openvpn.net/c/openvpn/+/1626<br>Message-Id: &lt;20260414055927.17252=
-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg36607.html<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M src/openvpn/ssl_mbedtls.c<br>1 file changed, 1 i=
nsertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span=
><br><span>index a62ff76..85c771a 100644</span><br><span>--- a/src/openvpn/=
ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><sp=
an>@@ -1572,7 +1572,7 @@</span><br><span> {</span><br><span>     static cha=
r mbedtls_version[30];</span><br><span>     unsigned int pv =3D mbedtls_ver=
sion_get_number();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 snprintf(mbedtls_version, sizeof(mbedtls_version), &quot;mbed TLS %d.%d.%d=
&quot;, (pv &gt;&gt; 24) &amp; 0xff,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    snprintf(mbedtls_version, sizeof(mbedtls_version), &qu=
ot;mbed TLS %u.%u.%u&quot;, (pv &gt;&gt; 24) &amp; 0xff,</span><br><span>  =
            (pv &gt;&gt; 16) &amp; 0xff, (pv &gt;&gt; 8) &amp; 0xff);</span=
><br><span>     return mbedtls_version;</span><br><span> }</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1626?usp=3Demail">change 1626</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1626?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--gDY6cg58jUg=--

