From: "selvanair (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 23:41:51 +0000
References: <gerrit.1775000509000.I1c18b3cf4a454444a61941d88a702a140b0ac23d@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f8bf893f8c9effd7115ae7ff86af0473ff865d5e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G0Kc0DsyUTI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add unit tests for
 'auth-user-pass username-only'
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

--G0Kc0DsyUTI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail

to review the following change.


Change subject: Add unit tests for 'auth-user-pass username-only'
......................................................................

Add unit tests for 'auth-user-pass username-only'

Inlined, file and stdin inputs tested.

Change-Id: I1c18b3cf4a454444a61941d88a702a140b0ac23d
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 32 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1602/1

diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index 16e0535..c4082e9 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -222,6 +222,16 @@
     assert_true(up.defined);
     assert_string_equal(up.username, "user");
     assert_string_equal(up.password, "cpassword");
+
+    reset_user_pass(&up);
+
+    flags =3D GET_USER_PASS_INLINE_CREDS | GET_USER_PASS_USERNAME_ONLY;
+    /*FIXME: query_user_exec() needs to be called even though nothing queu=
ed */
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, "iuser\n", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "iuser");
+    assert_string_equal(up.password, "[[BLANK]]");
 }

 /* NOTE: expect_assert_failure does not seem to work with MSVC */
@@ -282,6 +292,17 @@
     assert_true(up.defined);
     assert_string_equal(up.username, "user");
     assert_string_equal(up.password, "");
+
+    reset_user_pass(&up);
+
+    flags =3D GET_USER_PASS_USERNAME_ONLY;
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Username:");
+    will_return(query_user_exec_builtin, "cuser");
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, "stdin", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "cuser");
+    assert_string_equal(up.password, "[[BLANK]]");
 }

 /* NOTE: expect_assert_failure does not seem to work with MSVC */
@@ -353,6 +374,17 @@
     assert_true(up.defined);
     assert_string_equal(up.username, "user");
     assert_string_equal(up.password, "fuser");
+
+    reset_user_pass(&up);
+
+    flags =3D GET_USER_PASS_USERNAME_ONLY;
+    /*FIXME: query_user_exec() needs to be called even though nothing queu=
ed */
+    will_return(query_user_exec_builtin, true);
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/user_only.txt");
+    assert_true(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "fuser");
+    assert_string_equal(up.password, "[[BLANK]]");
 }

 #ifdef ENABLE_MANAGEMENT

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c18b3cf4a454444a61941d88a702a140b0ac23d
Gerrit-Change-Number: 1602
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--G0Kc0DsyUTI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Add unit tests for &#39;auth-user-pass user=
name-only&#39;<br><br>Inlined, file and stdin inputs tested.<br><br>Change-=
Id: I1c18b3cf4a454444a61941d88a702a140b0ac23d<br>Signed-off-by: Selva Nair =
&lt;selva.nair@...277...&gt;<br>---<br>M tests/unit_tests/openvpn/test_user=
_pass.c<br>1 file changed, 32 insertions(+), 0 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02=
/1602/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/te=
sts/unit_tests/openvpn/test_user_pass.c</span><br><span>index 16e0535..c408=
2e9 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.c<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><=
span>@@ -222,6 +222,16 @@</span><br><span>     assert_true(up.defined);</sp=
an><br><span>     assert_string_equal(up.username, &quot;user&quot;);</span=
><br><span>     assert_string_equal(up.password, &quot;cpassword&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    flags =3D GET_USER_PASS_INLINE_CREDS | GET_USE=
R_PASS_USERNAME_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /*FIXME: query_user_exec() needs to be called even though nothing que=
ued */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_retu=
rn(query_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;iuser\n&quot=
;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;iuser&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(up.password, &quot;[[BLANK]]&quot;);</span><br><span> }</span><br>=
<span> </span><br><span> /* NOTE: expect_assert_failure does not seem to wo=
rk with MSVC */</span><br><span>@@ -282,6 +292,17 @@</span><br><span>     a=
ssert_true(up.defined);</span><br><span>     assert_string_equal(up.usernam=
e, &quot;user&quot;);</span><br><span>     assert_string_equal(up.password,=
 &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&am=
p;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    flags =3D GET_USER_PASS_USER=
NAME_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expec=
t_string(query_user_exec_builtin, query_user[i].prompt, &quot;Enter UT User=
name:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wi=
ll_return(query_user_exec_builtin, &quot;cuser&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin,=
 true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(get_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, flags, NUL=
L));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(up.username, &quot;cuser&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;[=
[BLANK]]&quot;);</span><br><span> }</span><br><span> </span><br><span> /* N=
OTE: expect_assert_failure does not seem to work with MSVC */</span><br><sp=
an>@@ -353,6 +374,17 @@</span><br><span>     assert_true(up.defined);</span=
><br><span>     assert_string_equal(up.username, &quot;user&quot;);</span><=
br><span>     assert_string_equal(up.password, &quot;fuser&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    flags =3D GET_USER_PASS_USERNAME_ONLY;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() ne=
eds to be called even though nothing queued */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_test_get=
_srcdir_dir(authfile, PATH_MAX, &quot;input/user_only.txt&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass=
_cr(&amp;up, authfile, &quot;UT&quot;, flags, NULL));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.usern=
ame, &quot;fuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(up.password, &quot;[[BLANK]]&quot;);</span><br=
><span> }</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1602?usp=3Demail">change 1602</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1602?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c18b3cf4a454444a61941d88a7=
02a140b0ac23d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1602 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--G0Kc0DsyUTI=--

