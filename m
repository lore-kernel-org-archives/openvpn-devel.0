From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 18 Sep 2025 12:08:42 +0000
In-Reply-To: <gerrit.1753364704000.Id492cb774c6d022d06bb3cf5fec2a4bdd410e619@...2715...>
References: <gerrit.1753364704000.Id492cb774c6d022d06bb3cf5fec2a4bdd410e619@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <89117934f8ec4122ad0768142d82f492dc302f2d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nHCR4P7AMl8="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Introduce msglvl_t
 to unify msglevel type handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nHCR4P7AMl8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1110?usp=3Demail )

Change subject: Introduce msglvl_t to unify msglevel type handling
......................................................................


Patch Set 16: Code-Review+2

(2 comments)

Patchset:

PS16:
LGTM


File src/openvpn/error.c:

http://gerrit.openvpn.net/c/openvpn/+/1110/comment/adb8b041_da6e06cc :
PS16, Line 104: set_debug_level(const int level, const unsigned int flags)
> I considered it, but then decided to leave it as is. I had to draw a boun=
dary somewhere. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1110?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id492cb774c6d022d06bb3cf5fec2a4bdd410e619
Gerrit-Change-Number: 1110
Gerrit-PatchSet: 16
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 18 Sep 2025 12:08:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: ordex <antonio@...2726...>
Gerrit-MessageType: comment

--nHCR4P7AMl8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 16:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1110?usp=3Demail">=
View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1110?tab=3Dcomments">Patch Set #16:</a> </p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">LGTM</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/error.c:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
110/comment/adb8b041_da6e06cc">Patch Set #16, Line 104:</a> <code style=3D"=
font-family:monospace,monospace">set_debug_level(const int level, const uns=
igned int flags)</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">I considered it, but then decided to=
 leave it as is. I had to draw a boundary somewhere. [=E2=80=A6]</blockquot=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1110?usp=3Demail">change 1110</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1110?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id492cb774c6d022d06bb3cf5fec=
2a4bdd410e619 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1110 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 18 Sep 2025 12:08:42=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--nHCR4P7AMl8=--

