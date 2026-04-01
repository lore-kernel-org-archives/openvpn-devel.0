From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 1 Apr 2026 15:32:48 +0000
In-Reply-To: <gerrit.1774445432000.I77500d435f212a4bf42ee8cfca07d0285fe694f2@...2715...>
References: <gerrit.1774445432000.I77500d435f212a4bf42ee8cfca07d0285fe694f2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9468288ce4031926acc7dbfad47ce31d430afb8b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xmXDasIBDJQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Use
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

--xmXDasIBDJQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1587?usp=3Demail )

Change subject: Use ASN1_BIT_STRING_get_bit to check for netscape certifica=
te usage
......................................................................


Patch Set 4: Code-Review-1

(3 comments)

File src/openvpn/ssl_verify_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1587/comment/261d53a9_1d432fb9?usp=3D=
email :
PS4, Line 619:          * Note that we do not check for netscape certificat=
e type here but rather
This line of the comment appears to describe the check above?


http://gerrit.openvpn.net/c/openvpn/+/1587/comment/de76a3de_26cc4a05?usp=3D=
email :
PS4, Line 620:          * check for a gneral SSL/TLS client purpose. We do =
not know how long nscert
general


http://gerrit.openvpn.net/c/openvpn/+/1587/comment/88061c4b_a2679e31?usp=3D=
email :
PS4, Line 621:          * attributes are accepted by TLS library in the fut=
ure. Currently OpenSSL 4.0
libraries



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1587?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I77500d435f212a4bf42ee8cfca07d0285fe694f2
Gerrit-Change-Number: 1587
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 01 Apr 2026 15:32:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--xmXDasIBDJQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1587?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_op=
enssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1587/comment/261d53a9_1d432fb9?usp=3Demai=
l">Patch Set #4, Line 619:</a> <code style=3D"font-family:monospace,monospa=
ce">         * Note that we do not check for netscape certificate type here=
 but rather</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">This line of the comment appears to describe the che=
ck above?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1587=
/comment/de76a3de_26cc4a05?usp=3Demail">Patch Set #4, Line 620:</a> <code s=
tyle=3D"font-family:monospace,monospace">         * check for a gneral SSL/=
TLS client purpose. We do not know how long nscert</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">general</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1587/comment/88061c=
4b_a2679e31?usp=3Demail">Patch Set #4, Line 621:</a> <code style=3D"font-fa=
mily:monospace,monospace">         * attributes are accepted by TLS library=
 in the future. Currently OpenSSL 4.0</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">libraries</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1587?usp=3Demail">change 1587</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/15=
87?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I77500d435f212a4bf42ee8cfca0=
7d0285fe694f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1587 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 01 Apr 2026 15:32:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--xmXDasIBDJQ=--

