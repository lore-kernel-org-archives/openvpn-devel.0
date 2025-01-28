From: "kallisti5 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 01:50:27 +0000
References: <gerrit.1738029022000.I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d@...2715...>
Reply-To: alex@...2837..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f00596f42cf6fc3b5103ac7dc089cec0186927ee-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r6OMEUqLwYA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Haiku: Fix short
 interface path length
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--r6OMEUqLwYA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/689?usp=3Demail

to review the following change.


Change subject: Haiku: Fix short interface path length
......................................................................

Haiku: Fix short interface path length

* Haiku uses full paths for interface names, 16 characters
  isn't enough.

Change-Id: I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d
---
M src/openvpn/route.h
1 file changed, 7 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/689/1

diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 421e7d2..69b06b8 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -155,6 +155,8 @@
     /* gateway interface */
 #ifdef _WIN32
     DWORD adapter_index; /* interface or ~0 if undefined */
+#elif defined(TARGET_HAIKU)
+    char iface[PATH_MAX]; /* iface names are full /dev path with driver na=
me */
 #else
     char iface[16]; /* interface name (null terminated), may be empty */
 #endif
@@ -186,8 +188,13 @@
 #else
     /* non linux platform don't have this constant defined */
 #ifndef IFNAMSIZ
+#if defined(TARGET_HAIKU)
+/* iface names are full /dev path with driver name */
+#define IFNAMSIZ PATH_MAX
+#else
 #define IFNAMSIZ 16
 #endif
+#endif
     char iface[IFNAMSIZ]; /* interface name (null terminated), may be empt=
y */
 #endif


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/689?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d
Gerrit-Change-Number: 689
Gerrit-PatchSet: 1
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--r6OMEUqLwYA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>kallisti5 would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/689?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Haiku: Fix short interface path length<br><br>* Haiku uses fu=
ll paths for interface names, 16 characters<br>  isn&#39;t enough.<br><br>C=
hange-Id: I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d<br>---<br>M src/openvpn=
/route.h<br>1 file changed, 7 insertions(+), 0 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/689/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/route.h b/src/openvpn/route.h</span><br><span>index =
421e7d2..69b06b8 100644</span><br><span>--- a/src/openvpn/route.h</span><br=
><span>+++ b/src/openvpn/route.h</span><br><span>@@ -155,6 +155,8 @@</span>=
<br><span>     /* gateway interface */</span><br><span> #ifdef _WIN32</span=
><br><span>     DWORD adapter_index; /* interface or ~0 if undefined */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_HA=
IKU)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char iface[=
PATH_MAX]; /* iface names are full /dev path with driver name */</span><br>=
<span> #else</span><br><span>     char iface[16]; /* interface name (null t=
erminated), may be empty */</span><br><span> #endif</span><br><span>@@ -186=
,8 +188,13 @@</span><br><span> #else</span><br><span>     /* non linux plat=
form don&#39;t have this constant defined */</span><br><span> #ifndef IFNAM=
SIZ</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARG=
ET_HAIKU)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* iface n=
ames are full /dev path with driver name */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define IFNAMSIZ PATH_MAX</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#else</span><br><span> #define IFNAMSIZ 16</s=
pan><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span>     char iface[IFNAMSIZ]; /* interface name (null=
 terminated), may be empty */</span><br><span> #endif</span><br><span> </sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/689?usp=3Demail">change 689</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/689?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6de60ed5c03ea45e1d7a3f7777b=
fc8ed5075e84d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 689 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--r6OMEUqLwYA=--

