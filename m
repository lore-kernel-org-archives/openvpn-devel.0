From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 21 Jul 2025 19:21:15 +0000
In-Reply-To: <gerrit.1732124549000.Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2@...2715...>
References: <gerrit.1732124549000.Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <926253eb77676ac83f023b63ea8cd8ef278a4fcf-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ypWNGxvKpZ8="; charset=UTF-8
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
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ypWNGxvKpZ8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/810?usp=3Demail )

Change subject: PUSH_UPDATE: Added update_option() function.
......................................................................


Patch Set 21: Code-Review-1

(5 comments)

Patchset:

PS21:
Nagging about code duplication...


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/810/comment/e80b547e_689dbd50 :
PS21, Line 5897:             }
I find this duplication of syntax checking, mmmh, sub-optimal.  We'll check=
 the syntax anyway in `add_option()` later on...

I could see user complaints about "I sent a PUSH_UPDATE with one invalid `r=
oute` in it, and all my routes were lost", but honestly, do we really care =
that much?  (If yes, we could consider moving the syntax check into a small=
 helper, if not, just drop the lines from `rol_check_alloc()` up to this li=
ne).


http://gerrit.openvpn.net/c/openvpn/+/810/comment/e1f5b5bd_f34b1d7f :
PS21, Line 5927:             }
same here


http://gerrit.openvpn.net/c/openvpn/+/810/comment/4054ed13_3dac7037 :
PS21, Line 6009:
same here... lots of code that needs to be in sync with the add_option() ch=
ecks...


http://gerrit.openvpn.net/c/openvpn/+/810/comment/abc555fa_e0e5856c :
PS21, Line 6045: #endif
I note a distinct lack of syntax checking for `dhcp-option` ;-)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2
Gerrit-Change-Number: 810
Gerrit-PatchSet: 21
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Mon, 21 Jul 2025 19:21:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--ypWNGxvKpZ8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>Patch set 21:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail">V=
iew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/810?tab=3Dcomments">Patch Set #21:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Nagging about code duplication...</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/810/comment/e80b547e_689dbd50">Patch Set #21, Li=
ne 5897:</a> <code style=3D"font-family:monospace,monospace">            }<=
/code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I find=
 this duplication of syntax checking, mmmh, sub-optimal.  We&#39;ll check t=
he syntax anyway in `add_option()` later on...</p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I could see user complaints about &quot;I=
 sent a PUSH_UPDATE with one invalid `route` in it, and all my routes were =
lost&quot;, but honestly, do we really care that much?  (If yes, we could c=
onsider moving the syntax check into a small helper, if not, just drop the =
lines from `rol_check_alloc()` up to this line).</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/810/comment/e1f5b5bd_f34b1d7f">Patch Set=
 #21, Line 5927:</a> <code style=3D"font-family:monospace,monospace">      =
      }</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">same here</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
10/comment/4054ed13_3dac7037">Patch Set #21, Line 6009:</a> <code style=3D"=
font-family:monospace,monospace"></code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">same here... lots of code that needs to be in s=
ync with the add_option() checks...</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/810/comment/abc555fa_e0e5856c">Patch Set #21, Line 60=
45:</a> <code style=3D"font-family:monospace,monospace">#endif</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">I note a distinct =
lack of syntax checking for `dhcp-option` ;-)</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demai=
l">change 810</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia45c99e6df7b3ad24020c10b8a9=
b3577984ecdc2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 810 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 21 Jul 2025 19:21:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ypWNGxvKpZ8=--

