From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 2 Mar 2026 15:19:33 +0000
In-Reply-To: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
References: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <62ef50de0876b6c5030c352f21badb0503c2c85b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vtMAOJCcevY="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vtMAOJCcevY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

selvanair has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1548?usp=3Demail )

Change subject: Add an optional username-only flag for auth-user-pass
......................................................................


Patch Set 4:

(1 comment)

File doc/man-sections/client-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1548/comment/5b6d4fe6_304f5220?usp=3D=
email :
PS4, Line 96:
> So I have a bit of usability problems here. [=E2=80=A6]
Embedding username (with or without password) or reading from file are inco=
mpatible with username-only field. So, the usage you mentioned is not suppo=
rted.

I thought this was obvious as we currently do not support repeating such op=
tions like auth-user-pass --- i.e when repeated, onlythe last one overwrite=
s previous ones. But we can strss this as done in teh commit message.

If user wants  to inline a username in the file, do not use username-only, =
just inline the username and a dummy password. Its already possible an dno =
chnages needed. Adding a dummy password inline is no trouble IMO.

The rationale: The only case where "username-only" is required and useful i=
s when no password should be prompted for, and embedding a dummy password i=
s not practical: as in common config files for all users and SSO based on u=
sername/email that we do in some environments.



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
Gerrit-Comment-Date: Mon, 02 Mar 2026 15:19:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>

--vtMAOJCcevY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/client-option=
s.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1548/comment/5b6d4fe6_304f5220?usp=3Demail"=
>Patch Set #4, Line 96:</a> <code style=3D"font-family:monospace,monospace"=
></code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">So I have a bit of usability problems here. [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Embedding username (with or without password) or read=
ing from file are incompatible with username-only field. So, the usage you =
mentioned is not supported.</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">I thought this was obvious as we currently =
do not support repeating such options like auth-user-pass --- i.e when repe=
ated, onlythe last one overwrites previous ones. But we can strss this as d=
one in teh commit message.</p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">If user wants  to inline a username in the f=
ile, do not use username-only, just inline the username and a dummy passwor=
d. Its already possible an dno chnages needed. Adding a dummy password inli=
ne is no trouble IMO.</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">The rationale: The only case where &quot;username=
-only&quot; is required and useful is when no password should be prompted f=
or, and embedding a dummy password is not practical: as in common config fi=
les for all users and SSO based on username/email that we do in some enviro=
nments.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1548?usp=3Demail">change 1548</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1548?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Mar 2026 15:19:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>

</body></html>=

--vtMAOJCcevY=--

