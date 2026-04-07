From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 7 Apr 2026 11:54:13 +0000
In-Reply-To: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
References: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
Reply-To: arne-openvpn@...1227..., selva.nair@...277...,
 luca.boccassi@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <8acdcd7315dadb2805fa98f03cc2cb91df3ca554-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LQ0KX4yjt7E="; charset=UTF-8
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

--LQ0KX4yjt7E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Bluca, selvanair.

plaisthos has posted comments on this change by Bluca. ( http://gerrit.open=
vpn.net/c/openvpn/+/1622?usp=3Demail )

Change subject: Add new helpers to handle key exchange (S_SENT_KEY/S_START)=
 with large passwords
......................................................................


Patch Set 1:

(2 comments)

Patchset:

PS1:
> Sorry, I don't really follow. [=E2=80=A6]
The TLS layer uses TLS records for framing and OpenVPN currently relies on =
TLS records for its own framing. Not many protocols do this and this also c=
auses problem, ie when you enable record splitting.

And your patch basically decides to break this assumption but only for the =
key2 related methods, which is in my opinion quite hacky.

And that why I am saying that we need a proper patch/negotiation to overcom=
e this limit instead.

But I get the feeling that you are not really interested in any solution th=
at would actually improve on the OpenVPN protocol to implement longer usern=
ame/password if it is not compatible with the approach that Microsoft has d=
ecided to take.


PS1:
> Sure, but that's 2 years old and included in LTS distros, eg. Ubuntu 24. =
[=E2=80=A6]
You might not care about compatibility, interoperability and behaviour of m=
odern clients with older servers and vice versa but we care and we have tak=
e that into account. And "that's 2 years old" is way shorter than we care a=
bout. We still maintain compatibility with OpenVPN 2.2 server and clients a=
nd people are still using a lot of OpenVPN 2.4/OpenVPN 2.5.

And that your patch allows triggering very erratic behaviour with these old=
er version is not a good thing.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f
Gerrit-Change-Number: 1622
Gerrit-PatchSet: 1
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: Bluca <luca.boccassi@...277...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Tue, 07 Apr 2026 11:54:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: Bluca <luca.boccassi@...277...>

--LQ0KX4yjt7E=
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
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Sor=
ry, I don&#39;t really follow. [=E2=80=A6]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The TLS layer u=
ses TLS records for framing and OpenVPN currently relies on TLS records for=
 its own framing. Not many protocols do this and this also causes problem, =
ie when you enable record splitting.</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">And your patch basically decides t=
o break this assumption but only for the key2 related methods, which is in =
my opinion quite hacky.</p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">And that why I am saying that we need a proper =
patch/negotiation to overcome this limit instead. </p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">But I get the feelin=
g that you are not really interested in any solution that would actually im=
prove on the OpenVPN protocol to implement longer username/password if it i=
s not compatible with the approach that Microsoft has decided to take.</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?tab=3Dcomment=
s&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Sure, but that&#39;s 2=
 years old and included in LTS distros, eg. Ubuntu 24. [=E2=80=A6]</blockqu=
ote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">You might not care about compatibility, interoperability and behav=
iour of modern clients with older servers and vice versa but we care and we=
 have take that into account. And &quot;that&#39;s 2 years old&quot; is way=
 shorter than we care about. We still maintain compatibility with OpenVPN 2=
.2 server and clients and people are still using a lot of OpenVPN 2.4/OpenV=
PN 2.5.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">And that your patch allows triggering very erratic behaviour wi=
th these older version is not a good thing.</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail=
">change 1622</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I055c64ca8b23066e70eea7d7ded=
dfb14f5354c5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1622 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 07 Apr 2026 11:54:13=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Bluca &lt;luca.boccassi@...220...=
..277...&gt; </div>

</body></html>=

--LQ0KX4yjt7E=--

