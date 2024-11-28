From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 09:47:14 +0000
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <150e6e5a29cda7db0f8eca901804b8db34ae787e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fjPrUXGko5I="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fjPrUXGko5I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/796?usp=3Demail )

Change subject: Trigger renegotiation of data key if getting close to the A=
EAD usage limit
......................................................................


Patch Set 6: Code-Review-1

(8 comments)

File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/cd492ae9_fd17bd7c :
PS6, Line 603:  * number of number of block + packets. Return -1 if ciphern=
ame is not an AEAD
"blocks"


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/884aa131_043fac76 :
PS6, Line 353:      *      q + s <=3D (p^36 - 1)
`2^36`


http://gerrit.openvpn.net/c/openvpn/+/796/comment/5487e9b6_1af10abb :
PS6, Line 502:     /* update number of plaintext blocks decrypted. Use the =
x + (n-1)/n trick
Should be `(x + (n-1))/n`. The code is correct, but comment is wrong.


http://gerrit.openvpn.net/c/openvpn/+/796/comment/38ba5a32_7a3341ec :
PS6, Line 503:      * to round up the result to the number of blocked used.=
 */
"blocks"


http://gerrit.openvpn.net/c/openvpn/+/796/comment/4cbb5beb_e82ad0e6 :
PS6, Line 505:     opt->key_ctx_bi.decrypt.plaintext_blocks +=3D (outlen + =
(blocksize - 1))/blocksize;
So we increase this number before we have done all checks on the packet. Do=
esn't that open us up to potential attacks that force renegotiation by repl=
aying packets?


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/dc63e5a8_82d0b335 :
PS6, Line 144:     /* set limit to 7/8 of the limit so the renogiation has =
can succeeds before
"renegotiation can succeed" ?


File src/openvpn/ssl_common.h:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/728ac18b_aa309cd4 :
PS6, Line 336:     /** This limit for AEAD cipher, this is the sum of packe=
ts + blocks
"This" -> "The"? Or maybe just remove it?


File tests/unit_tests/openvpn/test_crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/fd854db2_f454d881 :
PS6, Line 463:     int64_t L =3D 101;
Please mention or use AEAD_LIMIT_BLOCKSIZE



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Gerrit-Change-Number: 796
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Thu, 28 Nov 2024 09:47:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--fjPrUXGko5I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">Vi=
ew Change</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.h:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/796/comment/cd492ae9_fd17bd7c">Patch Set #6, Line 603:=
</a> <code style=3D"font-family:monospace,monospace"> * number of number of=
 block + packets. Return -1 if ciphername is not an AEAD</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;blocks&quot;</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypt=
o.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/796/comment/884aa131_043fac76">Patch Set #6, =
Line 353:</a> <code style=3D"font-family:monospace,monospace">     *      q=
 + s &lt;=3D (p^36 - 1)</code></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">`2^36`</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/796/comment/5487e9b6_1af10abb">Patch Set #6, Line 502:</a> <code=
 style=3D"font-family:monospace,monospace">    /* update number of plaintex=
t blocks decrypted. Use the x + (n-1)/n trick</code></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Should be `(x + (n-1))/n`. The code=
 is correct, but comment is wrong.</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/796/comment/38ba5a32_7a3341ec">Patch Set #6, Line 503:=
</a> <code style=3D"font-family:monospace,monospace">     * to round up the=
 result to the number of blocked used. */</code></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">&quot;blocks&quot;</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/796/comment/4cbb5beb_e82ad0e6">Pa=
tch Set #6, Line 505:</a> <code style=3D"font-family:monospace,monospace"> =
   opt-&gt;key_ctx_bi.decrypt.plaintext_blocks +=3D (outlen + (blocksize - =
1))/blocksize;</code></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">So we increase this number before we have done all checks on the p=
acket. Doesn&#39;t that open us up to potential attacks that force renegoti=
ation by replaying packets?</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/ssl.c:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796/comment/dc6=
3e5a8_82d0b335">Patch Set #6, Line 144:</a> <code style=3D"font-family:mono=
space,monospace">    /* set limit to 7/8 of the limit so the renogiation ha=
s can succeeds before</code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">&quot;renegotiation can succeed&quot; ?</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_common.h:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/796/comment/728ac18b_aa309cd4">Patch Set #6, Line 336:<=
/a> <code style=3D"font-family:monospace,monospace">    /** This limit for =
AEAD cipher, this is the sum of packets + blocks</code></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">&quot;This&quot; -&gt; &quot;The=
&quot;? Or maybe just remove it?</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File tests/unit_tests/openvpn/test_crypto.c:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/796/comment/fd854db2_f454d881">Patch Set #6, Line 463:</a> <co=
de style=3D"font-family:monospace,monospace">    int64_t L =3D 101;</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Please mentio=
n or use AEAD_LIMIT_BLOCKSIZE</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">change 796</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/796?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I057f007577f10c6ac917ee4620e=
e3d2559187dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 796 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 28 Nov 2024 09:47:14=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--fjPrUXGko5I=--

