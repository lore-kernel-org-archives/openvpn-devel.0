From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 31 Dec 2023 17:33:53 +0000
In-Reply-To: <gerrit.1700582804000.Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8@...2715...>
References: <gerrit.1700582804000.Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4e40ce30adb48a22d876b562f27b73960b904455-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B1+1dAIa30A="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix unaligned access
 in macOS, FreeBSD, Solaris hwaddr
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--B1+1dAIa30A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/454?usp=3Demail )

Change subject: Fix unaligned access in macOS, FreeBSD, Solaris hwaddr
......................................................................


Patch Set 3: Code-Review+2

(1 comment)

Patchset:

PS3:
I still find this all horribly ugly, but this is not your fault... this API=
 is bad enough (... on MacOS, it seems) but combined with C "undefined beha=
viour" rules there is no hope for sanity...

That said, I have tested this on FreeBSD (works), NetBSD (works), OpenBSD (=
no AF_LINK provided, so, didn't work before, doesn't break anything now), M=
acOS (works) and OpenSolaris (no AF_LINK provided, but it compiles and test=
s fine).



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/454?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8
Gerrit-Change-Number: 454
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sun, 31 Dec 2023 17:33:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--B1+1dAIa30A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/454?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/454?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">I still find this all horribly ugly, but this =
is not your fault... this API is bad enough (... on MacOS, it seems) but co=
mbined with C &quot;undefined behaviour&quot; rules there is no hope for sa=
nity...</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">That =
said, I have tested this on FreeBSD (works), NetBSD (works), OpenBSD (no AF=
_LINK provided, so, didn&#39;t work before, doesn&#39;t break anything now)=
, MacOS (works) and OpenSolaris (no AF_LINK provided, but it compiles and t=
ests fine).</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/454?usp=3Demail">change 454</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/454?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia797c8801fa9a9bc10b6674efde=
5fdbd7132e4a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 454 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 31 Dec 2023 17:33:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--B1+1dAIa30A=--

