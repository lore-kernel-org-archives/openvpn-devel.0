From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 19 Mar 2025 17:48:17 +0000
In-Reply-To: <gerrit.1736341120000.Ib3a166ead912beb2a591105c84d96d342664c05f@...2715...>
References: <gerrit.1736341120000.Ib3a166ead912beb2a591105c84d96d342664c05f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <a700c7fe0bfb263b3767f7e035d9b424eb55e35f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3Zgpd0lLU6I="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3Zgpd0lLU6I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/85=
4?usp=3Demail )

Change subject: Post tchar.h removal cleanup
......................................................................

Post tchar.h removal cleanup

Remove some unused defines.

Change-Id: Ib3a166ead912beb2a591105c84d96d342664c05f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250319142234.25046-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
172.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/service.h
M src/tapctl/basic.h
2 files changed, 4 insertions(+), 11 deletions(-)




diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index b2b706b..7112f26 100644
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
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--3Zgpd0lLU6I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/854?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Post tchar.h removal cleanup<br><br>Remove som=
e unused defines.<br><br>Change-Id: Ib3a166ead912beb2a591105c84d96d342664c0=
5f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by=
: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250319142234.25=
046-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg31172.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M src/openvpnserv/service.h<br>M src/tapctl/bas=
ic.h<br>2 files changed, 4 insertions(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h</span=
><br><span>index b2b706b..7112f26 100644</span><br><span>--- a/src/openvpns=
erv/service.h</span><br><span>+++ b/src/openvpnserv/service.h</span><br><sp=
an>@@ -24,11 +24,6 @@</span><br><span> #ifndef _SERVICE_H</span><br><span> =
#define _SERVICE_H</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/* We do not support non-unicode builds */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#ifndef UNICODE</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define UNICODE</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include=
 &quot;config.h&quot;</span><br><span> #endif</span><br><span>diff --git a/=
src/tapctl/basic.h b/src/tapctl/basic.h</span><br><span>index ca5c6d4..49a3=
cf6 100644</span><br><span>--- a/src/tapctl/basic.h</span><br><span>+++ b/s=
rc/tapctl/basic.h</span><br><span>@@ -22,13 +22,11 @@</span><br><span> #ifn=
def BASIC_H</span><br><span> #define BASIC_H</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef _UNICODE</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define PRIsLPWSTR      &quot;ls&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PRIsLPOLESTR   =
 &quot;ls&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PRIsLPWSTR    =
  &quot;s&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e PRIsLPOLESTR    &quot;ls&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* We do not support non-unicode builds */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifndef UNICODE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define UNICODE</span><br><span> #endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #de=
fine PRIXGUID        &quot;{%08lX-%04hX-%04hX-%02hhX%02hhX-%02hhX%02hhX%02h=
hX%02hhX%02hhX%02hhX}&quot;</span><br><span> #define PRIGUID_PARAM(g) \</sp=
an><br><span>     (g).Data1, (g).Data2, (g).Data3, (g).Data4[0], (g).Data4[=
1], (g).Data4[2], (g).Data4[3], (g).Data4[4], (g).Data4[5], (g).Data4[6], (=
g).Data4[7]</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/854?usp=3Demail">change 854</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/854?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3a166ead912beb2a591105c84d=
96d342664c05f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 854 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--3Zgpd0lLU6I=--

