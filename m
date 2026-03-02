From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 2 Mar 2026 15:51:46 +0000
In-Reply-To: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
References: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
Reply-To: arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <2e7128f34683e569f0329a607e25f033f4024887-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6ILKZVbaTD4="; charset=UTF-8
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

--6ILKZVbaTD4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, selvanair.

plaisthos has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1548?usp=3Demail )

Change subject: Add an optional username-only flag for auth-user-pass
......................................................................


Patch Set 4:

(2 comments)

Patchset:

PS4:
> Well, a review would be appreciated.
yeah that was just a side that I added to this while doing the review. The =
delayed response made this a bit weird.


File doc/man-sections/client-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1548/comment/bc07f8c6_a0153d37?usp=3D=
email :
PS4, Line 96:
> Embedding username (with or without password) or reading from file are in=
compatible with username-on [=E2=80=A6]
Yeah but I think it is good mention this then and more explicitly point thi=
s out.

[...] ``dynamic challenge`` protocol. In these cases the user will be asked=
 for a username but not password. If embedding only username but no passwor=
d in the configure is desired a dummy password like 'no_passsword_required'=
 should be used instead.



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
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Mon, 02 Mar 2026 15:51:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: selvanair <selva.nair@...277...>

--6ILKZVbaTD4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1548?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Wel=
l, a review would be appreciated.</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">yeah that was just a sid=
e that I added to this while doing the review. The delayed response made th=
is a bit weird.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile doc/man-sections/client-options.rst:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1548/comm=
ent/bc07f8c6_a0153d37?usp=3Demail">Patch Set #4, Line 96:</a> <code style=
=3D"font-family:monospace,monospace"></code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Embedding usern=
ame (with or without password) or reading from file are incompatible with u=
sername-on [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Yeah but I think it is good mention=
 this then and more explicitly point this out.</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">[...] ``dynamic challeng=
e`` protocol. In these cases the user will be asked for a username but not =
password. If embedding only username but no password in the configure is de=
sired a dummy password like &#39;no_passsword_required&#39; should be used =
instead.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1548?usp=3Demail">change 1548</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1548?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Mar 2026 15:51:46=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>

</body></html>=

--6ILKZVbaTD4=--

