From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 25 Mar 2026 15:09:44 +0000
References: <gerrit.1774451380000.I53e7b984980cb1e2b3f68e80358b61c9e1045725@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f76a41fcb0c597fcda84174d2365d13df904e1ad-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xGVkw6IrcGY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Remove
 --enable-strict
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

--xGVkw6IrcGY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1590?usp=3Demail

to review the following change.


Change subject: configure: Remove --enable-strict
......................................................................

configure: Remove --enable-strict

Both -Wsign-compare (via -Wextra) and -Wuninitalized (via
-Wall) are enabled by default. So this does not do anything
anymore.

While here also remove rest of --enable-strict-options which
was mostly removed in commit
2104ea62430e4d203f2cd998e053f4192798b9f1

Change-Id: I53e7b984980cb1e2b3f68e80358b61c9e1045725
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M configure.ac
2 files changed, 1 insertion(+), 19 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1590/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 198c98f..f9cbbfd 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -112,7 +112,7 @@
         add_link_options("$<$<CONFIG:Release>:/CETCOMPAT>")
     endif()
 else ()
-    add_compile_options(-Wall -Wuninitialized)
+    add_compile_options(-Wall)
     check_and_add_compiler_flag(-Wno-stringop-truncation NoStringOpTruncat=
ion)
     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
diff --git a/configure.ac b/configure.ac
index ecef2b9..5da877a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -203,13 +203,6 @@
 )

 AC_ARG_ENABLE(
-	[strict],
-	[AS_HELP_STRING([--enable-strict], [enable strict compiler warnings (debu=
gging option) @<:@default=3Dno@:>@])],
-	,
-	[enable_strict=3D"no"]
-)
-
-AC_ARG_ENABLE(
 	[pedantic],
 	[AS_HELP_STRING([--enable-pedantic], [enable pedantic compiler warnings, =
will not generate a working executable (debugging option) @<:@default=3Dno@=
:>@])],
 	,
@@ -224,13 +217,6 @@
 )

 AC_ARG_ENABLE(
-	[strict-options],
-	[AS_HELP_STRING([--enable-strict-options], [enable strict options check b=
etween peers (debugging option) @<:@default=3Dno@:>@])],
-	,
-	[enable_strict_options=3D"no"]
-)
-
-AC_ARG_ENABLE(
 	[selinux],
 	[AS_HELP_STRING([--enable-selinux], [enable SELinux support @<:@default=
=3Dno@:>@])],
 	,
@@ -1270,13 +1256,9 @@
 fi

 if test "${enable_pedantic}" =3D "yes"; then
-	enable_strict=3D"yes"
 	CFLAGS=3D"${CFLAGS} -pedantic"
 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])
 fi
-if test "${enable_strict}" =3D "yes"; then
-	CFLAGS=3D"${CFLAGS} -Wsign-compare -Wuninitialized"
-fi
 if test "${enable_werror}" =3D "yes"; then
 	CFLAGS=3D"${CFLAGS} -Werror"
 fi

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1590?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53e7b984980cb1e2b3f68e80358b61c9e1045725
Gerrit-Change-Number: 1590
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--xGVkw6IrcGY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1590?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">configure: Remove --enable-strict<br><br>Bo=
th -Wsign-compare (via -Wextra) and -Wuninitalized (via<br>-Wall) are enabl=
ed by default. So this does not do anything<br>anymore.<br><br>While here a=
lso remove rest of --enable-strict-options which<br>was mostly removed in c=
ommit<br>2104ea62430e4d203f2cd998e053f4192798b9f1<br><br>Change-Id: I53e7b9=
84980cb1e2b3f68e80358b61c9e1045725<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M configure.ac<br>2 file=
s changed, 1 insertion(+), 19 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1590/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 198c98f..=
f9cbbfd 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/C=
MakeLists.txt</span><br><span>@@ -112,7 +112,7 @@</span><br><span>         =
add_link_options(&quot;$&lt;$&lt;CONFIG:Release&gt;:/CETCOMPAT&gt;&quot;)</=
span><br><span>     endif()</span><br><span> else ()</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    add_compile_options(-Wall -Wuninitializ=
ed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_compile_=
options(-Wall)</span><br><span>     check_and_add_compiler_flag(-Wno-string=
op-truncation NoStringOpTruncation)</span><br><span>     check_and_add_comp=
iler_flag(-Wstrict-prototypes StrictPrototypes)</span><br><span>     check_=
and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)</span><br>=
<span>diff --git a/configure.ac b/configure.ac</span><br><span>index ecef2b=
9..5da877a 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/=
configure.ac</span><br><span>@@ -203,13 +203,6 @@</span><br><span> )</span>=
<br><span> </span><br><span> AC_ARG_ENABLE(</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	[strict],</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	[AS_HELP_STRING([--enable-strict], [enable strict compiler warn=
ings (debugging option) @&lt;:@default=3Dno@:&gt;@])],</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	[enable_strict=3D&quot;no&quot;]</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_ARG_ENABLE(<=
/span><br><span> 	[pedantic],</span><br><span> 	[AS_HELP_STRING([--enable-p=
edantic], [enable pedantic compiler warnings, will not generate a working e=
xecutable (debugging option) @&lt;:@default=3Dno@:&gt;@])],</span><br><span=
> 	,</span><br><span>@@ -224,13 +217,6 @@</span><br><span> )</span><br><spa=
n> </span><br><span> AC_ARG_ENABLE(</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	[strict-options],</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	[AS_HELP_STRING([--enable-strict-options], [enable strict optio=
ns check between peers (debugging option) @&lt;:@default=3Dno@:&gt;@])],</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	[enable_strict_options=3D&quot;no&quot;]</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-AC_ARG_ENABLE(</span><br><span> 	[selinux],</span><br><span> 	[A=
S_HELP_STRING([--enable-selinux], [enable SELinux support @&lt;:@default=3D=
no@:&gt;@])],</span><br><span> 	,</span><br><span>@@ -1270,13 +1256,9 @@</s=
pan><br><span> fi</span><br><span> </span><br><span> if test &quot;${enable=
_pedantic}&quot; =3D &quot;yes&quot;; then</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-	enable_strict=3D&quot;yes&quot;</span><br><span> 	CFL=
AGS=3D&quot;${CFLAGS} -pedantic&quot;</span><br><span> 	AC_DEFINE([PEDANTIC=
], [1], [Enable pedantic mode])</span><br><span> fi</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-if test &quot;${enable_strict}&quot; =3D &q=
uot;yes&quot;; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	C=
FLAGS=3D&quot;${CFLAGS} -Wsign-compare -Wuninitialized&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span> if test &quot;${=
enable_werror}&quot; =3D &quot;yes&quot;; then</span><br><span> 	CFLAGS=3D&=
quot;${CFLAGS} -Werror&quot;</span><br><span> fi</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
590?usp=3Demail">change 1590</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1590=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53e7b984980cb1e2b3f68e80358=
b61c9e1045725 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1590 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--xGVkw6IrcGY=--

