From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 12:24:47 +0000
References: <gerrit.1771244685000.Idb1e96a4d0a618089db4290c5980d192985b5d29@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bdb55885f96d672315034b6d725480c071fab881-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cBGzNnScb2Y="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cBGzNnScb2Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1529?usp=3Demail

to review the following change.


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
---
M .clang-format
1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/1529/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb1e96a4d0a618089db4290c5980d192985b5d29
Gerrit-Change-Number: 1529
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--cBGzNnScb2Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1529?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">clang-format: Add missing InsertBraces: tru=
e<br><br>This takes care to add missing braces in<br>case of one-line if-st=
atements or loops.<br><br>Apparently we never tested this specific error<br=
>and we had no existing cases in the code when<br>we did the reformat. Noti=
ced this during a code<br>review.<br><br>Change-Id: Idb1e96a4d0a618089db429=
0c5980d192985b5d29<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>---<br>M .clang-format<br>1 file changed, 1 insertion(+), 0 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/29/1529/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/.clang-format b/.clang-fo=
rmat</span><br><span>index 1cce4c3..cbec0a4 100644</span><br><span>--- a/.c=
lang-format</span><br><span>+++ b/.clang-format</span><br><span>@@ -31,6 +3=
1,7 @@</span><br><span> IndentGotoLabels: false</span><br><span> IndentWidt=
h: &#39;4&#39;</span><br><span> IndentWrappedFunctionNames: false</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+InsertBraces: true</span><br>=
<span> KeepEmptyLinesAtTheStartOfBlocks: false</span><br><span> MaxEmptyLin=
esToKeep: &#39;2&#39;</span><br><span> PointerAlignment: Right</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1529?usp=3Demail">change 1529</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1529?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb1e96a4d0a618089db4290c598=
0d192985b5d29 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1529 </div>
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

--cBGzNnScb2Y=--

