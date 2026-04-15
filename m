From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 15 Apr 2026 16:39:29 +0000
In-Reply-To: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
References: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227..., davidben@...410...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3403b3ac0c3f7122adce2cc066b87ae69fa81609-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tzoxgiJsbXQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl_openssl: Fix
 some CRL mixups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, davidben <davidben@...410...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tzoxgiJsbXQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: davidben, flichtenheld.

MaxF has posted comments on this change by davidben. ( http://gerrit.openvp=
n.net/c/openvpn/+/1289?usp=3Demail )

Change subject: ssl_openssl: Fix some CRL mixups
......................................................................


Patch Set 12:

(2 comments)

Patchset:

PS12:
This makes sense to me, but I don't know these functions in-depth. Just one=
 question about how exactly X509_STORE_CTX_set0_crls() copies the CRLs.


File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1289/comment/c1a234c8_f81029f6?usp=3D=
email :
PS12, Line 321:     X509_STORE_CTX_set0_crls(ctx, session->opt->ssl_ctx->cr=
ls);
Does this function copy the CRLs into ctx, or a pointer to them? If it's th=
e latter, does this modified X509_STORE_CTX continue to exist inside the SS=
L_CTX  after this callback? (What I'm getting at is, do we need to worry ab=
out dangling pointers if reload_crl is called?)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31ac2a763209114267c35c4a9182a12d8d82f6fe
Gerrit-Change-Number: 1289
Gerrit-PatchSet: 12
Gerrit-Owner: davidben <davidben@...410...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: davidben <davidben@...410...>
Gerrit-Comment-Date: Wed, 15 Apr 2026 16:39:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--tzoxgiJsbXQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: davidben, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1289?tab=3Dcomments&amp;usp=3Demail">Patch Set #12:</a> </p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This makes se=
nse to me, but I don&#39;t know these functions in-depth. Just one question=
 about how exactly X509_STORE_CTX_set0_crls() copies the CRLs.</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1289/comment/c1a234c8_f81029f6?usp=3Demail">Pat=
ch Set #12, Line 321:</a> <code style=3D"font-family:monospace,monospace"> =
   X509_STORE_CTX_set0_crls(ctx, session-&gt;opt-&gt;ssl_ctx-&gt;crls);</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Does this function copy the CRLs into ctx, or a pointer to them? If=
 it&#39;s the latter, does this modified X509_STORE_CTX continue to exist i=
nside the SSL_CTX  after this callback? (What I&#39;m getting at is, do we =
need to worry about dangling pointers if reload_crl is called?)</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1289?usp=3Demail">change 1289</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1289?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31ac2a763209114267c35c4a918=
2a12d8d82f6fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1289 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: davidben &lt;davidben@...410...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: davidben &lt;davidben@...2975...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Apr 2026 16:39:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--tzoxgiJsbXQ=--

