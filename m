From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 4 Jul 2024 20:29:47 +0000
In-Reply-To: <gerrit.1718899574000.I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a@...2715...>
References: <gerrit.1718899574000.I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <12433c23e89ea7fa172c49009fec5b6ace424c2d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6BzEtOUxfkM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_server_null:
 multiple improvements and fixes
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

--6BzEtOUxfkM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 mattock. ( http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: t_server_null: multiple improvements and fixes
......................................................................

t_server_null: multiple improvements and fixes

- exit after a timeout if unable to kill servers
- use sudo or equivalent only for server stop/start
- use /bin/sh directly instead of through /usr/bin/env
- simplify sudo call in the sample rc file
- remove misleading and outdated documentation
- make it work on OpenBSD 7.5
- make it work on NetBSD 10.0
- make server logs readable by normal users

Change-Id: I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240704133337.26595-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
871.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/t_server_null.rst
M tests/t_server_null.rc-sample
M tests/t_server_null.sh
M tests/t_server_null_client.sh
M tests/t_server_null_default.rc
M tests/t_server_null_server.sh
M tests/t_server_null_stress.sh
7 files changed, 64 insertions(+), 40 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/669/6

diff --git a/doc/t_server_null.rst b/doc/t_server_null.rst
index e3a098a..5fe9080 100644
--- a/doc/t_server_null.rst
+++ b/doc/t_server_null.rst
@@ -43,6 +43,12 @@
   * run as root
   * a privilege escalation tool (sudo, doas, su) and the permission to bec=
ome root

+If you use "doas" you should enable nopass feature in */etc/doas.conf*. For
+example to allow users in the *wheel* group to run commands without a pass=
word
+prompt::
+
+    permit nopass keepenv :wheel
+
 Technical implementation
 ------------------------

@@ -73,13 +79,6 @@

       * Waits until servers have launched. Then launch all clients, wait f=
or them to exit and then check test results by parsing the client log files=
. Each client kills itself after some delay using an "--up" script.

-Note that "make check" moves on once *t_server_null_client.sh* has exited.=
 At
-that point *t_server_null_server.sh* is still running, because it exists o=
nly
-after waiting a few seconds for more client connections to potentially app=
ear.
-This is a feature and not a bug, but means that launching "make check" run=
s too
-quickly might cause test failures or unexpected behavior such as leftover
-OpenVPN server processes.
-
 Configuration
 -------------

diff --git a/tests/t_server_null.rc-sample b/tests/t_server_null.rc-sample
index 28c3773..98d7869 100644
--- a/tests/t_server_null.rc-sample
+++ b/tests/t_server_null.rc-sample
@@ -1,6 +1,5 @@
 # Uncomment to run tests with sudo
-#SUDO_EXEC=3D`which sudo`
-#RUN_SUDO=3D"${SUDO_EXEC} -E"
+#RUN_SUDO=3D"sudo -E"

 TEST_RUN_LIST=3D"1 2 3 10 11"

diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index 0e53ba4..7627edf 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env sh
+#!/bin/sh
 #
 TSERVER_NULL_SKIP_RC=3D"${TSERVER_NULL_SKIP_RC:-77}"

@@ -57,12 +57,7 @@

 srcdir=3D"${srcdir:-.}"

-if [ -z "${RUN_SUDO}" ]; then
-    "${srcdir}/t_server_null_server.sh" &
-else
-    $RUN_SUDO "${srcdir}/t_server_null_server.sh" &
-fi
-
+"${srcdir}/t_server_null_server.sh" &
 "${srcdir}/t_server_null_client.sh"
 retval=3D$?

diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index 8890007..e7dd332 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env sh
+#!/bin/sh

 launch_client() {
     test_name=3D$1
@@ -76,19 +76,22 @@
 count=3D0
 server_max_wait=3D15
 while [ $count -lt $server_max_wait ]; do
-    server_pids=3D""
-    server_count=3D$(set|grep 'SERVER_NAME_'|wc -l)
+    servers_up=3D0
+    server_count=3D$(echo $TEST_SERVER_LIST|wc -w)

     # We need to trim single-quotes because some shells return quoted valu=
es
     # and some don't. Using "set -o posix" which would resolve this proble=
m is
     # not supported in all shells.
+    #
+    # While inactive server configurations may get checked they won't incr=
ease
+    # the active server count as the processes won't be running.
     for i in `set|grep 'SERVER_NAME_'|cut -d "=3D" -f 2|tr -d "[\']"`; do
         server_pid=3D$(cat $i.pid 2> /dev/null)
-        server_pids=3D"${server_pids} ${server_pid}"
+        if ps -p $server_pid > /dev/null 2>&1; then
+            servers_up=3D$(( $servers_up + 1 ))
+        fi
     done

-    servers_up=3D$(ps -p $server_pids 2>/dev/null|sed '1d'|wc -l)
-
     echo "OpenVPN test servers up: ${servers_up}/${server_count}"

     if [ $servers_up -ge $server_count ]; then
@@ -101,6 +104,7 @@

     if [ $count -eq $server_max_wait ]; then
         retval=3D1
+        exit $retval
     fi
 done

diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index 63b6bcd..825bb52 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -24,7 +24,7 @@
 MAX_CLIENTS=3D"10"
 CLIENT_MATCH=3D"Test-Client"
 SERVER_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
-SERVER_BASE_OPTS=3D"--daemon --local 127.0.0.1 --dev tun --topology subnet=
 --server 10.29.41.0 255.255.255.0 --max-clients $MAX_CLIENTS --persist-tun=
 --verb 3"
+SERVER_BASE_OPTS=3D"--daemon --local 127.0.0.1 --dev tun --topology subnet=
 --max-clients $MAX_CLIENTS --persist-tun --verb 3"
 SERVER_CIPHER_OPTS=3D""
 SERVER_CERT_OPTS=3D"--ca ${CA} --dh ${DH} --cert ${SERVER_CERT} --key ${SE=
RVER_KEY} --tls-auth ${TA} 0"
 SERVER_CONF_BASE=3D"${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_CER=
T_OPTS}"
@@ -32,14 +32,16 @@
 TEST_SERVER_LIST=3D"1 2"

 SERVER_NAME_1=3D"t_server_null_server-1194_udp"
