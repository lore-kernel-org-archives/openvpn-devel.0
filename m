From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 5 Jun 2024 11:11:03 +0000
In-Reply-To: <gerrit.1717513301000.I32ee28fde5d38d736f753c782d88a81de7fe2980@...2715...>
References: <gerrit.1717513301000.I32ee28fde5d38d736f753c782d88a81de7fe2980@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a0dcd529545e5ea1106958fdce740bf70c9adbd0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b8zulcz0ry4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: LZO: do not use
 lzoutils.h macros
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

--b8zulcz0ry4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/64=
2?usp=3Demail )

Change subject: LZO: do not use lzoutils.h macros
......................................................................

LZO: do not use lzoutils.h macros

Instead of lzo_{free,malloc} we can just use the
free and malloc as the lzoutils.h header itself
suggests.

Change-Id: I32ee28fde5d38d736f753c782d88a81de7fe2980
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240604211708.32315-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
705.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M config.h.cmake.in
M configure.ac
M src/openvpn/lzo.c
M src/openvpn/lzo.h
4 files changed, 4 insertions(+), 21 deletions(-)




diff --git a/config.h.cmake.in b/config.h.cmake.in
index 2cdfdcc..effca2a 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -184,9 +184,6 @@
 /* Define to 1 if you have the <lzo1x.h> header file. */
 #define HAVE_LZO1X_H 1

-/* Define to 1 if you have the <lzoutil.h> header file. */
-#define HAVE_LZOUTIL_H 1
-
 /* Define to 1 if you have the `mlockall' function. */
 #cmakedefine HAVE_MLOCKALL

