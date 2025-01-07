From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 7 Jan 2025 09:53:32 +0000
In-Reply-To: <gerrit.1734714757000.I806757a8c6f9a589665624f176391b5f7b87f581@...2715...>
References: <gerrit.1734714757000.I806757a8c6f9a589665624f176391b5f7b87f581@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <5f0e833b85721813a9030b9b36115127ec2e3461-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Pnmn971HXBg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix float support in
 P2P topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Pnmn971HXBg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

ralf_lici has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/844?usp=3Demail )

Change subject: Fix float support in P2P topology
......................................................................


Patch Set 2:

(1 comment)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/844/comment/fd7d307f_f86255fe :
PS1, Line 1253:         process_incoming_link_part2(c, lsi, orig_buf);
> AFAICT the output of `_part1()` is correlated with `c->c2.buf.len` such t=
hat `buf. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I806757a8c6f9a589665624f176391b5f7b87f581
Gerrit-Change-Number: 844
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 07 Jan 2025 09:53:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: ralf_lici <ralf@...2726...>
Gerrit-MessageType: comment

--Pnmn971HXBg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/844?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/844/comment/fd7d307f_f86255fe">Patch Set #1, Line 1253:</a=
> <code style=3D"font-family:monospace,monospace">        process_incoming_=
link_part2(c, lsi, orig_buf);</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">AFAICT the output of `_=
part1()` is correlated with `c-&gt;c2.buf.len` such that `buf. [=E2=80=A6]<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/844?usp=3Demail">change 844</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/844?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I806757a8c6f9a589665624f1763=
91b5f7b87f581 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 844 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 07 Jan 2025 09:53:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@...2788...=
6...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Pnmn971HXBg=--

