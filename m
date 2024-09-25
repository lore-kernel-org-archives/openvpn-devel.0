From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 16:36:45 +0000
In-Reply-To: <gerrit.1727273213000.Ia020c696f63a2a317f001c061b2ab4da69977750@...2715...>
References: <gerrit.1727273213000.Ia020c696f63a2a317f001c061b2ab4da69977750@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3a2b124e44d6ccd03f75c359183362126db865f4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5u28UcMClXI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix check for CMake
 not detecting struct cmsg
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

--5u28UcMClXI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/771?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Fix check for CMake not detecting struct cmsg
......................................................................

Fix check for CMake not detecting struct cmsg

This check seems to have never worked and on Linux we hard coded
the check instead. Remove this hard coded assumption and use a
working check based on check_struct_has_member instead.

This is has the side-effect of port-sharing being enabled on macOS
when compiled with cmake.

Change-Id: Ia020c696f63a2a317f001c061b2ab4da69977750
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240925151342.13307-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
448.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
1 file changed, 5 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/771/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6271574..5db207d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -131,7 +131,6 @@
     set(ENABLE_FEATURE_TUN_PERSIST 1)
     set(HAVE_LINUX_TYPES_H 1)
     set(ENABLE_DCO YES)
-    set(HAVE_CMSGHDR YES)
 elseif (${CMAKE_SYSTEM_NAME} STREQUAL "FreeBSD")
     set(TARGET_FREEBSD YES)
     set(ENABLE_DCO YES)
@@ -185,7 +184,6 @@

 check_symbol_exists(sendmsg sys/socket.h HAVE_SENDMSG)
 check_symbol_exists(recvmsg sys/socket.h HAVE_RECVMSG)
-check_symbol_exists(cmsghdr sys/socket.h HAVE_CMSGHDR)
 check_symbol_exists(openlog syslog.h HAVE_OPENLOG)
 check_symbol_exists(syslog syslog.h HAVE_SYSLOG)
 check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)
@@ -193,6 +191,11 @@
 check_symbol_exists(getsockname sys/socket.h HAVE_GETSOCKNAME)
 check_symbol_exists(getrlimit "sys/time.h;sys/resource.h" HAVE_GETRLIMIT)

+# Checking for existence of structs with check_symbol_exists does not work,
+# so we use check_struct_hash_member with a member instead
+check_struct_has_member("struct cmsghdr" cmsg_len sys/socket.h HAVE_CMSGHD=
R)
+
+
 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
 set(NETEXTRA sys/types.h)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/771?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia020c696f63a2a317f001c061b2ab4da69977750
Gerrit-Change-Number: 771
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--5u28UcMClXI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
771?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix check for CMake not detecting struct cmsg=
<br><br>This check seems to have never worked and on Linux we hard coded<br=
>the check instead. Remove this hard coded assumption and use a<br>working =
check based on check_struct_has_member instead.<br><br>This is has the side=
-effect of port-sharing being enabled on macOS<br>when compiled with cmake.=
<br><br>Change-Id: Ia020c696f63a2a317f001c061b2ab4da69977750<br>Signed-off-=
by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Frank Lichten=
held &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240925151342.13307-1-ger=
t@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg29448.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M CMakeLists.txt<br>1 file changed, 5 insertions(+), 2 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/71/771/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span=
><br><span>index 6271574..5db207d 100644</span><br><span>--- a/CMakeLists.t=
xt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -131,7 +131,6 @@=
</span><br><span>     set(ENABLE_FEATURE_TUN_PERSIST 1)</span><br><span>   =
  set(HAVE_LINUX_TYPES_H 1)</span><br><span>     set(ENABLE_DCO YES)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    set(HAVE_CMSGHDR YES)</s=
pan><br><span> elseif (${CMAKE_SYSTEM_NAME} STREQUAL &quot;FreeBSD&quot;)</=
span><br><span>     set(TARGET_FREEBSD YES)</span><br><span>     set(ENABLE=
_DCO YES)</span><br><span>@@ -185,7 +184,6 @@</span><br><span> </span><br><=
span> check_symbol_exists(sendmsg sys/socket.h HAVE_SENDMSG)</span><br><spa=
n> check_symbol_exists(recvmsg sys/socket.h HAVE_RECVMSG)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-check_symbol_exists(cmsghdr sys/socket.=
h HAVE_CMSGHDR)</span><br><span> check_symbol_exists(openlog syslog.h HAVE_=
OPENLOG)</span><br><span> check_symbol_exists(syslog syslog.h HAVE_SYSLOG)<=
/span><br><span> check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)</span><b=
r><span>@@ -193,6 +191,11 @@</span><br><span> check_symbol_exists(getsockna=
me sys/socket.h HAVE_GETSOCKNAME)</span><br><span> check_symbol_exists(getr=
limit &quot;sys/time.h;sys/resource.h&quot; HAVE_GETRLIMIT)</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Checking for ex=
istence of structs with check_symbol_exists does not work,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# so we use check_struct_hash_member=
 with a member instead</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+check_struct_has_member(&quot;struct cmsghdr&quot; cmsg_len sys/socket.h=
 HAVE_CMSGHDR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Some=
 OS (e.g. FreeBSD) need some basic headers to allow</span><br><span> # incl=
uding network headers</span><br><span> set(NETEXTRA sys/types.h)</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/771?usp=3Demail">change 771</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/77=
1?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia020c696f63a2a317f001c061b2=
ab4da69977750 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 771 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--5u28UcMClXI=--

