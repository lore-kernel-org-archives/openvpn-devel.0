From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 18:58:42 +0000
In-Reply-To: <gerrit.1737979301000.Ieee368e325d7f9c367fd91fee0fd3e281ee0855d@...2715...>
References: <gerrit.1737979301000.Ieee368e325d7f9c367fd91fee0fd3e281ee0855d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <925fab951611e9898cce85e07e7817a6c61e6dea-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T4OIf7QGr+k="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unit tests for
 atoi parsing options helper
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--T4OIf7QGr+k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/87=
6?usp=3Demail )

Change subject: Add unit tests for atoi parsing options helper
......................................................................

Add unit tests for atoi parsing options helper

Change-Id: Ieee368e325d7f9c367fd91fee0fd3e281ee0855d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250128175855.12289-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
671.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/mock_msg.h
M tests/unit_tests/openvpn/test_misc.c
3 files changed, 109 insertions(+), 3 deletions(-)




diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn=
/mock_msg.c
index a291f8f..b6ec744 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -37,10 +37,16 @@

 #include "errlevel.h"
 #include "error.h"
+#include "mock_msg.h"

 unsigned int x_debug_level =3D 0; /* Default to (almost) no debugging outp=
ut */
+unsigned int print_x_debug_level =3D 0;
+
 bool fatal_error_triggered =3D false;

+char mock_msg_buf[MOCK_MSG_BUF];
+
+
 void
 mock_set_debug_level(int level)
 {
@@ -48,6 +54,18 @@
 }

 int
+mock_get_debug_level(void)
+{
+    return x_debug_level;
+}
+
+void
+mock_set_print_debug_level(int level)
+{
+    print_x_debug_level =3D level;
+}
+
+int
 get_debug_level(void)
 {
     return x_debug_level;
@@ -62,8 +80,14 @@
         fatal_error_triggered =3D true;
         printf("FATAL ERROR:");
     }
-    vprintf(format, arglist);
-    printf("\n");
+    CLEAR(mock_msg_buf);
+    vsnprintf(mock_msg_buf, sizeof(mock_msg_buf), format, arglist);
+
+    if ((flags & M_DEBUG_LEVEL) <=3D print_x_debug_level)
+    {
+        printf("%s", mock_msg_buf);
+        printf("\n");
+    }
 }

 void
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn=
/mock_msg.h
index be5f2e5..bc2ee5d 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -31,4 +31,18 @@
  */
 void mock_set_debug_level(int level);

+#define MOCK_MSG_BUF 2048
+
+extern bool fatal_error_triggered;
+extern char mock_msg_buf[MOCK_MSG_BUF];
+
+void
+mock_set_debug_level(int level);
+
+int
+mock_get_debug_level(void);
+
+void
+mock_set_print_debug_level(int level);
+
 #endif /* MOCK_MSG */
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 563d4ae..56e9d98 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -38,6 +38,7 @@
 #include "options_util.h"
 #include "test_common.h"
 #include "list.h"
+#include "mock_msg.h"

 static void
 test_compat_lzo_string(void **state)
@@ -311,13 +312,80 @@
     gc_free(&gc);
 }

