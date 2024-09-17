From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 16:12:50 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7bc835a350c61886b0c754dff60979f6e7933d74-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fabvXxpXt+E="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Support CIDR on
 options and extend netbits usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fabvXxpXt+E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ralf_lici has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/739?usp=3Demail )

Change subject: Support CIDR on options and extend netbits usage
......................................................................


Patch Set 5:

(3 comments)

File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/e9b1f04d_20390532 :
PS3, Line 220:      ifconfig local rn
> Yes, I think that is a good idea.
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/4b0a66fc_21822d3b :
PS3, Line 7071:             add_route_to_option_list(options->routes, p[1],=
 NULL, p[2], p[3]);
> yeah, it is fine. More idle wondering. [=E2=80=A6]
Acknowledged


File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/0d09b12f_5f27c1f4 :
PS4, Line 559:             const in_addr_t public_net =3D public & netmask;
> Turns out, it was formatted wrong because uncrustify thinks "public" is a=
 keyword and not a variable [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9
Gerrit-Change-Number: 739
Gerrit-PatchSet: 5
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 17 Sep 2024 16:12:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: ralf_lici <ralf@...2726...>
Gerrit-MessageType: comment

--fabvXxpXt+E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/vpn-network-o=
ptions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/739/comment/e9b1f04d_20390532">Patch S=
et #3, Line 220:</a> <code style=3D"font-family:monospace,monospace">     i=
fconfig local rn</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">Yes, I think that is a good idea.</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openv=
pn/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/739/comment/4b0a66fc_21822d3b">Patch=
 Set #3, Line 7071:</a> <code style=3D"font-family:monospace,monospace">   =
         add_route_to_option_list(options-&gt;routes, p[1], NULL, p[2], p[3=
]);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">yeah, it is fine. More idle wondering. [=E2=80=A6=
]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/tun.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/0d09b12f_5f27c1f=
4">Patch Set #4, Line 559:</a> <code style=3D"font-family:monospace,monospa=
ce">            const in_addr_t public_net =3D public &amp; netmask;</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">Turns out, it was formatted wrong because uncrustify thinks=
 &quot;public&quot; is a keyword and not a variable [=E2=80=A6]</blockquote=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/739?usp=3Demail">change 739</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9=
a766c9604efc9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 739 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Sep 2024 16:12:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@...2788...=
6...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--fabvXxpXt+E=--

