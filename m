From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 27 Apr 2026 20:14:31 +0000
In-Reply-To: <gerrit.1777311203000.I9433baee1f5a66d43d4e43e03128ae6a790a7937@...2715...>
References: <gerrit.1777311203000.I9433baee1f5a66d43d4e43e03128ae6a790a7937@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <84d7cc928177fef1244a39ec724dff6ea49cd1aa-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OUkaSaPSmGk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Avoid recursive
 call of man_read
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OUkaSaPSmGk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

selvanair has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1639?usp=3Demail )

Change subject: Avoid recursive call of man_read
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
Although FD_READ is level triggered,MSDN has this:
".. an application need not read all available data in response to an FD_RE=
AD network event=E2=80=94a single recv in response to each FD_READ network =
event is appropriate."

This is problematic, as it requires at least one recv() to get the event to=
 re-trigger. So, man_read() retruning without recv() as proposed here may n=
ot be fool-proof? Unfortunately recv with zero bytes is a no-op, so that's =
not an option either.

Back to square one?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9433baee1f5a66d43d4e43e03128ae6a790a7937
Gerrit-Change-Number: 1639
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Comment-Date: Mon, 27 Apr 2026 20:14:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--OUkaSaPSmGk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1639?tab=3Dcomments&=
amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Although FD_READ is level triggered=
,MSDN has this:<br>&quot;.. an application need not read all available data=
 in response to an FD_READ network event=E2=80=94a single recv in response =
to each FD_READ network event is appropriate.&quot;</p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">This is problematic=
, as it requires at least one recv() to get the event to re-trigger. So, ma=
n_read() retruning without recv() as proposed here may not be fool-proof? U=
nfortunately recv with zero bytes is a no-op, so that&#39;s not an option e=
ither.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Back to square one?</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail">change 1639=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1639?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9433baee1f5a66d43d4e43e0312=
8ae6a790a7937 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1639 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 27 Apr 2026 20:14:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--OUkaSaPSmGk=--

