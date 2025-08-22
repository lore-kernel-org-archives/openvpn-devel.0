From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 22 Aug 2025 13:45:25 +0000
References: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a5ff4909624c8e6569d174e924f46874a4f9c9b4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E51vmMfb/LM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: Introduce
 boolean_flag() and review usages of atoi_warn
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

--E51vmMfb/LM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1151?usp=3Demail

to review the following change.


Change subject: options: Introduce boolean_flag() and review usages of atoi=
_warn
......................................................................

options: Introduce boolean_flag() and review usages of atoi_warn

This uses atoi_constrained. Note that this makes the tests
stricter since previously any non-zero integer would be
interpreted as "true".

Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M tests/unit_tests/openvpn/test_misc.c
4 files changed, 38 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/1151/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b62e22c..46f4753 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8358,7 +8358,7 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sc_info.challenge_text =3D p[1];
-        if (atoi_warn(p[2], msglevel))
+        if (boolean_flag(p[2], "static-challenge echo", msglevel))
         {
             options->sc_info.flags |=3D SC_ECHO;
         }
@@ -8721,7 +8721,7 @@
         options->exit_event_name =3D p[1];
         if (p[2])
         {
-            options->exit_event_initial_state =3D (atoi_warn(p[2], msgleve=
l) !=3D 0);
+            options->exit_event_initial_state =3D boolean_flag(p[2], "serv=
ice state", msglevel);
         }
     }
     else if (streq(p[0], "allow-nonadmin") && !p[2])
@@ -9682,7 +9682,8 @@
     else if (streq(p[0], "show-pkcs11-ids") && !p[3])
     {
         char *provider =3D p[1];
-        bool cert_private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[2],=
 msglevel) !=3D 0));
