From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 8 Jan 2025 13:02:38 +0000
In-Reply-To: <gerrit.1736341120000.Ib3a166ead912beb2a591105c84d96d342664c05f@...2715...>
References: <gerrit.1736341120000.Ib3a166ead912beb2a591105c84d96d342664c05f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9dcb4e762549c0f6f535d728791d279eb95ecaf7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6bgYFd6wMko="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Post tchar.h removal
 cleanup
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

--6bgYFd6wMko=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/854?usp=3Demail

to look at the new patch set (#2).


Change subject: Post tchar.h removal cleanup
......................................................................

Post tchar.h removal cleanup

Change-Id: Ib3a166ead912beb2a591105c84d96d342664c05f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
D dev-tools/text-removal.sh
M src/openvpnserv/service.h
M src/tapctl/basic.h
3 files changed, 4 insertions(+), 62 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/854/2

diff --git a/dev-tools/text-removal.sh b/dev-tools/text-removal.sh
deleted file mode 100755
index 7b4e863..0000000
--- a/dev-tools/text-removal.sh
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/bin/bash
-
-# Replace all occurences of TEXT() in our codebase
-# to convert it to simpler Unicode-only code.
-
-set -x
-
-sed -i -E \
-	-e 's/TEXT\(("[^"]*")\)/L\1/g' \
-	-e 's/TEXT\(([^)]*)\)/L\1/g' \
-        -e 's/_T\(/_L(/g' \
-	-e 's/" LPRIsLPTSTR L"/ls/g' \
-	-e 's/" LPRIsLPTSTR/ls"/g' \
-	-e 's/LPRIsLPTSTR L"/L"ls/g' \
-	-e 's/" LPRIsLPOLESTR L"/ls/g' \
-	-e 's/LPRIsLPOLESTR L"/L"ls/g' \
-	-e 's/" LPRIsLPOLESTR/ls"/g' \
-	-e 's/" PRIsLPTSTR "/ls/g' \
-	-e 's/" PRIsLPOLESTR "/ls/g' \
-	-e 's/TCHAR/WCHAR/g' \
-	-e 's/LPTSTR/LPWSTR/g' \
-	-e 's/LPCTSTR/LPCWSTR/g' \
-	-e 's/LPRIXGUID/_L(PRIXGUID)/g' \
-	-e 's/LTAP_WIN_COMPONENT_ID/_L(TAP_WIN_COMPONENT_ID)/g' \
-	-e 's/LPACKAGE_(VERSION|NAME)/_L(PACKAGE_\1)/g' \
-        -e 's/LPACKAGE /_L(PACKAGE) /g' \
-	-e 's/_tcslen/wcslen/g' \
-        -e 's/_tcszlen/wcszlen/g' \
-	-e 's/_tcsrchr/wcsrchr/g' \
-	-e 's/_tcschr/wcschr/g' \
-	-e 's/_tcsstr/wcsstr/g' \
-	-e 's/_tcszistr/wcszistr/g' \
-        -e 's/_tcscpy/wcscpy/g' \
-        -e 's/_tcsicmp/wcsicmp/g' \
-        -e 's/_tcsdup/wcsdup/g' \
-        -e 's/_istspace/iswspace/g' \
-        -e 's/_stprintf/swprintf/g' \
-        -e 's/_ftprintf/fwprintf/g' \
-        -e 's/_tmain/wmain/g' \
-        -e 's/tchar\.h/wchar.h/g' \
-	src/openvpnmsica/*.[ch] \
-        src/openvpnserv/*.[ch] \
-        src/tapctl/*.[ch]
-
-# manual cleanup for complicated cases
-sed -i -E \
-    -e 's/error 0x%x.\\n"\),/error 0x%x).\\n",/g' \
-    src/tapctl/main.c
-sed -i -E \
-    -e 's/" is optional\\n"\),/") is optional\\n",/g' \
-    src/openvpnserv/service.c
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index daa48d7..9f3c150 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -24,11 +24,6 @@
 #ifndef _SERVICE_H
 #define _SERVICE_H

-/* We do not support non-unicode builds */
-#ifndef UNICODE
-#define UNICODE
-#endif
-
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index ca5c6d4..49a3cf6 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -22,13 +22,11 @@
 #ifndef BASIC_H
 #define BASIC_H

-#ifdef _UNICODE
-#define PRIsLPWSTR      "ls"
-#define PRIsLPOLESTR    "ls"
-#else
-#define PRIsLPWSTR      "s"
-#define PRIsLPOLESTR    "ls"
+/* We do not support non-unicode builds */
+#ifndef UNICODE
+#define UNICODE
 #endif
+
 #define PRIXGUID        "{%08lX-%04hX-%04hX-%02hhX%02hhX-%02hhX%02hhX%02hh=
X%02hhX%02hhX%02hhX}"
 #define PRIGUID_PARAM(g) \
     (g).Data1, (g).Data2, (g).Data3, (g).Data4[0], (g).Data4[1], (g).Data4=
