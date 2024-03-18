From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 18 Mar 2024 15:54:38 +0000
In-Reply-To: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2c029016a94bf3343252beb6176492f9476884e2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KIn1vLNJpP8="; charset=UTF-8
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

--KIn1vLNJpP8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/507?usp=3Demail )

Change subject: Implement support for larger packet counter sizes
......................................................................


Patch Set 3: Code-Review-2

(7 comments)

Patchset:

PS3:
DCO check is broken. Otherwise mostly documentation/comment nitpicks.


File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/425de6c1_e1212b4d :
PS3, Line 292:      * big ending number in the wire format.
"endian"?


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/aaac8918_9f1ed366 :
PS3, Line 393:     /* Combine IV from explicit part from packet and implici=
t part from context,
End on ".", not ","


http://gerrit.openvpn.net/c/openvpn/+/507/comment/fa740d6c_61efdac1 :
PS3, Line 394:      * the length of the implicit length is initialised when=
 the implicit is
That sentence is very unwieldy. Maybe: "implicit_iv and implicit_iv_len are=
 initialised in init_key_contexts together with the keys".


File src/openvpn/dco.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/fe17f58d_4c954e37 :
PS3, Line 253:  * Return if the dco implementation supports the new protoco=
l features of
"if" -> "whether"


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/60255894_aea373fc :
PS3, Line 3308:         to.data_v3_features_supported =3D false;
I think you mean "to.data_v3_features_supported =3D dco_supports_data_v3(c)=
" ?


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/0600a4d8_bb1a41ed :
PS2, Line 433:     if (session->opt->data_v3_features_supported && (iv_prot=
o_peer & IV_PROTO_DATA_V3))
> The thing here is that I didn't want to introduce two IV_PROTO flags and =
so the 2nd patch for the tw [=E2=80=A6]
Acknowledged



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
Gerrit-Change-Number: 507
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 18 Mar 2024 15:54:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--KIn1vLNJpP8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">Vi=
ew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/507?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">DCO check is broken. Otherwise mostly documen=
tation/comment nitpicks.</p></li></ul></li><li style=3D"margin: 0; padding:=
 0;"><p>File src/openvpn/crypto.h:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507/comment/425=
de6c1_e1212b4d">Patch Set #3, Line 292:</a> <code style=3D"font-family:mono=
space,monospace">     * big ending number in the wire format.</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;endian&quot;?=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/crypto.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/507/comment/aaac8918_9f1ed366">Patch Se=
t #3, Line 393:</a> <code style=3D"font-family:monospace,monospace">    /* =
Combine IV from explicit part from packet and implicit part from context,</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">End on =
&quot;.&quot;, not &quot;,&quot;</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/507/comment/fa740d6c_61efdac1">Patch Set #3, Line 394:</=
a> <code style=3D"font-family:monospace,monospace">     * the length of the=
 implicit length is initialised when the implicit is</code></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">That sentence is very unwiel=
dy. Maybe: &quot;implicit_iv and implicit_iv_len are initialised in init_ke=
y_contexts together with the keys&quot;.</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/dco.h:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
07/comment/fe17f58d_4c954e37">Patch Set #3, Line 253:</a> <code style=3D"fo=
nt-family:monospace,monospace"> * Return if the dco implementation supports=
 the new protocol features of</code></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">&quot;if&quot; -&gt; &quot;whether&quot;</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/507/comment/60255894_aea373fc">Patch Set #3, Line 33=
08:</a> <code style=3D"font-family:monospace,monospace">        to.data_v3_=
features_supported =3D false;</code></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">I think you mean &quot;to.data_v3_features_supporte=
d =3D dco_supports_data_v3(c)&quot; ?</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/ssl_ncp.c:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
07/comment/0600a4d8_bb1a41ed">Patch Set #2, Line 433:</a> <code style=3D"fo=
nt-family:monospace,monospace">    if (session-&gt;opt-&gt;data_v3_features=
_supported &amp;&amp; (iv_proto_peer &amp; IV_PROTO_DATA_V3))</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">The thing here is that I didn&#39;t want to introduce two IV_PROTO=
 flags and so the 2nd patch for the tw [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/507?usp=3Demail">change 507</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b3=
5ddc2318569e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 507 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 18 Mar 2024 15:54:38=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--KIn1vLNJpP8=--

