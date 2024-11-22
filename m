From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 22 Nov 2024 15:35:43 +0000
In-Reply-To: <gerrit.1732212459000.I145573555aaace5e94774b5f977d032d3747ed72@...2715...>
References: <gerrit.1732212459000.I145573555aaace5e94774b5f977d032d3747ed72@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <50defc64372d918cb5f03a5aa86138d080c0d453-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mGrPrJBurko="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mudp.c: keep offset
 value when reset buffer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mGrPrJBurko=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/814?usp=3Demail )

Change subject: mudp.c: keep offset value when reset buffer
......................................................................


Patch Set 1:

(3 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/814/comment/535895da_8fa8d201 :
PS1, Line 7: mudp.c: keep offset value when reset buffer
> "resetting"
Acknowledged


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/814/comment/c06e65ab_3f487764 :
PS1, Line 57:     /* dco-win server requres prepend with sockaddr, so prese=
rve offset */
> "requires"
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/814/comment/7b8a5279_1096f128 :
PS1, Line 58:     buf_init(&c->c2.buffers->aux_buf, buf.offset);
> buf_init can fail (buf_reset_len cannot). [=E2=80=A6]
Will wrap it into ASSERT.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/814?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I145573555aaace5e94774b5f977d032d3747ed72
Gerrit-Change-Number: 814
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 22 Nov 2024 15:35:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--mGrPrJBurko=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/814?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/814/comment/535895da_8fa8d201">Patch Set #1, Line 7:</a> <code style=
=3D"font-family:monospace,monospace">mudp.c: keep offset value when reset b=
uffer</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">&quot;resetting&quot;</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/814/comment/c06e65ab_3f487764">Patch Set #1, Line 57:=
</a> <code style=3D"font-family:monospace,monospace">    /* dco-win server =
requres prepend with sockaddr, so preserve offset */</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
&quot;requires&quot;</blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/814/comment/7b8a5279_1096f128">Patch Set #1, Line 58:</=
a> <code style=3D"font-family:monospace,monospace">    buf_init(&amp;c-&gt;=
c2.buffers-&gt;aux_buf, buf.offset);</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">buf_init can fai=
l (buf_reset_len cannot). [=E2=80=A6]</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Will wrap it into ASSERT.</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/814?usp=3Demail">change 814</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/814?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I145573555aaace5e94774b5f977=
d032d3747ed72 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 814 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 22 Nov 2024 15:35:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--mGrPrJBurko=--

