From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Wed, 11 Sep 2024 16:53:26 +0000
In-Reply-To: <gerrit.1725890088000.I5adbe0a79f078221c4bb5f3d39391a81b4d8adce@...2715...>
References: <gerrit.1725890088000.I5adbe0a79f078221c4bb5f3d39391a81b4d8adce@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ff1624dc79fdd8b13f5edd8c00e84113231b01f0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="REVG/Vhxa1w="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix
 check_addr_clash argument order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--REVG/Vhxa1w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

ralf_lici has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/737?usp=3Demail )

Change subject: Fix check_addr_clash argument order
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
> Code change makes sense to me, but I haven' tested it. [=E2=80=A6]
If you simply want to evaluate if the order is coherent between the argumen=
ts you can enable the debugging code at the beginning of check_addr_clash().

To actually trigger the tun warning I created a tuntap interface (tun0) and=
 set the ip address to 10.10.20.1/24. Then I executed:
openvpn --ifconfig 10.10.20.10 255.255.255.0  --local 10.10.20.1 --dev tun0=
 --topology subnet ...

The tap warning can be triggered by executing:
openvpn --ifconfig 10.10.20.10 255.255.255.0 --local 10.10.20.1 --dev tap .=
..

Nevertheless I could not find a way to trigger the first warning in check_a=
ddr_clash() (line 564) because I think a previous check already ensures tha=
t --local or --remote addresses are not the same as the --ifconfig addresse=
s (but I'm not entirely sure if this is always the case).



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/737?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5adbe0a79f078221c4bb5f3d39391a81b4d8adce
Gerrit-Change-Number: 737
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Wed, 11 Sep 2024 16:53:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--REVG/Vhxa1w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/737?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
37?tab=3Dcomments">Patch Set #1:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Code change makes sens=
e to me, but I haven&#39; tested it. [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">If you simply want to ev=
aluate if the order is coherent between the arguments you can enable the de=
bugging code at the beginning of check_addr_clash().</p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">To actually trigger the tun warning=
 I created a tuntap interface (tun0) and set the ip address to 10.10.20.1/2=
4. Then I executed:<br>openvpn --ifconfig 10.10.20.10 255.255.255.0  --loca=
l 10.10.20.1 --dev tun0 --topology subnet ...</p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">The tap warning can be triggered by execut=
ing:<br>openvpn --ifconfig 10.10.20.10 255.255.255.0 --local 10.10.20.1 --d=
ev tap ...</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ne=
vertheless I could not find a way to trigger the first warning in check_add=
r_clash() (line 564) because I think a previous check already ensures that =
--local or --remote addresses are not the same as the --ifconfig addresses =
(but I&#39;m not entirely sure if this is always the case).</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
737?usp=3Demail">change 737</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/737?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5adbe0a79f078221c4bb5f3d393=
91a81b4d8adce </div>
<div style=3D"display:none"> Gerrit-Change-Number: 737 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Sep 2024 16:53:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--REVG/Vhxa1w=--

