From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 21 Oct 2025 14:10:18 +0000
In-Reply-To: <gerrit.1722331476000.I87777e74b1fd34781e1d72c9f994eb84f39d800c@...2715...>
References: <gerrit.1722331476000.I87777e74b1fd34781e1d72c9f994eb84f39d800c@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <94ac3cf1d06dfa9a8f59f1a8c87efea1c9849242-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="egkxHDIzdP4="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--egkxHDIzdP4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

mrbff has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/721?usp=3Demail )

Change subject: route: extended logic to omit gateway when unnecessary
......................................................................


Patch Set 12:

(6 comments)

File src/openvpn/route.h:

http://gerrit.openvpn.net/c/openvpn/+/721/comment/0a1b545d_f913bbc8?usp=3De=
mail :
PS11, Line 274: bool add_route_ipv6(struct route_ipv6 *r, const struct tunt=
ap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ct=
x, const bool is_multipoint);
> The naming here and the usage seem to disagree. [=E2=80=A6]
Done


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/721/comment/aaa6380b_66ab5947?usp=3De=
mail :
PS11, Line 1811:     /* FIXME -- add on-link support for Dragonfly */
> Has this been really tested on DragonFly BSD?
i tested on the first patch but i tested again the #12 on 6.4.2 and found a=
lso a bug with the ifconfig, i fixed just moving from #if defined(TARGET_FR=
EEBSD) || defined (TARGET_DRAGONFLY) code to #if defined(TARGET_NETBSD) || =
defined (TARGET_DRAGONFLY) code in do_ifconfig_ipv4(). Here the logs:

master:
2025-10-20 13:36:42 PUSH: Received control message: 'PUSH_REPLY,route-gatew=
ay 10.23.100.1,topology subnet,ping 5,ping-restart 30,ifconfig 10.23.100.2 =
255.255.255.0,peer-id 0,cipher AES-256-GCM,protocol-flags cc-exit tls-ekm d=
yn-tls-crypt,tun-mtu 1500'
2025-10-20 13:36:42 OPTIONS IMPORT: --ifconfig/up options modified
2025-10-20 13:36:42 OPTIONS IMPORT: route-related options modified
2025-10-20 13:36:42 OPTIONS IMPORT: tun-mtu set to 1500
2025-10-20 13:36:42 TUN/TAP device tun0 exists previously, keep at program =
end
2025-10-20 13:36:42 TUN/TAP device /dev/tun0 opened
2025-10-20 13:36:42 tun/tap device [tun0] opened

2025-10-20 13:36:42 /sbin/ifconfig tun0 10.23.100.2/24 mtu 1500 up
ifconfig: ioctl (SIOCAIFADDR): Destination address required
2025-10-20 13:36:42 FreeBSD ifconfig failed: external program exited with e=
rror status: 1
2025-10-20 13:36:42 Exiting due to fatal error


patchset #12:
2025-10-20 13:43:42 PUSH: Received control message: 'PUSH_REPLY,route-gatew=
ay 10.23.100.1,topology subnet,ping 5,ping-restart 30,ifconfig 10.23.100.2 =
255.255.255.0,peer-id 0,cipher AES-256-GCM,protocol-flags cc-exit tls-ekm d=
yn-tls-crypt,tun-mtu 1500'
2025-10-20 13:43:42 OPTIONS IMPORT: --ifconfig/up options modified
2025-10-20 13:43:42 OPTIONS IMPORT: route-related options modified
2025-10-20 13:43:42 OPTIONS IMPORT: tun-mtu set to 1500
2025-10-20 13:43:42 TUN/TAP device tun0 exists previously, keep at program =
end
2025-10-20 13:43:42 TUN/TAP device /dev/tun0 opened
2025-10-20 13:43:42 tun/tap device [tun0] opened

2025-10-20 13:43:42 /sbin/ifconfig tun0 10.23.100.2 10.23.100.1 mtu 1500 ne=
tmask 255.255.255.0 up
2025-10-20 13:43:42 /sbin/route add -net 10.23.100.0 -iface tun0
add net 10.23.100.0: gateway tun0

2025-10-20 13:43:42 Initialization Sequence Completed


If you have any thought about it or something to suggest (or some particula=
r test) please feel free to share


http://gerrit.openvpn.net/c/openvpn/+/721/comment/b2bc803a_7e364e02?usp=3De=
mail :
PS11, Line 1600:         && !( (r4->flags & RT_METRIC_DEFINED) && r4->metri=
c =3D=3D 0 ) )
> how does the metric play into needing a gateway or not?
Done


http://gerrit.openvpn.net/c/openvpn/+/721/comment/2a5d88e2_1d00ff0a?usp=3De=
mail :
PS11, Line 1607:         return true;
> There should at least be some idea/comment in the source code as well. [=
=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/721/comment/85295ff5_ccdfe664?usp=3De=
mail :
PS11, Line 1898:     }
> Has this been tested on Open and NetBSD?
it was already tested from the first patch but i retested the latest patch =
on dradonfly 6.4.2, openbsd 7.7, freebsd 14.3, netbsd 10.0 and MacOS sonoma


