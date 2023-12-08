From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 Dec 2023 16:29:50 +0000
References: <gerrit.1702052980000.Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5273d762fe8bd0e65e019fa603bca948818672d1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="903kLaIUJlI="; charset=UTF-8
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

--903kLaIUJlI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/473?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/473/1

diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index edd566a..e468d3f 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -149,6 +149,29 @@

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--903kLaIUJlI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/473?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">test_user_pass: Add UTs for character filtering<br><br>For si=
mplicity I implemented them only with the<br>inline method, but they actual=
ly apply to all methods.<br><br>Change-Id: Ie8d2d5f6f58679baaf5eb817a7e2ca1=
afcb8c4db<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>-=
--<br>M tests/unit_tests/openvpn/test_user_pass.c<br>1 file changed, 23 ins=
ertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/73/473/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openv=
pn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><=
span>index edd566a..e468d3f 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_user_pass.c</span><br><span>@@ -149,6 +149,29 @@</span><br><span> </span><=
br><span>     reset_user_pass(&amp;up);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Test various valid characters =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: quer=
y_user_exec() called even though nothing queued */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, tru=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* FIXME? co=
ntent after first two lines just ignored */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;#iu=
ser and =EC=BB=A4=EB=AE=A4=EB=8B=88=ED=8B=B0\n//ipassw=C3=B6rd!\nsome other=
 content\nnot relevant&quot;, &quot;UT&quot;, flags, NULL));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(u=
p.username, &quot;#iuser and =EC=BB=A4=EB=AE=A4=EB=8B=88=ED=8B=B0&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equ=
al(up.password, &quot;//ipassw=C3=B6rd!&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Test various invalid characters */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even though not=
hing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
ill_return(query_user_exec_builtin, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /*FIXME? allows arbitrary crap if c &gt; 127 */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME? silentl=
y removes control characters */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;\tiuser\r\nipas=
s\xffwo\x1erd&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.usern=
ame, &quot;iuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(up.password, &quot;ipass\xffword&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     expect_strin=
g(query_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Password:&q=
uot;);</span><br><span>     will_return(query_user_exec_builtin, &quot;cpas=
sword&quot;);</span><br><span>     will_return(query_user_exec_builtin, tru=
e);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/473?usp=3Demail">change 473</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/473?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie8d2d5f6f58679baaf5eb817a7e=
2ca1afcb8c4db </div>
<div style=3D"display:none"> Gerrit-Change-Number: 473 </div>
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


--903kLaIUJlI=--

