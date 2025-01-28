From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 19:06:15 +0000
In-Reply-To: <gerrit.1738029022000.I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d@...2715...>
References: <gerrit.1738029022000.I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., alex@...2837...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d263fb19a5ef25723da6bf64b30179cd907bbae7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZbN4zcpcgcU="; charset=UTF-8
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
To: kallisti5 <alex@...2837...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZbN4zcpcgcU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/68=
9?usp=3Demail )

Change subject: Haiku: Fix short interface path length
......................................................................

Haiku: Fix short interface path length

* Haiku uses full paths for interface names, 16 characters
  isn't enough.

Change-Id: I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d
Signed-off-by: Alexander von Gluck <alex@...2837...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250128124026.108992-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
654.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.h
1 file changed, 7 insertions(+), 0 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--ZbN4zcpcgcU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/689?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Haiku: Fix short interface path length<br><br>=
* Haiku uses full paths for interface names, 16 characters<br>  isn&#39;t e=
nough.<br><br>Change-Id: I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d<br>Signe=
d-off-by: Alexander von Gluck &lt;alex@...2837...&gt;<br>Acked-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20250128124026.108992=
-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@=
lists.sourceforge.net/msg30654.html<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>---<br>M src/openvpn/route.h<br>1 file changed, 7 insert=
ions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/route.h b/src/openvpn/route.h</span><br><span>i=
ndex 421e7d2..69b06b8 100644</span><br><span>--- a/src/openvpn/route.h</spa=
n><br><span>+++ b/src/openvpn/route.h</span><br><span>@@ -155,6 +155,8 @@</=
span><br><span>     /* gateway interface */</span><br><span> #ifdef _WIN32<=
/span><br><span>     DWORD adapter_index; /* interface or ~0 if undefined *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARG=
ET_HAIKU)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char i=
face[PATH_MAX]; /* iface names are full /dev path with driver name */</span=
><br><span> #else</span><br><span>     char iface[16]; /* interface name (n=
ull terminated), may be empty */</span><br><span> #endif</span><br><span>@@=
 -186,8 +188,13 @@</span><br><span> #else</span><br><span>     /* non linux=
 platform don&#39;t have this constant defined */</span><br><span> #ifndef =
IFNAMSIZ</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(TARGET_HAIKU)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* if=
ace names are full /dev path with driver name */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define IFNAMSIZ PATH_MAX</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span> #define IFNAMSIZ =
16</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span>     char iface[IFNAMSIZ]; /* interface name =
(null terminated), may be empty */</span><br><span> #endif</span><br><span>=
 </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/689?usp=3Demail">change 689</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/689?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6de60ed5c03ea45e1d7a3f7777b=
fc8ed5075e84d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 689 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--ZbN4zcpcgcU=--

