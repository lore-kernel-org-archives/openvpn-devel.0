From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 16 Sep 2025 21:40:03 +0000
In-Reply-To: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
References: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <58253d1d13d8e3a8668f7af17bb8e7f64567c746-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="crgFEgBF3e0="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--crgFEgBF3e0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1192?usp=3Demail )

Change subject: Install host routes with onlink scope iroutes for ifconfig-=
push routes
......................................................................


Patch Set 4:

(2 comments)

File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/a01854be_05971411 :
PS2, Line 317:   When DCO is enabled, OpenVPN will install a /32 route for =
the local IP
> @heiko@...2292... [=E2=80=A6]
Yeah, was looking at an old version.


File src/openvpn/mroute.h:

http://gerrit.openvpn.net/c/openvpn/+/1192/comment/8364575a_c2f0e56d :
PS2, Line 78: /* MRoute is an on link/scope address  ather than a route */
> Typo r`ather`
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
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Tue, 16 Sep 2025 21:40:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@...2726...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--crgFEgBF3e0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/server-optio=
ns.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1192/comment/a01854be_05971411">Patch Set =
#2, Line 317:</a> <code style=3D"font-family:monospace,monospace">  When DC=
O is enabled, OpenVPN will install a /32 route for the local IP</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">@heiko@...2292... [=E2=80=A6]</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Yeah, was looking at an old versio=
n.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openv=
pn/mroute.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1192/comment/8364575a_c2f0e56d">Patch=
 Set #2, Line 78:</a> <code style=3D"font-family:monospace,monospace">/* MR=
oute is an on link/scope address  ather than a route */</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">Typo r`ather`</blockquote></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">change 1192</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1192?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 16 Sep 2025 21:40:03=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--crgFEgBF3e0=--

