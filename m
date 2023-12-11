From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Dec 2023 14:42:48 +0000
In-Reply-To: <gerrit.1701876289000.I193aef06912f01426dd4ac298aadfab97dd75a35@...2715...>
References: <gerrit.1701876289000.I193aef06912f01426dd4ac298aadfab97dd75a35@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2593a1d9f7a8f102f555cdba9af7386ed134bd30-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VfWPSTOVnWE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: test_user_pass: new
 UT for get_user_pass
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

--VfWPSTOVnWE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/468?usp=3Demail )

Change subject: test_user_pass: new UT for get_user_pass
......................................................................


Patch Set 3:

(2 comments)

File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/468/comment/ced071e8_e7d892e4 :
PS3, Line 625:                 ENVIRONMENT "srcdir=3D${CMAKE_CURRENT_SOURCE=
_DIR}/tests/unit_tests/openvpn")
Why not use a define instead like

add_compile_definition(${target} -DSRCDIR=3D"${CMAKE_CURRENT_SOURCE_DIR}"? =
That seems less fragile then an environment variable.


File tests/unit_tests/openvpn/test_user_pass.c:

http://gerrit.openvpn.net/c/openvpn/+/468/comment/c4d4854d_87b23353 :
PS3, Line 86: }
I think we should be consistent here. Either do the (void) var; in all mock=
ed functions or none. I would prefer not to use them if not necessary.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/468?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I193aef06912f01426dd4ac298aadfab97dd75a35
Gerrit-Change-Number: 468
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 11 Dec 2023 14:42:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--VfWPSTOVnWE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/468?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File CMakeLists.txt:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/468/comment/ced071e8_e7d892e4">Patch Set #3, Line 625:</a> <co=
de style=3D"font-family:monospace,monospace">                ENVIRONMENT &q=
uot;srcdir=3D${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_tests/openvpn&quot;)</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Why not =
use a define instead like </p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">add_compile_definition(${target} -DSRCDIR=3D&quot;${CMAKE_CUR=
RENT_SOURCE_DIR}&quot;? That seems less fragile then an environment variabl=
e.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/uni=
t_tests/openvpn/test_user_pass.c:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/468/comment/c4d4=
854d_87b23353">Patch Set #3, Line 86:</a> <code style=3D"font-family:monosp=
ace,monospace">}</code></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">I think we should be consistent here. Either do the (void) var; =
in all mocked functions or none. I would prefer not to use them if not nece=
ssary.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/468?usp=3Demail">change 468</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/468?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I193aef06912f01426dd4ac298aa=
dfab97dd75a35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 468 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 11 Dec 2023 14:42:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--VfWPSTOVnWE=--

