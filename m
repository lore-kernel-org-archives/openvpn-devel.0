From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 19:02:02 +0000
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <f575e36cf636e398490162ce6a48436f3e6b1d18-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6oOGxlRqsaw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Trigger
 renegotiation of data key if getting close to the AEAD usage ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6oOGxlRqsaw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/796?usp=3Demail )

Change subject: Trigger renegotiation of data key if getting close to the A=
EAD usage limit
......................................................................


Patch Set 7:

(9 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/afd7f3b3_34658dc4 :
PS6, Line 50: Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
> That is a good question, some that post commit script did some nonsense, =
I will try to figure out wh [=E2=80=A6]
Done


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/424ddba6_d7884def :
PS6, Line 603:  * number of number of block + packets. Return -1 if ciphern=
ame is not an AEAD
> "blocks"
Done


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/734aa10c_22eb3343 :
PS6, Line 353:      *      q + s <=3D (p^36 - 1)
> `2^36`
Done


http://gerrit.openvpn.net/c/openvpn/+/796/comment/827f411c_2ae94fdb :
PS6, Line 502:     /* update number of plaintext blocks decrypted. Use the =
x + (n-1)/n trick
> Should be `(x + (n-1))/n`. The code is correct, but comment is wrong.
Done


http://gerrit.openvpn.net/c/openvpn/+/796/comment/eaad6627_493699fa :
PS6, Line 503:      * to round up the result to the number of blocked used.=
 */
> "blocks"
Done


http://gerrit.openvpn.net/c/openvpn/+/796/comment/c3a09ead_b2f38a1c :
PS6, Line 505:     opt->key_ctx_bi.decrypt.plaintext_blocks +=3D (outlen + =
(blocksize - 1))/blocksize;
> So we increase this number before we have done all checks on the packet. =
[=E2=80=A6]
thanks good catch.


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/e2fcb49b_de363156 :
PS6, Line 144:     /* set limit to 7/8 of the limit so the renogiation has =
can succeeds before
> "renegotiation can succeed" ?
Acknowledged


File src/openvpn/ssl_common.h:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/c98780b7_0c3c5759 :
PS6, Line 336:     /** This limit for AEAD cipher, this is the sum of packe=
ts + blocks
> "This" -> "The"? Or maybe just remove it?
Done


File tests/unit_tests/openvpn/test_crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/918d7aea_2d1e7962 :
PS6, Line 463:     int64_t L =3D 101;
> Please mention or use AEAD_LIMIT_BLOCKSIZE
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Gerrit-Change-Number: 796
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 28 Nov 2024 19:02:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--6oOGxlRqsaw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">View C=
hange</a></p><p>9 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/796/comment/afd7f3b3_34658dc4">Patch Set #6, Line 50:</a> <code style=
=3D"font-family:monospace,monospace">Change-Id: I057f007577f10c6ac917ee4620=
ee3d2559187dc7</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">That is a good question, some that pos=
t commit script did some nonsense, I will try to figure out wh [=E2=80=A6]<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/crypto.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/796/comment/424ddba6_d7884def">Pa=
tch Set #6, Line 603:</a> <code style=3D"font-family:monospace,monospace"> =
* number of number of block + packets. Return -1 if ciphername is not an AE=
AD</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">&quot;blocks&quot;</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/796/comment/734aa10c_22eb3343">Patch Set #6, Line 353:</a> <code s=
tyle=3D"font-family:monospace,monospace">     *      q + s &lt;=3D (p^36 - =
1)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">`2^36`</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/796/comment/827f411c_2ae94fdb">Patch Set #6, Line 50=
2:</a> <code style=3D"font-family:monospace,monospace">    /* update number=
 of plaintext blocks decrypted. Use the x + (n-1)/n trick</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Should be `(x + (n-1))/n`. The code is correct, but comment is wrong.<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796/comme=
nt/eaad6627_493699fa">Patch Set #6, Line 503:</a> <code style=3D"font-famil=
y:monospace,monospace">     * to round up the result to the number of block=
ed used. */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">&quot;blocks&quot;</blockquote></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/796/comment/c3a09ead_b2f38a1c">=
Patch Set #6, Line 505:</a> <code style=3D"font-family:monospace,monospace"=
>    opt-&gt;key_ctx_bi.decrypt.plaintext_blocks +=3D (outlen + (blocksize =
- 1))/blocksize;</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">So we increase this number before we=
 have done all checks on the packet. [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">thanks good catch.</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/796/comment/e2fcb49b_de363156">Patch Set #6, Lin=
e 144:</a> <code style=3D"font-family:monospace,monospace">    /* set limit=
 to 7/8 of the limit so the renogiation has can succeeds before</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">&quot;renegotiation can succeed&quot; ?</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_common.=
h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/796/comment/c98780b7_0c3c5759">Patch Set #6, Li=
ne 336:</a> <code style=3D"font-family:monospace,monospace">    /** This li=
mit for AEAD cipher, this is the sum of packets + blocks</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">&quot;This&quot; -&gt; &quot;The&quot;? Or maybe just remove it?</block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_te=
sts/openvpn/test_crypto.c:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796/comment/918d7aea_2d=
1e7962">Patch Set #6, Line 463:</a> <code style=3D"font-family:monospace,mo=
nospace">    int64_t L =3D 101;</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Please mention or use=
 AEAD_LIMIT_BLOCKSIZE</blockquote></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">change 796</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/796?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I057f007577f10c6ac917ee4620e=
e3d2559187dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 796 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 28 Nov 2024 19:02:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--6oOGxlRqsaw=--

