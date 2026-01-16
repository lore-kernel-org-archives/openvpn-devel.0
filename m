From: "mandree (Code Review)" <gerrit@...515...>
Date: Fri, 16 Jan 2026 19:31:43 +0000
In-Reply-To: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
References: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
Reply-To: matthias.andree@...68..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ebb55f6a21153912b3cc75594f8b434c8dcfd42e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jE1QeiOfGHA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify_openssl:
 Avoid conversion warning in x509_verify_cert_ku
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jE1QeiOfGHA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

mandree has posted comments on this change by flichtenheld. ( http://gerrit=
.openvpn.net/c/openvpn/+/1445?usp=3Demail )

Change subject: ssl_verify_openssl: Avoid conversion warning in x509_verify=
_cert_ku
......................................................................


Patch Set 4: Code-Review+1


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d9df2b66763049
Gerrit-Change-Number: 1445
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mandree <matthias.andree@...68...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 16 Jan 2026 19:31:43 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--jE1QeiOfGHA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail">V=
iew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail=
">change 1445</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d=
9df2b66763049 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1445 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mandree &lt;matthias.andree@...220...=
..68...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 16 Jan 2026 19:31:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--jE1QeiOfGHA=--

