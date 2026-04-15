From: "davidben (Code Review)" <gerrit@...515...>
Date: Wed, 15 Apr 2026 17:27:38 +0000
In-Reply-To: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
References: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
Reply-To: davidben@...410..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <11768229532ab3281f39684165b0a9c2a19b02b0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hm4BLFxf0bY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: MaxF <max@...2606...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hm4BLFxf0bY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld.

davidben has posted comments on this change by davidben. ( http://gerrit.op=
envpn.net/c/openvpn/+/1289?usp=3Demail )

Change subject: ssl_openssl: Fix some CRL mixups
......................................................................


Patch Set 12:

(1 comment)

File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1289/comment/4e11b60a_6a1828e8?usp=3D=
email :
PS12, Line 321:     X509_STORE_CTX_set0_crls(ctx, session->opt->ssl_ctx->cr=
ls);
> Does this function copy the CRLs into ctx, or a pointer to them?

Pointer to them. set0 functions in OpenSSL generally are a pointer to them.

> If it's the latter, does this modified X509_STORE_CTX continue to exist i=
nside the SSL_CTX after this callback?

Nope. OpenSSL is very inconsistent about the relationship between `FOO` and=
 `FOO_CTX`. `X509_STORE` is shared configuration between certificate verifi=
cations, while `X509_STORE_CTX` is a single certificate verification operat=
ion. So this object will be freed shortly after this function returns. It's=
 just a vehicle for passing the verification bits to the caller.

> (What I'm getting at is, do we need to worry about dangling pointers if r=
eload_crl is called?)

Should be OK!



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
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Wed, 15 Apr 2026 17:27:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: MaxF <max@...2606...>

--hm4BLFxf0bY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1289/comment/4e11b60a_6a1828e8?usp=3Demail">Patch Set=
 #12, Line 321:</a> <code style=3D"font-family:monospace,monospace">    X50=
9_STORE_CTX_set0_crls(ctx, session-&gt;opt-&gt;ssl_ctx-&gt;crls);</code></p=
><blockquote class=3D"blocks" style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;"><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Does this function copy the CRLs into ctx, or a=
 pointer to them?</p></blockquote><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Pointer to them. set0 functions in OpenS=
SL generally are a pointer to them.</p><blockquote class=3D"blocks" style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">If it&#=
39;s the latter, does this modified X509_STORE_CTX continue to exist inside=
 the SSL_CTX after this callback?</p></blockquote><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Nope. OpenSSL is very in=
consistent about the relationship between `FOO` and `FOO_CTX`. `X509_STORE`=
 is shared configuration between certificate verifications, while `X509_STO=
RE_CTX` is a single certificate verification operation. So this object will=
 be freed shortly after this function returns. It&#39;s just a vehicle for =
passing the verification bits to the caller.</p><blockquote class=3D"blocks=
" style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
(What I&#39;m getting at is, do we need to worry about dangling pointers if=
 reload_crl is called?)</p></blockquote><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Should be OK!</p></li></ul></li></=
ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?=
usp=3Demail">change 1289</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Apr 2026 17:27:38=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>

</body></html>=

--hm4BLFxf0bY=--

