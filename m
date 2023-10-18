From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 18 Oct 2023 10:44:43 +0000
In-Reply-To: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
References: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, max@...2606...
Message-ID: <1df1c41b6aaa6c199c9709cfdca746f795ecef0c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SKJwvdvCTxg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add support for
 mbedtls 3.X.Y
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SKJwvdvCTxg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/370?usp=3Demail )

Change subject: Add support for mbedtls 3.X.Y
......................................................................


Patch Set 1: Code-Review-1

(12 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/aab50ccd_b3f897e3 :
PS1, Line 28: This commit breaks compatibility for mbed TLS version 2.x.y. A
That makes me unhappy. Can we have the changes in an order so that existing=
 builds do not get broken?


Patchset:

PS1:
Lots of nitpicks, mostly


File src/openvpn/crypto_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/01666ef9_bb9a9c08 :
PS1, Line 174:         if (info && name
why is the cipher_kt_insecure check missing here?


http://gerrit.openvpn.net/c/openvpn/+/370/comment/2aade4a0_473c3942 :
PS1, Line 423:     int key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(c=
ipher)/8;
That function seems to return size_t, so should change to correct type. Can=
 probably mark this as const.


http://gerrit.openvpn.net/c/openvpn/+/370/comment/92cbb001_0e886286 :
PS1, Line 459:     return mbedtls_cipher_info_get_key_bitlen(cipher_kt)/8;
returns size_t


http://gerrit.openvpn.net/c/openvpn/+/370/comment/5c87ca0d_15ec38d9 :
PS1, Line 471:     return mbedtls_cipher_info_get_iv_size(cipher_kt);
returns size_t


http://gerrit.openvpn.net/c/openvpn/+/370/comment/8a8454de_c71c3294 :
PS1, Line 482:     return mbedtls_cipher_info_get_block_size(cipher_kt);
returns size_t


http://gerrit.openvpn.net/c/openvpn/+/370/comment/9ff5f0a4_2587b778 :
PS1, Line 575:     int key_len =3D mbedtls_cipher_info_get_key_bitlen(kt)/8;
returns size_t


http://gerrit.openvpn.net/c/openvpn/+/370/comment/64a7ebc5_376b0cd8 :
PS1, Line 624:     return mbedtls_cipher_get_cipher_mode(ctx);
returns mbedtls_cipher_mode_t


http://gerrit.openvpn.net/c/openvpn/+/370/comment/a83a2860_08071efc :
PS1, Line 873:     return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx)=
);
returns unsigned char, but since this fits completely into int, this is fin=
e.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/6090c0ad_d2519496 :
PS1, Line 9049: #endif
Please use #else here so that static analysis doesn't complain about unreac=
hable code.


File src/openvpn/ssl_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/370/comment/c7cb421f_7d64647e :
PS1, Line 67: #ifndef HAVE_CTR_DRBG_UPDATE_RET
Since you remove support for mbedtls < 2.16, this code can be removed?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I445a93e84dc54b865b757038d22318ac427fce96
Gerrit-Change-Number: 370
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Wed, 18 Oct 2023 10:44:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--SKJwvdvCTxg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail">Vi=
ew Change</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/370/comment/aab50ccd_b3f897e3">Patch Set #1, Line 28:</a> <cod=
e style=3D"font-family:monospace,monospace">This commit breaks compatibilit=
y for mbed TLS version 2.x.y. A</code></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">That makes me unhappy. Can we have the changes in=
 an order so that existing builds do not get broken?</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370?=
tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Lots of nitpicks, mostly</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_mbedtls.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/370/comment/01666ef9_bb9a9c08">Patch Set #1, Line 174:</a> =
<code style=3D"font-family:monospace,monospace">        if (info &amp;&amp;=
 name</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
why is the cipher_kt_insecure check missing here?</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/370/comment/2aade4a0_473c3942">Patch Se=
t #1, Line 423:</a> <code style=3D"font-family:monospace,monospace">    int=
 key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(cipher)/8;</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">That function seem=
s to return size_t, so should change to correct type. Can probably mark thi=
s as const.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
70/comment/92cbb001_0e886286">Patch Set #1, Line 459:</a> <code style=3D"fo=
nt-family:monospace,monospace">    return mbedtls_cipher_info_get_key_bitle=
n(cipher_kt)/8;</code></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">returns size_t</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/370/comment/5c87ca0d_15ec38d9">Patch Set #1, Line 471:</a> <code=
 style=3D"font-family:monospace,monospace">    return mbedtls_cipher_info_g=
et_iv_size(cipher_kt);</code></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">returns size_t</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/370/comment/8a8454de_c71c3294">Patch Set #1, Line 482:</a=
> <code style=3D"font-family:monospace,monospace">    return mbedtls_cipher=
_info_get_block_size(cipher_kt);</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">returns size_t</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/370/comment/9ff5f0a4_2587b778">Patch Set #1, Li=
ne 575:</a> <code style=3D"font-family:monospace,monospace">    int key_len=
 =3D mbedtls_cipher_info_get_key_bitlen(kt)/8;</code></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">returns size_t</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/370/comment/64a7ebc5_376b0cd8">=
Patch Set #1, Line 624:</a> <code style=3D"font-family:monospace,monospace"=
>    return mbedtls_cipher_get_cipher_mode(ctx);</code></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">returns mbedtls_cipher_mode_t</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370/comment/a83a=
2860_08071efc">Patch Set #1, Line 873:</a> <code style=3D"font-family:monos=
pace,monospace">    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx=
));</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">re=
turns unsigned char, but since this fits completely into int, this is fine.=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/370/comment/6090c0ad_d2519496">Patch S=
et #1, Line 9049:</a> <code style=3D"font-family:monospace,monospace">#endi=
f</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Plea=
se use #else here so that static analysis doesn&#39;t complain about unreac=
hable code.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/ssl_mbedtls.c:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370/comment/c7cb421f_7d=
64647e">Patch Set #1, Line 67:</a> <code style=3D"font-family:monospace,mon=
ospace">#ifndef HAVE_CTR_DRBG_UPDATE_RET</code></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Since you remove support for mbedtls &lt=
; 2.16, this code can be removed?</p></li></ul></li></ul><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail">change 37=
0</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I445a93e84dc54b865b757038d22=
318ac427fce96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 370 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Oct 2023 10:44:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--SKJwvdvCTxg=--

