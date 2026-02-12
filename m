From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 12 Feb 2026 12:24:09 +0000
In-Reply-To: <gerrit.1755879913000.Ic9ac18f730e6035126ccf1cf19799548e5fd9316@...2715...>
References: <gerrit.1755879913000.Ic9ac18f730e6035126ccf1cf19799548e5fd9316@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <cd7958f4793a60f5a90d53cfcd1a11c1818622f7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TpDtcSgTFlE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: Move <= 0
 check for keepalive settings earlier
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TpDtcSgTFlE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by flichtenheld. ( http://g=
errit.openvpn.net/c/openvpn/+/1155?usp=3Demail )

Change subject: options: Move <=3D 0 check for keepalive settings earlier
......................................................................


Patch Set 7:

(1 comment)

This change is ready for review.

Patchset:

PS7:
Moving this out of draft status. I was originally hesitant to put this into=
 the RCs, but it is definitely fine for post-2.7 master



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1155?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316
Gerrit-Change-Number: 1155
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Thu, 12 Feb 2026 12:24:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--TpDtcSgTFlE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1155?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1155?tab=3Dcomments&amp;usp=3Demail">Patch Set #7:</a> </p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Moving this out=
 of draft status. I was originally hesitant to put this into the RCs, but i=
t is definitely fine for post-2.7 master</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1155?usp=3Demail">c=
hange 1155</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1155?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9ac18f730e6035126ccf1cf197=
99548e5fd9316 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1155 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Feb 2026 12:24:09=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--TpDtcSgTFlE=--

