From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 22 Jan 2025 09:17:28 +0000
In-Reply-To: <gerrit.1732124549000.Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2@...2715...>
References: <gerrit.1732124549000.Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5772b46f2e15d9f27a15d3399d8682aaef548b80-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XI2HkPT7e4o="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: Added
 update_option() function.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XI2HkPT7e4o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/810?usp=3Demail )

Change subject: PUSH_UPDATE: Added update_option() function.
......................................................................


Patch Set 12: Code-Review+2

(1 comment)

Patchset:

PS12:
I tested those 3 patches together - looks good. I was able to replace route=
s, remove routes, change IP address and revert it back.

It would me nice to make it work also for dco-win (which is a default drive=
r) - at the moment we don't support reopening dco device - but this could b=
e done later.



--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2
Gerrit-Change-Number: 810
Gerrit-PatchSet: 12
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Wed, 22 Jan 2025 09:17:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--XI2HkPT7e4o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>Patch set 12:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/810?tab=3Dcomments">Patch Set #12:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">I tested those 3 patches together - looks go=
od. I was able to replace routes, remove routes, change IP address and reve=
rt it back. </p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
It would me nice to make it work also for dco-win (which is a default drive=
r) - at the moment we don&#39;t support reopening dco device - but this cou=
ld be done later.</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail">change 810</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/810?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia45c99e6df7b3ad24020c10b8a9=
b3577984ecdc2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 810 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jan 2025 09:17:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--XI2HkPT7e4o=--

