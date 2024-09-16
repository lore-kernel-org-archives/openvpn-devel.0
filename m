From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 16 Sep 2024 15:54:54 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <19bb88ed2827707e1f0bb7c6e75d6e9e049dfede-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vu3dmQffs1k="; charset=UTF-8
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

--Vu3dmQffs1k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ralf_lici has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/739?usp=3Demail )

Change subject: Support CIDR on options and extend netbits usage
......................................................................


Patch Set 3:

(25 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/ef955895_c40062c5 :
PS3, Line 9: Add support for CIDR notation on all suitable options (client-=
nat,
> Maybe give some more motivation here. [=E2=80=A6]
Acknowledged


File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/36991047_c59736fd :
PS3, Line 344:   :code:`255.255.255.255`.
> for completeness mentions /32 as well.
Acknowledged


File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/61768e6b_7acc98ad :
PS3, Line 220:      ifconfig local rn
> Need to specify the two possibilities (IP address or netmask) separately.=
 [=E2=80=A6]
I think it stands for remote_netmask. I left it like this because I found i=
t mentioned in this form in the explanation that follows (line 237) but I a=
gree it isn't clear. I'm duplicating it to show both versions of ifconfig (=
remote and netmask) as you suggested. However this may not be completely co=
herent to --ifconfig-push (which has "local remote-netmask" arguments). Sho=
uld I change that one too accordingly?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/308f35e0_f16ee639 :
PS3, Line 266: 2 255
> Add /bits example here?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/1861ac78_b520ac5c :
PS3, Line 389:       route network|ipv4addr [netmask] [gateway] [metric]
> Does the network|ipv4addr here really add any value? Should we go just fo=
r ipv4addr here like with - [=E2=80=A6]
I didn't drop the "network" format because I thought it was referring to th=
e DNS resolvable name or special keywords as opposed to the ipv4 address. B=
ut I see that it can be a bit misleading therefore I will duplicate the lin=
es (network and ipv4addr).


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/ce30cce3_6ee36c90 :
PS3, Line 6103:         if (!p[2]) /* p[1] must be in CIDR format */
> Should probably do a ip_or_dns_addr_safe(p[1]) here? Might need to enhanc=
e that function to allow ne [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/10b9fbdb_8c9a2ae0 :
PS3, Line 7029: VERIFY_PERMISSION
> VERIFY_PERMISSION should go first
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/b4a5b082_b11cfef8 :
PS3, Line 7037:         if (cidr && !no_more_than_n_args(msglevel, p, 4, NM=
_QUOTE_HINT))
> Why NM_QUOTE_HINT?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/4c4dea4c_37ac9b94 :
PS3, Line 7042: OPT_P_ROUTE
> VERIFY_PERMISSION should go first
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/23a2b49a_8cb1624d :
PS3, Line 7047:             const char *network =3D strtok(p[i++], "/"); /*=
 this modifies p[1] */
> I find this very ugly. [=E2=80=A6]
Yes, definitely.


http://gerrit.openvpn.net/c/openvpn/+/739/comment/1f3bc400_01968578 :
PS3, Line 7071:             add_route_to_option_list(options->routes, p[1],=
 NULL, p[2], p[3]);
> Should we consider already normalizing the route here already and not par=
se the netmask vs netbits l [=E2=80=A6]
The parameters are all stored in string format because "network" and "gatew=
ay" can be ip addresses, resolvable names or even special keywords and the =
parsing is done in init_route(). If we were to search for the netbits here =
(in order to convert them into a netmask or vice versa) we would end up mov=
ing some of the init_route() logic here.
Anyway, once ip_or_dns_addr_safe() is improved to handle CIDR notated addre=
sses, do you still think the overhead introduced here is too much?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/03dc6477_3baf4f59 :
PS3, Line 7409:             if (!no_more_than_n_args(msglevel, p, 3, NM_QUO=
TE_HINT))
> Why NM_QUOTE_HINT?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/c67b2950_32857d05 :
PS3, Line 7424:                 msg(M_USAGE, "--server directive network/ne=
tmask combination is invalid");
> Why does this have a separate error message here but not in the sameish c=
ode in --server-bridge belo [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/68375742_e67a2168 :
PS3, Line 7487:             if (!no_more_than_n_args(msglevel, p, 4, NM_QUO=
TE_HINT))
> Why NM_QUOTE_HINT? Which argument could contain spaces?
None in fact, I just totally overlooked this flags honestly. Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/600e6ed7_2f6ddc3f :
PS3, Line 7898:             if (!no_more_than_n_args(msglevel, p, 3, NM_QUO=
TE_HINT))
> Why NM_QUOTE_HINT?
Acknowledged


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/ac8b37af_6f6e9a74 :
PS3, Line 324:     const in_addr_t default_netbits =3D IPV4_NETBITS_HOST;
> unsigned int?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/ee1f7533_80da73d9 :
PS3, Line 331:     const char *cidr =3D strchr(network, '/');
> Would convert to bool here to make it clear purpose
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/1b593f21_ba11a0bc :
PS3, Line 347: convert
> Want to do a drive-by fix? "a a" -> "to an"?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/fcdc0ae1_bb844192 :
PS3, Line 1105: route
> Maybe add a 0.0.0.0/1 and 128.0.0. [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/3eb2716e_74185bc0 :
PS3, Line 1166: route (
> Same (0.0.0.0/1 and 128.0.0.0/1) here.
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/2e313668_5df0fac8 :
PS3, Line 1456:
> Maybe we could move this into the if block? Not sure why we would create =
it otherwise?
Acknowledged


File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/6a23e054_db476467 :
PS3, Line 512:     const bool looks_like_netmask =3D addr && ((addr & 0xFF0=
00000) =3D=3D 0xFF000000);
> Isn't this redundant? If addr is 0 the second part never matches anyway
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/fe64f694_ae441e6d :
PS3, Line 524:=20=20=20
> Shouldn't that be "&&" ?
Yes, indeed


http://gerrit.openvpn.net/c/openvpn/+/739/comment/a2797ec0_d79ee4f7 :
PS3, Line 562:             const in_addr_t public_net =3D public &netmask;
> Add space after & ?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/739/comment/7d21b2d6_5f6efde8 :
PS3, Line 591: &
> Add space after &
Acknowledged



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
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 16 Sep 2024 15:54:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--Vu3dmQffs1k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">View C=
hange</a></p><p>25 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/739/comment/ef955895_c40062c5">Patch Set #3, Line 9:</a> <code style=
=3D"font-family:monospace,monospace">Add support for CIDR notation on all s=
uitable options (client-nat,</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Maybe give some more mot=
ivation here. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File doc/man-sections/server-options.rst:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/739/comment/36991047_c59736fd">Patch Set #3, Line 344:</a> <c=
ode style=3D"font-family:monospace,monospace">  :code:`255.255.255.255`.</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">for completeness mentions /32 as well.</blockquote></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-section=
s/vpn-network-options.rst:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/61768e6b_7a=
cc98ad">Patch Set #3, Line 220:</a> <code style=3D"font-family:monospace,mo=
nospace">     ifconfig local rn</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Need to specify the t=
wo possibilities (IP address or netmask) separately. [=E2=80=A6]</blockquot=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I think it=
 stands for remote_netmask. I left it like this because I found it mentione=
d in this form in the explanation that follows (line 237) but I agree it is=
n&#39;t clear. I&#39;m duplicating it to show both versions of ifconfig (re=
mote and netmask) as you suggested. However this may not be completely cohe=
rent to --ifconfig-push (which has &quot;local remote-netmask&quot; argumen=
ts). Should I change that one too accordingly?</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/739/comment/308f35e0_f16ee639">Patch Set #=
3, Line 266:</a> <code style=3D"font-family:monospace,monospace">2 255</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">Add /bits example here?</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/1861ac78_b520ac5c">Pa=
tch Set #3, Line 389:</a> <code style=3D"font-family:monospace,monospace"> =
     route network|ipv4addr [netmask] [gateway] [metric]</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">Does the network|ipv4addr here really add any value? Should we go just =
for ipv4addr here like with - [=E2=80=A6]</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">I didn&#39;t drop the &quot;netwo=
rk&quot; format because I thought it was referring to the DNS resolvable na=
me or special keywords as opposed to the ipv4 address. But I see that it ca=
n be a bit misleading therefore I will duplicate the lines (network and ipv=
4addr).</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/=
openvpn/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/ce30cce3_6ee36c90">=
Patch Set #3, Line 6103:</a> <code style=3D"font-family:monospace,monospace=
">        if (!p[2]) /* p[1] must be in CIDR format */</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Should probably do a ip_or_dns_addr_safe(p[1]) here? Might need to enhanc=
e that function to allow ne [=E2=80=A6]</blockquote></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/739/comment/10b9fbdb_8c9a2ae0">Patch=
 Set #3, Line 7029:</a> <code style=3D"font-family:monospace,monospace">VER=
IFY_PERMISSION</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">VERIFY_PERMISSION should go first</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ackn=
owledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/c=
omment/b4a5b082_b11cfef8">Patch Set #3, Line 7037:</a> <code style=3D"font-=
family:monospace,monospace">        if (cidr &amp;&amp; !no_more_than_n_arg=
s(msglevel, p, 4, NM_QUOTE_HINT))</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why NM_QUOTE_HINT?<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
39/comment/4c4dea4c_37ac9b94">Patch Set #3, Line 7042:</a> <code style=3D"f=
ont-family:monospace,monospace">OPT_P_ROUTE</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">VERIFY_P=
ERMISSION should go first</blockquote></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/739/comment/23a2b49a_8cb1624d">Patch Set #3, Line =
7047:</a> <code style=3D"font-family:monospace,monospace">            const=
 char *network =3D strtok(p[i++], &quot;/&quot;); /* this modifies p[1] */<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">I find this very ugly. [=E2=80=A6]</blockquote></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes, definitely.</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/1f3=
bc400_01968578">Patch Set #3, Line 7071:</a> <code style=3D"font-family:mon=
ospace,monospace">            add_route_to_option_list(options-&gt;routes, =
p[1], NULL, p[2], p[3]);</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">Should we consider already n=
ormalizing the route here already and not parse the netmask vs netbits l [=
=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">The parameters are all stored in string format because &quot;net=
work&quot; and &quot;gateway&quot; can be ip addresses, resolvable names or=
 even special keywords and the parsing is done in init_route(). If we were =
to search for the netbits here (in order to convert them into a netmask or =
vice versa) we would end up moving some of the init_route() logic here.<br>=
Anyway, once ip_or_dns_addr_safe() is improved to handle CIDR notated addre=
sses, do you still think the overhead introduced here is too much?</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/03dc6477_3=
baf4f59">Patch Set #3, Line 7409:</a> <code style=3D"font-family:monospace,=
monospace">            if (!no_more_than_n_args(msglevel, p, 3, NM_QUOTE_HI=
NT))</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">Why NM_QUOTE_HINT?</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/c67b2950_32857d05"=
>Patch Set #3, Line 7424:</a> <code style=3D"font-family:monospace,monospac=
e">                msg(M_USAGE, &quot;--server directive network/netmask co=
mbination is invalid&quot;);</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why does this have a sep=
arate error message here but not in the sameish code in --server-bridge bel=
o [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/739/comment/68375742_e67a2168">Patch Set #3, Line 7487:</a> <c=
ode style=3D"font-family:monospace,monospace">            if (!no_more_than=
_n_args(msglevel, p, 4, NM_QUOTE_HINT))</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why NM_QUOTE_=
HINT? Which argument could contain spaces?</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">None in fact, I just totally ove=
rlooked this flags honestly. Acknowledged</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/739/comment/600e6ed7_2f6ddc3f">Patch Set #3, Li=
ne 7898:</a> <code style=3D"font-family:monospace,monospace">            if=
 (!no_more_than_n_args(msglevel, p, 3, NM_QUOTE_HINT))</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Why NM_QUOTE_HINT?</blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/route.c:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/com=
ment/ac8b37af_6f6e9a74">Patch Set #3, Line 324:</a> <code style=3D"font-fam=
ily:monospace,monospace">    const in_addr_t default_netbits =3D IPV4_NETBI=
TS_HOST;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">unsigned int?</blockquote></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/ee1f7533_80da73d9">=
Patch Set #3, Line 331:</a> <code style=3D"font-family:monospace,monospace"=
>    const char *cidr =3D strchr(network, &#39;/&#39;);</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">Would convert to bool here to make it clear purpose</blockquote></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/1b593f21_=
ba11a0bc">Patch Set #3, Line 347:</a> <code style=3D"font-family:monospace,=
monospace">convert</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Want to do a drive-by fix? &quot;a=
 a&quot; -&gt; &quot;to an&quot;?</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/739/comment/fcdc0ae1_bb844192">Patch Set #=
3, Line 1105:</a> <code style=3D"font-family:monospace,monospace">route</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">Maybe add a 0.0.0.0/1 and 128.0.0. [=E2=80=A6]</blockquo=
te></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowled=
ged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/commen=
t/3eb2716e_74185bc0">Patch Set #3, Line 1166:</a> <code style=3D"font-famil=
y:monospace,monospace">route (</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Same (0.0.0.0/1 and 12=
8.0.0.0/1) here.</blockquote></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/739/comment/2e313668_5df0fac8">Patch Set #3, Line 1456:</a>=
 <code style=3D"font-family:monospace,monospace">  </code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">M=
aybe we could move this into the if block? Not sure why we would create it =
otherwise?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/tun.c:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/6a23e05=
4_db476467">Patch Set #3, Line 512:</a> <code style=3D"font-family:monospac=
e,monospace">    const bool looks_like_netmask =3D addr &amp;&amp; ((addr &=
amp; 0xFF000000) =3D=3D 0xFF000000);</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Isn&#39;t this r=
edundant? If addr is 0 the second part never matches anyway</blockquote></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/fe64=
f694_ae441e6d">Patch Set #3, Line 524:</a> <code style=3D"font-family:monos=
pace,monospace">  </code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Shouldn&#39;t that be &quot;&amp;&=
amp;&quot; ?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Yes, indeed</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/739/comment/a2797ec0_d79ee4f7">Patch Set #3, Line 562:</a> <code=
 style=3D"font-family:monospace,monospace">            const in_addr_t publ=
ic_net =3D public &amp;netmask;</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Add space after &amp;=
 ?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/739/comment/7d21b2d6_5f6efde8">Patch Set #3, Line 591:</a> <code style=3D=
"font-family:monospace,monospace">&amp;</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Add space aft=
er &amp;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Acknowledged</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">change 739</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/739?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Sep 2024 15:54:54=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Vu3dmQffs1k=--

