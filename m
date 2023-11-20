From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 11:44:17 +0000
In-Reply-To: <gerrit.1700475817000.I2cc8f9b82079acca250db5871ffd9fad2997d1a8@...2715...>
References: <gerrit.1700475817000.I2cc8f9b82079acca250db5871ffd9fad2997d1a8@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <007060512ff4aeb2f960cfd2bcee1c81eea241e5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XaQg6u0zGZ4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add check for nice
 in cmake config
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

--XaQg6u0zGZ4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/444?usp=3Demail

to look at the new patch set (#2).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: Add check for nice in cmake config
......................................................................

Add check for nice in cmake config

Change-Id: I2cc8f9b82079acca250db5871ffd9fad2997d1a8
---
M CMakeLists.txt
M config.h.cmake.in
2 files changed, 2 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/444/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index fe9b596..f82ee96 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -146,6 +146,7 @@
 check_symbol_exists(fork unistd.h HAVE_FORK)
 check_symbol_exists(execve unistd.h HAVE_EXECVE)
 check_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)
+check_symbol_exists(nice unistd.h HAVE_NICE)
 check_symbol_exists(setgid unistd.h HAVE_SETGID)
 check_symbol_exists(setuid unistd.h HAVE_SETUID)
 check_symbol_exists(setsid unistd.h HAVE_SETSID)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 25273ac..c1f5848 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -209,7 +209,7 @@
 #cmakedefine HAVE_NET_TUN_IF_TUN_H

 /* Define to 1 if you have the `nice' function. */
-#undef HAVE_NICE
+#cmakedefine HAVE_NICE

 /* Define to 1 if you have the `openlog' function. */
 #cmakedefine HAVE_OPENLOG

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/444?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2cc8f9b82079acca250db5871ffd9fad2997d1a8
Gerrit-Change-Number: 444
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--XaQg6u0zGZ4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/444?usp=3Demail">View Chang=
e</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule is=
 unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">Add check for nice in cmake config<br><br>Change-Id: I2cc=
8f9b82079acca250db5871ffd9fad2997d1a8<br>---<br>M CMakeLists.txt<br>M confi=
g.h.cmake.in<br>2 files changed, 2 insertions(+), 1 deletion(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/444/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index fe9b59=
6..f82ee96 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ =
b/CMakeLists.txt</span><br><span>@@ -146,6 +146,7 @@</span><br><span> check=
_symbol_exists(fork unistd.h HAVE_FORK)</span><br><span> check_symbol_exist=
s(execve unistd.h HAVE_EXECVE)</span><br><span> check_symbol_exists(ftrunca=
te unistd.h HAVE_FTRUNCATE)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+check_symbol_exists(nice unistd.h HAVE_NICE)</span><br><span> check=
_symbol_exists(setgid unistd.h HAVE_SETGID)</span><br><span> check_symbol_e=
xists(setuid unistd.h HAVE_SETUID)</span><br><span> check_symbol_exists(set=
sid unistd.h HAVE_SETSID)</span><br><span>diff --git a/config.h.cmake.in b/=
config.h.cmake.in</span><br><span>index 25273ac..c1f5848 100644</span><br><=
span>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span>=
<br><span>@@ -209,7 +209,7 @@</span><br><span> #cmakedefine HAVE_NET_TUN_IF=
_TUN_H</span><br><span> </span><br><span> /* Define to 1 if you have the `n=
ice&#39; function. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#undef HAVE_NICE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cm=
akedefine HAVE_NICE</span><br><span> </span><br><span> /* Define to 1 if yo=
u have the `openlog&#39; function. */</span><br><span> #cmakedefine HAVE_OP=
ENLOG</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/444?usp=3Demail">change 444</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/444?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2cc8f9b82079acca250db5871ff=
d9fad2997d1a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 444 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--XaQg6u0zGZ4=--

