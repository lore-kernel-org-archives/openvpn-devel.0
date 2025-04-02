From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 2 Apr 2025 18:36:43 +0000
In-Reply-To: <gerrit.1743591174000.I3434c35da75ede90a1b479b152142142ecc2fd40@...2715...>
References: <gerrit.1743591174000.I3434c35da75ede90a1b479b152142142ecc2fd40@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7a3312c2fc108213a6ee2b1b2a44401f76ffdad7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DCXOBC7daKQ="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DCXOBC7daKQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/932?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/932/2

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
Gerrit-MessageType: newpatchset

--DCXOBC7daKQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/932?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">GHA: Make sure renovate notifies us about AWS LC rel=
eases<br><br>Change-Id: I3434c35da75ede90a1b479b152142142ecc2fd40<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250402153701.7560-1-gert@...1186...=
.1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg31328.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 1 insertio=
n(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/32/932/2</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml=
 b/.github/workflows/build.yaml</span><br><span>index 5e8e15d..2df495c 1006=
44</span><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b=
/.github/workflows/build.yaml</span><br><span>@@ -469,6 +469,7 @@</span><br=
><span>         uses: actions/checkout@...2844... # v4.2.2</span><br><span>=
         with:</span><br><span>           path: aws-lc</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+          # versioning=3Dsemver-coerced<=
/span><br><span>           repository: aws/aws-lc</span><br><span>         =
  ref: v1.42.0</span><br><span>       - uses: lukka/get-cmake@...2870... # =
v3.31.6</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/932?usp=3Demail">change 932</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/932?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--DCXOBC7daKQ=--

