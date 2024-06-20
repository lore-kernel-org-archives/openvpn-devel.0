From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 20 Jun 2024 16:21:24 +0000
References: <gerrit.1718900482000.I379e1eb6dc57b9fe4bbdaefbd947a14326e7117a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5ee31d0d7d35fcf39e67f633d5cbae59a1a6828b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ELf3fDFs39A="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: console_systemd:
 rename query_user_exec to query_user_systemd
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

--ELf3fDFs39A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/670?usp=3Demail

to review the following change.


Change subject: console_systemd: rename query_user_exec to query_user_syste=
md
......................................................................

console_systemd: rename query_user_exec to query_user_systemd

This allows us to override query_user_exec for unit
tests more consistently without having to jump through
weird hoops.

Fixes running test_pkcs11 with --enable-systemd.

While here also fix documentation comments for
query_user_exec*.

Change-Id: I379e1eb6dc57b9fe4bbdaefbd947a14326e7117a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/console.h
M src/openvpn/console_systemd.c
M tests/unit_tests/openvpn/test_pkcs11.c
M tests/unit_tests/openvpn/test_user_pass.c
4 files changed, 36 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/670/1

diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 7358299..b542099 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -65,11 +65,10 @@


 /**
- * Executes a configured setup, using the built-in method for querying the=
 user.
+ * Loop through configured query_user slots, using the built-in method for
+ * querying the user.
  * This method uses the console/TTY directly.
  *
- * @param setup    Pointer to the setup defining what to ask the user
- *
  * @return True if executing all the defined steps completed successfully
  */
 bool query_user_exec_builtin(void);
@@ -77,15 +76,28 @@

 #if defined(ENABLE_SYSTEMD)
 /**
- * Executes a configured setup, using the compiled method for querying the=
 user
- *
- * @param setup    Pointer to the setup defining what to ask the user
+ * Loop through configured query_user slots, using the systemd method for
+ * querying the user.
+ * If systemd is not running it will fall back to use
+ * query_user_exec_builtin() instead.
  *
  * @return True if executing all the defined steps completed successfully
  */
-bool query_user_exec(void);
+bool query_user_exec_systemd(void);

-#else  /* ENABLE_SYSTEMD not defined*/
+/**
+ * Loop through configured query_user slots, using the compiled method for
+ * querying the user.
+ *
+ * @return True if executing all the defined steps completed successfully
+ */
+static bool
+query_user_exec(void)
+{
+    return query_user_exec_systemd();
+}
+
+#else  /* ENABLE_SYSTEMD not defined */
 /**
  * Wrapper function enabling query_user_exec() if no alternative methods h=
ave
  * been enabled
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index c7cf1ad..cc91cd1 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -96,7 +96,7 @@
  *
  */
 bool