+        bool cert_private =3D (p[2] =3D=3D NULL ? false
+                                          : boolean_flag(p[2], "show-pkcs1=
1-ids private", msglevel));

 #ifdef DEFAULT_PKCS11_MODULE
         if (!provider)
@@ -9728,14 +9729,12 @@
     }
     else if (streq(p[0], "pkcs11-protected-authentication"))
     {
-        int j;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);

-        for (j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
+        for (int j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
         {
             options->pkcs11_protected_authentication[j - 1] =3D
-                atoi_warn(p[j], msglevel) !=3D 0 ? 1 : 0;
+                boolean_flag(p[j], p[0], msglevel);
         }
     }
     else if (streq(p[0], "pkcs11-private-mode") && p[1])
@@ -9751,13 +9750,11 @@
     }
     else if (streq(p[0], "pkcs11-cert-private"))
     {
-        int j;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);

-        for (j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
+        for (int j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
         {
-            options->pkcs11_cert_private[j - 1] =3D (bool)(atoi_warn(p[j],=
 msglevel));
+            options->pkcs11_cert_private[j - 1] =3D boolean_flag(p[j], p[0=
], msglevel);
         }
     }
     else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index c1f7c74..32a9edb 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -181,6 +181,14 @@
     return true;
 }

+bool
+boolean_flag(const char *str, const char *name, int msglevel)
+{
+    int number =3D 0;
+    atoi_constrained(str, &number, name, 0, 1, msglevel);
+    return (bool)number;
+}
+
 static const char *updatable_options[] =3D { "block-ipv6", "block-outside-=
dns",
                                            "dhcp-option", "dns",
                                            "ifconfig", "ifconfig-ipv6",
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index d5ae8b9..b9e1569 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -59,6 +59,12 @@
                       int msglevel);

 /**
+ * Converts a str to an boolean if the string can be parsed as either 0 or=
 1.
+ * Otherwise print a warning with \p msglevel and return \c false.
+ */
+bool boolean_flag(const char *str, const char *name, int msglevel);
+
+/**
  * Filter an option line by all pull filters.
  *
  * If a match is found, the line is modified depending on
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 80a5dee..2d2cc9e 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -431,6 +431,22 @@
     assert_string_equal(mock_msg_buf, "test: Must be an integer >=3D 1, no=
t 0");
     assert_int_equal(parameter, -42);

+    /* special tests for boolean_flag */
+    assert_false(boolean_flag("0", "test", msglevel));
+    assert_true(boolean_flag("1", "test", msglevel));
+
+    CLEAR(mock_msg_buf);
+    assert_false(boolean_flag("foo77", "test", msglevel));
+    assert_string_equal(mock_msg_buf, "test: Cannot parse 'foo77' as integ=
er");
+
+    CLEAR(mock_msg_buf);
+    assert_false(boolean_flag("-77", "test", msglevel));
+    assert_string_equal(mock_msg_buf, "test: Must be an integer between 0 =
and 1, not -77");
+
+    CLEAR(mock_msg_buf);
+    assert_false(boolean_flag("77", "test", msglevel));
+    assert_string_equal(mock_msg_buf, "test: Must be an integer between 0 =
and 1, not 77");
+
     mock_set_debug_level(saved_log_level);
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1151?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
Gerrit-Change-Number: 1151
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--E51vmMfb/LM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1151?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">options: Introduce boolean_flag() and review usages of atoi_=
warn<br><br>This uses atoi_constrained. Note that this makes the tests<br>s=
tricter since previously any non-zero integer would be<br>interpreted as &q=
uot;true&quot;.<br><br>Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M s=
rc/openvpn/options.c<br>M src/openvpn/options_util.c<br>M src/openvpn/optio=
ns_util.h<br>M tests/unit_tests/openvpn/test_misc.c<br>4 files changed, 38 =
insertions(+), 11 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/51/1151/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/optio=
ns.c b/src/openvpn/options.c</span><br><span>index b62e22c..46f4753 100644<=
/span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openv=
pn/options.c</span><br><span>@@ -8358,7 +8358,7 @@</span><br><span>     {</=
span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span> =
        options-&gt;sc_info.challenge_text =3D p[1];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (atoi_warn(p[2], msglevel))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (boolean_flag=
(p[2], &quot;static-challenge echo&quot;, msglevel))</span><br><span>      =
   {</span><br><span>             options-&gt;sc_info.flags |=3D SC_ECHO;</=
span><br><span>         }</span><br><span>@@ -8721,7 +8721,7 @@</span><br><=
span>         options-&gt;exit_event_name =3D p[1];</span><br><span>       =
  if (p[2])</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            options-&gt;exit_event_initial_state =3D (atoi=
_warn(p[2], msglevel) !=3D 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            options-&gt;exit_event_initial_state =3D boolean_fla=
g(p[2], &quot;service state&quot;, msglevel);</span><br><span>         }</s=
pan><br><span>     }</span><br><span>     else if (streq(p[0], &quot;allow-=
nonadmin&quot;) &amp;&amp; !p[2])</span><br><span>@@ -9682,7 +9682,8 @@</sp=
an><br><span>     else if (streq(p[0], &quot;show-pkcs11-ids&quot;) &amp;&a=
mp; !p[3])</span><br><span>     {</span><br><span>         char *provider =
=3D p[1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bool=
 cert_private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[2], msglevel) !=
=3D 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        boo=
l cert_private =3D (p[2] =3D=3D NULL ? false</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                          : boolea=
n_flag(p[2], &quot;show-pkcs11-ids private&quot;, msglevel));</span><br><sp=
an> </span><br><span> #ifdef DEFAULT_PKCS11_MODULE</span><br><span>        =
 if (!provider)</span><br><span>@@ -9728,14 +9729,12 @@</span><br><span>   =
  }</span><br><span>     else if (streq(p[0], &quot;pkcs11-protected-authen=
tication&quot;))</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        int j;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
for (j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j] !=3D NULL; ++j)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        for (int j =3D 1; j &lt;=
 MAX_PARMS &amp;&amp; p[j] !=3D NULL; ++j)</span><br><span>         {</span=
><br><span>             options-&gt;pkcs11_protected_authentication[j - 1] =
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                at=
oi_warn(p[j], msglevel) !=3D 0 ? 1 : 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                boolean_flag(p[j], p[0], msglevel);</sp=
an><br><span>         }</span><br><span>     }</span><br><span>     else if=
 (streq(p[0], &quot;pkcs11-private-mode&quot;) &amp;&amp; p[1])</span><br><=
span>@@ -9751,13 +9750,11 @@</span><br><span>     }</span><br><span>     el=
se if (streq(p[0], &quot;pkcs11-cert-private&quot;))</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int j;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_GENERAL);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        for (j =3D 1; j &lt; MAX_PARMS &amp;&am=
p; p[j] !=3D NULL; ++j)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        for (int j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j] !=3D NULL; +=
+j)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            options-&gt;pkcs11_cert_private[j - 1] =3D (bool)(atoi=
_warn(p[j], msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            options-&gt;pkcs11_cert_private[j - 1] =3D boolean_flag(p[j=
], p[0], msglevel);</span><br><span>         }</span><br><span>     }</span=
><br><span>     else if (streq(p[0], &quot;pkcs11-pin-cache&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[2])</span><br><span>diff --git a/src/openvpn/options_=
util.c b/src/openvpn/options_util.c</span><br><span>index c1f7c74..32a9edb =
100644</span><br><span>--- a/src/openvpn/options_util.c</span><br><span>+++=
 b/src/openvpn/options_util.c</span><br><span>@@ -181,6 +181,14 @@</span><b=
r><span>     return true;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+boolean_flag(const char *str, const char *name,=
 int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int number =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    atoi_constrained(=
str, &amp;number, name, 0, 1, msglevel);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return (bool)number;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> static const char *updatable_options[] =3D { &quo=
t;block-ipv6&quot;, &quot;block-outside-dns&quot;,</span><br><span>        =
                                    &quot;dhcp-option&quot;, &quot;dns&quot=
;,</span><br><span>                                            &quot;ifconf=
ig&quot;, &quot;ifconfig-ipv6&quot;,</span><br><span>diff --git a/src/openv=
pn/options_util.h b/src/openvpn/options_util.h</span><br><span>index d5ae8b=
9..b9e1569 100644</span><br><span>--- a/src/openvpn/options_util.h</span><b=
r><span>+++ b/src/openvpn/options_util.h</span><br><span>@@ -59,6 +59,12 @@=
</span><br><span>                       int msglevel);</span><br><span> </s=
pan><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Converts a str to an boolean if the string can be parsed as either 0 or 1=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Otherwise print=
 a warning with \p msglevel and return \c false.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool boolean_flag(const char *str, const char *name, int msgle=
vel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Filter an=
 option line by all pull filters.</span><br><span>  *</span><br><span>  * I=
f a match is found, the line is modified depending on</span><br><span>diff =
--git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/tes=
t_misc.c</span><br><span>index 80a5dee..2d2cc9e 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/unit_tes=
ts/openvpn/test_misc.c</span><br><span>@@ -431,6 +431,22 @@</span><br><span=
>     assert_string_equal(mock_msg_buf, &quot;test: Must be an integer &gt;=
=3D 1, not 0&quot;);</span><br><span>     assert_int_equal(parameter, -42);=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* special tests for boolean_flag */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_false(boolean_flag(&quot;0&quot;, &quot;test=
&quot;, msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(boolean_flag(&quot;1&quot;, &quot;test&quot;, msglevel));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_false(boolean_flag(&quot=
;foo77&quot;, &quot;test&quot;, msglevel));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;test: C=
annot parse &#39;foo77&#39; as integer&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(boolean_flag(&quot;-77&quot;, &quot;test&quot=
;, msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(mock_msg_buf, &quot;test: Must be an integer between 0 a=
nd 1, not -77&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_ms=
g_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_f=
alse(boolean_flag(&quot;77&quot;, &quot;test&quot;, msglevel));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_ms=
g_buf, &quot;test: Must be an integer between 0 and 1, not 77&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     moc=
k_set_debug_level(saved_log_level);</span><br><span> }</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1151?usp=3Demail">change 1151</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1151?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic30612971367a4aa54ca89f9345=
2efc172d4f4e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1151 </div>
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


--E51vmMfb/LM=--

