From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Sep 2024 14:30:15 +0000
In-Reply-To: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
References: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <1d2629aa59ce17c1aa638ba60f97f813524ba84f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K//lRz/z/+U="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: factor out
 getting dco version info own function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--K//lRz/z/+U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/733?usp=3Demail )

Change subject: dco-win: factor out getting dco version info own function
......................................................................


Patch Set 1:

(5 comments)

Patchset:

PS1:
Overall the factoring-out looks good, but there's one textual change that I=
 find to be "less clear now", and a few remarks.


File src/openvpn/dco_win.c:

http://gerrit.openvpn.net/c/openvpn/+/733/comment/728ea9f7_3e755e74 :
PS1, Line 102:     msg(D_DCO_DEBUG, "dco data_v3: %d", dco->supports_data_v=
3);
I think keeping the "supports" here (=3D not changing the text) would ease =
understanding of the logs.


http://gerrit.openvpn.net/c/openvpn/+/733/comment/69aa1495_3d39dec2 :
PS1, Line 474:     ZeroMemory(&version, sizeof(version));
`CLEAR(version)` exists (if you change this line anyway).

Or just zeroize on assign `OVPN_VERSION =3D {0}`?


http://gerrit.openvpn.net/c/openvpn/+/733/comment/4fdb9c97_bc7702f6 :
PS1, Line 481:     return BSTR(&out);
technically this does something else if no DCO driver can be found - the ol=
d code returns "N/A", the new code returns "0.0.0".  Is this intentional?


http://gerrit.openvpn.net/c/openvpn/+/733/comment/bd3ba22f_ce91aaf0 :
PS1, Line 562:     dco_get_version(&version);
see above wrt `CLEAR()` or `=3D {0}`



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7
Gerrit-Change-Number: 733
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Mon, 09 Sep 2024 14:30:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--K//lRz/z/+U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
733?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Overall the factoring-out looks good, but there&#=
39;s one textual change that I find to be &quot;less clear now&quot;, and a=
 few remarks.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e src/openvpn/dco_win.c:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/733/comment/728ea9f7_3e75=
5e74">Patch Set #1, Line 102:</a> <code style=3D"font-family:monospace,mono=
space">    msg(D_DCO_DEBUG, &quot;dco data_v3: %d&quot;, dco-&gt;supports_d=
ata_v3);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">I think keeping the &quot;supports&quot; here (=3D not changing the text=
) would ease understanding of the logs.</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/733/comment/69aa1495_3d39dec2">Patch Set #1, Line=
 474:</a> <code style=3D"font-family:monospace,monospace">    ZeroMemory(&a=
mp;version, sizeof(version));</code></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">`CLEAR(version)` exists (if you change this line an=
yway).</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Or jus=
t zeroize on assign `OVPN_VERSION =3D {0}`?</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/733/comment/4fdb9c97_bc7702f6">Patch Set #1, =
Line 481:</a> <code style=3D"font-family:monospace,monospace">    return BS=
TR(&amp;out);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">technically this does something else if no DCO driver can be found =
- the old code returns &quot;N/A&quot;, the new code returns &quot;0.0.0&qu=
ot;.  Is this intentional?</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/733/comment/bd3ba22f_ce91aaf0">Patch Set #1, Line 562:</a> <co=
de style=3D"font-family:monospace,monospace">    dco_get_version(&amp;versi=
on);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">s=
ee above wrt `CLEAR()` or `=3D {0}`</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail">change =
733</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e8ddd35bd3cc3334faf7f57118=
d1892512ae9f7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 733 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 09 Sep 2024 14:30:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--K//lRz/z/+U=--

