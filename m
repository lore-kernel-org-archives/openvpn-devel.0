From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 1 Oct 2025 15:00:39 +0000
References: <gerrit.1759330832000.Icb91d9c560b6f78f16571ac3052cc566d94afe99@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8ace59b6b401fc3955cf0a3bb1878cba3967d09e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a/BZrV5es3M="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_options_parse:
 Add test for read_config_string
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

--a/BZrV5es3M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1247?usp=3Demail

to review the following change.


Change subject: test_options_parse: Add test for read_config_string
......................................................................

test_options_parse: Add test for read_config_string

The <inlineopt> test discovered the issue
fixed by commit "buffer: Fix buf_parse eating input".

Change-Id: Icb91d9c560b6f78f16571ac3052cc566d94afe99
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/test_options_parse.c
1 file changed, 106 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/1247/1

diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tes=
ts/openvpn/test_options_parse.c
index 9472c78..a5732c5 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -43,6 +43,9 @@
                   const unsigned int permission_mask, unsigned int *option=
_types_found,
                   struct env_set *es)
 {
+    function_called();
+    check_expected(p);
+    check_expected(is_inline);
 }

 void
@@ -185,11 +188,114 @@
     gc_free(&gc);
 }

+static void
+read_single_config(struct options *options, const char *config)
+{
+    unsigned int option_types_found =3D 0;
+    struct env_set es;
+    CLEAR(es);
+    read_config_string("test_options_parse", options, config, M_INFO, OPT_=
P_DEFAULT,
+                       &option_types_found, &es);
+}
+
+union tokens_parameter
+{
+    LargestIntegralType as_int;
+    void *as_pointer;
+};
+
+static int
+check_tokens(const LargestIntegralType value, const LargestIntegralType ex=
pected)
+{
+    union tokens_parameter temp;
+    temp.as_int =3D value;
+    const char **p =3D (const char **)temp.as_pointer;
+    temp.as_int =3D expected;
+    const char **expected_p =3D (const char **)temp.as_pointer;
+    for (int i =3D 0; i < MAX_PARMS; i++)
+    {
+        if (!p[i] && !expected_p[i])
+        {
+            return true;
+        }
+        if ((p[i] && !expected_p[i])
+            || (!p[i] && expected_p[i]))
+        {
+            fprintf(stderr, "diff at i=3D%d\n", i);
+            return false;
+        }
+        if (strcmp(p[i], expected_p[i]))
+        {
+            fprintf(stderr, "diff at i=3D%d, p=3D<%s> ep=3D<%s>\n", i, p[i=
], expected_p[i]);
+            return false;
+        }
+    }
+    fprintf(stderr, "fallthrough");
+    return false;
+}
+
+static void
+test_read_config(void **state)
+{
+    struct options o;
+    CLEAR(o); /* NB: avoiding init_options to limit dependencies */
+    gc_init(&o.gc);
+    gc_init(&o.dns_options.gc);
+    o.gc_owned =3D true;
+
+    char *p_expect_someopt[MAX_PARMS];
+    char *p_expect_otheropt[MAX_PARMS];
+    char *p_expect_inlineopt[MAX_PARMS];
+    CLEAR(p_expect_someopt);
+    CLEAR(p_expect_otheropt);
+    CLEAR(p_expect_inlineopt);
+    p_expect_someopt[0] =3D "someopt";
+    p_expect_someopt[1] =3D "parm1";
+    p_expect_someopt[2] =3D "parm2";
+    p_expect_otheropt[0] =3D "otheropt";
+    p_expect_otheropt[1] =3D "1";
+    p_expect_otheropt[2] =3D "2";
+    p_expect_inlineopt[0] =3D "inlineopt";
+    p_expect_inlineopt[1] =3D "some text\nother text\n";
+
+    /* basic test */
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_someopt);
+    expect_value(__wrap_add_option, is_inline, 0);
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_otheropt);
+    expect_value(__wrap_add_option, is_inline, 0);
+    read_single_config(&o, "someopt parm1 parm2\n  otheropt 1 2");
+
+    /* -- gets stripped */
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_someopt);
+    expect_value(__wrap_add_option, is_inline, 0);
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_otheropt);
+    expect_value(__wrap_add_option, is_inline, 0);
+    read_single_config(&o, "someopt parm1 parm2\n\t--otheropt 1 2");
+
+    /* inline options */
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_inlineopt);
+    expect_value(__wrap_add_option, is_inline, 1);
+    read_single_config(&o, "<inlineopt>\nsome text\nother text\n</inlineop=
t>");
+
+    p_expect_inlineopt[0] =3D "inlineopt";
+    p_expect_inlineopt[1] =3D A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_=
256 A_TIMES_256 "\n";
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_inlineopt);
+    expect_value(__wrap_add_option, is_inline, 1);
+    read_single_config(&o, "<inlineopt>\n" A_TIMES_256 A_TIMES_256 A_TIMES=
_256 A_TIMES_256 A_TIMES_256 "\n</inlineopt>");
+}
+
 int
 main(void)
 {
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(test_parse_line),
+        cmocka_unit_test(test_read_config),
     };

     return cmocka_run_group_tests_name("options_parse", tests, NULL, NULL);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1247?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icb91d9c560b6f78f16571ac3052cc566d94afe99
Gerrit-Change-Number: 1247
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--a/BZrV5es3M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1247?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">test_options_parse: Add test for read_confi=
g_string<br><br>The &lt;inlineopt&gt; test discovered the issue<br>fixed by=
 commit &quot;buffer: Fix buf_parse eating input&quot;.<br><br>Change-Id: I=
