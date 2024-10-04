From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 4 Oct 2024 07:09:11 +0000
References: <gerrit.1728025749000.I7e5ac9b4a8594251c3b5c4655f9d74b021950098@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9da209bed85d709b06f7bb579e65937db12a86aa-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hxhoOXYyMNk="; charset=UTF-8
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

--hxhoOXYyMNk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/777?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/777/1

diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index 10bb44b..bcbd002 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -8,6 +8,10 @@
     status=3D"${server_name}.status"
     pid=3D"${server_name}.pid"

+    # limit CPU time of processes to "5 minutes"
+    # (so a stuck-and-looping process will auto-terminate)
+    ulimit -t 300
+
     if [ -z "${RUN_SUDO}" ]; then
         rm -f "${status}" "${log}" "${pid}"
         "${server_exec}" \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/777?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098
Gerrit-Change-Number: 777
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--hxhoOXYyMNk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/777?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">t_server_null: run server processes with &#39;ulimit -t 300&#=
39;<br><br>&quot;ulimit -t&quot; will hard limit the usable CPU time for an=
y process started<br>to the specified number of seconds.  So if we have a s=
tuck-and-looping<br>server process (which was observed frequently) this wil=
l make sure<br>the situation will fix itself eventually.<br><br>Change-Id: =
I7e5ac9b4a8594251c3b5c4655f9d74b021950098<br>---<br>M tests/t_server_null_s=
erver.sh<br>1 file changed, 4 insertions(+), 0 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/777/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh</s=
pan><br><span>index 10bb44b..bcbd002 100755</span><br><span>--- a/tests/t_s=
erver_null_server.sh</span><br><span>+++ b/tests/t_server_null_server.sh</s=
pan><br><span>@@ -8,6 +8,10 @@</span><br><span>     status=3D&quot;${server=
_name}.status&quot;</span><br><span>     pid=3D&quot;${server_name}.pid&quo=
t;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    # limit CPU time of processes to &quot;5 minutes&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    # (so a stuck-and-looping proce=
ss will auto-terminate)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ulimit -t 300</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     if [ -z &quot;${RUN_SUDO}&quot; ]; then</span><br><=
span>         rm -f &quot;${status}&quot; &quot;${log}&quot; &quot;${pid}&q=
uot;</span><br><span>         &quot;${server_exec}&quot; \</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/777?usp=3Demail">change 777</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/777?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7e5ac9b4a8594251c3b5c4655f9=
d74b021950098 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 777 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--hxhoOXYyMNk=--

