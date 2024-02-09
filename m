From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 9 Feb 2024 14:52:54 +0000
In-Reply-To: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <036b022b7cbc08713738d920aeda0cd947ee5c39-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PGMZjKpz5wE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement support
 for larger packet counter sizes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PGMZjKpz5wE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/507?usp=3Demail )

Change subject: Implement support for larger packet counter sizes
......................................................................


Patch Set 2:

(16 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/ad2cfd5e_b853527e :
PS2, Line 27: larger packet counters in any scenario since the other scenar=
ios
> Maybe nicer "in any other scenario since those are all legacy"
Done


http://gerrit.openvpn.net/c/openvpn/+/507/comment/d0565850_8921e027 :
PS2, Line 38: 2^32 packet ids) forward. But this is an obscure edge that we=
 can
> remove second "forward"
Done


http://gerrit.openvpn.net/c/openvpn/+/507/comment/f6f357ad_2afeb6e6 :
PS2, Line 41: Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
> Missing sign-off
Done


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/aee34092_a4a37691 :
PS2, Line 287:     /**< Bit-flag indicating that we should use a 64 bit (8 =
byte) packet
> This needs WAY more explanation. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/507/comment/7ba9075c_7f276f76 :
PS2, Line 288:      * counter instead of the 32 bit that we normally use.
> "normally use" -> "use by default". 32bit will remain the default, but ho=
pefully not the norm.
Done


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/7b8ef00b_afc620f9 :
PS2, Line 397:         const size_t packet_iv_len =3D iv_len - ctx->implici=
t_iv_len;
> So implicit_iv_len also depends on the longiv flag, but that relationship=
 is hidden in a completely  [=E2=80=A6]
Well we also only store the part of the IV that is needed for filling it to=
 the required 12 bytes. So with short IV we store 8 bytes here and with lon=
g IV 4 bytes.

I can look into refactoring this or at least writing a better comment.


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/2a9600b7_98e09add :
PS2, Line 3304:     /* Check if the DCO drivers support the new 64bit packe=
t counter and
> missing "TODO"? Currently we do not seem to check this but just assume th=
at DCO doesn't support it?
Yes. There is currently no DCO implementation that has this feature as this=
 PR just adds the feature. But I will will add a stub method that always re=
turns false instead.


File src/openvpn/packet_id.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/fb5fb5ef_e3ecee08 :
PS2, Line 250:  * Variant of packet_id_read that expect the timestamp first=
 and packet
> "expects"
Done


http://gerrit.openvpn.net/c/openvpn/+/507/comment/b56f9064_b92507d0 :
PS2, Line 273:  * will always use a variant of the packet id that can just =
be seens as
> "seen"
Done


http://gerrit.openvpn.net/c/openvpn/+/507/comment/6a732452_444cd0be :
PS2, Line 274:  * a flat 64 bit counter
> add full stop at the end
Done


http://gerrit.openvpn.net/c/openvpn/+/507/comment/e88332e1_f6640f30 :
PS2, Line 277:  * @param buf           Buffer to write the packet ID too
> "too" -> "to"
Done


http://gerrit.openvpn.net/c/openvpn/+/507/comment/70329f6b_bb92daa0 :
PS2, Line 279:  * @param prepend       If true, prepend to buffer, otherwis=
e append.
> Sorry, confusing two different things here. [=E2=80=A6]
Done


File src/openvpn/ssl_common.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/87fa0aeb_65109819 :
PS2, Line 363:     bool data_v3_features_supported; /**< dco supports new d=
ata channel features */
> Why DCO? Doesn't the non-DCO code also support the features?
Clarified the doxygen comment


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/0b74fcf6_d3632ce2 :
PS2, Line 433:     if (session->opt->data_v3_features_supported && (iv_prot=
o_peer & IV_PROTO_DATA_V3))
> since this is based on both the TAG_AT_THE_END and 64_BIT_PKT_ID, maybe w=
ould be better to move this [=E2=80=A6]
The thing here is that I didn't want to introduce two IV_PROTO flags and so=
 the 2nd patch for the two introduces the IV_PROTO_DATA_V3 flag and all the=
 logic for it.


File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/b11e4b53_74e1e29b :
PS2, Line 151:             co->flags |=3D CO_64_BIT_PKT_ID;
> why is this required? I don't see any indication that we overwrite co->fl=
ags?
yeah seems to be old leftover code. Thanks for pointing out.


http://gerrit.openvpn.net/c/openvpn/+/507/comment/82c35dbd_ccb22c51 :
PS2, Line 494:     buf_advance(&buf, 4);
> might be nicer to move the this block before the packetid test to avoid t=
he "+ 4"?
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
Gerrit-Change-Number: 507
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 09 Feb 2024 14:52:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--PGMZjKpz5wE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">View C=
hange</a></p><p>16 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/507/comment/ad2cfd5e_b853527e">Patch Set #2, Line 27:</a> <code styl=
e=3D"font-family:monospace,monospace">larger packet counters in any scenari=
o since the other scenarios</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">Maybe nicer &quot;in any =
other scenario since those are all legacy&quot;</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/507/comment/d0565850_8921e027">Patch=
 Set #2, Line 38:</a> <code style=3D"font-family:monospace,monospace">2^32 =
