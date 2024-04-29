From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 29 Apr 2024 15:51:33 +0000
In-Reply-To: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
References: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., steffan@...1856...
Message-ID: <814ea5a5e944cf9b90bcb05f5e0052ea4303e3c0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hW23ADjGztI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement support
 for AEAD tag at the end
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: syzzer <steffan@...1856...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hW23ADjGztI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: syzzer.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/506?usp=3Demail )

Change subject: Implement support for AEAD tag at the end
......................................................................


Patch Set 4:

(1 comment)

Patchset:

PS4:
> I can change the signalling to only support combining both but I don't th=
ink this will change much i [=E2=80=A6]
I added a check that openvpn will not accept only of the options being enab=
led in protocol-flags



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00821d75342daf3f813b829812d648fe298bea81
Gerrit-Change-Number: 506
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: syzzer <steffan@...1856...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Comment-Date: Mon, 29 Apr 2024 15:51:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: syzzer <steffan@...1856...>
Gerrit-MessageType: comment

--hW23ADjGztI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: syzzer. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
06?tab=3Dcomments">Patch Set #4:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I can change the signa=
lling to only support combining both but I don&#39;t think this will change=
 much i [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">I added a check that openvpn will not accept only of th=
e options being enabled in protocol-flags</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">c=
hange 506</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00821d75342daf3f813b829812d=
648fe298bea81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@...1856...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 29 Apr 2024 15:51:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: syzzer &lt;steffan@...1852...=
6...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--hW23ADjGztI=--

