From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 7 May 2026 05:49:26 +0000
In-Reply-To: <gerrit.1778102459000.I5c9b54dca0a14688a3bb7798cb086f5bde7311b8@...2715...>
References: <gerrit.1778102459000.I5c9b54dca0a14688a3bb7798cb086f5bde7311b8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d3a7264e4c67bfab981ad60ae5514e5f2781126d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GZh7ZohP6UI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: Clarify
 operator precedence in a & b ? c : d
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GZh7ZohP6UI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change by flichtenheld. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1668?usp=3Demail )

Change subject: route: Clarify operator precedence in a & b ? c : d
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/1668/comment/7004e626_e74dcd6c?usp=3D=
email :
PS1, Line 2887:                             .metric =3D ((r->flags & RT_MET=
RIC_DEFINED) ? r->metric : -1) };
can we get rid of the outer braces?

.metric =3D ( a & b )? c: d

is clear enough to readers (IMHO easier to grasp) and should be fine for th=
e compiler?



--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1668?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5c9b54dca0a14688a3bb7798cb086f5bde7311b8
Gerrit-Change-Number: 1668
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 07 May 2026 05:49:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--GZh7ZohP6UI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1668?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1668/comment/7004e626_e74dcd6c?usp=3Demail">Patch Set #=
1, Line 2887:</a> <code style=3D"font-family:monospace,monospace">         =
                   .metric =3D ((r-&gt;flags &amp; RT_METRIC_DEFINED) ? r-&=
gt;metric : -1) };</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">can we get rid of the outer braces?</p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">.metr=
ic =3D ( a &amp; b )? c: d</p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">is clear enough to readers (IMHO easier to g=
rasp) and should be fine for the compiler?</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1668?usp=3Demail"=
>change 1668</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1668?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5c9b54dca0a14688a3bb7798cb0=
86f5bde7311b8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1668 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 07 May 2026 05:49:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--GZh7ZohP6UI=--

