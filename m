From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 14:34:29 +0000
In-Reply-To: <gerrit.1771244685000.Idb1e96a4d0a618089db4290c5980d192985b5d29@...2715...>
References: <gerrit.1771244685000.Idb1e96a4d0a618089db4290c5980d192985b5d29@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d3976c8b1a41e7c8161044ef89b06ebf97839d5f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gsUCb9WmJd8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: clang-format: Add
 missing InsertBraces: true
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

--gsUCb9WmJd8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1529?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: clang-format: Add missing InsertBraces: true
......................................................................

clang-format: Add missing InsertBraces: true

This takes care to add missing braces in
case of one-line if-statements or loops.

Apparently we never tested this specific error
and we had no existing cases in the code when
we did the reformat. Noticed this during a code
review.

Change-Id: Idb1e96a4d0a618089db4290c5980d192985b5d29
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1529
Message-Id: <20260216123026.3310-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
635.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .clang-format
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/1529/2

diff --git a/.clang-format b/.clang-format
index 1cce4c3..cbec0a4 100644
--- a/.clang-format
+++ b/.clang-format
@@ -31,6 +31,7 @@
 IndentGotoLabels: false
 IndentWidth: '4'
 IndentWrappedFunctionNames: false
+InsertBraces: true
 KeepEmptyLinesAtTheStartOfBlocks: false
 MaxEmptyLinesToKeep: '2'
 PointerAlignment: Right

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1529?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb1e96a4d0a618089db4290c5980d192985b5d29
Gerrit-Change-Number: 1529
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gsUCb9WmJd8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1529?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">clang-format: Add missing InsertBra=
ces: true<br><br>This takes care to add missing braces in<br>case of one-li=
ne if-statements or loops.<br><br>Apparently we never tested this specific =
error<br>and we had no existing cases in the code when<br>we did the reform=
at. Noticed this during a code<br>review.<br><br>Change-Id: Idb1e96a4d0a618=
089db4290c5980d192985b5d29<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit UR=
L: https://gerrit.openvpn.net/c/openvpn/+/1529<br>Message-Id: &lt;202602161=
23026.3310-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg35635.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>---<br>M .clang-format<br>1 file changed, 1 ins=
ertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/29/1529/2</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.clan=
g-format b/.clang-format</span><br><span>index 1cce4c3..cbec0a4 100644</spa=
n><br><span>--- a/.clang-format</span><br><span>+++ b/.clang-format</span><=
br><span>@@ -31,6 +31,7 @@</span><br><span> IndentGotoLabels: false</span><=
br><span> IndentWidth: &#39;4&#39;</span><br><span> IndentWrappedFunctionNa=
mes: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+InsertBra=
ces: true</span><br><span> KeepEmptyLinesAtTheStartOfBlocks: false</span><b=
r><span> MaxEmptyLinesToKeep: &#39;2&#39;</span><br><span> PointerAlignment=
: Right</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1529?usp=3Demail">change 1529</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1529?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb1e96a4d0a618089db4290c598=
0d192985b5d29 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1529 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--gsUCb9WmJd8=--

