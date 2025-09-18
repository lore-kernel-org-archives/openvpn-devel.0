From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 18 Sep 2025 14:45:57 +0000
In-Reply-To: <gerrit.1758036965000.Id070d1a45d45f9029309d23df7f3cab9ce792205@...2715...>
References: <gerrit.1758036965000.Id070d1a45d45f9029309d23df7f3cab9ce792205@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9d9bab87030049cc33bcbfee44e052198fe832ef-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gZjHCzWg5w4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ps: Fix conversion
 warnings related to send/recv return values
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gZjHCzWg5w4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1194?usp=3Demail )

Change subject: ps: Fix conversion warnings related to send/recv return val=
ues
......................................................................


Patch Set 7: -Code-Review

(1 comment)

File src/openvpn/ps.c:

http://gerrit.openvpn.net/c/openvpn/+/1194/comment/db9519f8_851d0944 :
PS7, Line 575:         dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: read[%d] %=
zd", (int)pc->sd, status);
> I should probably fix this to use SOCKET_PRINTF at the same time...
Nvm, I looked into it, and that would be a change worthy of its own commit



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1194?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id070d1a45d45f9029309d23df7f3cab9ce792205
Gerrit-Change-Number: 1194
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Thu, 18 Sep 2025 14:45:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--gZjHCzWg5w4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ddd;">-Code-Review</span></p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1194?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ps.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1194/comment/db9519f8_851d0944">Patch Set #7, Line 575:</a> <c=
ode style=3D"font-family:monospace,monospace">        dmsg(D_PS_PROXY_DEBUG=
, &quot;PORT SHARE PROXY: read[%d] %zd&quot;, (int)pc-&gt;sd, status);</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">I should probably fix this to use SOCKET_PRINTF at the sa=
me time...</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Nvm, I looked into it, and that would be a change worthy of its =
own commit</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1194?usp=3Demail">change 1194</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1194?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id070d1a45d45f9029309d23df7f=
3cab9ce792205 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1194 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 18 Sep 2025 14:45:57=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--gZjHCzWg5w4=--

