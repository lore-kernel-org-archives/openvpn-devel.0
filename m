From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 8 Aug 2025 05:58:29 +0000
In-Reply-To: <gerrit.1754579268000.Ice8c7ff4d8118a9e6465a4724207a355138360b8@...2715...>
References: <gerrit.1754579268000.Ice8c7ff4d8118a9e6465a4724207a355138360b8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <44115989071d65dcba02428137874eba5fa3fccb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R6aCMgQYfuk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.sh: Do not
 wait 3 seconds for OpenVPN to come up
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--R6aCMgQYfuk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
39?usp=3Demail )

Change subject: t_client.sh: Do not wait 3 seconds for OpenVPN to come up
......................................................................

t_client.sh: Do not wait 3 seconds for OpenVPN to come up

On most machines 1 second should be quite enough. Given
that we run currently 23 tests on most t_client runs, this
makes over 40 seconds difference. Not nothing.

We keep the existing 30s maximum wait-time since sometimes
we want to do tests with intentionally slow servers.

Change-Id: Ice8c7ff4d8118a9e6465a4724207a355138360b8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250807203741.31359-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
585.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/t_client.sh.in
1 file changed, 3 insertions(+), 3 deletions(-)




diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 7a271b6..a49de40 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -377,13 +377,13 @@
     $RUN_SUDO "${openvpn}" $openvpn_conf >>$LOGDIR/$SUF:openvpn.log &
     sudopid=3D$!

-    # Check if OpenVPN has initialized before continuing.  It will check e=
very 3rd second up
+    # Check if OpenVPN has initialized before continuing.  It will check e=
very second up
     # to $ovpn_init_check times.
-    ovpn_init_check=3D10
+    ovpn_init_check=3D30
     ovpn_init_success=3D0
     while [ $ovpn_init_check -gt 0 ];
     do
-       sleep 3  # Wait for OpenVPN to initialize and have had time to writ=
e the pid file
+       sleep 1  # Wait for OpenVPN to initialize and have had time to writ=
e the pid file
        grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn.log >=
/dev/null
        if [ $? -eq 0 ]; then
            ovpn_init_check=3D0

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1139?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ice8c7ff4d8118a9e6465a4724207a355138360b8
Gerrit-Change-Number: 1139
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--R6aCMgQYfuk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1139?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">t_client.sh: Do not wait 3 seconds for OpenVP=
N to come up<br><br>On most machines 1 second should be quite enough. Given=
<br>that we run currently 23 tests on most t_client runs, this<br>makes ove=
r 40 seconds difference. Not nothing.<br><br>We keep the existing 30s maxim=
um wait-time since sometimes<br>we want to do tests with intentionally slow=
 servers.<br><br>Change-Id: Ice8c7ff4d8118a9e6465a4724207a355138360b8<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert D=
oering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250807203741.31359-1-ge=
rt@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg32585.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M tests/t_client.sh.in<br>1 file changed, 3 insertions(=
+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in</span><br><span=
>index 7a271b6..a49de40 100755</span><br><span>--- a/tests/t_client.sh.in</=
span><br><span>+++ b/tests/t_client.sh.in</span><br><span>@@ -377,13 +377,1=
3 @@</span><br><span>     $RUN_SUDO &quot;${openvpn}&quot; $openvpn_conf &g=
t;&gt;$LOGDIR/$SUF:openvpn.log &amp;</span><br><span>     sudopid=3D$!</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Ch=
eck if OpenVPN has initialized before continuing.  It will check every 3rd =
second up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Chec=
k if OpenVPN has initialized before continuing.  It will check every second=
 up</span><br><span>     # to $ovpn_init_check times.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ovpn_init_check=3D10</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ovpn_init_check=3D30</span><br><sp=
an>     ovpn_init_success=3D0</span><br><span>     while [ $ovpn_init_check=
 -gt 0 ];</span><br><span>     do</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-       sleep 3  # Wait for OpenVPN to initialize and have had t=
ime to write the pid file</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+       sleep 1  # Wait for OpenVPN to initialize and have had time to=
 write the pid file</span><br><span>        grep &quot;Initialization Seque=
nce Completed&quot; $LOGDIR/$SUF:openvpn.log &gt;/dev/null</span><br><span>=
        if [ $? -eq 0 ]; then</span><br><span>            ovpn_init_check=
=3D0</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1139?usp=3Demail">change 1139</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1139?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ice8c7ff4d8118a9e6465a472420=
7a355138360b8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1139 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--R6aCMgQYfuk=--

