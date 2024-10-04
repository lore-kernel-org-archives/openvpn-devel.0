From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 4 Oct 2024 07:06:56 +0000
In-Reply-To: <gerrit.1728021778000.I49f1e7d25edb62bf202ffceb45dedc213f2eafdd@...2715...>
References: <gerrit.1728021778000.I49f1e7d25edb62bf202ffceb45dedc213f2eafdd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2d25c8e4f75f446f0907e971492eb978daad81f2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F4MVVrDEr3A="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_server_null:
 persist test log files
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

--F4MVVrDEr3A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mattock, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/776?usp=3Demail )

Change subject: t_server_null: persist test log files
......................................................................


Patch Set 1: Code-Review-1

(4 comments)

Patchset:

PS1:
needs a bit of polish


File tests/t_server_null_server.sh:

http://gerrit.openvpn.net/c/openvpn/+/776/comment/186bd796_c642bb4c :
PS1, Line 7:     log=3D"${server_name}.log"
maybe just do `log=3D"$t_server_null_logdir/$server_name.log"` here, to avo=
id having to repeat the "logdir" part below?


http://gerrit.openvpn.net/c/openvpn/+/776/comment/3986d2c5_84d97934 :
PS1, Line 12:         rm -f "${status}" "${log}" "${pid}"
I'd remove this line - at least removing ${log} is not serving a useful pur=
pose anymore, but also removing the other files is just "needless code" as =
OpenVPN will create them new anyway


http://gerrit.openvpn.net/c/openvpn/+/776/comment/52f6e109_1d63b541 :
PS1, Line 20:         $RUN_SUDO rm -f "${status}" "${log}" "${pid}"
same here



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49f1e7d25edb62bf202ffceb45dedc213f2eafdd
Gerrit-Change-Number: 776
Gerrit-PatchSet: 1
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-Comment-Date: Fri, 04 Oct 2024 07:06:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--F4MVVrDEr3A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mattock, plaisthos.=
 </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/776?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">needs a bit of polish</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File tests/t_server_null_server.sh:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/776/comment/186bd796_c642bb4c">Patch Set #1, Line 7:</=
a> <code style=3D"font-family:monospace,monospace">    log=3D&quot;${server=
_name}.log&quot;</code></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">maybe just do `log=3D&quot;$t_server_null_logdir/$server_name.lo=
g&quot;` here, to avoid having to repeat the &quot;logdir&quot; part below?=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/776/comment/3=
986d2c5_84d97934">Patch Set #1, Line 12:</a> <code style=3D"font-family:mon=
ospace,monospace">        rm -f &quot;${status}&quot; &quot;${log}&quot; &q=
uot;${pid}&quot;</code></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">I&#39;d remove this line - at least removing ${log} is not servi=
ng a useful purpose anymore, but also removing the other files is just &quo=
t;needless code&quot; as OpenVPN will create them new anyway</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/776/comment/52f6e109_1d63b54=
1">Patch Set #1, Line 20:</a> <code style=3D"font-family:monospace,monospac=
e">        $RUN_SUDO rm -f &quot;${status}&quot; &quot;${log}&quot; &quot;$=
{pid}&quot;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">same here</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/776?usp=3Demail">change 776</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/776?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I49f1e7d25edb62bf202ffceb45d=
edc213f2eafdd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 776 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 04 Oct 2024 07:06:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--F4MVVrDEr3A=--

