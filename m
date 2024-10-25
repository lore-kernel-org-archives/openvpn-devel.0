From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 25 Oct 2024 09:02:19 +0000
In-Reply-To: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
References: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e4747663a14ae8194e09814d1a54ec6475322253-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uMQbXLmIPtQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_server_null:
 forcibly kill misbehaving servers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mattock <samuli@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uMQbXLmIPtQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mattock, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/775?usp=3Demail )

Change subject: t_server_null: forcibly kill misbehaving servers
......................................................................


Patch Set 8: Code-Review-2

(4 comments)

Patchset:

PS8:
getting closer


File tests/t_server_null.sh:

http://gerrit.openvpn.net/c/openvpn/+/775/comment/eede43c8_d60b792c :
PS8, Line 72: wait
remembering the pid of the t_server_null_server.sh job after launching (`se=
rver_sh_pid=3D$!`) and then calling `wait $server_sh_pid` will nicely deliv=
er child program exit status in `$!`, without having to dance around with a=
n extra file that needs to be created, rc-filed, tested-for.

`wait` without a pid specified does not return child return code, which is =
somewhat annoying.


File tests/t_server_null_server.sh:

http://gerrit.openvpn.net/c/openvpn/+/775/comment/ea5470ba_cd74abb4 :
PS3, Line 106:     fi
> I think we should make this a "test fail". [=E2=80=A6]
Done


File tests/t_server_null_server.sh:

http://gerrit.openvpn.net/c/openvpn/+/775/comment/81b60a59_9f45dafb :
PS8, Line 110:         tail -n 20 "${t_server_null_logdir}/${SERVER_NAME}.l=
og"
this wants a `$RUN_SUDO` because root-owned logs are not readable otherwise=
 (or we need to precreate them before openvpn startup)...

```
Waiting for servers to exit
ERROR: had to send SIGKILL to server t_server_null_server-1194_udp with pid=
 23977!
Tail of server log:
tail: t_server_null-fbsd14bb.ov.greenie.net-20241025-105632/t_server_null_s=
erver-1194_udp.log: Permission denied
ERROR: had to send SIGKILL to server t_server_null_server-1195_tcp with pid=
 23983!
Tail of server log:
tail: t_server_null-fbsd14bb.ov.greenie.net-20241025-105632/t_server_null_s=
erver-1195_tcp.log: Permission denied
FAIL: t_server_null.sh
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb
Gerrit-Change-Number: 775
Gerrit-PatchSet: 8
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-Comment-Date: Fri, 25 Oct 2024 09:02:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--uMQbXLmIPtQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mattock, plaisthos.=
 </p>
<p>Patch set 8:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/775?tab=3Dcomments">Patch Set #8:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">getting closer</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File tests/t_server_null.sh:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/775/comment/eede43c8_d60b792c">Patch Set #8, Line 72:</a> <code styl=
e=3D"font-family:monospace,monospace">wait</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">remembering the pid of the t_server_nu=
ll_server.sh job after launching (`server_sh_pid=3D$!`) and then calling `w=
ait $server_sh_pid` will nicely deliver child program exit status in `$!`, =
without having to dance around with an extra file that needs to be created,=
 rc-filed, tested-for.</p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">`wait` without a pid specified does not return child return code,=
 which is somewhat annoying.</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File tests/t_server_null_server.sh:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
75/comment/ea5470ba_cd74abb4">Patch Set #3, Line 106:</a> <code style=3D"fo=
nt-family:monospace,monospace">    fi</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I think we shou=
ld make this a &quot;test fail&quot;. [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File tests/t_server_null_server.sh:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/775/comment/81b60a59_9f45dafb">Patch Set #8, Line =
110:</a> <code style=3D"font-family:monospace,monospace">        tail -n 20=
 &quot;${t_server_null_logdir}/${SERVER_NAME}.log&quot;</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">this wants a `$RUN_SUDO`=
 because root-owned logs are not readable otherwise (or we need to precreat=
e them before openvpn startup)...</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">```<br>Waiting for servers to exit<br>ERROR: had to se=
nd SIGKILL to server t_server_null_server-1194_udp with pid 23977!<br>Tail =
of server log:<br>tail: t_server_null-fbsd14bb.ov.greenie.net-20241025-1056=
32/t_server_null_server-1194_udp.log: Permission denied<br>ERROR: had to se=
nd SIGKILL to server t_server_null_server-1195_tcp with pid 23983!<br>Tail =
of server log:<br>tail: t_server_null-fbsd14bb.ov.greenie.net-20241025-1056=
32/t_server_null_server-1195_tcp.log: Permission denied<br>FAIL: t_server_n=
ull.sh<br>```</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/775?usp=3Demail">change 775</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/775?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic0f98cd3b87a7b86e032e63167a=
c9036f7c08fcb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 775 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 25 Oct 2024 09:02:19=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--uMQbXLmIPtQ=--

