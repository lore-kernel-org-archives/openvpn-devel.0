From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Apr 2026 13:02:04 +0000
In-Reply-To: <gerrit.1774451380000.I53e7b984980cb1e2b3f68e80358b61c9e1045725@...2715...>
References: <gerrit.1774451380000.I53e7b984980cb1e2b3f68e80358b61c9e1045725@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c08bd21624f41dc8d6118caddb0dccc4a82ae51c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L9Fjg2iiaJ8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L9Fjg2iiaJ8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
90?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1590
Message-Id: <20260427174757.4075-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
752.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M configure.ac
2 files changed, 1 insertion(+), 19 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 72e349c..715d02c 100644
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
index 1fd44f3..e19d651 100644
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53e7b984980cb1e2b3f68e80358b61c9e1045725
Gerrit-Change-Number: 1590
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L9Fjg2iiaJ8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1590?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">configure: Remove --enable-strict<br><br>Both -W=
sign-compare (via -Wextra) and -Wuninitalized (via<br>-Wall) are enabled by=
 default. So this does not do anything<br>anymore.<br><br>While here also r=
emove rest of --enable-strict-options which<br>was mostly removed in commit=
<br>2104ea62430e4d203f2cd998e053f4192798b9f1<br><br>Change-Id: I53e7b984980=
cb1e2b3f68e80358b61c9e1045725<br>Signed-off-by: Frank Lichtenheld &lt;frank=
@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit=
 URL: https://gerrit.openvpn.net/c/openvpn/+/1590<br>Message-Id: &lt;202604=
27174757.4075-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/op=
envpn-devel@lists.sourceforge.net/msg36752.html<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M configure.ac<br=
>2 files changed, 1 insertion(+), 19 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 72e34=
9c..715d02c 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -112,7 +112,7 @@</span><br><span>     =
    add_link_options(&quot;$&lt;$&lt;CONFIG:Release&gt;:/CETCOMPAT&gt;&quot=
;)</span><br><span>     endif()</span><br><span> else ()</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    add_compile_options(-Wall -Wuninitia=
lized)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_compi=
le_options(-Wall)</span><br><span>     check_and_add_compiler_flag(-Wno-str=
ingop-truncation NoStringOpTruncation)</span><br><span>     check_and_add_c=
ompiler_flag(-Wstrict-prototypes StrictPrototypes)</span><br><span>     che=
ck_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)</span><=
br><span>diff --git a/configure.ac b/configure.ac</span><br><span>index 1fd=
44f3..e19d651 100644</span><br><span>--- a/configure.ac</span><br><span>+++=
 b/configure.ac</span><br><span>@@ -203,13 +203,6 @@</span><br><span> )</sp=
an><br><span> </span><br><span> AC_ARG_ENABLE(</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	[strict],</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	[AS_HELP_STRING([--enable-strict], [enable strict compiler w=
arnings (debugging option) @&lt;:@default=3Dno@:&gt;@])],</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	[enable_strict=3D&quot;no&quot;]</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_ARG_ENABL=
E(</span><br><span> 	[pedantic],</span><br><span> 	[AS_HELP_STRING([--enabl=
e-pedantic], [enable pedantic compiler warnings, will not generate a workin=
g executable (debugging option) @&lt;:@default=3Dno@:&gt;@])],</span><br><s=
pan> 	,</span><br><span>@@ -224,13 +217,6 @@</span><br><span> )</span><br><=
span> </span><br><span> AC_ARG_ENABLE(</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	[strict-options],</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	[AS_HELP_STRING([--enable-strict-options], [enable strict op=
tions check between peers (debugging option) @&lt;:@default=3Dno@:&gt;@])],=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	[enable_strict_options=3D&quot;no&quot;=
]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-AC_ARG_ENABLE(</span><br><span> 	[selinux],</span><br><span> =
	[AS_HELP_STRING([--enable-selinux], [enable SELinux support @&lt;:@default=
=3Dno@:&gt;@])],</span><br><span> 	,</span><br><span>@@ -1270,13 +1256,9 @@=
</span><br><span> fi</span><br><span> </span><br><span> if test &quot;${ena=
ble_pedantic}&quot; =3D &quot;yes&quot;; then</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	enable_strict=3D&quot;yes&quot;</span><br><span> 	=
CFLAGS=3D&quot;${CFLAGS} -pedantic&quot;</span><br><span> 	AC_DEFINE([PEDAN=
TIC], [1], [Enable pedantic mode])</span><br><span> fi</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-if test &quot;${enable_strict}&quot; =3D &=
quot;yes&quot;; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
CFLAGS=3D&quot;${CFLAGS} -Wsign-compare -Wuninitialized&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span> if test &quot;$=
{enable_werror}&quot; =3D &quot;yes&quot;; then</span><br><span> 	CFLAGS=3D=
&quot;${CFLAGS} -Werror&quot;</span><br><span> fi</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1590?usp=3Demail">change 1590</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/159=
0?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53e7b984980cb1e2b3f68e80358=
b61c9e1045725 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1590 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--L9Fjg2iiaJ8=--

