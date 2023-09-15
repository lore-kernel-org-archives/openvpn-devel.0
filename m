From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 15 Sep 2023 13:04:14 +0000
References: <gerrit.1694783050000.I171d55da2be868d961caa1d4491e6f1ed10ebe8a@...2715...>
Reply-To: lstipakov@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <27f10f2682d4c21ab0b6d26c5343f243c2532fa3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cXNdrFNyrfo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: CMake: fix broken
 daemonization and syslog functionality
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

--cXNdrFNyrfo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/341?usp=3Demail

to review the following change.


Change subject: CMake: fix broken daemonization and syslog functionality
......................................................................

CMake: fix broken daemonization and syslog functionality

While CMake is not the official way to build OpenVPN on Linux,
it still make sense to support it. Turns out that

  HAVE_SETSID, HAVE_OPENLOG and HAVE_SYSLOG

were not set by CMake configure, and --daemon and syslog
functionality was broken.

While on it, fix compiler error on unused return value of chdir().

Change-Id: I171d55da2be868d961caa1d4491e6f1ed10ebe8a
Signed-off-by: Lev Stipakov <lev@...515...>
---
M CMakeLists.txt
M config.h.cmake.in
M src/compat/compat-daemon.c
3 files changed, 8 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/341/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7dae665..9de6aba 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -150,6 +150,7 @@
 check_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)
 check_symbol_exists(setgid unistd.h HAVE_SETGID)
 check_symbol_exists(setuid unistd.h HAVE_SETUID)
+check_symbol_exists(setsid unistd.h HAVE_SETSID)
 check_symbol_exists(getpeereid unistd.h HAVE_GETPEEREID)

 check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 4f28917..f2cdd39 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -218,7 +218,7 @@
 #undef HAVE_NICE

 /* Define to 1 if you have the `openlog' function. */
-#undef HAVE_OPENLOG
+#cmakedefine HAVE_OPENLOG

 /* OpenSSL engine support available */
 #undef HAVE_OPENSSL_ENGINE
@@ -258,7 +258,7 @@
 #undef HAVE_SETGROUPS

 /* Define to 1 if you have the `setsid' function. */
-#undef HAVE_SETSID
+#cmakedefine HAVE_SETSID

 /* Define to 1 if you have the `setsockopt' function. */
 #define HAVE_SETSOCKOPT 1
@@ -303,7 +303,7 @@
 #undef HAVE_STRSEP

 /* Define to 1 if you have the `syslog' function. */
-#undef HAVE_SYSLOG
+#cmakedefine HAVE_SYSLOG

 /* Define to 1 if you have the <syslog.h> header file. */
 #cmakedefine HAVE_SYSLOG_H
diff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c
index aebb8f4..5c6d740 100644
--- a/src/compat/compat-daemon.c
+++ b/src/compat/compat-daemon.c
@@ -70,7 +70,10 @@

     if (!nochdir)
     {
-        chdir("/");
+        if (chdir("/") =3D=3D -1)
+        {
+            return (-1);
+        }
     }

     if (!noclose)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/341?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I171d55da2be868d961caa1d4491e6f1ed10ebe8a
Gerrit-Change-Number: 341
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--cXNdrFNyrfo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>stipa would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/341?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">CMake: fix broken daemonization and syslog functionality<br><=
br>While CMake is not the official way to build OpenVPN on Linux,<br>it sti=
ll make sense to support it. Turns out that<br><br>  HAVE_SETSID, HAVE_OPEN=
LOG and HAVE_SYSLOG<br><br>were not set by CMake configure, and --daemon an=
d syslog<br>functionality was broken.<br><br>While on it, fix compiler erro=
r on unused return value of chdir().<br><br>Change-Id: I171d55da2be868d961c=
aa1d4491e6f1ed10ebe8a<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<=
br>---<br>M CMakeLists.txt<br>M config.h.cmake.in<br>M src/compat/compat-da=
emon.c<br>3 files changed, 8 insertions(+), 4 deletions(-)<br><br></pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/341/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 7dae665..9d=
e6aba 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMa=
keLists.txt</span><br><span>@@ -150,6 +150,7 @@</span><br><span> check_symb=
ol_exists(ftruncate unistd.h HAVE_FTRUNCATE)</span><br><span> check_symbol_=
exists(setgid unistd.h HAVE_SETGID)</span><br><span> check_symbol_exists(se=
tuid unistd.h HAVE_SETUID)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+check_symbol_exists(setsid unistd.h HAVE_SETSID)</span><br><span> ch=
eck_symbol_exists(getpeereid unistd.h HAVE_GETPEEREID)</span><br><span> </s=
pan><br><span> check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREA=
TE)</span><br><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</spa=
n><br><span>index 4f28917..f2cdd39 100644</span><br><span>--- a/config.h.cm=
ake.in</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -218,7 +2=
18,7 @@</span><br><span> #undef HAVE_NICE</span><br><span> </span><br><span=
> /* Define to 1 if you have the `openlog&#39; function. */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_OPENLOG</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_OPENLOG</span><br><=
span> </span><br><span> /* OpenSSL engine support available */</span><br><s=
pan> #undef HAVE_OPENSSL_ENGINE</span><br><span>@@ -258,7 +258,7 @@</span><=
br><span> #undef HAVE_SETGROUPS</span><br><span> </span><br><span> /* Defin=
e to 1 if you have the `setsid&#39; function. */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#undef HAVE_SETSID</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SETSID</span><br><span> </span>=
<br><span> /* Define to 1 if you have the `setsockopt&#39; function. */</sp=
an><br><span> #define HAVE_SETSOCKOPT 1</span><br><span>@@ -303,7 +303,7 @@=
</span><br><span> #undef HAVE_STRSEP</span><br><span> </span><br><span> /* =
Define to 1 if you have the `syslog&#39; function. */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_SYSLOG</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SYSLOG</span><br><span> </=
span><br><span> /* Define to 1 if you have the &lt;syslog.h&gt; header file=
. */</span><br><span> #cmakedefine HAVE_SYSLOG_H</span><br><span>diff --git=
 a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c</span><br><span>=
index aebb8f4..5c6d740 100644</span><br><span>--- a/src/compat/compat-daemo=
n.c</span><br><span>+++ b/src/compat/compat-daemon.c</span><br><span>@@ -70=
,7 +70,10 @@</span><br><span> </span><br><span>     if (!nochdir)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
chdir(&quot;/&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (chdir(&quot;/&quot;) =3D=3D -1)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return (-1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </sp=
an><br><span>     if (!noclose)</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/341?usp=3Demail">c=
hange 341</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/341?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I171d55da2be868d961caa1d4491=
e6f1ed10ebe8a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 341 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--cXNdrFNyrfo=--

