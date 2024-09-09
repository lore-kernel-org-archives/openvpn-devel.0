From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Sep 2024 06:56:26 +0000
In-Reply-To: <gerrit.1718418288000.I41f6c1f7acb58f30fc4db0e32505018f64fcad28@...2715...>
References: <gerrit.1718418288000.I41f6c1f7acb58f30fc4db0e32505018f64fcad28@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ba6029ec108b6a5efde708cd2a7effc53efd8507-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sasTYX9IygM="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sasTYX9IygM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/666?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review+2 by plaisthos


Change subject: Add test for static-challenge concatenation option
......................................................................

Add test for static-challenge concatenation option

Change-Id: I41f6c1f7acb58f30fc4db0e32505018f64fcad28
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240830141824.108599-1-selva.nair@...277...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
054.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 19 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/666/2

diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index 4dc4b83..620542d 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -326,7 +326,25 @@

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
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--sasTYX9IygM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by selvanair.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
666?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld, Code-Review+2 by plaisthos</p><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">Add test for stat=
ic-challenge concatenation option<br><br>Change-Id: I41f6c1f7acb58f30fc4db0=
e32505018f64fcad28<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt=
;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Fr=
ank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240830141824.=
108599-1-selva.nair@...277...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg29054.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_user_pa=
ss.c<br>1 file changed, 19 insertions(+), 1 deletion(-)<br><br></pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/666/2</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn=
/test_user_pass.c</span><br><span>index 4dc4b83..620542d 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ -326,7 +326,25=
 @@</span><br><span> </span><br><span>     reset_user_pass(&amp;up);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    flags =
|=3D GET_USER_PASS_INLINE_CREDS;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    flags |=3D GET_USER_PASS_STATIC_CHALLENGE_CONCAT;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, quer=
y_user[i].prompt, &quot;Enter UT Username:&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &qu=
ot;c1user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;Enter =
UT Password:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    will_return(query_user_exec_builtin, &quot;c1password&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_e=
xec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;CHAL=
LENGE: Please enter token PIN&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;0123456&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_retur=
n(query_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, NULL, &quot;UT&quot=
;, flags, challenge));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(up.defined);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_string_equal(up.username, &quot;c1user&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* password and respo=
nse concatenated */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(up.password, &quot;c1password0123456&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    flags =3D GET_USER_PASS_STATIC_CHALLENGE|GET_USER_=
PASS_INLINE_CREDS;</span><br><span> </span><br><span>     /*FIXME: query_us=
er_exec() called even though nothing queued */</span><br><span>     will_re=
turn(query_user_exec_builtin, true);</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/666?usp=3Dema=
il">change 666</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/666?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41f6c1f7acb58f30fc4db0e3250=
5018f64fcad28 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 666 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--sasTYX9IygM=--

