From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 17 Jul 2024 20:04:58 +0000
In-Reply-To: <gerrit.1720531952000.I72934e747d1ad68a7e3675afbeb1b63df7941186@...2715...>
References: <gerrit.1720531952000.I72934e747d1ad68a7e3675afbeb1b63df7941186@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <934db7a34fef87c712bbb12df33666a0919360e8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WvFmVxuIIY8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: configure: Switch
 to C11 by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WvFmVxuIIY8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/67=
3?usp=3Demail )

Change subject: configure: Switch to C11 by default
......................................................................

configure: Switch to C11 by default

Mostly so we can use anonymous structs without jumping through
hoops or relying on unofficial support.

Change-Id: I72934e747d1ad68a7e3675afbeb1b63df7941186
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240710160306.190351-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
916.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M configure.ac
2 files changed, 3 insertions(+), 3 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 096837d..ad620fa 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -119,7 +119,7 @@
 set(OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})
 set(OPENVPN_VERSION_RESOURCE ${PRODUCT_VERSION_RESOURCE})

-set(CMAKE_C_STANDARD 99)
+set(CMAKE_C_STANDARD 11)

 # Set the various defines for config.h.cmake.in
 if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
diff --git a/configure.ac b/configure.ac
index 555c97e..9ce826c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -421,10 +421,10 @@
 AC_CHECK_PROGS([RST2HTML], [rst2html rst2html.py])
 AM_CONDITIONAL([HAVE_PYDOCUTILS], [test "${RST2MAN}" -a "${RST2HTML}"])

-# Set -std=3Dc99 unless user already specified a -std=3D
+# Set -std=3Dc11 unless user already specified a -std=3D
 case "${CFLAGS}" in
   *-std=3D*) ;;
-  *)       CFLAGS=3D"${CFLAGS} -std=3Dc99" ;;
+  *)       CFLAGS=3D"${CFLAGS} -std=3Dc11" ;;
 esac

 #

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/673?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I72934e747d1ad68a7e3675afbeb1b63df7941186
Gerrit-Change-Number: 673
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--WvFmVxuIIY8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/673?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">configure: Switch to C11 by default<br><br>Mos=
tly so we can use anonymous structs without jumping through<br>hoops or rel=
ying on unofficial support.<br><br>Change-Id: I72934e747d1ad68a7e3675afbeb1=
b63df7941186<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt=
;20240710160306.190351-1-frank@...2641...&gt;<br>URL: https://www.mail-arch=
ive.com/openvpn-devel@lists.sourceforge.net/msg28916.html<br>Signed-off-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M confi=
gure.ac<br>2 files changed, 3 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 09683=
7d..ad620fa 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -119,7 +119,7 @@</span><br><span> set(=
OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})</span><br><span> set(OPENVP=
N_VERSION_RESOURCE ${PRODUCT_VERSION_RESOURCE})</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-set(CMAKE_C_STANDARD 99)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+set(CMAKE_C_STANDARD 11)</=
span><br><span> </span><br><span> # Set the various defines for config.h.cm=
ake.in</span><br><span> if (${CMAKE_SYSTEM_NAME} STREQUAL &quot;Linux&quot;=
)</span><br><span>diff --git a/configure.ac b/configure.ac</span><br><span>=
index 555c97e..9ce826c 100644</span><br><span>--- a/configure.ac</span><br>=
<span>+++ b/configure.ac</span><br><span>@@ -421,10 +421,10 @@</span><br><s=
pan> AC_CHECK_PROGS([RST2HTML], [rst2html rst2html.py])</span><br><span> AM=
_CONDITIONAL([HAVE_PYDOCUTILS], [test &quot;${RST2MAN}&quot; -a &quot;${RST=
2HTML}&quot;])</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# Set -std=3Dc99 unless user already specified a -std=3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# Set -std=3Dc11 unless use=
r already specified a -std=3D</span><br><span> case &quot;${CFLAGS}&quot; i=
n</span><br><span>   *-std=3D*) ;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  *)       CFLAGS=3D&quot;${CFLAGS} -std=3Dc99&quot; ;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  *)       CFLAGS=3D&quot;=
${CFLAGS} -std=3Dc11&quot; ;;</span><br><span> esac</span><br><span> </span=
><br><span> #</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/673?usp=3Demail">change 673</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/673?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I72934e747d1ad68a7e3675afbeb=
1b63df7941186 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 673 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--WvFmVxuIIY8=--

