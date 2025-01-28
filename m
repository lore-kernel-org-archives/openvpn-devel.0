From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 18:58:40 +0000
In-Reply-To: <gerrit.1737979301000.Ieee368e325d7f9c367fd91fee0fd3e281ee0855d@...2715...>
References: <gerrit.1737979301000.Ieee368e325d7f9c367fd91fee0fd3e281ee0855d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <925fab951611e9898cce85e07e7817a6c61e6dea-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vQBitHy8ny4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vQBitHy8ny4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/876?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/876/3

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
Gerrit-MessageType: newpatchset

--vQBitHy8ny4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
876?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add unit tests for atoi parsing options helpe=
r<br><br>Change-Id: Ieee368e325d7f9c367fd91fee0fd3e281ee0855d<br>Signed-off=
-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>Message-Id: &lt;20250128175855.12289-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg30671.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M tests/unit_tests/openvpn/mock_msg.c<br>M tests/unit_tests/ope=
nvpn/mock_msg.h<br>M tests/unit_tests/openvpn/test_misc.c<br>3 files change=
d, 109 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/76/876/3</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_t=
ests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c</span><br><sp=
an>index a291f8f..b6ec744 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/mock_msg.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_msg.c</=
span><br><span>@@ -37,10 +37,16 @@</span><br><span> </span><br><span> #incl=
ude &quot;errlevel.h&quot;</span><br><span> #include &quot;error.h&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mock_ms=
g.h&quot;</span><br><span> </span><br><span> unsigned int x_debug_level =3D=
 0; /* Default to (almost) no debugging output */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+unsigned int print_x_debug_level =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool fa=
tal_error_triggered =3D false;</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+char mock_msg_buf[MOCK_MSG_BUF];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> mock_set_deb=
ug_level(int level)</span><br><span> {</span><br><span>@@ -48,6 +54,18 @@</=
span><br><span> }</span><br><span> </span><br><span> int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+mock_get_debug_level(void)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return x_debug_level;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mock_set_print_deb=
ug_level(int level)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    print_x_debug_=
level =3D level;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+int</span><br><span> get_debug_level(voi=
d)</span><br><span> {</span><br><span>     return x_debug_level;</span><br>=
<span>@@ -62,8 +80,14 @@</span><br><span>         fatal_error_triggered =3D=
 true;</span><br><span>         printf(&quot;FATAL ERROR:&quot;);</span><br=
><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    vpri=
ntf(format, arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    printf(&quot;\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    vsnprintf(mock_msg_buf, sizeof(mock_msg_buf), format, argl=
ist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if ((flags &amp; M_DEBUG_LEVE=
L) &lt;=3D print_x_debug_level)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      printf(&quot;%s&quot;, mock_msg_buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        printf(&quot;\n&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h</span><br><span>index=
 be5f2e5..bc2ee5d 100644</span><br><span>--- a/tests/unit_tests/openvpn/moc=
k_msg.h</span><br><span>+++ b/tests/unit_tests/openvpn/mock_msg.h</span><br=
><span>@@ -31,4 +31,18 @@</span><br><span>  */</span><br><span> void mock_s=
et_debug_level(int level);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define MOCK_MSG_BUF 2048</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+extern bool fatal_error_triggered;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+extern char mock_msg_buf[MOCK_MSG_BUF];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+mock_set_debug_level(int level);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mock_get_=
debug_level(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+mock_set_print_debug_level(int leve=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #endif /* MOCK_MSG */</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c</span><br><span>index=
 563d4ae..56e9d98 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_misc.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc.c</span><=
br><span>@@ -38,6 +38,7 @@</span><br><span> #include &quot;options_util.h&q=
uot;</span><br><span> #include &quot;test_common.h&quot;</span><br><span> #=
include &quot;list.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;mock_msg.h&quot;</span><br><span> </span><br><span> s=
tatic void</span><br><span> test_compat_lzo_string(void **state)</span><br>=
<span>@@ -311,13 +312,80 @@</span><br><span>     gc_free(&amp;gc);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_atoi_variants(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(valid_integer(&quot;1234&quot;, true));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(valid_integer(&quot;1234&=
quot;, false));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(valid_integer(&quot;0&quot;, false));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(valid_integer(&quot;0&quot;, =
true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(valid_integer(&quot;-777&quot;, false));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(valid_integer(&quot;-777&quot;, t=
rue));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(valid_integer(&=
quot;-777foo&quot;, false));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_false(valid_integer(&quot;-777foo&quot;, true));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_false(valid_integer(&quot;foo777&q=
uot;, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(valid_integer(&quot;foo777&quot;, false));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* 2**31 + 5 , just outside of signed int range */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(valid_in=
teger(&quot;2147483653&quot;, true));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(valid_integer(&quot;2147483653&quot;, fa=
lse));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fa=
lse(valid_integer(&quot;-2147483653&quot;, true));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_false(valid_integer(&quot;-214748=
3653&quot;, false));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int msglevel =3D D_LOW;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int saved_log_level =3D m=
ock_get_debug_level();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    mock_set_debug_level(D_LOW);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* check happy path */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(positive_atoi(&quot;1234&quot;, msglevel), 1234);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(positive_atoi(&quot;0&quot;, msglevel), 0);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(atoi_warn(&quot;1234&quot;, msglevel), 1234);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(a=
toi_warn(&quot;0&quot;, msglevel), 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(atoi_warn(&quot;-1194&quot;, msglev=
el), -1194);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
positive_atoi(&quot;-1234&quot;, msglevel), 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Can=
not parse argument &#39;-1234&#39; as non-negative integer&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* 2**31 + 5 , just outside of signed int r=
ange */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mo=
ck_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(positive_atoi(&quot;2147483653&quot;, msglevel), 0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock=
_msg_buf, &quot;Cannot parse argument &#39;2147483653&#39; as non-negative =
integer&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(atoi_warn(&quot;2147483653&quot;, msglevel), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &qu=
ot;Cannot parse argument &#39;2147483653&#39; as integer&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(positive_atoi(&quot;foo=
77&quot;, msglevel), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(mock_msg_buf, &quot;Cannot parse argument &#39=
;foo77&#39; as non-negative integer&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(positive_atoi(&quot;77foo&quot;, msglevel), =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_strin=
g_equal(mock_msg_buf, &quot;Cannot parse argument &#39;77foo&#39; as non-ne=
gative integer&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_m=
sg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(atoi_warn(&quot;foo77&quot;, msglevel), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &qu=
ot;Cannot parse argument &#39;foo77&#39; as integer&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(atoi_warn(&quot;77foo&quot;,=
 msglevel), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(mock_msg_buf, &quot;Cannot parse argument &#39;77foo&#3=
9; as integer&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mock_set_debu=
g_level(saved_log_level);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span> </span><br><span> const struct CMUnitTest misc_tes=
ts[] =3D {</span><br><span>     cmocka_unit_test(test_compat_lzo_string),</=
span><br><span>     cmocka_unit_test(test_auth_fail_temp_no_flags),</span><=
br><span>     cmocka_unit_test(test_auth_fail_temp_flags),</span><br><span>=
     cmocka_unit_test(test_auth_fail_temp_flags_msg),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    cmocka_unit_test(test_list)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_list)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_te=
st(test_atoi_variants)</span><br><span> };</span><br><span> </span><br><spa=
n> int</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/876?usp=3Demail">change 876</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/876?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--vQBitHy8ny4=--

