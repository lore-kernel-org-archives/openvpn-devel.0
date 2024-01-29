From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 29 Jan 2024 13:55:24 +0000
In-Reply-To: <gerrit.1702052980000.Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db@...2715...>
References: <gerrit.1702052980000.Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2f7c95aa683c0ea563bf7f0e21b7645037e81803-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k1edvpRiJpA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--k1edvpRiJpA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/473?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2, Code-Review+2 by plaisthos


Change subject: test_user_pass: Add UTs for character filtering
......................................................................

test_user_pass: Add UTs for character filtering

For simplicity I implemented them only with the
inline method, but they actually apply to all methods.

Change-Id: Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240129105358.11161-1-gert@...1296...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20240129105358.11161-1=
-gert@...1296...
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 23 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/473/7

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
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--k1edvpRiJpA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #7</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/473?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2, Code-Review+2 by plaisthos</p><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">test_user_pass: Add UTs =
for character filtering<br><br>For simplicity I implemented them only with =
the<br>inline method, but they actually apply to all methods.<br><br>Change=
-Id: Ie8d2d5f6f58679baaf5eb817a7e2ca1afcb8c4db<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn=
@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Messag=
e-Id: &lt;20240129105358.11161-1-gert@...1296...&gt;<br>URL: https://www.ma=
il-archive.com/search?l=3Dmid&amp;q=3D20240129105358.11161-1-gert@...2132...=
.<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M tests/=
unit_tests/openvpn/test_user_pass.c<br>1 file changed, 23 insertions(+), 0 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/73/473/7</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_user_p=
ass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>index ab4=
dfe4..277cb1d 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_us=
er_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass.c</=
span><br><span>@@ -141,6 +141,29 @@</span><br><span> </span><br><span>     =
reset_user_pass(&amp;up);</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Test various valid characters */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() =
called even though nothing queued */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* FIXME? content after fi=
rst two lines just ignored */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;#iuser and =EC=BB=
=A4=EB=AE=A4=EB=8B=88=ED=8B=B0\n//ipassw=C3=B6rd!\nsome other content\nnot =
relevant&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &q=
uot;#iuser and =EC=BB=A4=EB=AE=A4=EB=8B=88=ED=8B=B0&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password=
, &quot;//ipassw=C3=B6rd!&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Test va=
rious invalid characters */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /*FIXME: query_user_exec() called even though nothing queued */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(que=
ry_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /*FIXME? allows arbitrary crap if c &gt; 127 */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME? silently removes cont=
rol characters */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(get_user_pass_cr(&amp;up, &quot;\tiuser\r\nipass\xffwo\x1erd&=
quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;iuser=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(up.password, &quot;ipass\xffword&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     expect_string(query_user_exe=
c_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br=
><span>     will_return(query_user_exec_builtin, &quot;cpassword&quot;);</s=
pan><br><span>     will_return(query_user_exec_builtin, true);</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/473?usp=3Demail">change 473</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/473?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie8d2d5f6f58679baaf5eb817a7e=
2ca1afcb8c4db </div>
<div style=3D"display:none"> Gerrit-Change-Number: 473 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--k1edvpRiJpA=--