+SERVER_SERVER_1=3D"--server 10.29.41.0 255.255.255.0"
 SERVER_MGMT_PORT_1=3D"11194"
 SERVER_EXEC_1=3D"${SERVER_EXEC}"
-SERVER_CONF_1=3D"${SERVER_CONF_BASE} --lport 1194 --proto udp --management=
 127.0.0.1 ${SERVER_MGMT_PORT_1}"
+SERVER_CONF_1=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_1} --lport 1194 --pro=
to udp --management 127.0.0.1 ${SERVER_MGMT_PORT_1}"

 SERVER_NAME_2=3D"t_server_null_server-1195_tcp"
+SERVER_SERVER_2=3D"--server 10.29.42.0 255.255.255.0"
 SERVER_MGMT_PORT_2=3D"11195"
 SERVER_EXEC_2=3D"${SERVER_EXEC}"
-SERVER_CONF_2=3D"${SERVER_CONF_BASE} --lport 1195 --proto tcp --management=
 127.0.0.1 ${SERVER_MGMT_PORT_2}"
+SERVER_CONF_2=3D"${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --pro=
to tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}"

 # Test client configurations
 CLIENT_EXEC=3D"${top_builddir}/src/openvpn/openvpn"
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index 9bc0c88..e5906ee 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env sh
+#!/bin/sh

 launch_server() {
     server_name=3D$1
@@ -8,18 +8,28 @@
     status=3D"${server_name}.status"
     pid=3D"${server_name}.pid"

-    # Ensure that old status, log and pid files are gone
-    rm -f "${status}" "${log}" "${pid}"
-
-    "${server_exec}" \
-        $server_conf \
-        --status "${status}" 1 \
-        --log "${log}" \
-        --writepid "${pid}" \
-        --explicit-exit-notify 3
-
+    if [ -z "${RUN_SUDO}" ]; then
+        rm -f "${status}" "${log}" "${pid}"
+        "${server_exec}" \
+         $server_conf \
+         --status "${status}" 1 \
+         --log "${log}" \
+         --writepid "${pid}" \
+         --explicit-exit-notify 3
+    else
+        $RUN_SUDO rm -f "${status}" "${log}" "${pid}"
+        $RUN_SUDO "${server_exec}" \
+                   $server_conf \
+                   --status "${status}" 1 \
+                   --log "${log}" \
+                   --writepid "${pid}" \
+                   --explicit-exit-notify 3
+    fi
 }

