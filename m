From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 10:23:43 +0000
References: <gerrit.1700475817000.I2cc8f9b82079acca250db5871ffd9fad2997d1a8@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0c4e74fd006c680b5596cbe75eaa05bac1110a58-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WPqJnf1FKNo="; charset=UTF-8
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

--WPqJnf1FKNo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/444?usp=3Demail

to review the following change.


Change subject: Add check for nice in cmake config
......................................................................

Add check for nice in cmake config

Change-Id: I2cc8f9b82079acca250db5871ffd9fad2997d1a8
---
M CMakeLists.txt
M config.h.cmake.in
2 files changed, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/444/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--WPqJnf1FKNo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/444?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add check for nice in cmake config<br><br>Change-Id: I2cc8f9b=
82079acca250db5871ffd9fad2997d1a8<br>---<br>M CMakeLists.txt<br>M config.h.=
cmake.in<br>2 files changed, 2 insertions(+), 1 deletion(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/444/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index fe9b596..f=
82ee96 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CM=
akeLists.txt</span><br><span>@@ -146,6 +146,7 @@</span><br><span> check_sym=
bol_exists(fork unistd.h HAVE_FORK)</span><br><span> check_symbol_exists(ex=
ecve unistd.h HAVE_EXECVE)</span><br><span> check_symbol_exists(ftruncate u=
nistd.h HAVE_FTRUNCATE)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+check_symbol_exists(nice unistd.h HAVE_NICE)</span><br><span> check_sym=
bol_exists(setgid unistd.h HAVE_SETGID)</span><br><span> check_symbol_exist=
s(setuid unistd.h HAVE_SETUID)</span><br><span> check_symbol_exists(setsid =
unistd.h HAVE_SETSID)</span><br><span>diff --git a/config.h.cmake.in b/conf=
ig.h.cmake.in</span><br><span>index 25273ac..c1f5848 100644</span><br><span=
>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br>=
<span>@@ -209,7 +209,7 @@</span><br><span> #cmakedefine HAVE_NET_TUN_IF_TUN=
_H</span><br><span> </span><br><span> /* Define to 1 if you have the `nice&=
#39; function. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#und=
ef HAVE_NICE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmaked=
efine HAVE_NICE</span><br><span> </span><br><span> /* Define to 1 if you ha=
ve the `openlog&#39; function. */</span><br><span> #cmakedefine HAVE_OPENLO=
G</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/444?usp=3Demail">change 444</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/444?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2cc8f9b82079acca250db5871ff=
d9fad2997d1a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 444 </div>
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


--WPqJnf1FKNo=--

