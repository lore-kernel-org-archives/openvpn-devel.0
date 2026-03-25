From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 25 Mar 2026 14:55:26 +0000
In-Reply-To: <gerrit.1774445432000.Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a@...2715...>
References: <gerrit.1774445432000.Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7f8d5907ed58de11075266fb4463b30ca47b50ed-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MhAqJ+hGzWY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use const
 specifices in extract_x509_field_ssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MhAqJ+hGzWY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1588?usp=3Demail )

Change subject: Use const specifices in  extract_x509_field_ssl
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/ssl_verify_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1588/comment/705b14cd_cb71802f?usp=3D=
email :
PS1, Line 229:     const ASN1_STRING *asn1 =3D asn1 =3D X509_NAME_ENTRY_get=
_data(x509ne);
redundant `asn1 =3D`



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1588?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a
Gerrit-Change-Number: 1588
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 25 Mar 2026 14:55:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--MhAqJ+hGzWY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1588?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_ope=
nssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1588/comment/705b14cd_cb71802f?usp=3Demail=
">Patch Set #1, Line 229:</a> <code style=3D"font-family:monospace,monospac=
e">    const ASN1_STRING *asn1 =3D asn1 =3D X509_NAME_ENTRY_get_data(x509ne=
);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">redundant `asn1 =3D`</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1588?usp=3Demail">change =
1588</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1588?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia43bb88d9ddf2e82c638011353a=
64c770f2c2c0a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1588 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Mar 2026 14:55:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--MhAqJ+hGzWY=--

