From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 5 Sep 2024 10:01:25 +0000
In-Reply-To: <gerrit.1724095724000.I7615116b5251319aa1f13d671bab7013f3a043ea@...2715...>
References: <gerrit.1724095724000.I7615116b5251319aa1f13d671bab7013f3a043ea@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <64a1beb90646f2f605d6c2f638f55781eebb692d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i00my8ORp1Q="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add a test for
 loading certificate and key using file: URI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--i00my8ORp1Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, selvanair.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/730?usp=3Demail )

Change subject: Add a test for loading certificate and key using file: URI
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/730/comment/efb80c80_18698be7 :
PS1, Line 249: #endif /* HAVE_OPENSSL_STORE */
I would prefer to use #else here so that there is no dead code.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/730?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7615116b5251319aa1f13d671bab7013f3a043ea
Gerrit-Change-Number: 730
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Thu, 05 Sep 2024 10:01:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--i00my8ORp1Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, selvanair. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/730?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/te=
st_ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/730/comment/efb80c80_18698be7">Patch Set=
 #1, Line 249:</a> <code style=3D"font-family:monospace,monospace">#endif /=
* HAVE_OPENSSL_STORE */</code></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I would prefer to use #else here so that there is no dead=
 code.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/730?usp=3Demail">change 730</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/730?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7615116b5251319aa1f13d671ba=
b7013f3a043ea </div>
<div style=3D"display:none"> Gerrit-Change-Number: 730 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 05 Sep 2024 10:01:25=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--i00my8ORp1Q=--

