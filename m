From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 13 Sep 2024 13:57:21 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <ad52567da6d3ffbf28501cd99047fa4a3b8b0adc-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u6+jhBfM9DQ="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--u6+jhBfM9DQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/739?usp=3Demail )

Change subject: Support CIDR on options and extend netbits usage
......................................................................


Patch Set 3: Code-Review-2

(16 comments)

Patchset:

PS3:
Didn't get through the whole code, but here a collection of my thoughts so =
far...


File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/04a8784d_9d0d84d0 :
PS3, Line 344:   :code:`255.255.255.255`.
for completeness mentions /32 as well.


File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/7f755556_b75a572a :
PS3, Line 220:      ifconfig local rn
Need to specify the two possibilities (IP address or netmask) separately.
Also "rn" is a horrible name. What it is supposed to mean?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/9e59c2d1_8882b7e2 :
PS3, Line 266: 2 255
Add /bits example here?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/f33e5bdd_a494b3ca :
PS3, Line 389:       route network|ipv4addr [netmask] [gateway] [metric]
Does the network|ipv4addr here really add any value? Should we go just for =
ipv4addr here like with --route-ipv6 ?


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/f3ac4520_d5a41ab2 :
PS2, Line 1535:     msg(D_SHOW_PARMS, "  ifconfig_pool_start =3D %s/%d", pr=
int_in_addr_t(o->ifconfig_pool_start, 0, &gc), o->ifconfig_pool_netbits);
> ok
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/483600ca_2e578b22 :
PS3, Line 6103:         if (!p[2]) /* p[1] must be in CIDR format */
Should probably do a ip_or_dns_addr_safe(p[1]) here? Might need to enhance =
that function to allow netbits, though.


http://gerrit.openvpn.net/c/openvpn/+/739/comment/37d80b88_d3071bd7 :
PS3, Line 7029: VERIFY_PERMISSION
VERIFY_PERMISSION should go first


http://gerrit.openvpn.net/c/openvpn/+/739/comment/babf9754_f9b70e73 :
PS3, Line 7037:         if (cidr && !no_more_than_n_args(msglevel, p, 4, NM=
_QUOTE_HINT))
Why NM_QUOTE_HINT?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/e96e9d33_aa4c39e3 :
PS3, Line 7042: OPT_P_ROUTE
VERIFY_PERMISSION should go first


http://gerrit.openvpn.net/c/openvpn/+/739/comment/1c383a62_67435f56 :
PS3, Line 7047:             const char *network =3D strtok(p[i++], "/"); /*=
 this modifies p[1] */
I find this very ugly. Would be better if we could improve ip_or_dns_addr_s=
afe to handle CIDR notation, wouldn't it?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/4bb91f0f_a5b37ba7 :
PS3, Line 7071:             add_route_to_option_list(options->routes, p[1],=
 NULL, p[2], p[3]);
Should we consider already normalizing the route here already and not parse=
 the netmask vs netbits later _again_? But I have to confess I'm not sure w=
hy we store the strings here in the first place and do not parse them alrea=
dy, so I might be missing something.