+# Make server log files readable by normal users
+umask 022
+
 # Load base/default configuration
 . "${srcdir}/t_server_null_default.rc" || exit 1

@@ -64,15 +74,30 @@

 echo "All clients have disconnected from all servers"

+# Make sure that the server processes are truly dead before exiting.  If a
+# server process does not exit in 15 seconds assume it never will, move on=
 and
+# hope for the best.
+echo "Waiting for servers to exit"
 for PID_FILE in $server_pid_files
 do
     SERVER_PID=3D$(cat "${PID_FILE}")
-    $KILL_EXEC "${SERVER_PID}"

-    # Make sure that the server processes are truly dead before exiting
-    while :
+    if [ -z "${RUN_SUDO}" ]; then
+        $KILL_EXEC "${SERVER_PID}"
+    else
+        $RUN_SUDO $KILL_EXEC "${SERVER_PID}"
+    fi
+
+    count=3D0
+    maxcount=3D75
+    while [ $count -le $maxcount ]
     do
         ps -p "${SERVER_PID}" > /dev/null || break
+        count=3D$(( count + 1))
         sleep 0.2
     done
+
+    if [ $count -ge $maxcount ]; then
+        echo "WARNING: could not kill server with pid ${SERVER_PID}!"
+    fi
 done
diff --git a/tests/t_server_null_stress.sh b/tests/t_server_null_stress.sh
index 1281397..0bb9452 100755
--- a/tests/t_server_null_stress.sh
+++ b/tests/t_server_null_stress.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env sh
+#!/bin/sh
 #
 # Run this stress test as root to avoid sudo authorization from timing out.


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a
Gerrit-Change-Number: 669
Gerrit-PatchSet: 6
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--6BzEtOUxfkM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #6</strong> to the change originally cr=
eated by mattock.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/66=
9?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">t_server_null: multiple improvements and fixe=
s<br><br>- exit after a timeout if unable to kill servers<br>- use sudo or =
equivalent only for server stop/start<br>- use /bin/sh directly instead of =
through /usr/bin/env<br>- simplify sudo call in the sample rc file<br>- rem=
ove misleading and outdated documentation<br>- make it work on OpenBSD 7.5<=
br>- make it work on NetBSD 10.0<br>- make server logs readable by normal u=
sers<br><br>Change-Id: I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a<br>Signed-=
off-by: Samuli Sepp=C3=A4nen &lt;samuli.seppanen@...277...&gt;<br>Acked-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;202407041333=
37.26595-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg28871.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M doc/t_server_null.rst<br>M tests/t_serve=
r_null.rc-sample<br>M tests/t_server_null.sh<br>M tests/t_server_null_clien=
t.sh<br>M tests/t_server_null_default.rc<br>M tests/t_server_null_server.sh=
<br>M tests/t_server_null_stress.sh<br>7 files changed, 64 insertions(+), 4=
0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/69/669/6</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/doc/t_server_null.rst b/doc/t_serv=
er_null.rst</span><br><span>index e3a098a..5fe9080 100644</span><br><span>-=
-- a/doc/t_server_null.rst</span><br><span>+++ b/doc/t_server_null.rst</spa=
n><br><span>@@ -43,6 +43,12 @@</span><br><span>   * run as root</span><br><=
span>   * a privilege escalation tool (sudo, doas, su) and the permission t=
o become root</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+If you use &quot;doas&quot; you should enable nopass feature in=
 */etc/doas.conf*. For</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+example to allow users in the *wheel* group to run commands without a pa=
ssword</span><br><span style=3D"color: hsl(120, 100%, 40%);">+prompt::</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    permit nopass keepenv :wheel</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Technical =
implementation</span><br><span> ------------------------</span><br><span> <=
/span><br><span>@@ -73,13 +79,6 @@</span><br><span> </span><br><span>      =
 * Waits until servers have launched. Then launch all clients, wait for the=
m to exit and then check test results by parsing the client log files. Each=
 client kills itself after some delay using an &quot;--up&quot; script.</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-Note th=
