From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 20 Feb 2024 13:42:54 +0000
In-Reply-To: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
References: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <c8bf06fec7faf6a787943ed3ff498f43ac5ec890-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UnsjToLZFSY="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UnsjToLZFSY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/529?usp=3Demail )

Change subject: Persist-key: enable persist-key option by default
......................................................................


Patch Set 1: Code-Review-1

(6 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/99bc33fe_177eba51 :
PS1, Line 9: This commit changes the default behavior of the OpenVPN
Nitpick: just use "Change the default behavior". "This commit" is redundant=
 and clunky.


Patchset:

PS1:
Functionally looks good to me. Some documentation improvements suggested.


File doc/man-sections/signals.rst:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/4c986d46_e82cde2f :
PS1, Line 13:     remote IP address/port based on ``--persist-tun``, ``--pe=
rsist-local-ip``
Trailing whitespace


File doc/man-sections/unsupported-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/8164c8c9_a1ae98fb :
PS1, Line 47:   Removed in OpenVPN 2.7. Corresponding behavior is now alway=
s enabled.
"Corresponding behavior" is very vague. Let's write "Keys are now always pe=
rsisted across restarts" or something like that.


File sample/sample-config-files/server.conf:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/910d57b4_d0613104 :
PS1, Line 277: # The persist options will try to avoid
Nitpick: "The persist options" not correct anymore, since it is only one op=
tion now =F0=9F=98=8A


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/529/comment/a6f6455c_7e115ef1 :
PS1, Line 6963:             "The corresponding behavior is now always enabl=
ed."
Same comment about "corresponding behavior"



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
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Tue, 20 Feb 2024 13:42:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--UnsjToLZFSY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/529?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/529/comment/99bc33fe_177eba51">Patch Set #1, Line 9:</a> <code st=
yle=3D"font-family:monospace,monospace">This commit changes the default beh=
avior of the OpenVPN</code></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Nitpick: just use &quot;Change the default behavior&quot;. &=
quot;This commit&quot; is redundant and clunky.</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/529?tab=
=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Functionally looks good to me. Some documentation improv=
ements suggested.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File doc/man-sections/signals.rst:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/529/comment/4c=
986d46_e82cde2f">Patch Set #1, Line 13:</a> <code style=3D"font-family:mono=
space,monospace">    remote IP address/port based on ``--persist-tun``, ``-=
-persist-local-ip`` </code></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Trailing whitespace</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File doc/man-sections/unsupported-options.rst:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/529/comment/8164c8c9_a1ae98fb">Patch Set #1, Line 47:</a> <c=
ode style=3D"font-family:monospace,monospace">  Removed in OpenVPN 2.7. Cor=
responding behavior is now always enabled.</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">&quot;Corresponding behavior&quot; is =
very vague. Let&#39;s write &quot;Keys are now always persisted across rest=
arts&quot; or something like that.</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File sample/sample-config-files/server.conf:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/529/comment/910d57b4_d0613104">Patch Set #1, Line 277:</a> <co=
de style=3D"font-family:monospace,monospace"># The persist options will try=
 to avoid</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Nitpick: &quot;The persist options&quot; not correct anymore, since it =
is only one option now =F0=9F=98=8A</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
29/comment/a6f6455c_7e115ef1">Patch Set #1, Line 6963:</a> <code style=3D"f=
ont-family:monospace,monospace">            &quot;The corresponding behavio=
r is now always enabled.&quot;</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Same comment about &quot;corresponding behavior&qu=
ot;</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/529?usp=3Demail">change 529</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/529?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 20 Feb 2024 13:42:54=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--UnsjToLZFSY=--

