From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 19 Jun 2024 16:28:04 +0000
References: <gerrit.1718814483000.I35f7cf84e035bc793d6f0f59e46edf1a2efe0391@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6bd4026e966b54c38e0a5c2cc960caa65ffdb9e6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pxqE3PPVYBY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_server_null.sh:
 Fix failure case
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

--pxqE3PPVYBY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/668?usp=3Demail

to review the following change.


Change subject: t_server_null.sh: Fix failure case
......................................................................

t_server_null.sh: Fix failure case

The changes for POSIX shell compatibility and parallel
make compatibility broke actually failing the test
when a subtest fails.

Change-Id: I35f7cf84e035bc793d6f0f59e46edf1a2efe0391
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/t_server_null.sh
M tests/t_server_null_client.sh
2 files changed, 4 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/668/1

diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index cfca5ee..0e53ba4 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -64,9 +64,12 @@
 fi

 "${srcdir}/t_server_null_client.sh"
+retval=3D$?

 # When running make jobs in parallel ("make -j<x> check") we need to ensure
 # that this script does not exit before all --dev null servers are dead and
 # their network interfaces are gone. Otherwise t_client.sh will fail becau=
se
 # pre and post ifconfig output does not match.
 wait
+
+exit $retval
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index 5d5542b..8890007 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -130,7 +130,7 @@
     eval test_name=3D\"\$TEST_NAME_$SUF\"
     eval should_pass=3D\"\$SHOULD_PASS_$SUF\"

-    (get_client_test_result "${test_name}" "${should_pass}")
+    get_client_test_result "${test_name}" "${should_pass}"
 done

 exit $retval

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/668?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I35f7cf84e035bc793d6f0f59e46edf1a2efe0391
Gerrit-Change-Number: 668
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--pxqE3PPVYBY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/668?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">t_server_null.sh: Fix failure case<br><br>The changes for POS=
IX shell compatibility and parallel<br>make compatibility broke actually fa=
iling the test<br>when a subtest fails.<br><br>Change-Id: I35f7cf84e035bc79=
3d6f0f59e46edf1a2efe0391<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1665...=
641...&gt;<br>---<br>M tests/t_server_null.sh<br>M tests/t_server_null_clie=
nt.sh<br>2 files changed, 4 insertions(+), 1 deletion(-)<br><br></pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/668/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/tests/t_server_null.sh b/tests/t_server_null.sh</span><br><span>ind=
ex cfca5ee..0e53ba4 100755</span><br><span>--- a/tests/t_server_null.sh</sp=
an><br><span>+++ b/tests/t_server_null.sh</span><br><span>@@ -64,9 +64,12 @=
@</span><br><span> fi</span><br><span> </span><br><span> &quot;${srcdir}/t_=
server_null_client.sh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+retval=3D$?</span><br><span> </span><br><span> # When running make =
jobs in parallel (&quot;make -j&lt;x&gt; check&quot;) we need to ensure</sp=
an><br><span> # that this script does not exit before all --dev null server=
s are dead and</span><br><span> # their network interfaces are gone. Otherw=
ise t_client.sh will fail because</span><br><span> # pre and post ifconfig =
output does not match.</span><br><span> wait</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+exit $retval</span><br><span>diff --git a/tests/t_server_null_client.=
sh b/tests/t_server_null_client.sh</span><br><span>index 5d5542b..8890007 1=
00755</span><br><span>--- a/tests/t_server_null_client.sh</span><br><span>+=
++ b/tests/t_server_null_client.sh</span><br><span>@@ -130,7 +130,7 @@</spa=
n><br><span>     eval test_name=3D\&quot;\$TEST_NAME_$SUF\&quot;</span><br>=
<span>     eval should_pass=3D\&quot;\$SHOULD_PASS_$SUF\&quot;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (get_client_=
test_result &quot;${test_name}&quot; &quot;${should_pass}&quot;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    get_client_test_result &qu=
ot;${test_name}&quot; &quot;${should_pass}&quot;</span><br><span> done</spa=
n><br><span> </span><br><span> exit $retval</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/668?us=
p=3Demail">change 668</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/668?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I35f7cf84e035bc793d6f0f59e46=
edf1a2efe0391 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 668 </div>
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


--pxqE3PPVYBY=--

