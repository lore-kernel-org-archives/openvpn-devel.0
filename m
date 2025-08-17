From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 17 Aug 2025 16:24:32 +0000
In-Reply-To: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
References: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <10c44cd8ce1eda594aadaafa2eed04880e20f836-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lG8b/lYFmjQ="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE message
 sender: enabling the server to send PUSH_UPDATE c...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lG8b/lYFmjQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/869?usp=3Demail )

Change subject: PUSH_UPDATE message sender: enabling the server to send PUS=
H_UPDATE control messages
......................................................................


Patch Set 23: Code-Review-2

(2 comments)

Patchset:

PS23:
There's two things that need fixing - one is a (trivial) rebase accident in=
 manage.c (and please check if there are more of them).

The other is a lack of robustness on invalid pushed options on the server s=
ide - that is, you do on the management interface

```
push-update-broad blab
SUCCESS: 1 client(s) updated
SUCCESS: push-update command succeeded
```

(so it claims "success") but what really happens is "the full server restar=
ts"

```
Aug 17 18:11:40 gentoo tun-udp-p2mp[4243]: MANAGEMENT: CMD 'push-update-cid=
 20 -dns'
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: MANAGEMENT: CMD 'push-update-bro=
ad blab'
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: SENT CONTROL [cron2-freebsd-tc-a=
md64]: 'PUSH_UPDATE,blab' (status=3D1)
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: Pushed option is not updatable: =
'blab'. Restarting.
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: Failed to process push update me=
ssage sent to client ID: 0
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/UDP: Closing socket
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/UDP: Close Socket failed: Ba=
d file descriptor (errno=3D9)
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/UDP: Closing socket
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/UDP: Closing socket
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/UDP: Closing socket
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/UDP: Closing socket
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/UDP: Closing socket
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: SIGUSR1[soft,Offending option re=
ceived from server] received, process restarting
Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: Restart pause, 1 second(s)
```

it should not do that, but give an error on the management interface instea=
d.

If pushing "correct" stuff it works, even if the timing is a bit odd

server:
```
Aug 17 18:16:01 gentoo tun-udp-p2mp[4243]: MANAGEMENT: CMD 'push-update-bro=
ad "route 10.204.0.0 255.255.240.0"'
```

client

```
2025-08-17 18:16:12 PUSH: Received control message: 'PUSH_UPDATE,route 10.2=
04.0.0 255.255.240.0'
```

so it took 11 seconds for the message to actually get out (clocks are in sy=
nc, and this is observable, so not a "clocks are wrong" artefact).


There is something else that isn't right with pushing ifconfigs, but maybe =
I am doing it wrong

```
push-update-cid 2 "ifconfig 10.204.2.46 10.204.2.45"
SUCCESS: 1 client(s) updated
```

client does new ifconfig.  Ping server gives

```
Aug 17 18:20:08 gentoo tun-udp-p2mp[4243]: cron2-freebsd-tc-amd64/udp6:194.=
97.140.21:14092 MULTI: bad source address from client [10.204.2.46], packet=
 dropped
```

so the client is using the correct source IP, but the server has not learne=
d it.

The server claims it has, though

```
Aug 17 18:19:54 gentoo tun-udp-p2mp[4243]: MULTI: Learn: 10.204.2.46/0 -> c=
ron2-freebsd-tc-amd64/udp6:194.97.140.21:14092
```

The /0 is a bit suspicious, for "regular" learning it prints

```
Aug 17 18:17:32 gentoo tun-udp-p2mp[4243]: MULTI: Learn: 10.204.2.6 -> cron=
2-freebsd-tc-amd64/udp6:194.97.140.21:14092
```

For IPv6 it does not work either

```
Aug 17 18:23:37 gentoo tun-udp-p2mp[4243]: SENT CONTROL [cron2-freebsd-tc-a=
md64]: 'PUSH_UPDATE,ifconfig-ipv6 fd00:abcd:204:2::9a9a/64 fd00:abcd:204:2:=
:1' (status=3D1)
Aug 17 18:23:37 gentoo tun-udp-p2mp[4243]: MULTI: Learn: ::/0 -> cron2-free=
bsd-tc-amd64/udp6:194.97.140.21:14092
Aug 17 18:23:46 gentoo tun-udp-p2mp[4243]: cron2-freebsd-tc-amd64/udp6:194.=
97.140.21:14092 MULTI: bad source address from client [fd00:abcd:204:2::9a9=
a], packet dropped
```

why ::/0 ?!?


File src/openvpn/manage.c:

