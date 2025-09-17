From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 17 Sep 2025 10:19:40 +0000
In-Reply-To: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
References: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
Reply-To: arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <9456158c5fe7fcc7e6faa1921c0c540599a7f3c6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="I1qORfuz12U="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Install host routes
 with onlink scope iroutes for ifconfig-push routes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: d12fk <heiko@...515...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--I1qORfuz12U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, ordex.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1192?usp=3Demail )

Change subject: Install host routes with onlink scope iroutes for ifconfig-=
push routes
......................................................................


Patch Set 4:

(13 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/db3aa800_00ffb55b :
PS4, Line 7: Install host routes with onlink scope iroutes for ifconfig-pus=
h routes
> to be honest, this title feels a bit cryptic =F0=9F=98=84 [=E2=80=A6]
I tried to make it a bit easier to understand what is happening here.


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/8599ca43_fae0473b :
PS4, Line 10: of the configured device need to be added to the operating sy=
stem to
> the subject for "need" is "Additional IP addresses", but I think you mean=
t "a route to those IPs", r [=E2=80=A6]
ifconfig-push can be used for both. To either pick a specific IP address of=
 the pool or to specify an address outside of the pool. But pool is not rea=
lly correct here either as we really care about  --ifconfig here and not ab=
out --ifconfig-pool but --server typically sets to be the same.


File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/86c25c1c_10f45ae8 :
PS2, Line 317:   When DCO is enabled, OpenVPN will install a /32 route for =
the local IP
> Should this also be documented for `ifconfig-ipv6-push`?
I already documented. You seem to have commented on version 2 after I uploa=
ded v4.


File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/17f06b05_a6c4c15f :
PS4, Line 318:   address
> s/for/to/ [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/6b55d068_07d64a50 :
PS4, Line 330:   When DCO is enabled, OpenVPN will install a /128 route for=
 the local IP
> s/for/to/
Done


File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/b545dc09_22feb536 :
PS4, Line 729:         /* Check if we added the local network as /32 route =
as it was not in
> should we call it "client network", as "local" seems to be something loca=
l to the server
Done


File src/openvpn/mroute.h:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/442f986d_d8c6b1d1 :
PS2, Line 78: /* MRoute is an on link/scope address  ather than a route */
> Typo r`ather`
fixed already in v4.


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/413eed33_c08b5e0d :
PS4, Line 672:  *
> forgot to document "mi"
Done


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/f087988d_68fbfd53 :
PS2, Line 4347: /**
> Doxygen is already in the header file
Done


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/8e1814c1_f9785b38 :
PS4, Line 1251:         msg(D_MULTI_LOW, "MULTI: Adding /32 on-link route f=
or route %s -> %s",
> s/for route/for ifconfig-push/ ? (like you wrote in the ipv6 case)
Done


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/8e6958ef_74bd7374 :
PS4, Line 1262:     if (!primary)
> for clarity sake, shouldn't this be an "else if"? [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/4d8bd6f0_6be3546b :
PS4, Line 1315:     if (!primary)
> same
Done


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/de75b4bc_4f184632 :
PS4, Line 4353:  */
> I think we normally put the doxygen in one place only (i.e. header file),=
 so this can go.
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I83295e00d1a756dfa44050b0a4493095fb050fff
Gerrit-Change-Number: 1192
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Wed, 17 Sep 2025 10:19:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@...2726...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--I1qORfuz12U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, ordex. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">View =
Change</a></p><p>13 comments:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1192/comment/db3aa800_00ffb55b">Patch Set #4, Line 7:</a> <code sty=
le=3D"font-family:monospace,monospace">Install host routes with onlink scop=
e iroutes for ifconfig-push routes</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">to be honest, this=
 title feels a bit cryptic =F0=9F=98=84 [=E2=80=A6]</blockquote></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">I tried to make it a bi=
t easier to understand what is happening here.</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1192/comment/8599ca43_fae0473b">Patch Set =
#4, Line 10:</a> <code style=3D"font-family:monospace,monospace">of the con=
figured device need to be added to the operating system to</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">the subject for &quot;need&quot; is &quot;Additional IP addresses&quo=
t;, but I think you meant &quot;a route to those IPs&quot;, r [=E2=80=A6]</=
blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">i=
fconfig-push can be used for both. To either pick a specific IP address of =
the pool or to specify an address outside of the pool. But pool is not real=
ly correct here either as we really care about  --ifconfig here and not abo=
ut --ifconfig-pool but --server typically sets to be the same.</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/server-=
options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1192/comment/86c25c1c_10f45ae8">Patch=
 Set #2, Line 317:</a> <code style=3D"font-family:monospace,monospace">  Wh=
en DCO is enabled, OpenVPN will install a /32 route for the local IP</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">Should this also be documented for `ifconfig-ipv6-push`?</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I =
already documented. You seem to have commented on version 2 after I uploade=
d v4.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/ma=
n-sections/server-options.rst:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192/comment/17f06b=
05_a6c4c15f">Patch Set #4, Line 318:</a> <code style=3D"font-family:monospa=
ce,monospace">  address </code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">s/for/to/ [=E2=80=A6]</block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192/comment/6b=
55d068_07d64a50">Patch Set #4, Line 330:</a> <code style=3D"font-family:mon=
ospace,monospace">  When DCO is enabled, OpenVPN will install a /128 route =
for the local IP</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">s/for/to/</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1192/comment/b545dc09_22feb536">Patch Set #4, Line 729:</a> <c=
ode style=3D"font-family:monospace,monospace">        /* Check if we added =
the local network as /32 route as it was not in</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">shoul=
d we call it &quot;client network&quot;, as &quot;local&quot; seems to be s=
omething local to the server</blockquote></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/mroute.h:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192/c=
omment/442f986d_d8c6b1d1">Patch Set #2, Line 78:</a> <code style=3D"font-fa=
mily:monospace,monospace">/* MRoute is an on link/scope address  ather than=
 a route */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">Typo r`ather`</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">fixed already in v4.</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.=
h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1192/comment/413eed33_c08b5e0d">Patch Set #4, L=
ine 672:</a> <code style=3D"font-family:monospace,monospace"> *</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">forgot to document &quot;mi&quot;</blockquote></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1192/comment/f087988d_68fbfd53">Patch Set #2, Line 4347:</a> <code=
 style=3D"font-family:monospace,monospace">/**</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Doxyge=
n is already in the header file</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192=
/comment/8e1814c1_f9785b38">Patch Set #4, Line 1251:</a> <code style=3D"fon=
t-family:monospace,monospace">        msg(D_MULTI_LOW, &quot;MULTI: Adding =
/32 on-link route for route %s -&gt; %s&quot;,</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">s/for =
route/for ifconfig-push/ ? (like you wrote in the ipv6 case)</blockquote></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192/comment/8e6958ef_7=
4bd7374">Patch Set #4, Line 1262:</a> <code style=3D"font-family:monospace,=
monospace">    if (!primary)</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">for clarity sake, should=
n&#39;t this be an &quot;else if&quot;? [=E2=80=A6]</blockquote></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1192/comment/4d8bd6f0_6be3546b"=
>Patch Set #4, Line 1315:</a> <code style=3D"font-family:monospace,monospac=
e">    if (!primary)</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">same</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1192/comment/de75b4bc_4f184632">Patc=
h Set #4, Line 4353:</a> <code style=3D"font-family:monospace,monospace"> *=
/</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">I think we normally put the doxygen in one place on=
ly (i.e. header file), so this can go.</blockquote></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail=
">change 1192</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I83295e00d1a756dfa44050b0a44=
93095fb050fff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1192 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 17 Sep 2025 10:19:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--I1qORfuz12U=--