http://gerrit.openvpn.net/c/openvpn/+/721/comment/0b6b4458_7d49c544?usp=3De=
mail :
PS11, Line 2010: {
> I think this duplicates the code that was publicly accessible in https://=
gerrit.openvpn. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87777e74b1fd34781e1d72c9f994eb84f39d800c
Gerrit-Change-Number: 721
Gerrit-PatchSet: 12
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Tue, 21 Oct 2025 14:10:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: ordex <antonio@...2726...>

--egkxHDIzdP4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail">View C=
hange</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.h:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/721/comment/0a1b545d_f913bbc8?usp=3Demail">Patch Set #11, L=
ine 274:</a> <code style=3D"font-family:monospace,monospace">bool add_route=
_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, co=
nst struct env_set *es, openvpn_net_ctx_t *ctx, const bool is_multipoint);<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">The naming here and the usage seem to disagree. [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/route.c:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/721/comment=
/aaa6380b_66ab5947?usp=3Demail">Patch Set #11, Line 1811:</a> <code style=
=3D"font-family:monospace,monospace">    /* FIXME -- add on-link support fo=
r Dragonfly */</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">Has this been really tested on DragonF=
ly BSD?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">i tested on the first patch but i tested again the=
 #12 on 6.4.2 and found also a bug with the ifconfig, i fixed just moving f=
rom #if defined(TARGET_FREEBSD) || defined (TARGET_DRAGONFLY) code to #if d=
efined(TARGET_NETBSD) || defined (TARGET_DRAGONFLY) code in do_ifconfig_ipv=
4(). Here the logs:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">master:<br>2025-10-20 13:36:42 PUSH: Received contr=
ol message: &#39;PUSH_REPLY,route-gateway 10.23.100.1,topology subnet,ping =
5,ping-restart 30,ifconfig 10.23.100.2 255.255.255.0,peer-id 0,cipher AES-2=
56-GCM,protocol-flags cc-exit tls-ekm dyn-tls-crypt,tun-mtu 1500&#39;<br>20=
25-10-20 13:36:42 OPTIONS IMPORT: --ifconfig/up options modified<br>2025-10=
-20 13:36:42 OPTIONS IMPORT: route-related options modified<br>2025-10-20 1=
3:36:42 OPTIONS IMPORT: tun-mtu set to 1500<br>2025-10-20 13:36:42 TUN/TAP =
device tun0 exists previously, keep at program end<br>2025-10-20 13:36:42 T=
UN/TAP device /dev/tun0 opened<br>2025-10-20 13:36:42 tun/tap device [tun0]=
 opened</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">2025-10-20 13:36:42 /sbin/ifconfig tun0 10.23.100.2/24 mtu 1500=
 up<br>ifconfig: ioctl (SIOCAIFADDR): Destination address required<br>2025-=
10-20 13:36:42 FreeBSD ifconfig failed: external program exited with error =
status: 1<br>2025-10-20 13:36:42 Exiting due to fatal error</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"><br>patchse=
t #12:<br>2025-10-20 13:43:42 PUSH: Received control message: &#39;PUSH_REP=
LY,route-gateway 10.23.100.1,topology subnet,ping 5,ping-restart 30,ifconfi=
g 10.23.100.2 255.255.255.0,peer-id 0,cipher AES-256-GCM,protocol-flags cc-=
exit tls-ekm dyn-tls-crypt,tun-mtu 1500&#39;<br>2025-10-20 13:43:42 OPTIONS=
 IMPORT: --ifconfig/up options modified<br>2025-10-20 13:43:42 OPTIONS IMPO=
RT: route-related options modified<br>2025-10-20 13:43:42 OPTIONS IMPORT: t=
un-mtu set to 1500<br>2025-10-20 13:43:42 TUN/TAP device tun0 exists previo=
usly, keep at program end<br>2025-10-20 13:43:42 TUN/TAP device /dev/tun0 o=
pened<br>2025-10-20 13:43:42 tun/tap device [tun0] opened</p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">2025-10-20 13=
:43:42 /sbin/ifconfig tun0 10.23.100.2 10.23.100.1 mtu 1500 netmask 255.255=
.255.0 up<br>2025-10-20 13:43:42 /sbin/route add -net 10.23.100.0 -iface tu=
n0<br>add net 10.23.100.0: gateway tun0</p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">2025-10-20 13:43:42 Initializat=
ion Sequence Completed</p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;"><br>If you have any thought about it or somethin=
g to suggest (or some particular test) please feel free to share</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/721/comment/b2bc803a_7e3=
64e02?usp=3Demail">Patch Set #11, Line 1600:</a> <code style=3D"font-family=
:monospace,monospace">        &amp;&amp; !( (r4-&gt;flags &amp; RT_METRIC_D=
EFINED) &amp;&amp; r4-&gt;metric =3D=3D 0 ) )</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">how doe=
s the metric play into needing a gateway or not?</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/721/comment/2a5d=
88e2_1d00ff0a?usp=3Demail">Patch Set #11, Line 1607:</a> <code style=3D"fon=
t-family:monospace,monospace">        return true;</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Th=
ere should at least be some idea/comment in the source code as well. [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/721/comment/85295ff5_ccdfe664?usp=3Demail">Patch Set #11, L=
ine 1898:</a> <code style=3D"font-family:monospace,monospace">    }</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Has this been tested on Open and NetBSD?</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">it=
 was already tested from the first patch but i retested the latest patch on=
 dradonfly 6.4.2, openbsd 7.7, freebsd 14.3, netbsd 10.0 and MacOS sonoma</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/721/comment/0b6=
b4458_7d49c544?usp=3Demail">Patch Set #11, Line 2010:</a> <code style=3D"fo=
nt-family:monospace,monospace">{</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I think this duplica=
tes the code that was publicly accessible in https://gerrit.openvpn. [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail">change 721</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/721?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87777e74b1fd34781e1d72c9f99=
4eb84f39d800c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 721 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 21 Oct 2025 14:10:18=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>

</body></html>=

--egkxHDIzdP4=--

