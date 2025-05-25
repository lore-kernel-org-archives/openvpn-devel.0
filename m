From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 25 May 2025 16:36:28 +0000
In-Reply-To: <gerrit.1733837528000.I15d4946800cbfaead67a73450ff3b12193814e54@...2715...>
References: <gerrit.1733837528000.I15d4946800cbfaead67a73450ff3b12193814e54@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <afed8aafb8acd25fb7bf90bc29ee41149d661083-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D51TFYKP/l8="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove uncrustify
 config and scripts, switch GHA
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--D51TFYKP/l8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/830?usp=3Demail )

Change subject: Remove uncrustify config and scripts, switch GHA
......................................................................


Patch Set 8: Code-Review-1

(1 comment)

Patchset:

PS8:
we need to keep "a pre-commit" script for easy local installation of the pr=
e-commit hook.  For those that change beween 2.6 and master/2.7 branches an=
d commit to either of them, a git hook that does "is this an uncrustif bran=
ch?  call uncrustify, if not, call clang-format" would be helpful.

("dev-tools/" changes appropriately when changing branches, but .git/hooks/=
 does not)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I15d4946800cbfaead67a73450ff3b12193814e54
Gerrit-Change-Number: 830
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sun, 25 May 2025 16:36:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--D51TFYKP/l8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 8:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/830?tab=3Dcomments">Patch Set #8:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">we need to keep &quot;a pre-commit&quot; scrip=
t for easy local installation of the pre-commit hook.  For those that chang=
e beween 2.6 and master/2.7 branches and commit to either of them, a git ho=
ok that does &quot;is this an uncrustif branch?  call uncrustify, if not, c=
all clang-format&quot; would be helpful.</p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">(&quot;dev-tools/&quot; changes appropriately w=
hen changing branches, but .git/hooks/ does not)</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/830?usp=3De=
mail">change 830</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I15d4946800cbfaead67a73450ff=
3b12193814e54 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 830 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 25 May 2025 16:36:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--D51TFYKP/l8=--

