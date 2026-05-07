From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 7 May 2026 08:48:13 +0000
In-Reply-To: <gerrit.1778018195000.Ia7ad24181bd97dccbb77865c10e829778f72a506@...2715...>
References: <gerrit.1778018195000.Ia7ad24181bd97dccbb77865c10e829778f72a506@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1dd8b61361ec20cdb8ba25f266d3b5bb89b85945-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qSplACtaQMM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: sample: Fix
 cppcheck error invalidPrintfArgType_sint
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

--qSplACtaQMM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
62?usp=3Demail )

Change subject: sample: Fix cppcheck error invalidPrintfArgType_sint
......................................................................

sample: Fix cppcheck error invalidPrintfArgType_sint

Change-Id: Ia7ad24181bd97dccbb77865c10e829778f72a506
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1662
Message-Id: <20260507075502.25473-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
844.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M sample/sample-plugins/log/log_v3.c
M sample/sample-plugins/simple/base64.c
2 files changed, 2 insertions(+), 2 deletions(-)




diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log=
/log_v3.c
index deae590..d2d44c7 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -91,7 +91,7 @@
     }

     /* Print some version information about the OpenVPN process using this=
 plug-in */
-    printf("log_v3: OpenVPN %s  (Major: %i, Minor: %i, Patch: %s)\n", args=
->ovpn_version,
+    printf("log_v3: OpenVPN %s  (Major: %u, Minor: %u, Patch: %s)\n", args=
->ovpn_version,
            args->ovpn_version_major, args->ovpn_version_minor, args->ovpn_=
version_patch);

     /*  Which callbacks to intercept.  */
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/=
simple/base64.c
index ab6aed8..3b11543 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -122,7 +122,7 @@
     ovpn_base64_decode =3D args->callbacks->plugin_base64_decode;

     /* Print some version information about the OpenVPN process using this=
 plug-in */
-    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OpenVPN %s  (Major: %i, Minor: %i, P=
atch: %s)\n",
+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, "OpenVPN %s  (Major: %u, Minor: %u, P=
atch: %s)\n",
              args->ovpn_version, args->ovpn_version_major, args->ovpn_vers=
ion_minor,
              args->ovpn_version_patch);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1662?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia7ad24181bd97dccbb77865c10e829778f72a506
Gerrit-Change-Number: 1662
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qSplACtaQMM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1662?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">sample: Fix cppcheck error invalidPrintfArgType_=
sint<br><br>Change-Id: Ia7ad24181bd97dccbb77865c10e829778f72a506<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openv=
pn/+/1662<br>Message-Id: &lt;20260507075502.25473-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
844.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 sample/sample-plugins/log/log_v3.c<br>M sample/sample-plugins/simple/base6=
4.c<br>2 files changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/=
log/log_v3.c</span><br><span>index deae590..d2d44c7 100644</span><br><span>=
--- a/sample/sample-plugins/log/log_v3.c</span><br><span>+++ b/sample/sampl=
e-plugins/log/log_v3.c</span><br><span>@@ -91,7 +91,7 @@</span><br><span>  =
   }</span><br><span> </span><br><span>     /* Print some version informati=
on about the OpenVPN process using this plug-in */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    printf(&quot;log_v3: OpenVPN %s  (Major: %=
i, Minor: %i, Patch: %s)\n&quot;, args-&gt;ovpn_version,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;log_v3: OpenVPN %s  (=
Major: %u, Minor: %u, Patch: %s)\n&quot;, args-&gt;ovpn_version,</span><br>=
<span>            args-&gt;ovpn_version_major, args-&gt;ovpn_version_minor,=
 args-&gt;ovpn_version_patch);</span><br><span> </span><br><span>     /*  W=
hich callbacks to intercept.  */</span><br><span>diff --git a/sample/sample=
-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c</span><br>=
<span>index ab6aed8..3b11543 100644</span><br><span>--- a/sample/sample-plu=
gins/simple/base64.c</span><br><span>+++ b/sample/sample-plugins/simple/bas=
e64.c</span><br><span>@@ -122,7 +122,7 @@</span><br><span>     ovpn_base64_=
decode =3D args-&gt;callbacks-&gt;plugin_base64_decode;</span><br><span> </=
span><br><span>     /* Print some version information about the OpenVPN pro=
cess using this plug-in */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    ovpn_log(PLOG_NOTE, PLUGIN_NAME, &quot;OpenVPN %s  (Major: %i, Min=
or: %i, Patch: %s)\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, &quot;OpenVPN %s  (Major: %u, =
Minor: %u, Patch: %s)\n&quot;,</span><br><span>              args-&gt;ovpn_=
version, args-&gt;ovpn_version_major, args-&gt;ovpn_version_minor,</span><b=
r><span>              args-&gt;ovpn_version_patch);</span><br><span> </span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1662?usp=3Demail">change 1662</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1662?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia7ad24181bd97dccbb77865c10e=
829778f72a506 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1662 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--qSplACtaQMM=--

