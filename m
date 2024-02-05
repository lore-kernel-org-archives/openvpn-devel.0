From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 5 Feb 2024 11:24:24 +0000
In-Reply-To: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8cdf8c81e5231b2f99d61634dae9cddcae74e945-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SSwHe4ID3Kw="; charset=UTF-8
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

--SSwHe4ID3Kw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/507?usp=3Demail )

Change subject: Implement support for larger packet counter sizes
......................................................................


Patch Set 2: Code-Review-1

(11 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/9474d66b_41a49dc1 :
PS2, Line 27: larger packet counters in any scenario since the other scenar=
ios
Maybe nicer "in any other scenario since those are all legacy"


http://gerrit.openvpn.net/c/openvpn/+/507/comment/c459f6e9_1c6a2ee5 :
PS2, Line 38: 2^32 packet ids) forward. But this is an obscure edge that we=
 can
remove second "forward"


http://gerrit.openvpn.net/c/openvpn/+/507/comment/e22305ad_aea02a52 :
PS2, Line 41: Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
Missing sign-off


Patchset:

PS2:
Didn't get through the whole change, yet, but since I accumulated already a=
 sizeable number of comments, here they are...


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/f5a0f5fa_c7d56d07 :
PS2, Line 287:     /**< Bit-flag indicating that we should use a 64 bit (8 =
byte) packet
This needs WAY more explanation. What is the difference between CO_PACKET_I=
D_LONG_FORM and this? CO_PACKET_ID_LONG_FORM is only for non-AEAD data pack=
ets and this is only for AEAD packets, right? I think this should be mentio=
ned here.


http://gerrit.openvpn.net/c/openvpn/+/507/comment/44aff7d2_675e1cf8 :
PS2, Line 288:      * counter instead of the 32 bit that we normally use.
"normally use" -> "use by default". 32bit will remain the default, but hope=
fully not the norm.


File src/openvpn/packet_id.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/586075bf_d6c272af :
PS2, Line 250:  * Variant of packet_id_read that expect the timestamp first=
 and packet
"expects"


http://gerrit.openvpn.net/c/openvpn/+/507/comment/01116f80_49cacdec :
PS2, Line 273:  * will always use a variant of the packet id that can just =
be seens as
"seen"


http://gerrit.openvpn.net/c/openvpn/+/507/comment/27267e93_2e924d4c :
PS2, Line 274:  * a flat 64 bit counter
add full stop at the end


http://gerrit.openvpn.net/c/openvpn/+/507/comment/a6ddc660_5b3f2b5e :
PS2, Line 277:  * @param buf           Buffer to write the packet ID too
"too" -> "to"


http://gerrit.openvpn.net/c/openvpn/+/507/comment/42ac15af_a6087522 :
PS2, Line 279:  * @param prepend       If true, prepend to buffer, otherwis=
e append.
prepend parameter does not exist in this variant. Why is that? Is CO_AEAD_T=
AG_AT_THE_END now always true?



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
Gerrit-Comment-Date: Mon, 05 Feb 2024 11:24:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--SSwHe4ID3Kw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">Vi=
ew Change</a></p><p>11 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/507/comment/9474d66b_41a49dc1">Patch Set #2, Line 27:</a> <cod=
e style=3D"font-family:monospace,monospace">larger packet counters in any s=
cenario since the other scenarios</code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Maybe nicer &quot;in any other scenario since t=
hose are all legacy&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/507/comment/c459f6e9_1c6a2ee5">Patch Set #2, Line 38:</a> <code=
 style=3D"font-family:monospace,monospace">2^32 packet ids) forward. But th=
is is an obscure edge that we can</code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">remove second &quot;forward&quot;</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/e22305ad_aea02a=
52">Patch Set #2, Line 41:</a> <code style=3D"font-family:monospace,monospa=
ce">Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Missing sign-off</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/507?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Didn&#39;t get through the whole cha=
nge, yet, but since I accumulated already a sizeable number of comments, he=
re they are...</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/crypto.h:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/f5a0f5fa_c7d5=
6d07">Patch Set #2, Line 287:</a> <code style=3D"font-family:monospace,mono=
space">    /**&lt; Bit-flag indicating that we should use a 64 bit (8 byte)=
 packet</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">This needs WAY more explanation. What is the difference between CO_PACKET=
_ID_LONG_FORM and this? CO_PACKET_ID_LONG_FORM is only for non-AEAD data pa=
ckets and this is only for AEAD packets, right? I think this should be ment=
ioned here.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
07/comment/44aff7d2_675e1cf8">Patch Set #2, Line 288:</a> <code style=3D"fo=
nt-family:monospace,monospace">     * counter instead of the 32 bit that we=
 normally use.</code></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">&quot;normally use&quot; -&gt; &quot;use by default&quot;. 32bit w=
ill remain the default, but hopefully not the norm.</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/packet_id.h:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/507/comment/586075bf_d6c272af">Patch Set #2, Line 250:</a> <=
code style=3D"font-family:monospace,monospace"> * Variant of packet_id_read=
 that expect the timestamp first and packet</code></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">&quot;expects&quot;</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/01116f80_49cacdec">=
Patch Set #2, Line 273:</a> <code style=3D"font-family:monospace,monospace"=
> * will always use a variant of the packet id that can just be seens as</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;se=
en&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/c=
omment/27267e93_2e924d4c">Patch Set #2, Line 274:</a> <code style=3D"font-f=
amily:monospace,monospace"> * a flat 64 bit counter</code></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">add full stop at the end</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/a6ddc6=
60_5b3f2b5e">Patch Set #2, Line 277:</a> <code style=3D"font-family:monospa=
ce,monospace"> * @param buf           Buffer to write the packet ID too</co=
de></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;too=
&quot; -&gt; &quot;to&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/507/comment/42ac15af_a6087522">Patch Set #2, Line 279:</a> <c=
ode style=3D"font-family:monospace,monospace"> * @param prepend       If tr=
ue, prepend to buffer, otherwise append.</code></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">prepend parameter does not exist in this=
 variant. Why is that? Is CO_AEAD_TAG_AT_THE_END now always true?</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/507?usp=3Demail">change 507</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 05 Feb 2024 11:24:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--SSwHe4ID3Kw=--

