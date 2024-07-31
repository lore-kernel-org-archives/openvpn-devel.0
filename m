From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 31 Jul 2024 14:12:10 +0000
In-Reply-To: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7fa36718c520745470ce6c1d3f1498653aad19df-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BlSjsXKipgI="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BlSjsXKipgI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/507?usp=3Demail )

Change subject: Implement support for larger packet counter sizes
......................................................................


Patch Set 6: Code-Review+1

(6 comments)

Patchset:

PS6:
A few minor comments, otherwise LGTM


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/057e647e_235cce26 :
PS6, Line 364: openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
Is it so that for DATA_V1:

  ad_start points to packet_id

and for DATA_V2:

  ad_start points to opcode/peer-id

?


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/68137a62_4480a3d5 :
PS6, Line 2696:         /* Ensure that for proto v3 is enabled fully or not=
 at all */
Ensure that both aead_tag_end and long_pkt_id are enabled for DATA_V3 ?


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/758ca11c_70a5b728 :
PS6, Line 1528:         impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) -=
 packet_id_size(longiv);
why not move declaration of impl_iv_len here?


File src/openvpn/ssl_common.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/e1373829_32fe9ec0 :
PS6, Line 314:     bool disable_occ;
this looks like an unrelated change


http://gerrit.openvpn.net/c/openvpn/+/507/comment/b333e775_ad0af8c2 :
PS6, Line 493:     int limit_next;             /* used for traffic shaping =
on the control channel */
ditto



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
Gerrit-Change-Number: 507
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 31 Jul 2024 14:12:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--BlSjsXKipgI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/507?tab=3Dcomments">Patch Set #6:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">A few minor comments, otherwise LGTM</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/507/comment/057e647e_235cce26">Patch Set #6, Lin=
e 364:</a> <code style=3D"font-family:monospace,monospace">openvpn_decrypt_=
aead(struct buffer *buf, struct buffer work,</code></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Is it so that for DATA_V1:</p><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">  ad_star=
t points to packet_id<br>  <br>and for DATA_V2:</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">  ad_start points to opco=
de/peer-id<br>  <br>?</pre></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/init.c:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/68137a=
62_4480a3d5">Patch Set #6, Line 2696:</a> <code style=3D"font-family:monosp=
ace,monospace">        /* Ensure that for proto v3 is enabled fully or not =
at all */</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Ensure that both aead_tag_end and long_pkt_id are enabled for DATA_V3 ?=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/507/comment/758ca11c_70a5b728">Patch Set #=
6, Line 1528:</a> <code style=3D"font-family:monospace,monospace">        i=
mpl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher) - packet_id_size(longiv=
);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">why=
 not move declaration of impl_iv_len here?</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/ssl_common.h:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/507/comment/e1373829_32fe9ec0">Patch Set #6, Line 314:</a> <code sty=
le=3D"font-family:monospace,monospace">    bool disable_occ;</code></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">this looks like an u=
nrelated change</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/507/comment/b333e775_ad0af8c2">Patch Set #6, Line 493:</a> <code style=3D=
"font-family:monospace,monospace">    int limit_next;             /* used f=
or traffic shaping on the control channel */</code></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">ditto</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail=
">change 507</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b3=
5ddc2318569e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 507 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 31 Jul 2024 14:12:10=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--BlSjsXKipgI=--

