From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 1 Apr 2026 10:24:45 +0000
In-Reply-To: <gerrit.1774445432000.I77500d435f212a4bf42ee8cfca07d0285fe694f2@...2715...>
References: <gerrit.1774445432000.I77500d435f212a4bf42ee8cfca07d0285fe694f2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8270503395f6523d513b2956daa33cc825c31afc-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WLpFqrOTgXM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use
 ASN1_BIT_STRING_get_bit to check for netscape certificate usage
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

--WLpFqrOTgXM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1587?usp=3Demail )

Change subject: Use ASN1_BIT_STRING_get_bit to check for netscape certifica=
te usage
......................................................................


Patch Set 3: Code-Review-1

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/1587/comment/a6196a88_86a2feb6?usp=3D=
email :
PS3, Line 13: The bit counting in ANS.1 and of this method is a bit strange=
 and
ASN


File src/openvpn/ssl_verify_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1587/comment/8acc94f5_568890ee?usp=3D=
email :
PS3, Line 621:          * case when its distribution will update to OpenSSL=
 1.1
This comments seems very obsolete? Apparently even newest OpenSSL allows us=
 to make this check? The actual warning is probably fine since it just says=
 "future", but the comment could clearly use some update?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1587?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I77500d435f212a4bf42ee8cfca07d0285fe694f2
Gerrit-Change-Number: 1587
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 01 Apr 2026 10:24:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--WLpFqrOTgXM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1587?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1587/comment/a6196a88_86a2feb6?usp=3Demail">Patch Set #3, Line=
 13:</a> <code style=3D"font-family:monospace,monospace">The bit counting i=
n ANS.1 and of this method is a bit strange and</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">ASN</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_o=
penssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1587/comment/8acc94f5_568890ee?usp=3Dema=
il">Patch Set #3, Line 621:</a> <code style=3D"font-family:monospace,monosp=
ace">         * case when its distribution will update to OpenSSL 1.1</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">This comments seems very obsolete? Apparently even newest OpenSSL all=
ows us to make this check? The actual warning is probably fine since it jus=
t says &quot;future&quot;, but the comment could clearly use some update?</=
p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1587?usp=3Demail">change 1587</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1587?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I77500d435f212a4bf42ee8cfca0=
7d0285fe694f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1587 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 01 Apr 2026 10:24:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--WLpFqrOTgXM=--

