From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 1 Apr 2026 11:58:40 +0000
In-Reply-To: <gerrit.1775000509000.I1c18b3cf4a454444a61941d88a702a140b0ac23d@...2715...>
References: <gerrit.1775000509000.I1c18b3cf4a454444a61941d88a702a140b0ac23d@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ba76af5edbc7d83db736ef662740f88715a81993-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8JkM2HPCF5Y="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add unit tests for
 'auth-user-pass username-only'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8JkM2HPCF5Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

selvanair has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1602?usp=3Demail )

Change subject: Add unit tests for 'auth-user-pass username-only'
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
No point in testing this for authfile and inline as those are not supported=
 with username-only. Though the test works.
The recommendation in those cases is to include a dummy password.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c18b3cf4a454444a61941d88a702a140b0ac23d
Gerrit-Change-Number: 1602
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 01 Apr 2026 11:58:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--8JkM2HPCF5Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1602?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">No point in tes=
ting this for authfile and inline as those are not supported with username-=
only. Though the test works.<br>The recommendation in those cases is to inc=
lude a dummy password.</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail">change 1602</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1602?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c18b3cf4a454444a61941d88a7=
02a140b0ac23d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1602 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 01 Apr 2026 11:58:40=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--8JkM2HPCF5Y=--

