From: "MaxF (Code Review)" <gerrit@...515...>
Date: Sun, 29 Dec 2024 00:42:46 +0000
In-Reply-To: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
References: <gerrit.1731290343000.Id7d6a576ca8c9560cb2dfae82fc62175820e9b80@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e2a6b299528a6253460120651a7a04bd0fb07228-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i/VnNFVecsY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement methods to
 generate and manage OpenVPN Epoch keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--i/VnNFVecsY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/804?usp=3Demail )

Change subject: Implement methods to generate and manage OpenVPN Epoch keys
......................................................................


Patch Set 9: Code-Review-1

(13 comments)

Patchset:

PS9:
Needs uncrustification.

Code looks good to me, I just have some comments about comments and naming.


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/71ce8066_a53680c4 :
PS9, Line 307: This limit for AEAD cipher
The limit for AEAD ciphers?


File src/openvpn/crypto_epoch.c:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/4fc082c6_eb80eb11 :
PS9, Line 136: 11
We could use strlen() here.


http://gerrit.openvpn.net/c/openvpn/+/804/comment/8fdb0547_fcd70ff2 :
PS9, Line 157: 8
strlen?


http://gerrit.openvpn.net/c/openvpn/+/804/comment/403bd9f7_0bc3e36d :
PS9, Line 163: 7
strlen?


http://gerrit.openvpn.net/c/openvpn/+/804/comment/769c056a_676d4fc5 :
PS9, Line 210: uint16_t current_epoch_recv =3D co->key_ctx_bi.decrypt.epoch;
The variable name makes this look like it should be co->epoch_key_recv.epoc=
h.

After reading the function, I think the code is correct, but together with =
the ASSERT below, this caused me a lot of confusion. I thought that the ass=
ert was saying that you can only generate new future keys if you used them =
all up.


http://gerrit.openvpn.net/c/openvpn/+/804/comment/dcaea617_c7f7124b :
PS9, Line 423: is
in?


File src/openvpn/packet_id.h:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/7be792f3_fe78b9b2 :
PS9, Line 214:  */
Incomplete


File src/openvpn/packet_id.c:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/bf06e613_bc17423a :
PS9, Line 81: packet_id_init_recv(struct packet_id_rec *rec, int seq_backtr=
ack, int time_backtrack, const char *name, int unit)
You could make this a static function.


File tests/unit_tests/openvpn/test_crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/804/comment/7799a129_e434234f :
PS9, Line 728: is uses
uses


http://gerrit.openvpn.net/c/openvpn/+/804/comment/e365ffa5_5d07eb01 :
PS9, Line 830: 1-5
2-6


http://gerrit.openvpn.net/c/openvpn/+/804/comment/c9e49297_c1a18bdd :
PS9, Line 835:     assert_int_equal(epoch_lookup_decrypt_key(co, 1)->epoch,=
 1);
Could we make sure that it really is the retiring key by comparing it with =
&co->epoch_retiring_data_receive_key?

Similar for epoch 7 and &co->key_ctx_bi.decrypt


http://gerrit.openvpn.net/c/openvpn/+/804/comment/a1b07fcd_530357a4 :
PS9, Line 899:     assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX - 32=
));
This hard-codes the assumption that this function is called with a state th=
at has num_future_keys =3D=3D 32. Can't we get that number from co instead?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id7d6a576ca8c9560cb2dfae82fc62175820e9b80
Gerrit-Change-Number: 804
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sun, 29 Dec 2024 00:42:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--i/VnNFVecsY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 9:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804?usp=3Demail">Vi=
ew Change</a></p><p>13 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/804?tab=3Dcomments">Patch Set #9:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Needs uncrustification.</p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Code looks good to me, I just hav=
e some comments about comments and naming.</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/crypto.h:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/804/comment/71ce8066_a53680c4">Patch Set #9, Line 307:</a> <code style=
=3D"font-family:monospace,monospace">This limit for AEAD cipher</code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">The limit for AEA=
D ciphers?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/crypto_epoch.c:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/4fc082c6_eb=
80eb11">Patch Set #9, Line 136:</a> <code style=3D"font-family:monospace,mo=
nospace">11</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">We could use strlen() here.</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/804/comment/8fdb0547_fcd70ff2">Patch Set #9, Line 157:<=
/a> <code style=3D"font-family:monospace,monospace">8</code></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">strlen?</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/403bd9f7_0bc3e36d">=
Patch Set #9, Line 163:</a> <code style=3D"font-family:monospace,monospace"=
>7</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">str=
len?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comme=
nt/769c056a_676d4fc5">Patch Set #9, Line 210:</a> <code style=3D"font-famil=
y:monospace,monospace">uint16_t current_epoch_recv =3D co-&gt;key_ctx_bi.de=
crypt.epoch;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">The variable name makes this look like it should be co-&gt;epoch_key=
_recv.epoch.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
After reading the function, I think the code is correct, but together with =
the ASSERT below, this caused me a lot of confusion. I thought that the ass=
ert was saying that you can only generate new future keys if you used them =
all up.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/co=
mment/dcaea617_c7f7124b">Patch Set #9, Line 423:</a> <code style=3D"font-fa=
mily:monospace,monospace">is</code></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">in?</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/packet_id.h:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/commen=
t/7be792f3_fe78b9b2">Patch Set #9, Line 214:</a> <code style=3D"font-family=
:monospace,monospace"> */</code></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Incomplete</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/packet_id.c:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/co=
mment/bf06e613_bc17423a">Patch Set #9, Line 81:</a> <code style=3D"font-fam=
ily:monospace,monospace">packet_id_init_recv(struct packet_id_rec *rec, int=
 seq_backtrack, int time_backtrack, const char *name, int unit)</code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">You could make th=
is a static function.</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File tests/unit_tests/openvpn/test_crypto.c:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
804/comment/7799a129_e434234f">Patch Set #9, Line 728:</a> <code style=3D"f=
ont-family:monospace,monospace">is uses</code></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">uses</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/804/comment/e365ffa5_5d07eb01">Patch Set #9, Line =
830:</a> <code style=3D"font-family:monospace,monospace">1-5</code></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">2-6</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/c9e49297_c1a18bdd"=
>Patch Set #9, Line 835:</a> <code style=3D"font-family:monospace,monospace=
">    assert_int_equal(epoch_lookup_decrypt_key(co, 1)-&gt;epoch, 1);</code=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Could we ma=
ke sure that it really is the retiring key by comparing it with &amp;co-&gt=
;epoch_retiring_data_receive_key?</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Similar for epoch 7 and &amp;co-&gt;key_ctx_bi.decrypt=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/804/comment/a=
1b07fcd_530357a4">Patch Set #9, Line 899:</a> <code style=3D"font-family:mo=
nospace,monospace">    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX =
- 32));</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">This hard-codes the assumption that this function is called with a state =
that has num_future_keys =3D=3D 32. Can&#39;t we get that number from co in=
stead?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/804?usp=3Demail">change 804</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/804?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id7d6a576ca8c9560cb2dfae82fc=
62175820e9b80 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 804 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 29 Dec 2024 00:42:46=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--i/VnNFVecsY=--

