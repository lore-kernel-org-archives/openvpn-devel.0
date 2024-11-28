From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 10:03:54 +0000
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <0a652af407cf7d74dc11e4a8509557937939a359-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Gi4Ipl8juW0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Gi4Ipl8juW0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/796?usp=3Demail )

Change subject: Trigger renegotiation of data key if getting close to the A=
EAD usage limit
......................................................................


Patch Set 6: Code-Review-2

(6 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/6f5c1440_6ba1cc3d :
PS6, Line 17: For a VPN OpenVPN, the same calculation would either require =
using a
"VPN like OpenVPN"? Or just "For OpenVPN"?


http://gerrit.openvpn.net/c/openvpn/+/796/comment/e9855faf_bebc8208 :
PS6, Line 24: To avoid this dynamic calculation and also avoiding needing t=
o know the
"avoid"


http://gerrit.openvpn.net/c/openvpn/+/796/comment/56e7feb1_cedb0de9 :
PS6, Line 29: This also has the side effects that connection with a lot of =
small packets
"connections"


http://gerrit.openvpn.net/c/openvpn/+/796/comment/374d394d_c29d4c00 :
PS6, Line 30: (like TCP ACKs) mixed with large packets will be able to keep=
 using the same
"same key"?


http://gerrit.openvpn.net/c/openvpn/+/796/comment/4815cde9_b38338fa :
PS6, Line 34: of the
"of the actual limit"?


http://gerrit.openvpn.net/c/openvpn/+/796/comment/efd85c78_167db128 :
PS6, Line 50: Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Why does this have three Change-Ids?



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Thu, 28 Nov 2024 10:03:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Gi4Ipl8juW0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>Patch set 6:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/796/comment/6f5c1440_6ba1cc3d">Patch Set #6, Line 17:</a> <code s=
tyle=3D"font-family:monospace,monospace">For a VPN OpenVPN, the same calcul=
ation would either require using a</code></p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">&quot;VPN like OpenVPN&quot;? Or just &quot;Fo=
r OpenVPN&quot;?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/796/comment/e9855faf_bebc8208">Patch Set #6, Line 24:</a> <code style=3D=
"font-family:monospace,monospace">To avoid this dynamic calculation and als=
o avoiding needing to know the</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">&quot;avoid&quot;</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/796/comment/56e7feb1_cedb0de9">Patch Set #6, L=
ine 29:</a> <code style=3D"font-family:monospace,monospace">This also has t=
he side effects that connection with a lot of small packets</code></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;connections&quo=
t;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796/comment=
/374d394d_c29d4c00">Patch Set #6, Line 30:</a> <code style=3D"font-family:m=
onospace,monospace">(like TCP ACKs) mixed with large packets will be able t=
o keep using the same</code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">&quot;same key&quot;?</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/796/comment/4815cde9_b38338fa">Patch Set #6, Line 3=
4:</a> <code style=3D"font-family:monospace,monospace">of the</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;of the actual=
 limit&quot;?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
796/comment/efd85c78_167db128">Patch Set #6, Line 50:</a> <code style=3D"fo=
nt-family:monospace,monospace">Change-Id: I057f007577f10c6ac917ee4620ee3d25=
59187dc7</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Why does this have three Change-Ids?</p></li></ul></li></ul><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">cha=
nge 796</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 28 Nov 2024 10:03:54=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Gi4Ipl8juW0=--

