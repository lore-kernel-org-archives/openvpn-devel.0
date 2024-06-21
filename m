From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 21 Jun 2024 13:02:41 +0000
In-Reply-To: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
References: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <3535840333ffa844443c99961c6c4a7a7e9897fe-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uiUH+78g0Dw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uiUH+78g0Dw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail

to look at the new patch set (#7).


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

Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M config.h.cmake.in
M configure.ac
M src/openvpn/lzo.h
3 files changed, 22 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/556/7

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
index c01ad09..d7d1b18 100644
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
@@ -1166,8 +1179,10 @@
 		[AC_CHECK_HEADERS(
 			[lzo1x.h],
 			,
-			[AC_MSG_ERROR([lzo1x.h is missing])]
-		)]
+			[AC_MSG_ERROR([lzo1x.h is missing])],
+                        [#include <lzodefs.h>
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
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-MessageType: newpatchset

--uiUH+78g0Dw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #7</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">configure: Try to detect LZO with pkg-config<br><br>On most system=
s this should work just fine.<br><br>v2:<br> - simplify code by removing -l=
lzo special handling<br>v3:<br> - reintroduce support for autodetection wit=
hout pkg-config,<br>   no need to break backwards compatibility right now<b=
r>v7:<br> - Handle case correctly where lzo/lzo1x.h can not be included<br>=
   at all. On most distros this works even though the .pc<br>   file sugges=
ts to use it without. We had some partly<br>   solution for that but it was=
n&#39;t really working.<br><br>Change-Id: I1c038dc4ec80d3499582d81eee61fee7=
4f26e693<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>--=
-<br>M config.h.cmake.in<br>M configure.ac<br>M src/openvpn/lzo.h<br>3 file=
s changed, 22 insertions(+), 12 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/56/556/7</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/conf=
ig.h.cmake.in b/config.h.cmake.in</span><br><span>index effca2a..720d679 10=
0644</span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/config.h=
.cmake.in</span><br><span>@@ -178,9 +178,6 @@</span><br><span> /* Define to=
 1 if you have the &lt;linux/types.h&gt; header file. */</span><br><span> #=
cmakedefine HAVE_LINUX_TYPES_H</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt;lzoconf.h&gt;=
 header file. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne HAVE_LZO_CONF_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> /* Define to 1 if you have the &lt;lzo1x.h&gt; header file. =
*/</span><br><span> #define HAVE_LZO1X_H 1</span><br><span> </span><br><spa=
n>diff --git a/configure.ac b/configure.ac</span><br><span>index c01ad09..d=
7d1b18 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/conf=
igure.ac</span><br><span>@@ -1143,8 +1143,17 @@</span><br><span> </span><br=
><span> AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])</span><br><spa=
n> AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-have_lzo=3D&quot;yes&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-if test -z &quot;${LZO_LIBS}&quot;; then</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test -z &quot;${LZ=
O_CFLAGS}&quot; -a -z &quot;${LZO_LIBS}&quot;; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # if the user did not explicitly spec=
ify flags, try to autodetect</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    PKG_CHECK_MODULES([LZO],</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+		[lzo2],</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+		[have_lzo=3D&quot;yes&quot;],</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+		[]</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if test &quot;${have_lzo=
}&quot; !=3D &quot;yes&quot;; then</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	# try to detect without pkg-config</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	have_lzo=3D&quot;yes&quot;</span><br><span>=
 	AC_CHECK_LIB(</span><br><span> 		[lzo2],</span><br><span> 		[lzo1x_1_15_c=
ompress],</span><br><span>@@ -1156,6 +1165,10 @@</span><br><span> 			[have_=
lzo=3D&quot;no&quot;]</span><br><span> 		)]</span><br><span> 	)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    # assume the user configured it correctly</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    have_lzo=3D&quot;yes&quot;</s=
pan><br><span> fi</span><br><span> if test &quot;${have_lzo}&quot; =3D &quo=
t;yes&quot;; then</span><br><span> 	saved_CFLAGS=3D&quot;${CFLAGS}&quot;</s=
pan><br><span>@@ -1166,8 +1179,10 @@</span><br><span> 		[AC_CHECK_HEADERS(<=
/span><br><span> 			[lzo1x.h],</span><br><span> 			,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-			[AC_MSG_ERROR([lzo1x.h is missing])]</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-		)]</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+			[AC_MSG_ERROR([lzo1x.h is missing])],=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     [#include &lt;lzodefs.h&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                         #include &lt;lzoconf.h&gt;]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+		)],</span><br><span> 	)</sp=
an><br><span> 	CFLAGS=3D&quot;${saved_CFLAGS}&quot;</span><br><span> fi</sp=
an><br><span>diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h</span><br><=
span>index 62d73a1..c271527 100644</span><br><span>--- a/src/openvpn/lzo.h<=
/span><br><span>+++ b/src/openvpn/lzo.h</span><br><span>@@ -37,17 +37,15 @@=
</span><br><span>  * @addtogroup compression</span><br><span>  * @{</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(HAVE_LZO_CONF_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(HAVE_LZO_LZO1X_H)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &lt;lzo/lzo1x.h&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#elif defined(HAVE_LZO1X_H)</span><br><span> /* The lzo=
.h magic gets confused and still wants</span><br><span>  * to include lzo/l=
zoconf.h even if our include paths</span><br><span>  * are setup to include=
 the paths without lzo/</span><br><span>  */</span><br><span> #include &lt;=
lzodefs.h&gt;</span><br><span> #include &lt;lzoconf.h&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(HAVE_LZO_LZO1X_H)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#include &lt;lzo/lzo1x.h&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#elif defined(HAVE_LZO1X_H)</span><br><=
span> #include &lt;lzo1x.h&gt;</span><br><span> #endif</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/556?usp=3Demail">change 556</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/556?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee6=
1fee74f26e693 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 556 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--uiUH+78g0Dw=--

