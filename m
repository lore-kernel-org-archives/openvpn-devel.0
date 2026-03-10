From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 10 Mar 2026 10:51:31 +0000
In-Reply-To: <gerrit.1770053869000.I1bc576c4c7ffacbb9300608d98b06b22f2475fd9@...2715...>
References: <gerrit.1770053869000.I1bc576c4c7ffacbb9300608d98b06b22f2475fd9@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <df39503e10e064e3252df90928ce70aabe4f29a6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YNYcDFonkEM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto: Change
 cipher_kt_*_size to return size_t instead of int
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YNYcDFonkEM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by flichtenheld. ( http://gerr=
it.openvpn.net/c/openvpn/+/1508?usp=3Demail )

Change subject: crypto: Change cipher_kt_*_size to return size_t instead of=
 int
......................................................................


Patch Set 6: Code-Review-1

(3 comments)

File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/1508/comment/8b0e13d7_3c7a3f09?usp=3D=
email :
PS6, Line 91:         const unsigned int iv_len =3D cipher_ctx_iv_length(ct=
x->cipher);
Shouldn't this trigger a warning because we are putting a 8 byte int into a=
 4 byte int


File src/openvpn/crypto_backend.h:

http://gerrit.openvpn.net/c/openvpn/+/1508/comment/c62f107f_bb65928c?usp=3D=
email :
PS6, Line 284: size_t cipher_kt_tag_size(const char *ciphername);
I would like to have some more consistency here. We are making cipher_ctx_i=
v_length an unsigned int but this a size_t


http://gerrit.openvpn.net/c/openvpn/+/1508/comment/4d9f4906_47ca6c0c?usp=3D=
email :
PS6, Line 379: unsigned int cipher_ctx_block_size(const cipher_ctx_t *ctx);
This is an unsigned int while the non context uses a different return type =
of size_t



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1bc576c4c7ffacbb9300608d98b06b22f2475fd9
Gerrit-Change-Number: 1508
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 10 Mar 2026 10:51:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--YNYcDFonkEM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail">V=
iew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1508/comment/8b0e13d7_3c7a3f09?usp=3Demail">Patch Set=
 #6, Line 91:</a> <code style=3D"font-family:monospace,monospace">        c=
onst unsigned int iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher);</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Shouldn&#39;t this trigger a warning because we are putting a 8 byte int=
 into a 4 byte int</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/crypto_backend.h:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1508/comment/=
c62f107f_bb65928c?usp=3Demail">Patch Set #6, Line 284:</a> <code style=3D"f=
ont-family:monospace,monospace">size_t cipher_kt_tag_size(const char *ciphe=
rname);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">I would like to have some more consistency here. We are =
making cipher_ctx_iv_length an unsigned int but this a size_t</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1508/comment/4d9f4906_47ca6=
c0c?usp=3Demail">Patch Set #6, Line 379:</a> <code style=3D"font-family:mon=
ospace,monospace">unsigned int cipher_ctx_block_size(const cipher_ctx_t *ct=
x);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">This is an unsigned int while the non context uses a differe=
nt return type of size_t</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail">change 1508</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1508?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1bc576c4c7ffacbb9300608d98b=
06b22f2475fd9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1508 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Mar 2026 10:51:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--YNYcDFonkEM=--

