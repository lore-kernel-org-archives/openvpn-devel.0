From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 10 Sep 2024 10:05:39 +0000
In-Reply-To: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <315b8f43f024a49698f8cc8543bf918566ee5974-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yWF0DIa7Kkc="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yWF0DIa7Kkc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, stipa.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/507?usp=3Demail )

Change subject: Implement support for larger packet counter sizes
......................................................................


Patch Set 10:

(3 comments)

File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/109f8bbf_34e87541 :
PS6, Line 2696:         /* Ensure that for proto v3 is enabled fully or not=
 at all */
> Ensure that both aead_tag_end and long_pkt_id are enabled for DATA_V3 ?
Done


http://gerrit.openvpn.net/c/openvpn/+/507/comment/d9907f20_32a208a8 :
PS6, Line 2702:             msg(D_PUSH_ERRORS, "OPTIONS ERROR: Aead tag at =
the end and 64 bit"
> missing space after "bit"
Done


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/8de88348_c0036eed :
PS6, Line 1528:         impl_iv_len =3D cipher_ctx_iv_length(ctx->cipher) -=
 packet_id_size(longiv);
> why not move declaration of impl_iv_len here?
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
Gerrit-Change-Number: 507
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Tue, 10 Sep 2024 10:05:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--yWF0DIa7Kkc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/507/comment/109f8bbf_34e87541">Patch Set #6, Line 2696:</a> =
<code style=3D"font-family:monospace,monospace">        /* Ensure that for =
proto v3 is enabled fully or not at all */</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Ensure t=
hat both aead_tag_end and long_pkt_id are enabled for DATA_V3 ?</blockquote=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/d9907f20=
_32a208a8">Patch Set #6, Line 2702:</a> <code style=3D"font-family:monospac=
e,monospace">            msg(D_PUSH_ERRORS, &quot;OPTIONS ERROR: Aead tag a=
t the end and 64 bit&quot;</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">missing space after &quot;=
bit&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/8de88348_c0036ee=
d">Patch Set #6, Line 1528:</a> <code style=3D"font-family:monospace,monosp=
ace">        impl_iv_len =3D cipher_ctx_iv_length(ctx-&gt;cipher) - packet_=
id_size(longiv);</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">why not move declaration of impl_iv_=
len here?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/507?usp=3Demail">change 507</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/507?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b3=
5ddc2318569e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 507 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Sep 2024 10:05:39=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--yWF0DIa7Kkc=--

