From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 10 Nov 2023 17:55:09 +0000
In-Reply-To: <gerrit.1699611717000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
References: <gerrit.1699611717000.I24f43ad319bd1ca530fe17442d02a97412eb75c7@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <86e21783ada6d3f1bedf09d65421b73b5f112a96-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j+Xehj9/+X4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: Make --dns
 options apply for tap-windows6 driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--j+Xehj9/+X4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/423?usp=3Demail )

Change subject: Make --dns options apply for tap-windows6 driver
......................................................................


Patch Set 2:

(1 comment)

File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/423/comment/36cbef03_760b5ca6 :
PS1, Line 8018:             options->tuntap_options.dhcp_options |=3D DHCP_=
OPTIONS_DHCP_REQUIRED;
> I would move this to tuntap_options_copy_dns() function. Also avoids the =
additional #ifdefs. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I24f43ad319bd1ca530fe17442d02a97412eb75c7
Gerrit-Change-Number: 423
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Fri, 10 Nov 2023 17:55:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--j+Xehj9/+X4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/423/comment/36cbef03_760b5ca6">Patch Set #1, Line 8018:</a=
> <code style=3D"font-family:monospace,monospace">            options-&gt;t=
untap_options.dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">I would move this to tuntap_options_copy_dns() function. Also avoids=
 the additional #ifdefs. [=E2=80=A6]</blockquote></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail">c=
hange 423</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/423?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24f43ad319bd1ca530fe17442d0=
2a97412eb75c7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 423 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 10 Nov 2023 17:55:09=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--j+Xehj9/+X4=--

