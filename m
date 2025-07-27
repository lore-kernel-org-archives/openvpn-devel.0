From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 27 Jul 2025 11:02:31 +0000
In-Reply-To: <gerrit.1753488078000.I1ad5df0f6785ffe9becd9f83329a9335d1a36f24@...2715...>
References: <gerrit.1753488078000.I1ad5df0f6785ffe9becd9f83329a9335d1a36f24@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <56f809cded1d20dfbd5d08a7fa83816df9b9e18d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9yG6wN7Ci5w="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco: drop client
 prefix after DCO PEER_FLOAT notification
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9yG6wN7Ci5w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1116?usp=3Demail )

Change subject: dco: drop client prefix after DCO PEER_FLOAT notification
......................................................................


Patch Set 2:

(1 comment)

Patchset:

PS2:
Here's another one... counter timer triggering while an outgoing TLS renego=
tiation is in progress

```
Jul 27 12:33:36 ubuntu2004 tun-udp-p2mp[298589]: udp6:[2001:608:0:814::fb00=
:14]:33827 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384,=
 peer certificate: 2048 bits RSA, signature: RSA-SHA256, peer temporary key=
: 253 bits X25519, peer signing digest/type: SHA256 RSASSA-PSS
Jul 27 12:33:36 ubuntu2004 kernel: [443346.370968] tun1: del peer 1
Jul 27 12:33:36 ubuntu2004 kernel: [443346.370974] tun1: deleting peer with=
 id 1, reason 1
Jul 27 12:33:36 ubuntu2004 tun-udp-p2mp[298589]: udp6:[2001:608:0:814::fb00=
:14]:33827 [freebsd-14-amd64] Peer Connection Initiated with [AF_INET6]2001=
:608:0:814::fb00:14:33827
Jul 27 12:33:36 ubuntu2004 tun-udp-p2mp[298589]: freebsd-14-amd64/udp6:[200=
1:608:0:814::fb00:14]:33827 peer-id=3D2 dco_get_peer: peer-id -1
Jul 27 12:33:36 ubuntu2004 tun-udp-p2mp[298589]: freebsd-14-amd64/udp6:[200=
1:608:0:814::fb00:14]:33827 peer-id=3D2 ovpn-dco: received netlink message =
type=3D31 cmd=3D3 flags=3D0x0002
Jul 27 12:33:36 ubuntu2004 tun-udp-p2mp[298589]: freebsd-14-amd64/udp6:[200=
1:608:0:814::fb00:14]:33827 peer-id=3D2 ovpn_handle_peer: parsing message f=
or peer 0...
Jul 27 12:33:36 ubuntu2004 tun-udp-p2mp[298589]: freebsd-14-amd64/udp6:[200=
1:608:0:814::fb00:14]:33827 peer-id=3D2 dco_update_peer_stat / dco_read_byt=
es(0): 440
Jul 27 12:33:36 ubuntu2004 tun-udp-p2mp[298589]: freebsd-14-amd64/udp6:[200=
1:608:0:814::fb00:14]:33827 peer-id=3D2 dco_update_peer_stat / dco_write_by=
tes(0): 480
```

in this case resetting the prefix would mess up prefix logging for the TLS =
handshake, so it's not the right approach anyway.

Digging through error.c I found something half-forgotten...

```
    /* set up client prefix */
    if (flags & M_NOIPREFIX)
    {
        prefix =3D NULL;
    }
    else
    {
        prefix =3D msg_get_prefix();
    }
```

so I think the *right* approach is to use `msg(...|M_NOIPREFIX, ...)` for e=
verything that is not normally related to a particular MI instance - like, =
most of the DCO events.

Magic



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1ad5df0f6785ffe9becd9f83329a9335d1a36f24
Gerrit-Change-Number: 1116
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Sun, 27 Jul 2025 11:02:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--9yG6wN7Ci5w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1116?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Here&#39;s another one... counter timer triggeri=
ng while an outgoing TLS renegotiation is in progress</p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">```<br>Jul 27 12:33:36 ubuntu2004 =
tun-udp-p2mp[298589]: udp6:[2001:608:0:814::fb00:14]:33827 Control Channel:=
 TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, peer certificate: 2048 bit=
s RSA, signature: RSA-SHA256, peer temporary key: 253 bits X25519, peer sig=
ning digest/type: SHA256 RSASSA-PSS<br>Jul 27 12:33:36 ubuntu2004 kernel: [=
443346.370968] tun1: del peer 1<br>Jul 27 12:33:36 ubuntu2004 kernel: [4433=
46.370974] tun1: deleting peer with id 1, reason 1<br>Jul 27 12:33:36 ubunt=
u2004 tun-udp-p2mp[298589]: udp6:[2001:608:0:814::fb00:14]:33827 [freebsd-1=
4-amd64] Peer Connection Initiated with [AF_INET6]2001:608:0:814::fb00:14:3=
3827<br>Jul 27 12:33:36 ubuntu2004 tun-udp-p2mp[298589]: freebsd-14-amd64/u=
dp6:[2001:608:0:814::fb00:14]:33827 peer-id=3D2 dco_get_peer: peer-id -1<br=
>Jul 27 12:33:36 ubuntu2004 tun-udp-p2mp[298589]: freebsd-14-amd64/udp6:[20=
01:608:0:814::fb00:14]:33827 peer-id=3D2 ovpn-dco: received netlink message=
 type=3D31 cmd=3D3 flags=3D0x0002<br>Jul 27 12:33:36 ubuntu2004 tun-udp-p2m=
p[298589]: freebsd-14-amd64/udp6:[2001:608:0:814::fb00:14]:33827 peer-id=3D=
2 ovpn_handle_peer: parsing message for peer 0...<br>Jul 27 12:33:36 ubuntu=
2004 tun-udp-p2mp[298589]: freebsd-14-amd64/udp6:[2001:608:0:814::fb00:14]:=
33827 peer-id=3D2 dco_update_peer_stat / dco_read_bytes(0): 440<br>Jul 27 1=
2:33:36 ubuntu2004 tun-udp-p2mp[298589]: freebsd-14-amd64/udp6:[2001:608:0:=
814::fb00:14]:33827 peer-id=3D2 dco_update_peer_stat / dco_write_bytes(0): =
480<br>```</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">in=
 this case resetting the prefix would mess up prefix logging for the TLS ha=
ndshake, so it&#39;s not the right approach anyway.</p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Digging through error.c I found some=
thing half-forgotten...</p><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">```<br>    /* set up client prefix */<br>    if (fl=
ags &amp; M_NOIPREFIX)<br>    {<br>        prefix =3D NULL;<br>    }<br>   =
 else<br>    {<br>        prefix =3D msg_get_prefix();<br>    }<br>```</pre=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">so I think the =
*right* approach is to use `msg(...|M_NOIPREFIX, ...)` for everything that =
is not normally related to a particular MI instance - like, most of the DCO=
 events.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Magi=
c</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1116?usp=3Demail">change 1116</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1116?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1ad5df0f6785ffe9becd9f83329=
a9335d1a36f24 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1116 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 27 Jul 2025 11:02:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--9yG6wN7Ci5w=--

