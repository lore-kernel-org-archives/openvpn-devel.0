From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 4 Aug 2025 08:26:03 +0000
In-Reply-To: <gerrit.1730386897000.I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff@...2715...>
References: <gerrit.1730386897000.I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ab41d6a850d5794cc22e3b2ec2107ed9c8540c7c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q5xZ2pJH8BU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Define a
 .clang-format file for the project
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

--Q5xZ2pJH8BU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#19) to the change originally created b=
y flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Define a .clang-format file for the project
......................................................................

Define a .clang-format file for the project

Each of these statements has been reviewed but
not all of them are obvious.

Also add a pre-commit config to easily check the
formatting.

Change-Id: I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250803150143.3878-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
484.html
Signed-off-by: Gert Doering <gert@...1296...>
---
A .clang-format
A .pre-commit-config.yaml
2 files changed, 59 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/790/19

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 0000000..c314fca
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,51 @@
+---
+BasedOnStyle: Mozilla
+AccessModifierOffset: '-4'
+AlignAfterOpenBracket: Align
+AlignConsecutiveMacros:
+  Enabled: true
+  AcrossEmptyLines: false
+  AcrossComments: true
+AlignEscapedNewlines: Left
+AlignOperands: true
+AlignTrailingComments:
+  Kind: Always
+  OverEmptyLines: 1
+AllowAllParametersOfDeclarationOnNextLine: true
+AllowShortBlocksOnASingleLine: Never
+AllowShortCaseLabelsOnASingleLine: false
+AllowShortFunctionsOnASingleLine: None
+AllowShortIfStatementsOnASingleLine: Never
+AllowShortLoopsOnASingleLine: false
+BinPackArguments: true
+BinPackParameters: true
+BreakAfterReturnType: AllDefinitions
+BreakBeforeBinaryOperators: NonAssignment
+BreakBeforeBraces: Allman
+BreakBeforeTernaryOperators: true
+BreakStringLiterals: false
+ColumnLimit: '100'
+ContinuationIndentWidth: '4'
+DerivePointerAlignment: false
+IndentCaseLabels: true
+IndentGotoLabels: false
+IndentWidth: '4'
+IndentWrappedFunctionNames: false
+KeepEmptyLinesAtTheStartOfBlocks: false
+MaxEmptyLinesToKeep: '2'
+PointerAlignment: Right
+ReflowComments: true
+SortIncludes: false
+SpaceAfterCStyleCast: false
+SpaceBeforeAssignmentOperators: true
+SpaceBeforeParens: ControlStatements
+SpacesBeforeTrailingComments: '2'
+SpacesInParens: Never
+TabWidth: '4'
+TypeNames: [DWORD]
+UseTab: Never
+WhitespaceSensitiveMacros: [_STRINGIFY]
+---
+Language: C
+---
+Language: Cpp
diff --git a/.pre-commit-config.yaml b/.pre-commit-config.yaml
new file mode 100644
index 0000000..c1bca47
--- /dev/null
+++ b/.pre-commit-config.yaml
@@ -0,0 +1,8 @@
+repos:
+  - repo: https://github.com/pre-commit/mirrors-clang-format
+    rev: 'v20.1.0'
+    hooks:
+      - id: clang-format
+        files: \.[ch]$
+        # preserve upstream formatting
+        exclude: ^(src/compat/compat-lz4\.[ch]|src/openvpn/ovpn_dco_(linux=
|win)\.h)$

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff
Gerrit-Change-Number: 790
Gerrit-PatchSet: 19
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--Q5xZ2pJH8BU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #19</strong> to the change originally c=
reated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/790?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Define a .clang-format file for the project<br><br>E=
ach of these statements has been reviewed but<br>not all of them are obviou=
s.<br><br>Also add a pre-commit config to easily check the<br>formatting.<b=
r><br>Change-Id: I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;=
gert@...1296...&gt;<br>Message-Id: &lt;20250803150143.3878-1-gert@...2132...=
.&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...290...=
net/msg32484.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>A .clang-format<br>A .pre-commit-config.yaml<br>2 files changed, 59=
 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/90/790/19</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/.clang-format b/.=
clang-format</span><br><span>new file mode 100644</span><br><span>index 000=
0000..c314fca</span><br><span>--- /dev/null</span><br><span>+++ b/.clang-fo=
rmat</span><br><span>@@ -0,0 +1,51 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+---</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+BasedOnStyle: Mozilla</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+AccessModifierOffset: &#39;-4&#39;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+AlignAfterOpenBracket: Align</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+AlignConsecutiveMacros:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Enabled: true</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  AcrossEmptyLines: false</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  AcrossComments: true</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+AlignEscapedNewlines: Left</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+AlignOperands: true</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+AlignTrailingComments:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  Kind: Always</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  OverEmptyLines: 1</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+AllowAllParametersOfDeclaration=
OnNextLine: true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+All=
owShortBlocksOnASingleLine: Never</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+AllowShortCaseLabelsOnASingleLine: false</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+AllowShortFunctionsOnASingleLine: None</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+AllowShortIfStatement=
sOnASingleLine: Never</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+AllowShortLoopsOnASingleLine: false</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+BinPackArguments: true</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+BinPackParameters: true</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+BreakAfterReturnType: AllDefinitions</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+BreakBeforeBinaryOperators: NonAs=
signment</span><br><span style=3D"color: hsl(120, 100%, 40%);">+BreakBefore=
Braces: Allman</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Break=
BeforeTernaryOperators: true</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+BreakStringLiterals: false</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ColumnLimit: &#39;100&#39;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ContinuationIndentWidth: &#39;4&#39;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+DerivePointerAlignment: false</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+IndentCaseLabels: true</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+IndentGotoLabels: fals=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+IndentWidth: &#39;=
4&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+IndentWrapped=
FunctionNames: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+KeepEmptyLinesAtTheStartOfBlocks: false</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+MaxEmptyLinesToKeep: &#39;2&#39;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+PointerAlignment: Right</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ReflowComments: true</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+SortIncludes: false</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+SpaceAfterCStyleCast: false</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+SpaceBeforeAssignmentOperato=
rs: true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SpaceBefore=
Parens: ControlStatements</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+SpacesBeforeTrailingComments: &#39;2&#39;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+SpacesInParens: Never</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+TabWidth: &#39;4&#39;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+TypeNames: [DWORD]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+UseTab: Never</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+WhitespaceSensitiveMacros: [_STRINGIFY]</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+---</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Language: C</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+---</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+Language: Cpp</span><br><span>diff --git a/.pre-commit-config.yam=
l b/.pre-commit-config.yaml</span><br><span>new file mode 100644</span><br>=
<span>index 0000000..c1bca47</span><br><span>--- /dev/null</span><br><span>=
+++ b/.pre-commit-config.yaml</span><br><span>@@ -0,0 +1,8 @@</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+repos:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  - repo: https://github.com/pre-commit/mirror=
s-clang-format</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
ev: &#39;v20.1.0&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    hooks:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      -=
 id: clang-format</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      files: \.[ch]$</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        # preserve upstream formatting</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        exclude: ^(src/compat/compat-lz4\.[ch]|src/open=
vpn/ovpn_dco_(linux|win)\.h)$</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail">cha=
nge 790</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I40f6af10c5ee2f5aed4185d783f=
c622a2e3c19ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 790 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Q5xZ2pJH8BU=--

