From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 24 Oct 2024 18:41:55 +0000
In-Reply-To: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
References: <gerrit.1728021620000.Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c84aaa274086dff947f0e594acf759039405c353-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fKz9OUlLyH8="; charset=UTF-8
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

--fKz9OUlLyH8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mattock, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/775?usp=3Demail )

Change subject: t_server_null: forcibly kill misbehaving servers
......................................................................


Patch Set 5: Code-Review-2

(2 comments)

Patchset:

PS5:
It fails to see "does the process still live?" due to `ps -p`, see comment =
at the corresponding line.  Changing that to `RUN_SUDO kill -0 $SERVER_PID =
2>/dev/null` yields the desired result (server hacked to maliciously ignore=
 SIGTERM 2x)

```
Waiting for servers to exit
ERROR: had to send SIGKILL to server with pid 10186!
ERROR: had to send SIGKILL to server with pid 10189!
FAIL: t_server_null.sh
```

now, while at it, we should actually print which server is "10186" and "101=
89" so it's easier to find the right log...


File tests/t_server_null_server.sh:

http://gerrit.openvpn.net/c/openvpn/+/775/comment/3af78b34_8263c5b3 :
PS5, Line 100:         ps -p "${SERVER_PID}" > /dev/null || break
this does not work on systems where root processes are not visible to norma=
l users, like "FreeBSD with `security.bsd.see_other_uids=3D0`" set.  We've =
been here before - testing for "does the process still live?" needs to be d=
one with `$RUN_SUDO kill -0 $SERVER_PID`



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0f98cd3b87a7b86e032e63167ac9036f7c08fcb
Gerrit-Change-Number: 775
Gerrit-PatchSet: 5
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-Comment-Date: Thu, 24 Oct 2024 18:41:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--fKz9OUlLyH8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mattock, plaisthos.=
 </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/775?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">It fails to see &quot;does the process still =
live?&quot; due to `ps -p`, see comment at the corresponding line.  Changin=
g that to `RUN_SUDO kill -0 $SERVER_PID 2&gt;/dev/null` yields the desired =
result (server hacked to maliciously ignore SIGTERM 2x)</p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">```<br>Waiting for servers to ex=
it<br>ERROR: had to send SIGKILL to server with pid 10186!<br>ERROR: had to=
 send SIGKILL to server with pid 10189!<br>FAIL: t_server_null.sh<br>```</p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">now, while at i=
t, we should actually print which server is &quot;10186&quot; and &quot;101=
89&quot; so it&#39;s easier to find the right log...</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File tests/t_server_null_server.sh:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/775/comment/3af78b34_8263c5b3">Patch Set #5, Line 100=
:</a> <code style=3D"font-family:monospace,monospace">        ps -p &quot;$=
{SERVER_PID}&quot; &gt; /dev/null || break</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">this does not work on systems where ro=
ot processes are not visible to normal users, like &quot;FreeBSD with `secu=
rity.bsd.see_other_uids=3D0`&quot; set.  We&#39;ve been here before - testi=
ng for &quot;does the process still live?&quot; needs to be done with `$RUN=
_SUDO kill -0 $SERVER_PID`</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/775?usp=3Demail">change 775</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/775?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic0f98cd3b87a7b86e032e63167a=
c9036f7c08fcb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 775 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 24 Oct 2024 18:41:55=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--fKz9OUlLyH8=--

