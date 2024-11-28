From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 18:40:35 +0000
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <17908acca7979992dd9601c928335dea43e192ba-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eZiri8mfx7k="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Trigger
 renegotiation of data key if getting close to the AEAD usage ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eZiri8mfx7k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/796?usp=3Demail )

Change subject: Trigger renegotiation of data key if getting close to the A=
EAD usage limit
......................................................................


Patch Set 6:

(6 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/933872f5_aebd1b85 :
PS6, Line 17: For a VPN OpenVPN, the same calculation would either require =
using a
> "VPN like OpenVPN"? Or just "For OpenVPN"?
Done


http://gerrit.openvpn.net/c/openvpn/+/796/comment/ca599a2c_8f021338 :
PS6, Line 24: To avoid this dynamic calculation and also avoiding needing t=
o know the
> "avoid"
Done


http://gerrit.openvpn.net/c/openvpn/+/796/comment/dbf4f6ff_4d8eca15 :
PS6, Line 29: This also has the side effects that connection with a lot of =
small packets
> "connections"
Done


http://gerrit.openvpn.net/c/openvpn/+/796/comment/2fede922_5b7df247 :
PS6, Line 30: (like TCP ACKs) mixed with large packets will be able to keep=
 using the same
> "same key"?
Done


http://gerrit.openvpn.net/c/openvpn/+/796/comment/578c0f8b_24b20229 :
PS6, Line 34: of the
> "of the actual limit"?
Done


http://gerrit.openvpn.net/c/openvpn/+/796/comment/75c4d609_2a233adb :
PS6, Line 50: Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
> Why does this have three Change-Ids?
That is a good question, some that post commit script did some nonsense, I =
will try to figure out which is the right one and remove the other two.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Gerrit-Change-Number: 796
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 28 Nov 2024 18:40:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--eZiri8mfx7k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">View C=
hange</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/796/comment/933872f5_aebd1b85">Patch Set #6, Line 17:</a> <code style=
=3D"font-family:monospace,monospace">For a VPN OpenVPN, the same calculatio=
n would either require using a</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;VPN like OpenVPN=
&quot;? Or just &quot;For OpenVPN&quot;?</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/796/comment/ca599a2c_8f021338">Patch Set #6=
, Line 24:</a> <code style=3D"font-family:monospace,monospace">To avoid thi=
s dynamic calculation and also avoiding needing to know the</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">&quot;avoid&quot;</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/796/comment/dbf4f6ff_4d8eca15">Patch Set #6, Line 29:</a> <=
code style=3D"font-family:monospace,monospace">This also has the side effec=
ts that connection with a lot of small packets</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;=
connections&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/796/comment/2fede922_5b7df247">Patch Set #6, Line 30:</a> <code st=
yle=3D"font-family:monospace,monospace">(like TCP ACKs) mixed with large pa=
ckets will be able to keep using the same</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;same =
key&quot;?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/796/comment/578c0f8b_24b20229">Patch Set #6, Line 34:</a> <code style=3D"=
font-family:monospace,monospace">of the</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;of the =
actual limit&quot;?</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/796/comment/75c4d609_2a233adb">Patch Set #6, Line 50:</a> <code =
style=3D"font-family:monospace,monospace">Change-Id: I057f007577f10c6ac917e=
e4620ee3d2559187dc7</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">Why does this have three Change-I=
ds?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">That is a good question, some that post commit script did some nonsense=
, I will try to figure out which is the right one and remove the other two.=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/796?usp=3Demail">change 796</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
96?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I057f007577f10c6ac917ee4620e=
e3d2559187dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 796 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 28 Nov 2024 18:40:35=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--eZiri8mfx7k=--

