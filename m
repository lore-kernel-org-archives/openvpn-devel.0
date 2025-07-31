From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 31 Jul 2025 12:07:39 +0000
In-Reply-To: <gerrit.1753959374000.Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787@...2715...>
References: <gerrit.1753959374000.Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <86fce696fb8c01f7e0b77454db30af16bc9e9e52-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xJGL5uyh+FA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix DNS options
 duplication on PUSH_UPDATE
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

--xJGL5uyh+FA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1121?usp=3Demail )

Change subject: Fix DNS options duplication on PUSH_UPDATE
......................................................................


Patch Set 2:

(4 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1121/comment/cc9f9b67_aace83f8 :
PS2, Line 18: were added to existing once instead of overwriting them.
*existing ones


http://gerrit.openvpn.net/c/openvpn/+/1121/comment/6f40d257_3c5dd855 :
PS2, Line 22:  - reseting tuntap DNS options (regression from abovementione=
d commit)
*resetting


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/1121/comment/769a02c7_b70d0065 :
PS2, Line 3548:     if (s)
s will never be NULL here, in that case we'd branched to /* Copy --dhcp-opt=
ions to tuntap_options */ above already


http://gerrit.openvpn.net/c/openvpn/+/1121/comment/c0668a3d_ef605be7 :
PS2, Line 6227:
This code should instead store the DNS related things in `options->dns_opti=
ons.from_dhcp`. Using `tuntap_options` directly is not how it is done any l=
onger. Instead "values" of whatever origin are copied to `tuntap_options` d=
uring the postprocess stage if needed.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1121?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ife4d8fc5f8e2183e61226d66a76bbaa02c06f787
Gerrit-Change-Number: 1121
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 31 Jul 2025 12:07:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--xJGL5uyh+FA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1121?usp=3Demail">View =
Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1121/comment/cc9f9b67_aace83f8">Patch Set #2, Line 18:</a> <code sty=
le=3D"font-family:monospace,monospace">were added to existing once instead =
of overwriting them.</code></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">*existing ones</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1121/comment/6f40d257_3c5dd855">Patch Set #2, Line 22:</a> =
<code style=3D"font-family:monospace,monospace"> - reseting tuntap DNS opti=
ons (regression from abovementioned commit)</code></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">*resetting</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1121/comment/769a02c7_b70d0065">Patch Set #2, Line 3548:</a> <cod=
e style=3D"font-family:monospace,monospace">    if (s)</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">s will never be NULL her=
e, in that case we&#39;d branched to /* Copy --dhcp-options to tuntap_optio=
ns */ above already</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1121/comment/c0668a3d_ef605be7">Patch Set #2, Line 6227:</a> <code st=
yle=3D"font-family:monospace,monospace"></code></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">This code should instead store the DNS r=
elated things in `options-&gt;dns_options.from_dhcp`. Using `tuntap_options=
` directly is not how it is done any longer. Instead &quot;values&quot; of =
whatever origin are copied to `tuntap_options` during the postprocess stage=
 if needed.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1121?usp=3Demail">change 1121</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1121?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ife4d8fc5f8e2183e61226d66a76=
bbaa02c06f787 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1121 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 31 Jul 2025 12:07:39=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--xJGL5uyh+FA=--

