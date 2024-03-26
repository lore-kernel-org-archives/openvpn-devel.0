From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 26 Mar 2024 10:28:44 +0000
In-Reply-To: <gerrit.1711389887000.If23988a05dd53a519c5e57f2aa3b2d10bd29df1d@...2715...>
References: <gerrit.1711389887000.If23988a05dd53a519c5e57f2aa3b2d10bd29df1d@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e33256abfc30d6ef4b69768bb14cbccc20356c52-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oZlHKS7MA0I="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix
 snprintf/swnprintf related compiler warnings
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

--oZlHKS7MA0I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/549?usp=3Demail )

Change subject: Fix snprintf/swnprintf related compiler warnings
......................................................................


Patch Set 1: Code-Review+2

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/549/comment/2124d3d9_d4975207 :
PS1, Line 12: This warning can be avoid by either explicitly the return val=
ue
missing "checking"


Patchset:

PS1:
Except the error in commit message looks good



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/549?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If23988a05dd53a519c5e57f2aa3b2d10bd29df1d
Gerrit-Change-Number: 549
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Tue, 26 Mar 2024 10:28:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--oZlHKS7MA0I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/549?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/549/comment/2124d3d9_d4975207">Patch Set #1, Line 12:</a> <code s=
tyle=3D"font-family:monospace,monospace">This warning can be avoid by eithe=
r explicitly the return value</code></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">missing &quot;checking&quot;</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/549?=
tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Except the error in commit message looks good</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/549?usp=3Demail">change 549</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/549?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If23988a05dd53a519c5e57f2aa3=
b2d10bd29df1d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 549 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 26 Mar 2024 10:28:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--oZlHKS7MA0I=--

