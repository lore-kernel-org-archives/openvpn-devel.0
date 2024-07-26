From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 26 Jul 2024 11:57:34 +0000
In-Reply-To: <gerrit.1718900482000.I379e1eb6dc57b9fe4bbdaefbd947a14326e7117a@...2715...>
References: <gerrit.1718900482000.I379e1eb6dc57b9fe4bbdaefbd947a14326e7117a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4af52f39c1bf80ef0de993928a1113cfffedb44a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f+/0hIAwkJc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: console_systemd:
 rename query_user_exec to query_user_systemd
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

--f+/0hIAwkJc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/67=
0?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240726104032.2112-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
983.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/console.h
M src/openvpn/console_systemd.c
M tests/unit_tests/openvpn/test_pkcs11.c
M tests/unit_tests/openvpn/test_user_pass.c
4 files changed, 37 insertions(+), 14 deletions(-)




diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 7358299..72ae8e0 100644
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
@@ -77,21 +76,34 @@

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
+static inline bool
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
  *
  */
-static bool
+static inline bool
 query_user_exec(void)
 {
     return query_user_exec_builtin();
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
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--f+/0hIAwkJc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/670?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">console_systemd: rename query_user_exec to que=
ry_user_systemd<br><br>This allows us to override query_user_exec for unit<=
br>tests more consistently without having to jump through<br>weird hoops.<b=
r><br>Fixes running test_pkcs11 with --enable-systemd.<br><br>While here al=
so fix documentation comments for<br>query_user_exec*.<br><br>Change-Id: I3=
79e1eb6dc57b9fe4bbdaefbd947a14326e7117a<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;=
<br>Message-Id: &lt;20240726104032.2112-1-gert@...1296...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28983.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openv=
pn/console.h<br>M src/openvpn/console_systemd.c<br>M tests/unit_tests/openv=
pn/test_pkcs11.c<br>M tests/unit_tests/openvpn/test_user_pass.c<br>4 files =
changed, 37 insertions(+), 14 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/console.h b/src/openvpn/console.h</span><br><sp=
an>index 7358299..72ae8e0 100644</span><br><span>--- a/src/openvpn/console.=
h</span><br><span>+++ b/src/openvpn/console.h</span><br><span>@@ -65,11 +65=
,10 @@</span><br><span> </span><br><span> </span><br><span> /**</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * Executes a configured setup, u=
sing the built-in method for querying the user.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Loop through configured query_user slots, us=
ing the built-in method for</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * querying the user.</span><br><span>  * This method uses the cons=
ole/TTY directly.</span><br><span>  *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @param setup    Pointer to the setup defining what to as=
k the user</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span>  * @return True if executing all the defined steps completed succe=
ssfully</span><br><span>  */</span><br><span> bool query_user_exec_builtin(=
void);</span><br><span>@@ -77,21 +76,34 @@</span><br><span> </span><br><spa=
n> #if defined(ENABLE_SYSTEMD)</span><br><span> /**</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Executes a configured setup, using the c=
ompiled method for querying the user</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
param setup    Pointer to the setup defining what to ask the user</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Loop through configured qu=
ery_user slots, using the systemd method for</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * querying the user.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * If systemd is not running it will fall back t=
o use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * query_user_=
exec_builtin() instead.</span><br><span>  *</span><br><span>  * @return Tru=
e if executing all the defined steps completed successfully</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool query_user_=
exec(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool que=
ry_user_exec_systemd(void);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#else  /* ENABLE_SYSTEMD not defined*/</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Loop through configured query_user slots, usi=
ng the compiled method for</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * querying the user.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn True if executing all the defined steps completed successfully</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+query_user_exec(void)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return query_user_exec_systemd();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else =
 /* ENABLE_SYSTEMD not defined */</span><br><span> /**</span><br><span>  * =
Wrapper function enabling query_user_exec() if no alternative methods have<=
/span><br><span>  * been enabled</span><br><span>  *</span><br><span>  */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><s=
pan> query_user_exec(void)</span><br><span> {</span><br><span>     return q=
uery_user_exec_builtin();</span><br><span>diff --git a/src/openvpn/console_=
systemd.c b/src/openvpn/console_systemd.c</span><br><span>index c7cf1ad..cc=
91cd1 100644</span><br><span>--- a/src/openvpn/console_systemd.c</span><br>=
<span>+++ b/src/openvpn/console_systemd.c</span><br><span>@@ -96,7 +96,7 @@=
</span><br><span>  *</span><br><span>  */</span><br><span> bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-query_user_exec(void)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+query_user_exec_systemd(void)</=
span><br><span> {</span><br><span>     bool ret =3D true;  /* Presume every=
thing goes okay */</span><br><span>     int i;</span><br><span>diff --git a=
/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkc=
s11.c</span><br><span>index 6d283a2..5518fa1 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_pkcs11.c</span><br><span>+++ b/tests/unit_test=
s/openvpn/test_pkcs11.c</span><br><span>@@ -75,6 +75,14 @@</span><br><span>=
 {</span><br><span>     assert_true(0);</span><br><span> }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_SYSTEMD)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+query_user_exec_systemd(void)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span> bool</span><br><span> query_user_exec_builtin=
(void)</span><br><span> {</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br=
><span>index b43e655..de60291 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_user_pass.c</span><br><span>@@ -26,10 +26,6 @@</span><br><span> #include=
 &quot;config.h&quot;</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#undef ENABLE_SYSTEMD</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/* avoid redefining ENABLE_SYSTEM=
D in misc.c */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef =
HAVE_CONFIG_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> #include &quot;syshead.h&quot;</span><br><span> #include &quot;ma=
nage.h&quot;</span><br><span> </span><br><span>@@ -44,6 +40,13 @@</span><br=
><span> struct management *management; /* global */</span><br><span> </span=
><br><span> /* mocking */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(ENABLE_SYSTEMD)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+q=
uery_user_exec_systemd(void)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n query_user_exec_builtin();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span> bool</span><br><span> query_user_exec_builtin(void)</span><b=
r><span> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/670?usp=3Demail">change 670</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/670?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I379e1eb6dc57b9fe4bbdaefbd94=
7a14326e7117a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 670 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--f+/0hIAwkJc=--

