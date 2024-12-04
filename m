From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 4 Dec 2024 17:56:22 +0000
In-Reply-To: <gerrit.1733328040000.Id2bed0908e84c19b8fb6fe806376316793e550b4@...2715...>
References: <gerrit.1733328040000.Id2bed0908e84c19b8fb6fe806376316793e550b4@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e7a24c257263bc03d33eb335b6ddd333d79964b3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6+OInMa3IaI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: do not use
 netsh to set name server addresses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6+OInMa3IaI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/825?usp=3Demail )

Change subject: dns: do not use netsh to set name server addresses
......................................................................


Patch Set 2:

(1 comment)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/825/comment/7e06254d_29fcb9b6 :
PS2, Line 1748:     LSTATUS err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE, itfs_=
key, 0, KEY_ALL_ACCESS, key);
Here we use RegOpenKeyExA, and in the function below RegOpenKeyExW



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id2bed0908e84c19b8fb6fe806376316793e550b4
Gerrit-Change-Number: 825
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Wed, 04 Dec 2024 17:56:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--6+OInMa3IaI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/825/comment/7e06254d_29fcb9b6">Patch Set #2, Line =
1748:</a> <code style=3D"font-family:monospace,monospace">    LSTATUS err =
=3D RegOpenKeyExA(HKEY_LOCAL_MACHINE, itfs_key, 0, KEY_ALL_ACCESS, key);</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Here we =
use RegOpenKeyExA, and in the function below RegOpenKeyExW</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
25?usp=3Demail">change 825</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/825?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id2bed0908e84c19b8fb6fe80637=
6316793e550b4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 825 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Dec 2024 17:56:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--6+OInMa3IaI=--

