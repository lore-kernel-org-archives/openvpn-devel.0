From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 11:27:24 +0000
In-Reply-To: <gerrit.1700477479000.I9c85ccab6d51064ebff2c391740ba8c2d044ed1a@...2715...>
References: <gerrit.1700477479000.I9c85ccab6d51064ebff2c391740ba8c2d044ed1a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5ef92d4d19d18aa7a9fce8f84e20ff08357ab687-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wGmlIQ0WAr8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove compat
 versionhelpers.h and remove cmake/configure check for it
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

--wGmlIQ0WAr8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/445?usp=3Demail )

Change subject: Remove compat versionhelpers.h and remove cmake/configure c=
heck for it
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/445/comment/ac1dbdba_a1bab3b8 :
PS1, Line 10: old msvc-config.h that always had it present. Also interactiv=
e.c includes
interactive.c does not include it without the check?


Patchset:

PS1:
Code looks good, but commit message seems wrong?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/445?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9c85ccab6d51064ebff2c391740ba8c2d044ed1a
Gerrit-Change-Number: 445
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 20 Nov 2023 11:27:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--wGmlIQ0WAr8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/445?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/445/comment/ac1dbdba_a1bab3b8">Patch Set #1, Line 10:</a> <code s=
tyle=3D"font-family:monospace,monospace">old msvc-config.h that always had =
it present. Also interactive.c includes</code></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">interactive.c does not include it without=
 the check?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Patch=
set:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/445?tab=3Dcomments">Patch Set #1:</a> </p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Code looks good, bu=
t commit message seems wrong?</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/445?usp=3Demail">change 445</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/445?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9c85ccab6d51064ebff2c391740=
ba8c2d044ed1a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 445 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Nov 2023 11:27:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--wGmlIQ0WAr8=--

