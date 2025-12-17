From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 17 Dec 2025 14:26:05 +0000
In-Reply-To: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
References: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 matthias.andree@...68..., openvpn-devel@lists.sourceforge.net
Message-ID: <bdab3a3efe16a7ab8059cfe860483c8324af7da2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GfCyDcz/n9I="; charset=UTF-8
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
Cc: mandree <matthias.andree@...68...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GfCyDcz/n9I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mandree, plaisthos.

flichtenheld has posted comments on this change by flichtenheld. ( http://g=
errit.openvpn.net/c/openvpn/+/1445?usp=3Demail )

Change subject: ssl_verify_openssl: Avoid conversion warning in x509_verify=
_cert_ku
......................................................................


Patch Set 2:

(3 comments)

File src/openvpn/ssl_verify_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1445/comment/daf21b8d_ebd343a0?usp=3D=
email :
PS1, Line 678: x509_verify_cert_ku(X509 *x509, const unsigned *const expect=
ed_ku, int expected_len)
> expected_len might be an unsigned int or size_t to fix warnings below.
Done


http://gerrit.openvpn.net/c/openvpn/+/1445/comment/c6d817b4_b71d7230?usp=3D=
email :
PS1, Line 714:     for (int i =3D 0; fFound !=3D SUCCESS && i < expected_le=
n; i++)
> If this triggers a signed/unsigned mismatch on the < - that's because the=
 iterator was a size_t and  [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1445/comment/f6912297_5457cc36?usp=3D=
email :
PS1, Line 725:         for (int i =3D 0; i < expected_len && expected_ku[i]=
; i++)
> If this triggers a signed/unsigned mismatch on the < - that's because the=
 iterator was a size_t and  [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d9df2b66763049
Gerrit-Change-Number: 1445
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mandree <matthias.andree@...68...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mandree <matthias.andree@...68...>
Gerrit-Comment-Date: Wed, 17 Dec 2025 14:26:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: mandree <matthias.andree@...68...>

--GfCyDcz/n9I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: mandree, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_openss=
l.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1445/comment/daf21b8d_ebd343a0?usp=3Demail">P=
atch Set #1, Line 678:</a> <code style=3D"font-family:monospace,monospace">=
x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku, int expe=
cted_len)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">expected_len might be an unsigned int or si=
ze_t to fix warnings below.</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1445/comment/c6d817b4_b71d7230?usp=3Dem=
ail">Patch Set #1, Line 714:</a> <code style=3D"font-family:monospace,monos=
pace">    for (int i =3D 0; fFound !=3D SUCCESS &amp;&amp; i &lt; expected_=
len; i++)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">If this triggers a signed/unsigned mismatch=
 on the &lt; - that&#39;s because the iterator was a size_t and  [=E2=80=A6=
]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1445/comment/f6912297_5457cc36?usp=3Demail">Patch Set #1, Line 72=
5:</a> <code style=3D"font-family:monospace,monospace">        for (int i =
=3D 0; i &lt; expected_len &amp;&amp; expected_ku[i]; i++)</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">If this triggers a signed/unsigned mismatch on the &lt; - that&#39;s =
because the iterator was a size_t and  [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1445?usp=3Demail">change 1445</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1445?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d=
9df2b66763049 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1445 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: mandree &lt;matthias.andree@=
...68...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 17 Dec 2025 14:26:05=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: mandree &lt;matthias.andr=
ee@...68...&gt; </div>

</body></html>=

--GfCyDcz/n9I=--

