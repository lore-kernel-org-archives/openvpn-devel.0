From: "MaxF (Code Review)" <gerrit@...515...>
Date: Sat, 28 Dec 2024 00:37:01 +0000
In-Reply-To: <gerrit.1734706182000.I81440ac28a1ad553652e201234e5ddfe03a8c190@...2715...>
References: <gerrit.1734706182000.I81440ac28a1ad553652e201234e5ddfe03a8c190@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <74d9c84e717a9963cc0788f7a3c2f1841ed5042c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X6iIHiirrLI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not attempt to
 decrypt packets anymore after 2**36 failed decryptions
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

--X6iIHiirrLI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/843?usp=3Demail )

Change subject: Do not attempt to decrypt packets anymore after 2**36 faile=
d decryptions
......................................................................


Patch Set 2: Code-Review-1

(5 comments)

Patchset:

PS2:
I'm unsure if we should use the 2^36 limit for Chacha-poly, but for AES-GCM=
 it should be ok.


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/843/comment/39d7c228_ac4d76f3 :
PS2, Line 667:  We
Incomplete


http://gerrit.openvpn.net/c/openvpn/+/843/comment/e2534d46_534f661c :
PS2, Line 672: TLS 1.3
Should be DTLS


http://gerrit.openvpn.net/c/openvpn/+/843/comment/96fbdeb5_8ce34e21 :
PS2, Line 672: 2**36
I've been looking at the integrity bounds in the AEAD limits RFC again and =
I'm not sure if 2^36 is right for us. The number of decryption failures tha=
t we can tolerate depends on the maximum message length that we're willing =
to receive (L in the formulas).

The DTLS RFC assumes L <=3D 2^10, but for us it can be larger. I don't thin=
k this matters for AES-GCM, the 2^36 limit leaves lots of room to spare. Bu=
t for Chacha-poly, it's pretty tight.

If we tolerate p =3D 2^-57 and we have L =3D 2^14, then we can only have 2^=
32 decryption failures.


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/843/comment/62ea554d_ed6bec9a :
PS2, Line 426:
Extra whitespace



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/843?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I81440ac28a1ad553652e201234e5ddfe03a8c190
Gerrit-Change-Number: 843
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 28 Dec 2024 00:37:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--X6iIHiirrLI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/843?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/843?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">I&#39;m unsure if we should use the 2^36 limi=
t for Chacha-poly, but for AES-GCM it should be ok.</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.h:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/843/comment/39d7c228_ac4d76f3">Patch Set #2, Line 667:</a> <co=
de style=3D"font-family:monospace,monospace"> We</code></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Incomplete</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/843/comment/e2534d46_534f661c">Pa=
tch Set #2, Line 672:</a> <code style=3D"font-family:monospace,monospace">T=
LS 1.3</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Should be DTLS</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/843/comment/96fbdeb5_8ce34e21">Patch Set #2, Line 672:</a> <code style=3D=
"font-family:monospace,monospace">2**36</code></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I&#39;ve been looking at the integrity bo=
unds in the AEAD limits RFC again and I&#39;m not sure if 2^36 is right for=
 us. The number of decryption failures that we can tolerate depends on the =
maximum message length that we&#39;re willing to receive (L in the formulas=
).</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">The DTLS R=
FC assumes L &lt;=3D 2^10, but for us it can be larger. I don&#39;t think t=
his matters for AES-GCM, the 2^36 limit leaves lots of room to spare. But f=
or Chacha-poly, it&#39;s pretty tight.</p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">If we tolerate p =3D 2^-57 and we have L =3D 2^14=
, then we can only have 2^32 decryption failures.</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/843/comment/62ea554d_ed6bec9a">Patch Set #2, Line 426:</a> <code =
style=3D"font-family:monospace,monospace"></code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Extra whitespace</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/843?us=
p=3Demail">change 843</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/843?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81440ac28a1ad553652e201234e=
5ddfe03a8c190 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 843 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 28 Dec 2024 00:37:01=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--X6iIHiirrLI=--

