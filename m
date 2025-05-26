From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 May 2025 11:27:45 +0000
References: <gerrit.1748258863000.Ifd36651a3713dd6f2e585f0771f349178a494360@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <497fa634036c188a4d43a62c7b2d4adeac99411e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CaCGM2Fzz6M="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]:
 git-pre-commit-uncrustify: Make sure to not run on branches with clan...
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

--CaCGM2Fzz6M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1031?usp=3Demail

to review the following change.


Change subject: git-pre-commit-uncrustify: Make sure to not run on branches=
 with clang-format
......................................................................

git-pre-commit-uncrustify: Make sure to not run on branches with clang-form=
at

If a .clang-format file is present, do not run this hook.
This allows to keep this installed while working also on
newer branches that do not use uncrustify anymore.

Change-Id: Ifd36651a3713dd6f2e585f0771f349178a494360
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M dev-tools/git-pre-commit-uncrustify.sh
1 file changed, 6 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/1031/1

diff --git a/dev-tools/git-pre-commit-uncrustify.sh b/dev-tools/git-pre-com=
mit-uncrustify.sh
index 9851c21..1f49086 100755
--- a/dev-tools/git-pre-commit-uncrustify.sh
+++ b/dev-tools/git-pre-commit-uncrustify.sh
@@ -58,6 +58,12 @@
     exit 0
 fi

+
+if [ -f .clang-format ]; then
+    echo "skipping uncrustify due to presence of .clang-format"
+    exit 0
+fi
+
 # check whether the given file matches any of the set extensions
 matches_extension() {
     local filename=3D"$(basename -- "$1")"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1031?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ifd36651a3713dd6f2e585f0771f349178a494360
Gerrit-Change-Number: 1031
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--CaCGM2Fzz6M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1031?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git-pre-commit-uncrustify: Make sure to not run on branches =
with clang-format<br><br>If a .clang-format file is present, do not run thi=
s hook.<br>This allows to keep this installed while working also on<br>newe=
r branches that do not use uncrustify anymore.<br><br>Change-Id: Ifd36651a3=
713dd6f2e585f0771f349178a494360<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>---<br>M dev-tools/git-pre-commit-uncrustify.sh<br>1 f=
ile changed, 6 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/31/1031/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev=
-tools/git-pre-commit-uncrustify.sh b/dev-tools/git-pre-commit-uncrustify.s=
h</span><br><span>index 9851c21..1f49086 100755</span><br><span>--- a/dev-t=
ools/git-pre-commit-uncrustify.sh</span><br><span>+++ b/dev-tools/git-pre-c=
ommit-uncrustify.sh</span><br><span>@@ -58,6 +58,12 @@</span><br><span>    =
 exit 0</span><br><span> fi</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+if [ -f .clang-format ]; then</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    echo &quot;skipping uncrustify due to presence of .cla=
ng-format&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
exit 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # check whet=
her the given file matches any of the set extensions</span><br><span> match=
es_extension() {</span><br><span>     local filename=3D&quot;$(basename -- =
&quot;$1&quot;)&quot;</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1031?usp=3Demail">change 103=
1</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1031?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd36651a3713dd6f2e585f0771f=
349178a494360 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1031 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--CaCGM2Fzz6M=--

