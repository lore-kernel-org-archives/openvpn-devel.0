From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 16:55:20 +0000
In-Reply-To: <gerrit.1774974242000.Id8680e6555a66024417d6eb9322d4fde79922453@...2715...>
References: <gerrit.1774974242000.Id8680e6555a66024417d6eb9322d4fde79922453@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <206bbfeae83c92b93ede479dc9a6fbf480d97de3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m4xk8w5RraY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename key* to
 privkey* in cert_data.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--m4xk8w5RraY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by plaisthos. ( http://gerrit.=
openvpn.net/c/openvpn/+/1597?usp=3Demail )

Change subject: Rename key* to privkey* in cert_data.h
......................................................................


Patch Set 2:

(1 comment)

File tests/unit_tests/openvpn/test_pkcs11.c:

http://gerrit.openvpn.net/c/openvpn/+/1597/comment/f99da7b2_1b6c52c6?usp=3D=
email :
PS1, Line 145:         { cert1, key1, cname1, "OVPN TEST CA1", "OVPN Test C=
ert 1", { 0 }, NULL },
> When you trust your IDE to do the rename and only build the test you are =
working on. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1597?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id8680e6555a66024417d6eb9322d4fde79922453
Gerrit-Change-Number: 1597
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 31 Mar 2026 16:55:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--m4xk8w5RraY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1597?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_=
pkcs11.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1597/comment/f99da7b2_1b6c52c6?usp=3Dema=
il">Patch Set #1, Line 145:</a> <code style=3D"font-family:monospace,monosp=
ace">        { cert1, key1, cname1, &quot;OVPN TEST CA1&quot;, &quot;OVPN T=
est Cert 1&quot;, { 0 }, NULL },</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">When you trust your =
IDE to do the rename and only build the test you are working on. [=E2=80=A6=
]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1597?usp=3Demail">change 1597</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1597?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id8680e6555a66024417d6eb9322=
d4fde79922453 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1597 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@...2641...&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 31 Mar 2026 16:55:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--m4xk8w5RraY=--