+static void
+test_atoi_variants(void **state)
+{
+    assert_true(valid_integer("1234", true));
+    assert_true(valid_integer("1234", false));
+    assert_true(valid_integer("0", false));
+    assert_true(valid_integer("0", true));
+    assert_true(valid_integer("-777", false));
+    assert_false(valid_integer("-777", true));
+
+    assert_false(valid_integer("-777foo", false));
+    assert_false(valid_integer("-777foo", true));
+
+    assert_false(valid_integer("foo777", true));
+    assert_false(valid_integer("foo777", false));
+
+    /* 2**31 + 5 , just outside of signed int range */
+    assert_false(valid_integer("2147483653", true));
+    assert_false(valid_integer("2147483653", false));
+    assert_false(valid_integer("-2147483653", true));
+    assert_false(valid_integer("-2147483653", false));
+
+
+    int msglevel =3D D_LOW;
+    int saved_log_level =3D mock_get_debug_level();
+    mock_set_debug_level(D_LOW);
+
+    /* check happy path */
+    assert_int_equal(positive_atoi("1234", msglevel), 1234);
+    assert_int_equal(positive_atoi("0", msglevel), 0);
+
+    assert_int_equal(atoi_warn("1234", msglevel), 1234);
+    assert_int_equal(atoi_warn("0", msglevel), 0);
+    assert_int_equal(atoi_warn("-1194", msglevel), -1194);
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(positive_atoi("-1234", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument '-1234' as no=
n-negative integer");
+
+    /* 2**31 + 5 , just outside of signed int range */
+    CLEAR(mock_msg_buf);
+    assert_int_equal(positive_atoi("2147483653", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument '2147483653' =
as non-negative integer");
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(atoi_warn("2147483653", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument '2147483653' =
as integer");
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(positive_atoi("foo77", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument 'foo77' as no=
n-negative integer");
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(positive_atoi("77foo", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument '77foo' as no=
n-negative integer");
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(atoi_warn("foo77", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument 'foo77' as in=
teger");
+
+    CLEAR(mock_msg_buf);
+    assert_int_equal(atoi_warn("77foo", msglevel), 0);
+    assert_string_equal(mock_msg_buf, "Cannot parse argument '77foo' as in=
teger");
+
+    mock_set_debug_level(saved_log_level);
+}

 const struct CMUnitTest misc_tests[] =3D {
     cmocka_unit_test(test_compat_lzo_string),
     cmocka_unit_test(test_auth_fail_temp_no_flags),
     cmocka_unit_test(test_auth_fail_temp_flags),
     cmocka_unit_test(test_auth_fail_temp_flags_msg),
-    cmocka_unit_test(test_list)
+    cmocka_unit_test(test_list),
+    cmocka_unit_test(test_atoi_variants)
 };

 int

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/876?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieee368e325d7f9c367fd91fee0fd3e281ee0855d
Gerrit-Change-Number: 876
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--T4OIf7QGr+k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/876?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Add unit tests for atoi parsing options helper=
<br><br>Change-Id: Ieee368e325d7f9c367fd91fee0fd3e281ee0855d<br>Signed-off-=
by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>Message-Id: &lt;20250128175855.12289-1-gert@...1826...=
6...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg30671.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M tests/unit_tests/openvpn/mock_msg.c<br>M tests/unit_tests/open=
vpn/mock_msg.h<br>M tests/unit_tests/openvpn/test_misc.c<br>3 files changed=
, 109 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/open=
vpn/mock_msg.c</span><br><span>index a291f8f..b6ec744 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/mock_msg.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/mock_msg.c</span><br><span>@@ -37,10 +37,16 @@</span><br><s=
pan> </span><br><span> #include &quot;errlevel.h&quot;</span><br><span> #in=
clude &quot;error.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;mock_msg.h&quot;</span><br><span> </span><br><span> un=
signed int x_debug_level =3D 0; /* Default to (almost) no debugging output =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int prin=
t_x_debug_level =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> bool fatal_error_triggered =3D false;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+char mock_msg_buf[=
MOCK_MSG_BUF];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</=
span><br><span> mock_set_debug_level(int level)</span><br><span> {</span><b=
r><span>@@ -48,6 +54,18 @@</span><br><span> }</span><br><span> </span><br><=
span> int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mock_get_d=
ebug_level(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return x_debug_le=
vel;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+mock_set_print_debug_level(int level)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    print_x_debug_level =3D level;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span> get_debug_level(void)</span><br><span> {</span><br><span>     return=
 x_debug_level;</span><br><span>@@ -62,8 +80,14 @@</span><br><span>        =
 fatal_error_triggered =3D true;</span><br><span>         printf(&quot;FATA=
L ERROR:&quot;);</span><br><span>     }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    vprintf(format, arglist);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    printf(&quot;\n&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    vsnprintf(mock_msg_buf, sizeof(m=
ock_msg_buf), format, arglist);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
((flags &amp; M_DEBUG_LEVEL) &lt;=3D print_x_debug_level)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        printf(&quot;%s&quot;, mock_msg_buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        printf(&quot;\n&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span> }</span><br><span> </span><br><span> void</span><br><span>diff --=
git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_m=
sg.h</span><br><span>index be5f2e5..bc2ee5d 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/mock_msg.h</span><br><span>+++ b/tests/unit_tests/op=
envpn/mock_msg.h</span><br><span>@@ -31,4 +31,18 @@</span><br><span>  */</s=
pan><br><span> void mock_set_debug_level(int level);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MOCK_MSG_BUF 204=
8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+extern bool fatal_error_triggered;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+extern char mock_msg_b=
uf[MOCK_MSG_BUF];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+mock_set_debug_level(int level);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+mock_get_debug_level(void);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mock_set=
_print_debug_level(int level);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> #endif /* MOCK_MSG */</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_m=
isc.c</span><br><span>index 563d4ae..56e9d98 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_misc.c</span><br><span>@@ -38,6 +38,7 @@</span><br><span> #inc=
lude &quot;options_util.h&quot;</span><br><span> #include &quot;test_common=
.h&quot;</span><br><span> #include &quot;list.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;mock_msg.h&quot;</span><br=
><span> </span><br><span> static void</span><br><span> test_compat_lzo_stri=
ng(void **state)</span><br><span>@@ -311,13 +312,80 @@</span><br><span>    =
 gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+test_atoi_variants(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(valid_integer(&quot;1234&quot;, true=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
valid_integer(&quot;1234&quot;, false));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(valid_integer(&quot;0&quot;, false));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(vali=
d_integer(&quot;0&quot;, true));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(valid_integer(&quot;-777&quot;, false));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(valid_in=
teger(&quot;-777&quot;, true));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_false(valid_integer(&quot;-777foo&quot;, false));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(valid_integer(&quot;-777=
foo&quot;, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(val=
id_integer(&quot;foo777&quot;, true));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(valid_integer(&quot;foo777&quot;, false=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* 2**31 + 5 , just outside of =
signed int range */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_false(valid_integer(&quot;2147483653&quot;, true));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(valid_integer(&=
quot;2147483653&quot;, false));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(valid_integer(&quot;-2147483653&quot;, true));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(va=
lid_integer(&quot;-2147483653&quot;, false));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int msgl=
evel =3D D_LOW;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int saved_log_level =3D mock_get_debug_level();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    mock_set_debug_level(D_LOW);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* check happy path */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(positive_atoi(&quot;1234&=
quot;, msglevel), 1234);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(positive_atoi(&quot;0&quot;, msglevel), 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(atoi_warn(&quot;1234&qu=
ot;, msglevel), 1234);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(atoi_warn(&quot;0&quot;, msglevel), 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(atoi_warn(=
&quot;-1194&quot;, msglevel), -1194);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(positive_atoi(&quot;-1234&quot;, msglevel), 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(mock_msg_buf, &quot;Cannot parse argument &#39;-1234&#39; as non-negative=
 integer&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 2**31 + 5 , jus=
t outside of signed int range */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(positive_atoi(&quot;2147483653&quot;=
, msglevel), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_string_equal(mock_msg_buf, &quot;Cannot parse argument &#39;2147483=
653&#39; as non-negative integer&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(atoi_warn(&quot;2147483653&quot;, msglevel), 0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(mock_msg_buf, &quot;Cannot parse argument &#39;2147483653&#39; as int=
eger&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
positive_atoi(&quot;foo77&quot;, msglevel), 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Can=
not parse argument &#39;foo77&#39; as non-negative integer&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(positive_atoi(&quot;=
77foo&quot;, msglevel), 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(mock_msg_buf, &quot;Cannot parse argument &=
#39;77foo&#39; as non-negative integer&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(atoi_warn(&quot;foo77&quot;, msglevel), 0=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string=
_equal(mock_msg_buf, &quot;Cannot parse argument &#39;foo77&#39; as integer=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(atoi=
_warn(&quot;77foo&quot;, msglevel), 0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Cannot pars=
e argument &#39;77foo&#39; as integer&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    mock_set_debug_level(saved_log_level);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> const st=
ruct CMUnitTest misc_tests[] =3D {</span><br><span>     cmocka_unit_test(te=
st_compat_lzo_string),</span><br><span>     cmocka_unit_test(test_auth_fail=
_temp_no_flags),</span><br><span>     cmocka_unit_test(test_auth_fail_temp_=
flags),</span><br><span>     cmocka_unit_test(test_auth_fail_temp_flags_msg=
),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cmocka_unit_tes=
t(test_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmo=
cka_unit_test(test_list),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    cmocka_unit_test(test_atoi_variants)</span><br><span> };</span><b=
r><span> </span><br><span> int</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/876?usp=3Demail">ch=
ange 876</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/876?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieee368e325d7f9c367fd91fee0f=
d3e281ee0855d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 876 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--T4OIf7QGr+k=--

