From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 18 Oct 2025 17:01:34 +0000
In-Reply-To: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
References: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <a03439831d4dcf89d010598dce4c0a1b20ef58df-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GyDfElnGKW8="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco-freebsd: store
 peer stats directly in c2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GyDfElnGKW8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici.

cron2 has posted comments on this change by ralf_lici. ( http://gerrit.open=
vpn.net/c/openvpn/+/1275?usp=3Demail )

Change subject: dco-freebsd: store peer stats directly in c2
......................................................................


Patch Set 2: Code-Review-1

(2 comments)

Patchset:

PS2:
I think this needs more discussion on which counters on what event and in w=
hat mode (client side / CM_P2P vs. server side) to put where


File src/openvpn/dco_freebsd.c:

http://gerrit.openvpn.net/c/openvpn/+/1275/comment/4f9c725c_42b0c79e?usp=3D=
email :
PS2, Line 625:                 dco->c->c2.dco_write_bytes =3D nvlist_get_nu=
mber(bytes, "out");
I don't think this is the correct place to store these.

The overall context here is "OVPN_NOTIF_DEL_PEER", so we're told by the ker=
nel that `dco->dco_message_peer_id` went away, and, btw, here are the lates=
t counters for this peer.

Storing it in `dco->c->c2->` smells like "the server's global structure" wh=
ile Linux would put per-client into `dco->c->multi->instances[peer_id]->con=
text.c2->` - OTOH, Linux' `CMD_PEER_DEL_NTF` seems to carry no counters, so=
 the code is not the same anyway.

Am I misreading this?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84
Gerrit-Change-Number: 1275
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Sat, 18 Oct 2025 17:01:34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--GyDfElnGKW8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1275?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think th=
is needs more discussion on which counters on what event and in what mode (=
client side / CM_P2P vs. server side) to put where</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_freebsd.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1275/comment/4f9c725c_42b0c79e?usp=3Demail">Patch Set #2, L=
ine 625:</a> <code style=3D"font-family:monospace,monospace">              =
  dco-&gt;c-&gt;c2.dco_write_bytes =3D nvlist_get_number(bytes, &quot;out&q=
uot;);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I don&#39;t think this is the correct place to store thes=
e.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">The overall context here is &quot;OVPN_NOTIF_DEL_PEER&quot;, so we&#=
39;re told by the kernel that `dco-&gt;dco_message_peer_id` went away, and,=
 btw, here are the latest counters for this peer.</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Storing it in `dco-&g=
t;c-&gt;c2-&gt;` smells like &quot;the server&#39;s global structure&quot; =
while Linux would put per-client into `dco-&gt;c-&gt;multi-&gt;instances[pe=
er_id]-&gt;context.c2-&gt;` - OTOH, Linux&#39; `CMD_PEER_DEL_NTF` seems to =
carry no counters, so the code is not the same anyway.</p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Am I misreading =
this?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1275?usp=3Demail">change 1275</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1275?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53dd40fabdeacb9dca843e28fdd=
3b357711c5a84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1275 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 18 Oct 2025 17:01:34=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--GyDfElnGKW8=--