http://gerrit.openvpn.net/c/openvpn/+/869/comment/9d6db2f0_20959fe8 :
PS23, Line 136:     msg(M_CLIENT, "version [n]            : Set client's ve=
rsion to n or show current version of daemon.");
Unfortunately a rebase accident has happened here, and now this line is pri=
nted twice.  While trivial to correct, project rules require that I do not =
do code-changes on merge.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc
Gerrit-Change-Number: 869
Gerrit-PatchSet: 23
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Sun, 17 Aug 2025 16:24:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--lG8b/lYFmjQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos, s=
tipa. </p>
<p>Patch set 23:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/869?tab=3Dcomments">Patch Set #23:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">There&#39;s two things that need fixing - o=
ne is a (trivial) rebase accident in manage.c (and please check if there ar=
e more of them).</p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">The other is a lack of robustness on invalid pushed options on the serv=
er side - that is, you do on the management interface</p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">```<br>push-update-broad blab<br>S=
UCCESS: 1 client(s) updated<br>SUCCESS: push-update command succeeded<br>``=
`</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">(so it clai=
ms &quot;success&quot;) but what really happens is &quot;the full server re=
starts&quot;</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
```<br>Aug 17 18:11:40 gentoo tun-udp-p2mp[4243]: MANAGEMENT: CMD &#39;push=
-update-cid 20 -dns&#39;<br>Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: MANA=
GEMENT: CMD &#39;push-update-broad blab&#39;<br>Aug 17 18:11:46 gentoo tun-=
udp-p2mp[4243]: SENT CONTROL [cron2-freebsd-tc-amd64]: &#39;PUSH_UPDATE,bla=
b&#39; (status=3D1)<br>Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: Pushed op=
tion is not updatable: &#39;blab&#39;. Restarting.<br>Aug 17 18:11:46 gento=
o tun-udp-p2mp[4243]: Failed to process push update message sent to client =
ID: 0<br>Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/UDP: Closing socket=
<br>Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/UDP: Close Socket failed=
: Bad file descriptor (errno=3D9)<br>Aug 17 18:11:46 gentoo tun-udp-p2mp[42=
43]: TCP/UDP: Closing socket<br>Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: =
TCP/UDP: Closing socket<br>Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/U=
DP: Closing socket<br>Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/UDP: C=
losing socket<br>Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: TCP/UDP: Closin=
g socket<br>Aug 17 18:11:46 gentoo tun-udp-p2mp[4243]: SIGUSR1[soft,Offendi=
ng option received from server] received, process restarting<br>Aug 17 18:1=
1:46 gentoo tun-udp-p2mp[4243]: Restart pause, 1 second(s)<br>```</p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">it should not do that,=
 but give an error on the management interface instead.</p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">If pushing &quot;correct&quot; s=
tuff it works, even if the timing is a bit odd</p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">server:<br>```<br>Aug 17 18:16:01 gentoo =
tun-udp-p2mp[4243]: MANAGEMENT: CMD &#39;push-update-broad &quot;route 10.2=
04.0.0 255.255.240.0&quot;&#39;<br>```</p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">client</p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">```<br>2025-08-17 18:16:12 PUSH: Received control messa=
ge: &#39;PUSH_UPDATE,route 10.204.0.0 255.255.240.0&#39;<br>```</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">so it took 11 seconds fo=
r the message to actually get out (clocks are in sync, and this is observab=
le, so not a &quot;clocks are wrong&quot; artefact).</p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;"><br>There is something else that is=
n&#39;t right with pushing ifconfigs, but maybe I am doing it wrong</p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>push-update-c=
id 2 &quot;ifconfig 10.204.2.46 10.204.2.45&quot;<br>SUCCESS: 1 client(s) u=
pdated<br>```</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>client does new ifconfig.  Ping server gives</p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">```<br>Aug 17 18:20:08 gentoo tun-udp-p2mp=
[4243]: cron2-freebsd-tc-amd64/udp6:194.97.140.21:14092 MULTI: bad source a=
ddress from client [10.204.2.46], packet dropped<br>```</p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">so the client is using the corre=
ct source IP, but the server has not learned it.</p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">The server claims it has, though</p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>Aug 17 18:19=
:54 gentoo tun-udp-p2mp[4243]: MULTI: Learn: 10.204.2.46/0 -&gt; cron2-free=
bsd-tc-amd64/udp6:194.97.140.21:14092<br>```</p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">The /0 is a bit suspicious, for &quot;regul=
ar&quot; learning it prints</p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">```<br>Aug 17 18:17:32 gentoo tun-udp-p2mp[4243]: MULTI: Lea=
rn: 10.204.2.6 -&gt; cron2-freebsd-tc-amd64/udp6:194.97.140.21:14092<br>```=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">For IPv6 it =
does not work either</p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">```<br>Aug 17 18:23:37 gentoo tun-udp-p2mp[4243]: SENT CONTROL [cro=
n2-freebsd-tc-amd64]: &#39;PUSH_UPDATE,ifconfig-ipv6 fd00:abcd:204:2::9a9a/=
64 fd00:abcd:204:2::1&#39; (status=3D1)<br>Aug 17 18:23:37 gentoo tun-udp-p=
2mp[4243]: MULTI: Learn: ::/0 -&gt; cron2-freebsd-tc-amd64/udp6:194.97.140.=
21:14092<br>Aug 17 18:23:46 gentoo tun-udp-p2mp[4243]: cron2-freebsd-tc-amd=
64/udp6:194.97.140.21:14092 MULTI: bad source address from client [fd00:abc=
d:204:2::9a9a], packet dropped<br>```</p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">why ::/0 ?!?</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/manage.c:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
69/comment/9d6db2f0_20959fe8">Patch Set #23, Line 136:</a> <code style=3D"f=
ont-family:monospace,monospace">    msg(M_CLIENT, &quot;version [n]        =
    : Set client&#39;s version to n or show current version of daemon.&quot=
;);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Un=
fortunately a rebase accident has happened here, and now this line is print=
ed twice.  While trivial to correct, project rules require that I do not do=
 code-changes on merge.</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail">change 869</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/869?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d=
1a323ed8df3fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 869 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 23 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 17 Aug 2025 16:24:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--lG8b/lYFmjQ=--

