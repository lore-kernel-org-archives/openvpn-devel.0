From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Jun 2024 16:55:39 +0000
In-Reply-To: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
References: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <be72d4db1c70f45e017da1dfdf3bd34663b2ff97-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MVG/CyTCvmc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Try to
 detect LZO with pkg-config
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

--MVG/CyTCvmc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/55=
6?usp=3Demail )

Change subject: configure: Try to detect LZO with pkg-config
......................................................................

configure: Try to detect LZO with pkg-config

On most systems this should work just fine.

v2:
 - simplify code by removing -llzo special handling
v3:
 - reintroduce support for autodetection without pkg-config,
   no need to break backwards compatibility right now
v7:
 - Handle case correctly where lzo/lzo1x.h can not be included
   at all. On most distros this works even though the .pc
   file suggests to use it without. We had some partly
   solution for that but it wasn't really working.
v8:
 - Handle systems that do not implicitly include limits.h
   in configure test builds.
   lzodefs.h usually relies on lzoconf.h to include it.

Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240626161921.179301-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
848.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M config.h.cmake.in
M configure.ac
M src/openvpn/lzo.h
3 files changed, 23 insertions(+), 12 deletions(-)




diff --git a/config.h.cmake.in b/config.h.cmake.in
index effca2a..720d679 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -178,9 +178,6 @@
 /* Define to 1 if you have the <linux/types.h> header file. */
 #cmakedefine HAVE_LINUX_TYPES_H

-/* Define to 1 if you have the <lzoconf.h> header file. */
-#define HAVE_LZO_CONF_H
-
 /* Define to 1 if you have the <lzo1x.h> header file. */
 #define HAVE_LZO1X_H 1

diff --git a/configure.ac b/configure.ac
index c01ad09..555c97e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1143,8 +1143,17 @@

 AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])
 AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])
-have_lzo=3D"yes"
-if test -z "${LZO_LIBS}"; then
+if test -z "${LZO_CFLAGS}" -a -z "${LZO_LIBS}"; then
+    # if the user did not explicitly specify flags, try to autodetect
+    PKG_CHECK_MODULES([LZO],
+		[lzo2],
+		[have_lzo=3D"yes"],
+		[]
+    )
+
+    if test "${have_lzo}" !=3D "yes"; then
+	# try to detect without pkg-config
+	have_lzo=3D"yes"
 	AC_CHECK_LIB(
 		[lzo2],
 		[lzo1x_1_15_compress],
@@ -1156,6 +1165,10 @@
 			[have_lzo=3D"no"]
 		)]
 	)
+    fi
+else
+    # assume the user configured it correctly
+    have_lzo=3D"yes"
 fi
 if test "${have_lzo}" =3D "yes"; then
 	saved_CFLAGS=3D"${CFLAGS}"
