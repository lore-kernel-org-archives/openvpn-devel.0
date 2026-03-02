From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 2 Mar 2026 15:03:45 +0000
In-Reply-To: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
References: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
Reply-To: arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <ae70585394d096429fd9c90b1aec6c36f7fa75de-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZsT6Vmqbsn8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add an optional
 username-only flag for auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZsT6Vmqbsn8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

plaisthos has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1548?usp=3Demail )

Change subject: Add an optional username-only flag for auth-user-pass
......................................................................


Patch Set 4:

(2 comments)

Patchset:

PS4:
The patch overall looks good but think the usability how to use the feature=
 needs to be clearer.


File doc/man-sections/client-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1548/comment/695f9498_3d55bfa1?usp=3D=
email :
PS4, Line 96:
So I have a bit of usability problems here. If I want to put the username t=
o use into the profile, in typical OpenVPN fashion I expect to having to use

auth-user-pass username-only
<auth-user-pass>
theusername
</auth-user-pass>

which is not necessarily obvious. If we want this to be the way, we should =
at least document it.

And something like

auth-user-pass /some/file username-only does not seem to be supported.

auth-user-pass username-only
auth-user-pass /some/file username-only

might work but is not intuitive either.

Maybe have something like auth-sendusername as alias to auth-user-pass that=
 imlicitlty sets the flag and otherwise works the same as auth-user-pass?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I788f76e6a70a9c20bca3367140d2741bd0551582
Gerrit-Change-Number: 1548
Gerrit-PatchSet: 4
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 02 Mar 2026 15:03:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--ZsT6Vmqbsn8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1548?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The patch over=
all looks good but think the usability how to use the feature needs to be c=
learer.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/=
man-sections/client-options.rst:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1548/comment/695f=
9498_3d55bfa1?usp=3Demail">Patch Set #4, Line 96:</a> <code style=3D"font-f=
amily:monospace,monospace"></code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">So I have a bit of usability problem=
s here. If I want to put the username to use into the profile, in typical O=
penVPN fashion I expect to having to use </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">auth-user-pass username-only<=
br>&lt;auth-user-pass&gt;<br>theusername<br>&lt;/auth-user-pass&gt;</p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">whi=
ch is not necessarily obvious. If we want this to be the way, we should at =
least document it.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">And something like</p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">auth-user-pass /some/file use=
rname-only does not seem to be supported.</p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">auth-user-pass username-only =
<br>auth-user-pass /some/file username-only</p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">might work but is not intui=
tive either.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Maybe have something like auth-sendusername as alias to au=
th-user-pass that imlicitlty sets the flag and otherwise works the same as =
auth-user-pass?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail">change 1548</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1548?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I788f76e6a70a9c20bca3367140d=
2741bd0551582 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1548 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@...2641...&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Mar 2026 15:03:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--ZsT6Vmqbsn8=--

