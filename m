From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 15 Apr 2026 18:16:05 +0000
In-Reply-To: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
References: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
Reply-To: arne-openvpn@...1227..., davidben@...410...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <22df74b257cac363ef7e83d9406be4c474422b94-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XyReW5cepa8="; charset=UTF-8
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
Cc: MaxF <max@...2606...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XyReW5cepa8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, davidben, flichtenheld.

plaisthos has posted comments on this change by davidben. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1289?usp=3Demail )

Change subject: ssl_openssl: Fix some CRL mixups
......................................................................


Patch Set 12: Code-Review+2

(1 comment)

File src/openvpn/ssl_openssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1289/comment/6820491f_1542525e?usp=3D=
email :
PS12, Line 321:     X509_STORE_CTX_set0_crls(ctx, session->opt->ssl_ctx->cr=
ls);
> Does this function copy the CRLs into ctx, or a pointer to them? If it's =
the latter, does this modif [=E2=80=A6]
set0/get0 in OpenSSL terms mean no copy being made. We are really passing t=
he pointer.

This is not super avoid but     session->opt->ssl_ctx is a pointer that poi=
nts to the global tls_root_ctx. Commit 44dd39b3ef actually makes it a real =
pointer. Before it was as well but in a very weird way that all the pointer=
s in that ssl_ctx would point to a global object but ssl_ctx still being lo=
cal.

The pointer is technically dangling but since we set that before every acce=
ss of it (in the callback), the pointer is also always updated.



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
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Wed, 15 Apr 2026 18:16:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: MaxF <max@...2606...>

--XyReW5cepa8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, davidben, flichtenheld. </p>
<p>Patch set 12:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_openssl.c=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1289/comment/6820491f_1542525e?usp=3Demail">Patc=
h Set #12, Line 321:</a> <code style=3D"font-family:monospace,monospace">  =
  X509_STORE_CTX_set0_crls(ctx, session-&gt;opt-&gt;ssl_ctx-&gt;crls);</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">Does this function copy the CRLs into ctx, or a pointer t=
o them? If it&#39;s the latter, does this modif [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">set0/get0 in OpenSSL terms mean no copy being made. We are really passing=
 the pointer. </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">This is not super avoid but     session-&gt;opt-&gt;ssl_=
ctx is a pointer that points to the global tls_root_ctx. Commit 44dd39b3ef =
actually makes it a real pointer. Before it was as well but in a very weird=
 way that all the pointers in that ssl_ctx would point to a global object b=
ut ssl_ctx still being local.</p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">The pointer is technically dangling but s=
ince we set that before every access of it (in the callback), the pointer i=
s also always updated.</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail">change 1289</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Apr 2026 18:16:05=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>

</body></html>=

--XyReW5cepa8=--

