From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 4 Jun 2024 15:01:43 +0000
References: <gerrit.1717513301000.I32ee28fde5d38d736f753c782d88a81de7fe2980@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <425409ca95aef27b97e7e0c8f60a106a5fb8c36c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QlOr6pLXcVg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QlOr6pLXcVg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/642?usp=3Demail

to review the following change.


Change subject: LZO: do not use lzoutils.h macros
......................................................................

LZO: do not use lzoutils.h macros

Instead of lzo_{free,malloc} we can just use the
free and malloc as the lzoutils.h header itself
suggests.

Change-Id: I32ee28fde5d38d736f753c782d88a81de7fe2980
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M config.h.cmake.in
M configure.ac
M src/openvpn/lzo.c
M src/openvpn/lzo.h
4 files changed, 4 insertions(+), 21 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/642/1

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
index d834f30..bb87c59 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1174,15 +1174,6 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--QlOr6pLXcVg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/642?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">LZO: do not use lzoutils.h macros<br><br>Instead of lzo_{free=
,malloc} we can just use the<br>free and malloc as the lzoutils.h header it=
self<br>suggests.<br><br>Change-Id: I32ee28fde5d38d736f753c782d88a81de7fe29=
80<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M=
 config.h.cmake.in<br>M configure.ac<br>M src/openvpn/lzo.c<br>M src/openvp=
n/lzo.h<br>4 files changed, 4 insertions(+), 21 deletions(-)<br><br></pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/642/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><span>index 2cd=
fdcc..effca2a 100644</span><br><span>--- a/config.h.cmake.in</span><br><spa=
n>+++ b/config.h.cmake.in</span><br><span>@@ -184,9 +184,6 @@</span><br><sp=
an> /* Define to 1 if you have the &lt;lzo1x.h&gt; header file. */</span><b=
r><span> #define HAVE_LZO1X_H 1</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt;lzoutil.h&gt=
; header file. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine HAVE_LZOUTIL_H 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> /* Define to 1 if you have the `mlockall&#39; function. */=
</span><br><span> #cmakedefine HAVE_MLOCKALL</span><br><span> </span><br><s=
pan>diff --git a/configure.ac b/configure.ac</span><br><span>index d834f30.=
.bb87c59 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/co=
nfigure.ac</span><br><span>@@ -1174,15 +1174,6 @@</span><br><span> 	saved_C=
FLAGS=3D&quot;${CFLAGS}&quot;</span><br><span> 	CFLAGS=3D&quot;${CFLAGS} ${=
LZO_CFLAGS}&quot;</span><br><span> 	AC_CHECK_HEADERS(</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-		[lzo/lzoutil.h],</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-		,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-		[AC_CHECK_HEADERS(</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-			[lzoutil.h],</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-			,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[AC_MSG_ER=
ROR([lzoutil.h is missing])]</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-		)]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_HEADERS(</span><br>=
<span> 		[lzo/lzo1x.h],</span><br><span> 		,</span><br><span> 		[AC_CHECK_H=
EADERS(</span><br><span>diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c<=
/span><br><span>index b313284..bab2d78 100644</span><br><span>--- a/src/ope=
nvpn/lzo.c</span><br><span>+++ b/src/openvpn/lzo.c</span><br><span>@@ -107,=
14 +107,14 @@</span><br><span>     {</span><br><span>         msg(M_FATAL, =
&quot;Cannot initialize LZO compression library (lzo_init() returns %d)&quo=
t;, lzo_status);</span><br><span>     }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    compctx-&gt;wu.lzo.wmem =3D (lzo_voidp) lzo_malloc(co=
mpctx-&gt;wu.lzo.wmem_size);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    compctx-&gt;wu.lzo.wmem =3D (lzo_voidp) malloc(compctx-&gt;wu.=
lzo.wmem_size);</span><br><span>     check_malloc_return(compctx-&gt;wu.lzo=
.wmem);</span><br><span> }</span><br><span> </span><br><span> static void</=
span><br><span> lzo_compress_uninit(struct compress_context *compctx)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    lzo_=
free(compctx-&gt;wu.lzo.wmem);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    free(compctx-&gt;wu.lzo.wmem);</span><br><span>     compctx-=
&gt;wu.lzo.wmem =3D NULL;</span><br><span> }</span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h</span><br><span>inde=
x e951b49..62d73a1 100644</span><br><span>--- a/src/openvpn/lzo.h</span><br=
><span>+++ b/src/openvpn/lzo.h</span><br><span>@@ -40,16 +40,11 @@</span><b=
r><span> #if defined(HAVE_LZO_CONF_H)</span><br><span> /* The lzo.h magic g=
ets confused and still wants</span><br><span>  * to include lzo/lzoconf.h e=
ven if our include paths</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * are setup to include the paths without lzo/ include lzoconf.h to</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * avoid it being include =
by lzoutil.h */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a=
re setup to include the paths without lzo/</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span> #include &lt;lzodefs.h&gt;</spa=
n><br><span> #include &lt;lzoconf.h&gt;</span><br><span> #endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_LZO_LZOUTIL_H)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;lzo/lzouti=
l.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif defined(=
HAVE_LZOUTIL_H)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inclu=
de &lt;lzoutil.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span> #if defined(HAVE_LZO_LZO1X_H)</span><br><span> #incl=
ude &lt;lzo/lzo1x.h&gt;</span><br><span> #elif defined(HAVE_LZO1X_H)</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/642?usp=3Demail">change 642</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/642?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I32ee28fde5d38d736f753c782d8=
8a81de7fe2980 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 642 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--QlOr6pLXcVg=--

