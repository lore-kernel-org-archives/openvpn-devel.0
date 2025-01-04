From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 4 Jan 2025 22:49:22 +0000
In-Reply-To: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
References: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606..., lstipakov@...277...
Message-ID: <de359131d5a02c0c0ab4d44ff37963d3cbe272f5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ieAryPGSC+w="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add methods to
 read/write packet ids for epoch data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: MaxF <max@...2606...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ieAryPGSC+w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, stipa.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/803?usp=3Demail )

Change subject: Add methods to read/write packet ids for epoch data
......................................................................


Patch Set 10:

(2 comments)

File src/openvpn/packet_id.h:

http://gerrit.openvpn.net/c/openvpn/+/803/comment/d417abd6_3a14c47d :
PS8, Line 331: packed
> I'm thinking this is a typo. [=E2=80=A6]
typo. Will fix.


File tests/unit_tests/openvpn/test_packet_id.c:

http://gerrit.openvpn.net/c/openvpn/+/803/comment/9930dda9_9f758def :
PS8, Line 241: /* test writing/checking the 48 bit overflow */
> I don't get it, what overflow?
Epoch packet counter is max 48 bit. This is 2**48-1. Will extend the commen=
t.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2a104decdb1e77a460f7a6976bcd0560b67a07b5
Gerrit-Change-Number: 803
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Sat, 04 Jan 2025 22:49:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: MaxF <max@...2606...>
Gerrit-MessageType: comment

--ieAryPGSC+w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/packet_id.h:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/803/comment/d417abd6_3a14c47d">Patch Set #8, Line 331:<=
/a> <code style=3D"font-family:monospace,monospace">packed</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">I&#39;m thinking this is a typo. [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">typo. Will fix.</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/ope=
nvpn/test_packet_id.c:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/803/comment/9930dda9_9f758d=
ef">Patch Set #8, Line 241:</a> <code style=3D"font-family:monospace,monosp=
ace">/* test writing/checking the 48 bit overflow */</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
I don&#39;t get it, what overflow?</blockquote></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Epoch packet counter is max 48 bit. This=
 is 2**48-1. Will extend the comment.</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail">chang=
e 803</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2a104decdb1e77a460f7a6976bc=
d0560b67a07b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 803 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 04 Jan 2025 22:49:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ieAryPGSC+w=--

