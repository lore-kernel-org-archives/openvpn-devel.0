From: "mattock (Code Review)" <gerrit@...515...>
Date: Thu, 20 Jun 2024 16:06:16 +0000
References: <gerrit.1718899574000.I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4711ccb96b777449406ef34ee3d2e6a27aeaf9e8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vcVWOvYfm34="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vcVWOvYfm34=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail

to review the following change.


Change subject: t_server_null: multiple improvements and fixes
......................................................................

t_server_null: multiple improvements and fixes

- exit after a timeout if unable to kill servers
- use sudo or equivalent only for server stop/start
- use /bin/sh directly instead of through /usr/bin/env
- simplify sudo call in the sample rc file
- remove misleading and outdated documentation

Change-Id: I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a
Signed-off-by: Samuli Sepp=C3=A4nen <samuli.seppanen@...277...>
---
M doc/t_server_null.rst
M tests/t_server_null.rc-sample
M tests/t_server_null.sh
M tests/t_server_null_client.sh
M tests/t_server_null_server.sh
M tests/t_server_null_stress.sh
6 files changed, 41 insertions(+), 32 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/69/669/1

diff --git a/doc/t_server_null.rst b/doc/t_server_null.rst
index e3a098a..7ce7a3f 100644
--- a/doc/t_server_null.rst
+++ b/doc/t_server_null.rst
@@ -73,13 +73,6 @@

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
index 8890007..3b7dc6d 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env sh
+#!/bin/sh

 launch_client() {
     test_name=3D$1
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index 9bc0c88..037baf7 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/env sh
+#!/bin/sh

 launch_server() {
     server_name=3D$1
@@ -8,16 +8,23 @@
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

 # Load base/default configuration
@@ -64,15 +71,30 @@

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
Gerrit-PatchSet: 1
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--vcVWOvYfm34=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mattock would like plaisthos and flichtenheld to <strong>review</strong>=
 this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">t_server_null: multiple improvements and fixes<br><br>- exit =
after a timeout if unable to kill servers<br>- use sudo or equivalent only =
for server stop/start<br>- use /bin/sh directly instead of through /usr/bin=
/env<br>- simplify sudo call in the sample rc file<br>- remove misleading a=
nd outdated documentation<br><br>Change-Id: I2cce8ad4e0d262e1404ab1eb6ff673=
d8590b6b3a<br>Signed-off-by: Samuli Sepp=C3=A4nen &lt;samuli.seppanen@...1664...=
7...&gt;<br>---<br>M doc/t_server_null.rst<br>M tests/t_server_null.rc-samp=
le<br>M tests/t_server_null.sh<br>M tests/t_server_null_client.sh<br>M test=
s/t_server_null_server.sh<br>M tests/t_server_null_stress.sh<br>6 files cha=
nged, 41 insertions(+), 32 deletions(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/69/669/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/t_ser=
ver_null.rst b/doc/t_server_null.rst</span><br><span>index e3a098a..7ce7a3f=
 100644</span><br><span>--- a/doc/t_server_null.rst</span><br><span>+++ b/d=
oc/t_server_null.rst</span><br><span>@@ -73,13 +73,6 @@</span><br><span> </=
span><br><span>       * Waits until servers have launched. Then launch all =
clients, wait for them to exit and then check test results by parsing the c=
lient log files. Each client kills itself after some delay using an &quot;-=
-up&quot; script.</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-Note that &quot;make check&quot; moves on once *t_server_null=
_client.sh* has exited. At</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-that point *t_server_null_server.sh* is still running, because it exis=
ts only</span><br><span style=3D"color: hsl(0, 100%, 40%);">-after waiting =
a few seconds for more client connections to potentially appear.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-This is a feature and not a bug,=
 but means that launching &quot;make check&quot; runs too</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-quickly might cause test failures or un=
expected behavior such as leftover</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-OpenVPN server processes.</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> Configuration</span><br><span> ---------=
----</span><br><span> </span><br><span>diff --git a/tests/t_server_null.rc-=
sample b/tests/t_server_null.rc-sample</span><br><span>index 28c3773..98d78=
69 100644</span><br><span>--- a/tests/t_server_null.rc-sample</span><br><sp=
an>+++ b/tests/t_server_null.rc-sample</span><br><span>@@ -1,6 +1,5 @@</spa=
n><br><span> # Uncomment to run tests with sudo</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#SUDO_EXEC=3D`which sudo`</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#RUN_SUDO=3D&quot;${SUDO_EXEC} -E&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#RUN_SUDO=3D&quot;sudo =
-E&quot;</span><br><span> </span><br><span> TEST_RUN_LIST=3D&quot;1 2 3 10 =
11&quot;</span><br><span> </span><br><span>diff --git a/tests/t_server_null=
.sh b/tests/t_server_null.sh</span><br><span>index 0e53ba4..7627edf 100755<=
/span><br><span>--- a/tests/t_server_null.sh</span><br><span>+++ b/tests/t_=
server_null.sh</span><br><span>@@ -1,4 +1,4 @@</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#!/usr/bin/env sh</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span> #</span><br><span> TSERVE=
R_NULL_SKIP_RC=3D&quot;${TSERVER_NULL_SKIP_RC:-77}&quot;</span><br><span> <=
/span><br><span>@@ -57,12 +57,7 @@</span><br><span> </span><br><span> srcdi=
r=3D&quot;${srcdir:-.}&quot;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    &quot;${srcdir}/t_server_nul=
l_server.sh&quot; &amp;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    $RUN_SUDO &=
quot;${srcdir}/t_server_null_server.sh&quot; &amp;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;${s=
rcdir}/t_server_null_server.sh&quot; &amp;</span><br><span> &quot;${srcdir}=
/t_server_null_client.sh&quot;</span><br><span> retval=3D$?</span><br><span=
> </span><br><span>diff --git a/tests/t_server_null_client.sh b/tests/t_ser=
ver_null_client.sh</span><br><span>index 8890007..3b7dc6d 100755</span><br>=
<span>--- a/tests/t_server_null_client.sh</span><br><span>+++ b/tests/t_ser=
ver_null_client.sh</span><br><span>@@ -1,4 +1,4 @@</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#!/usr/bin/env sh</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span> </span><br><span> lau=
nch_client() {</span><br><span>     test_name=3D$1</span><br><span>diff --g=
it a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh</span><b=
r><span>index 9bc0c88..037baf7 100755</span><br><span>--- a/tests/t_server_=
null_server.sh</span><br><span>+++ b/tests/t_server_null_server.sh</span><b=
r><span>@@ -1,4 +1,4 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#!/usr/bin/env sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#!/bin/sh</span><br><span> </span><br><span> launch_server() {</span><br><s=
pan>     server_name=3D$1</span><br><span>@@ -8,16 +8,23 @@</span><br><span=
>     status=3D&quot;${server_name}.status&quot;</span><br><span>     pid=
=3D&quot;${server_name}.pid&quot;</span><br><span> </span><br><span style=
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
, 40%);">+    fi</span><br><span> }</span><br><span> </span><br><span> # Lo=
ad base/default configuration</span><br><span>@@ -64,15 +71,30 @@</span><br=
><span> </span><br><span> echo &quot;All clients have disconnected from all=
 servers&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# Make sure that the server processes are truly dead before ex=
iting.  If a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# serve=
r process does not exit in 15 seconds assume it never will, move on and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# hope for the best.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+echo &quot;Waiting for=
 servers to exit&quot;</span><br><span> for PID_FILE in $server_pid_files</=
span><br><span> do</span><br><span>     SERVER_PID=3D$(cat &quot;${PID_FILE=
}&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    $KILL_EXE=
C &quot;${SERVER_PID}&quot;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    # Make sure that the server processes are truly=
 dead before exiting</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   while :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ =
-z &quot;${RUN_SUDO}&quot; ]; then</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        $KILL_EXEC &quot;${SERVER_PID}&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        $RUN_SUDO $KILL_EXEC &quot;${SERVER_PI=
D}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    count=3D0</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    maxcount=3D75</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    while [ $count -le $maxcount ]</span><br><spa=
n>     do</span><br><span>         ps -p &quot;${SERVER_PID}&quot; &gt; /de=
v/null || break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    count=3D$(( count + 1))</span><br><span>         sleep 0.2</span><br><s=
pan>     done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ $count -ge $maxc=
ount ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 echo &quot;WARNING: could not kill server with pid ${SERVER_PID}!&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span=
> done</span><br><span>diff --git a/tests/t_server_null_stress.sh b/tests/t=
_server_null_stress.sh</span><br><span>index 1281397..0bb9452 100755</span>=
<br><span>--- a/tests/t_server_null_stress.sh</span><br><span>+++ b/tests/t=
_server_null_stress.sh</span><br><span>@@ -1,4 +1,4 @@</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#!/usr/bin/env sh</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span> #</span><br><span=
> # Run this stress test as root to avoid sudo authorization from timing ou=
t.</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail">change 669</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/669?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2cce8ad4e0d262e1404ab1eb6ff=
673d8590b6b3a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 669 </div>
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


--vcVWOvYfm34=--

