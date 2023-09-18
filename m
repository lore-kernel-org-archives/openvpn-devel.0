From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 18 Sep 2023 22:20:36 +0000
In-Reply-To: <gerrit.1689947729000.I6de18261d5dc7f8561612184059656c73f33a5f2@...2715...>
References: <gerrit.1689947729000.I6de18261d5dc7f8561612184059656c73f33a5f2@...2715...>
Reply-To: heiko@...515..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <3a352497bef3f7366e426fae720e032e87aee3b4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N0DQ7Y4aTSo="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[release/2.6]: CMake:
 backport CMake buildsystem from master to release/2.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: stipa <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--N0DQ7Y4aTSo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/315?usp=3Demail )

Change subject: CMake: backport CMake buildsystem from master to release/2.6
......................................................................


Patch Set 1: Code-Review+2

(3 comments)

File README.cmake.md:

http://gerrit.openvpn.net/c/openvpn/+/315/comment/1db29f03_003dbb6b :
PS1, Line 27: can them install with a package manager of your choice (e.g.
*install them


File contrib/cmake/git-version.py:

http://gerrit.openvpn.net/c/openvpn/+/315/comment/7da55e9b_6b13084e :
PS1, Line 23: #
A comment what this does and why would be cool, but then maybe in master or=
  both here and there


File contrib/cmake/parse-version.m4.py:

http://gerrit.openvpn.net/c/openvpn/+/315/comment/df755f5f_7c8d4861 :
PS1, Line 23: #
A comment what this does and why would be cool, but then maybe in master or=
  both here and there



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I6de18261d5dc7f8561612184059656c73f33a5f2
Gerrit-Change-Number: 315
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 18 Sep 2023 22:20:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--N0DQ7Y4aTSo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File README.cmake.md:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/315/comment/1db29f03_003dbb6b">Patch Set #1, Line 27:</a> <=
code style=3D"font-family:monospace,monospace">can them install with a pack=
age manager of your choice (e.g.</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">*install them</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File contrib/cmake/git-version.py:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/315/comment/7da55e9b_6b13084e">Patch Set #1, Line 23:</a> <code st=
yle=3D"font-family:monospace,monospace">#</code></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">A comment what this does and why would =
be cool, but then maybe in master or  both here and there</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File contrib/cmake/parse-version.m=
4.py:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/315/comment/df755f5f_7c8d4861">Patch Set #1,=
 Line 23:</a> <code style=3D"font-family:monospace,monospace">#</code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">A comment what th=
is does and why would be cool, but then maybe in master or  both here and t=
here</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/315?usp=3Demail">change 315</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/315?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6de18261d5dc7f8561612184059=
656c73f33a5f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 315 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 18 Sep 2023 22:20:36=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--N0DQ7Y4aTSo=--

