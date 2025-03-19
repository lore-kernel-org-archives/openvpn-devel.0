From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 19 Mar 2025 14:21:58 +0000
References: <gerrit.1730386897000.I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8dd10d25af752f122403842c6072ea8a8219a3d5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vjuyGsnr4uU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vjuyGsnr4uU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail

to review the following change.


Change subject: Define a .clang-format file for the project
......................................................................

Define a .clang-format file for the project

Each of these statements has been reviewed but
not all of them are obvious.

Also add a pre-commit config to easily check the
formatting.

Change-Id: I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
A .clang-format
A .pre-commit-config.yaml
2 files changed, 54 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/790/9

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 0000000..0960fe7
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,46 @@
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
+AlwaysBreakAfterReturnType: None
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
+Language: Cpp
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
diff --git a/.pre-commit-config.yaml b/.pre-commit-config.yaml
new file mode 100644
index 0000000..0f09a06
--- /dev/null
+++ b/.pre-commit-config.yaml
@@ -0,0 +1,8 @@
+repos:
+  - repo: https://github.com/pre-commit/mirrors-clang-format
+    rev: 'v19.1.4'
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
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--vjuyGsnr4uU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Define a .clang-format file for the project<br><br>Each of th=
ese statements has been reviewed but<br>not all of them are obvious.<br><br=
>Also add a pre-commit config to easily check the<br>formatting.<br><br>Cha=
nge-Id: I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>---<br>A .clang-format<br>A .pre-com=
mit-config.yaml<br>2 files changed, 54 insertions(+), 0 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/790/9</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/.clang-format b/.clang-format</span><br><span>new file =
mode 100644</span><br><span>index 0000000..0960fe7</span><br><span>--- /dev=
/null</span><br><span>+++ b/.clang-format</span><br><span>@@ -0,0 +1,46 @@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+---</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+BasedOnStyle: Mozilla</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+AccessModifierOffset: &#39;-4&#39;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AlignAfterOpenBrack=
et: Align</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AlignConse=
cutiveMacros:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Enab=
led: true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  AcrossEm=
ptyLines: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Ac=
rossComments: true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+A=
lignEscapedNewlines: Left</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+AlignOperands: true</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+AlignTrailingComments:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  Kind: Always</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  OverEmptyLines: 1</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+AllowAllParametersOfDeclarationOnNextLine: true</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+AllowShortBlocksOnASingleLine: Never</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+AllowShortCaseLabelsOnAS=
ingleLine: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+All=
owShortFunctionsOnASingleLine: None</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+AllowShortIfStatementsOnASingleLine: Never</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+AllowShortLoopsOnASingleLine: false<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+AlwaysBreakAfterRetu=
rnType: None</span><br><span style=3D"color: hsl(120, 100%, 40%);">+BreakBe=
foreBinaryOperators: NonAssignment</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+BreakBeforeBraces: Allman</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+BreakBeforeTernaryOperators: true</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+BreakStringLiterals: false</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ColumnLimit: &#39;100&#39;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ContinuationIndentWidth: &=
#39;4&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+DerivePoi=
nterAlignment: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+IndentCaseLabels: true</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+IndentGotoLabels: false</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+IndentWidth: &#39;4&#39;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+IndentWrappedFunctionNames: false</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+KeepEmptyLinesAtTheStartOfBlocks: false</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+Language: Cpp</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+MaxEmptyLinesToKeep: &#39;2&#39;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+PointerAlignment: Rig=
ht</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ReflowComments: t=
rue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SortIncludes: fa=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SpaceAfterCStyle=
Cast: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SpaceBef=
oreAssignmentOperators: true</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+SpaceBeforeParens: ControlStatements</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+SpacesBeforeTrailingComments: &#39;2&#39;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+SpacesInParens: Never</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+TabWidth: &#39;4&#39;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+TypeNames: [DWORD]</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+UseTab: Never</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+WhitespaceSensitiveMacros: [_S=
TRINGIFY]</span><br><span>diff --git a/.pre-commit-config.yaml b/.pre-commi=
t-config.yaml</span><br><span>new file mode 100644</span><br><span>index 00=
00000..0f09a06</span><br><span>--- /dev/null</span><br><span>+++ b/.pre-com=
mit-config.yaml</span><br><span>@@ -0,0 +1,8 @@</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+repos:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  - repo: https://github.com/pre-commit/mirrors-clang-format=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rev: &#39;v19.1=
.4&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hooks:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - id: clang-for=
mat</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        files: \=
.[ch]$</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # pre=
serve upstream formatting</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        exclude: ^(src/compat/compat-lz4\.[ch]|src/openvpn/ovpn_dco_(=
linux|win)\.h)$</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail">change 790</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/790?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I40f6af10c5ee2f5aed4185d783f=
c622a2e3c19ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 790 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--vjuyGsnr4uU=--

