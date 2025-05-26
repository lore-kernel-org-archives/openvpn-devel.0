From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 May 2025 10:35:54 +0000
In-Reply-To: <gerrit.1730386897000.I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff@...2715...>
References: <gerrit.1730386897000.I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6611216b8cd063ee328a191cd81f24e370e736a8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ons1SkHNGU0="; charset=UTF-8
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

--Ons1SkHNGU0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail

to look at the new patch set (#15).


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
2 files changed, 59 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/790/15

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
Gerrit-PatchSet: 15
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--Ons1SkHNGU0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #15</strong> to this change.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/790?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Define a .clang-format file for the project<br><br>Each of these =
statements has been reviewed but<br>not all of them are obvious.<br><br>Als=
o add a pre-commit config to easily check the<br>formatting.<br><br>Change-=
Id: I40f6af10c5ee2f5aed4185d783fc622a2e3c19ff<br>Signed-off-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>---<br>A .clang-format<br>A .pre-commit-=
config.yaml<br>2 files changed, 59 insertions(+), 0 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/790/15</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/.clang-format b/.clang-format</span><br><span>new file mod=
e 100644</span><br><span>index 0000000..c314fca</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/.clang-format</span><br><span>@@ -0,0 +1,51 @@</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+---</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+BasedOnStyle: Mozilla</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+AccessModifierOffset: &#39;-4&#39;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+AlignAfterOpenBracket:=
 Align</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AlignConsecut=
iveMacros:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Enabled=
: true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  AcrossEmpty=
Lines: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Acros=
sComments: true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Alig=
nEscapedNewlines: Left</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+AlignOperands: true</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+AlignTrailingComments:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  Kind: Always</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  OverEmptyLines: 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+AllowAllParametersOfDeclarationOnNextLine: true</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+AllowShortBlocksOnASingleLine: Never</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+AllowShortCaseLabelsOnASingle=
Line: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AllowSho=
rtFunctionsOnASingleLine: None</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+AllowShortIfStatementsOnASingleLine: Never</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+AllowShortLoopsOnASingleLine: false</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+BinPackArguments: true</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+BinPackParameters: tru=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+BreakAfterReturnTy=
pe: AllDefinitions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+B=
reakBeforeBinaryOperators: NonAssignment</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+BreakBeforeBraces: Allman</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+BreakBeforeTernaryOperators: true</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+BreakStringLiterals: false</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ColumnLimit: &#39;100&#39;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ContinuationIndentWi=
dth: &#39;4&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Der=
ivePointerAlignment: false</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+IndentCaseLabels: true</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+IndentGotoLabels: false</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+IndentWidth: &#39;4&#39;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+IndentWrappedFunctionNames: false</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+KeepEmptyLinesAtTheStartOfBlocks: false</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+MaxEmptyLinesToKeep: =
&#39;2&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+PointerA=
lignment: Right</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Refl=
owComments: true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Sor=
tIncludes: false</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Spa=
ceAfterCStyleCast: false</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+SpaceBeforeAssignmentOperators: true</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+SpaceBeforeParens: ControlStatements</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+SpacesBeforeTrailingComments: &#39;2=
&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SpacesInParens=
: Never</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TabWidth: &#=
39;4&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TypeNames:=
 [DWORD]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+UseTab: Nev=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+WhitespaceSensiti=
veMacros: [_STRINGIFY]</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+---</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Language: C</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+---</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+Language: Cpp</span><br><span>diff --=
git a/.pre-commit-config.yaml b/.pre-commit-config.yaml</span><br><span>new=
 file mode 100644</span><br><span>index 0000000..c1bca47</span><br><span>--=
- /dev/null</span><br><span>+++ b/.pre-commit-config.yaml</span><br><span>@=
@ -0,0 +1,8 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+repos=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  - repo: https://=
github.com/pre-commit/mirrors-clang-format</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    rev: &#39;v20.1.0&#39;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    hooks:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      - id: clang-format</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        files: \.[ch]$</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        # preserve upstream formatting</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        exclude: ^(src/comp=
at/compat-lz4\.[ch]|src/openvpn/ovpn_dco_(linux|win)\.h)$</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/790?usp=3Demail">change 790</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/790?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I40f6af10c5ee2f5aed4185d783f=
c622a2e3c19ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 790 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Ons1SkHNGU0=--

