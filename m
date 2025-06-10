From: "mattock (Code Review)" <gerrit@...515...>
Date: Tue, 10 Jun 2025 11:31:32 +0000
In-Reply-To: <gerrit.1747380025000.I39dc6b08952a06dae7901e468f9487c8541d83c3@...2715...>
References: <gerrit.1747380025000.I39dc6b08952a06dae7901e468f9487c8541d83c3@...2715...>
Reply-To: sasepp@...2783..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <41b63e08af6011e3f024475cd78957684ffdedb1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wMl8Xx7KqNI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_server_null: print
 error when server startup fails
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

--wMl8Xx7KqNI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1024?usp=3Demail

to look at the new patch set (#3).


Change subject: t_server_null: print error when server startup fails
......................................................................

t_server_null: print error when server startup fails

Use "&" to background so that the exit code and all output can be
obtained in all failure cases.

Change-Id: I39dc6b08952a06dae7901e468f9487c8541d83c3
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M tests/t_server_null_default.rc
M tests/t_server_null_server.sh
2 files changed, 13 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1024/3

diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 5b74761..1f2fa2c 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -38,7 +38,7 @@
 MAX_CLIENTS=3D"10"
 CLIENT_MATCH=3D"Test-Client"
 SERVER_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
-SERVER_BASE_OPTS=3D"--daemon --dev tun --topology subnet --max-clients $MA=
X_CLIENTS --persist-tun --verb 3 --duplicate-cn"
+SERVER_BASE_OPTS=3D"--dev tun --topology subnet --max-clients $MAX_CLIENTS=
 --persist-tun --verb 3 --duplicate-cn"
 SERVER_BIND_OPTS=3D"--local 127.0.0.1"
 SERVER_CIPHER_OPTS=3D""
 SERVER_CERT_OPTS=3D"--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SE=
RVER_KEY} --tls-auth ${TA} 0"
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index acf8479..65b7d56 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -11,20 +11,18 @@
     # Allow reading this file even umask values are strict
     touch "$log"

-    if [ -z "${RUN_SUDO}" ]; then
-        "${server_exec}" \
-         $server_conf \
-         --status "${status}" 1 \
-         --log "${log}" \
-         --writepid "${pid}" \
-         --explicit-exit-notify 3
-    else
-        $RUN_SUDO "${server_exec}" \
-                   $server_conf \
-                   --status "${status}" 1 \
-                   --log "${log}" \
-                   --writepid "${pid}" \
-                   --explicit-exit-notify 3
+    # Try to launch the server
+    $RUN_SUDO "${server_exec}" \
+               $server_conf \
+               --status "${status}" 1 \
+               --writepid "${pid}" \
+               --explicit-exit-notify 3 > "$log" 2>&1 &
+
+    sleep 1
+
+    if ! [ -r "$pid" ] || [ -z "$pid" ]; then
+        echo "ERROR: failed to start server $server_name"
+        tail -n 20 "$log"
     fi
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1024?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I39dc6b08952a06dae7901e468f9487c8541d83c3
Gerrit-Change-Number: 1024
Gerrit-PatchSet: 3
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--wMl8Xx7KqNI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>mattock <strong>uploaded patch set #3</strong> to this change.</p><p><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1024?usp=3Demail">View Change=
</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">t_server_null: print error when server startup fails<br><br>Use &quot;=
&amp;&quot; to background so that the exit code and all output can be<br>ob=
tained in all failure cases.<br><br>Change-Id: I39dc6b08952a06dae7901e468f9=
487c8541d83c3<br>Signed-off-by: Samuli Sepp=C3=A4nen &lt;samuli.seppanen@...1186...=
.277...&gt;<br>---<br>M tests/t_server_null_default.rc<br>M tests/t_server_=
null_server.sh<br>2 files changed, 13 insertions(+), 15 deletions(-)<br><br=
></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1024/3<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_d=
efault.rc</span><br><span>index 5b74761..1f2fa2c 100755</span><br><span>---=
 a/tests/t_server_null_default.rc</span><br><span>+++ b/tests/t_server_null=
_default.rc</span><br><span>@@ -38,7 +38,7 @@</span><br><span> MAX_CLIENTS=
=3D&quot;10&quot;</span><br><span> CLIENT_MATCH=3D&quot;Test-Client&quot;</=
span><br><span> SERVER_EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SERVER_BASE_OPTS=3D=
&quot;--daemon --dev tun --topology subnet --max-clients $MAX_CLIENTS --per=
sist-tun --verb 3 --duplicate-cn&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+SERVER_BASE_OPTS=3D&quot;--dev tun --topology subnet --m=
ax-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn&quot;</span><=
br><span> SERVER_BIND_OPTS=3D&quot;--local 127.0.0.1&quot;</span><br><span>=
 SERVER_CIPHER_OPTS=3D&quot;&quot;</span><br><span> SERVER_CERT_OPTS=3D&quo=
t;--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SERVER_KEY} --tls-aut=
h ${TA} 0&quot;</span><br><span>diff --git a/tests/t_server_null_server.sh =
b/tests/t_server_null_server.sh</span><br><span>index acf8479..65b7d56 1007=
55</span><br><span>--- a/tests/t_server_null_server.sh</span><br><span>+++ =
b/tests/t_server_null_server.sh</span><br><span>@@ -11,20 +11,18 @@</span><=
br><span>     # Allow reading this file even umask values are strict</span>=
<br><span>     touch &quot;$log&quot;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if [ -z &quot;${RUN_SUDO}&quot; ]; th=
en</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;${ser=
ver_exec}&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
     $server_conf \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       --status &quot;${status}&quot; 1 \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-         --log &quot;${log}&quot; \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         --writepid &quot;${pid}&quot; \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-         --explicit-ex=
it-notify 3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        $RUN_SUDO &quot=
;${server_exec}&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                   $server_conf \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                   --status &quot;${status}&quot; 1 \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                   --log &quo=
t;${log}&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
              --writepid &quot;${pid}&quot; \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                   --explicit-exit-notify 3</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    # Try to launch the ser=
ver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    $RUN_SUDO &q=
uot;${server_exec}&quot; \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+               $server_conf \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+               --status &quot;${status}&quot; 1 \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+               --writepid &q=
uot;${pid}&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
              --explicit-exit-notify 3 &gt; &quot;$log&quot; 2&gt;&amp;1 &a=
mp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    sleep 1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if ! [ -r &quot;$pid&quot; ] || [ -z &quot;$pid&quot; ];=
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &=
quot;ERROR: failed to start server $server_name&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tail -n 20 &quot;$log&quot;</span=
><br><span>     fi</span><br><span> }</span><br><span> </span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1024?usp=3Demail">change 1024</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1024?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39dc6b08952a06dae7901e468f9=
487c8541d83c3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1024 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;sasepp@...2783...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--wMl8Xx7KqNI=--

