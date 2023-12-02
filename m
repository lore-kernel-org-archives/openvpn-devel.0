From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 2 Dec 2023 16:07:32 +0000
In-Reply-To: <gerrit.1700475817000.I2cc8f9b82079acca250db5871ffd9fad2997d1a8@...2715...>
References: <gerrit.1700475817000.I2cc8f9b82079acca250db5871ffd9fad2997d1a8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cd355623473ccc87a0a6e0a4fe0ed50e54134361-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+KUFLCYZ2+k="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+KUFLCYZ2+k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/44=
4?usp=3Demail )

Change subject: Add check for nice in cmake config
......................................................................

Add check for nice in cmake config

Change-Id: I2cc8f9b82079acca250db5871ffd9fad2997d1a8
Acked-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Arne Schwabe <arne@...1227...>
Message-Id: <20231128104129.62761-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
574.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M config.h.cmake.in
2 files changed, 2 insertions(+), 1 deletion(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 4aa9793..db9966b 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -144,6 +144,7 @@
 check_symbol_exists(fork unistd.h HAVE_FORK)
 check_symbol_exists(execve unistd.h HAVE_EXECVE)
 check_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)
+check_symbol_exists(nice unistd.h HAVE_NICE)
 check_symbol_exists(setgid unistd.h HAVE_SETGID)
 check_symbol_exists(setuid unistd.h HAVE_SETUID)
 check_symbol_exists(setsid unistd.h HAVE_SETSID)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 848c505..0ef8fe3 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -215,7 +215,7 @@
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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--+KUFLCYZ2+k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/444?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Add check for nice in cmake config<br><br>Chan=
ge-Id: I2cc8f9b82079acca250db5871ffd9fad2997d1a8<br>Acked-by: Frank Lichten=
held &lt;frank@...2641...&gt;<br>Signed-off-by: Arne Schwabe &lt;arne@...1711...=
27...&gt;<br>Message-Id: &lt;20231128104129.62761-1-frank@...2641...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg2=
7574.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M CMakeLists.txt<br>M config.h.cmake.in<br>2 files changed, 2 insertions(+)=
, 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 4aa97=
93..db9966b 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -144,6 +144,7 @@</span><br><span> chec=
k_symbol_exists(fork unistd.h HAVE_FORK)</span><br><span> check_symbol_exis=
ts(execve unistd.h HAVE_EXECVE)</span><br><span> check_symbol_exists(ftrunc=
ate unistd.h HAVE_FTRUNCATE)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+check_symbol_exists(nice unistd.h HAVE_NICE)</span><br><span> chec=
k_symbol_exists(setgid unistd.h HAVE_SETGID)</span><br><span> check_symbol_=
exists(setuid unistd.h HAVE_SETUID)</span><br><span> check_symbol_exists(se=
tsid unistd.h HAVE_SETSID)</span><br><span>diff --git a/config.h.cmake.in b=
/config.h.cmake.in</span><br><span>index 848c505..0ef8fe3 100644</span><br>=
<span>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span=
><br><span>@@ -215,7 +215,7 @@</span><br><span> #cmakedefine HAVE_NET_TUN_I=
F_TUN_H</span><br><span> </span><br><span> /* Define to 1 if you have the `=
nice&#39; function. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#undef HAVE_NICE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#c=
makedefine HAVE_NICE</span><br><span> </span><br><span> /* Define to 1 if y=
ou have the `openlog&#39; function. */</span><br><span> #cmakedefine HAVE_O=
PENLOG</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/444?usp=3Demail">change 444</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/444?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2cc8f9b82079acca250db5871ff=
d9fad2997d1a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 444 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--+KUFLCYZ2+k=--

