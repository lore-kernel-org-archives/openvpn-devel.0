From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 19 Sep 2024 11:10:41 +0000
In-Reply-To: <gerrit.1721311407000.Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d1@...2715...>
References: <gerrit.1721311407000.Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <87542ce3f7b6ac520989148a01b2051e03c207e9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5BSVfKT12IY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: copied
 'gateway_needed' logic from add_route_ipv6 to add_route
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5BSVfKT12IY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/677?usp=3Demail )

Change subject: route: copied 'gateway_needed' logic from add_route_ipv6 to=
 add_route
......................................................................


Patch Set 9:

(5 comments)

Patchset:

PS9:
Getting there...


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/677/comment/cc58944a_810b6a73 :
PS9, Line 1585: #if !defined(TARGET_LINUX)
why is that `#ifndef` moved`?  It's not used by the new Linux code either, =
or am I misreading it (so, no -Werror safe)?


http://gerrit.openvpn.net/c/openvpn/+/677/comment/fc88af46_52bd13d6 :
PS9, Line 1599:
this blank line (and the one at the end of the if()) feel superfluous


http://gerrit.openvpn.net/c/openvpn/+/677/comment/6c4000d3_493952ff :
PS9, Line 1616:     if (gateway_needed && r->gateway =3D=3D 0)
if we add this here, we might consider getting rid of this warning in `init=
_route()` then...  but this is a bit complex, as for most platforms `gatewa=
y_needed =3D true` is still valid, due to limits in route table handling


http://gerrit.openvpn.net/c/openvpn/+/677/comment/1ea919ca_7a56279c :
PS9, Line 1634: #if defined(TARGET_LINUX)
this needs to go - two `#if defined(TARGET_LINUX)` next to each other, with=
 nothing else in between.  Or am I misreading the diff?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/677?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id1ec0c6e4c391604ec5dbb8b7122f2e47ad186d1
Gerrit-Change-Number: 677
Gerrit-PatchSet: 9
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Thu, 19 Sep 2024 11:10:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--5BSVfKT12IY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/677?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
677?tab=3Dcomments">Patch Set #9:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Getting there...</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/route.c:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/677/comment/cc58944a_810b6a73">Patch Set #9, Line 1585:</a> <code style=
=3D"font-family:monospace,monospace">#if !defined(TARGET_LINUX)</code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">why is that `#ifn=
def` moved`?  It&#39;s not used by the new Linux code either, or am I misre=
ading it (so, no -Werror safe)?</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/677/comment/fc88af46_52bd13d6">Patch Set #9, Line 1599:</=
a> <code style=3D"font-family:monospace,monospace"></code></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">this blank line (and the one =
at the end of the if()) feel superfluous</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/677/comment/6c4000d3_493952ff">Patch Set #9, Lin=
e 1616:</a> <code style=3D"font-family:monospace,monospace">    if (gateway=
_needed &amp;&amp; r-&gt;gateway =3D=3D 0)</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">if we add this here, we might consider=
 getting rid of this warning in `init_route()` then...  but this is a bit c=
omplex, as for most platforms `gateway_needed =3D true` is still valid, due=
 to limits in route table handling</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/677/comment/1ea919ca_7a56279c">Patch Set #9, Line 1634=
:</a> <code style=3D"font-family:monospace,monospace">#if defined(TARGET_LI=
NUX)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">t=
his needs to go - two `#if defined(TARGET_LINUX)` next to each other, with =
nothing else in between.  Or am I misreading the diff?</p></li></ul></li></=
ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/677?u=
sp=3Demail">change 677</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/677?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id1ec0c6e4c391604ec5dbb8b712=
2f2e47ad186d1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 677 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Sep 2024 11:10:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--5BSVfKT12IY=--

