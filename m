From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 25 Sep 2025 15:25:31 +0000
In-Reply-To: <gerrit.1758811182000.Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080@...2715...>
References: <gerrit.1758811182000.Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <2f885bbc78b722fdbef0b88f9d83e1a515e448b4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FCWI9pBvo4k="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: support for
 epoch data channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FCWI9pBvo4k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1219?usp=3Demail )

Change subject: dco-win: support for epoch data channel
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/dco_win.c:

http://gerrit.openvpn.net/c/openvpn/+/1219/comment/c396d4fa_c56eb5fb :
PS1, Line 1102:     return dco_get_version(&ver) && ver.Major >=3D 2 && ver=
.Minor >=3D 8;
That sounds wrong. Version 3.1 would this test.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080
Gerrit-Change-Number: 1219
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 25 Sep 2025 15:25:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--FCWI9pBvo4k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_win.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1219/comment/c396d4fa_c56eb5fb">Patch Set #1, Line 1102:<=
/a> <code style=3D"font-family:monospace,monospace">    return dco_get_vers=
ion(&amp;ver) &amp;&amp; ver.Major &gt;=3D 2 &amp;&amp; ver.Minor &gt;=3D 8=
;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">That=
 sounds wrong. Version 3.1 would this test.</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail=
">change 1219</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1219?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5ed5969dcd405a47e34ed8479b=
7ffaaa5c43080 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1219 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 25 Sep 2025 15:25:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--FCWI9pBvo4k=--

