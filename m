From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 5 Mar 2024 08:30:52 +0000
In-Reply-To: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
References: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6ee799ff4697b0f8de3275fdc886b35acae829f0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KrL9fH1YLSE="; charset=UTF-8
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

--KrL9fH1YLSE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/529?usp=3Demail )

Change subject: Persist-key: enable persist-key option by default
......................................................................


Patch Set 2:

(4 comments)

Patchset:

PS2:
> An entry in Changes.rst is missing.
Acknowledged


File doc/man-sections/unsupported-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/3e92e860_85f89117 :
PS2, Line 47:   Removed in OpenVPN 2.7. Keys are now always persisted acros=
s restarts.
> Maybe use "Ignored" since OpenVPN 2. [=E2=80=A6]
Acknowledged


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/5d665ab1_8651ae42 :
PS2, Line 3630:
> random whitespace change
Acknowledged


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/3677f02f_e3f89e35 :
PS2, Line 6965:             "please remove it from your configuration.");
> I don't think we should/warn or threaten to remove that option. [=E2=80=
=A6]
We do exactly the same with max-routes, the only difference is that with pe=
rsist-key we check for permission.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff
Gerrit-Change-Number: 529
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 05 Mar 2024 08:30:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: comment

--KrL9fH1YLSE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
529?tab=3Dcomments">Patch Set #2:</a> </p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">An entry in Changes.r=
st is missing.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File doc/man-sections/unsupported-options.rst:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/529/comment/3e92e860_85f89117">Patch Set #2, Line 47:</a> <code sty=
le=3D"font-family:monospace,monospace">  Removed in OpenVPN 2.7. Keys are n=
ow always persisted across restarts.</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Maybe use &quot;=
Ignored&quot; since OpenVPN 2. [=E2=80=A6]</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/529/comment/5d665ab1_8651ae42">Patch Set #2, Line 3630:</a> <=
code style=3D"font-family:monospace,monospace"></code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">rando=
m whitespace change</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/529/co=
mment/3677f02f_e3f89e35">Patch Set #2, Line 6965:</a> <code style=3D"font-f=
amily:monospace,monospace">            &quot;please remove it from your con=
figuration.&quot;);</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">I don&#39;t think we should/warn =
or threaten to remove that option. [=E2=80=A6]</blockquote></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">We do exactly the same with =
max-routes, the only difference is that with persist-key we check for permi=
ssion.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/529?usp=3Demail">change 529</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/529?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I57f1c2ed42bd9dfd43577238749=
a9b7f4c1419ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 529 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 05 Mar 2024 08:30:52=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--KrL9fH1YLSE=--

