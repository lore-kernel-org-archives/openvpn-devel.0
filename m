From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 3 Nov 2024 20:19:01 +0000
In-Reply-To: <gerrit.1728025749000.I7e5ac9b4a8594251c3b5c4655f9d74b021950098@...2715...>
References: <gerrit.1728025749000.I7e5ac9b4a8594251c3b5c4655f9d74b021950098@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ffe212c2fc57cc9604da0a21b11cbb2ce7600a3c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nZtxW8mYJ4w="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_server_null: run
 server processes with 'ulimit -t 300'
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

--nZtxW8mYJ4w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/777?usp=3Demail

to look at the new patch set (#2).


Change subject: t_server_null: run server processes with 'ulimit -t 300'
......................................................................

t_server_null: run server processes with 'ulimit -t 300'

"ulimit -t" will hard limit the usable CPU time for any process started
to the specified number of seconds.  So if we have a stuck-and-looping
server process (which was observed frequently) this will make sure
the situation will fix itself eventually.

Change-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098
---
M tests/t_server_null_server.sh
1 file changed, 4 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/777/2

diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index acf8479..40ce94b 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -11,6 +11,10 @@
     # Allow reading this file even umask values are strict
     touch "$log"

+    # limit CPU time of processes to "5 minutes"
+    # (so a stuck-and-looping process will auto-terminate)
+    ulimit -t 300
+
     if [ -z "${RUN_SUDO}" ]; then
         "${server_exec}" \
          $server_conf \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/777?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098
Gerrit-Change-Number: 777
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--nZtxW8mYJ4w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/777?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">t_server_null: run server processes with &#39;ulimit -t 300&#39;<br><br>&=
quot;ulimit -t&quot; will hard limit the usable CPU time for any process st=
arted<br>to the specified number of seconds.  So if we have a stuck-and-loo=
ping<br>server process (which was observed frequently) this will make sure<=
br>the situation will fix itself eventually.<br><br>Change-Id: I7e5ac9b4a85=
94251c3b5c4655f9d74b021950098<br>---<br>M tests/t_server_null_server.sh<br>=
1 file changed, 4 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/77/777/2</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/t=
ests/t_server_null_server.sh b/tests/t_server_null_server.sh</span><br><spa=
n>index acf8479..40ce94b 100755</span><br><span>--- a/tests/t_server_null_s=
erver.sh</span><br><span>+++ b/tests/t_server_null_server.sh</span><br><spa=
n>@@ -11,6 +11,10 @@</span><br><span>     # Allow reading this file even um=
ask values are strict</span><br><span>     touch &quot;$log&quot;</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # limit=
 CPU time of processes to &quot;5 minutes&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    # (so a stuck-and-looping process will auto=
-terminate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ulim=
it -t 300</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br><span>       =
  &quot;${server_exec}&quot; \</span><br><span>          $server_conf \</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/777?usp=3Demail">change 777</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/777?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7e5ac9b4a8594251c3b5c4655f9=
d74b021950098 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 777 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--nZtxW8mYJ4w=--