at &quot;make check&quot; moves on once *t_server_null_client.sh* has exite=
d. At</span><br><span style=3D"color: hsl(0, 100%, 40%);">-that point *t_se=
rver_null_server.sh* is still running, because it exists only</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-after waiting a few seconds for mor=
e client connections to potentially appear.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-This is a feature and not a bug, but means that launc=
hing &quot;make check&quot; runs too</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-quickly might cause test failures or unexpected behavior suc=
h as leftover</span><br><span style=3D"color: hsl(0, 100%, 40%);">-OpenVPN =
server processes.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> Configuration</span><br><span> -------------</span><br><span>=
 </span><br><span>diff --git a/tests/t_server_null.rc-sample b/tests/t_serv=
er_null.rc-sample</span><br><span>index 28c3773..98d7869 100644</span><br><=
span>--- a/tests/t_server_null.rc-sample</span><br><span>+++ b/tests/t_serv=
er_null.rc-sample</span><br><span>@@ -1,6 +1,5 @@</span><br><span> # Uncomm=
ent to run tests with sudo</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#SUDO_EXEC=3D`which sudo`</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#RUN_SUDO=3D&quot;${SUDO_EXEC} -E&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#RUN_SUDO=3D&quot;sudo -E&quot;</span><br><spa=
n> </span><br><span> TEST_RUN_LIST=3D&quot;1 2 3 10 11&quot;</span><br><spa=
n> </span><br><span>diff --git a/tests/t_server_null.sh b/tests/t_server_nu=
ll.sh</span><br><span>index 0e53ba4..7627edf 100755</span><br><span>--- a/t=
ests/t_server_null.sh</span><br><span>+++ b/tests/t_server_null.sh</span><b=
r><span>@@ -1,4 +1,4 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#!/usr/bin/env sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#!/bin/sh</span><br><span> #</span><br><span> TSERVER_NULL_SKIP_RC=3D&quot;=
${TSERVER_NULL_SKIP_RC:-77}&quot;</span><br><span> </span><br><span>@@ -57,=
12 +57,7 @@</span><br><span> </span><br><span> srcdir=3D&quot;${srcdir:-.}&=
quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    &quot;${srcdir}/t_server_null_server.sh&quot; &amp;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    $RUN_SUDO &quot;${srcdir}/t_server=
_null_server.sh&quot; &amp;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+&quot;${srcdir}/t_server_null_se=
rver.sh&quot; &amp;</span><br><span> &quot;${srcdir}/t_server_null_client.s=
h&quot;</span><br><span> retval=3D$?</span><br><span> </span><br><span>diff=
 --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh</spa=
