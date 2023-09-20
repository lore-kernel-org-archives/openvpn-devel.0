From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 20 Sep 2023 20:36:03 +0000
In-Reply-To: <gerrit.1694783050000.I171d55da2be868d961caa1d4491e6f1ed10ebe8a@...2715...>
References: <gerrit.1694783050000.I171d55da2be868d961caa1d4491e6f1ed10ebe8a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <d3291ba121dd475a0e365901b729b1b41031864b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K+WQymdvlSg="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--K+WQymdvlSg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/34=
1?usp=3Demail )

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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20230920121519.177949-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
045.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M config.h.cmake.in
M src/compat/compat-daemon.c
3 files changed, 8 insertions(+), 4 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--K+WQymdvlSg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/341?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">CMake: fix broken daemonization and syslog fun=
ctionality<br><br>While CMake is not the official way to build OpenVPN on L=
inux,<br>it still make sense to support it. Turns out that<br><br>  HAVE_SE=
TSID, HAVE_OPENLOG and HAVE_SYSLOG<br><br>were not set by CMake configure, =
and --daemon and syslog<br>functionality was broken.<br><br>While on it, fi=
x compiler error on unused return value of chdir().<br><br>Change-Id: I171d=
55da2be868d961caa1d4491e6f1ed10ebe8a<br>Signed-off-by: Lev Stipakov &lt;lev=
@...515...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br=
>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20=
230920121519.177949-1-frank@...2641...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg27045.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M config.h=
.cmake.in<br>M src/compat/compat-daemon.c<br>3 files changed, 8 insertions(=
+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 7dae6=
65..9de6aba 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -150,6 +150,7 @@</span><br><span> chec=
k_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)</span><br><span> check_s=
ymbol_exists(setgid unistd.h HAVE_SETGID)</span><br><span> check_symbol_exi=
sts(setuid unistd.h HAVE_SETUID)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+check_symbol_exists(setsid unistd.h HAVE_SETSID)</span><br><sp=
an> check_symbol_exists(getpeereid unistd.h HAVE_GETPEEREID)</span><br><spa=
n> </span><br><span> check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOL=
L_CREATE)</span><br><span>diff --git a/config.h.cmake.in b/config.h.cmake.i=
n</span><br><span>index 4f28917..f2cdd39 100644</span><br><span>--- a/confi=
g.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -21=
8,7 +218,7 @@</span><br><span> #undef HAVE_NICE</span><br><span> </span><br=
><span> /* Define to 1 if you have the `openlog&#39; function. */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_OPENLOG</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_OPENLOG</span=
><br><span> </span><br><span> /* OpenSSL engine support available */</span>=
<br><span> #undef HAVE_OPENSSL_ENGINE</span><br><span>@@ -258,7 +258,7 @@</=
span><br><span> #undef HAVE_SETGROUPS</span><br><span> </span><br><span> /*=
 Define to 1 if you have the `setsid&#39; function. */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_SETSID</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SETSID</span><br><span>=
 </span><br><span> /* Define to 1 if you have the `setsockopt&#39; function=
. */</span><br><span> #define HAVE_SETSOCKOPT 1</span><br><span>@@ -303,7 +=
303,7 @@</span><br><span> #undef HAVE_STRSEP</span><br><span> </span><br><s=
pan> /* Define to 1 if you have the `syslog&#39; function. */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_SYSLOG</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_SYSLOG</span><br><=
span> </span><br><span> /* Define to 1 if you have the &lt;syslog.h&gt; hea=
der file. */</span><br><span> #cmakedefine HAVE_SYSLOG_H</span><br><span>di=
ff --git a/src/compat/compat-daemon.c b/src/compat/compat-daemon.c</span><b=
r><span>index aebb8f4..5c6d740 100644</span><br><span>--- a/src/compat/comp=
at-daemon.c</span><br><span>+++ b/src/compat/compat-daemon.c</span><br><spa=
n>@@ -70,7 +70,10 @@</span><br><span> </span><br><span>     if (!nochdir)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        chdir(&quot;/&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (chdir(&quot;/&quot;) =3D=3D -1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return (-1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><sp=
an> </span><br><span>     if (!noclose)</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/341?usp=3D=
email">change 341</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/341?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I171d55da2be868d961caa1d4491=
e6f1ed10ebe8a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 341 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--K+WQymdvlSg=--

