From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 8 Apr 2026 01:42:01 +0000
In-Reply-To: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
References: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
Reply-To: arne-openvpn@...1227..., selva.nair@...277...,
 luca.boccassi@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <06ea93871da9ac7d02c6800e67ecfca95fe7f4bc-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/hw0+qrzzCs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add new helpers to
 handle key exchange (S_SENT_KEY/S_START) with larg...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Bluca <luca.boccassi@...277...>
Cc: selvanair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/hw0+qrzzCs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Bluca, selvanair.

plaisthos has posted comments on this change by Bluca. ( http://gerrit.open=
vpn.net/c/openvpn/+/1622?usp=3Demail )

Change subject: Add new helpers to handle key exchange (S_SENT_KEY/S_START)=
 with large passwords
......................................................................


Patch Set 2:

(2 comments)

Patchset:

PS1:
> > But I get the feeling that you are not really interested in any solutio=
n that would actually impro [=E2=80=A6]
There are multiple way that I can see that are better suited to solve the p=
roblem of supporting longer username/passwords in OpenVPN. They would have =
many advantages over the approach that you are trying to force in here. The=
y would have only the one downside of not working with the Azure OpenVPN im=
plementation.

This is not the first patch/protocol change that has been rejected by the O=
penVPN maintainers that is in use for the protocol. See the xor patch for a=
nother example.

I understand that this is frustrating for you but maybe you should complain=
 to Microsoft instead.


PS1:
> With a pre-a7f80d402f server there was no helpful message with a patched =
client, so I've now added it.

And while you consider that behaviour completely acceptable and the problem=
 that your patch introduces, I really don't like adding another obscure way=
 an OpenVPN connection can fail. While it might be a not be a big deal for =
you, you also do not need to debug and support OpenVPN.

> The error reporting from a7f80d402f doesn't trigger in any combination.

To trigger the error reporting of a7f80d402f in earlier version you need a =
client compiled with --enable-pkcs11 against a server without --enable-pkcs=
1, ie only accepting passwords of 128 bytes or shorter. As these are not co=
mmon, as you noticed, it took quite a long time to actually this situation =
being properly recognised and fixed.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f
Gerrit-Change-Number: 1622
Gerrit-PatchSet: 2
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: Bluca <luca.boccassi@...277...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Wed, 08 Apr 2026 01:42:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: Bluca <luca.boccassi@...277...>

--/hw0+qrzzCs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Bluca, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1622?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&gt=
; But I get the feeling that you are not really interested in any solution =
that would actually impro [=E2=80=A6]</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">There are multiple w=
ay that I can see that are better suited to solve the problem of supporting=
 longer username/passwords in OpenVPN. They would have many advantages over=
 the approach that you are trying to force in here. They would have only th=
e one downside of not working with the Azure OpenVPN implementation.</p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Th=
is is not the first patch/protocol change that has been rejected by the Ope=
nVPN maintainers that is in use for the protocol. See the xor patch for ano=
ther example.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I understand that this is frustrating for you but maybe y=
ou should complain to Microsoft instead.</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1622?tab=3Dcomments&amp;usp=3Demail">Patch Set #=
1:</a> </p><blockquote class=3D"blocks" style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;"><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">With a pre-a7f80d402f server there wa=
s no helpful message with a patched client, so I&#39;ve now added it.</p></=
blockquote><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">And while you consider that behaviour completely acceptable and=
 the problem that your patch introduces, I really don&#39;t like adding ano=
ther obscure way an OpenVPN connection can fail. While it might be a not be=
 a big deal for you, you also do not need to debug and support OpenVPN.</p>=
<blockquote class=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;"><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">The error reporting from a7f80d402f doesn&#39;t =
trigger in any combination.</p></blockquote><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">To trigger the error reporting=
 of a7f80d402f in earlier version you need a client compiled with --enable-=
pkcs11 against a server without --enable-pkcs1, ie only accepting passwords=
 of 128 bytes or shorter. As these are not common, as you noticed, it took =
quite a long time to actually this situation being properly recognised and =
fixed.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1622?usp=3Demail">change 1622</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1622?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I055c64ca8b23066e70eea7d7ded=
dfb14f5354c5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1622 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Bluca &lt;luca.boccassi@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Bluca &lt;luca.boccassi@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 08 Apr 2026 01:42:01=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Bluca &lt;luca.boccassi@...220...=
..277...&gt; </div>

</body></html>=

--/hw0+qrzzCs=--

