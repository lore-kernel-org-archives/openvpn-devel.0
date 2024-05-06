From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 6 May 2024 16:02:17 +0000
In-Reply-To: <gerrit.1714664981000.Id95e0124d943912439c6ec6f562c0eb40d434163@...2715...>
References: <gerrit.1714664981000.Id95e0124d943912439c6ec6f562c0eb40d434163@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4517b85de04604130b7a418688241a3f4a21fd2b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DIIraRfaThQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Only run coverity
 scan in OpenVPN/OpenVPN repository
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DIIraRfaThQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/58=
3?usp=3Demail )

Change subject: Only run coverity scan in OpenVPN/OpenVPN repository
......................................................................

Only run coverity scan in OpenVPN/OpenVPN repository

This avoids the error message triggering every night that the run
failed in forked repositories

Change-Id: Id95e0124d943912439c6ec6f562c0eb40d434163
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240506155831.3524-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
627.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/coverity-scan.yml
1 file changed, 3 insertions(+), 0 deletions(-)




diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/coveri=
ty-scan.yml
index e289746..37b8102 100644
--- a/.github/workflows/coverity-scan.yml
+++ b/.github/workflows/coverity-scan.yml
@@ -6,6 +6,9 @@

 jobs:
   latest:
+    # Running coverity requires the secrets.COVERITY_SCAN_TOKEN token
+    # which is only available on the main repository
+    if: github.repository_owner =3D=3D 'OpenVPN'
     runs-on: ubuntu-latest
     steps:
       - name: Check submission cache

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/583?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id95e0124d943912439c6ec6f562c0eb40d434163
Gerrit-Change-Number: 583
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--DIIraRfaThQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/583?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Only run coverity scan in OpenVPN/OpenVPN repo=
sitory<br><br>This avoids the error message triggering every night that the=
 run<br>failed in forked repositories<br><br>Change-Id: Id95e0124d943912439=
c6ec6f562c0eb40d434163<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&g=
t;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &=
lt;20240506155831.3524-1-gert@...1296...&gt;<br>URL: https://www.mail-archi=
ve.com/openvpn-devel@lists.sourceforge.net/msg28627.html<br>Signed-off-by: =
Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/coverity=
-scan.yml<br>1 file changed, 3 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/coverity-scan.yml b/.github/workflows/cov=
erity-scan.yml</span><br><span>index e289746..37b8102 100644</span><br><spa=
n>--- a/.github/workflows/coverity-scan.yml</span><br><span>+++ b/.github/w=
orkflows/coverity-scan.yml</span><br><span>@@ -6,6 +6,9 @@</span><br><span>=
 </span><br><span> jobs:</span><br><span>   latest:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # Running coverity requires the secre=
ts.COVERITY_SCAN_TOKEN token</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    # which is only available on the main repository</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if: github.repository_owner =
=3D=3D &#39;OpenVPN&#39;</span><br><span>     runs-on: ubuntu-latest</span>=
<br><span>     steps:</span><br><span>       - name: Check submission cache=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/583?usp=3Demail">change 583</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/583?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id95e0124d943912439c6ec6f562=
c0eb40d434163 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 583 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--DIIraRfaThQ=--

