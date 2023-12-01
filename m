From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 1 Dec 2023 11:11:21 +0000
In-Reply-To: <gerrit.1700590714000.Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3@...2715...>
References: <gerrit.1700590714000.Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e0b27b0f4ed7aa22c6b90f27fb787486fef12597-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CShX3L4x4+s="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Extend the error
 message when TLS 1.0 PRF fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CShX3L4x4+s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/456?usp=3Demail )

Change subject: Extend the error message when TLS 1.0 PRF fails
......................................................................


Patch Set 6: Code-Review-1

(3 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/456/comment/608abdb9_ecbe54f9 :
PS5, Line 10: more and more system will drop TLS 1.0 PRF support. We are al=
ready seeing
"systems"


http://gerrit.openvpn.net/c/openvpn/+/456/comment/96b73433_b71bae49 :
PS5, Line 19: the OpenVPN protocol. Improve a on this message to give a nor=
mal user a chance
Remove "a on"


Patchset:

PS6:
Isn't this made redundant by https://gerrit.openvpn.net/c/openvpn/+/460?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/456?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib3b64b52beed69dc7740f191b0e9a9dc9af5b7f3
Gerrit-Change-Number: 456
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 01 Dec 2023 11:11:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--CShX3L4x4+s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/456?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/456/comment/608abdb9_ecbe54f9">Patch Set #5, Line 10:</a> <code s=
tyle=3D"font-family:monospace,monospace">more and more system will drop TLS=
 1.0 PRF support. We are already seeing</code></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">&quot;systems&quot;</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/456/comment/96b73433_b71bae49">Pa=
tch Set #5, Line 19:</a> <code style=3D"font-family:monospace,monospace">th=
e OpenVPN protocol. Improve a on this message to give a normal user a chanc=
e</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Remo=
ve &quot;a on&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;">=
<p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/456?tab=3Dcomments">Patch Set #6:</a>=
 </p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Isn&#39;t t=
his made redundant by https://gerrit.openvpn.net/c/openvpn/+/460?</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/456?usp=3Demail">change 456</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/456?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3b64b52beed69dc7740f191b0e=
9a9dc9af5b7f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 456 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 01 Dec 2023 11:11:21=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--CShX3L4x4+s=--

