From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 20 Feb 2024 14:10:50 +0000
In-Reply-To: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
References: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a6ff921004d279dd2dbdaa19cddca4de676115e2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ns748MR15vQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Persist-key: enable
 persist-key option by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Ns748MR15vQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/529?usp=3Demail )

Change subject: Persist-key: enable persist-key option by default
......................................................................


Patch Set 1:

(5 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/e10934a7_2866e37f :
PS1, Line 9: This commit changes the default behavior of the OpenVPN
> Nitpick: just use "Change the default behavior". "This commit" is redunda=
nt and clunky.
Done


File doc/man-sections/signals.rst:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/cd5281ba_35c80d22 :
PS1, Line 13:     remote IP address/port based on ``--persist-tun``, ``--pe=
rsist-local-ip``
> Trailing whitespace
Done


File doc/man-sections/unsupported-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/ffcf9cec_929ec0cd :
PS1, Line 47:   Removed in OpenVPN 2.7. Corresponding behavior is now alway=
s enabled.
> "Corresponding behavior" is very vague. [=E2=80=A6]
Done


File sample/sample-config-files/server.conf:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/4fe0fe2f_2a0c3f24 :
PS1, Line 277: # The persist options will try to avoid
> Nitpick: "The persist options" not correct anymore, since it is only one =
option now =F0=9F=98=8A
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/489e0245_c52b6bdb :
PS1, Line 6963:             "The corresponding behavior is now always enabl=
ed."
> Same comment about "corresponding behavior"
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff
Gerrit-Change-Number: 529
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 20 Feb 2024 14:10:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--Ns748MR15vQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/529/comment/e10934a7_2866e37f">Patch Set #1, Line 9:</a> <code style=
=3D"font-family:monospace,monospace">This commit changes the default behavi=
or of the OpenVPN</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">Nitpick: just use &quot;Change the =
default behavior&quot;. &quot;This commit&quot; is redundant and clunky.</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-s=
ections/signals.rst:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/529/comment/cd5281ba_35c80d22=
">Patch Set #1, Line 13:</a> <code style=3D"font-family:monospace,monospace=
">    remote IP address/port based on ``--persist-tun``, ``--persist-local-=
ip`` </code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">Trailing whitespace</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/unsupported-optio=
ns.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/529/comment/ffcf9cec_929ec0cd">Patch Set #=
1, Line 47:</a> <code style=3D"font-family:monospace,monospace">  Removed i=
n OpenVPN 2.7. Corresponding behavior is now always enabled.</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">&quot;Corresponding behavior&quot; is very vague. [=E2=80=A6]</bloc=
kquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sample/sampl=
e-config-files/server.conf:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/529/comment/4fe0fe2f_2=
a0c3f24">Patch Set #1, Line 277:</a> <code style=3D"font-family:monospace,m=
onospace"># The persist options will try to avoid</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Nit=
pick: &quot;The persist options&quot; not correct anymore, since it is only=
 one option now =F0=9F=98=8A</blockquote></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/529/c=
omment/489e0245_c52b6bdb">Patch Set #1, Line 6963:</a> <code style=3D"font-=
family:monospace,monospace">            &quot;The corresponding behavior is=
 now always enabled.&quot;</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">Same comment about &quot;c=
orresponding behavior&quot;</blockquote></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail">change 529=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I57f1c2ed42bd9dfd43577238749=
a9b7f4c1419ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 529 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 20 Feb 2024 14:10:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Ns748MR15vQ=--

