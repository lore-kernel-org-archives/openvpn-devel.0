From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 18 Jun 2025 16:14:06 +0000
In-Reply-To: <gerrit.1747380025000.I39dc6b08952a06dae7901e468f9487c8541d83c3@...2715...>
References: <gerrit.1747380025000.I39dc6b08952a06dae7901e468f9487c8541d83c3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., sasepp@...2783...
Message-ID: <4a161ab64652388f4263cb431eb4f3c479623ab7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VjmFrCVb6sg="; charset=UTF-8
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
To: mattock <sasepp@...2783...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VjmFrCVb6sg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
24?usp=3Demail )

Change subject: t_server_null: print error when server startup fails
......................................................................

t_server_null: print error when server startup fails

Use "&" to background so that the exit code and all output can be
obtained in all failure cases.

Change-Id: I39dc6b08952a06dae7901e468f9487c8541d83c3
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250618141328.4600-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
932.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_server_null_default.rc
M tests/t_server_null_server.sh
2 files changed, 13 insertions(+), 15 deletions(-)




diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 365b5a8..41ec591 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -38,7 +38,7 @@
 MAX_CLIENTS=3D"10"
 CLIENT_MATCH=3D"Test-Client"
 SERVER_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
-SERVER_BASE_OPTS=3D"--daemon --local 127.0.0.1 --dev tun --topology subnet=
 --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
+SERVER_BASE_OPTS=3D"--local 127.0.0.1 --dev tun --topology subnet --max-cl=
ients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn"
 SERVER_CIPHER_OPTS=3D""
 SERVER_CERT_OPTS=3D"--ca ${CA} --cert ${SERVER_CERT} --key ${SERVER_KEY} -=
-tls-auth ${TA} 0"
 SERVER_CONF_BASE=3D"${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CER=
T_OPTS}"
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
Gerrit-PatchSet: 4
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--VjmFrCVb6sg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1024?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">t_server_null: print error when server startu=
p fails<br><br>Use &quot;&amp;&quot; to background so that the exit code an=
d all output can be<br>obtained in all failure cases.<br><br>Change-Id: I39=
dc6b08952a06dae7901e468f9487c8541d83c3<br>Signed-off-by: Samuli Sepp=C3=A4n=
en &lt;samuli.seppanen@...277...&gt;<br>Acked-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>Message-Id: &lt;20250618141328.4600-1-gert@...1296...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3=
1932.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M tests/t_server_null_default.rc<br>M tests/t_server_null_server.sh<br>2 fi=
les changed, 13 insertions(+), 15 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_defaul=
t.rc</span><br><span>index 365b5a8..41ec591 100755</span><br><span>--- a/te=
sts/t_server_null_default.rc</span><br><span>+++ b/tests/t_server_null_defa=
ult.rc</span><br><span>@@ -38,7 +38,7 @@</span><br><span> MAX_CLIENTS=3D&qu=
ot;10&quot;</span><br><span> CLIENT_MATCH=3D&quot;Test-Client&quot;</span><=
br><span> SERVER_EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-SERVER_BASE_OPTS=3D&quot;=
--daemon --local 127.0.0.1 --dev tun --topology subnet --max-clients $MAX_C=
LIENTS --persist-tun --verb 3 --duplicate-cn&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+SERVER_BASE_OPTS=3D&quot;--local 127.0.0.1 -=
-dev tun --topology subnet --max-clients $MAX_CLIENTS --persist-tun --verb =
3 --duplicate-cn&quot;</span><br><span> SERVER_CIPHER_OPTS=3D&quot;&quot;</=
span><br><span> SERVER_CERT_OPTS=3D&quot;--ca ${CA} --cert ${SERVER_CERT} -=
-key ${SERVER_KEY} --tls-auth ${TA} 0&quot;</span><br><span> SERVER_CONF_BA=
SE=3D&quot;${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CERT_OPTS}&qu=
ot;</span><br><span>diff --git a/tests/t_server_null_server.sh b/tests/t_se=
rver_null_server.sh</span><br><span>index acf8479..65b7d56 100755</span><br=
><span>--- a/tests/t_server_null_server.sh</span><br><span>+++ b/tests/t_se=
rver_null_server.sh</span><br><span>@@ -11,20 +11,18 @@</span><br><span>   =
  # Allow reading this file even umask values are strict</span><br><span>  =
   touch &quot;$log&quot;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;${server_exec}&qu=
ot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         $server=
_conf \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         --sta=
tus &quot;${status}&quot; 1 \</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         --log &quot;${log}&quot; \</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         --writepid &quot;${pid}&quot; \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-         --explicit-exit-notify 3<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        $RUN_SUDO &quot;${server_ex=
ec}&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
         $server_conf \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                   --status &quot;${status}&quot; 1 \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                   --log &quot;${log}&quo=
t; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
  --writepid &quot;${pid}&quot; \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                   --explicit-exit-notify 3</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    # Try to launch the server</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    $RUN_SUDO &quot;${server=
_exec}&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
          $server_conf \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+               --status &quot;${status}&quot; 1 \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+               --writepid &quot;${pid}&q=
uot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
  --explicit-exit-notify 3 &gt; &quot;$log&quot; 2&gt;&amp;1 &amp;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    sleep 1</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if ! [ -r &quot;$pid&quot; ] || [ -z &quot;$pid&quot; ]; then</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;ERROR: fa=
iled to start server $server_name&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        tail -n 20 &quot;$log&quot;</span><br><span>   =
  fi</span><br><span> }</span><br><span> </span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1024?usp=
=3Demail">change 1024</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1024?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39dc6b08952a06dae7901e468f9=
487c8541d83c3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1024 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;sasepp@...2783...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--VjmFrCVb6sg=--

