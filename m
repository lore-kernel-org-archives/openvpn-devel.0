From: "mandree (Code Review)" <gerrit@...515...>
Date: Tue, 16 Dec 2025 19:41:00 +0000
In-Reply-To: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
References: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
Reply-To: matthias.andree@...68..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b209d745eef65afa5ff7ae764ad2e7207f8b86bd-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4d78RaVYdgA="; charset=UTF-8
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

--4d78RaVYdgA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

mandree has posted comments on this change by flichtenheld. ( http://gerrit=
.openvpn.net/c/openvpn/+/1445?usp=3Demail )

Change subject: ssl_verify_openssl: Avoid conversion warning in x509_verify=
_cert_ku
......................................................................


Patch Set 1: Code-Review-2

(5 comments)

Patchset:

PS1:
I think the fixes go in the wrong direction.


File src/openvpn/ssl_verify_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1445/comment/821e73fa_f775f9c3?usp=3D=
email :
PS1, Line 678: x509_verify_cert_ku(X509 *x509, const unsigned *const expect=
ed_ku, int expected_len)
expected_len might be an unsigned int or size_t to fix warnings below.


http://gerrit.openvpn.net/c/openvpn/+/1445/comment/d6e1387e_3213e9eb?usp=3D=
email :
PS1, Line 696:     for (int i =3D 0; i < 8; i++)
I don't seem to have the ASN1_BIT_STRING_get_bit() manpage handy, but if th=
e compiler is unhappy about the nku |=3D line, make the literals unsigned, =
as in nku |=3D 1u << (7u - i) while i is some unsigned type (such as size_t=
).


http://gerrit.openvpn.net/c/openvpn/+/1445/comment/253f9ee2_e2908373?usp=3D=
email :
PS1, Line 714:     for (int i =3D 0; fFound !=3D SUCCESS && i < expected_le=
n; i++)
If this triggers a signed/unsigned mismatch on the < - that's because the i=
terator was a size_t and the expected_len argument a signed plain "int".


http://gerrit.openvpn.net/c/openvpn/+/1445/comment/360f53ad_26945225?usp=3D=
email :
PS1, Line 725:         for (int i =3D 0; i < expected_len && expected_ku[i]=
; i++)
If this triggers a signed/unsigned mismatch on the < - that's because the i=
terator was a size_t and the expected_len argument a signed plain "int".



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
Gerrit-Comment-Date: Tue, 16 Dec 2025 19:41:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--4d78RaVYdgA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail">V=
iew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1445?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think th=
e fixes go in the wrong direction.</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/ssl_verify_openssl.c:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1445/comment/821e73fa_f775f9c3?usp=3Demail">Patch Set #1, Line 678:<=
/a> <code style=3D"font-family:monospace,monospace">x509_verify_cert_ku(X50=
9 *x509, const unsigned *const expected_ku, int expected_len)</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">ex=
pected_len might be an unsigned int or size_t to fix warnings below.</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445/comment/d6e1387=
e_3213e9eb?usp=3Demail">Patch Set #1, Line 696:</a> <code style=3D"font-fam=
ily:monospace,monospace">    for (int i =3D 0; i &lt; 8; i++)</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I =
don&#39;t seem to have the ASN1_BIT_STRING_get_bit() manpage handy, but if =
the compiler is unhappy about the nku |=3D line, make the literals unsigned=
, as in nku |=3D 1u &lt;&lt; (7u - i) while i is some unsigned type (such a=
s size_t).</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
445/comment/253f9ee2_e2908373?usp=3Demail">Patch Set #1, Line 714:</a> <cod=
e style=3D"font-family:monospace,monospace">    for (int i =3D 0; fFound !=
=3D SUCCESS &amp;&amp; i &lt; expected_len; i++)</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">If this trigger=
s a signed/unsigned mismatch on the &lt; - that&#39;s because the iterator =
was a size_t and the expected_len argument a signed plain &quot;int&quot;.<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445/comment/3=
60f53ad_26945225?usp=3Demail">Patch Set #1, Line 725:</a> <code style=3D"fo=
nt-family:monospace,monospace">        for (int i =3D 0; i &lt; expected_le=
n &amp;&amp; expected_ku[i]; i++)</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">If this triggers a signed/unsi=
gned mismatch on the &lt; - that&#39;s because the iterator was a size_t an=
d the expected_len argument a signed plain &quot;int&quot;.</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1445?usp=3Demail">change 1445</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/144=
5?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 16 Dec 2025 19:41:00=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--4d78RaVYdgA=--

