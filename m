From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 27 Jan 2025 12:01:46 +0000
References: <gerrit.1737979301000.Ieee368e325d7f9c367fd91fee0fd3e281ee0855d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2f6f608cb61cccee430ea675de28ededf19a7e4f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="By0wqAz3Mks="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--By0wqAz3Mks=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/876?usp=3Demail

to review the following change.


Change subject: Add unit tests for atoi parsing options helper
......................................................................

Add unit tests for atoi parsing options helper

Change-Id: Ieee368e325d7f9c367fd91fee0fd3e281ee0855d
---
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/mock_msg.h
M tests/unit_tests/openvpn/test_misc.c
3 files changed, 108 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/876/1

diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn=
/mock_msg.c
index a291f8f..99224f8 100644
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
@@ -62,8 +80,13 @@
         fatal_error_triggered =3D true;
         printf("FATAL ERROR:");
     }
-    vprintf(format, arglist);
-    printf("\n");
+    CLEAR(mock_msg_buf);
+    if ((flags & M_DEBUG_LEVEL) <=3D print_x_debug_level)
+    {
+        vprintf(format, arglist);
+        printf("\n");
+    }
+    vsnprintf(mock_msg_buf, sizeof(mock_msg_buf), format, arglist);
 }

 void
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn=
/mock_msg.h
index be5f2e5..25b7aa2 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -31,4 +31,18 @@
  */
 void mock_set_debug_level(int level);

