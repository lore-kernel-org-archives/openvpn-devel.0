From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 22 Oct 2023 09:06:38 +0000
In-Reply-To: <gerrit.1695213156000.If4e9c2e58441efb3fd00872cd62d1cc6c607f160@...2715...>
References: <gerrit.1695213156000.If4e9c2e58441efb3fd00872cd62d1cc6c607f160@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 flichtenheld79@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <b8955aec49b73f68648c055f08842c1f20770717-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EfDZu7TxBF4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 dev-tools/gerrit-send-mail.py: tool to send Gerrit patchsets to Patch...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: unauthorized <flichtenheld79@...277...>, plaisthos <arne-openvpn@...1227...>, d12fk <heiko@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EfDZu7TxBF4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/361?usp=3Demail )

Change subject: dev-tools/gerrit-send-mail.py: tool to send Gerrit patchset=
s to Patchwork
......................................................................


Patch Set 5:

(1 comment)

Patchset:

PS5:
I tested this today, and besides needing extra python modules (dateutils) t=
hat neither Gentoo nor FreeBSD had before, it nicely did the job on #368 fo=
r me.

For extra benefits, the produced "git send-email" line could have the "-v3"=
 for "patch v3"...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/361?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If4e9c2e58441efb3fd00872cd62d1cc6c607f160
Gerrit-Change-Number: 361
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: unauthorized <flichtenheld79@...277...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Sun, 22 Oct 2023 09:06:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--EfDZu7TxBF4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/361?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
61?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I tested this today, and besides needing extra pyt=
hon modules (dateutils) that neither Gentoo nor FreeBSD had before, it nice=
ly did the job on #368 for me.</p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">For extra benefits, the produced &quot;git send-email&quo=
t; line could have the &quot;-v3&quot; for &quot;patch v3&quot;...</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/361?usp=3Demail">change 361</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/361?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If4e9c2e58441efb3fd00872cd62=
d1cc6c607f160 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 361 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: unauthorized &lt;flichtenheld79@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 22 Oct 2023 09:06:38=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--EfDZu7TxBF4=--

