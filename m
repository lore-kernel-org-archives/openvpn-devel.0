From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 5 Aug 2025 15:08:45 +0000
In-Reply-To: <gerrit.1754396906000.I729ee240e107a629ada5fab6b2ed2399e864cbd0@...2715...>
References: <gerrit.1754396906000.I729ee240e107a629ada5fab6b2ed2399e864cbd0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2d06db8071c1a7c53dec1f3f4ab7e4ebef1f7794-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k0gpc4ty5NA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add clang-format
 reformat commit to .git-blame-ignore-revs
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

--k0gpc4ty5NA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1130?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Add clang-format reformat commit to .git-blame-ignore-revs
......................................................................

Add clang-format reformat commit to .git-blame-ignore-revs

Change-Id: I729ee240e107a629ada5fab6b2ed2399e864cbd0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250805150503.11391-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
528.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .git-blame-ignore-revs
1 file changed, 5 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/1130/3

diff --git a/.git-blame-ignore-revs b/.git-blame-ignore-revs
index 1fafaac..290e4c3 100644
--- a/.git-blame-ignore-revs
+++ b/.git-blame-ignore-revs
@@ -48,3 +48,8 @@

 # Reformat for sp_after_comma=3Dadd
 e51d9a73693ee742b36e19fb1718e5e27167831d
+
+# The Great Reformatting of 2025, switching to clang-format
+3cca3367e6e0ffeccb8e39cb2c739d1dcb086701
+# Switching to ColumnLimit 0 for clang-format
+21f7d6e1ad65b1f7db673bc98764dc7325858e0b

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1130?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I729ee240e107a629ada5fab6b2ed2399e864cbd0
Gerrit-Change-Number: 1130
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--k0gpc4ty5NA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1130?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Add clang-format reformat commit to .git-blame-ignor=
e-revs<br><br>Change-Id: I729ee240e107a629ada5fab6b2ed2399e864cbd0<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250805150503.11391-1-gert@=
...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1885...=
rceforge.net/msg32528.html<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M .git-blame-ignore-revs<br>1 file changed, 5 insertions(+=
), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/30/1130/3</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/.git-blame-ignore-revs b/.git-=
blame-ignore-revs</span><br><span>index 1fafaac..290e4c3 100644</span><br><=
span>--- a/.git-blame-ignore-revs</span><br><span>+++ b/.git-blame-ignore-r=
evs</span><br><span>@@ -48,3 +48,8 @@</span><br><span> </span><br><span> # =
Reformat for sp_after_comma=3Dadd</span><br><span> e51d9a73693ee742b36e19fb=
1718e5e27167831d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# The Great Reformatti=
ng of 2025, switching to clang-format</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+3cca3367e6e0ffeccb8e39cb2c739d1dcb086701</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# Switching to ColumnLimit 0 for cla=
ng-format</span><br><span style=3D"color: hsl(120, 100%, 40%);">+21f7d6e1ad=
65b1f7db673bc98764dc7325858e0b</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1130?usp=3Demail">c=
hange 1130</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1130?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I729ee240e107a629ada5fab6b2e=
d2399e864cbd0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1130 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--k0gpc4ty5NA=--

