From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 15 Apr 2026 09:52:42 +0000
In-Reply-To: <gerrit.1775000509000.I1c18b3cf4a454444a61941d88a702a140b0ac23d@...2715...>
References: <gerrit.1775000509000.I1c18b3cf4a454444a61941d88a702a140b0ac23d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9f85736e3379c945a268272fa8c25e5771aa4198-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DQ4R47yUl3A="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DQ4R47yUl3A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
02?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c18b3cf4a454444a61941d88a702a140b0ac23d
Gerrit-Change-Number: 1602
Gerrit-PatchSet: 3
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DQ4R47yUl3A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1602?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Add unit tests for &#39;auth-user-pass username-=
only&#39;<br><br>Input from stdin is tested.<br><br>Change-Id: I1c18b3cf4a4=
54444a61941d88a702a140b0ac23d<br>Signed-off-by: Selva Nair &lt;selva.nair@...220...=
..277...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>G=
errit URL: https://gerrit.openvpn.net/c/openvpn/+/1602<br>Message-Id: &lt;2=
0260414055805.16974-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg36605.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test=
_user_pass.c<br>1 file changed, 11 insertions(+), 0 deletions(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_test=
s/openvpn/test_user_pass.c</span><br><span>index 16e0535..c0a0866 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ -282,=
6 +282,17 @@</span><br><span>     assert_true(up.defined);</span><br><span>=
     assert_string_equal(up.username, &quot;user&quot;);</span><br><span>  =
   assert_string_equal(up.password, &quot;&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    flags =3D GET_USER_PASS_USERNAME_ONLY;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_=
user[i].prompt, &quot;Enter UT Username:&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot=
;cuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
ill_return(query_user_exec_builtin, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;stdi=
n&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;cus=
er&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_string_equal(up.password, &quot;[[BLANK]]&quot;);</span><br><span> }</spa=
n><br><span> </span><br><span> /* NOTE: expect_assert_failure does not seem=
 to work with MSVC */</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail">change 160=
2</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--DQ4R47yUl3A=--