-query_user_exec(void)
+query_user_exec_systemd(void)
 {
     bool ret =3D true;  /* Presume everything goes okay */
     int i;
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index 6d283a2..5518fa1 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -75,6 +75,14 @@
 {
     assert_true(0);
 }
+#if defined(ENABLE_SYSTEMD)
+bool
+query_user_exec_systemd(void)
+{
+    assert_true(0);
+    return false;
+}
+#endif
 bool
 query_user_exec_builtin(void)
 {
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index b43e655..de60291 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -26,10 +26,6 @@
 #include "config.h"
 #endif

-#undef ENABLE_SYSTEMD
-/* avoid redefining ENABLE_SYSTEMD in misc.c */
-#undef HAVE_CONFIG_H
-
 #include "syshead.h"
 #include "manage.h"

@@ -44,6 +40,13 @@
 struct management *management; /* global */
=20
 /* mocking */
+#if defined(ENABLE_SYSTEMD)
+bool
+query_user_exec_systemd(void)
+{
+    return query_user_exec_builtin();
+}
+#endif
 bool
 query_user_exec_builtin(void)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/670?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I379e1eb6dc57b9fe4bbdaefbd947a14326e7117a
Gerrit-Change-Number: 670
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--ELf3fDFs39A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/670?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">console_systemd: rename query_user_exec to query_user_systemd=
<br><br>This allows us to override query_user_exec for unit<br>tests more c=
onsistently without having to jump through<br>weird hoops.<br><br>Fixes run=
ning test_pkcs11 with --enable-systemd.<br><br>While here also fix document=
ation comments for<br>query_user_exec*.<br><br>Change-Id: I379e1eb6dc57b9fe=
4bbdaefbd947a14326e7117a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>---<br>M src/openvpn/console.h<br>M src/openvpn/console_syste=
md.c<br>M tests/unit_tests/openvpn/test_pkcs11.c<br>M tests/unit_tests/open=
vpn/test_user_pass.c<br>4 files changed, 36 insertions(+), 13 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/6=
70/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/console.h b/src/openvpn/console.h</sp=
an><br><span>index 7358299..b542099 100644</span><br><span>--- a/src/openvp=
n/console.h</span><br><span>+++ b/src/openvpn/console.h</span><br><span>@@ =
-65,11 +65,10 @@</span><br><span> </span><br><span> </span><br><span> /**</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Executes a configure=
d setup, using the built-in method for querying the user.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Loop through configured query_user=
 slots, using the built-in method for</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * querying the user.</span><br><span>  * This method use=
s the console/TTY directly.</span><br><span>  *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * @param setup    Pointer to the setup defining =
what to ask the user</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span>  * @return True if executing all the defined steps compl=
eted successfully</span><br><span>  */</span><br><span> bool query_user_exe=
c_builtin(void);</span><br><span>@@ -77,15 +76,28 @@</span><br><span> </spa=
n><br><span> #if defined(ENABLE_SYSTEMD)</span><br><span> /**</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * Executes a configured setup, usi=
ng the compiled method for querying the user</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @param setup    Pointer to the setup defining what to ask the user</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Loop through confi=
gured query_user slots, using the systemd method for</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * querying the user.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * If systemd is not running it will fa=
ll back to use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * qu=
ery_user_exec_builtin() instead.</span><br><span>  *</span><br><span>  * @r=
eturn True if executing all the defined steps completed successfully</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool qu=
ery_user_exec(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool query_user_exec_systemd(void);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#else  /* ENABLE_SYSTEMD not defined*/</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Loop through configured query_user s=
lots, using the compiled method for</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * querying the user.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @return True if executing all the defined steps completed successfully<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+query_user_exec(void)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return query_user_exec_systemd();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#el=
se  /* ENABLE_SYSTEMD not defined */</span><br><span> /**</span><br><span> =
 * Wrapper function enabling query_user_exec() if no alternative methods ha=
ve</span><br><span>  * been enabled</span><br><span>diff --git a/src/openvp=
n/console_systemd.c b/src/openvpn/console_systemd.c</span><br><span>index c=
7cf1ad..cc91cd1 100644</span><br><span>--- a/src/openvpn/console_systemd.c<=
/span><br><span>+++ b/src/openvpn/console_systemd.c</span><br><span>@@ -96,=
7 +96,7 @@</span><br><span>  *</span><br><span>  */</span><br><span> bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-query_user_exec(void)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+query_user_exec_syste=
md(void)</span><br><span> {</span><br><span>     bool ret =3D true;  /* Pre=
sume everything goes okay */</span><br><span>     int i;</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvp=
n/test_pkcs11.c</span><br><span>index 6d283a2..5518fa1 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_pkcs11.c</span><br><span>@@ -75,6 +75,14 @@</span>=
<br><span> {</span><br><span>     assert_true(0);</span><br><span> }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_SYSTEMD=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+query_user_exec_systemd(void)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span> bool</span><br><span> query_user_ex=
ec_builtin(void)</span><br><span> {</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c=
</span><br><span>index b43e655..de60291 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_user_pass.c</span><br><span>@@ -26,10 +26,6 @@</span><br><span=
> #include &quot;config.h&quot;</span><br><span> #endif</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef ENABLE_SYSTEMD</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* avoid redefining ENA=
BLE_SYSTEMD in misc.c */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#undef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> #include &quot;syshead.h&quot;</span><br><span> #includ=
e &quot;manage.h&quot;</span><br><span> </span><br><span>@@ -44,6 +40,13 @@=
</span><br><span> struct management *management; /* global */</span><br><sp=
an> </span><br><span> /* mocking */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(ENABLE_SYSTEMD)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+query_user_exec_systemd(void)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return query_user_exec_builtin();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span> bool</span><br><span> query_user_exec_builtin(void=
)</span><br><span> {</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/670?usp=3Demail">change 670</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/670?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I379e1eb6dc57b9fe4bbdaefbd94=
7a14326e7117a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 670 </div>
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


--ELf3fDFs39A=--

