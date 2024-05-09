From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 9 May 2024 10:12:54 +0000
In-Reply-To: <gerrit.1715191782000.I85d4d27333773e8df109e42b1fa56ccf57994e57@...2715...>
References: <gerrit.1715191782000.I85d4d27333773e8df109e42b1fa56ccf57994e57@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <459e40d1b0a05a8bc473729bb65ba6561a306152-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jNCPk1JWKRc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Support OpenBSD
 with cmake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jNCPk1JWKRc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/58=
5?usp=3Demail )

Change subject: Support OpenBSD with cmake
......................................................................

Support OpenBSD with cmake

Change-Id: I85d4d27333773e8df109e42b1fa56ccf57994e57
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240508220512.12362-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
648.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
1 file changed, 3 insertions(+), 1 deletion(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 3127611..f8b37a9 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -136,6 +136,8 @@
     set(TARGET_FREEBSD YES)
     set(ENABLE_DCO YES)
     link_libraries(-lnv)
+elseif (${CMAKE_SYSTEM_NAME} STREQUAL "OpenBSD")
+    set(TARGET_OPENBSD YES)
 elseif (${CMAKE_SYSTEM_NAME} STREQUAL "SunOS")
     set(TARGET_SOLARIS YES)
     set(HAVE_SYS_SOCKIO_H 1)
@@ -169,7 +171,7 @@
 check_symbol_exists(setgid unistd.h HAVE_SETGID)
 check_symbol_exists(setuid unistd.h HAVE_SETUID)
 check_symbol_exists(setsid unistd.h HAVE_SETSID)
-check_symbol_exists(getpeereid unistd.h HAVE_GETPEEREID)
+check_symbol_exists(getpeereid "unistd.h;sys/socket.h" HAVE_GETPEEREID)

 check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/585?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I85d4d27333773e8df109e42b1fa56ccf57994e57
Gerrit-Change-Number: 585
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--jNCPk1JWKRc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/585?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Support OpenBSD with cmake<br><br>Change-Id: I=
85d4d27333773e8df109e42b1fa56ccf57994e57<br>Signed-off-by: Arne Schwabe &lt=
;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>Message-Id: &lt;20240508220512.12362-1-gert@...1296...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28648.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLi=
sts.txt<br>1 file changed, 3 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 31276=
11..f8b37a9 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -136,6 +136,8 @@</span><br><span>     =
set(TARGET_FREEBSD YES)</span><br><span>     set(ENABLE_DCO YES)</span><br>=
<span>     link_libraries(-lnv)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+elseif (${CMAKE_SYSTEM_NAME} STREQUAL &quot;OpenBSD&quot;)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    set(TARGET_OPENBSD Y=
ES)</span><br><span> elseif (${CMAKE_SYSTEM_NAME} STREQUAL &quot;SunOS&quot=
;)</span><br><span>     set(TARGET_SOLARIS YES)</span><br><span>     set(HA=
VE_SYS_SOCKIO_H 1)</span><br><span>@@ -169,7 +171,7 @@</span><br><span> che=
ck_symbol_exists(setgid unistd.h HAVE_SETGID)</span><br><span> check_symbol=
_exists(setuid unistd.h HAVE_SETUID)</span><br><span> check_symbol_exists(s=
etsid unistd.h HAVE_SETSID)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-check_symbol_exists(getpeereid unistd.h HAVE_GETPEEREID)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(getpeereid &=
quot;unistd.h;sys/socket.h&quot; HAVE_GETPEEREID)</span><br><span> </span><=
br><span> check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)</=
span><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/585?usp=3Demail">change 585</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/585?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I85d4d27333773e8df109e42b1fa=
56ccf57994e57 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 585 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--jNCPk1JWKRc=--

