From: "selvanair (Code Review)" <gerrit@...515...>
Date: Sat, 15 Jun 2024 02:24:53 +0000
References: <gerrit.1718418288000.I41f6c1f7acb58f30fc4db0e32505018f64fcad28@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <485c814b727094012dc7fd722f2548456c331221-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NDGHIRQ6Zkk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add test for
 static-challenge concatenation option
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

--NDGHIRQ6Zkk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/666?usp=3Demail

to review the following change.


Change subject: Add test for static-challenge concatenation option
......................................................................

Add test for static-challenge concatenation option

Change-Id: I41f6c1f7acb58f30fc4db0e32505018f64fcad28
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 19 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/666/1

diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index b43e655..35fe60d 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -311,7 +311,25 @@

     reset_user_pass(&up);

-    flags |=3D GET_USER_PASS_INLINE_CREDS;
+    flags |=3D GET_USER_PASS_STATIC_CHALLENGE_CONCAT;
+
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Username:");
+    will_return(query_user_exec_builtin, "c1user");
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
+    will_return(query_user_exec_builtin, "c1password");
+    will_return(query_user_exec_builtin, true);
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "CHALLENG=
E: Please enter token PIN");
+    will_return(query_user_exec_builtin, "0123456");
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, NULL, "UT", flags, challenge));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "c1user");
+    /* password and response concatenated */
+    assert_string_equal(up.password, "c1password0123456");
+
+    reset_user_pass(&up);
+
+    flags =3D GET_USER_PASS_STATIC_CHALLENGE|GET_USER_PASS_INLINE_CREDS;

     /*FIXME: query_user_exec() called even though nothing queued */
     will_return(query_user_exec_builtin, true);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/666?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I41f6c1f7acb58f30fc4db0e32505018f64fcad28
Gerrit-Change-Number: 666
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--NDGHIRQ6Zkk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/666?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add test for static-challenge concatenation option<br><br>Cha=
nge-Id: I41f6c1f7acb58f30fc4db0e32505018f64fcad28<br>---<br>M tests/unit_te=
sts/openvpn/test_user_pass.c<br>1 file changed, 19 insertions(+), 1 deletio=
n(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/66/666/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/=
tests/unit_tests/openvpn/test_user_pass.c</span><br><span>index b43e655..35=
fe60d 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br=
><span>@@ -311,7 +311,25 @@</span><br><span> </span><br><span>     reset_us=
er_pass(&amp;up);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    flags |=3D GET_USER_PASS_INLINE_CREDS;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS_STATIC_CH=
ALLENGE_CONCAT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(query=
_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Username:&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(quer=
y_user_exec_builtin, &quot;c1user&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_user=
[i].prompt, &quot;Enter UT Password:&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;c1p=
assword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
will_return(query_user_exec_builtin, true);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_us=
er[i].prompt, &quot;CHALLENGE: Please enter token PIN&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_b=
uiltin, &quot;0123456&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    will_return(query_user_exec_builtin, true);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp=
;up, NULL, &quot;UT&quot;, flags, challenge));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &q=
uot;c1user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* password and response concatenated */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;c1passwo=
rd0123456&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&=
amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    flags =3D GET_USER_PASS_ST=
ATIC_CHALLENGE|GET_USER_PASS_INLINE_CREDS;</span><br><span> </span><br><spa=
n>     /*FIXME: query_user_exec() called even though nothing queued */</spa=
n><br><span>     will_return(query_user_exec_builtin, true);</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/666?usp=3Demail">change 666</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/666?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41f6c1f7acb58f30fc4db0e3250=
5018f64fcad28 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 666 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--NDGHIRQ6Zkk=--

