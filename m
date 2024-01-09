From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jan 2024 09:42:18 +0000
In-Reply-To: <gerrit.1702052980000.Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db@...2715...>
References: <gerrit.1702052980000.Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7d1d9c46b4a56b136a381433258c914cdc14b193-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4FOO6t3ieu0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: test_user_pass: Add
 UTs for character filtering
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

--4FOO6t3ieu0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/473?usp=3Demail

to look at the new patch set (#5).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: test_user_pass: Add UTs for character filtering
......................................................................

test_user_pass: Add UTs for character filtering

For simplicity I implemented them only with the
inline method, but they actually apply to all methods.

Change-Id: Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 23 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/473/5

diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index ab4dfe4..277cb1d 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -141,6 +141,29 @@

     reset_user_pass(&up);

+    /* Test various valid characters */
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    /* FIXME? content after first two lines just ignored */
+    assert_true(get_user_pass_cr(&up, "#iuser and =EC=BB=A4=EB=AE=A4=EB=8B=
=88=ED=8B=B0\n//ipassw=C3=B6rd!\nsome other content\nnot relevant", "UT", f=
lags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "#iuser and =EC=BB=A4=EB=AE=A4=EB=8B=
=88=ED=8B=B0");
+    assert_string_equal(up.password, "//ipassw=C3=B6rd!");
+
+    reset_user_pass(&up);
+
+    /* Test various invalid characters */
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    /*FIXME? allows arbitrary crap if c > 127 */
+    /*FIXME? silently removes control characters */
+    assert_true(get_user_pass_cr(&up, "\tiuser\r\nipass\xffwo\x1erd", "UT"=
, flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "iuser");
+    assert_string_equal(up.password, "ipass\xffword");
+
+    reset_user_pass(&up);
+
     expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
     will_return(query_user_exec_builtin, "cpassword");
     will_return(query_user_exec_builtin, true);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/473?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db
Gerrit-Change-Number: 473
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--4FOO6t3ieu0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>flichtenheld <strong>uploaded patch set #5</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/473?usp=3Demail">View Ch=
ange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">test_user_pass: Add UTs for character filtering<br><br=
>For simplicity I implemented them only with the<br>inline method, but they=
 actually apply to all methods.<br><br>Change-Id: Ie8d2d5f6f58679baaf5eb817=
a7e2ca1afcb8c4db<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>---<br>M tests/unit_tests/openvpn/test_user_pass.c<br>1 file changed,=
 23 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/73/473/5</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_test=
s/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</spa=
n><br><span>index ab4dfe4..277cb1d 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_user_pass.c</span><br><span>@@ -141,6 +141,29 @@</span><br><span> <=
/span><br><span>     reset_user_pass(&amp;up);</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* Test various valid char=
acters */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXM=
E: query_user_exec() called even though nothing queued */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_built=
in, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* FI=
XME? content after first two lines just ignored */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &q=
uot;#iuser and =EC=BB=A4=EB=AE=A4=EB=8B=88=ED=8B=B0\n//ipassw=C3=B6rd!\nsom=
e other content\nnot relevant&quot;, &quot;UT&quot;, flags, NULL));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(up.username, &quot;#iuser and =EC=BB=A4=EB=AE=A4=EB=8B=88=ED=8B=B0&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_str=
ing_equal(up.password, &quot;//ipassw=C3=B6rd!&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Test various invalid characters */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even tho=
ugh nothing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    will_return(query_user_exec_builtin, true);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /*FIXME? allows arbitrary crap if c &gt; =
127 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME? =
silently removes control characters */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;\tiuser\=
r\nipass\xffwo\x1erd&quot;, &quot;UT&quot;, flags, NULL));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.=
username, &quot;iuser&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_string_equal(up.password, &quot;ipass\xffword&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     expect_=
string(query_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Passwo=
rd:&quot;);</span><br><span>     will_return(query_user_exec_builtin, &quot=
;cpassword&quot;);</span><br><span>     will_return(query_user_exec_builtin=
, true);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/473?usp=3Demail">change 473</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/473?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie8d2d5f6f58679baaf5eb817a7e=
2ca1afcb8c4db </div>
<div style=3D"display:none"> Gerrit-Change-Number: 473 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--4FOO6t3ieu0=--

