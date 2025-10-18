From: "ordex (Code Review)" <gerrit@...515...>
Date: Sat, 18 Oct 2025 21:29:34 +0000
In-Reply-To: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
References: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...,
 gert@...1296...
Message-ID: <511bee86dcc353c89fcd495cc482c52e713a95e7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z2X9wf+TbJU="; charset=UTF-8
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

--Z2X9wf+TbJU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici.

ordex has posted comments on this change by ralf_lici. ( http://gerrit.open=
vpn.net/c/openvpn/+/1275?usp=3Demail )

Change subject: dco-freebsd: store peer stats directly in c2
......................................................................


Patch Set 2:

(1 comment)

File src/openvpn/dco_freebsd.c:

http://gerrit.openvpn.net/c/openvpn/+/1275/comment/eaa99283_eaf32505?usp=3D=
email :
PS2, Line 625:                 dco->c->c2.dco_write_bytes =3D nvlist_get_nu=
mber(bytes, "out");
> I don't think this is the correct place to store these. [=E2=80=A6]
actually if you check `dco_update_peer_stat()` it already does the right th=
ing, similarly to what Gert is alluding to. Maybe this function can be re-u=
sed while parsing `OVPN_NOTIF_DEL_PEER`?



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
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Sat, 18 Oct 2025 21:29:34 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>

--Z2X9wf+TbJU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_freebsd.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1275/comment/eaa99283_eaf32505?usp=3Demail">Patch Set=
 #2, Line 625:</a> <code style=3D"font-family:monospace,monospace">        =
        dco-&gt;c-&gt;c2.dco_write_bytes =3D nvlist_get_number(bytes, &quot=
;out&quot;);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">I don&#39;t think this is the correct pl=
ace to store these. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">actually if you check `d=
co_update_peer_stat()` it already does the right thing, similarly to what G=
ert is alluding to. Maybe this function can be re-used while parsing `OVPN_=
NOTIF_DEL_PEER`?</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1275?usp=3Demail">change 1275</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1275?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 18 Oct 2025 21:29:34=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>

</body></html>=

--Z2X9wf+TbJU=--

