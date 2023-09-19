From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 19 Sep 2023 11:37:17 +0000
In-Reply-To: <gerrit.1689947729000.I6de18261d5dc7f8561612184059656c73f33a5f2@...2715...>
References: <gerrit.1689947729000.I6de18261d5dc7f8561612184059656c73f33a5f2@...2715...>
Reply-To: frank@...2641..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <f1ceaa56d4ad211ff76ec91bd59f4ccb58ccf60b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8EbDTj75YLE="; charset=UTF-8
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
Cc: d12fk <heiko@...515...>, stipa <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8EbDTj75YLE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/315?usp=3Demail )

Change subject: CMake: backport CMake buildsystem from master to release/2.6
......................................................................


Patch Set 1:

(5 comments)

Patchset:

PS1:
Will put all the documentation/comment requests into a separate patch to ma=
ke it easier to merge both in master and release/2.6


File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/315/comment/2fac3714_15b4e724 :
PS1, Line 294: # TODO remove later when msvc-config.h is removed and we can=
 always include config.h
> This comment seems to be outdated, since we got rid of config-msvc. [=E2=
=80=A6]
Acknowledged


File README.cmake.md:

http://gerrit.openvpn.net/c/openvpn/+/315/comment/9825cfee_238d23c0 :
PS1, Line 27: can them install with a package manager of your choice (e.g.
> *install them
Acknowledged


File contrib/cmake/git-version.py:

http://gerrit.openvpn.net/c/openvpn/+/315/comment/7e42230e_d6445805 :
PS1, Line 23: #
> A comment what this does and why would be cool, but then maybe in master =
or  both here and there
Acknowledged


File contrib/cmake/parse-version.m4.py:

http://gerrit.openvpn.net/c/openvpn/+/315/comment/abb2f492_3f01938f :
PS1, Line 23: #
> A comment what this does and why would be cool, but then maybe in master =
or  both here and there
Acknowledged



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
Gerrit-Comment-Date: Tue, 19 Sep 2023 11:37:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: d12fk <heiko@...515...>
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--8EbDTj75YLE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
315?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Will put all the documentation/comment requests i=
nto a separate patch to make it easier to merge both in master and release/=
2.6</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File CMakeLis=
ts.txt:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/315/comment/2fac3714_15b4e724">Patch Set #=
1, Line 294:</a> <code style=3D"font-family:monospace,monospace"># TODO rem=
ove later when msvc-config.h is removed and we can always include config.h<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">This comment seems to be outdated, since we got rid o=
f config-msvc. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File README.cmake.md:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/315/c=
omment/9825cfee_238d23c0">Patch Set #1, Line 27:</a> <code style=3D"font-fa=
mily:monospace,monospace">can them install with a package manager of your c=
hoice (e.g.</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">*install them</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File contrib/cmake/git-version.=
py:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/315/comment/7e42230e_d6445805">Patch Set #1, L=
ine 23:</a> <code style=3D"font-family:monospace,monospace">#</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">A comment what this does and why would be cool, but then maybe in =
master or  both here and there</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File contrib/cmake/parse-version.m4.py:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/315/comment/abb2f492_3f01938f">Patch Set #1, Line 23:</a> =
<code style=3D"font-family:monospace,monospace">#</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">A c=
omment what this does and why would be cool, but then maybe in master or  b=
oth here and there</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail">change 315<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 19 Sep 2023 11:37:17=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--8EbDTj75YLE=--

