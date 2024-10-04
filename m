From: "mattock (Code Review)" <gerrit@...515...>
Date: Fri, 4 Oct 2024 06:03:01 +0000
References: <gerrit.1728021778000.I49f1e7d25edb62bf202ffceb45dedc213f2eafdd@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <07bc3590c0b3cdf5100f0f5df13bb8b925adfa94-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ynxPQxLs0rY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ynxPQxLs0rY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail

to review the following change.


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
3 files changed, 9 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/776/1

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
index 10bb44b..9393b9c 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -13,7 +13,7 @@
         "${server_exec}" \
          $server_conf \
          --status "${status}" 1 \
-         --log "${log}" \
+         --log "${t_server_null_logdir}/${log}" \
          --writepid "${pid}" \
          --explicit-exit-notify 3
     else
@@ -21,7 +21,7 @@
         $RUN_SUDO "${server_exec}" \
                    $server_conf \
                    --status "${status}" 1 \
-                   --log "${log}" \
+                   --log "${t_server_null_logdir}/${log}" \
                    --writepid "${pid}" \
                    --explicit-exit-notify 3
     fi

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49f1e7d25edb62bf202ffceb45dedc213f2eafdd
Gerrit-Change-Number: 776
Gerrit-PatchSet: 1
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--ynxPQxLs0rY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mattock would like plaisthos and flichtenheld to <strong>review</strong>=
 this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">t_server_null: persist test log files<br><br>The goal is to h=
elp debug issues with t_server_null. The immediate goal<br>is to be able to=
 debug server startup issues encountered on some of the<br>*BSD platforms.<=
br><br>Change-Id: I49f1e7d25edb62bf202ffceb45dedc213f2eafdd<br>Signed-off-b=
y: Samuli Sepp=C3=A4nen &lt;samuli.seppanen@...277...&gt;<br>---<br>M tests=
/t_server_null.sh<br>M tests/t_server_null_client.sh<br>M tests/t_server_nu=
ll_server.sh<br>3 files changed, 9 insertions(+), 4 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/76/776/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh</span><br><=
span>index 7627edf..61a9cdc 100755</span><br><span>--- a/tests/t_server_nul=
l.sh</span><br><span>+++ b/tests/t_server_null.sh</span><br><span>@@ -56,11=
 +56,16 @@</span><br><span> fi</span><br><span> </span><br><span> srcdir=3D=
&quot;${srcdir:-.}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+export t_server_null_logdir=3Dt_server_null-`hostname`-`date +%Y%m%d-%=
H%M%S`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# Create directory for server an=
d client logs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mkdir =
$t_server_null_logdir</span><br><span> </span><br><span> &quot;${srcdir}/t_=
server_null_server.sh&quot; &amp;</span><br><span> &quot;${srcdir}/t_server=
_null_client.sh&quot;</span><br><span> retval=3D$?</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # When r=
unning make jobs in parallel (&quot;make -j&lt;x&gt; check&quot;) we need t=
o ensure</span><br><span> # that this script does not exit before all --dev=
 null servers are dead and</span><br><span> # their network interfaces are =
gone. Otherwise t_client.sh will fail because</span><br><span>diff --git a/=
tests/t_server_null_client.sh b/tests/t_server_null_client.sh</span><br><sp=
an>index c1a25df..846f790 100755</span><br><span>--- a/tests/t_server_null_=
client.sh</span><br><span>+++ b/tests/t_server_null_client.sh</span><br><sp=
an>@@ -14,7 +14,7 @@</span><br><span>         $client_conf \</span><br><spa=
n>         --writepid &quot;${pid}&quot; \</span><br><span>         --seten=
v pid $pid \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        -=
-log &quot;${log}&quot; &amp;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        --log &quot;${t_server_null_logdir}/${log}&quot; &amp;</s=
pan><br><span> }</span><br><span> </span><br><span> wait_for_results() {</s=
pan><br><span>@@ -44,7 +44,7 @@</span><br><span>     should_pass=3D$2</span=
><br><span>     log=3D&quot;${test_name}.log&quot;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    grep &quot;Initializatio=
n Sequence Completed&quot; &quot;${log}&quot; &gt; /dev/null</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    grep &quot;Initialization Sequ=
ence Completed&quot; &quot;${t_server_null_logdir}/${log}&quot; &gt; /dev/n=
ull</span><br><span>     exit_code=3D$?</span><br><span> </span><br><span> =
    if [ $exit_code -eq 0 ] &amp;&amp; [ &quot;${should_pass}&quot; =3D &qu=
ot;yes&quot; ]; then</span><br><span>diff --git a/tests/t_server_null_serve=
r.sh b/tests/t_server_null_server.sh</span><br><span>index 10bb44b..9393b9c=
 100755</span><br><span>--- a/tests/t_server_null_server.sh</span><br><span=
>+++ b/tests/t_server_null_server.sh</span><br><span>@@ -13,7 +13,7 @@</spa=
n><br><span>         &quot;${server_exec}&quot; \</span><br><span>         =
 $server_conf \</span><br><span>          --status &quot;${status}&quot; 1 =
\</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         --log &quot=
;${log}&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     --log &quot;${t_server_null_logdir}/${log}&quot; \</span><br><span>   =
       --writepid &quot;${pid}&quot; \</span><br><span>          --explicit=
-exit-notify 3</span><br><span>     else</span><br><span>@@ -21,7 +21,7 @@<=
/span><br><span>         $RUN_SUDO &quot;${server_exec}&quot; \</span><br><=
span>                    $server_conf \</span><br><span>                   =
 --status &quot;${status}&quot; 1 \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                   --log &quot;${log}&quot; \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                   --log &quot;${t_=
server_null_logdir}/${log}&quot; \</span><br><span>                    --wr=
itepid &quot;${pid}&quot; \</span><br><span>                    --explicit-=
exit-notify 3</span><br><span>     fi</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Dem=
ail">change 776</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I49f1e7d25edb62bf202ffceb45d=
edc213f2eafdd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 776 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--ynxPQxLs0rY=--

