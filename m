From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 15 Apr 2026 09:52:38 +0000
In-Reply-To: <gerrit.1775000509000.I1c18b3cf4a454444a61941d88a702a140b0ac23d@...2715...>
References: <gerrit.1775000509000.I1c18b3cf4a454444a61941d88a702a140b0ac23d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9f85736e3379c945a268272fa8c25e5771aa4198-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4kNjO4s5Xdg="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4kNjO4s5Xdg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Add unit tests for 'auth-user-pass username-only'
......................................................................

Add unit tests for 'auth-user-pass username-only'

Input from stdin is tested.

Change-Id: I1c18b3cf4a454444a61941d88a702a140b0ac23d
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1602
Message-Id: <20260414055805.16974-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
605.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 11 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1602/3

diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index 16e0535..c0a0866 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -282,6 +282,17 @@
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c18b3cf4a454444a61941d88a702a140b0ac23d
Gerrit-Change-Number: 1602
Gerrit-PatchSet: 3
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4kNjO4s5Xdg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Add unit tests for &#39;auth-us=
er-pass username-only&#39;<br><br>Input from stdin is tested.<br><br>Change=
-Id: I1c18b3cf4a454444a61941d88a702a140b0ac23d<br>Signed-off-by: Selva Nair=
 &lt;selva.nair@...277...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1186...=
.1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1602<br>=
Message-Id: &lt;20260414055805.16974-1-gert@...1296...&gt;<br>URL: https://=
www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36605.html<br>S=
igned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M tests/unit_t=
ests/openvpn/test_user_pass.c<br>1 file changed, 11 insertions(+), 0 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/02/1602/3</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn=
/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><sp=
an>index 16e0535..c0a0866 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_u=
ser_pass.c</span><br><span>@@ -282,6 +282,17 @@</span><br><span>     assert=
_true(up.defined);</span><br><span>     assert_string_equal(up.username, &q=
uot;user&quot;);</span><br><span>     assert_string_equal(up.password, &quo=
t;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    flags =3D GET_USER_PASS_USERNAME_=
ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_str=
ing(query_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Username:=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_re=
turn(query_user_exec_builtin, &quot;cuser&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(g=
et_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, flags, NULL));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.d=
efined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(up.username, &quot;cuser&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;[[BLAN=
K]]&quot;);</span><br><span> }</span><br><span> </span><br><span> /* NOTE: =
expect_assert_failure does not seem to work with MSVC */</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1602?usp=3Demail">change 1602</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1602?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c18b3cf4a454444a61941d88a7=
02a140b0ac23d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1602 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--4kNjO4s5Xdg=--

