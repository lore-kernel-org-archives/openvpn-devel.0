From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 08:11:33 +0000
In-Reply-To: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
References: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <8c563a497eaac78db1c0532d5249bf2131c37de2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6lNZXhhAm00="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: better naming
 for function parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6lNZXhhAm00=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/769?usp=3Demail )

Change subject: dco: better naming for function parameters
......................................................................


Patch Set 3:

(2 comments)

File src/openvpn/dco_freebsd.c:

http://gerrit.openvpn.net/c/openvpn/+/769/comment/66bace0e_74cc1f97 :
PS3, Line 98:     if (vpn_in4)
wrong name


http://gerrit.openvpn.net/c/openvpn/+/769/comment/3adba3c8_1a9f262b :
PS3, Line 104:     if (vpn_in6)
wrong name



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I101bbc9f682375ec733bca10b52da82f0abfec27
Gerrit-Change-Number: 769
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Wed, 25 Sep 2024 08:11:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--6lNZXhhAm00=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_freebsd.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/769/comment/66bace0e_74cc1f97">Patch Set #3, Line 98:=
</a> <code style=3D"font-family:monospace,monospace">    if (vpn_in4)</code=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">wrong name<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/769/comment/3a=
dba3c8_1a9f262b">Patch Set #3, Line 104:</a> <code style=3D"font-family:mon=
ospace,monospace">    if (vpn_in6)</code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">wrong name</p></li></ul></li></ul><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail">cha=
nge 769</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I101bbc9f682375ec733bca10b52=
da82f0abfec27 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 769 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Sep 2024 08:11:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--6lNZXhhAm00=--

