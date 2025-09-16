From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 16 Sep 2025 21:19:39 +0000
In-Reply-To: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
References: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7f19b9d91d6f6dc4e099579b958b3e218b83bd4f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qhcSdNtJDtI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: d12fk <heiko@...515...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qhcSdNtJDtI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1192?usp=3Demail )

Change subject: Install host routes with onlink scope iroutes for ifconfig-=
push routes
......................................................................


Patch Set 4: Code-Review+1

(12 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/6b060a08_b9b15038 :
PS4, Line 7: Install host routes with onlink scope iroutes for ifconfig-pus=
h routes
to be honest, this title feels a bit cryptic =F0=9F=98=84
maybe it can be simplified a little, since we have the longer description b=
elow?


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/955bcbc5_de33bffb :
PS4, Line 10: of the configured device need to be added to the operating sy=
stem to
the subject for "need" is "Additional IP addresses", but I think you meant =
"a route to those IPs", right? So this sentence should be massaged a little.

Moreover, is `ifconfig-push` really creating an "Additional IP" or is it ju=
st substituting the IP assigned out of the server pool?


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/9e07abea_3c127d4d :
PS4, Line 15: iroute, will not work.
should we add "because the server does not have an address in the same netw=
ork as these IPs assigned to the VPN interface" (some something alike)?

Just to make sure in 5 months from now we recall why we did this.


Patchset:

PS4:
patch looks good to me. I just have a few minor nitpicks..


File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/a86c4865_793f1207 :
PS4, Line 318:   address
s/for/to/
s/ /./


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/bff8681a_b8c91a88 :
PS4, Line 330:   When DCO is enabled, OpenVPN will install a /128 route for=
 the local IP
s/for/to/


File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/d9ae49b2_0ce9bbcd :
PS4, Line 729:         /* Check if we added the local network as /32 route =
as it was not in
should we call it "client network", as "local" seems to be something local =
to the server


File src/openvpn/multi.h:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/c67d489a_5aa0fbc8 :
PS4, Line 672:  *
forgot to document "mi"


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/d08232ec_d390068e :
PS4, Line 1251:         msg(D_MULTI_LOW, "MULTI: Adding /32 on-link route f=
or route %s -> %s",
s/for route/for ifconfig-push/ ? (like you wrote in the ipv6 case)


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/bed1bbae_c70f9021 :
PS4, Line 1262:     if (!primary)
for clarity sake, shouldn't this be an "else if"?
From a functional perspective it shouldn't make a difference.


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/8760fe93_46153291 :
PS4, Line 1315:     if (!primary)
same


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/4a7ec029_5c48f9ed :
PS4, Line 4353:  */
I think we normally put the doxygen in one place only (i.e. header file), s=
o this can go.



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 16 Sep 2025 21:19:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--qhcSdNtJDtI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">V=
iew Change</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1192/comment/6b060a08_b9b15038">Patch Set #4, Line 7:</a> <cod=
e style=3D"font-family:monospace,monospace">Install host routes with onlink=
 scope iroutes for ifconfig-push routes</code></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">to be honest, this title feels a bit cryp=
tic =F0=9F=98=84<br>maybe it can be simplified a little, since we have the =
longer description below?</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1192/comment/955bcbc5_de33bffb">Patch Set #4, Line 10:</a> <cod=
e style=3D"font-family:monospace,monospace">of the configured device need t=
o be added to the operating system to</code></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">the subject for &quot;need&quot; is &quot;A=
dditional IP addresses&quot;, but I think you meant &quot;a route to those =
IPs&quot;, right? So this sentence should be massaged a little.</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Moreover, is `ifconfig-p=
ush` really creating an &quot;Additional IP&quot; or is it just substitutin=
g the IP assigned out of the server pool?</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1192/comment/9e07abea_3c127d4d">Patch Set #4, L=
ine 15:</a> <code style=3D"font-family:monospace,monospace">iroute, will no=
t work.</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">should we add &quot;because the server does not have an address in the sa=
me network as these IPs assigned to the VPN interface&quot; (some something=
 alike)?</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Just=
 to make sure in 5 months from now we recall why we did this.</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1192?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">patch looks good to me. I just have a few m=
inor nitpicks..</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile doc/man-sections/server-options.rst:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192/comm=
ent/a86c4865_793f1207">Patch Set #4, Line 318:</a> <code style=3D"font-fami=
ly:monospace,monospace">  address </code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">s/for/to/<br>s/ /./</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1192/comment/bff8681a_b8c91a88">Patch Se=
t #4, Line 330:</a> <code style=3D"font-family:monospace,monospace">  When =
DCO is enabled, OpenVPN will install a /128 route for the local IP</code></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">s/for/to/</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco.=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1192/comment/d9ae49b2_0ce9bbcd">Patch Set #4, L=
ine 729:</a> <code style=3D"font-family:monospace,monospace">        /* Che=
ck if we added the local network as /32 route as it was not in</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">should we call it =
&quot;client network&quot;, as &quot;local&quot; seems to be something loca=
l to the server</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/multi.h:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192/comment/c67d489a_5aa=
0fbc8">Patch Set #4, Line 672:</a> <code style=3D"font-family:monospace,mon=
ospace"> *</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">forgot to document &quot;mi&quot;</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
192/comment/d08232ec_d390068e">Patch Set #4, Line 1251:</a> <code style=3D"=
font-family:monospace,monospace">        msg(D_MULTI_LOW, &quot;MULTI: Addi=
ng /32 on-link route for route %s -&gt; %s&quot;,</code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">s/for route/for ifconfig-push/ =
? (like you wrote in the ipv6 case)</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1192/comment/bed1bbae_c70f9021">Patch Set #4, Line 12=
62:</a> <code style=3D"font-family:monospace,monospace">    if (!primary)</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">for cla=
rity sake, shouldn&#39;t this be an &quot;else if&quot;?<br>From a function=
al perspective it shouldn&#39;t make a difference.</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1192/comment/8760fe93_46153291">Patch =
Set #4, Line 1315:</a> <code style=3D"font-family:monospace,monospace">    =
if (!primary)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">same</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
192/comment/4a7ec029_5c48f9ed">Patch Set #4, Line 4353:</a> <code style=3D"=
font-family:monospace,monospace"> */</code></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">I think we normally put the doxygen in one p=
lace only (i.e. header file), so this can go.</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Dema=
il">change 1192</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 16 Sep 2025 21:19:39=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--qhcSdNtJDtI=--

