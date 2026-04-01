From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 1 Apr 2026 11:59:38 +0000
In-Reply-To: <gerrit.1775000509000.I1c18b3cf4a454444a61941d88a702a140b0ac23d@...2715...>
References: <gerrit.1775000509000.I1c18b3cf4a454444a61941d88a702a140b0ac23d@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e7a16aabe282b6794df6e010bf565f8a9e8349ee-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sKCwfyZeFIw="; charset=UTF-8
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

--sKCwfyZeFIw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail

to look at the new patch set (#2).


Change subject: Add unit tests for 'auth-user-pass username-only'
......................................................................

Add unit tests for 'auth-user-pass username-only'

Input from stdin is tested.

Change-Id: I1c18b3cf4a454444a61941d88a702a140b0ac23d
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 11 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1602/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--sKCwfyZeFIw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Add unit tests for &#39;auth-user-pass username-onl=
y&#39;<br><br>Input from stdin is tested.<br><br>Change-Id: I1c18b3cf4a4544=
44a61941d88a702a140b0ac23d<br>Signed-off-by: Selva Nair &lt;selva.nair@...1665...=
77...&gt;<br>---<br>M tests/unit_tests/openvpn/test_user_pass.c<br>1 file c=
hanged, 11 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1602/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/open=
vpn/test_user_pass.c</span><br><span>index 16e0535..c0a0866 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ -282,6 +282=
,17 @@</span><br><span>     assert_true(up.defined);</span><br><span>     a=
ssert_string_equal(up.username, &quot;user&quot;);</span><br><span>     ass=
ert_string_equal(up.password, &quot;&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 flags =3D GET_USER_PASS_USERNAME_ONLY;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_user[i=
].prompt, &quot;Enter UT Username:&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;cuser=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_re=
turn(query_user_exec_builtin, true);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;stdin&quot=
;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;cuser&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(up.password, &quot;[[BLANK]]&quot;);</span><br><span> }</span><br>=
<span> </span><br><span> /* NOTE: expect_assert_failure does not seem to wo=
rk with MSVC */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail">change 1602</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c18b3cf4a454444a61941d88a7=
02a140b0ac23d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1602 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--sKCwfyZeFIw=--

