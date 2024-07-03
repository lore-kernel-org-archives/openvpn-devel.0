From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 3 Jul 2024 14:13:57 +0000
In-Reply-To: <gerrit.1718899574000.I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a@...2715...>
References: <gerrit.1718899574000.I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1a1875dfd16848ca46a76980dbf713398b98fcc6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9IAosoQEaow="; charset=UTF-8
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
To: mattock <samuli@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9IAosoQEaow=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mattock, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/669?usp=3Demail )

Change subject: t_server_null: multiple improvements and fixes
......................................................................


Patch Set 4:

(1 comment)

Patchset:

PS4:
So this works on FreeBSD and OpenBSD (great), while on NetBSD it works *som=
etimes*, and then it fails to start servers again because the old servers a=
re still running.

When it does not work, the error message could use some improvement

```
make  check-TESTS
./t_server_null.sh: sudo /bin/kill -0 succeeded, good.
OpenVPN test servers up: 0/       2
OpenVPN test servers up: 0/       2
OpenVPN test servers up: 0/       2
OpenVPN test servers up: 0/       2
OpenVPN test servers up: 0/       2
OpenVPN test servers up: 0/       2
All clients have disconnected from all servers
Waiting for servers to exit
cat: ./t_server_null_server-1194_udp.pid: No such file or directory
Terminated
[1]   Terminated              ("${@}" 2>&1; es... | tee -a "${log_fi...
```

(like, showing a "tail -f" of the server logs? - which are root-owned and m=
ode 0600, so not trivial.  Why are they 0600 anyway, is there an explicit u=
mask call?)

Not sure why the processes got stuck.  When running from the CLI the server=
s are properly terminated...  need to re-test from buildbot.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a
Gerrit-Change-Number: 669
Gerrit-PatchSet: 4
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-Comment-Date: Wed, 03 Jul 2024 14:13:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--9IAosoQEaow=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mattock, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/6=
69?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">So this works on FreeBSD and OpenBSD (great), whil=
e on NetBSD it works *sometimes*, and then it fails to start servers again =
because the old servers are still running.</p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">When it does not work, the error message coul=
d use some improvement</p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">```<br>make  check-TESTS<br>./t_server_null.sh: sudo /bin/kill -0=
 succeeded, good.<br>OpenVPN test servers up: 0/       2<br>OpenVPN test se=
rvers up: 0/       2<br>OpenVPN test servers up: 0/       2<br>OpenVPN test=
 servers up: 0/       2<br>OpenVPN test servers up: 0/       2<br>OpenVPN t=
est servers up: 0/       2<br>All clients have disconnected from all server=
s<br>Waiting for servers to exit<br>cat: ./t_server_null_server-1194_udp.pi=
d: No such file or directory<br>Terminated <br>[1]   Terminated            =
  (&quot;${@}&quot; 2&gt;&amp;1; es... | tee -a &quot;${log_fi...<br>```</p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">(like, showing =
a &quot;tail -f&quot; of the server logs? - which are root-owned and mode 0=
600, so not trivial.  Why are they 0600 anyway, is there an explicit umask =
call?)</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Not su=
re why the processes got stuck.  When running from the CLI the servers are =
properly terminated...  need to re-test from buildbot.</p></li></ul></li></=
ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/669?u=
sp=3Demail">change 669</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2cce8ad4e0d262e1404ab1eb6ff=
673d8590b6b3a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 669 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 03 Jul 2024 14:13:57=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--9IAosoQEaow=--

