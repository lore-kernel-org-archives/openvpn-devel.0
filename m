From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 8 May 2024 18:09:48 +0000
References: <gerrit.1715191782000.I85d4d27333773e8df109e42b1fa56ccf57994e57@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <71594b6f52f7888e7e421e020cf43d8c714ea13b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9LqXtgK+UbE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9LqXtgK+UbE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/585?usp=3Demail

to review the following change.


Change subject: Support OpenBSD with cmake
......................................................................

Support OpenBSD with cmake

Change-Id: I85d4d27333773e8df109e42b1fa56ccf57994e57
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
1 file changed, 3 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/585/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--9LqXtgK+UbE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/585?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Support OpenBSD with cmake<br><br>Change-Id: I85d4d27333773e8=
df109e42b1fa56ccf57994e57<br>Signed-off-by: Arne Schwabe &lt;arne@...2477...=
.&gt;<br>---<br>M CMakeLists.txt<br>1 file changed, 3 insertions(+), 1 dele=
tion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/85/585/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br=
><span>index 3127611..f8b37a9 100644</span><br><span>--- a/CMakeLists.txt</=
span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -136,6 +136,8 @@</sp=
an><br><span>     set(TARGET_FREEBSD YES)</span><br><span>     set(ENABLE_D=
CO YES)</span><br><span>     link_libraries(-lnv)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+elseif (${CMAKE_SYSTEM_NAME} STREQUAL &quot;O=
penBSD&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    se=
t(TARGET_OPENBSD YES)</span><br><span> elseif (${CMAKE_SYSTEM_NAME} STREQUA=
L &quot;SunOS&quot;)</span><br><span>     set(TARGET_SOLARIS YES)</span><br=
><span>     set(HAVE_SYS_SOCKIO_H 1)</span><br><span>@@ -169,7 +171,7 @@</s=
pan><br><span> check_symbol_exists(setgid unistd.h HAVE_SETGID)</span><br><=
span> check_symbol_exists(setuid unistd.h HAVE_SETUID)</span><br><span> che=
ck_symbol_exists(setsid unistd.h HAVE_SETSID)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-check_symbol_exists(getpeereid unistd.h HAVE_GETPEE=
REID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_e=
xists(getpeereid &quot;unistd.h;sys/socket.h&quot; HAVE_GETPEEREID)</span><=
br><span> </span><br><span> check_symbol_exists(epoll_create sys/epoll.h HA=
VE_EPOLL_CREATE)</span><br><span> </span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/585?usp=3Demail=
">change 585</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/585?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I85d4d27333773e8df109e42b1fa=
56ccf57994e57 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 585 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--9LqXtgK+UbE=--