+#define MOCK_MSG_BUF 1024
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--By0wqAz3Mks=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/876?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add unit tests for atoi parsing options helper<br><br>Change-=
Id: Ieee368e325d7f9c367fd91fee0fd3e281ee0855d<br>---<br>M tests/unit_tests/=
openvpn/mock_msg.c<br>M tests/unit_tests/openvpn/mock_msg.h<br>M tests/unit=
_tests/openvpn/test_misc.c<br>3 files changed, 108 insertions(+), 3 deletio=
ns(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/76/876/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests=
/unit_tests/openvpn/mock_msg.c</span><br><span>index a291f8f..99224f8 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/mock_msg.c</span><br><span=
>+++ b/tests/unit_tests/openvpn/mock_msg.c</span><br><span>@@ -37,10 +37,16=
 @@</span><br><span> </span><br><span> #include &quot;errlevel.h&quot;</spa=
n><br><span> #include &quot;error.h&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;mock_msg.h&quot;</span><br><span> </sp=
an><br><span> unsigned int x_debug_level =3D 0; /* Default to (almost) no d=
ebugging output */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
nsigned int print_x_debug_level =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> bool fatal_error_triggered =3D false;<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ch=
ar mock_msg_buf[MOCK_MSG_BUF];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> void</span><br><span> mock_set_debug_level(int level)</span><br><=
span> {</span><br><span>@@ -48,6 +54,18 @@</span><br><span> }</span><br><sp=
an> </span><br><span> int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+mock_get_debug_level(void)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn x_debug_level;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+mock_set_print_debug_level(int level)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    print_x_debug_level =3D level;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int</span><br><span> get_debug_level(void)</span><br><span> {</span><br><=
span>     return x_debug_level;</span><br><span>@@ -62,8 +80,13 @@</span><b=
r><span>         fatal_error_triggered =3D true;</span><br><span>         p=
rintf(&quot;FATAL ERROR:&quot;);</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    vprintf(format, arglist);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;\n&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((flags &amp;=
 M_DEBUG_LEVEL) &lt;=3D print_x_debug_level)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        vprintf(format, arglist);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        printf(&quot;\n&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    vsnprintf(mock_msg_buf, sizeof(mock_msg_buf), fo=
rmat, arglist);</span><br><span> }</span><br><span> </span><br><span> void<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/un=
it_tests/openvpn/mock_msg.h</span><br><span>index be5f2e5..25b7aa2 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/mock_msg.h</span><br><span>++=
+ b/tests/unit_tests/openvpn/mock_msg.h</span><br><span>@@ -31,4 +31,18 @@<=
/span><br><span>  */</span><br><span> void mock_set_debug_level(int level);=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define MOCK_MSG_BUF 1024</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extern bool fa=
tal_error_triggered;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+extern char mock_msg_buf[MOCK_MSG_BUF];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mock_set_debu=
g_level(int level);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+mock_get_debug_level(void);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+mock_set_print_debug_level(int level);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* MOCK_MSG */</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/un=
it_tests/openvpn/test_misc.c</span><br><span>index 563d4ae..56e9d98 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_misc.c</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_misc.c</span><br><span>@@ -38,6 +38,7 @=
@</span><br><span> #include &quot;options_util.h&quot;</span><br><span> #in=
clude &quot;test_common.h&quot;</span><br><span> #include &quot;list.h&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;moc=
k_msg.h&quot;</span><br><span> </span><br><span> static void</span><br><spa=
n> test_compat_lzo_string(void **state)</span><br><span>@@ -311,13 +312,80 =
@@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_atoi_variants(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(valid_integer=
(&quot;1234&quot;, true));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(valid_integer(&quot;1234&quot;, false));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(valid_integer(&=
quot;0&quot;, false));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(valid_integer(&quot;0&quot;, true));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(valid_integer(&quot;-77=
7&quot;, false));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(valid_integer(&quot;-777&quot;, true));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_false(valid_integer(&quot;-777foo&quot;, false))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(v=
alid_integer(&quot;-777foo&quot;, true));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_false(valid_integer(&quot;foo777&quot;, true));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(valid_integer(&q=
uot;foo777&quot;, false));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 2**31=
 + 5 , just outside of signed int range */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(valid_integer(&quot;2147483653&quot=
;, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(valid_integer(&quot;2147483653&quot;, false));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(valid_integer(&quot;-21=
47483653&quot;, true));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_false(valid_integer(&quot;-2147483653&quot;, false));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int msglevel =3D D_LOW;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int saved_log_level =3D mock_get_debug_level();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    mock_set_debug_level=
(D_LOW);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* check happy path */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(po=
sitive_atoi(&quot;1234&quot;, msglevel), 1234);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(positive_atoi(&quot;0&quot=
;, msglevel), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
atoi_warn(&quot;1234&quot;, msglevel), 1234);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(atoi_warn(&quot;0&quot;, msg=
level), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(atoi_warn(&quot;-1194&quot;, msglevel), -1194);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(positive_atoi(&quot;-1234&q=
uot;, msglevel), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(mock_msg_buf, &quot;Cannot parse argument &#39;-12=
34&#39; as non-negative integer&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* 2**31 + 5 , just outside of signed int range */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(positive_atoi=
(&quot;2147483653&quot;, msglevel), 0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Cannot pars=
e argument &#39;2147483653&#39; as non-negative integer&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(atoi_warn(&quot;21474836=
53&quot;, msglevel), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(mock_msg_buf, &quot;Cannot parse argument &#39=
;2147483653&#39; as integer&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(positive_atoi(&quot;foo77&quot;, msglevel), 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(=
mock_msg_buf, &quot;Cannot parse argument &#39;foo77&#39; as non-negative i=
nteger&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(positive_atoi(&quot;77foo&quot;, msglevel), 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;C=
annot parse argument &#39;77foo&#39; as non-negative integer&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(atoi_warn(&quot;foo=
77&quot;, msglevel), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(mock_msg_buf, &quot;Cannot parse argument &#39=
;foo77&#39; as integer&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEA=
R(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(atoi_warn(&quot;77foo&quot;, msglevel), 0);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_=
buf, &quot;Cannot parse argument &#39;77foo&#39; as integer&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    mock_set_debug_level(saved_log_level);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </sp=
an><br><span> const struct CMUnitTest misc_tests[] =3D {</span><br><span>  =
   cmocka_unit_test(test_compat_lzo_string),</span><br><span>     cmocka_un=
it_test(test_auth_fail_temp_no_flags),</span><br><span>     cmocka_unit_tes=
t(test_auth_fail_temp_flags),</span><br><span>     cmocka_unit_test(test_au=
th_fail_temp_flags_msg),</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    cmocka_unit_test(test_list)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    cmocka_unit_test(test_list),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_atoi_variants)</span>=
<br><span> };</span><br><span> </span><br><span> int</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/876?usp=3Demail">change 876</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/876?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieee368e325d7f9c367fd91fee0f=
d3e281ee0855d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 876 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--By0wqAz3Mks=--

