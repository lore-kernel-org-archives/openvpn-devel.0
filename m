From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 7 May 2026 08:48:11 +0000
In-Reply-To: <gerrit.1778018195000.Ia7ad24181bd97dccbb77865c10e829778f72a506@...2715...>
References: <gerrit.1778018195000.Ia7ad24181bd97dccbb77865c10e829778f72a506@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1dd8b61361ec20cdb8ba25f266d3b5bb89b85945-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2EfNdRrN5cw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2EfNdRrN5cw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1662?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/1662/3

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia7ad24181bd97dccbb77865c10e829778f72a506
Gerrit-Change-Number: 1662
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2EfNdRrN5cw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1662?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">sample: Fix cppcheck error invalidP=
rintfArgType_sint<br><br>Change-Id: Ia7ad24181bd97dccbb77865c10e829778f72a5=
06<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by=
: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvp=
n.net/c/openvpn/+/1662<br>Message-Id: &lt;20260507075502.25473-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg36844.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M sample/sample-plugins/log/log_v3.c<br>M sample/sample-plugins=
/simple/base64.c<br>2 files changed, 2 insertions(+), 2 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/62/1662/3</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/sample/sample-plugins/log/log_v3.c b/=
sample/sample-plugins/log/log_v3.c</span><br><span>index deae590..d2d44c7 1=
00644</span><br><span>--- a/sample/sample-plugins/log/log_v3.c</span><br><s=
pan>+++ b/sample/sample-plugins/log/log_v3.c</span><br><span>@@ -91,7 +91,7=
 @@</span><br><span>     }</span><br><span> </span><br><span>     /* Print =
some version information about the OpenVPN process using this plug-in */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;log_v3:=
 OpenVPN %s  (Major: %i, Minor: %i, Patch: %s)\n&quot;, args-&gt;ovpn_versi=
on,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot=
;log_v3: OpenVPN %s  (Major: %u, Minor: %u, Patch: %s)\n&quot;, args-&gt;ov=
pn_version,</span><br><span>            args-&gt;ovpn_version_major, args-&=
gt;ovpn_version_minor, args-&gt;ovpn_version_patch);</span><br><span> </spa=
n><br><span>     /*  Which callbacks to intercept.  */</span><br><span>diff=
 --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simp=
le/base64.c</span><br><span>index ab6aed8..3b11543 100644</span><br><span>-=
-- a/sample/sample-plugins/simple/base64.c</span><br><span>+++ b/sample/sam=
ple-plugins/simple/base64.c</span><br><span>@@ -122,7 +122,7 @@</span><br><=
span>     ovpn_base64_decode =3D args-&gt;callbacks-&gt;plugin_base64_decod=
e;</span><br><span> </span><br><span>     /* Print some version information=
 about the OpenVPN process using this plug-in */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ovpn_log(PLOG_NOTE, PLUGIN_NAME, &quot;OpenV=
PN %s  (Major: %i, Minor: %i, Patch: %s)\n&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, &quot;Op=
enVPN %s  (Major: %u, Minor: %u, Patch: %s)\n&quot;,</span><br><span>      =
        args-&gt;ovpn_version, args-&gt;ovpn_version_major, args-&gt;ovpn_v=
ersion_minor,</span><br><span>              args-&gt;ovpn_version_patch);</=
span><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1662?usp=3Demail">change 1662</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1662?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--2EfNdRrN5cw=--

