From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 3 Jul 2024 14:30:03 +0000
In-Reply-To: <gerrit.1718899574000.I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a@...2715...>
References: <gerrit.1718899574000.I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6d017ce98ea71f3bb18e2fd26fce9b9ca18a5622-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Cner5sCMnH0="; charset=UTF-8
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

--Cner5sCMnH0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mattock, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/669?usp=3Demail )

Change subject: t_server_null: multiple improvements and fixes
......................................................................


Patch Set 4: Code-Review-1

(1 comment)

Patchset:

PS4:
OK, so the NetBSD problem seems to be "umask"

 - when run from BB, the server processes are started (sudo openvpn...) jus=
t fine
 - the resulting PID file (and Log file) are 600
```
-rw-------  1 root      users       6 Jul  3 16:22 t_server_null_server-119=
4_udp.pid
-rw-------  1 root      users       5 Jul  3 16:22 t_server_null_server-119=
5_tcp.pid
-rw-------  1 root      users     227 Jul  3 16:24 t_server_null_server-119=
5_tcp.status
-rw-------  1 root      users    1991 Jul  3 16:24 t_server_null_server-119=
5_tcp.log
-rw-------  1 root      users     227 Jul  3 16:24 t_server_null_server-119=
4_udp.status
-rw-------  1 root      users    1824 Jul  3 16:24 t_server_null_server-119=
4_udp.log
```
 - some other element running as non-root cannot read the pid file, so assu=
mes "the server process must have been not started", and neither proceeds w=
ith the client
 - since "the server has not been started" it's not killed either, and on t=
he next run, the port is in use

My suggestion would be to add an `umask 022` to the script that starts the =
server processes (I do not feel like digging into "why does BB set 077, whe=
n the system default is 022", and it *will* bite someone else running from =
the CLI eventually)

Also, error handling, for "there is a file and I can't read it".



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
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-Comment-Date: Wed, 03 Jul 2024 14:30:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Cner5sCMnH0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mattock, plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/669?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">OK, so the NetBSD problem seems to be &quot;um=
ask&quot;</p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"> - when run from BB, the server processes are started (sudo openv=
pn...) just fine<br> - the resulting PID file (and Log file) are 600<br>```=
<br>-rw-------  1 root      users       6 Jul  3 16:22 t_server_null_server=
-1194_udp.pid<br>-rw-------  1 root      users       5 Jul  3 16:22 t_serve=
r_null_server-1195_tcp.pid<br>-rw-------  1 root      users     227 Jul  3 =
16:24 t_server_null_server-1195_tcp.status<br>-rw-------  1 root      users=
    1991 Jul  3 16:24 t_server_null_server-1195_tcp.log<br>-rw-------  1 ro=
ot      users     227 Jul  3 16:24 t_server_null_server-1194_udp.status<br>=
-rw-------  1 root      users    1824 Jul  3 16:24 t_server_null_server-119=
4_udp.log<br>```<br> - some other element running as non-root cannot read t=
he pid file, so assumes &quot;the server process must have been not started=
&quot;, and neither proceeds with the client<br> - since &quot;the server h=
as not been started&quot; it&#39;s not killed either, and on the next run, =
the port is in use<br> <br>My suggestion would be to add an `umask 022` to =
the script that starts the server processes (I do not feel like digging int=
o &quot;why does BB set 077, when the system default is 022&quot;, and it *=
will* bite someone else running from the CLI eventually)</pre><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Also, error handling, for &qu=
ot;there is a file and I can&#39;t read it&quot;.</p></li></ul></li></ul><p=
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
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 03 Jul 2024 14:30:03=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Cner5sCMnH0=--

