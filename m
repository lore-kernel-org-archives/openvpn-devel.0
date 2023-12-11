From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Dec 2023 13:59:24 +0000
In-Reply-To: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
References: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <83cc725ebcc53a91061c9f8b43e1793105cec162-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="svqHCS6ciE8="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add test_ssl unit
 test and test export of PEM to file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--svqHCS6ciE8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/471?usp=3Demail )

Change subject: Add test_ssl unit test and test export of PEM to file
......................................................................


Patch Set 1:

(6 comments)

File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/471/comment/0db70bef_074e855b :
PS1, Line 560:         "test_ssl"
> Those are sorted alphabetically
Done


http://gerrit.openvpn.net/c/openvpn/+/471/comment/e741cdb3_5a0aaaff :
PS1, Line 675:     target_sources(test_ssl PRIVATE
> also sorted alphabetically
I sorted them like the other ones that include mock files and have the test=
/mock files first and not strictly alphabetical which would have put them a=
t the end.


File tests/unit_tests/openvpn/mock_management.c:

http://gerrit.openvpn.net/c/openvpn/+/471/comment/5b10dbd9_9e007792 :
PS1, Line 8:  *  Copyright (C) 2017-2021 Fox Crypto B.V. <openvpn@...2782...=
.>
> Copy & paste error? Or intentional?
Done


File tests/unit_tests/openvpn/mock_ssl_dependencies.c:

http://gerrit.openvpn.net/c/openvpn/+/471/comment/979d7c62_638080d7 :
PS1, Line 8:  *  Copyright (C) 2017-2021 Fox Crypto B.V. <openvpn@...2782...=
.>
> intentional?
Done


http://gerrit.openvpn.net/c/openvpn/+/471/comment/96b5a578_3c274b81 :
PS1, Line 24: /* Minimal set of mocked management function/globals to get u=
nit tests to
> "management" is probably copy&paste
Done


File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/471/comment/8b19f7d6_6a5c48d6 :
PS1, Line 8:  *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2782...=
.>
> probably not intentional
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/471?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie248d35d063bb6878f3dd42840c77ba0d6fa3381
Gerrit-Change-Number: 471
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 11 Dec 2023 13:59:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--svqHCS6ciE8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/471?usp=3Demail">View C=
hange</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File CMakeLists.txt:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/471/comment/0db70bef_074e855b">Patch Set #1, Line 560:</a> <co=
de style=3D"font-family:monospace,monospace">        &quot;test_ssl&quot;</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">Those are sorted alphabetically</blockquote></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/471/comment/e741cdb3_5a0aaaff">=
Patch Set #1, Line 675:</a> <code style=3D"font-family:monospace,monospace"=
>    target_sources(test_ssl PRIVATE</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">also sorted alph=
abetically</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">I sorted them like the other ones that include mock files and ha=
ve the test/mock files first and not strictly alphabetical which would have=
 put them at the end.</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File tests/unit_tests/openvpn/mock_management.c:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/471/comment/5b10dbd9_9e007792">Patch Set #1, Line 8:</a> <code style=3D=
"font-family:monospace,monospace"> *  Copyright (C) 2017-2021 Fox Crypto B.=
V. &lt;openvpn@...2507...&gt;</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Copy &amp; paste error?=
 Or intentional?</blockquote></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File tests/unit_tests/openvpn/mock_ssl_dependencies.c:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/471/comment/979d7c62_638080d7">Patch Set #1, Line 8:</a> <code st=
yle=3D"font-family:monospace,monospace"> *  Copyright (C) 2017-2021 Fox Cry=
pto B.V. &lt;openvpn@...2507...&gt;</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">intentional?</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/471/comment/9=
6b5a578_3c274b81">Patch Set #1, Line 24:</a> <code style=3D"font-family:mon=
ospace,monospace">/* Minimal set of mocked management function/globals to g=
et unit tests to</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">&quot;management&quot; is probably c=
opy&amp;paste</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File tests/unit_tests/openvpn/test_ssl.c:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/471/co=
mment/8b19f7d6_6a5c48d6">Patch Set #1, Line 8:</a> <code style=3D"font-fami=
ly:monospace,monospace"> *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;ope=
nvpn@...2507...&gt;</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">probably not intentional</blockqu=
ote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/471?usp=3Demail">change 471</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/471?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie248d35d063bb6878f3dd42840c=
77ba0d6fa3381 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 471 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 11 Dec 2023 13:59:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--svqHCS6ciE8=--

