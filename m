From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 13 Oct 2025 15:01:15 +0000
In-Reply-To: <gerrit.1722331476000.I87777e74b1fd34781e1d72c9f994eb84f39d800c@...2715...>
References: <gerrit.1722331476000.I87777e74b1fd34781e1d72c9f994eb84f39d800c@...2715...>
Reply-To: arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fb0f931caece514d3dffc45e349702ae2b635a24-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6IYntEuNxVI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: route: extended
 logic to omit gateway when unnecessary
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6IYntEuNxVI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff.

plaisthos has posted comments on this change by mrbff. ( http://gerrit.open=
vpn.net/c/openvpn/+/721?usp=3Demail )

Change subject: route: extended logic to omit gateway when unnecessary
......................................................................


Patch Set 11: Code-Review-2

(7 comments)

Patchset:

PS11:
I am seriously confused by this PR. The premise of the PR seems that routes=
 that are setup on the startup of OpenVPN (CM_TOP) need to be handled diffe=
rrent than routes on the startup of a client or routes that are added later=
, e.g. by CCD files but I do not see a strong reason why these initial rout=
es should be special in that regard.


File src/openvpn/route.h:

http://gerrit.openvpn.net/c/openvpn/+/721/comment/c375c7a6_648618a0?usp=3De=
mail :
PS11, Line 274: bool add_route_ipv6(struct route_ipv6 *r, const struct tunt=
ap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ct=
x, const bool is_multipoint);
The naming here and the usage seem to disagree. `is_multipoint` sounds like=
 the usage in a p2mp server context but the actual usage is that this flag =
is only used for the CM_TOP instance, which is more the initialisation of p=
2mp on startup. So this naming is quite confusing here.

Also why adding a flag as bool to the function vs adding it as extra flag i=
n the route structure.


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/721/comment/d77240b0_a0c41a4e?usp=3De=
mail :
PS11, Line 1811:     /* FIXME -- add on-link support for Dragonfly */
Has this been really tested on DragonFly BSD?


http://gerrit.openvpn.net/c/openvpn/+/721/comment/f8856fdf_5f40d6a4?usp=3De=
mail :
PS11, Line 1600:         && !( (r4->flags & RT_METRIC_DEFINED) && r4->metri=
c =3D=3D 0 ) )
how does the metric play into needing a gateway or not?


http://gerrit.openvpn.net/c/openvpn/+/721/comment/ac755fc1_a42389d2?usp=3De=
mail :
PS11, Line 1607:         return true;
A little bit of explanation why DCO is different is needed.


http://gerrit.openvpn.net/c/openvpn/+/721/comment/657a25df_8073c041?usp=3De=
mail :
PS11, Line 1898:     }
Has this been tested on Open and NetBSD?


http://gerrit.openvpn.net/c/openvpn/+/721/comment/715e26fa_29fc79e0?usp=3De=
mail :
PS11, Line 2010: {
I think this duplicates the code that was publicly accessible in https://ge=
rrit.openvpn.net/c/openvpn/+/1191



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87777e74b1fd34781e1d72c9f994eb84f39d800c
Gerrit-Change-Number: 721
Gerrit-PatchSet: 11
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Mon, 13 Oct 2025 15:01:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--6IYntEuNxVI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff. </p>
<p>Patch set 11:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail">V=
iew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/721?tab=3Dcomments&amp;usp=3Demail">Patch Set #11:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I am serio=
usly confused by this PR. The premise of the PR seems that routes that are =
setup on the startup of OpenVPN (CM_TOP) need to be handled differrent than=
 routes on the startup of a client or routes that are added later, e.g. by =
CCD files but I do not see a strong reason why these initial routes should =
be special in that regard.</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/route.h:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/721/comment/c3=
75c7a6_648618a0?usp=3Demail">Patch Set #11, Line 274:</a> <code style=3D"fo=
nt-family:monospace,monospace">bool add_route_ipv6(struct route_ipv6 *r, co=
nst struct tuntap *tt, unsigned int flags, const struct env_set *es, openvp=
n_net_ctx_t *ctx, const bool is_multipoint);</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">The naming here and=
 the usage seem to disagree. `is_multipoint` sounds like the usage in a p2m=
p server context but the actual usage is that this flag is only used for th=
e CM_TOP instance, which is more the initialisation of p2mp on startup. So =
this naming is quite confusing here.</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Also why adding a flag as bool to =
the function vs adding it as extra flag in the route structure.</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.c:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/721/comment/d77240b0_a0c41a4e?usp=3Demail">Patch Set=
 #11, Line 1811:</a> <code style=3D"font-family:monospace,monospace">    /*=
 FIXME -- add on-link support for Dragonfly */</code></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Has this been rea=
lly tested on DragonFly BSD?</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/721/comment/f8856fdf_5f40d6a4?usp=3Demail">Patch Set #11, Li=
ne 1600:</a> <code style=3D"font-family:monospace,monospace">        &amp;&=
amp; !( (r4-&gt;flags &amp; RT_METRIC_DEFINED) &amp;&amp; r4-&gt;metric =3D=
=3D 0 ) )</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">how does the metric play into needing a gateway or not=
?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/721/comment/=
ac755fc1_a42389d2?usp=3Demail">Patch Set #11, Line 1607:</a> <code style=3D=
"font-family:monospace,monospace">        return true;</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A littl=
e bit of explanation why DCO is different is needed.</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/721/comment/657a25df_8073c041?usp=3D=
email">Patch Set #11, Line 1898:</a> <code style=3D"font-family:monospace,m=
onospace">    }</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Has this been tested on Open and NetBSD?</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/721/comment/715e26fa_=
29fc79e0?usp=3Demail">Patch Set #11, Line 2010:</a> <code style=3D"font-fam=
ily:monospace,monospace">{</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">I think this duplicates the code that=
 was publicly accessible in https://gerrit.openvpn.net/c/openvpn/+/1191</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/721?usp=3Demail">change 721</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/721?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87777e74b1fd34781e1d72c9f99=
4eb84f39d800c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 721 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 13 Oct 2025 15:01:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--6IYntEuNxVI=--

