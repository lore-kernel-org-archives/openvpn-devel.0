From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 28 Nov 2023 13:39:57 +0000
In-Reply-To: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
References: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <8ec89e4f6dacadb48b3be39c6c63b5a8dce605f7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XNJCIwpqpSY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Check PRF
 availability on initialisation and add --force-tls-key-mate...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XNJCIwpqpSY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/460?usp=3Demail )

Change subject: Check PRF availability on initialisation and add --force-tl=
s-key-material-export
......................................................................


Patch Set 1:

(2 comments)

File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/460/comment/cbdb8303_d315f0e5 :
PS1, Line 1797:      * limits our compatibility to other 2.6.x+ OpernVPN pe=
ers. Do a simple
> "OpenVPN"
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/460/comment/ba9c2025_db846721 :
PS1, Line 2583:         if (options->force_key_material_export)
> This is in "if (options->mode =3D=3D MODE_SERVER)" which is wrong.
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04f8c7c413e7cb62c726262feee6ca89c7e86c70
Gerrit-Change-Number: 460
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 28 Nov 2023 13:39:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--XNJCIwpqpSY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/460/comment/cbdb8303_d315f0e5">Patch Set #1, Line 1797:</a=
> <code style=3D"font-family:monospace,monospace">     * limits our compati=
bility to other 2.6.x+ OpernVPN peers. Do a simple</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&q=
uot;OpenVPN&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/460/comment/ba9c=
2025_db846721">Patch Set #1, Line 2583:</a> <code style=3D"font-family:mono=
space,monospace">        if (options-&gt;force_key_material_export)</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">This is in &quot;if (options-&gt;mode =3D=3D MODE_SERVER)&qu=
ot; which is wrong.</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail">change 460</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/460?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04f8c7c413e7cb62c726262feee=
6ca89c7e86c70 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 460 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Nov 2023 13:39:57=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--XNJCIwpqpSY=--