diff --git a/configure.ac b/configure.ac
index 965ed1a..2e5ab6a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1161,15 +1161,6 @@
 	saved_CFLAGS=3D"${CFLAGS}"
 	CFLAGS=3D"${CFLAGS} ${LZO_CFLAGS}"
 	AC_CHECK_HEADERS(
-		[lzo/lzoutil.h],
-		,
-		[AC_CHECK_HEADERS(
-			[lzoutil.h],
-			,
-			[AC_MSG_ERROR([lzoutil.h is missing])]
-		)]
-	)
-	AC_CHECK_HEADERS(
 		[lzo/lzo1x.h],
 		,
 		[AC_CHECK_HEADERS(
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index b313284..bab2d78 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -107,14 +107,14 @@
     {
         msg(M_FATAL, "Cannot initialize LZO compression library (lzo_init(=
) returns %d)", lzo_status);
     }
-    compctx->wu.lzo.wmem =3D (lzo_voidp) lzo_malloc(compctx->wu.lzo.wmem_s=
ize);
+    compctx->wu.lzo.wmem =3D (lzo_voidp) malloc(compctx->wu.lzo.wmem_size);
     check_malloc_return(compctx->wu.lzo.wmem);
 }

 static void
 lzo_compress_uninit(struct compress_context *compctx)
 {
-    lzo_free(compctx->wu.lzo.wmem);
+    free(compctx->wu.lzo.wmem);
     compctx->wu.lzo.wmem =3D NULL;
 }

diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index e951b49..62d73a1 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -40,16 +40,11 @@
 #if defined(HAVE_LZO_CONF_H)
 /* The lzo.h magic gets confused and still wants
  * to include lzo/lzoconf.h even if our include paths
- * are setup to include the paths without lzo/ include lzoconf.h to
- * avoid it being include by lzoutil.h */
+ * are setup to include the paths without lzo/
+ */
 #include <lzodefs.h>
 #include <lzoconf.h>
 #endif
-#if defined(HAVE_LZO_LZOUTIL_H)
-#include <lzo/lzoutil.h>
-#elif defined(HAVE_LZOUTIL_H)
-#include <lzoutil.h>
-#endif
 #if defined(HAVE_LZO_LZO1X_H)
 #include <lzo/lzo1x.h>
 #elif defined(HAVE_LZO1X_H)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/642?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I32ee28fde5d38d736f753c782d88a81de7fe2980
Gerrit-Change-Number: 642
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--b8zulcz0ry4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/642?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">LZO: do not use lzoutils.h macros<br><br>Inste=
ad of lzo_{free,malloc} we can just use the<br>free and malloc as the lzout=
ils.h header itself<br>suggests.<br><br>Change-Id: I32ee28fde5d38d736f753c7=
82d88a81de7fe2980<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id=
: &lt;20240604211708.32315-1-gert@...1296...&gt;<br>URL: https://www.mail-a=
rchive.com/openvpn-devel@lists.sourceforge.net/msg28705.html<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M config.h.cmake.in<br>M=
 configure.ac<br>M src/openvpn/lzo.c<br>M src/openvpn/lzo.h<br>4 files chan=
ged, 4 insertions(+), 21 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><span>index=
 2cdfdcc..effca2a 100644</span><br><span>--- a/config.h.cmake.in</span><br>=
<span>+++ b/config.h.cmake.in</span><br><span>@@ -184,9 +184,6 @@</span><br=
><span> /* Define to 1 if you have the &lt;lzo1x.h&gt; header file. */</spa=
n><br><span> #define HAVE_LZO1X_H 1</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt;lzoutil.=
h&gt; header file. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define HAVE_LZOUTIL_H 1</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> /* Define to 1 if you have the `mlockall&#39; function=
. */</span><br><span> #cmakedefine HAVE_MLOCKALL</span><br><span> </span><b=
r><span>diff --git a/configure.ac b/configure.ac</span><br><span>index 965e=
d1a..2e5ab6a 100644</span><br><span>--- a/configure.ac</span><br><span>+++ =
b/configure.ac</span><br><span>@@ -1161,15 +1161,6 @@</span><br><span> 	sav=
ed_CFLAGS=3D&quot;${CFLAGS}&quot;</span><br><span> 	CFLAGS=3D&quot;${CFLAGS=
} ${LZO_CFLAGS}&quot;</span><br><span> 	AC_CHECK_HEADERS(</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-		[lzo/lzoutil.h],</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-		,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-		[AC_CHECK_HEADERS(</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-			[lzoutil.h],</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-			,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[AC_MS=
G_ERROR([lzoutil.h is missing])]</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-		)]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_HEADERS(</span>=
<br><span> 		[lzo/lzo1x.h],</span><br><span> 		,</span><br><span> 		[AC_CHE=
CK_HEADERS(</span><br><span>diff --git a/src/openvpn/lzo.c b/src/openvpn/lz=
o.c</span><br><span>index b313284..bab2d78 100644</span><br><span>--- a/src=
/openvpn/lzo.c</span><br><span>+++ b/src/openvpn/lzo.c</span><br><span>@@ -=
107,14 +107,14 @@</span><br><span>     {</span><br><span>         msg(M_FAT=
AL, &quot;Cannot initialize LZO compression library (lzo_init() returns %d)=
&quot;, lzo_status);</span><br><span>     }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    compctx-&gt;wu.lzo.wmem =3D (lzo_voidp) lzo_mallo=
c(compctx-&gt;wu.lzo.wmem_size);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    compctx-&gt;wu.lzo.wmem =3D (lzo_voidp) malloc(compctx-&gt=
;wu.lzo.wmem_size);</span><br><span>     check_malloc_return(compctx-&gt;wu=
.lzo.wmem);</span><br><span> }</span><br><span> </span><br><span> static vo=
id</span><br><span> lzo_compress_uninit(struct compress_context *compctx)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
lzo_free(compctx-&gt;wu.lzo.wmem);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free(compctx-&gt;wu.lzo.wmem);</span><br><span>     comp=
ctx-&gt;wu.lzo.wmem =3D NULL;</span><br><span> }</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h</span><br><span>=
index e951b49..62d73a1 100644</span><br><span>--- a/src/openvpn/lzo.h</span=
><br><span>+++ b/src/openvpn/lzo.h</span><br><span>@@ -40,16 +40,11 @@</spa=
n><br><span> #if defined(HAVE_LZO_CONF_H)</span><br><span> /* The lzo.h mag=
ic gets confused and still wants</span><br><span>  * to include lzo/lzoconf=
.h even if our include paths</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * are setup to include the paths without lzo/ include lzoconf.h to<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * avoid it being incl=
ude by lzoutil.h */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * are setup to include the paths without lzo/</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span> #include &lt;lzodefs.h&gt;<=
/span><br><span> #include &lt;lzoconf.h&gt;</span><br><span> #endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_LZO_LZOUTIL_=
H)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;lzo/lz=
outil.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defi=
ned(HAVE_LZOUTIL_H)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
nclude &lt;lzoutil.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span> #if defined(HAVE_LZO_LZO1X_H)</span><br><span> #=
include &lt;lzo/lzo1x.h&gt;</span><br><span> #elif defined(HAVE_LZO1X_H)</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/642?usp=3Demail">change 642</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/642?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I32ee28fde5d38d736f753c782d8=
8a81de7fe2980 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 642 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--b8zulcz0ry4=--

