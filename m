From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 22 Aug 2025 15:52:00 +0000
References: <gerrit.1755877911000.I454126b3f8fa9d14501f6c4b1ed9ce7b2904be61@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a6d4660ddf0bc48d3a4d9980f65c6ff36859f518-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IAafsZlDdnY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Factor out
 usages of strtoll and atoll
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

--IAafsZlDdnY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1154?usp=3Demail

to review the following change.


Change subject: options: Factor out usages of strtoll and atoll
......................................................................

options: Factor out usages of strtoll and atoll

This covers the cases where we actually want to
allow numbers > 2^31

Change-Id: I454126b3f8fa9d14501f6c4b1ed9ce7b2904be61
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M tests/unit_tests/openvpn/test_misc.c
4 files changed, 41 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/1154/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7c685e2..6e97ae4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7181,8 +7181,7 @@
         options->inactivity_timeout =3D positive_atoi(p[1], msglevel);
         if (p[2])
         {
-            int64_t val =3D atoll(p[2]);
-            options->inactivity_minimum_bytes =3D (val < 0) ? 0 : val;
+            positive_atoll(p[2], &options->inactivity_minimum_bytes, p[0],=
 msglevel);
             if (options->inactivity_minimum_bytes > INT_MAX)
             {
                 msg(M_WARN,
@@ -9528,26 +9527,18 @@
     else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        char *end;
-        long long reneg_bytes =3D strtoll(p[1], &end, 10);
-        if (*end !=3D '\0' || reneg_bytes < 0)
+        if (!positive_atoll(p[1], &options->renegotiate_bytes, p[0], msgle=
vel))
         {
-            msg(msglevel, "--reneg-bytes parameter must be an integer and =
>=3D 0");
             goto err;
         }
-        options->renegotiate_bytes =3D reneg_bytes;
     }
     else if (streq(p[0], "reneg-pkts") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        char *end;
-        long long pkt_max =3D strtoll(p[1], &end, 10);
-        if (*end !=3D '\0' || pkt_max < 0)
+        if (!positive_atoll(p[1], &options->renegotiate_packets, p[0], msg=
level))
         {
-            msg(msglevel, "--reneg-pkts parameter must be an integer and >=
=3D 0");
             goto err;
         }
-        options->renegotiate_packets =3D pkt_max;
     }
     else if (streq(p[0], "reneg-sec") && p[1] && !p[3])
     {
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 32a9edb..e930078 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -131,6 +131,22 @@
     return (int)i;
 }

+bool
+positive_atoll(const char *str, int64_t *value, const char *name, int msgl=
evel)
+{
+    char *endptr;
+    long long ll =3D strtoll(str, &endptr, 10);
+
+    if (ll < 0 || *endptr !=3D '\0')
+    {
+        msg(msglevel, "%s: Cannot parse '%s' as non-negative integer", nam=
e, str);
+        return false;
+    }
+
+    *value =3D (int64_t)ll;
+    return true;
+}
+
 int
 atoi_warn(const char *str, int msglevel)
 {
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index b9e1569..5d38eda 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -41,6 +41,17 @@

 /**
  * Converts a str to an integer if the string can be represented as an
+ * integer number and is >=3D 0.
+ * The integer is stored in \p value.
+ * On error, print a warning with \p msglevel using \p name. \p value is
+ * not changed on error.
+ *
+ * @return \c true if the integer has been parsed and stored in value, \c =
false otherwise
+ */
+bool positive_atoll(const char *str, int64_t *value, const char *name, int=
 msglevel);
+
+/**
+ * Converts a str to an integer if the string can be represented as an
  * integer number. Otherwise print a warning with \p msglevel and return 0
  */
 int atoi_warn(const char *str, int msglevel);
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 2d2cc9e..ff96644 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -359,6 +359,17 @@
     assert_true(atoi_constrained("-1194", &parameter, "test", INT_MIN, INT=
_MAX, msglevel));
     assert_int_equal(parameter, -1194);

+    int64_t parameter64 =3D 0;
+    assert_true(positive_atoll("1234", &parameter64, "test", msglevel));
+    assert_int_equal(parameter64, 1234);
+    assert_true(positive_atoll("0", &parameter64, "test", msglevel));
+    assert_int_equal(parameter64, 0);
+    assert_true(positive_atoll("2147483653", &parameter64, "test", msgleve=
l));
+    assert_int_equal(parameter64, 2147483653);
+    /* overflow gets capped to LLONG_MAX */
+    assert_true(positive_atoll("9223372036854775810", &parameter64, "test"=
, msglevel));
+    assert_int_equal(parameter64, 9223372036854775807);
+
     CLEAR(mock_msg_buf);
     assert_int_equal(positive_atoi("-1234", msglevel), 0);
     assert_string_equal(mock_msg_buf, "Cannot parse argument '-1234' as no=
n-negative integer");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1154?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I454126b3f8fa9d14501f6c4b1ed9ce7b2904be61
Gerrit-Change-Number: 1154
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--IAafsZlDdnY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1154?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">options: Factor out usages of strtoll and atoll<br><br>This =
covers the cases where we actually want to<br>allow numbers &gt; 2^31<br><b=
r>Change-Id: I454126b3f8fa9d14501f6c4b1ed9ce7b2904be61<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/options.c<=
br>M src/openvpn/options_util.c<br>M src/openvpn/options_util.h<br>M tests/=
unit_tests/openvpn/test_misc.c<br>4 files changed, 41 insertions(+), 12 del=
etions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/54/1154/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/op=
tions.c</span><br><span>index 7c685e2..6e97ae4 100644</span><br><span>--- a=
/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><b=
r><span>@@ -7181,8 +7181,7 @@</span><br><span>         options-&gt;inactivi=
ty_timeout =3D positive_atoi(p[1], msglevel);</span><br><span>         if (=
p[2])</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            int64_t val =3D atoll(p[2]);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            options-&gt;inactivity_minimum_=
bytes =3D (val &lt; 0) ? 0 : val;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            positive_atoll(p[2], &amp;options-&gt;inactivity_=
minimum_bytes, p[0], msglevel);</span><br><span>             if (options-&g=
t;inactivity_minimum_bytes &gt; INT_MAX)</span><br><span>             {</sp=
an><br><span>                 msg(M_WARN,</span><br><span>@@ -9528,26 +9527=
,18 @@</span><br><span>     else if (streq(p[0], &quot;reneg-bytes&quot;) &=
amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>   =
      VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        char *end;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        long long reneg_bytes =3D strtoll(p[1], &amp;end, =
10);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (*end =
!=3D &#39;\0&#39; || reneg_bytes &lt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (!positive_atoll(p[1], &amp;options-&gt;ren=
egotiate_bytes, p[0], msglevel))</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;--ren=
eg-bytes parameter must be an integer and &gt;=3D 0&quot;);</span><br><span=
>             goto err;</span><br><span>         }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        options-&gt;renegotiate_bytes =3D rene=
g_bytes;</span><br><span>     }</span><br><span>     else if (streq(p[0], &=
quot;reneg-pkts&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>  =
   {</span><br><span>         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        char *end;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        long long pkt_max =3D strt=
oll(p[1], &amp;end, 10);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (*end !=3D &#39;\0&#39; || pkt_max &lt; 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (!positive_atoll(p[1], &amp=
;options-&gt;renegotiate_packets, p[0], msglevel))</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msg=
level, &quot;--reneg-pkts parameter must be an integer and &gt;=3D 0&quot;)=
;</span><br><span>             goto err;</span><br><span>         }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;renegotia=
te_packets =3D pkt_max;</span><br><span>     }</span><br><span>     else if=
 (streq(p[0], &quot;reneg-sec&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</spa=
n><br><span>     {</span><br><span>diff --git a/src/openvpn/options_util.c =
b/src/openvpn/options_util.c</span><br><span>index 32a9edb..e930078 100644<=
/span><br><span>--- a/src/openvpn/options_util.c</span><br><span>+++ b/src/=
openvpn/options_util.c</span><br><span>@@ -131,6 +131,22 @@</span><br><span=
>     return (int)i;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+positive_atoll(const char *str, int64_t *value, cons=
t char *name, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
endptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    long lon=
g ll =3D strtoll(str, &amp;endptr, 10);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (ll &lt; 0 || *endptr !=3D &#39;\0&#39;)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(msglevel, &quot;%s: Cannot parse &#39;%s&#39; as=
 non-negative integer&quot;, name, str);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *value=
 =3D (int64_t)ll;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</=
span><br><span> atoi_warn(const char *str, int msglevel)</span><br><span> {=
</span><br><span>diff --git a/src/openvpn/options_util.h b/src/openvpn/opti=
ons_util.h</span><br><span>index b9e1569..5d38eda 100644</span><br><span>--=
- a/src/openvpn/options_util.h</span><br><span>+++ b/src/openvpn/options_ut=
il.h</span><br><span>@@ -41,6 +41,17 @@</span><br><span> </span><br><span> =
/**</span><br><span>  * Converts a str to an integer if the string can be r=
epresented as an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
integer number and is &gt;=3D 0.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * The integer is stored in \p value.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * On error, print a warning with \p msgleve=
l using \p name. \p value is</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * not changed on error.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@return \c true if the integer has been parsed and stored in value, \c fals=
e otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool positive_atoll(cons=
t char *str, int64_t *value, const char *name, int msglevel);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Converts a str to an integer if the string can be represented as =
an</span><br><span>  * integer number. Otherwise print a warning with \p ms=
glevel and return 0</span><br><span>  */</span><br><span> int atoi_warn(con=
st char *str, int msglevel);</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c</span><br><span>=
index 2d2cc9e..ff96644 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_misc.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc.c</s=
pan><br><span>@@ -359,6 +359,17 @@</span><br><span>     assert_true(atoi_co=
nstrained(&quot;-1194&quot;, &amp;parameter, &quot;test&quot;, INT_MIN, INT=
_MAX, msglevel));</span><br><span>     assert_int_equal(parameter, -1194);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int64_t parameter64 =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(positive_atoll(&quot;1234&quot;, &amp;parameter64,=
 &quot;test&quot;, msglevel));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(parameter64, 1234);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(positive_atoll(&quot;0&qu=
ot;, &amp;parameter64, &quot;test&quot;, msglevel));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(parameter64, 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(positiv=
e_atoll(&quot;2147483653&quot;, &amp;parameter64, &quot;test&quot;, msgleve=
l));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(parameter64, 2147483653);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* overflow gets capped to LLONG_MAX */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(positive_atoll(&quot;92=
23372036854775810&quot;, &amp;parameter64, &quot;test&quot;, msglevel));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(p=
arameter64, 9223372036854775807);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     CLEAR(mock_msg_buf);</span><br><span>  =
   assert_int_equal(positive_atoi(&quot;-1234&quot;, msglevel), 0);</span><=
br><span>     assert_string_equal(mock_msg_buf, &quot;Cannot parse argument=
 &#39;-1234&#39; as non-negative integer&quot;);</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
154?usp=3Demail">change 1154</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1154?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I454126b3f8fa9d14501f6c4b1ed=
9ce7b2904be61 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1154 </div>
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


--IAafsZlDdnY=--

