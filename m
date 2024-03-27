From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 27 Mar 2024 10:40:22 +0000
In-Reply-To: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
References: <gerrit.1706186293000.I01e258e97351b5aa4b9e561f5b35ddc2318569e2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f427ec580313da27acf6e5ce6710f6beba3c906f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="okwQJi38uXI="; charset=UTF-8
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

--okwQJi38uXI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/507?usp=3Demail )

Change subject: Implement support for larger packet counter sizes
......................................................................


Patch Set 4:

(5 comments)

File src/openvpn/crypto.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/f254a2ce_f57578ee :
PS3, Line 292:      * big ending number in the wire format.
> "endian"?
Acknowledged


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/5002c984_e4c79e7d :
PS3, Line 393:     /* Combine IV from explicit part from packet and implici=
t part from context,
> End on ". [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/507/comment/7c48e081_1bd56f08 :
PS3, Line 394:      * the length of the implicit length is initialised when=
 the implicit is
> That sentence is very unwieldy. [=E2=80=A6]
Done


File src/openvpn/dco.h:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/2852f4e6_e5ca91be :
PS3, Line 253:  * Return if the dco implementation supports the new protoco=
l features of
> "if" -> "whether"
Done


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/507/comment/7d199642_142d7abf :
PS3, Line 3308:         to.data_v3_features_supported =3D false;
> I think you mean "to. [=E2=80=A6]
Acknowledged



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b35ddc2318569e2
Gerrit-Change-Number: 507
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 27 Mar 2024 10:40:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--okwQJi38uXI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/507?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.h:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/507/comment/f254a2ce_f57578ee">Patch Set #3, Line 292:</a>=
 <code style=3D"font-family:monospace,monospace">     * big ending number i=
n the wire format.</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">&quot;endian&quot;?</blockquote></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/c=
rypto.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/507/comment/5002c984_e4c79e7d">Patch Set =
#3, Line 393:</a> <code style=3D"font-family:monospace,monospace">    /* Co=
mbine IV from explicit part from packet and implicit part from context,</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">End on &quot;. [=E2=80=A6]</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/507/comment/7c48e081_1bd56f08">Patch S=
et #3, Line 394:</a> <code style=3D"font-family:monospace,monospace">     *=
 the length of the implicit length is initialised when the implicit is</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">That sentence is very unwieldy. [=E2=80=A6]</blockquote><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco.h:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/507/comment/2852f4e6_e5ca91be">Patch Set #3, Line 2=
53:</a> <code style=3D"font-family:monospace,monospace"> * Return if the dc=
o implementation supports the new protocol features of</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">&quot;if&quot; -&gt; &quot;whether&quot;</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/507/comment/7d199642_142d7abf">Patch Set #3, Line 3308:</a> <code sty=
le=3D"font-family:monospace,monospace">        to.data_v3_features_supporte=
d =3D false;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">I think you mean &quot;to. [=E2=80=A6]</=
blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">A=
cknowledged</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/507?usp=3Demail">change 507</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/507?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I01e258e97351b5aa4b9e561f5b3=
5ddc2318569e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 507 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 27 Mar 2024 10:40:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--okwQJi38uXI=--

