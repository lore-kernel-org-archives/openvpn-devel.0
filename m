From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 Dec 2023 16:40:22 +0000
In-Reply-To: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
References: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <76ba1c362c5255c59aae9c7c2179a3a08e1a3c0b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="txItmy8Nogo="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--txItmy8Nogo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/471?usp=3Demail )

Change subject: Add test_ssl unit test and test export of PEM to file
......................................................................


Patch Set 1: Code-Review-1

(6 comments)

File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/471/comment/7cbe21a6_5ded543e :
PS1, Line 560:         "test_ssl"
Those are sorted alphabetically


http://gerrit.openvpn.net/c/openvpn/+/471/comment/fb6707f8_9e4c3991 :
PS1, Line 675:     target_sources(test_ssl PRIVATE
also sorted alphabetically


File tests/unit_tests/openvpn/mock_management.c:

http://gerrit.openvpn.net/c/openvpn/+/471/comment/013fb9b0_9685277c :
PS1, Line 8:  *  Copyright (C) 2017-2021 Fox Crypto B.V. <openvpn@...2782...=
.>
Copy & paste error? Or intentional?


File tests/unit_tests/openvpn/mock_ssl_dependencies.c:

http://gerrit.openvpn.net/c/openvpn/+/471/comment/e183659b_a49b0182 :
PS1, Line 8:  *  Copyright (C) 2017-2021 Fox Crypto B.V. <openvpn@...2782...=
.>
intentional?


http://gerrit.openvpn.net/c/openvpn/+/471/comment/8366d424_83a92832 :
PS1, Line 24: /* Minimal set of mocked management function/globals to get u=
nit tests to
"management" is probably copy&paste


File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/471/comment/c8cca67b_59a239d1 :
PS1, Line 8:  *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2782...=
.>
probably not intentional



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 08 Dec 2023 16:40:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--txItmy8Nogo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/471?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File CMakeLists.txt:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/471/comment/7cbe21a6_5ded543e">Patch Set #1, Line 560:</a> <=
code style=3D"font-family:monospace,monospace">        &quot;test_ssl&quot;=
</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Those=
 are sorted alphabetically</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/471/comment/fb6707f8_9e4c3991">Patch Set #1, Line 675:</a> <co=
de style=3D"font-family:monospace,monospace">    target_sources(test_ssl PR=
IVATE</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
also sorted alphabetically</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File tests/unit_tests/openvpn/mock_management.c:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/471/comment/013fb9b0_9685277c">Patch Set #1, Line 8:</a> <code sty=
le=3D"font-family:monospace,monospace"> *  Copyright (C) 2017-2021 Fox Cryp=
to B.V. &lt;openvpn@...2507...&gt;</code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Copy &amp; paste error? Or intentional?</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/o=
penvpn/mock_ssl_dependencies.c:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/471/comment/e18365=
9b_a49b0182">Patch Set #1, Line 8:</a> <code style=3D"font-family:monospace=
,monospace"> *  Copyright (C) 2017-2021 Fox Crypto B.V. &lt;openvpn@...2754...=
...&gt;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">intentional?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/471/comment/8366d424_83a92832">Patch Set #1, Line 24:</a> <code style=3D"f=
ont-family:monospace,monospace">/* Minimal set of mocked management functio=
n/globals to get unit tests to</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">&quot;management&quot; is probably copy&amp;paste<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_t=
ests/openvpn/test_ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/471/comment/c8cca67b_59a2=
39d1">Patch Set #1, Line 8:</a> <code style=3D"font-family:monospace,monosp=
ace"> *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;=
</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">proba=
bly not intentional</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/471?usp=3Demail">change 471</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/471?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 08 Dec 2023 16:40:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--txItmy8Nogo=--

