From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 8 Jan 2025 12:58:54 +0000
References: <gerrit.1736341120000.Ib3a166ead912beb2a591105c84d96d342664c05f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7e1b31a7327a4b8e943e562661a71bbeb2c6e609-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Sjv83kwSBiA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Post tchar.h removal
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

--Sjv83kwSBiA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/854?usp=3Demail

to review the following change.


Change subject: Post tchar.h removal cleanup
......................................................................

Post tchar.h removal cleanup

Change-Id: Ib3a166ead912beb2a591105c84d96d342664c05f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnserv/service.h
M src/tapctl/basic.h
2 files changed, 4 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/854/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Sjv83kwSBiA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/854?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Post tchar.h removal cleanup<br><br>Change-Id: Ib3a166ead912b=
eb2a591105c84d96d342664c05f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>---<br>M src/openvpnserv/service.h<br>M src/tapctl/basic.h=
<br>2 files changed, 4 insertions(+), 11 deletions(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/54/854/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpnserv/service.h b/src/openvpnserv/service.h</span><br><span=
>index daa48d7..9f3c150 100644</span><br><span>--- a/src/openvpnserv/servic=
e.h</span><br><span>+++ b/src/openvpnserv/service.h</span><br><span>@@ -24,=
11 +24,6 @@</span><br><span> #ifndef _SERVICE_H</span><br><span> #define _S=
ERVICE_H</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/* We do not support non-unicode builds */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifndef UNICODE</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define UNICODE</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;confi=
g.h&quot;</span><br><span> #endif</span><br><span>diff --git a/src/tapctl/b=
asic.h b/src/tapctl/basic.h</span><br><span>index ca5c6d4..49a3cf6 100644</=
span><br><span>--- a/src/tapctl/basic.h</span><br><span>+++ b/src/tapctl/ba=
sic.h</span><br><span>@@ -22,13 +22,11 @@</span><br><span> #ifndef BASIC_H<=
/span><br><span> #define BASIC_H</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#ifdef _UNICODE</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define PRIsLPWSTR      &quot;ls&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define PRIsLPOLESTR    &quot;ls&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define PRIsLPWSTR      &quot;s&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PRIsLPOLES=
TR    &quot;ls&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* We do not support non-unicode builds */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef UNICODE</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define UNICODE</span><br><span> #endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #define PRIXGUID =
       &quot;{%08lX-%04hX-%04hX-%02hhX%02hhX-%02hhX%02hhX%02hhX%02hhX%02hhX=
%02hhX}&quot;</span><br><span> #define PRIGUID_PARAM(g) \</span><br><span> =
    (g).Data1, (g).Data2, (g).Data3, (g).Data4[0], (g).Data4[1], (g).Data4[=
2], (g).Data4[3], (g).Data4[4], (g).Data4[5], (g).Data4[6], (g).Data4[7]</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/854?usp=3Demail">change 854</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/854?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3a166ead912beb2a591105c84d=
96d342664c05f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 854 </div>
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


--Sjv83kwSBiA=--

