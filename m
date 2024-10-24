From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 24 Oct 2024 17:51:15 +0000
In-Reply-To: <gerrit.1728021778000.I49f1e7d25edb62bf202ffceb45dedc213f2eafdd@...2715...>
References: <gerrit.1728021778000.I49f1e7d25edb62bf202ffceb45dedc213f2eafdd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dc9bef8dab979e2da462053e2241dcc55ef00a2d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wbhigDpBzfA="; charset=UTF-8
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
To: mattock <samuli@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wbhigDpBzfA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 mattock. ( http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: t_server_null: persist test log files
......................................................................

t_server_null: persist test log files

The goal is to help debug issues with t_server_null. The immediate goal
is to be able to debug server startup issues encountered on some of the
*BSD platforms.

Change-Id: I49f1e7d25edb62bf202ffceb45dedc213f2eafdd
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241024133220.4864-1-gert@...1296...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20241024133220.4864-1-=
gert@...1296...
URL: https://gerrit.openvpn.net/c/openvpn/+/776
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_server_null.sh
M tests/t_server_null_client.sh
M tests/t_server_null_server.sh
3 files changed, 7 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/776/3

diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index 7627edf..d4311d4 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -56,6 +56,10 @@
 fi

 srcdir=3D"${srcdir:-.}"
+export t_server_null_logdir=3Dt_server_null-`hostname`-`date +%Y%m%d-%H%M%=
S`
+
+# Create directory for server and client logs
+mkdir $t_server_null_logdir

 "${srcdir}/t_server_null_server.sh" &
 "${srcdir}/t_server_null_client.sh"
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
Gerrit-PatchSet: 3
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--wbhigDpBzfA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by mattock.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/77=
6?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">t_server_null: persist test log files<br><br>The goa=
l is to help debug issues with t_server_null. The immediate goal<br>is to b=
e able to debug server startup issues encountered on some of the<br>*BSD pl=
atforms.<br><br>Change-Id: I49f1e7d25edb62bf202ffceb45dedc213f2eafdd<br>Sig=
ned-off-by: Samuli Sepp=C3=A4nen &lt;samuli.seppanen@...277...&gt;<br>Acked=
-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20241024133220=
.4864-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/search?l=
=3Dmid&amp;q=3D20241024133220.4864-1-gert@...1296...<br>URL: https://gerrit=
.openvpn.net/c/openvpn/+/776<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M tests/t_server_null.sh<br>M tests/t_server_null_client=
.sh<br>M tests/t_server_null_server.sh<br>3 files changed, 7 insertions(+),=
 5 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/76/776/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/tests/t_server_null.sh b/tests/t_=
server_null.sh</span><br><span>index 7627edf..d4311d4 100755</span><br><spa=
n>--- a/tests/t_server_null.sh</span><br><span>+++ b/tests/t_server_null.sh=
</span><br><span>@@ -56,6 +56,10 @@</span><br><span> fi</span><br><span> </=
span><br><span> srcdir=3D&quot;${srcdir:-.}&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+export t_server_null_logdir=3Dt_server_null-`=
hostname`-`date +%Y%m%d-%H%M%S`</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Creat=
e directory for server and client logs</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+mkdir $t_server_null_logdir</span><br><span> </span><br>=
<span> &quot;${srcdir}/t_server_null_server.sh&quot; &amp;</span><br><span>=
 &quot;${srcdir}/t_server_null_client.sh&quot;</span><br><span>diff --git a=
/tests/t_server_null_client.sh b/tests/t_server_null_client.sh</span><br><s=
pan>index c1a25df..846f790 100755</span><br><span>--- a/tests/t_server_null=
_client.sh</span><br><span>+++ b/tests/t_server_null_client.sh</span><br><s=
pan>@@ -14,7 +14,7 @@</span><br><span>         $client_conf \</span><br><sp=
an>         --writepid &quot;${pid}&quot; \</span><br><span>         --sete=
nv pid $pid \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
--log &quot;${log}&quot; &amp;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        --log &quot;${t_server_null_logdir}/${log}&quot; &amp;</=
span><br><span> }</span><br><span> </span><br><span> wait_for_results() {</=
span><br><span>@@ -44,7 +44,7 @@</span><br><span>     should_pass=3D$2</spa=
n><br><span>     log=3D&quot;${test_name}.log&quot;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    grep &quot;Initializati=
on Sequence Completed&quot; &quot;${log}&quot; &gt; /dev/null</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    grep &quot;Initialization Seq=
uence Completed&quot; &quot;${t_server_null_logdir}/${log}&quot; &gt; /dev/=
null</span><br><span>     exit_code=3D$?</span><br><span> </span><br><span>=
     if [ $exit_code -eq 0 ] &amp;&amp; [ &quot;${should_pass}&quot; =3D &q=
uot;yes&quot; ]; then</span><br><span>diff --git a/tests/t_server_null_serv=
er.sh b/tests/t_server_null_server.sh</span><br><span>index 10bb44b..f8ba3a=
3 100755</span><br><span>--- a/tests/t_server_null_server.sh</span><br><spa=
n>+++ b/tests/t_server_null_server.sh</span><br><span>@@ -4,12 +4,11 @@</sp=
an><br><span>     server_name=3D$1</span><br><span>     server_exec=3D$2</s=
pan><br><span>     server_conf=3D$3</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    log=3D&quot;${server_name}.log&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    log=3D&quot;${t_server_null_logdir}/=
${server_name}.log&quot;</span><br><span>     status=3D&quot;${server_name}=
.status&quot;</span><br><span>     pid=3D&quot;${server_name}.pid&quot;</sp=
an><br><span> </span><br><span>     if [ -z &quot;${RUN_SUDO}&quot; ]; then=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        rm -f &quot;$=
{status}&quot; &quot;${log}&quot; &quot;${pid}&quot;</span><br><span>      =
   &quot;${server_exec}&quot; \</span><br><span>          $server_conf \</s=
pan><br><span>          --status &quot;${status}&quot; 1 \</span><br><span>=
@@ -17,7 +16,6 @@</span><br><span>          --writepid &quot;${pid}&quot; \=
</span><br><span>          --explicit-exit-notify 3</span><br><span>     el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        $RUN_SUDO r=
m -f &quot;${status}&quot; &quot;${log}&quot; &quot;${pid}&quot;</span><br>=
<span>         $RUN_SUDO &quot;${server_exec}&quot; \</span><br><span>     =
               $server_conf \</span><br><span>                    --status =
&quot;${status}&quot; 1 \</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail">change =
776</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I49f1e7d25edb62bf202ffceb45d=
edc213f2eafdd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 776 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--wbhigDpBzfA=--

