From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 23 Jan 2025 12:59:15 +0000
In-Reply-To: <gerrit.1733849609000.Ib118426c5a69256894040c69856a4003d9f4637c@...2715...>
References: <gerrit.1733849609000.Ib118426c5a69256894040c69856a4003d9f4637c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 ralf@...2726..., frank@...2641...
Message-ID: <93a076e9818b8337bcb5ab700f345ea5d065c6b6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q90wV+Ayqh8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Handle missing DCO
 peer by restarting the session
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Q90wV+Ayqh8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ralf_lici.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/831?usp=3Demail )

Change subject: Handle missing DCO peer by restarting the session
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/sig.c:

http://gerrit.openvpn.net/c/openvpn/+/831/comment/2680885b_1241b5c7 :
PS1, Line 495:             msg(M_WARN, "Error requesting peer %d DCO stats =
(%s). Restarting the session",
Might to give some user understandable reason/guidance. I would not know wh=
at to expect here. Is this normal? Is this a problem? Do I have to worry an=
d look to debug some deeper underlying problem?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib118426c5a69256894040c69856a4003d9f4637c
Gerrit-Change-Number: 831
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Thu, 23 Jan 2025 12:59:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--Q90wV+Ayqh8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ralf_lici. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/sig.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/831/comment/2680885b_1241b5c7">Patch Set #1, Line 495:</a> <co=
de style=3D"font-family:monospace,monospace">            msg(M_WARN, &quot;=
Error requesting peer %d DCO stats (%s). Restarting the session&quot;,</cod=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Might to g=
ive some user understandable reason/guidance. I would not know what to expe=
ct here. Is this normal? Is this a problem? Do I have to worry and look to =
debug some deeper underlying problem?</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail">chang=
e 831</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/831?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib118426c5a69256894040c69856=
a4003d9f4637c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 831 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 23 Jan 2025 12:59:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Q90wV+Ayqh8=--

