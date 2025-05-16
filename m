From: "mattock (Code Review)" <gerrit@...515...>
Date: Fri, 16 May 2025 07:20:28 +0000
References: <gerrit.1747380025000.I39dc6b08952a06dae7901e468f9487c8541d83c3@...2715...>
Reply-To: sasepp@...2783..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ffb57b65543120f903a11ab379e737132218859f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LGMguMEVWLU="; charset=UTF-8
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

--LGMguMEVWLU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1024?usp=3Demail

to review the following change.


Change subject: t_server_null: print error when server startup fails
......................................................................

t_server_null: print error when server startup fails

The --daemon option has to be at the end of the command-line.  Moreover,
if a pid-file is not found or is empty, launch a new server instance
without --log or --daemon so that the error message is printed properly.

Change-Id: I39dc6b08952a06dae7901e468f9487c8541d83c3
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M tests/t_server_null_default.rc
M tests/t_server_null_server.sh
2 files changed, 22 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1024/1

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
index acf8479..d8fd1c4 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -11,20 +11,31 @@
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
+    # Try to launch the server daemonized
+    $RUN_SUDO "${server_exec}" \
+               $server_conf \
+               --status "${status}" 1 \
+               --log "${log}" \
+               --writepid "${pid}" \
+               --explicit-exit-notify 3 \
+               --daemon
+
+    sleep 1
+
+    # With --daemon OpenVPN's exit code is always 0, even when it failed to
+    # start. Therefore we check the pid-file and if it is missing or is em=
pty
+    # we run OpenVPN without --daemon and --log to catch the underlying er=
ror.
+    # By backgrounding the process in the shell we ensure that we don't bl=
ock
+    # the test run in the (unlikely) case that OpenVPN startup actually
+    # succeeds.
+    if ! [ -r "$pid" ] || [ -z "$pid" ]; then
+        echo "ERROR: failed to start server $server_name"
+
         $RUN_SUDO "${server_exec}" \
                    $server_conf \
                    --status "${status}" 1 \
-                   --log "${log}" \
                    --writepid "${pid}" \
-                   --explicit-exit-notify 3
+                   --explicit-exit-notify 3 &
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
Gerrit-PatchSet: 1
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--LGMguMEVWLU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mattock would like plaisthos and flichtenheld to <strong>review</strong>=
 this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1024?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">t_server_null: print error when server startup fails<br><br>=
The --daemon option has to be at the end of the command-line.  Moreover,<br=
>if a pid-file is not found or is empty, launch a new server instance<br>wi=
thout --log or --daemon so that the error message is printed properly.<br><=
br>Change-Id: I39dc6b08952a06dae7901e468f9487c8541d83c3<br>Signed-off-by: S=
amuli Sepp=C3=A4nen &lt;samuli.seppanen@...277...&gt;<br>---<br>M tests/t_s=
erver_null_default.rc<br>M tests/t_server_null_server.sh<br>2 files changed=
, 22 insertions(+), 11 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/24/1024/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/t_serv=
er_null_default.rc b/tests/t_server_null_default.rc</span><br><span>index 5=
b74761..1f2fa2c 100755</span><br><span>--- a/tests/t_server_null_default.rc=
</span><br><span>+++ b/tests/t_server_null_default.rc</span><br><span>@@ -3=
8,7 +38,7 @@</span><br><span> MAX_CLIENTS=3D&quot;10&quot;</span><br><span>=
 CLIENT_MATCH=3D&quot;Test-Client&quot;</span><br><span> SERVER_EXEC=3D&quo=
t;${top_builddir}/src/openvpn/openvpn&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-SERVER_BASE_OPTS=3D&quot;--daemon --dev tun --topolog=
y subnet --max-clients $MAX_CLIENTS --persist-tun --verb 3 --duplicate-cn&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_BASE_OPT=
S=3D&quot;--dev tun --topology subnet --max-clients $MAX_CLIENTS --persist-=
tun --verb 3 --duplicate-cn&quot;</span><br><span> SERVER_BIND_OPTS=3D&quot=
;--local 127.0.0.1&quot;</span><br><span> SERVER_CIPHER_OPTS=3D&quot;&quot;=
</span><br><span> SERVER_CERT_OPTS=3D&quot;--ca ${CA} --dh ${DH} --cert ${S=
ERVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0&quot;</span><br><span>di=
ff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh</s=
pan><br><span>index acf8479..d8fd1c4 100755</span><br><span>--- a/tests/t_s=
erver_null_server.sh</span><br><span>+++ b/tests/t_server_null_server.sh</s=
pan><br><span>@@ -11,20 +11,31 @@</span><br><span>     # Allow reading this=
 file even umask values are strict</span><br><span>     touch &quot;$log&qu=
ot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        &quot;${server_exec}&quot; \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-         $server_conf \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-         --status &quot;${status}&qu=
ot; 1 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         --log=
 &quot;${log}&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
         --writepid &quot;${pid}&quot; \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-         --explicit-exit-notify 3</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    # Try to launch the server daemonized</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    $RUN_SUDO &quot;${server_exe=
c}&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
      $server_conf \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+               --status &quot;${status}&quot; 1 \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+               --log &quot;${log}&quot; \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+               --write=
pid &quot;${pid}&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+               --explicit-exit-notify 3 \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+               --daemon</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    sleep 1</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # With --da=
emon OpenVPN&#39;s exit code is always 0, even when it failed to</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    # start. Therefore we chec=
k the pid-file and if it is missing or is empty</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    # we run OpenVPN without --daemon and --log=
 to catch the underlying error.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    # By backgrounding the process in the shell we ensure that =
we don&#39;t block</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   # the test run in the (unlikely) case that OpenVPN startup actually</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    # succeeds.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if ! [ -r &quot;$pid&quo=
t; ] || [ -z &quot;$pid&quot; ]; then</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        echo &quot;ERROR: failed to start server $server_=
name&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>         $RUN_SUDO &quot;${server_exec}&quot; \</span><br><span>   =
                 $server_conf \</span><br><span>                    --statu=
s &quot;${status}&quot; 1 \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                   --log &quot;${log}&quot; \</span><br><span>       =
             --writepid &quot;${pid}&quot; \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                   --explicit-exit-notify 3</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                   --explici=
t-exit-notify 3 &amp;</span><br><span>     fi</span><br><span> }</span><br>=
<span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1024?usp=3Demail">change 1024</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1024?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39dc6b08952a06dae7901e468f9=
487c8541d83c3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1024 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;sasepp@...2783...&gt=
; </div>
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


--LGMguMEVWLU=--

