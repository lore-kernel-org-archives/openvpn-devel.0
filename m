From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jan 2024 13:16:20 +0000
In-Reply-To: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
References: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <9d5bc3f56a72e05ec857190a04354375b8700fa1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k7SRd2UIQZM="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Windows: enforce
 'block-local' with WFP filters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--k7SRd2UIQZM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/489?usp=3Demail )

Change subject: Windows: enforce 'block-local' with WFP filters
......................................................................


Patch Set 1:

(10 comments)

File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/616966e3_6506d21f :
PS1, Line 357:       Push this flag to defend against the TunnelCrack attac=
ks.
> Should explain a bit more what this protects against. [=E2=80=A6]
Agree not to explain TunnelCrack in the openvpn man page, but then referenc=
es are not much of a thing in roff either. Could you elaborate what you hav=
e in mind? The technicalities are explained before the concluding sentence,=
 so if you have a clue about TunnnelCrack things should be clear enough.


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/b47799d4_dca0b2c0 :
PS1, Line 1971:         /* Fortify 'redirect-gateway block-local' with fire=
wall rules? */
> Since this hunk and the previous are completely identical I would move th=
em to a separate function. [=E2=80=A6]
I think there's even more duplicate code before. I'll take a look and submi=
t a separate commit if it is not tightly related to wfp only.


File src/openvpn/route.h:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/0c835951_e7364760 :
PS1, Line 248:  * is connected. This definatly returns false when not redir=
ecting the gateway
> Typo "definatly"
Done


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/eb7787ef_be0c1c5c :
PS1, Line 78: static bool add_route(struct route_ipv4 *r, const struct tunt=
ap *tt, unsigned int flags,
> this breaks compilation on a zillion of platforms that want to call add_r=
oute() from tun. [=E2=80=A6]
Right, failed to spot this. The build results speak for themselves. =3D/


http://gerrit.openvpn.net/c/openvpn/+/489/comment/0e347637_c3fa5a5a :
PS1, Line 612:     size_t i;
> no reason to leave that on its own line
Done


File src/openvpn/wfp_block.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/97c5a316_ea67f28e :
PS1, Line 167:  * Block outgoing port 53 traffic except for
> "port 53" needs to be changed to reflect the new functionality
Done


http://gerrit.openvpn.net/c/openvpn/+/489/comment/ff62cf3d_89d511ff :
PS1, Line 197:     FWPM_FILTER_CONDITION0 Condition[2];
> Why remove the "=3D {0}" here?
because the filters are zeroed right below, and than copied into [0] and/or=
 [1] below as needed, so there's no uninitialized memory.


http://gerrit.openvpn.net/c/openvpn/+/489/comment/662c3688_6dc87eea :
PS1, Line 294:     /* Third filter. Block IPv4 to port 53 or all besided lo=
opback. */
> "besides"? Or maybe "except"?
Done


http://gerrit.openvpn.net/c/openvpn/+/489/comment/af60e388_d7cb7c20 :
PS1, Line 303:     /* Forth filter. Block IPv6 to port 53 or all besides lo=
opback */
> "Fourth"
Done


File src/openvpn/win32.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/bdfe473f_2369c40d :
PS1, Line 1225:     if (ret =3D=3D false)
> Simplify to "!win_get_exe_path(openvpnpath, _countof(openvpnpath))"
We need to set ret as return value anyway, so doing it before the if is mor=
e readable IMHO compared to cramming the function call between the parenthe=
ses.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba
Gerrit-Change-Number: 489
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 09 Jan 2024 13:16:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--k7SRd2UIQZM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">View C=
hange</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/vpn-network-=
options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/489/comment/616966e3_6506d21f">Patch =
Set #1, Line 357:</a> <code style=3D"font-family:monospace,monospace">     =
 Push this flag to defend against the TunnelCrack attacks.</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">Should explain a bit more what this protects against. [=E2=80=A6]</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Agr=
ee not to explain TunnelCrack in the openvpn man page, but then references =
are not much of a thing in roff either. Could you elaborate what you have i=
n mind? The technicalities are explained before the concluding sentence, so=
 if you have a clue about TunnnelCrack things should be clear enough.</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/489/comment/b47799d4_dca0b2c0">Patch Set #1, Li=
ne 1971:</a> <code style=3D"font-family:monospace,monospace">        /* For=
tify &#39;redirect-gateway block-local&#39; with firewall rules? */</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Since this hunk and the previous are completely identical I =
would move them to a separate function. [=E2=80=A6]</blockquote></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">I think there&#39;s eve=
n more duplicate code before. I&#39;ll take a look and submit a separate co=
mmit if it is not tightly related to wfp only.</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.h:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/489/comment/0c835951_e7364760">Patch Set #1, Line 248:</a> <code sty=
le=3D"font-family:monospace,monospace"> * is connected. This definatly retu=
rns false when not redirecting the gateway</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo &qu=
ot;definatly&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/route.c:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/eb778=
7ef_be0c1c5c">Patch Set #1, Line 78:</a> <code style=3D"font-family:monospa=
ce,monospace">static bool add_route(struct route_ipv4 *r, const struct tunt=
ap *tt, unsigned int flags,</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">this breaks compilation o=
n a zillion of platforms that want to call add_route() from tun. [=E2=80=A6=
]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Right, failed to spot this. The build results speak for themselves. =3D/<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/0e=
347637_c3fa5a5a">Patch Set #1, Line 612:</a> <code style=3D"font-family:mon=
ospace,monospace">    size_t i;</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">no reason to leave th=
at on its own line</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/wfp_block.c:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/9=
7c5a316_ea67f28e">Patch Set #1, Line 167:</a> <code style=3D"font-family:mo=
nospace,monospace"> * Block outgoing port 53 traffic except for</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">&quot;port 53&quot; needs to be changed to reflect the new funct=
ionality</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
489/comment/ff62cf3d_89d511ff">Patch Set #1, Line 197:</a> <code style=3D"f=
ont-family:monospace,monospace">    FWPM_FILTER_CONDITION0 Condition[2];</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">Why remove the &quot;=3D {0}&quot; here?</blockquote></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">because the fi=
lters are zeroed right below, and than copied into [0] and/or [1] below as =
needed, so there&#39;s no uninitialized memory.</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/489/comment/662c3688_6dc87eea">Patch Set =
#1, Line 294:</a> <code style=3D"font-family:monospace,monospace">    /* Th=
ird filter. Block IPv4 to port 53 or all besided loopback. */</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">&quot;besides&quot;? Or maybe &quot;except&quot;?</blockquote></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/af60e388_d7cb=
7c20">Patch Set #1, Line 303:</a> <code style=3D"font-family:monospace,mono=
space">    /* Forth filter. Block IPv6 to port 53 or all besides loopback *=
/</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">&quot;Fourth&quot;</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/win32.c:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/489/comment/bdfe473f_2369c40d">Patch Set #1, Line 1225:</a> <code st=
yle=3D"font-family:monospace,monospace">    if (ret =3D=3D false)</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Simplify to &quot;!win_get_exe_path(openvpnpath, _countof(open=
vpnpath))&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">We need to set ret as return value anyway, so doing it befo=
re the if is more readable IMHO compared to cramming the function call betw=
een the parentheses.</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">change 489</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/489?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f=
071db3e4832ba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 489 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Jan 2024 13:16:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--k7SRd2UIQZM=--

