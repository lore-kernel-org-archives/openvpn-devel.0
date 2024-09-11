From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Wed, 11 Sep 2024 13:26:12 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <220b14dc20dc23d9479a34548416e711a8302507-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o+uAXR9nCsc="; charset=UTF-8
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

--o+uAXR9nCsc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ralf_lici has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/739?usp=3Demail )

Change subject: Support CIDR on options and extend netbits usage
......................................................................


Patch Set 2:

(4 comments)

Patchset:

PS2:
> Only started going through the code, so only a few comments. [=E2=80=A6]
Will do


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/2609ef1b_3e2658b8 :
PS2, Line 1516:     msg(D_SHOW_PARMS, "  server_network =3D %s/%d", print_i=
n_addr_t(o->server_network, 0, &gc), o->server_netbits);
> %u
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/511cdb40_3a9d08f3 :
PS2, Line 1519:     msg(D_SHOW_PARMS, "  server_bridge_ip =3D %s/%d", print=
_in_addr_t(o->server_bridge_ip, 0, &gc), o->server_bridge_netbits);
> %u
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/af179191_a1b280d9 :
PS2, Line 1535:     msg(D_SHOW_PARMS, "  ifconfig_pool_start =3D %s/%d", pr=
int_in_addr_t(o->ifconfig_pool_start, 0, &gc), o->ifconfig_pool_netbits);
> %u [=E2=80=A6]
So you are suggesting avoiding netbits in this case?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9
Gerrit-Change-Number: 739
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 11 Sep 2024 13:26:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--o+uAXR9nCsc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
739?tab=3Dcomments">Patch Set #2:</a> </p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Only started going th=
rough the code, so only a few comments. [=E2=80=A6]</blockquote></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Will do</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/739/comment/2609ef1b_3e2658b8">Patch Set #2, Line 1516=
:</a> <code style=3D"font-family:monospace,monospace">    msg(D_SHOW_PARMS,=
 &quot;  server_network =3D %s/%d&quot;, print_in_addr_t(o-&gt;server_netwo=
rk, 0, &amp;gc), o-&gt;server_netbits);</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">%u</blockquot=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledg=
ed</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment=
/511cdb40_3a9d08f3">Patch Set #2, Line 1519:</a> <code style=3D"font-family=
:monospace,monospace">    msg(D_SHOW_PARMS, &quot;  server_bridge_ip =3D %s=
/%d&quot;, print_in_addr_t(o-&gt;server_bridge_ip, 0, &amp;gc), o-&gt;serve=
r_bridge_netbits);</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">%u</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/af179191_a1b280d9">=
Patch Set #2, Line 1535:</a> <code style=3D"font-family:monospace,monospace=
">    msg(D_SHOW_PARMS, &quot;  ifconfig_pool_start =3D %s/%d&quot;, print_=
in_addr_t(o-&gt;ifconfig_pool_start, 0, &amp;gc), o-&gt;ifconfig_pool_netbi=
ts);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">%u [=E2=80=A6]</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">So you are suggesting avoiding ne=
tbits in this case?</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">change 739</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/739?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9=
a766c9604efc9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 739 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Sep 2024 13:26:12=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--o+uAXR9nCsc=--