n><br><span>index 8890007..e7dd332 100755</span><br><span>--- a/tests/t_ser=
ver_null_client.sh</span><br><span>+++ b/tests/t_server_null_client.sh</spa=
n><br><span>@@ -1,4 +1,4 @@</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#!/usr/bin/env sh</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#!/bin/sh</span><br><span> </span><br><span> launch_client() {</span><b=
r><span>     test_name=3D$1</span><br><span>@@ -76,19 +76,22 @@</span><br><=
span> count=3D0</span><br><span> server_max_wait=3D15</span><br><span> whil=
e [ $count -lt $server_max_wait ]; do</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    server_pids=3D&quot;&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    server_count=3D$(set|grep &#39;SERVER_NAME_&#3=
9;|wc -l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    server=
s_up=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    server_=
count=3D$(echo $TEST_SERVER_LIST|wc -w)</span><br><span> </span><br><span> =
    # We need to trim single-quotes because some shells return quoted value=
s</span><br><span>     # and some don&#39;t. Using &quot;set -o posix&quot;=
 which would resolve this problem is</span><br><span>     # not supported i=
n all shells.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # While inactive=
 server configurations may get checked they won&#39;t increase</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    # the active server count as=
 the processes won&#39;t be running.</span><br><span>     for i in `set|gre=
p &#39;SERVER_NAME_&#39;|cut -d &quot;=3D&quot; -f 2|tr -d &quot;[\&#39;]&q=
uot;`; do</span><br><span>         server_pid=3D$(cat $i.pid 2&gt; /dev/nul=
l)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pids=
=3D&quot;${server_pids} ${server_pid}&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if ps -p $server_pid &gt; /dev/null 2&gt;&a=
mp;1; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   servers_up=3D$(( $servers_up + 1 ))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        fi</span><br><span>     done</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    servers_up=3D$(ps -=
p $server_pids 2&gt;/dev/null|sed &#39;1d&#39;|wc -l)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     echo &quot;OpenVPN te=
st servers up: ${servers_up}/${server_count}&quot;</span><br><span> </span>=
<br><span>     if [ $servers_up -ge $server_count ]; then</span><br><span>@=
@ -101,6 +104,7 @@</span><br><span> </span><br><span>     if [ $count -eq $=
server_max_wait ]; then</span><br><span>         retval=3D1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        exit $retval</span><br><spa=
n>     fi</span><br><span> done</span><br><span> </span><br><span>diff --gi=
t a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc</span><=
br><span>index 63b6bcd..825bb52 100755</span><br><span>--- a/tests/t_server=
_null_default.rc</span><br><span>+++ b/tests/t_server_null_default.rc</span=
><br><span>@@ -24,7 +24,7 @@</span><br><span> MAX_CLIENTS=3D&quot;10&quot;<=
/span><br><span> CLIENT_MATCH=3D&quot;Test-Client&quot;</span><br><span> SE=
RVER_EXEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-SERVER_BASE_OPTS=3D&quot;--daemon --l=
ocal 127.0.0.1 --dev tun --topology subnet --server 10.29.41.0 255.255.255.=
0 --max-clients $MAX_CLIENTS --persist-tun --verb 3&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+SERVER_BASE_OPTS=3D&quot;--daemon --l=
ocal 127.0.0.1 --dev tun --topology subnet --max-clients $MAX_CLIENTS --per=
sist-tun --verb 3&quot;</span><br><span> SERVER_CIPHER_OPTS=3D&quot;&quot;<=
/span><br><span> SERVER_CERT_OPTS=3D&quot;--ca ${CA} --dh ${DH} --cert ${SE=
RVER_CERT} --key ${SERVER_KEY} --tls-auth ${TA} 0&quot;</span><br><span> SE=
RVER_CONF_BASE=3D&quot;${SERVER_BASE_OPTS} ${SERVER_CIPHER_OPTS} ${SERVER_C=
ERT_OPTS}&quot;</span><br><span>@@ -32,14 +32,16 @@</span><br><span> TEST_S=
ERVER_LIST=3D&quot;1 2&quot;</span><br><span> </span><br><span> SERVER_NAME=
_1=3D&quot;t_server_null_server-1194_udp&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+SERVER_SERVER_1=3D&quot;--server 10.29.41.0 255.=
255.255.0&quot;</span><br><span> SERVER_MGMT_PORT_1=3D&quot;11194&quot;</sp=
an><br><span> SERVER_EXEC_1=3D&quot;${SERVER_EXEC}&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-SERVER_CONF_1=3D&quot;${SERVER_CONF_BASE=
} --lport 1194 --proto udp --management 127.0.0.1 ${SERVER_MGMT_PORT_1}&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SERVER_CONF_1=3D&=
quot;${SERVER_CONF_BASE} ${SERVER_SERVER_1} --lport 1194 --proto udp --mana=
gement 127.0.0.1 ${SERVER_MGMT_PORT_1}&quot;</span><br><span> </span><br><s=
pan> SERVER_NAME_2=3D&quot;t_server_null_server-1195_tcp&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+SERVER_SERVER_2=3D&quot;--server=
 10.29.42.0 255.255.255.0&quot;</span><br><span> SERVER_MGMT_PORT_2=3D&quot=
;11195&quot;</span><br><span> SERVER_EXEC_2=3D&quot;${SERVER_EXEC}&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-SERVER_CONF_2=3D&quot;${=
SERVER_CONF_BASE} --lport 1195 --proto tcp --management 127.0.0.1 ${SERVER_=
MGMT_PORT_2}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+S=
ERVER_CONF_2=3D&quot;${SERVER_CONF_BASE} ${SERVER_SERVER_2} --lport 1195 --=
proto tcp --management 127.0.0.1 ${SERVER_MGMT_PORT_2}&quot;</span><br><spa=
n> </span><br><span> # Test client configurations</span><br><span> CLIENT_E=
XEC=3D&quot;${top_builddir}/src/openvpn/openvpn&quot;</span><br><span>diff =
--git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh</span=
><br><span>index 9bc0c88..e5906ee 100755</span><br><span>--- a/tests/t_serv=
er_null_server.sh</span><br><span>+++ b/tests/t_server_null_server.sh</span=
><br><span>@@ -1,4 +1,4 @@</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#!/usr/bin/env sh</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#!/bin/sh</span><br><span> </span><br><span> launch_server() {</span><br=
><span>     server_name=3D$1</span><br><span>@@ -8,18 +8,28 @@</span><br><s=
pan>     status=3D&quot;${server_name}.status&quot;</span><br><span>     pi=
d=3D&quot;${server_name}.pid&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    # Ensure that old status, log and pid f=
iles are gone</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rm -=
f &quot;${status}&quot; &quot;${log}&quot; &quot;${pid}&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    &quot;${server_exec}&quot; \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        $server_conf \</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        --status &quot;${status}&quot; 1 \=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        --log &quot;$=
{log}&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
--writepid &quot;${pid}&quot; \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        --explicit-exit-notify 3</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        rm -f &quot;${status}&quot; &quot;${log}&=
quot; &quot;${pid}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        &quot;${server_exec}&quot; \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         $server_conf \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         --status &quot;${status}&quot; 1 \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         --log &quot;${lo=
g}&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
--writepid &quot;${pid}&quot; \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         --explicit-exit-notify 3</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        $RUN_SUDO rm -f &quot;${status}&quot; &quot;${log}&q=
uot; &quot;${pid}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        $RUN_SUDO &quot;${server_exec}&quot; \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                   $server_conf \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                   --status &q=
uot;${status}&quot; 1 \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   --log &quot;${log}&quot; \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                   --writepid &quot;${pid}&qu=
ot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
     --explicit-exit-notify 3</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    fi</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# Make server log files readable by norma=
l users</span><br><span style=3D"color: hsl(120, 100%, 40%);">+umask 022</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Lo=
ad base/default configuration</span><br><span> . &quot;${srcdir}/t_server_n=
ull_default.rc&quot; || exit 1</span><br><span> </span><br><span>@@ -64,15 =
+74,30 @@</span><br><span> </span><br><span> echo &quot;All clients have di=
sconnected from all servers&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# Make sure that the server processes are=
 truly dead before exiting.  If a</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# server process does not exit in 15 seconds assume it never =
will, move on and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
hope for the best.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+e=
cho &quot;Waiting for servers to exit&quot;</span><br><span> for PID_FILE i=
n $server_pid_files</span><br><span> do</span><br><span>     SERVER_PID=3D$=
(cat &quot;${PID_FILE}&quot;)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    $KILL_EXEC &quot;${SERVER_PID}&quot;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    # Make sure that the serve=
r processes are truly dead before exiting</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    while :</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        $KILL_EXEC &quot;${SERVER_PID}&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        $RUN_SUDO $KILL_E=
XEC &quot;${SERVER_PID}&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    count=3D0</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    maxcount=3D75</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    while [ $count -le $maxcou=
nt ]</span><br><span>     do</span><br><span>         ps -p &quot;${SERVER_=
PID}&quot; &gt; /dev/null || break</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        count=3D$(( count + 1))</span><br><span>         sle=
ep 0.2</span><br><span>     done</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 [ $count -ge $maxcount ]; then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        echo &quot;WARNING: could not kill server with pid ${SE=
RVER_PID}!&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 fi</span><br><span> done</span><br><span>diff --git a/tests/t_server_null_=
stress.sh b/tests/t_server_null_stress.sh</span><br><span>index 1281397..0b=
b9452 100755</span><br><span>--- a/tests/t_server_null_stress.sh</span><br>=
<span>+++ b/tests/t_server_null_stress.sh</span><br><span>@@ -1,4 +1,4 @@</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/usr/bin/env sh</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span=
> #</span><br><span> # Run this stress test as root to avoid sudo authoriza=
tion from timing out.</span><br><span> </span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/669?usp=3D=
email">change 669</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div it=
emscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2cce8ad4e0d262e1404ab1eb6ff=
673d8590b6b3a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 669 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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


--6BzEtOUxfkM=--

