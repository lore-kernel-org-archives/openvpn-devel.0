From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Sep 2024 06:56:31 +0000
In-Reply-To: <gerrit.1718418288000.I41f6c1f7acb58f30fc4db0e32505018f64fcad28@...2715...>
References: <gerrit.1718418288000.I41f6c1f7acb58f30fc4db0e32505018f64fcad28@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ba6029ec108b6a5efde708cd2a7effc53efd8507-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/SF9F06rmwM="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/SF9F06rmwM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/66=
6?usp=3Demail )

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
Gerrit-MessageType: merged

--/SF9F06rmwM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/666?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Add test for static-challenge concatenation op=
tion<br><br>Change-Id: I41f6c1f7acb58f30fc4db0e32505018f64fcad28<br>Signed-=
off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Arne Schwabe &=
lt;arne-openvpn@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>Message-Id: &lt;20240830141824.108599-1-selva.nair@...277...=
&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1223...=
et/msg29054.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
---<br>M tests/unit_tests/openvpn/test_user_pass.c<br>1 file changed, 19 in=
sertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_test=
s/openvpn/test_user_pass.c</span><br><span>index 4dc4b83..620542d 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ -326,=
7 +326,25 @@</span><br><span> </span><br><span>     reset_user_pass(&amp;up=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   flags |=3D GET_USER_PASS_INLINE_CREDS;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS_STATIC_CHALLENGE_CONCAT;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_buil=
tin, query_user[i].prompt, &quot;Enter UT Username:&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_bui=
ltin, &quot;c1user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    expect_string(query_user_exec_builtin, query_user[i].prompt, &qu=
ot;Enter UT Password:&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    will_return(query_user_exec_builtin, &quot;c1password&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(que=
ry_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    expect_string(query_user_exec_builtin, query_user[i].prompt, &=
quot;CHALLENGE: Please enter token PIN&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;0=
123456&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
ill_return(query_user_exec_builtin, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, NULL, &quo=
t;UT&quot;, flags, challenge));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;c1user&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* password =
and response concatenated */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(up.password, &quot;c1password0123456&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    flags =3D GET_USER_PASS_STATIC_CHALLENGE|=
GET_USER_PASS_INLINE_CREDS;</span><br><span> </span><br><span>     /*FIXME:=
 query_user_exec() called even though nothing queued */</span><br><span>   =
  will_return(query_user_exec_builtin, true);</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/666?=
usp=3Demail">change 666</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/666?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--/SF9F06rmwM=--

