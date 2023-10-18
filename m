From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 12:50:30 +0000
In-Reply-To: <gerrit.1697629414000.I2d353a0cea0a62f289b8c1060244df66dd7a14cb@...2715...>
References: <gerrit.1697629414000.I2d353a0cea0a62f289b8c1060244df66dd7a14cb@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <01275684afe6ca1f7449ab5328daf53d1b379e4e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Rk0qnHM5gqY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove openssl
 engine method for loading the key
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

--Rk0qnHM5gqY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/373?usp=3Demail )

Change subject: Remove openssl engine method for loading the key
......................................................................


Patch Set 1: Code-Review-1

(5 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/373/comment/e17b8596_9a54a763 :
PS1, Line 10: deprecated since OpenSSL 3.0 and James Bottomlehy has not agr=
eed
"Bottomley"


http://gerrit.openvpn.net/c/openvpn/+/373/comment/95a52a7e_866bd6f6 :
PS1, Line 11: to the proposed license chagne. He is also okay with removing
"change"


http://gerrit.openvpn.net/c/openvpn/+/373/comment/4669cbdb_a38c78ba :
PS1, Line 12: with the feature from the current code base as it is obsolete=
 with
remove "with"


http://gerrit.openvpn.net/c/openvpn/+/373/comment/bea8f16e_17b2230f :
PS1, Line 14:
I think the commit message should mention the original commit that introduc=
ed the feature.


Patchset:

PS1:
Commit message needs some work.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/373?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d353a0cea0a62f289b8c1060244df66dd7a14cb
Gerrit-Change-Number: 373
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 18 Oct 2023 12:50:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Rk0qnHM5gqY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/373?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/373/comment/e17b8596_9a54a763">Patch Set #1, Line 10:</a> <code s=
tyle=3D"font-family:monospace,monospace">deprecated since OpenSSL 3.0 and J=
ames Bottomlehy has not agreed</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">&quot;Bottomley&quot;</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/373/comment/95a52a7e_866bd6f6">Patch Set #=
1, Line 11:</a> <code style=3D"font-family:monospace,monospace">to the prop=
osed license chagne. He is also okay with removing</code></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">&quot;change&quot;</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/373/comment/4669cbdb_a38c=
78ba">Patch Set #1, Line 12:</a> <code style=3D"font-family:monospace,monos=
pace">with the feature from the current code base as it is obsolete with</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">remove &=
quot;with&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/373/comment/bea8f16e_17b2230f">Patch Set #1, Line 14:</a> <code style=3D"=
font-family:monospace,monospace"></code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">I think the commit message should mention the o=
riginal commit that introduced the feature.</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/373?tab=3Dcom=
ments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Commit message needs some work.</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/373?usp=3Demail=
">change 373</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/373?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2d353a0cea0a62f289b8c106024=
4df66dd7a14cb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 373 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Oct 2023 12:50:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Rk0qnHM5gqY=--

