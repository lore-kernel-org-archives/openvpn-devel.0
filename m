From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 17 Sep 2025 11:01:39 +0000
In-Reply-To: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
References: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <de7c0b9b7e95c1505cdbf53d75d95a710056a15f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x5UAw2boC1k="; charset=UTF-8
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

--x5UAw2boC1k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1192?usp=3Demail )

Change subject: Install host routes with onlink scope iroutes for ifconfig-=
push routes
......................................................................


Patch Set 4:

(3 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/e68f700d_fb964762 :
PS4, Line 7: Install host routes with onlink scope iroutes for ifconfig-pus=
h routes
> I tried to make it a bit easier to understand what is happening here.
how about:

DCO: install onlink host iroute when pushed IP is out of server network

?


http://gerrit.openvpn.net/c/openvpn/+/1192/comment/e81bb1a9_d227e995 :
PS4, Line 10: of the configured device need to be added to the operating sy=
stem to
> ifconfig-push can be used for both. [=E2=80=A6]
I agree with that, but what I meant in my comment is that we "need *routes*=
 to be added" not IPs.
In your text you're implying we need to add IPs "..to the operating system.=
."


File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/c74c5864_8023ffde :
PS2, Line 317:   When DCO is enabled, OpenVPN will install a /32 route for =
the local IP
> I already documented. You seem to have commented on version 2 after I upl=
oaded v4.
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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Wed, 17 Sep 2025 11:01:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: ordex <antonio@...2726...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--x5UAw2boC1k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1192/comment/e68f700d_fb964762">Patch Set #4, Line 7:</a> <code styl=
e=3D"font-family:monospace,monospace">Install host routes with onlink scope=
 iroutes for ifconfig-push routes</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I tried to make it =
a bit easier to understand what is happening here.</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">how about:</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">DCO: install onlink host=
 iroute when pushed IP is out of server network</p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">?</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1192/comment/e81bb1a9_d227e995">Patch Set #4, Line 1=
0:</a> <code style=3D"font-family:monospace,monospace">of the configured de=
vice need to be added to the operating system to</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">ifco=
nfig-push can be used for both. [=E2=80=A6]</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">I agree with that, but what I m=
eant in my comment is that we &quot;need *routes* to be added&quot; not IPs=
.<br>In your text you&#39;re implying we need to add IPs &quot;..to the ope=
rating system..&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File doc/man-sections/server-options.rst:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
192/comment/c74c5864_8023ffde">Patch Set #2, Line 317:</a> <code style=3D"f=
ont-family:monospace,monospace">  When DCO is enabled, OpenVPN will install=
 a /32 route for the local IP</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I already documented. Y=
ou seem to have commented on version 2 after I uploaded v4.</blockquote></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1192?usp=3Demail">change 1192</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 17 Sep 2025 11:01:39=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--x5UAw2boC1k=--

