From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 19 Oct 2025 09:49:39 +0000
In-Reply-To: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
References: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <730e59c345a9702b29523369b7d3d3a415267275-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IEeIDQGDsVk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Install host routes
 for ifconfig-push routes when DCO is enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: d12fk <heiko@...515...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IEeIDQGDsVk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change by plaisthos. ( http://gerrit.open=
vpn.net/c/openvpn/+/1192?usp=3Demail )

Change subject: Install host routes for ifconfig-push routes when DCO is en=
abled
......................................................................


Patch Set 11:

(1 comment)

File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/55223ae1_ab140e86?usp=3D=
email :
PS11, Line 4377:                                     &o->push_ifconfig_ipv6=
_local));
Ah, here we go.  This fails if there is *no* `ifconfig-ipv6-push` in the co=
nfig, as then we have

```
(gdb) print o->push_ifconfig_ipv6_local
$10 =3D {__u6_addr =3D {__u6_addr8 =3D '\000' <repeats 15 times>, __u6_addr=
16 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 =3D {0, 0, 0, 0}}}
```

... and that obviously does not match.

From reading the code in `dco_delete_iroutes()`, this looks as if the chec=
k should be on `mi->context.c2.push_ifconfig_local` and not `mi->context.op=
tions.push_ifconfig_ipv6_local`?

... later... yep, this works:

```
    struct context_2 *c2 =3D &mi->context.c2;
    return (!ipv6_net_contains_host(&ifconfig_local, o->ifconfig_ipv6_netbi=
ts,
                                    &c2->push_ifconfig_ipv6_local));
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I83295e00d1a756dfa44050b0a4493095fb050fff
Gerrit-Change-Number: 1192
Gerrit-PatchSet: 11
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Sun, 19 Oct 2025 09:49:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--IEeIDQGDsVk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, flichtenheld, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1192/comment/55223ae1_ab140e86?usp=3Demail">Patch Set #11, =
Line 4377:</a> <code style=3D"font-family:monospace,monospace">            =
                        &amp;o-&gt;push_ifconfig_ipv6_local));</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A=
h, here we go.  This fails if there is *no* `ifconfig-ipv6-push` in the con=
fig, as then we have</p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">```<br>(gdb) print o-&gt;push_ifconfig_ipv6_local<=
br>$10 =3D {__u6_addr =3D {__u6_addr8 =3D &#39;\000&#39; &lt;repeats 15 tim=
es&gt;, __u6_addr16 =3D {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 =3D {0, 0, 0,=
 0}}}<br>```</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">... and that obviously does not match.</p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">From reading th=
e code in `dco_delete_iroutes()`, this looks as if the check should be on `=
mi-&gt;context.c2.push_ifconfig_local` and not `mi-&gt;context.options.push=
_ifconfig_ipv6_local`?  </p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">... later... yep, this works:</p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>``` <br>    struct context_2 *c2 =3D &amp;mi-&gt;context.c2;<br>    return=
 (!ipv6_net_contains_host(&amp;ifconfig_local, o-&gt;ifconfig_ipv6_netbits,=
<br>                                    &amp;c2-&gt;push_ifconfig_ipv6_loca=
l));<br>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">change 1192</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1192?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I83295e00d1a756dfa44050b0a44=
93095fb050fff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1192 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 19 Oct 2025 09:49:39=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--IEeIDQGDsVk=--

