From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 4 Mar 2024 16:31:36 +0000
In-Reply-To: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
References: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
Reply-To: arne-openvpn@...1227..., gianmarco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6472d57e9f512a33ae5be7646c290b201cd10c28-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JBOkdgSX3Xo="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JBOkdgSX3Xo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/529?usp=3Demail )

Change subject: Persist-key: enable persist-key option by default
......................................................................


Patch Set 2:

(4 comments)

Patchset:

PS2:
An entry in Changes.rst is missing.


File doc/man-sections/unsupported-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/eb5579c0_cf2fe0e5 :
PS2, Line 47:   Removed in OpenVPN 2.7. Keys are now always persisted acros=
s restarts.
Maybe use "Ignored" since OpenVPN 2.7?


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/cab1614e_ebf8f6bc :
PS2, Line 3630:
random whitespace change


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/6f595c78_b2ccf3fe :
PS2, Line 6965:             "please remove it from your configuration.");
I don't think we should/warn or threaten to remove that option. That just m=
akes configuration files incompatible in the future without a good reason t=
o do so. For other options like max-routes, we also just ignore them.



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
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 04 Mar 2024 16:31:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--JBOkdgSX3Xo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
529?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">An entry in Changes.rst is missing.</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/unsuppor=
ted-options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/529/comment/eb5579c0_cf2fe0e5">=
Patch Set #2, Line 47:</a> <code style=3D"font-family:monospace,monospace">=
  Removed in OpenVPN 2.7. Keys are now always persisted across restarts.</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe us=
e &quot;Ignored&quot; since OpenVPN 2.7?</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
29/comment/cab1614e_ebf8f6bc">Patch Set #2, Line 3630:</a> <code style=3D"f=
ont-family:monospace,monospace"></code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">random whitespace change</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/529/comment/6f595c78_b2ccf3fe">Patch Set #2, Line 6965:</a> <c=
ode style=3D"font-family:monospace,monospace">            &quot;please remo=
ve it from your configuration.&quot;);</code></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">I don&#39;t think we should/warn or threat=
en to remove that option. That just makes configuration files incompatible =
in the future without a good reason to do so. For other options like max-ro=
utes, we also just ignore them.</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail">change 529<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 04 Mar 2024 16:31:36=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--JBOkdgSX3Xo=--

