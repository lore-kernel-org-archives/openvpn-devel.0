From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 5 Feb 2024 12:24:14 +0000
In-Reply-To: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9ab88ff8ef05e79a2c33c3c870695e47a4478747-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pJapMCVF8+Q="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pJapMCVF8+Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/507?usp=3Demail )

Change subject: Implement support for larger packet counter sizes
......................................................................


Patch Set 2:

(8 comments)

Patchset:

PS2:
Some more comments now that I understand the code a bit better


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/373e1697_ed598058 :
PS2, Line 397:         const size_t packet_iv_len =3D iv_len - ctx->implici=
t_iv_len;
So implicit_iv_len also depends on the longiv flag, but that relationship i=
s hidden in a completely separate part of the code? IMHO that is very confu=
sing. Wouldn't it be easier if we just fill the implicit_iv fully always an=
d check how much of it to use here? It think that would make the code simpl=
er and easier to understand.


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/db73a5bd_f5a88cfb :
PS2, Line 3304:     /* Check if the DCO drivers support the new 64bit packe=
t counter and
missing "TODO"? Currently we do not seem to check this but just assume that=
 DCO doesn't support it?


File src/openvpn/packet_id.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/9644908d_23b0dda7 :
PS2, Line 279:  * @param prepend       If true, prepend to buffer, otherwis=
e append.
> prepend parameter does not exist in this variant. [=E2=80=A6]
Sorry, confusing two different things here. It does not exist because it wo=
uld be always false anyway in the places where this is used. Still needs to=
 be removed from documentation, though.


File src/openvpn/ssl_common.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/612bae7e_d66dfc56 :
PS2, Line 363:     bool data_v3_features_supported; /**< dco supports new d=
ata channel features */
Why DCO? Doesn't the non-DCO code also support the features?


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/88a16718_ea9da9d3 :
PS2, Line 433:     if (session->opt->data_v3_features_supported && (iv_prot=
o_peer & IV_PROTO_DATA_V3))
since this is based on both the TAG_AT_THE_END and 64_BIT_PKT_ID, maybe wou=
ld be better to move this to its own patch instead of mixing it into the ex=
isting two?


File tests/unit_tests/openvpn/test_ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/c0271a29_2d76ebf0 :
PS2, Line 151:             co->flags |=3D CO_64_BIT_PKT_ID;
why is this required? I don't see any indication that we overwrite co->flag=
s?


http://gerrit.openvpn.net/c/openvpn/+/507/comment/581f83d7_d1986ad4 :
PS2, Line 494:     buf_advance(&buf, 4);
might be nicer to move the this block before the packetid test to avoid the=
 "+ 4"?



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 05 Feb 2024 12:24:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--pJapMCVF8+Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">View C=
hange</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
507?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Some more comments now that I understand the code=
 a bit better</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e src/openvpn/crypto.c:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/373e1697_ed598=
058">Patch Set #2, Line 397:</a> <code style=3D"font-family:monospace,monos=
pace">        const size_t packet_iv_len =3D iv_len - ctx-&gt;implicit_iv_l=
en;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">So=
 implicit_iv_len also depends on the longiv flag, but that relationship is =
hidden in a completely separate part of the code? IMHO that is very confusi=
ng. Wouldn&#39;t it be easier if we just fill the implicit_iv fully always =
and check how much of it to use here? It think that would make the code sim=
pler and easier to understand.</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/init.c:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment=
/db73a5bd_f5a88cfb">Patch Set #2, Line 3304:</a> <code style=3D"font-family=
:monospace,monospace">    /* Check if the DCO drivers support the new 64bit=
 packet counter and</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">missing &quot;TODO&quot;? Currently we do not seem to check t=
his but just assume that DCO doesn&#39;t support it?</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/packet_id.h:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/507/comment/9644908d_23b0dda7">Patch Set #2, Line 279:</a> =
<code style=3D"font-family:monospace,monospace"> * @param prepend       If =
true, prepend to buffer, otherwise append.</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">prepend =
parameter does not exist in this variant. [=E2=80=A6]</blockquote></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Sorry, confusing two =
different things here. It does not exist because it would be always false a=
nyway in the places where this is used. Still needs to be removed from docu=
mentation, though.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/ssl_common.h:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/612ba=
e7e_d66dfc56">Patch Set #2, Line 363:</a> <code style=3D"font-family:monosp=
ace,monospace">    bool data_v3_features_supported; /**&lt; dco supports ne=
w data channel features */</code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Why DCO? Doesn&#39;t the non-DCO code also support the=
 features?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/ssl_ncp.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/88a16718_ea9da9d=
3">Patch Set #2, Line 433:</a> <code style=3D"font-family:monospace,monospa=
ce">    if (session-&gt;opt-&gt;data_v3_features_supported &amp;&amp; (iv_p=
roto_peer &amp; IV_PROTO_DATA_V3))</code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">since this is based on both the TAG_AT_THE_END=
 and 64_BIT_PKT_ID, maybe would be better to move this to its own patch ins=
tead of mixing it into the existing two?</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_ssl.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/507/comment/c0271a29_2d76ebf0">Patch Set #2, Line 151:</a> =
<code style=3D"font-family:monospace,monospace">            co-&gt;flags |=
=3D CO_64_BIT_PKT_ID;</code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">why is this required? I don&#39;t see any indication that w=
e overwrite co-&gt;flags?</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/507/comment/581f83d7_d1986ad4">Patch Set #2, Line 494:</a> <cod=
e style=3D"font-family:monospace,monospace">    buf_advance(&amp;buf, 4);</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">might b=
e nicer to move the this block before the packetid test to avoid the &quot;=
+ 4&quot;?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/507?usp=3Demail">change 507</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/507?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 05 Feb 2024 12:24:14=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--pJapMCVF8+Q=--

