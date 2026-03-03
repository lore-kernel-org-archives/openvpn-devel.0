From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 3 Mar 2026 14:21:49 +0000
In-Reply-To: <gerrit.1754490554000.I4e75ba1dbc6d9a0f75298bc900f713b67e60d096@...2715...>
References: <gerrit.1754490554000.I4e75ba1dbc6d9a0f75298bc900f713b67e60d096@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <af898765ce663469d5528d17a23d5162fb7c4cee-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PdoT+tUVDIc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Add BLENZ
 macro that returns size_t and use it where required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PdoT+tUVDIc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by flichtenheld. ( http://g=
errit.openvpn.net/c/openvpn/+/1132?usp=3Demail )

Change subject: buffer: Add BLENZ macro that returns size_t and use it wher=
e required
......................................................................


Set Ready For Review


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1132?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4e75ba1dbc6d9a0f75298bc900f713b67e60d096
Gerrit-Change-Number: 1132
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Tue, 03 Mar 2026 14:21:49 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--PdoT+tUVDIc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Set Ready For Review</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1132?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; paddi=
ng: 0;"></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1132?usp=3Demail">change 1132</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1132?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4e75ba1dbc6d9a0f75298bc900f=
713b67e60d096 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1132 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Mar 2026 14:21:49=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--PdoT+tUVDIc=--

