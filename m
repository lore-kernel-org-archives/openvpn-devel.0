From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 7 Aug 2025 15:53:29 +0000
In-Reply-To: <gerrit.1754579268000.Ice8c7ff4d8118a9e6465a4724207a355138360b8@...2715...>
References: <gerrit.1754579268000.Ice8c7ff4d8118a9e6465a4724207a355138360b8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <809d7961e7471110745016662780b2773d51502d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z9K9Qf3OdGY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Z9K9Qf3OdGY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1139?usp=3Demail

to look at the new patch set (#2).


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
---
M tests/t_client.sh.in
1 file changed, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1139/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--Z9K9Qf3OdGY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1139?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">t_client.sh: Do not wait 3 seconds for OpenVPN to come up<br><br>=
On most machines 1 second should be quite enough. Given<br>that we run curr=
ently 23 tests on most t_client runs, this<br>makes over 40 seconds differe=
nce. Not nothing.<br><br>We keep the existing 30s maximum wait-time since s=
ometimes<br>we want to do tests with intentionally slow servers.<br><br>Cha=
nge-Id: Ice8c7ff4d8118a9e6465a4724207a355138360b8<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>---<br>M tests/t_client.sh.in<br>1 f=
ile changed, 3 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/39/1139/2</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tes=
ts/t_client.sh.in b/tests/t_client.sh.in</span><br><span>index 7a271b6..a49=
de40 100755</span><br><span>--- a/tests/t_client.sh.in</span><br><span>+++ =
b/tests/t_client.sh.in</span><br><span>@@ -377,13 +377,13 @@</span><br><spa=
n>     $RUN_SUDO &quot;${openvpn}&quot; $openvpn_conf &gt;&gt;$LOGDIR/$SUF:=
openvpn.log &amp;</span><br><span>     sudopid=3D$!</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Check if OpenVPN has =
initialized before continuing.  It will check every 3rd second up</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    # Check if OpenVPN has in=
itialized before continuing.  It will check every second up</span><br><span=
>     # to $ovpn_init_check times.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ovpn_init_check=3D10</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ovpn_init_check=3D30</span><br><span>     ovpn_init_s=
uccess=3D0</span><br><span>     while [ $ovpn_init_check -gt 0 ];</span><br=
><span>     do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
sleep 3  # Wait for OpenVPN to initialize and have had time to write the pi=
d file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       sleep =
1  # Wait for OpenVPN to initialize and have had time to write the pid file=
</span><br><span>        grep &quot;Initialization Sequence Completed&quot;=
 $LOGDIR/$SUF:openvpn.log &gt;/dev/null</span><br><span>        if [ $? -eq=
 0 ]; then</span><br><span>            ovpn_init_check=3D0</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1139?usp=3Demail">change 1139</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1139?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ice8c7ff4d8118a9e6465a472420=
7a355138360b8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1139 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Z9K9Qf3OdGY=--