packet ids) forward. But this is an obscure edge that we can</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">remove second &quot;forward&quot;</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/507/comment/f6f357ad_2afeb6e6">Patch Set #=
2, Line 41:</a> <code style=3D"font-family:monospace,monospace">Change-Id: =
I01e258e97351b5aa4b9e561f5b35ddc2318569e2</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Missing sig=
n-off</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/crypto.h:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/aee34092_a4a37691=
">Patch Set #2, Line 287:</a> <code style=3D"font-family:monospace,monospac=
e">    /**&lt; Bit-flag indicating that we should use a 64 bit (8 byte) pac=
ket</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">This needs WAY more explanation. [=E2=80=A6]</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/7=
ba9075c_7f276f76">Patch Set #2, Line 288:</a> <code style=3D"font-family:mo=
nospace,monospace">     * counter instead of the 32 bit that we normally us=
e.</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">&quot;normally use&quot; -&gt; &quot;use by defaul=
t&quot;. 32bit will remain the default, but hopefully not the norm.</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/cr=
ypto.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/507/comment/7b8ef00b_afc620f9">Patch Set #=
2, Line 397:</a> <code style=3D"font-family:monospace,monospace">        co=
nst size_t packet_iv_len =3D iv_len - ctx-&gt;implicit_iv_len;</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">So implicit_iv_len also depends on the longiv flag, but that rela=
tionship is hidden in a completely  [=E2=80=A6]</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Well we also only store the=
 part of the IV that is needed for filling it to the required 12 bytes. So =
with short IV we store 8 bytes here and with long IV 4 bytes.</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I can look into refactor=
ing this or at least writing a better comment.</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/507/comment/2a9600b7_98e09add">Patch Set #2, Line 3304:</a> <code sty=
le=3D"font-family:monospace,monospace">    /* Check if the DCO drivers supp=
ort the new 64bit packet counter and</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">missing &quot;TO=
DO&quot;? Currently we do not seem to check this but just assume that DCO d=
oesn&#39;t support it?</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Yes. There is currently no DCO implementation that h=
as this feature as this PR just adds the feature. But I will will add a stu=
b method that always returns false instead.</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/packet_id.h:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/507/comment/fb5fb5ef_e3ecee08">Patch Set #2, Line 250:</a> <code sty=
le=3D"font-family:monospace,monospace"> * Variant of packet_id_read that ex=
pect the timestamp first and packet</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;expects&quo=
t;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/co=
mment/b56f9064_b92507d0">Patch Set #2, Line 273:</a> <code style=3D"font-fa=
mily:monospace,monospace"> * will always use a variant of the packet id tha=
t can just be seens as</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">&quot;seen&quot;</blockquote><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/6a732452_4=
44cd0be">Patch Set #2, Line 274:</a> <code style=3D"font-family:monospace,m=
onospace"> * a flat 64 bit counter</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">add full stop at t=
he end</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
07/comment/e88332e1_f6640f30">Patch Set #2, Line 277:</a> <code style=3D"fo=
nt-family:monospace,monospace"> * @param buf           Buffer to write the =
packet ID too</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">&quot;too&quot; -&gt; &quot;to&quot;</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment=
/70329f6b_bb92daa0">Patch Set #2, Line 279:</a> <code style=3D"font-family:=
monospace,monospace"> * @param prepend       If true, prepend to buffer, ot=
herwise append.</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">Sorry, confusing two different things=
 here. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/ssl_common.h:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/=
87fa0aeb_65109819">Patch Set #2, Line 363:</a> <code style=3D"font-family:m=
onospace,monospace">    bool data_v3_features_supported; /**&lt; dco suppor=
ts new data channel features */</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why DCO? Doesn&#39;t =
the non-DCO code also support the features?</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Clarified the doxygen comment</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/s=
sl_ncp.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/507/comment/0b74fcf6_d3632ce2">Patch Set=
 #2, Line 433:</a> <code style=3D"font-family:monospace,monospace">    if (=
session-&gt;opt-&gt;data_v3_features_supported &amp;&amp; (iv_proto_peer &a=
mp; IV_PROTO_DATA_V3))</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">since this is based on both th=
e TAG_AT_THE_END and 64_BIT_PKT_ID, maybe would be better to move this [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">The thing here is that I didn&#39;t want to introduce two IV_PROTO =
flags and so the 2nd patch for the two introduces the IV_PROTO_DATA_V3 flag=
 and all the logic for it.</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File tests/unit_tests/openvpn/test_ssl.c:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/507/comment/b11e4b53_74e1e29b">Patch Set #2, Line 151:</a> <code style=3D=
"font-family:monospace,monospace">            co-&gt;flags |=3D CO_64_BIT_P=
KT_ID;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">why is this required? I don&#39;t see any indi=
cation that we overwrite co-&gt;flags?</blockquote></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">yeah seems to be old leftover code. =
Thanks for pointing out.</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/507/comment/82c35dbd_ccb22c51">Patch Set #2, Line 494:</a> <code=
 style=3D"font-family:monospace,monospace">    buf_advance(&amp;buf, 4);</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">might be nicer to move the this block before the packet=
id test to avoid the &quot;+ 4&quot;?</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">=
change 507</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b3=
5ddc2318569e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 507 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 09 Feb 2024 14:52:54=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--PGMZjKpz5wE=--

