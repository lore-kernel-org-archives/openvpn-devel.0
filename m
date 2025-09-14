From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 14 Sep 2025 13:26:23 +0000
In-Reply-To: <gerrit.1755877911000.I454126b3f8fa9d14501f6c4b1ed9ce7b2904be61@...2715...>
References: <gerrit.1755877911000.I454126b3f8fa9d14501f6c4b1ed9ce7b2904be61@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <e5bbfa16b5c3c7340bb6973beef94694fb8fdc65-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VDMKZSXyZZA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VDMKZSXyZZA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1154?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


Change subject: options: Factor out usages of strtoll and atoll
......................................................................

options: Factor out usages of strtoll and atoll

This covers the cases where we actually want to
allow numbers > 2^31

Change-Id: I454126b3f8fa9d14501f6c4b1ed9ce7b2904be61
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
URL: https://gerrit.openvpn.net/c/openvpn/+/1154
Message-Id: <20250911201505.25582-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
858.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M tests/unit_tests/openvpn/test_misc.c
4 files changed, 41 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/1154/5

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 18cc1d9..ae285d9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7193,8 +7193,7 @@
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
@@ -9545,26 +9544,18 @@
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
index 28f1f9e..5740ee5 100644
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
index 9eca7b6..45417d9 100644
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
index c3f80dc..93e2460 100644
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
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--VDMKZSXyZZA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1154?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by MaxF</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">options: Factor out usages of strtoll and atoll<br><b=
r>This covers the cases where we actually want to<br>allow numbers &gt; 2^3=
1<br><br>Change-Id: I454126b3f8fa9d14501f6c4b1ed9ce7b2904be61<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: MaxF &lt;max@...220...=
..2606...&gt;<br>URL: https://gerrit.openvpn.net/c/openvpn/+/1154<br>Messag=
e-Id: &lt;20250911201505.25582-1-gert@...1296...&gt;<br>URL: https://www.ma=
il-archive.com/openvpn-devel@lists.sourceforge.net/msg32858.html<br>Signed-=
off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/option=
s.c<br>M src/openvpn/options_util.c<br>M src/openvpn/options_util.h<br>M te=
sts/unit_tests/openvpn/test_misc.c<br>4 files changed, 41 insertions(+), 12=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/54/1154/5</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openvp=
n/options.c</span><br><span>index 18cc1d9..ae285d9 100644</span><br><span>-=
-- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</spa=
n><br><span>@@ -7193,8 +7193,7 @@</span><br><span>         options-&gt;inac=
tivity_timeout =3D positive_atoi(p[1], msglevel);</span><br><span>         =
if (p[2])</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            int64_t val =3D atoll(p[2]);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            options-&gt;inactivity_minimu=
m_bytes =3D (val &lt; 0) ? 0 : val;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            positive_atoll(p[2], &amp;options-&gt;inactivit=
y_minimum_bytes, p[0], msglevel);</span><br><span>             if (options-=
&gt;inactivity_minimum_bytes &gt; INT_MAX)</span><br><span>             {</=
span><br><span>                 msg(M_WARN,</span><br><span>@@ -9545,26 +95=
44,18 @@</span><br><span>     else if (streq(p[0], &quot;reneg-bytes&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span> =
        VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        char *end;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        long long reneg_bytes =3D strtoll(p[1], &amp;end=
, 10);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (*en=
d !=3D &#39;\0&#39; || reneg_bytes &lt; 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!positive_atoll(p[1], &amp;options-&gt;r=
enegotiate_bytes, p[0], msglevel))</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;--r=
eneg-bytes parameter must be an integer and &gt;=3D 0&quot;);</span><br><sp=
an>             goto err;</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;renegotiate_bytes =3D r=
eneg_bytes;</span><br><span>     }</span><br><span>     else if (streq(p[0]=
, &quot;reneg-pkts&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span=
>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        char *end;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        long long pkt_max =3D s=
trtoll(p[1], &amp;end, 10);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (*end !=3D &#39;\0&#39; || pkt_max &lt; 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (!positive_atoll(p[1], &=
amp;options-&gt;renegotiate_packets, p[0], msglevel))</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
msglevel, &quot;--reneg-pkts parameter must be an integer and &gt;=3D 0&quo=
t;);</span><br><span>             goto err;</span><br><span>         }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;renego=
tiate_packets =3D pkt_max;</span><br><span>     }</span><br><span>     else=
 if (streq(p[0], &quot;reneg-sec&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</=
span><br><span>     {</span><br><span>diff --git a/src/openvpn/options_util=
.c b/src/openvpn/options_util.c</span><br><span>index 28f1f9e..5740ee5 1006=
44</span><br><span>--- a/src/openvpn/options_util.c</span><br><span>+++ b/s=
rc/openvpn/options_util.c</span><br><span>@@ -131,6 +131,22 @@</span><br><s=
pan>     return (int)i;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+positive_atoll(const char *str, int64_t *value, c=
onst char *name, int msglevel)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cha=
r *endptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    long =
long ll =3D strtoll(str, &amp;endptr, 10);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (ll &lt; 0 || *endptr !=3D &#39;\0&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(msglevel, &quot;%s: Cannot parse &#39;%s&#3=
9; as non-negative integer&quot;, name, str);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *=
value =3D (int64_t)ll;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
int</span><br><span> atoi_warn(const char *str, int msglevel)</span><br><sp=
an> {</span><br><span>diff --git a/src/openvpn/options_util.h b/src/openvpn=
/options_util.h</span><br><span>index 9eca7b6..45417d9 100644</span><br><sp=
an>--- a/src/openvpn/options_util.h</span><br><span>+++ b/src/openvpn/optio=
ns_util.h</span><br><span>@@ -41,6 +41,17 @@</span><br><span> </span><br><s=
pan> /**</span><br><span>  * Converts a str to an integer if the string can=
 be represented as an</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * integer number and is &gt;=3D 0.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * The integer is stored in \p value.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * On error, print a warning with \p ms=
glevel using \p name. \p value is</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * not changed on error.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return \c true if the integer has been parsed and stored in value, \c=
 false otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool positive_atoll=
(const char *str, int64_t *value, const char *name, int msglevel);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Converts a str to an integer if the string can be represente=
d as an</span><br><span>  * integer number. Otherwise print a warning with =
\p msglevel and return 0</span><br><span>  */</span><br><span> int atoi_war=
n(const char *str, int msglevel);</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c</span><br><=
span>index c3f80dc..93e2460 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_misc.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=
.c</span><br><span>@@ -359,6 +359,17 @@</span><br><span>     assert_true(at=
oi_constrained(&quot;-1194&quot;, &amp;parameter, &quot;test&quot;, INT_MIN=
, INT_MAX, msglevel));</span><br><span>     assert_int_equal(parameter, -11=
94);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int64_t parameter64 =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(positive_atoll(&quot;1234&quot;, &amp;paramet=
er64, &quot;test&quot;, msglevel));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(parameter64, 1234);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(positive_atoll(&quot;0=
&quot;, &amp;parameter64, &quot;test&quot;, msglevel));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(parameter64, 0);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(posit=
ive_atoll(&quot;2147483653&quot;, &amp;parameter64, &quot;test&quot;, msgle=
vel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(parameter64, 2147483653);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* overflow gets capped to LLONG_MAX */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(positive_atoll(&quot;=
9223372036854775810&quot;, &amp;parameter64, &quot;test&quot;, msglevel));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(parameter64, 9223372036854775807);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     CLEAR(mock_msg_buf);</span><br><span>=
     assert_int_equal(positive_atoi(&quot;-1234&quot;, msglevel), 0);</span=
><br><span>     assert_string_equal(mock_msg_buf, &quot;Cannot parse argume=
nt &#39;-1234&#39; as non-negative integer&quot;);</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1154?usp=3Demail">change 1154</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1154?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I454126b3f8fa9d14501f6c4b1ed=
9ce7b2904be61 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1154 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--VDMKZSXyZZA=--

