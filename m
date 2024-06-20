From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 20 Jun 2024 13:34:21 +0000
In-Reply-To: <gerrit.1718814483000.I35f7cf84e035bc793d6f0f59e46edf1a2efe0391@...2715...>
References: <gerrit.1718814483000.I35f7cf84e035bc793d6f0f59e46edf1a2efe0391@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b6c4c38c5c501c97c023362bcdb020fc27176797-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5N/zoUCNCzM="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, mattock <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5N/zoUCNCzM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/668?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by mattock


Change subject: t_server_null.sh: Fix failure case
......................................................................

t_server_null.sh: Fix failure case

The changes for POSIX shell compatibility and parallel
make compatibility broke actually failing the test
when a subtest fails.

Change-Id: I35f7cf84e035bc793d6f0f59e46edf1a2efe0391
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Samuli Sepp=C3=A4nen <samuli@...515...>
Message-Id: <20240620103749.7923-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
815.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_server_null.sh
M tests/t_server_null_client.sh
2 files changed, 4 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/668/2

diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index cfca5ee..0e53ba4 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -64,9 +64,12 @@
 fi
=20
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mattock <samuli@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--5N/zoUCNCzM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/668?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by mattock</p><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">t_server_null.sh: Fix failure case<br><br>The chan=
ges for POSIX shell compatibility and parallel<br>make compatibility broke =
actually failing the test<br>when a subtest fails.<br><br>Change-Id: I35f7c=
f84e035bc793d6f0f59e46edf1a2efe0391<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>Acked-by: Samuli Sepp=C3=A4nen &lt;samuli@...1699...=
.&gt;<br>Message-Id: &lt;20240620103749.7923-1-gert@...1296...&gt;<br>URL: =
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28815.h=
tml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M test=
s/t_server_null.sh<br>M tests/t_server_null_client.sh<br>2 files changed, 4=
 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/68/668/2</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/tests/t_server_null=
.sh b/tests/t_server_null.sh</span><br><span>index cfca5ee..0e53ba4 100755<=
/span><br><span>--- a/tests/t_server_null.sh</span><br><span>+++ b/tests/t_=
server_null.sh</span><br><span>@@ -64,9 +64,12 @@</span><br><span> fi</span=
><br><span> </span><br><span> &quot;${srcdir}/t_server_null_client.sh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+retval=3D$?</span><=
br><span> </span><br><span> # When running make jobs in parallel (&quot;mak=
e -j&lt;x&gt; check&quot;) we need to ensure</span><br><span> # that this s=
cript does not exit before all --dev null servers are dead and</span><br><s=
pan> # their network interfaces are gone. Otherwise t_client.sh will fail b=
ecause</span><br><span> # pre and post ifconfig output does not match.</spa=
n><br><span> wait</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+exit $retval</span><b=
r><span>diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_cl=
ient.sh</span><br><span>index 5d5542b..8890007 100755</span><br><span>--- a=
/tests/t_server_null_client.sh</span><br><span>+++ b/tests/t_server_null_cl=
ient.sh</span><br><span>@@ -130,7 +130,7 @@</span><br><span>     eval test_=
name=3D\&quot;\$TEST_NAME_$SUF\&quot;</span><br><span>     eval should_pass=
=3D\&quot;\$SHOULD_PASS_$SUF\&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    (get_client_test_result &quot;${test_na=
me}&quot; &quot;${should_pass}&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    get_client_test_result &quot;${test_name}&quot; &quot=
;${should_pass}&quot;</span><br><span> done</span><br><span> </span><br><sp=
an> exit $retval</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/668?usp=3Demail">change 668</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/668?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I35f7cf84e035bc793d6f0f59e46=
edf1a2efe0391 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 668 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mattock &lt;samuli@...515...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--5N/zoUCNCzM=--

