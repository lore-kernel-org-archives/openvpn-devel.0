From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 7 Jul 2025 14:05:56 +0000
In-Reply-To: <gerrit.1751893020000.Iecbbcf32c0059f2b16a05333b3794599060d7d6a@...2715...>
References: <gerrit.1751893020000.Iecbbcf32c0059f2b16a05333b3794599060d7d6a@...2715...>
Reply-To: arne-openvpn@...1227..., gianmarco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <43f5a57500bdc4aad48a9b409d225d6770a81dd5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q6pALGOkBvs="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Multi-socket: Fix
 assert triggered by stale peer-id reuse
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--q6pALGOkBvs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1078?usp=3Demail )

Change subject: Multi-socket: Fix assert triggered by stale peer-id reuse
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

Patchset:

PS1:
The check for NULL after already accessing it, looks very fishy.


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/1078/comment/5cf6ed60_e43a0b88 :
PS1, Line 225:                     if (mi)
This looks fishy. This basically can never fail. Since we already access `m=
->instances[peer_id]` in the if condition, this would have already segfault=
ed before even getting to this if (mi) check



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iecbbcf32c0059f2b16a05333b3794599060d7d6a
Gerrit-Change-Number: 1078
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 07 Jul 2025 14:05:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--q6pALGOkBvs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1078?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1078?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">The check for NULL after already accessing =
it, looks very fishy.</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/mudp.c:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1078/comment/5cf6ed6=
0_e43a0b88">Patch Set #1, Line 225:</a> <code style=3D"font-family:monospac=
e,monospace">                    if (mi)</code></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">This looks fishy. This basically can nev=
er fail. Since we already access `m-&gt;instances[peer_id]` in the if condi=
tion, this would have already segfaulted before even getting to this if (mi=
) check</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1078?usp=3Demail">change 1078</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1078?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iecbbcf32c0059f2b16a05333b37=
94599060d7d6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1078 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 07 Jul 2025 14:05:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--q6pALGOkBvs=--