[2], (g).Data4[3], (g).Data4[4], (g).Data4[5], (g).Data4[6], (g).Data4[7]

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/854?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib3a166ead912beb2a591105c84d96d342664c05f
Gerrit-Change-Number: 854
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--6bgYFd6wMko=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/854?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Post tchar.h removal cleanup<br><br>Change-Id: Ib3a166ead912beb2a5=
91105c84d96d342664c05f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>---<br>D dev-tools/text-removal.sh<br>M src/openvpnserv/service=
.h<br>M src/tapctl/basic.h<br>3 files changed, 4 insertions(+), 62 deletion=
s(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/54/854/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/dev-tools/text-removal.sh b/dev-tools/text-r=
emoval.sh</span><br><span>deleted file mode 100755</span><br><span>index 7b=
4e863..0000000</span><br><span>--- a/dev-tools/text-removal.sh</span><br><s=
pan>+++ /dev/null</span><br><span>@@ -1,51 +0,0 @@</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#!/bin/bash</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
Replace all occurences of TEXT() in our codebase</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# to convert it to simpler Unicode-only code.</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-set -x</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sed =
-i -E \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-e &#39;s/TEX=
T\((&quot;[^&quot;]*&quot;)\)/L\1/g&#39; \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	-e &#39;s/TEXT\(([^)]*)\)/L\1/g&#39; \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        -e &#39;s/_T\(/_L(/g&#39; \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-e &#39;s/&quot; LPRI=
sLPTSTR L&quot;/ls/g&#39; \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	-e &#39;s/&quot; LPRIsLPTSTR/ls&quot;/g&#39; \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	-e &#39;s/LPRIsLPTSTR L&quot;/L&quot;ls/g&=
#39; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-e &#39;s/&quo=
t; LPRIsLPOLESTR L&quot;/ls/g&#39; \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	-e &#39;s/LPRIsLPOLESTR L&quot;/L&quot;ls/g&#39; \</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	-e &#39;s/&quot; LPRIsLPOLEST=
R/ls&quot;/g&#39; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-=
e &#39;s/&quot; PRIsLPTSTR &quot;/ls/g&#39; \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	-e &#39;s/&quot; PRIsLPOLESTR &quot;/ls/g&#39; \</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-e &#39;s/TCHAR/WCHAR/=
g&#39; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-e &#39;s/LP=
TSTR/LPWSTR/g&#39; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
-e &#39;s/LPCTSTR/LPCWSTR/g&#39; \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	-e &#39;s/LPRIXGUID/_L(PRIXGUID)/g&#39; \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	-e &#39;s/LTAP_WIN_COMPONENT_ID/_L(TAP_W=
IN_COMPONENT_ID)/g&#39; \</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	-e &#39;s/LPACKAGE_(VERSION|NAME)/_L(PACKAGE_\1)/g&#39; \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        -e &#39;s/LPACKAGE /_L(PAC=
KAGE) /g&#39; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-e &#=
39;s/_tcslen/wcslen/g&#39; \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        -e &#39;s/_tcszlen/wcszlen/g&#39; \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	-e &#39;s/_tcsrchr/wcsrchr/g&#39; \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	-e &#39;s/_tcschr/wcschr/g&#39=
; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-e &#39;s/_tcsstr=
/wcsstr/g&#39; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-e &=
#39;s/_tcszistr/wcszistr/g&#39; \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        -e &#39;s/_tcscpy/wcscpy/g&#39; \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        -e &#39;s/_tcsicmp/wcsicmp/g&#39; \=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        -e &#39;s/_tc=
sdup/wcsdup/g&#39; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       -e &#39;s/_istspace/iswspace/g&#39; \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        -e &#39;s/_stprintf/swprintf/g&#39; \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        -e &#39;s/_ftprintf/=
fwprintf/g&#39; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    -e &#39;s/_tmain/wmain/g&#39; \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        -e &#39;s/tchar\.h/wchar.h/g&#39; \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	src/openvpnmsica/*.[ch] \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        src/openvpnserv/*.[ch] \</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        src/tapctl/*.[c=
h]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# manual cleanup for complicated cases</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-sed -i -E \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    -e &#39;s/error 0x%x.\\n&quot=
;\),/error 0x%x).\\n&quot;,/g&#39; \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    src/tapctl/main.c</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-sed -i -E \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    -e &#39;s/&quot; is optional\\n&quot;\),/&quot;) is optional\\n&qu=
ot;,/g&#39; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    src/=
openvpnserv/service.c</span><br><span>diff --git a/src/openvpnserv/service.=
h b/src/openvpnserv/service.h</span><br><span>index daa48d7..9f3c150 100644=
</span><br><span>--- a/src/openvpnserv/service.h</span><br><span>+++ b/src/=
openvpnserv/service.h</span><br><span>@@ -24,11 +24,6 @@</span><br><span> #=
ifndef _SERVICE_H</span><br><span> #define _SERVICE_H</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-/* We do not support non-=
unicode builds */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifn=
def UNICODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define UN=
ICODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef HAVE_C=
ONFIG_H</span><br><span> #include &quot;config.h&quot;</span><br><span> #en=
dif</span><br><span>diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h</s=
pan><br><span>index ca5c6d4..49a3cf6 100644</span><br><span>--- a/src/tapct=
l/basic.h</span><br><span>+++ b/src/tapctl/basic.h</span><br><span>@@ -22,1=
3 +22,11 @@</span><br><span> #ifndef BASIC_H</span><br><span> #define BASIC=
_H</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifdef _UNICODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 PRIsLPWSTR      &quot;ls&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define PRIsLPOLESTR    &quot;ls&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define PRIsLPWSTR      &quot;s&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define PRIsLPOLESTR    &quot;ls&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* We do not support non-unic=
ode builds */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnde=
f UNICODE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define UN=
ICODE</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> #define PRIXGUID        &quot;{%08lX-%04hX-%04h=
X-%02hhX%02hhX-%02hhX%02hhX%02hhX%02hhX%02hhX%02hhX}&quot;</span><br><span>=
 #define PRIGUID_PARAM(g) \</span><br><span>     (g).Data1, (g).Data2, (g).=
Data3, (g).Data4[0], (g).Data4[1], (g).Data4[2], (g).Data4[3], (g).Data4[4]=
, (g).Data4[5], (g).Data4[6], (g).Data4[7]</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/854?usp=
=3Demail">change 854</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/854?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3a166ead912beb2a591105c84d=
96d342664c05f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 854 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--6bgYFd6wMko=--

