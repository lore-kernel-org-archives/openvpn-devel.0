From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 10:47:30 +0000
In-Reply-To: <gerrit.1770053869000.I1bc576c4c7ffacbb9300608d98b06b22f2475fd9@...2715...>
References: <gerrit.1770053869000.I1bc576c4c7ffacbb9300608d98b06b22f2475fd9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7fc9a3bf2bb77758b06011f2e644b1856bd5ba45-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K1rIeZ0r+LI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto: Change
 cipher_kt_*_size to return unsigned instead of int
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--K1rIeZ0r+LI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by flichtenheld. ( http://g=
errit.openvpn.net/c/openvpn/+/1508?usp=3Demail )

Change subject: crypto: Change cipher_kt_*_size to return unsigned instead =
of int
......................................................................


Patch Set 7:

(4 comments)

Patchset:

PS6:
> Could we make it just unsigned int instead? Using a size_t for something =
that is not really somethin [=E2=80=A6]
Done


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/1508/comment/4868ae72_9464a4d3?usp=3D=
email :
PS6, Line 91:         const unsigned int iv_len =3D cipher_ctx_iv_length(ct=
x->cipher);
> Shouldn't this trigger a warning because we are putting a 8 byte int into=
 a 4 byte int
Acknowledged


File src/openvpn/crypto_backend.h:

http://gerrit.openvpn.net/c/openvpn/+/1508/comment/70af9e9e_335e1b00?usp=3D=
email :
PS6, Line 284: size_t cipher_kt_tag_size(const char *ciphername);
> I would like to have some more consistency here. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1508/comment/36f5a73f_70322dfd?usp=3D=
email :
PS6, Line 379: unsigned int cipher_ctx_block_size(const cipher_ctx_t *ctx);
> This is an unsigned int while the non context uses a different return typ=
e of size_t
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1bc576c4c7ffacbb9300608d98b06b22f2475fd9
Gerrit-Change-Number: 1508
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 11 Mar 2026 10:47:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>

--K1rIeZ0r+LI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail">View =
Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1508?tab=3Dcomments&amp;usp=3Demail">Patch Set #6:</a> </p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Cou=
ld we make it just unsigned int instead? Using a size_t for something that =
is not really somethin [=E2=80=A6]</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1508/comment/4868ae72_9464a4d3?usp=3Demail">Patch Set #6, =
Line 91:</a> <code style=3D"font-family:monospace,monospace">        const =
unsigned int iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher);</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Shouldn&#39;t this trigger a warning because we are putting a 8 by=
te int into a 4 byte int</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_backend.h:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1508/comment/70af9e9e_335e1b00?usp=3Demail">Patch Se=
t #6, Line 284:</a> <code style=3D"font-family:monospace,monospace">size_t =
cipher_kt_tag_size(const char *ciphername);</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I would =
like to have some more consistency here. [=E2=80=A6]</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done<=
/p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1508/comment/3=
6f5a73f_70322dfd?usp=3Demail">Patch Set #6, Line 379:</a> <code style=3D"fo=
nt-family:monospace,monospace">unsigned int cipher_ctx_block_size(const cip=
her_ctx_t *ctx);</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">This is an unsigned int while the no=
n context uses a different return type of size_t</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1508?usp=3Demail">change 1508</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1508?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1bc576c4c7ffacbb9300608d98b=
06b22f2475fd9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1508 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Mar 2026 10:47:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>

</body></html>=

--K1rIeZ0r+LI=--

