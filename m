From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 9 May 2024 10:12:52 +0000
In-Reply-To: <gerrit.1715191782000.I85d4d27333773e8df109e42b1fa56ccf57994e57@...2715...>
References: <gerrit.1715191782000.I85d4d27333773e8df109e42b1fa56ccf57994e57@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <459e40d1b0a05a8bc473729bb65ba6561a306152-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PjQ1jGBQmyY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PjQ1jGBQmyY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/585?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/585/2

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
Gerrit-MessageType: newpatchset

--PjQ1jGBQmyY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
585?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Support OpenBSD with cmake<br><br>Change-Id: =
I85d4d27333773e8df109e42b1fa56ccf57994e57<br>Signed-off-by: Arne Schwabe &l=
t;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>Message-Id: &lt;20240508220512.12362-1-gert@...1296...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28648.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeL=
ists.txt<br>1 file changed, 3 insertions(+), 1 deletion(-)<br><br></pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/585/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 3127611..f8=
b37a9 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMa=
keLists.txt</span><br><span>@@ -136,6 +136,8 @@</span><br><span>     set(TA=
RGET_FREEBSD YES)</span><br><span>     set(ENABLE_DCO YES)</span><br><span>=
     link_libraries(-lnv)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+elseif (${CMAKE_SYSTEM_NAME} STREQUAL &quot;OpenBSD&quot;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    set(TARGET_OPENBSD YES)</s=
pan><br><span> elseif (${CMAKE_SYSTEM_NAME} STREQUAL &quot;SunOS&quot;)</sp=
an><br><span>     set(TARGET_SOLARIS YES)</span><br><span>     set(HAVE_SYS=
_SOCKIO_H 1)</span><br><span>@@ -169,7 +171,7 @@</span><br><span> check_sym=
bol_exists(setgid unistd.h HAVE_SETGID)</span><br><span> check_symbol_exist=
s(setuid unistd.h HAVE_SETUID)</span><br><span> check_symbol_exists(setsid =
unistd.h HAVE_SETSID)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
check_symbol_exists(getpeereid unistd.h HAVE_GETPEEREID)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(getpeereid &quot;u=
nistd.h;sys/socket.h&quot; HAVE_GETPEEREID)</span><br><span> </span><br><sp=
an> check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)</span><=
br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/585?usp=3Demail">change 585</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/585?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--PjQ1jGBQmyY=--

