From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 10 Nov 2025 12:04:41 +0000
In-Reply-To: <gerrit.1762539795000.I4d905da3add9b8a3daf349eb1bc830a017cf493d@...2715...>
References: <gerrit.1762539795000.I4d905da3add9b8a3daf349eb1bc830a017cf493d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <01f1120cb7e14b92b952a32ef5f99a97ed2f9ed8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aMxoRu053Vk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: validate
 config path case-insensitive
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aMxoRu053Vk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

flichtenheld has posted comments on this change by d12fk. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1362?usp=3Demail )

Change subject: iservice: validate config path case-insensitive
......................................................................


Patch Set 2:

(1 comment)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1362/comment/724daf9e_538e1abf?usp=3D=
email :
PS2, Line 9: Windows filesystems do not make a difference here, so should w=
e.
While I believe that this is a valid meaning of "making a difference" it is=
 not a common one. I would suggest "differentiate". And the "so should we" =
is confusing.

How about:

```suggestion
Windows filesystems do not differentiate by case, so we shouldn't either.
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1362?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d905da3add9b8a3daf349eb1bc830a017cf493d
Gerrit-Change-Number: 1362
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Mon, 10 Nov 2025 12:04:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--aMxoRu053Vk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1362?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1362/comment/724daf9e_538e1abf?usp=3Demail">Patch Set #2, Line 9:</a>=
 <code style=3D"font-family:monospace,monospace">Windows filesystems do not=
 make a difference here, so should we.</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">While I believe that thi=
s is a valid meaning of &quot;making a difference&quot; it is not a common =
one. I would suggest &quot;differentiate&quot;. And the &quot;so should we&=
quot; is confusing.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">How about:</p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">```suggestion<br>Windows filesystems=
 do not differentiate by case, so we shouldn&#39;t either.<br>```</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1362?usp=3Demail">change 1362</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1362?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d905da3add9b8a3daf349eb1bc=
830a017cf493d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1362 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 10 Nov 2025 12:04:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--aMxoRu053Vk=--

