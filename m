From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 12:57:10 +0000
In-Reply-To: <gerrit.1758544032000.I1ce408d4473874d88a348308503527ef7eb8c1ff@...2715...>
References: <gerrit.1758544032000.I1ce408d4473874d88a348308503527ef7eb8c1ff@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1265440dfa996c5cd8c672a99ed299afee4956f2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aezn/WoxKa4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aezn/WoxKa4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
04?usp=3Demail )

Change subject: configure.ac: Make ACL_CHECK_ADD_COMPILE_FLAGS append inste=
ad of prepend
......................................................................

configure.ac: Make ACL_CHECK_ADD_COMPILE_FLAGS append instead of prepend

The prepend behavior is surprising. If there is a difference
in behavior at least make it easy to understand what happens
why.

Change-Id: I1ce408d4473874d88a348308503527ef7eb8c1ff
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1204
Message-Id: <20250923122006.12212-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59237450/
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
1 file changed, 2 insertions(+), 2 deletions(-)




diff --git a/configure.ac b/configure.ac
index 38b14a1..0fc21ee 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1388,9 +1388,9 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--aezn/WoxKa4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1204?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">configure.ac: Make ACL_CHECK_ADD_COMPILE_FLAG=
S append instead of prepend<br><br>The prepend behavior is surprising. If t=
here is a difference<br>in behavior at least make it easy to understand wha=
t happens<br>why.<br><br>Change-Id: I1ce408d4473874d88a348308503527ef7eb8c1=
ff<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by=
: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvp=
n.net/c/openvpn/+/1204<br>Message-Id: &lt;20250923122006.12212-1-gert@...1711...=
96...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/5923745=
0/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M confi=
gure.ac<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index 38b14a1..=
0fc21ee 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -1388,9 +1388,9 @@</span><br><span> # required=
 for gcc, but some compilers such as clang need it.</span><br><span> AC_DEF=
UN([ACL_CHECK_ADD_COMPILE_FLAGS], [</span><br><span>     old_cflags=3D&quot=
;$CFLAGS&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CFL=
AGS=3D&quot;$1 -Werror $CFLAGS&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    CFLAGS=3D&quot;-Werror $CFLAGS $1&quot;</span><br><spa=
n>     AC_MSG_CHECKING([whether the compiler accepts $1])</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    AC_COMPILE_IFELSE([AC_LANG_PROGRAM(=
)], [AC_MSG_RESULT([yes])]; CFLAGS=3D&quot;$1 $old_cflags&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    AC_COMPILE_IFELSE([AC_LANG=
_PROGRAM()], [AC_MSG_RESULT([yes])]; CFLAGS=3D&quot;$old_cflags $1&quot;,</=
span><br><span>         [AC_MSG_RESULT([no]); CFLAGS=3D&quot;$old_cflags&qu=
ot;])]</span><br><span> )</span><br><span> </span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1204?u=
sp=3Demail">change 1204</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1204?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1ce408d4473874d88a348308503=
527ef7eb8c1ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1204 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--aezn/WoxKa4=--

