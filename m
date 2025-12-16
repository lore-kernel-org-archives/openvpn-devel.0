From: "mandree (Code Review)" <gerrit@...515...>
Date: Tue, 16 Dec 2025 19:46:58 +0000
In-Reply-To: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
References: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
Reply-To: matthias.andree@...68..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c3db9f170d945716f7d563149f2371ad3e055251-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GO0sm8GO/HY="; charset=UTF-8
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

--GO0sm8GO/HY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

mandree has posted comments on this change by flichtenheld. ( http://gerrit=
.openvpn.net/c/openvpn/+/1445?usp=3Demail )

Change subject: ssl_verify_openssl: Avoid conversion warning in x509_verify=
_cert_ku
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/ssl_verify_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1445/comment/c27d7464_b4c44732?usp=3D=
email :
PS1, Line 696:     for (int i =3D 0; i < 8; i++)
> I don't seem to have the ASN1_BIT_STRING_get_bit() manpage handy, but if =
the compiler is unhappy about the nku |=3D line, make the literals unsigned=
, as in nku |=3D 1u << (7u - i) while i is some unsigned type (such as size=
_t).
So the 2nd argument to ASN1_BIT_STRING_get_bit() wants to be a literal "int=
" so this one change in the "for" would be OK.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d9df2b66763049
Gerrit-Change-Number: 1445
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mandree <matthias.andree@...68...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 16 Dec 2025 19:46:58 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: mandree <matthias.andree@...68...>

--GO0sm8GO/HY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_openssl=
.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1445/comment/c27d7464_b4c44732?usp=3Demail">Pa=
tch Set #1, Line 696:</a> <code style=3D"font-family:monospace,monospace"> =
   for (int i =3D 0; i &lt; 8; i++)</code></p><blockquote class=3D"blocks" =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I =
don&#39;t seem to have the ASN1_BIT_STRING_get_bit() manpage handy, but if =
the compiler is unhappy about the nku |=3D line, make the literals unsigned=
, as in nku |=3D 1u &lt;&lt; (7u - i) while i is some unsigned type (such a=
s size_t).<br>So the 2nd argument to ASN1_BIT_STRING_get_bit() wants to be =
a literal &quot;int&quot; so this one change in the &quot;for&quot; would b=
e OK.</p></blockquote></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail">change 1445</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d=
9df2b66763049 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1445 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 16 Dec 2025 19:46:58=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: mandree &lt;matthias.andr=
ee@...68...&gt; </div>

</body></html>=

--GO0sm8GO/HY=--

