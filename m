From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 8 Jan 2025 12:58:51 +0000
References: <gerrit.1736341120000.I4879f983ed6cc035cd6ad8d571e00eb14f9ffdc1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e081e696f4d0cd6bbbbfbd6f791007aaafc7a408-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4edq6CAU9Vg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 dev-tools/text-removal.sh: Script to remove usage of tchar.h
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

--4edq6CAU9Vg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/852?usp=3Demail

to review the following change.


Change subject: dev-tools/text-removal.sh: Script to remove usage of tchar.h
......................................................................

dev-tools/text-removal.sh: Script to remove usage of tchar.h

We only support UNICODE builds anyway, so why make some
part of the code pretend that they do not. The code is
more readable when removing the unused compatibility layer.

This script to be removed again once the conversion is
completed.

Change-Id: I4879f983ed6cc035cd6ad8d571e00eb14f9ffdc1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
A dev-tools/text-removal.sh
1 file changed, 51 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/852/1

diff --git a/dev-tools/text-removal.sh b/dev-tools/text-removal.sh
new file mode 100755
index 0000000..7b4e863
--- /dev/null
+++ b/dev-tools/text-removal.sh
@@ -0,0 +1,51 @@
+#!/bin/bash
+
+# Replace all occurences of TEXT() in our codebase
+# to convert it to simpler Unicode-only code.
+
+set -x
+
+sed -i -E \
+	-e 's/TEXT\(("[^"]*")\)/L\1/g' \
+	-e 's/TEXT\(([^)]*)\)/L\1/g' \
+        -e 's/_T\(/_L(/g' \
+	-e 's/" LPRIsLPTSTR L"/ls/g' \
+	-e 's/" LPRIsLPTSTR/ls"/g' \
+	-e 's/LPRIsLPTSTR L"/L"ls/g' \
+	-e 's/" LPRIsLPOLESTR L"/ls/g' \
+	-e 's/LPRIsLPOLESTR L"/L"ls/g' \
+	-e 's/" LPRIsLPOLESTR/ls"/g' \
+	-e 's/" PRIsLPTSTR "/ls/g' \
+	-e 's/" PRIsLPOLESTR "/ls/g' \
+	-e 's/TCHAR/WCHAR/g' \
+	-e 's/LPTSTR/LPWSTR/g' \
+	-e 's/LPCTSTR/LPCWSTR/g' \
+	-e 's/LPRIXGUID/_L(PRIXGUID)/g' \
+	-e 's/LTAP_WIN_COMPONENT_ID/_L(TAP_WIN_COMPONENT_ID)/g' \
+	-e 's/LPACKAGE_(VERSION|NAME)/_L(PACKAGE_\1)/g' \
+        -e 's/LPACKAGE /_L(PACKAGE) /g' \
+	-e 's/_tcslen/wcslen/g' \
+        -e 's/_tcszlen/wcszlen/g' \
+	-e 's/_tcsrchr/wcsrchr/g' \
+	-e 's/_tcschr/wcschr/g' \
+	-e 's/_tcsstr/wcsstr/g' \
+	-e 's/_tcszistr/wcszistr/g' \
+        -e 's/_tcscpy/wcscpy/g' \
+        -e 's/_tcsicmp/wcsicmp/g' \
+        -e 's/_tcsdup/wcsdup/g' \
+        -e 's/_istspace/iswspace/g' \
+        -e 's/_stprintf/swprintf/g' \
+        -e 's/_ftprintf/fwprintf/g' \
+        -e 's/_tmain/wmain/g' \
+        -e 's/tchar\.h/wchar.h/g' \
+	src/openvpnmsica/*.[ch] \
+        src/openvpnserv/*.[ch] \
+        src/tapctl/*.[ch]
+
+# manual cleanup for complicated cases
+sed -i -E \
+    -e 's/error 0x%x.\\n"\),/error 0x%x).\\n",/g' \
+    src/tapctl/main.c
+sed -i -E \
+    -e 's/" is optional\\n"\),/") is optional\\n",/g' \
+    src/openvpnserv/service.c

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/852?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4879f983ed6cc035cd6ad8d571e00eb14f9ffdc1
Gerrit-Change-Number: 852
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--4edq6CAU9Vg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/852?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dev-tools/text-removal.sh: Script to remove usage of tchar.h<=
br><br>We only support UNICODE builds anyway, so why make some<br>part of t=
he code pretend that they do not. The code is<br>more readable when removin=
g the unused compatibility layer.<br><br>This script to be removed again on=
ce the conversion is<br>completed.<br><br>Change-Id: I4879f983ed6cc035cd6ad=
8d571e00eb14f9ffdc1<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2723...=
.&gt;<br>---<br>A dev-tools/text-removal.sh<br>1 file changed, 51 insertion=
s(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/52/852/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/dev-tools/text-removal.sh b/=
dev-tools/text-removal.sh</span><br><span>new file mode 100755</span><br><s=
pan>index 0000000..7b4e863</span><br><span>--- /dev/null</span><br><span>++=
+ b/dev-tools/text-removal.sh</span><br><span>@@ -0,0 +1,51 @@</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#!/bin/bash</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Replace all occurences of TEXT() in our codebase</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# to convert it to simpler U=
nicode-only code.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+set -x</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+sed -i -E \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	-e &#39;s/TEXT\((&quot;[^&quot;]*&quot;)\)/L\1/g&#39; \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	-e &#39;s/TEXT\(([^)]*)=
\)/L\1/g&#39; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    -e &#39;s/_T\(/_L(/g&#39; \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	-e &#39;s/&quot; LPRIsLPTSTR L&quot;/ls/g&#39; \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	-e &#39;s/&quot; LPRIsLPTSTR/ls&=
quot;/g&#39; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-e &=
#39;s/LPRIsLPTSTR L&quot;/L&quot;ls/g&#39; \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	-e &#39;s/&quot; LPRIsLPOLESTR L&quot;/ls/g&#39; =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-e &#39;s/LPRIsLP=
OLESTR L&quot;/L&quot;ls/g&#39; \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	-e &#39;s/&quot; LPRIsLPOLESTR/ls&quot;/g&#39; \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	-e &#39;s/&quot; PRIsLPTSTR &q=
uot;/ls/g&#39; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-e=
 &#39;s/&quot; PRIsLPOLESTR &quot;/ls/g&#39; \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	-e &#39;s/TCHAR/WCHAR/g&#39; \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	-e &#39;s/LPTSTR/LPWSTR/g&#39; \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	-e &#39;s/LPCTSTR/LPC=
WSTR/g&#39; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-e &#=
39;s/LPRIXGUID/_L(PRIXGUID)/g&#39; \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	-e &#39;s/LTAP_WIN_COMPONENT_ID/_L(TAP_WIN_COMPONENT_ID)/=
g&#39; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-e &#39;s/=
LPACKAGE_(VERSION|NAME)/_L(PACKAGE_\1)/g&#39; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        -e &#39;s/LPACKAGE /_L(PACKAGE) /g&#39;=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-e &#39;s/_tcsle=
n/wcslen/g&#39; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      -e &#39;s/_tcszlen/wcszlen/g&#39; \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	-e &#39;s/_tcsrchr/wcsrchr/g&#39; \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	-e &#39;s/_tcschr/wcschr/g&#39; \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-e &#39;s/_tcsstr/wc=
sstr/g&#39; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-e &#=
39;s/_tcszistr/wcszistr/g&#39; \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        -e &#39;s/_tcscpy/wcscpy/g&#39; \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        -e &#39;s/_tcsicmp/wcsicmp/g&#39=
; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        -e &#39;=
s/_tcsdup/wcsdup/g&#39; \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        -e &#39;s/_istspace/iswspace/g&#39; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        -e &#39;s/_stprintf/swprintf/g&#3=
9; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        -e &#39=
;s/_ftprintf/fwprintf/g&#39; \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        -e &#39;s/_tmain/wmain/g&#39; \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        -e &#39;s/tchar\.h/wchar.h/g&#39; \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	src/openvpnmsica/*.=
[ch] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/o=
penvpnserv/*.[ch] \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        src/tapctl/*.[ch]</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# manual clea=
nup for complicated cases</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+sed -i -E \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  -e &#39;s/error 0x%x.\\n&quot;\),/error 0x%x).\\n&quot;,/g&#39; \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    src/tapctl/main.c</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+sed -i -E \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    -e &#39;s/&quot; is optional\=
\n&quot;\),/&quot;) is optional\\n&quot;,/g&#39; \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    src/openvpnserv/service.c</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/852?usp=3Demail">change 852</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/852?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4879f983ed6cc035cd6ad8d571e=
00eb14f9ffdc1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 852 </div>
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


--4edq6CAU9Vg=--

