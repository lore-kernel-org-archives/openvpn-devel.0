From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 6 Jan 2024 16:22:54 +0000
In-Reply-To: <gerrit.1704203193000.I6899c1af65fbd670d434cdb17f81c82b900bfbd4@...2715...>
References: <gerrit.1704203193000.I6899c1af65fbd670d434cdb17f81c82b900bfbd4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2b925c5a080dc482bdb587cc5525e5df5153299c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X45kkT5cl0o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow having an
 extra function that is called when an env is freed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--X45kkT5cl0o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/486?usp=3Demail )

Change subject: Allow having an extra function that is called when an env i=
s freed
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
From a cursory glance, the code looks OK.  I'm not sure if we want it, tho=
ugh, as it adds even more complexity to the env handling.

For "we only want that for `--tls-export-cert` so the cert files +env produ=
ced are cumulative and the last call has them all", I think this is overdoi=
ng things - I do not think we had a single request to have "all certs in `-=
-tls-verify`" and so balance feature <-> complexity goes more toward negati=
ve.

If this cleans up other env-set related problems, that would be a different=
 story.



--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/486?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6899c1af65fbd670d434cdb17f81c82b900bfbd4
Gerrit-Change-Number: 486
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sat, 06 Jan 2024 16:22:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--X45kkT5cl0o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/486?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
86?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">From a cursory glance, the code looks OK.  I&#39;m=
 not sure if we want it, though, as it adds even more complexity to the env=
 handling.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Fo=
r &quot;we only want that for `--tls-export-cert` so the cert files +env pr=
oduced are cumulative and the last call has them all&quot;, I think this is=
 overdoing things - I do not think we had a single request to have &quot;al=
l certs in `--tls-verify`&quot; and so balance feature &lt;-&gt; complexity=
 goes more toward negative.</p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">If this cleans up other env-set related problems, that would=
 be a different story.</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/486?usp=3Demail">change 486</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/486?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6899c1af65fbd670d434cdb17f8=
1c82b900bfbd4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 486 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 06 Jan 2024 16:22:54=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--X45kkT5cl0o=--

