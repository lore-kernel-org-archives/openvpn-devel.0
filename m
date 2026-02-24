From: "selvanair (Code Review)" <gerrit@...515...>
Date: Tue, 24 Feb 2026 20:14:26 +0000
In-Reply-To: <gerrit.1771205254000.I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a@...2715...>
References: <gerrit.1771205254000.I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <a05ec65355a412cf8e224a50c1238a768534e5e1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BW/uCkoSBjc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fixup version
 command on management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BW/uCkoSBjc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

selvanair has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1528?usp=3Demail )

Change subject: Fixup version command on management interface
......................................................................


Patch Set 3:

(1 comment)

Patchset:

PS3:
> meh, gerrit tricked me.  I answered on the "to respond only if ... [=E2=
=80=A6]
I do that all the time -- the other day deleted a dozen old comments that n=
ever saw the light of day...

Anyway, I found "commit 8be444df8" had upped the latest client version to 3=
, so enabling this for >=3D 4. We really need a way to document client vers=
ions -- right now one has to just know.

What about something like a private enum in manage.c with {CLIENT_VERSION_B=
ASE =3D 1, CLIENT_VERSION_PKSIGN =3D 2, ... } and then use those like "if (=
client_version >=3D CLIENT_VERSION_PKSIGN)" etc? As a separate patch of cou=
rse. Or, is there a better way?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1528?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a
Gerrit-Change-Number: 1528
Gerrit-PatchSet: 3
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 24 Feb 2026 20:14:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>

--BW/uCkoSBjc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1528?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1528?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">meh,=
 gerrit tricked me.  I answered on the &quot;to respond only if ... [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">I do that all the time -- the other day deleted a doz=
en old comments that never saw the light of day...</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Anyway, I found &quo=
t;commit 8be444df8&quot; had upped the latest client version to 3, so enabl=
ing this for &gt;=3D 4. We really need a way to document client versions --=
 right now one has to just know.</p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">What about something like a private en=
um in manage.c with {CLIENT_VERSION_BASE =3D 1, CLIENT_VERSION_PKSIGN =3D 2=
, ... } and then use those like &quot;if (client_version &gt;=3D CLIENT_VER=
SION_PKSIGN)&quot; etc? As a separate patch of course. Or, is there a bette=
r way?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1528?usp=3Demail">change 1528</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1528?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76dc80a9d9b29e401b7bbd59e0c=
46baf751d2e4a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1528 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 24 Feb 2026 20:14:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>

</body></html>=

--BW/uCkoSBjc=--

