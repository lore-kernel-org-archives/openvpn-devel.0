From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 5 May 2026 21:56:37 +0000
References: <gerrit.1778018195000.Ia7ad24181bd97dccbb77865c10e829778f72a506@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0d726fca617b49a6a853de1e8c94bdf3c912b327-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sbLcXxs2hSQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sbLcXxs2hSQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1662?usp=3Demail

to review the following change.


Change subject: sample: Fix cppcheck error invalidPrintfArgType_sint
......................................................................

sample: Fix cppcheck error invalidPrintfArgType_sint

Change-Id: Ia7ad24181bd97dccbb77865c10e829778f72a506
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M sample/sample-plugins/log/log_v3.c
M sample/sample-plugins/simple/base64.c
2 files changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/1662/1

diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log=
/log_v3.c
index fae7bc4..09c6735 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia7ad24181bd97dccbb77865c10e829778f72a506
Gerrit-Change-Number: 1662
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--sbLcXxs2hSQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1662?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">sample: Fix cppcheck error invalidPrintfArg=
Type_sint<br><br>Change-Id: Ia7ad24181bd97dccbb77865c10e829778f72a506<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M sample/=
sample-plugins/log/log_v3.c<br>M sample/sample-plugins/simple/base64.c<br>2=
 files changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/1662/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins=
/log/log_v3.c</span><br><span>index fae7bc4..09c6735 100644</span><br><span=
>--- a/sample/sample-plugins/log/log_v3.c</span><br><span>+++ b/sample/samp=
le-plugins/log/log_v3.c</span><br><span>@@ -91,7 +91,7 @@</span><br><span> =
    }</span><br><span> </span><br><span>     /* Print some version informat=
ion about the OpenVPN process using this plug-in */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;log_v3: OpenVPN %s  (Major=
: %i, Minor: %i, Patch: %s)\n&quot;, args-&gt;ovpn_version,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;log_v3: OpenVPN %s=
  (Major: %u, Minor: %u, Patch: %s)\n&quot;, args-&gt;ovpn_version,</span><=
br><span>            args-&gt;ovpn_version_major, args-&gt;ovpn_version_min=
or, args-&gt;ovpn_version_patch);</span><br><span> </span><br><span>     /*=
  Which callbacks to intercept.  */</span><br><span>diff --git a/sample/sam=
ple-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c</span><=
br><span>index ab6aed8..3b11543 100644</span><br><span>--- a/sample/sample-=
plugins/simple/base64.c</span><br><span>+++ b/sample/sample-plugins/simple/=
base64.c</span><br><span>@@ -122,7 +122,7 @@</span><br><span>     ovpn_base=
64_decode =3D args-&gt;callbacks-&gt;plugin_base64_decode;</span><br><span>=
 </span><br><span>     /* Print some version information about the OpenVPN =
process using this plug-in */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ovpn_log(PLOG_NOTE, PLUGIN_NAME, &quot;OpenVPN %s  (Major: %i, =
Minor: %i, Patch: %s)\n&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ovpn_log(PLOG_NOTE, PLUGIN_NAME, &quot;OpenVPN %s  (Major: %=
u, Minor: %u, Patch: %s)\n&quot;,</span><br><span>              args-&gt;ov=
pn_version, args-&gt;ovpn_version_major, args-&gt;ovpn_version_minor,</span=
><br><span>              args-&gt;ovpn_version_patch);</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1662?usp=3Demail">change 1662</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1662?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia7ad24181bd97dccbb77865c10e=
829778f72a506 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1662 </div>
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

--sbLcXxs2hSQ=--

