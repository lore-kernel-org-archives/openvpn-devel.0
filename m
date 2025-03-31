From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 31 Mar 2025 15:42:21 +0000
In-Reply-To: <gerrit.1743422979000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
References: <gerrit.1743422979000.Ie9bffcc487f53a3a8ae6e59b79e654360d99902c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <bb7b31aba2af8fe3e44b59d20217b3a3706d4c1d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HThly3WfsAw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Dependency and
 Actions update April 2025
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HThly3WfsAw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/926?usp=3Demail )

Change subject: GHA: Dependency and Actions update April 2025
......................................................................


Patch Set 1:

(1 comment)

File .github/workflows/build.yaml:

http://gerrit.openvpn.net/c/openvpn/+/926/comment/bfccada6_757aa827 :
PS1, Line 69:             -DENABLE_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -D=
ENABLE_LZO=3Dfalse -DUSE_WERROR=3Dno
you missed your opportunity to fix the yes vs true you complained about las=
t time ;)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/926?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie9bffcc487f53a3a8ae6e59b79e654360d99902c
Gerrit-Change-Number: 926
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 31 Mar 2025 15:42:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--HThly3WfsAw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/926?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File .github/workflows/build.yaml:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/926/comment/bfccada6_757aa827">Patch Set #1, Line 6=
9:</a> <code style=3D"font-family:monospace,monospace">            -DENABLE=
_PKCS11=3Dfalse -DBUILD_TESTING=3Dtrue -DENABLE_LZO=3Dfalse -DUSE_WERROR=3D=
no</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">you=
 missed your opportunity to fix the yes vs true you complained about last t=
ime ;)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/926?usp=3Demail">change 926</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/926?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie9bffcc487f53a3a8ae6e59b79e=
654360d99902c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 926 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 31 Mar 2025 15:42:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--HThly3WfsAw=--

