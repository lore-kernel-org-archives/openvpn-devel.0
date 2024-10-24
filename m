From: "mattock (Code Review)" <gerrit@...515...>
Date: Thu, 24 Oct 2024 07:31:33 +0000
In-Reply-To: <gerrit.1728021778000.I49f1e7d25edb62bf202ffceb45dedc213f2eafdd@...2715...>
References: <gerrit.1728021778000.I49f1e7d25edb62bf202ffceb45dedc213f2eafdd@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <2da17fa99206616e54a920726df60ef4a0b64395-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0AwzR5FEMg8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_server_null:
 persist test log files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0AwzR5FEMg8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, mattock, plaisth=
os.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: t_server_null: persist test log files
......................................................................

t_server_null: persist test log files

The goal is to help debug issues with t_server_null. The immediate goal
is to be able to debug server startup issues encountered on some of the
*BSD platforms.

Change-Id: I49f1e7d25edb62bf202ffceb45dedc213f2eafdd
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M tests/t_server_null.sh
M tests/t_server_null_client.sh
M tests/t_server_null_server.sh
3 files changed, 8 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/776/2

diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index 7627edf..61a9cdc 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -56,11 +56,16 @@
 fi

 srcdir=3D"${srcdir:-.}"
+export t_server_null_logdir=3Dt_server_null-`hostname`-`date +%Y%m%d-%H%M%=
S`
+
+# Create directory for server and client logs
+mkdir $t_server_null_logdir

 "${srcdir}/t_server_null_server.sh" &
 "${srcdir}/t_server_null_client.sh"
 retval=3D$?

+
 # When running make jobs in parallel ("make -j<x> check") we need to ensure
 # that this script does not exit before all --dev null servers are dead and
 # their network interfaces are gone. Otherwise t_client.sh will fail becau=
se
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index c1a25df..846f790 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -14,7 +14,7 @@
         $client_conf \
         --writepid "${pid}" \
         --setenv pid $pid \
-        --log "${log}" &
+        --log "${t_server_null_logdir}/${log}" &
 }

 wait_for_results() {
@@ -44,7 +44,7 @@
     should_pass=3D$2
     log=3D"${test_name}.log"

-    grep "Initialization Sequence Completed" "${log}" > /dev/null
+    grep "Initialization Sequence Completed" "${t_server_null_logdir}/${lo=
g}" > /dev/null
     exit_code=3D$?

     if [ $exit_code -eq 0 ] && [ "${should_pass}" =3D "yes" ]; then
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index 10bb44b..f8ba3a3 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -4,12 +4,11 @@
     server_name=3D$1
     server_exec=3D$2
     server_conf=3D$3
-    log=3D"${server_name}.log"
+    log=3D"${t_server_null_logdir}/${server_name}.log"
     status=3D"${server_name}.status"
     pid=3D"${server_name}.pid"

     if [ -z "${RUN_SUDO}" ]; then
-        rm -f "${status}" "${log}" "${pid}"
         "${server_exec}" \
          $server_conf \
          --status "${status}" 1 \
@@ -17,7 +16,6 @@
          --writepid "${pid}" \
          --explicit-exit-notify 3
     else
-        $RUN_SUDO rm -f "${status}" "${log}" "${pid}"
         $RUN_SUDO "${server_exec}" \
                    $server_conf \
                    --status "${status}" 1 \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49f1e7d25edb62bf202ffceb45dedc213f2eafdd
Gerrit-Change-Number: 776
Gerrit-PatchSet: 2
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-MessageType: newpatchset

