From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 16:48:29 +0000
In-Reply-To: <gerrit.1725891072000.I8c0e9f32b235cb262ca2be6aac8d520e49b30d74@...2715...>
References: <gerrit.1725891072000.I8c0e9f32b235cb262ca2be6aac8d520e49b30d74@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <57b6a91ca0d4d039be0af01a2ee36e245106fba7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y/C7WzSKeek="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move to common
 backend_driver type in struct tuntap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--y/C7WzSKeek=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/738?usp=3Demail )

Change subject: Move to common backend_driver type in struct tuntap
......................................................................


Patch Set 7:

(2 comments)

File src/openvpn/tun.h:

http://gerrit.openvpn.net/c/openvpn/+/738/comment/2be53bb0_c2ced10a :
PS5, Line 46: #ifdef WIN32
> Do we really need pre-processor here? Doesn't hurt if the enum contains u=
nused values, does it?
It is different philosophies. One could argue that you catch a windows only=
 define used out of windows only code. The other is that too many define/if=
defs are worse.


File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/738/comment/369450ea_d033a0b6 :
PS5, Line 63: #ifdef WIN32
> Again, don't think we really need the #ifdefs here...
DO you propose to have them always be defined?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/738?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8c0e9f32b235cb262ca2be6aac8d520e49b30d74
Gerrit-Change-Number: 738
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 17 Sep 2024 16:48:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--y/C7WzSKeek=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/738?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun.h:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/738/comment/2be53bb0_c2ced10a">Patch Set #5, Line 46:</a> <co=
de style=3D"font-family:monospace,monospace">#ifdef WIN32</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Do we really need pre-processor here? Doesn&#39;t hurt if the enum con=
tains unused values, does it?</blockquote></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">It is different philosophies. One could argue=
 that you catch a windows only define used out of windows only code. The ot=
her is that too many define/ifdefs are worse.</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun.c:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/738/comment/369450ea_d033a0b6">Patch Set #5, Line 63:</a> <code style=
=3D"font-family:monospace,monospace">#ifdef WIN32</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Aga=
in, don&#39;t think we really need the #ifdefs here...</blockquote></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">DO you propose to ha=
ve them always be defined?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/738?usp=3Demail">change 738</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/738?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8c0e9f32b235cb262ca2be6aac8=
d520e49b30d74 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 738 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Sep 2024 16:48:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--y/C7WzSKeek=--

