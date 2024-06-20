From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 20 Jun 2024 13:34:24 +0000
In-Reply-To: <gerrit.1718814483000.I35f7cf84e035bc793d6f0f59e46edf1a2efe0391@...2715...>
References: <gerrit.1718814483000.I35f7cf84e035bc793d6f0f59e46edf1a2efe0391@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b6c4c38c5c501c97c023362bcdb020fc27176797-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RKd17fzi+GY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: mattock <samuli@...515...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RKd17fzi+GY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/66=
8?usp=3Demail )

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mattock <samuli@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--RKd17fzi+GY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/668?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">t_server_null.sh: Fix failure case<br><br>The =
changes for POSIX shell compatibility and parallel<br>make compatibility br=
oke actually failing the test<br>when a subtest fails.<br><br>Change-Id: I3=
5f7cf84e035bc793d6f0f59e46edf1a2efe0391<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Acked-by: Samuli Sepp=C3=A4nen &lt;samuli@...1696...=
15...&gt;<br>Message-Id: &lt;20240620103749.7923-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg288=
15.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
tests/t_server_null.sh<br>M tests/t_server_null_client.sh<br>2 files change=
d, 4 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh</span><br><=
span>index cfca5ee..0e53ba4 100755</span><br><span>--- a/tests/t_server_nul=
l.sh</span><br><span>+++ b/tests/t_server_null.sh</span><br><span>@@ -64,9 =
+64,12 @@</span><br><span> fi</span><br><span> </span><br><span> &quot;${sr=
cdir}/t_server_null_client.sh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+retval=3D$?</span><br><span> </span><br><span> # When runni=
ng make jobs in parallel (&quot;make -j&lt;x&gt; check&quot;) we need to en=
sure</span><br><span> # that this script does not exit before all --dev nul=
l servers are dead and</span><br><span> # their network interfaces are gone=
. Otherwise t_client.sh will fail because</span><br><span> # pre and post i=
fconfig output does not match.</span><br><span> wait</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+exit $retval</span><br><span>diff --git a/tests/t_server_nul=
l_client.sh b/tests/t_server_null_client.sh</span><br><span>index 5d5542b..=
8890007 100755</span><br><span>--- a/tests/t_server_null_client.sh</span><b=
r><span>+++ b/tests/t_server_null_client.sh</span><br><span>@@ -130,7 +130,=
7 @@</span><br><span>     eval test_name=3D\&quot;\$TEST_NAME_$SUF\&quot;</=
span><br><span>     eval should_pass=3D\&quot;\$SHOULD_PASS_$SUF\&quot;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    (ge=
t_client_test_result &quot;${test_name}&quot; &quot;${should_pass}&quot;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    get_client_test_r=
esult &quot;${test_name}&quot; &quot;${should_pass}&quot;</span><br><span> =
done</span><br><span> </span><br><span> exit $retval</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/668?usp=3Demail">change 668</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/668?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--RKd17fzi+GY=--