--0AwzR5FEMg8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, mattock, pla=
isthos. </p>
<p>mattock <strong>uploaded patch set #2</strong> to this change.</p><p><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail">View Change<=
/a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">t_server_null: persist test log files<br><br>The goa=
l is to help debug issues with t_server_null. The immediate goal<br>is to b=
e able to debug server startup issues encountered on some of the<br>*BSD pl=
atforms.<br><br>Change-Id: I49f1e7d25edb62bf202ffceb45dedc213f2eafdd<br>Sig=
ned-off-by: Samuli Sepp=C3=A4nen &lt;samuli.seppanen@...277...&gt;<br>---<b=
r>M tests/t_server_null.sh<br>M tests/t_server_null_client.sh<br>M tests/t_=
server_null_server.sh<br>3 files changed, 8 insertions(+), 5 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/77=
6/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh</s=
pan><br><span>index 7627edf..61a9cdc 100755</span><br><span>--- a/tests/t_s=
erver_null.sh</span><br><span>+++ b/tests/t_server_null.sh</span><br><span>=
@@ -56,11 +56,16 @@</span><br><span> fi</span><br><span> </span><br><span> =
srcdir=3D&quot;${srcdir:-.}&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+export t_server_null_logdir=3Dt_server_null-`hostname`-`date =
+%Y%m%d-%H%M%S`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# Create directory for =
server and client logs</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+mkdir $t_server_null_logdir</span><br><span> </span><br><span> &quot;${s=
rcdir}/t_server_null_server.sh&quot; &amp;</span><br><span> &quot;${srcdir}=
/t_server_null_client.sh&quot;</span><br><span> retval=3D$?</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 # When running make jobs in parallel (&quot;make -j&lt;x&gt; check&quot;) =
we need to ensure</span><br><span> # that this script does not exit before =
all --dev null servers are dead and</span><br><span> # their network interf=
aces are gone. Otherwise t_client.sh will fail because</span><br><span>diff=
 --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh</spa=
n><br><span>index c1a25df..846f790 100755</span><br><span>--- a/tests/t_ser=
ver_null_client.sh</span><br><span>+++ b/tests/t_server_null_client.sh</spa=
n><br><span>@@ -14,7 +14,7 @@</span><br><span>         $client_conf \</span=
><br><span>         --writepid &quot;${pid}&quot; \</span><br><span>       =
  --setenv pid $pid \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        --log &quot;${log}&quot; &amp;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        --log &quot;${t_server_null_logdir}/${log}&quot;=
 &amp;</span><br><span> }</span><br><span> </span><br><span> wait_for_resul=
ts() {</span><br><span>@@ -44,7 +44,7 @@</span><br><span>     should_pass=
=3D$2</span><br><span>     log=3D&quot;${test_name}.log&quot;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    grep &quot;In=
itialization Sequence Completed&quot; &quot;${log}&quot; &gt; /dev/null</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    grep &quot;Initiali=
zation Sequence Completed&quot; &quot;${t_server_null_logdir}/${log}&quot; =
&gt; /dev/null</span><br><span>     exit_code=3D$?</span><br><span> </span>=
<br><span>     if [ $exit_code -eq 0 ] &amp;&amp; [ &quot;${should_pass}&qu=
ot; =3D &quot;yes&quot; ]; then</span><br><span>diff --git a/tests/t_server=
_null_server.sh b/tests/t_server_null_server.sh</span><br><span>index 10bb4=
4b..f8ba3a3 100755</span><br><span>--- a/tests/t_server_null_server.sh</spa=
n><br><span>+++ b/tests/t_server_null_server.sh</span><br><span>@@ -4,12 +4=
,11 @@</span><br><span>     server_name=3D$1</span><br><span>     server_ex=
ec=3D$2</span><br><span>     server_conf=3D$3</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    log=3D&quot;${server_name}.log&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    log=3D&quot;${t_server_nul=
l_logdir}/${server_name}.log&quot;</span><br><span>     status=3D&quot;${se=
rver_name}.status&quot;</span><br><span>     pid=3D&quot;${server_name}.pid=
&quot;</span><br><span> </span><br><span>     if [ -z &quot;${RUN_SUDO}&quo=
t; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        rm =
-f &quot;${status}&quot; &quot;${log}&quot; &quot;${pid}&quot;</span><br><s=
pan>         &quot;${server_exec}&quot; \</span><br><span>          $server=
_conf \</span><br><span>          --status &quot;${status}&quot; 1 \</span>=
<br><span>@@ -17,7 +16,6 @@</span><br><span>          --writepid &quot;${pi=
d}&quot; \</span><br><span>          --explicit-exit-notify 3</span><br><sp=
an>     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        $=
RUN_SUDO rm -f &quot;${status}&quot; &quot;${log}&quot; &quot;${pid}&quot;<=
/span><br><span>         $RUN_SUDO &quot;${server_exec}&quot; \</span><br><=
span>                    $server_conf \</span><br><span>                   =
 --status &quot;${status}&quot; 1 \</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demai=
l">change 776</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I49f1e7d25edb62bf202ffceb45d=
edc213f2eafdd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 776 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--0AwzR5FEMg8=--

