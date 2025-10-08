From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 10:47:49 +0000
In-Reply-To: <gerrit.1759330832000.Icb91d9c560b6f78f16571ac3052cc566d94afe99@...2715...>
References: <gerrit.1759330832000.Icb91d9c560b6f78f16571ac3052cc566d94afe99@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <90ff0eb1e10496763c2e4b68575fb6498fc077ee-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+5xPKvXlVGQ="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+5xPKvXlVGQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
47?usp=3Demail )

Change subject: test_options_parse: Add test for read_config_string
......................................................................

test_options_parse: Add test for read_config_string

The <inlineopt> test discovered the issue
fixed by commit "buffer: Fix buf_parse eating input".

Change-Id: Icb91d9c560b6f78f16571ac3052cc566d94afe99
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1247
Message-Id: <20251008100222.4610-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243809/
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_options_parse.c
1 file changed, 109 insertions(+), 0 deletions(-)




diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tes=
ts/openvpn/test_options_parse.c
index 9472c78..e552dd7 100644
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
@@ -185,11 +188,117 @@
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
+    uintmax_t as_int;
+    void *as_pointer;
+};
+
+static int
+check_tokens(const uintmax_t value, const uintmax_t expected)
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
+
+    gc_free(&o.gc);
+    gc_free(&o.dns_options.gc);
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icb91d9c560b6f78f16571ac3052cc566d94afe99
Gerrit-Change-Number: 1247
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+5xPKvXlVGQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1247?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">test_options_parse: Add test for read_config_str=
ing<br><br>The &lt;inlineopt&gt; test discovered the issue<br>fixed by comm=
it &quot;buffer: Fix buf_parse eating input&quot;.<br><br>Change-Id: Icb91d=
9c560b6f78f16571ac3052cc566d94afe99<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>=
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1247<br>Message-Id: &lt;=
20251008100222.4610-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p=
/openvpn/mailman/message/59243809/<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_options_parse.c<br=
>1 file changed, 109 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_=
tests/openvpn/test_options_parse.c</span><br><span>index 9472c78..e552dd7 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_options_parse.c</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_options_parse.c</span><b=
r><span>@@ -43,6 +43,9 @@</span><br><span>                   const unsigned=
 int permission_mask, unsigned int *option_types_found,</span><br><span>   =
                struct env_set *es)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    function_called();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    check_expected(p);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    check_expected(is_inline);</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span>@@ =
-185,11 +188,117 @@</span><br><span>     gc_free(&amp;gc);</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_si=
ngle_config(struct options *options, const char *config)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    unsigned int option_types_found =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct env_set es;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(es);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    read_config_string(&quot;test_o=
ptions_parse&quot;, options, config, M_INFO, OPT_P_DEFAULT,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                       &amp;option_=
types_found, &amp;es);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+union tokens_parameter</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uintmax_t as_int;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    void *as_pointer;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_tokens(co=
nst uintmax_t value, const uintmax_t expected)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    union tokens_parameter temp;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    temp.as_int =3D value;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char **p =3D (const char **)temp.as_=
pointer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    temp.as=
_int =3D expected;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char **expected_p =3D (const char **)temp.as_pointer;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; MAX=
_PARMS; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!p[i] &am=
p;&amp; !expected_p[i])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
((p[i] &amp;&amp; !expected_p[i])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            || (!p[i] &amp;&amp; expected_p[i]))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            fprintf(stderr, &quot;diff at=
 i=3D%d\n&quot;, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (strcmp(p[i], expected_p[i]))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            fprintf(stderr, &quot;diff at i=3D%d, p=3D&lt;%s&gt; ep=
=3D&lt;%s&gt;\n&quot;, i, p[i], expected_p[i]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    fprintf(stderr, &quot;fallthrough&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_read_c=
onfig(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct options=
 o;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(o); /*=
 NB: avoiding init_options to limit dependencies */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_init(&amp;o.gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_init(&amp;o.dns_options.gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o.gc_owned =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    char *p_expect_someopt[MAX_PARM=
S];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *p_expe=
ct_otheropt[MAX_PARMS];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    char *p_expect_inlineopt[MAX_PARMS];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    CLEAR(p_expect_someopt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(p_expect_otheropt);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(p_expect_inlineopt);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p_expect_someopt=
[0] =3D &quot;someopt&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    p_expect_someopt[1] =3D &quot;parm1&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    p_expect_someopt[2] =3D &quot;parm2=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p_expect=
_otheropt[0] =3D &quot;otheropt&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    p_expect_otheropt[1] =3D &quot;1&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    p_expect_otheropt[2] =3D &qu=
ot;2&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p_ex=
pect_inlineopt[0] =3D &quot;inlineopt&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    p_expect_inlineopt[1] =3D &quot;some text\noth=
er text\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* basic test */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_function_c=
all(__wrap_add_option);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    expect_check(__wrap_add_option, p, check_tokens, p_expect_someopt);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_value(__=
wrap_add_option, is_inline, 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    expect_function_call(__wrap_add_option);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    expect_check(__wrap_add_option, p,=
 check_tokens, p_expect_otheropt);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    expect_value(__wrap_add_option, is_inline, 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    read_single_config(&amp;o=
, &quot;someopt parm1 parm2\n  otheropt 1 2&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* -- gets stripped */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    expect_function_call(__wrap_add_option);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    expect_check(__wrap_add_=
option, p, check_tokens, p_expect_someopt);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    expect_value(__wrap_add_option, is_inline, 0);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_function_=
call(__wrap_add_option);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    expect_check(__wrap_add_option, p, check_tokens, p_expect_otheropt=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_value(=
__wrap_add_option, is_inline, 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    read_single_config(&amp;o, &quot;someopt parm1 parm2\n\t-=
-otheropt 1 2&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* inline opt=
ions */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_f=
unction_call(__wrap_add_option);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    expect_check(__wrap_add_option, p, check_tokens, p_expect_=
inlineopt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expe=
ct_value(__wrap_add_option, is_inline, 1);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    read_single_config(&amp;o, &quot;&lt;inlineopt&g=
t;\nsome text\nother text\n&lt;/inlineopt&gt;&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    p_expect_inlineopt[0] =3D &quot;inlineopt&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    p_expect_inlineopt[1] =
=3D A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 &quot;\n&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_func=
tion_call(__wrap_add_option);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    expect_check(__wrap_add_option, p, check_tokens, p_expect_inl=
ineopt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_=
value(__wrap_add_option, is_inline, 1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    read_single_config(&amp;o, &quot;&lt;inlineopt&gt;\=
n&quot; A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 &quot;\=
n&lt;/inlineopt&gt;&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;o.gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;o.dns_options.gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> int</span><br><span> main(void)</span><br><span> {</span><br><span=
>     const struct CMUnitTest tests[] =3D {</span><br><span>         cmocka=
_unit_test(test_parse_line),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_read_config),</span><br><span>     }=
;</span><br><span> </span><br><span>     return cmocka_run_group_tests_name=
(&quot;options_parse&quot;, tests, NULL, NULL);</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/12=
47?usp=3Demail">change 1247</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1247?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icb91d9c560b6f78f16571ac3052=
cc566d94afe99 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1247 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--+5xPKvXlVGQ=--

