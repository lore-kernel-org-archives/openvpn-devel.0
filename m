From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Jun 2024 16:55:37 +0000
In-Reply-To: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
References: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <be72d4db1c70f45e017da1dfdf3bd34663b2ff97-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pp/25cXu5oo="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pp/25cXu5oo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/56/556/9

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
Gerrit-MessageType: newpatchset

--pp/25cXu5oo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #9</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/556?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">configure: Try to detect LZO with pkg-config<br><br>=
On most systems this should work just fine.<br><br>v2:<br> - simplify code =
by removing -llzo special handling<br>v3:<br> - reintroduce support for aut=
odetection without pkg-config,<br>   no need to break backwards compatibili=
ty right now<br>v7:<br> - Handle case correctly where lzo/lzo1x.h can not b=
e included<br>   at all. On most distros this works even though the .pc<br>=
   file suggests to use it without. We had some partly<br>   solution for t=
hat but it wasn&#39;t really working.<br>v8:<br> - Handle systems that do n=
ot implicitly include limits.h<br>   in configure test builds.<br>   lzodef=
s.h usually relies on lzoconf.h to include it.<br><br>Change-Id: I1c038dc4e=
c80d3499582d81eee61fee74f26e693<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Mess=
age-Id: &lt;20240626161921.179301-1-frank@...2641...&gt;<br>URL: https://ww=
w.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28848.html<br>Sig=
ned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M config.h.cmake=
.in<br>M configure.ac<br>M src/openvpn/lzo.h<br>3 files changed, 23 inserti=
ons(+), 12 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/56/556/9</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/config.h.cmake.in b/confi=
g.h.cmake.in</span><br><span>index effca2a..720d679 100644</span><br><span>=
--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><=
span>@@ -178,9 +178,6 @@</span><br><span> /* Define to 1 if you have the &l=
t;linux/types.h&gt; header file. */</span><br><span> #cmakedefine HAVE_LINU=
X_TYPES_H</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/* Define to 1 if you have the &lt;lzoconf.h&gt; header file. */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_LZO_CONF_H</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Def=
ine to 1 if you have the &lt;lzo1x.h&gt; header file. */</span><br><span> #=
define HAVE_LZO1X_H 1</span><br><span> </span><br><span>diff --git a/config=
ure.ac b/configure.ac</span><br><span>index c01ad09..555c97e 100644</span><=
br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><s=
pan>@@ -1143,8 +1143,17 @@</span><br><span> </span><br><span> AC_ARG_VAR([L=
ZO_CFLAGS], [C compiler flags for lzo])</span><br><span> AC_ARG_VAR([LZO_LI=
BS], [linker flags for lzo])</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-have_lzo=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-if test -z &quot;${LZO_LIBS}&quot;; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if test -z &quot;${LZO_CFLAGS}&quot; -a -=
z &quot;${LZO_LIBS}&quot;; then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    # if the user did not explicitly specify flags, try to auto=
detect</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PKG_CHECK=
_MODULES([LZO],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[l=
zo2],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[have_lzo=3D=
&quot;yes&quot;],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		=
[]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if test &quot;${have_lzo}&quot; !=3D &quot;yes=
&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	# try =
to detect without pkg-config</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	have_lzo=3D&quot;yes&quot;</span><br><span> 	AC_CHECK_LIB(</span>=
<br><span> 		[lzo2],</span><br><span> 		[lzo1x_1_15_compress],</span><br><s=
pan>@@ -1156,6 +1165,10 @@</span><br><span> 			[have_lzo=3D&quot;no&quot;]<=
/span><br><span> 		)]</span><br><span> 	)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # =
assume the user configured it correctly</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    have_lzo=3D&quot;yes&quot;</span><br><span> fi</spa=
n><br><span> if test &quot;${have_lzo}&quot; =3D &quot;yes&quot;; then</spa=
n><br><span> 	saved_CFLAGS=3D&quot;${CFLAGS}&quot;</span><br><span>@@ -1166=
,8 +1179,11 @@</span><br><span> 		[AC_CHECK_HEADERS(</span><br><span> 			[l=
zo1x.h],</span><br><span> 			,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-			[AC_MSG_ERROR([lzo1x.h is missing])]</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-		)]</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+			[AC_MSG_ERROR([lzo1x.h is missing])],</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        [#include &lt;lim=
its.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
               #include &lt;lzodefs.h&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                         #include &lt;lzoconf.h&gt;]<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+		)],</span><br><spa=
n> 	)</span><br><span> 	CFLAGS=3D&quot;${saved_CFLAGS}&quot;</span><br><spa=
n> fi</span><br><span>diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h</s=
pan><br><span>index 62d73a1..c271527 100644</span><br><span>--- a/src/openv=
pn/lzo.h</span><br><span>+++ b/src/openvpn/lzo.h</span><br><span>@@ -37,17 =
+37,15 @@</span><br><span>  * @addtogroup compression</span><br><span>  * @=
{</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if defined(HAVE_LZO_CONF_H)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(HAVE_LZO_LZO1X_H)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &lt;lzo/lzo1x.h&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#elif defined(HAVE_LZO1X_H)</span><br><span> /=
* The lzo.h magic gets confused and still wants</span><br><span>  * to incl=
ude lzo/lzoconf.h even if our include paths</span><br><span>  * are setup t=
o include the paths without lzo/</span><br><span>  */</span><br><span> #inc=
lude &lt;lzodefs.h&gt;</span><br><span> #include &lt;lzoconf.h&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_LZO_LZO1X_H)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#include &lt;lzo/lzo1x.h&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(HAVE_LZO1X_H)<=
/span><br><span> #include &lt;lzo1x.h&gt;</span><br><span> #endif</span><br=
><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">change 556</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/556?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--pp/25cXu5oo=--

