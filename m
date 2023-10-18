From: "MaxF (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 17:02:51 +0000
In-Reply-To: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
References: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a985b88ad3ebb9ed4a2cc0154b8398d790f851ba-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LrjcrRw06B8="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for
 mbedtls 3.X.Y
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LrjcrRw06B8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/370?usp=3Demail )

Change subject: Add support for mbedtls 3.X.Y
......................................................................


Patch Set 2:

(11 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/1e1bd1ee_e11801b6 :
PS1, Line 28: This commit breaks compatibility for mbed TLS version 2.x.y. A
> Would you prefer to put the two commits together into one? [=E2=80=A6]
Done


File src/openvpn/crypto_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/008f3995_73f1ae0c :
PS1, Line 174:         if (info && name
> By accident. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/370/comment/66051a9c_642a1e63 :
PS1, Line 423:     int key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(c=
ipher)/8;
> That function seems to return size_t, so should change to correct type. [=
=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/370/comment/c10ad802_99af1817 :
PS1, Line 459:     return mbedtls_cipher_info_get_key_bitlen(cipher_kt)/8;
> returns size_t
Done


http://gerrit.openvpn.net/c/openvpn/+/370/comment/be1a8941_5596cf61 :
PS1, Line 471:     return mbedtls_cipher_info_get_iv_size(cipher_kt);
> returns size_t
Done


http://gerrit.openvpn.net/c/openvpn/+/370/comment/9ae7a2af_718cafbf :
PS1, Line 482:     return mbedtls_cipher_info_get_block_size(cipher_kt);
> returns size_t
Done


http://gerrit.openvpn.net/c/openvpn/+/370/comment/99ffebe4_f1f1bd12 :
PS1, Line 575:     int key_len =3D mbedtls_cipher_info_get_key_bitlen(kt)/8;
> returns size_t
Done


http://gerrit.openvpn.net/c/openvpn/+/370/comment/caa37eb7_96175d1a :
PS1, Line 624:     return mbedtls_cipher_get_cipher_mode(ctx);
> returns mbedtls_cipher_mode_t
Done


http://gerrit.openvpn.net/c/openvpn/+/370/comment/d4b69ec4_32c46882 :
PS1, Line 873:     return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx)=
);
> returns unsigned char, but since this fits completely into int, this is f=
ine.
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/d0411b3f_dc08e26f :
PS1, Line 9049: #endif
> Please use #else here so that static analysis doesn't complain about unre=
achable code.
Done


File src/openvpn/ssl_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/3c48b929_e7bfd684 :
PS1, Line 67: #ifndef HAVE_CTR_DRBG_UPDATE_RET
> We discussed in the community meeting today that support for older versio=
ns still makes sense. [=E2=80=A6]
Actually, it can go, but I now need a different compatibility function...

very old mbedtls: ..._update() has no return value
old mbedtls: ..._update() deprecated, ..._update_ret() has return value
current: ..._update() has return value, ..._update_ret() doesn't exist



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I445a93e84dc54b865b757038d22318ac427fce96
Gerrit-Change-Number: 370
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 18 Oct 2023 17:02:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: MaxF <max@...2606...>
Gerrit-MessageType: comment

--LrjcrRw06B8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail">View C=
hange</a></p><p>11 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/370/comment/1e1bd1ee_e11801b6">Patch Set #1, Line 28:</a> <code styl=
e=3D"font-family:monospace,monospace">This commit breaks compatibility for =
mbed TLS version 2.x.y. A</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">Would you prefer to put the=
 two commits together into one? [=E2=80=A6]</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_mbedtls.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/370/comment/008f3995_73f1ae0c">Patch Set #1, Line 174:</a>=
 <code style=3D"font-family:monospace,monospace">        if (info &amp;&amp=
; name</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">By accident. [=E2=80=A6]</blockquote></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/370/comment/66051a9c_642a1e63"=
>Patch Set #1, Line 423:</a> <code style=3D"font-family:monospace,monospace=
">    int key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(cipher)/8;</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">That function seems to return size_t, so should change t=
o correct type. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/370/comment/c10ad802_99af1817">Patch Set #1, Line 459:</=
a> <code style=3D"font-family:monospace,monospace">    return mbedtls_ciphe=
r_info_get_key_bitlen(cipher_kt)/8;</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">returns size_t</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370/comment=
/be1a8941_5596cf61">Patch Set #1, Line 471:</a> <code style=3D"font-family:=
monospace,monospace">    return mbedtls_cipher_info_get_iv_size(cipher_kt);=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">returns size_t</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/370/comment/9ae7a2af_718cafbf">Patch Set #1, L=
ine 482:</a> <code style=3D"font-family:monospace,monospace">    return mbe=
dtls_cipher_info_get_block_size(cipher_kt);</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">returns =
size_t</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
70/comment/99ffebe4_f1f1bd12">Patch Set #1, Line 575:</a> <code style=3D"fo=
nt-family:monospace,monospace">    int key_len =3D mbedtls_cipher_info_get_=
key_bitlen(kt)/8;</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">returns size_t</blockquote></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/370/comment/caa37eb7_96175d1a=
">Patch Set #1, Line 624:</a> <code style=3D"font-family:monospace,monospac=
e">    return mbedtls_cipher_get_cipher_mode(ctx);</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">re=
turns mbedtls_cipher_mode_t</blockquote></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/370/comment/d4b69ec4_32c46882">Patch Set #1, Line 873:</=
a> <code style=3D"font-family:monospace,monospace">    return mbedtls_md_ge=
t_size(mbedtls_md_info_from_ctx(ctx));</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">returns unsign=
ed char, but since this fits completely into int, this is fine.</blockquote=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/option=
s.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/370/comment/d0411b3f_dc08e26f">Patch Set #1, =
Line 9049:</a> <code style=3D"font-family:monospace,monospace">#endif</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">Please use #else here so that static analysis doesn&#39;t =
complain about unreachable code.</blockquote></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/ssl_mbedtls.c:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/370/comment/3c48b929_e7bfd684">Patch Set #1, Line 67:</a> <code style=3D=
"font-family:monospace,monospace">#ifndef HAVE_CTR_DRBG_UPDATE_RET</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">We discussed in the community meeting today that support for =
older versions still makes sense. [=E2=80=A6]</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Actually, it can go, but I no=
w need a different compatibility function...</p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">very old mbedtls: ..._update() has no retur=
n value<br>old mbedtls: ..._update() deprecated, ..._update_ret() has retur=
n value<br>current: ..._update() has return value, ..._update_ret() doesn&#=
39;t exist</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/370?usp=3Demail">change 370</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/370?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I445a93e84dc54b865b757038d22=
318ac427fce96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 370 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Oct 2023 17:02:51=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@...2606...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--LrjcrRw06B8=--

