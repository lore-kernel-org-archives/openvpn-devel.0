From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 22 Sep 2025 12:27:15 +0000
References: <gerrit.1758544032000.I1ce408d4473874d88a348308503527ef7eb8c1ff@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <af81ad63b312536a0878b44cf4ac3bdf79a440d4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z+cVG/nuXNk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: configure.ac: Make
 ACL_CHECK_ADD_COMPILE_FLAGS append instead of prepend
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

--Z+cVG/nuXNk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1204?usp=3Demail

to review the following change.


Change subject: configure.ac: Make ACL_CHECK_ADD_COMPILE_FLAGS append inste=
ad of prepend
......................................................................

configure.ac: Make ACL_CHECK_ADD_COMPILE_FLAGS append instead of prepend

The prepend behavior is surprising. If there is a difference
in behavior at least make it easy to understand what happens
why.

Change-Id: I1ce408d4473874d88a348308503527ef7eb8c1ff
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M configure.ac
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/1204/1

diff --git a/configure.ac b/configure.ac
index 03c5e3b..acda253 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1387,9 +1387,9 @@
 # required for gcc, but some compilers such as clang need it.
 AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
     old_cflags=3D"$CFLAGS"
-    CFLAGS=3D"$1 -Werror $CFLAGS"
+    CFLAGS=3D"-Werror $CFLAGS $1"
     AC_MSG_CHECKING([whether the compiler accepts $1])
-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])]; CFLAGS=
=3D"$1 $old_cflags",
+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MSG_RESULT([yes])]; CFLAGS=
=3D"$old_cflags $1",
         [AC_MSG_RESULT([no]); CFLAGS=3D"$old_cflags"])]
 )


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1204?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1ce408d4473874d88a348308503527ef7eb8c1ff
Gerrit-Change-Number: 1204
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--Z+cVG/nuXNk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1204?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">configure.ac: Make ACL_CHECK_ADD_COMPILE_FLAGS append instea=
d of prepend<br><br>The prepend behavior is surprising. If there is a diffe=
rence<br>in behavior at least make it easy to understand what happens<br>wh=
y.<br><br>Change-Id: I1ce408d4473874d88a348308503527ef7eb8c1ff<br>Signed-of=
f-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M configure.ac<b=
r>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/04/1204/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/configure.ac b/configure.ac</span><br><span>index 03c5e3b..acda253 10=
0644</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac<=
/span><br><span>@@ -1387,9 +1387,9 @@</span><br><span> # required for gcc, =
but some compilers such as clang need it.</span><br><span> AC_DEFUN([ACL_CH=
ECK_ADD_COMPILE_FLAGS], [</span><br><span>     old_cflags=3D&quot;$CFLAGS&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CFLAGS=3D&quo=
t;$1 -Werror $CFLAGS&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    CFLAGS=3D&quot;-Werror $CFLAGS $1&quot;</span><br><span>     AC_=
MSG_CHECKING([whether the compiler accepts $1])</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()], [AC_MS=
G_RESULT([yes])]; CFLAGS=3D&quot;$1 $old_cflags&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    AC_COMPILE_IFELSE([AC_LANG_PROGRAM()=
], [AC_MSG_RESULT([yes])]; CFLAGS=3D&quot;$old_cflags $1&quot;,</span><br><=
span>         [AC_MSG_RESULT([no]); CFLAGS=3D&quot;$old_cflags&quot;])]</sp=
an><br><span> )</span><br><span> </span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1204?usp=3Demail=
">change 1204</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1204?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1ce408d4473874d88a348308503=
527ef7eb8c1ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1204 </div>
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


--Z+cVG/nuXNk=--