cb91d9c560b6f78f16571ac3052cc566d94afe99<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>---<br>M tests/unit_tests/openvpn/test_option=
s_parse.c<br>1 file changed, 106 insertions(+), 0 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/47/1247/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_options_parse=
.c b/tests/unit_tests/openvpn/test_options_parse.c</span><br><span>index 94=
72c78..a5732c5 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_o=
ptions_parse.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_options_=
parse.c</span><br><span>@@ -43,6 +43,9 @@</span><br><span>                 =
  const unsigned int permission_mask, unsigned int *option_types_found,</sp=
an><br><span>                   struct env_set *es)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    function_called();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_expected(p)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_expected=
(is_inline);</span><br><span> }</span><br><span> </span><br><span> void</sp=
an><br><span>@@ -185,11 +188,114 @@</span><br><span>     gc_free(&amp;gc);<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+read_single_config(struct options *options, const char *config)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    unsigned int option_types_found =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct env_se=
t es;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(es);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    read_config_str=
ing(&quot;test_options_parse&quot;, options, config, M_INFO, OPT_P_DEFAULT,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
    &amp;option_types_found, &amp;es);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+union tokens_param=
eter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    LargestIntegralType as_int;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void *as_pointer;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+check_tokens(const LargestIntegralType value, const LargestInteg=
ralType expected)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    union tokens_par=
ameter temp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tem=
p.as_int =3D value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char **p =3D (const char **)temp.as_pointer;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    temp.as_int =3D expected;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const char **expected_p =
=3D (const char **)temp.as_pointer;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (int i =3D 0; i &lt; MAX_PARMS; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (!p[i] &amp;&amp; !expected_p[i])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if ((p[i] &amp;&amp; !expected=
_p[i])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            |=
| (!p[i] &amp;&amp; expected_p[i]))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            fprintf(stderr, &quot;diff at i=3D%d\n&quot;, i);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (strcmp(p[i], expect=
ed_p[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fprintf(=
stderr, &quot;diff at i=3D%d, p=3D&lt;%s&gt; ep=3D&lt;%s&gt;\n&quot;, i, p[=
i], expected_p[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fprintf(stderr=
, &quot;fallthrough&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_read_config(void **state)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct options o;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    CLEAR(o); /* NB: avoiding init_options t=
o limit dependencies */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gc_init(&amp;o.gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_init(&amp;o.dns_options.gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    o.gc_owned =3D true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    char *p_expect_someopt[MAX_PARMS];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char *p_expect_otheropt[MAX_PARMS];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char *p_expect_inlineo=
pt[MAX_PARMS];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    C=
LEAR(p_expect_someopt);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    CLEAR(p_expect_otheropt);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    CLEAR(p_expect_inlineopt);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    p_expect_someopt[0] =3D &quot;someopt&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p_expect_someopt[=
1] =3D &quot;parm1&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    p_expect_someopt[2] =3D &quot;parm2&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    p_expect_otheropt[0] =3D &quot;othero=
pt&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p_expe=
ct_otheropt[1] =3D &quot;1&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    p_expect_otheropt[2] =3D &quot;2&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    p_expect_inlineopt[0] =3D &quot;i=
nlineopt&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
p_expect_inlineopt[1] =3D &quot;some text\nother text\n&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* basic test */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    expect_function_call(__wrap_add_option);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_check(__wrap_a=
dd_option, p, check_tokens, p_expect_someopt);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    expect_value(__wrap_add_option, is_inline, 0=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_functi=
on_call(__wrap_add_option);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    expect_check(__wrap_add_option, p, check_tokens, p_expect_other=
opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_val=
ue(__wrap_add_option, is_inline, 0);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    read_single_config(&amp;o, &quot;someopt parm1 parm2\n=
  otheropt 1 2&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* -- gets s=
tripped */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expec=
t_function_call(__wrap_add_option);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    expect_check(__wrap_add_option, p, check_tokens, p_expe=
ct_someopt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exp=
ect_value(__wrap_add_option, is_inline, 0);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    expect_function_call(__wrap_add_option);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_check(__wrap_ad=
d_option, p, check_tokens, p_expect_otheropt);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    expect_value(__wrap_add_option, is_inline, 0=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    read_single_c=
onfig(&amp;o, &quot;someopt parm1 parm2\n\t--otheropt 1 2&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* inline options */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    expect_function_call(__wrap_add_optio=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_check=
(__wrap_add_option, p, check_tokens, p_expect_inlineopt);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    expect_value(__wrap_add_option, i=
s_inline, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
ad_single_config(&amp;o, &quot;&lt;inlineopt&gt;\nsome text\nother text\n&l=
t;/inlineopt&gt;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p_expect_i=
nlineopt[0] =3D &quot;inlineopt&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    p_expect_inlineopt[1] =3D A_TIMES_256 A_TIMES_256 A_=
TIMES_256 A_TIMES_256 A_TIMES_256 &quot;\n&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    expect_function_call(__wrap_add_option);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_check(__w=
rap_add_option, p, check_tokens, p_expect_inlineopt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    expect_value(__wrap_add_option, is_in=
line, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    read_s=
ingle_config(&amp;o, &quot;&lt;inlineopt&gt;\n&quot; A_TIMES_256 A_TIMES_25=
6 A_TIMES_256 A_TIMES_256 A_TIMES_256 &quot;\n&lt;/inlineopt&gt;&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> m=
ain(void)</span><br><span> {</span><br><span>     const struct CMUnitTest t=
ests[] =3D {</span><br><span>         cmocka_unit_test(test_parse_line),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_read_config),</span><br><span>     };</span><br><span> </span><br><=
span>     return cmocka_run_group_tests_name(&quot;options_parse&quot;, tes=
ts, NULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1247?usp=3Demail">change 1247</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1247?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icb91d9c560b6f78f16571ac3052=
cc566d94afe99 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1247 </div>
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

--a/BZrV5es3M=--

