From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 18 Sep 2024 19:07:02 +0000
In-Reply-To: <gerrit.1726680937000.Ib8ba2b63ea9fd1944ff07f69c545a880e464680c@...2715...>
References: <gerrit.1726680937000.Ib8ba2b63ea9fd1944ff07f69c545a880e464680c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e8fb9afc936e18f7dcf00a5200e69c28d525321b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WcdZpLwevUI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Refactor methods to
 use the actual state of tun rather the options st...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WcdZpLwevUI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/753?usp=3Demail )

Change subject: Refactor methods to use the actual state of tun rather the =
options struct
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/753/comment/3d324953_82de2ce7 :
PS1, Line 634:     if (tun_dco_enabled(m->top.c1.tuntap))
this does not look correct - it goes from "if(!dco_enabled)" to "if(tun_dco=
_enabled)" without `!`.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/753?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib8ba2b63ea9fd1944ff07f69c545a880e464680c
Gerrit-Change-Number: 753
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 18 Sep 2024 19:07:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--WcdZpLwevUI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/753?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/753/comment/3d324953_82de2ce7">Patch Set #1, Line 634:</a>=
 <code style=3D"font-family:monospace,monospace">    if (tun_dco_enabled(m-=
&gt;top.c1.tuntap))</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">this does not look correct - it goes from &quot;if(!dco_enabl=
ed)&quot; to &quot;if(tun_dco_enabled)&quot; without `!`.</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/75=
3?usp=3Demail">change 753</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/753?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib8ba2b63ea9fd1944ff07f69c54=
5a880e464680c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 753 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Sep 2024 19:07:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--WcdZpLwevUI=--