@@ -1166,8 +1179,11 @@
 		[AC_CHECK_HEADERS(
 			[lzo1x.h],
 			,
-			[AC_MSG_ERROR([lzo1x.h is missing])]
-		)]
+			[AC_MSG_ERROR([lzo1x.h is missing])],
+                        [#include <limits.h>
+                         #include <lzodefs.h>
+                         #include <lzoconf.h>]
+		)],
 	)
 	CFLAGS=3D"${saved_CFLAGS}"
 fi
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index 62d73a1..c271527 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -37,17 +37,15 @@
  * @addtogroup compression
  * @{
  */
-#if defined(HAVE_LZO_CONF_H)
+#if defined(HAVE_LZO_LZO1X_H)
+#include <lzo/lzo1x.h>
+#elif defined(HAVE_LZO1X_H)
 /* The lzo.h magic gets confused and still wants
  * to include lzo/lzoconf.h even if our include paths
  * are setup to include the paths without lzo/
  */
 #include <lzodefs.h>
 #include <lzoconf.h>
-#endif
-#if defined(HAVE_LZO_LZO1X_H)
-#include <lzo/lzo1x.h>
-#elif defined(HAVE_LZO1X_H)
 #include <lzo1x.h>
 #endif


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Gerrit-Change-Number: 556
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--MVG/CyTCvmc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/556?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">configure: Try to detect LZO with pkg-config<b=
r><br>On most systems this should work just fine.<br><br>v2:<br> - simplify=
 code by removing -llzo special handling<br>v3:<br> - reintroduce support f=
or autodetection without pkg-config,<br>   no need to break backwards compa=
tibility right now<br>v7:<br> - Handle case correctly where lzo/lzo1x.h can=
 not be included<br>   at all. On most distros this works even though the .=
pc<br>   file suggests to use it without. We had some partly<br>   solution=
 for that but it wasn&#39;t really working.<br>v8:<br> - Handle systems tha=
t do not implicitly include limits.h<br>   in configure test builds.<br>   =
lzodefs.h usually relies on lzoconf.h to include it.<br><br>Change-Id: I1c0=
38dc4ec80d3499582d81eee61fee74f26e693<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>Message-Id: &lt;20240626161921.179301-1-frank@...2641...&gt;<br>URL: http=
s://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28848.html<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M config.h=
.cmake.in<br>M configure.ac<br>M src/openvpn/lzo.h<br>3 files changed, 23 i=
nsertions(+), 12 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><span>index=
 effca2a..720d679 100644</span><br><span>--- a/config.h.cmake.in</span><br>=
<span>+++ b/config.h.cmake.in</span><br><span>@@ -178,9 +178,6 @@</span><br=
><span> /* Define to 1 if you have the &lt;linux/types.h&gt; header file. *=
/</span><br><span> #cmakedefine HAVE_LINUX_TYPES_H</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have t=
he &lt;lzoconf.h&gt; header file. */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define HAVE_LZO_CONF_H</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /* Define to 1 if you have the &lt;lzo1x=
.h&gt; header file. */</span><br><span> #define HAVE_LZO1X_H 1</span><br><s=
pan> </span><br><span>diff --git a/configure.ac b/configure.ac</span><br><s=
pan>index c01ad09..555c97e 100644</span><br><span>--- a/configure.ac</span>=
<br><span>+++ b/configure.ac</span><br><span>@@ -1143,8 +1143,17 @@</span><=
br><span> </span><br><span> AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for =
lzo])</span><br><span> AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-have_lzo=3D&quot;yes&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-if test -z &quot;${LZO=
_LIBS}&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
f test -z &quot;${LZO_CFLAGS}&quot; -a -z &quot;${LZO_LIBS}&quot;; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    # if the user did n=
ot explicitly specify flags, try to autodetect</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    PKG_CHECK_MODULES([LZO],</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+		[lzo2],</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+		[have_lzo=3D&quot;yes&quot;],</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+		[]</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    )</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if tes=
t &quot;${have_lzo}&quot; !=3D &quot;yes&quot;; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	# try to detect without pkg-config</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	have_lzo=3D&quot;yes&quo=
t;</span><br><span> 	AC_CHECK_LIB(</span><br><span> 		[lzo2],</span><br><sp=
an> 		[lzo1x_1_15_compress],</span><br><span>@@ -1156,6 +1165,10 @@</span><=
br><span> 			[have_lzo=3D&quot;no&quot;]</span><br><span> 		)]</span><br><s=
pan> 	)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    # assume the user configured it corr=
ectly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    have_lzo=
=3D&quot;yes&quot;</span><br><span> fi</span><br><span> if test &quot;${hav=
e_lzo}&quot; =3D &quot;yes&quot;; then</span><br><span> 	saved_CFLAGS=3D&qu=
ot;${CFLAGS}&quot;</span><br><span>@@ -1166,8 +1179,11 @@</span><br><span> =
		[AC_CHECK_HEADERS(</span><br><span> 			[lzo1x.h],</span><br><span> 			,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[AC_MSG_ERROR([lzo1x=
.h is missing])]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		)]<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[AC_MSG_ERROR([lz=
o1x.h is missing])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        [#include &lt;limits.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                         #include &lt;lzo=
defs.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                #include &lt;lzoconf.h&gt;]</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+		)],</span><br><span> 	)</span><br><span> 	CFLAGS=
=3D&quot;${saved_CFLAGS}&quot;</span><br><span> fi</span><br><span>diff --g=
it a/src/openvpn/lzo.h b/src/openvpn/lzo.h</span><br><span>index 62d73a1..c=
271527 100644</span><br><span>--- a/src/openvpn/lzo.h</span><br><span>+++ b=
/src/openvpn/lzo.h</span><br><span>@@ -37,17 +37,15 @@</span><br><span>  * =
@addtogroup compression</span><br><span>  * @{</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_LZO_CONF_H)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(HAVE_LZO=
_LZO1X_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;lzo/lzo1x.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
elif defined(HAVE_LZO1X_H)</span><br><span> /* The lzo.h magic gets confuse=
d and still wants</span><br><span>  * to include lzo/lzoconf.h even if our =
include paths</span><br><span>  * are setup to include the paths without lz=
o/</span><br><span>  */</span><br><span> #include &lt;lzodefs.h&gt;</span><=
br><span> #include &lt;lzoconf.h&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(HAVE_LZO_LZO1X_H)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#include &lt;lzo/lzo1x.h&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#elif defined(HAVE_LZO1X_H)</span><br><span> #include &lt;lz=
o1x.h&gt;</span><br><span> #endif</span><br><span> </span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/556?usp=3Demail">change 556</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee6=
1fee74f26e693 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 556 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--MVG/CyTCvmc=--