http://gerrit.openvpn.net/c/openvpn/+/739/comment/70b69c9f_0e173b5d :
PS3, Line 7409:             if (!no_more_than_n_args(msglevel, p, 3, NM_QUO=
TE_HINT))
Why NM_QUOTE_HINT?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/eed071e7_4e1a613b :
PS3, Line 7424:                 msg(M_USAGE, "--server directive network/ne=
tmask combination is invalid");
Why does this have a separate error message here but not in the sameish cod=
e in --server-bridge below? Can probably remove it here.


http://gerrit.openvpn.net/c/openvpn/+/739/comment/ef3a007f_b7b2f353 :
PS3, Line 7487:             if (!no_more_than_n_args(msglevel, p, 4, NM_QUO=
TE_HINT))
Why NM_QUOTE_HINT? Which argument could contain spaces?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/5a041385_78596de3 :
PS3, Line 7898:             if (!no_more_than_n_args(msglevel, p, 3, NM_QUO=
TE_HINT))
Why NM_QUOTE_HINT?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9
Gerrit-Change-Number: 739
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Fri, 13 Sep 2024 13:57:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: ralf_lici <ralf@...2726...>
Gerrit-MessageType: comment

--u6+jhBfM9DQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, ralf_lici. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">Vi=
ew Change</a></p><p>16 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/739?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Didn&#39;t get through the whole code, but h=
ere a collection of my thoughts so far...</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File doc/man-sections/server-options.rst:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/739/comment/04a8784d_9d0d84d0">Patch Set #3, Line 344:</a>=
 <code style=3D"font-family:monospace,monospace">  :code:`255.255.255.255`.=
</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">for c=
ompleteness mentions /32 as well.</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File doc/man-sections/vpn-network-options.rst:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/739/comment/7f755556_b75a572a">Patch Set #3, Line 220:</a> <c=
ode style=3D"font-family:monospace,monospace">     ifconfig local rn</code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Need to spec=
ify the two possibilities (IP address or netmask) separately.<br>Also &quot=
;rn&quot; is a horrible name. What it is supposed to mean?</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/9e59c2d1_8882b7e2"=
>Patch Set #3, Line 266:</a> <code style=3D"font-family:monospace,monospace=
">2 255</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Add /bits example here?</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/739/comment/f33e5bdd_a494b3ca">Patch Set #3, Line 389:</a> <cod=
e style=3D"font-family:monospace,monospace">      route network|ipv4addr [n=
etmask] [gateway] [metric]</code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Does the network|ipv4addr here really add any value? S=
hould we go just for ipv4addr here like with --route-ipv6 ?</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/739/comment/f3ac4520_d5a41ab2">Patch Set #2, Line 1535=
:</a> <code style=3D"font-family:monospace,monospace">    msg(D_SHOW_PARMS,=
 &quot;  ifconfig_pool_start =3D %s/%d&quot;, print_in_addr_t(o-&gt;ifconfi=
g_pool_start, 0, &amp;gc), o-&gt;ifconfig_pool_netbits);</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">ok</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/483600ca_2e578b=
22">Patch Set #3, Line 6103:</a> <code style=3D"font-family:monospace,monos=
pace">        if (!p[2]) /* p[1] must be in CIDR format */</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Should probably do a i=
p_or_dns_addr_safe(p[1]) here? Might need to enhance that function to allow=
 netbits, though.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/739/comment/37d80b88_d3071bd7">Patch Set #3, Line 7029:</a> <code style=
=3D"font-family:monospace,monospace">VERIFY_PERMISSION</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">VERIFY_PERMISSION should=
 go first</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/=
comment/babf9754_f9b70e73">Patch Set #3, Line 7037:</a> <code style=3D"font=
-family:monospace,monospace">        if (cidr &amp;&amp; !no_more_than_n_ar=
gs(msglevel, p, 4, NM_QUOTE_HINT))</code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Why NM_QUOTE_HINT?</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/739/comment/e96e9d33_aa4c39e3">Patch Set =
#3, Line 7042:</a> <code style=3D"font-family:monospace,monospace">OPT_P_RO=
UTE</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">VE=
RIFY_PERMISSION should go first</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/739/comment/1c383a62_67435f56">Patch Set #3, Line 7047:</=
a> <code style=3D"font-family:monospace,monospace">            const char *=
network =3D strtok(p[i++], &quot;/&quot;); /* this modifies p[1] */</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I find this v=
ery ugly. Would be better if we could improve ip_or_dns_addr_safe to handle=
 CIDR notation, wouldn&#39;t it?</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/739/comment/4bb91f0f_a5b37ba7">Patch Set #3, Line 7071:<=
/a> <code style=3D"font-family:monospace,monospace">            add_route_t=
o_option_list(options-&gt;routes, p[1], NULL, p[2], p[3]);</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Should we consider alr=
eady normalizing the route here already and not parse the netmask vs netbit=
s later _again_? But I have to confess I&#39;m not sure why we store the st=
rings here in the first place and do not parse them already, so I might be =
missing something.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/739/comment/70b69c9f_0e173b5d">Patch Set #3, Line 7409:</a> <code styl=
e=3D"font-family:monospace,monospace">            if (!no_more_than_n_args(=
msglevel, p, 3, NM_QUOTE_HINT))</code></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Why NM_QUOTE_HINT?</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/739/comment/eed071e7_4e1a613b">Patch Set #3,=
 Line 7424:</a> <code style=3D"font-family:monospace,monospace">           =
     msg(M_USAGE, &quot;--server directive network/netmask combination is i=
nvalid&quot;);</code></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Why does this have a separate error message here but not in the sa=
meish code in --server-bridge below? Can probably remove it here.</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/ef3a007f_b7=
b2f353">Patch Set #3, Line 7487:</a> <code style=3D"font-family:monospace,m=
onospace">            if (!no_more_than_n_args(msglevel, p, 4, NM_QUOTE_HIN=
T))</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Wh=
y NM_QUOTE_HINT? Which argument could contain spaces?</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/5a041385_78596de3">Pa=
tch Set #3, Line 7898:</a> <code style=3D"font-family:monospace,monospace">=
            if (!no_more_than_n_args(msglevel, p, 3, NM_QUOTE_HINT))</code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Why NM_QUOTE=
_HINT?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/739?usp=3Demail">change 739</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/739?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9=
a766c9604efc9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 739 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 13 Sep 2024 13:57:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@...2788...=
6...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--u6+jhBfM9DQ=--

