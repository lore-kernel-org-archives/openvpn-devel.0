From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 20 Oct 2023 14:34:41 +0000
In-Reply-To: <gerrit.1697649699000.I204b396dea9f22d68e8e091d181a85ffebde4c17@...2715...>
References: <gerrit.1697649699000.I204b396dea9f22d68e8e091d181a85ffebde4c17@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <814dd0b23e9c197cd72098c96cb12432657c5645-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="caiWaDPnYPU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add undefined and
 abort on error to clang sanaitize builds
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

--caiWaDPnYPU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/375?usp=3Demail )

Change subject: Add undefined and abort on error to clang sanaitize builds
......................................................................


Patch Set 1: Code-Review+2

(4 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/375/comment/0af4b2eb_1d83dd0c :
PS1, Line 7: Add undefined and abort on error to clang sanaitize builds
"sanitize"


http://gerrit.openvpn.net/c/openvpn/+/375/comment/27d3be40_0a7d6d92 :
PS1, Line 11: that nobody sess. Also add the undefined tests to catch more =
bugs.
"sees"


File .github/workflows/build.yaml:

http://gerrit.openvpn.net/c/openvpn/+/375/comment/e2fb72bb_2259aa1a :
PS1, Line 205:             ldflags: -fsanitize=3Daddress,undefined -fno-san=
itize-recover=3Dall
Trailing whitespace


Patchset:

PS1:
Small typo/whitespace issues can be fixed on ml send



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/375?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I204b396dea9f22d68e8e091d181a85ffebde4c17
Gerrit-Change-Number: 375
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 20 Oct 2023 14:34:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--caiWaDPnYPU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/375?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/375/comment/0af4b2eb_1d83dd0c">Patch Set #1, Line 7:</a> <code st=
yle=3D"font-family:monospace,monospace">Add undefined and abort on error to=
 clang sanaitize builds</code></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">&quot;sanitize&quot;</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/375/comment/27d3be40_0a7d6d92">Patch Set #1, Line =
11:</a> <code style=3D"font-family:monospace,monospace">that nobody sess. A=
lso add the undefined tests to catch more bugs.</code></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">&quot;sees&quot;</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File .github/workflows/build.yaml=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/375/comment/e2fb72bb_2259aa1a">Patch Set #1, Lin=
e 205:</a> <code style=3D"font-family:monospace,monospace">            ldfl=
ags: -fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall </code></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">Trailing whitesp=
ace</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/375?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Small typo/whitespace issue=
s can be fixed on ml send</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/375?usp=3Demail">change 375</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/375?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I204b396dea9f22d68e8e091d181=
a85ffebde4c17 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 375 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 20 Oct 2023 14:34:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--caiWaDPnYPU=--

