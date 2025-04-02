From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 2 Apr 2025 18:36:45 +0000
In-Reply-To: <gerrit.1743591174000.I3434c35da75ede90a1b479b152142142ecc2fd40@...2715...>
References: <gerrit.1743591174000.I3434c35da75ede90a1b479b152142142ecc2fd40@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7a3312c2fc108213a6ee2b1b2a44401f76ffdad7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Wrhz4IvH+Hw="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Make sure
 renovate notifies us about AWS LC releases
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

--Wrhz4IvH+Hw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/93=
2?usp=3Demail )

Change subject: GHA: Make sure renovate notifies us about AWS LC releases
......................................................................

GHA: Make sure renovate notifies us about AWS LC releases

Change-Id: I3434c35da75ede90a1b479b152142142ecc2fd40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250402153701.7560-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
328.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 1 insertion(+), 0 deletions(-)




diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 5e8e15d..2df495c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -469,6 +469,7 @@
         uses: actions/checkout@...2844... # v4.2.2
         with:
           path: aws-lc
+          # versioning=3Dsemver-coerced
           repository: aws/aws-lc
           ref: v1.42.0
       - uses: lukka/get-cmake@...2870... # v3.31.6

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/932?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3434c35da75ede90a1b479b152142142ecc2fd40
Gerrit-Change-Number: 932
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Wrhz4IvH+Hw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/932?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">GHA: Make sure renovate notifies us about AWS =
LC releases<br><br>Change-Id: I3434c35da75ede90a1b479b152142142ecc2fd40<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250402153701.7560-1-g=
ert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg31328.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 1 in=
sertion(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 5e8e15d..2df495c 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -469,6 +469,7 @@</span><br><span>         uses: actions/c=
heckout@...2844... # v4.2.2</span><br><span>         with:</span><br><span>=
           path: aws-lc</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+          # versioning=3Dsemver-coerced</span><br><span>           repo=
sitory: aws/aws-lc</span><br><span>           ref: v1.42.0</span><br><span>=
       - uses: lukka/get-cmake@...2870... # v3.31.6</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/932?usp=3Demail">change 932</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/932?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3434c35da75ede90a1b479b1521=
42142ecc2fd40 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 932 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Wrhz4IvH+Hw=--

