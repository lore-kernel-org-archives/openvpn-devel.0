From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 14 Sep 2025 19:54:50 +0000
In-Reply-To: <gerrit.1757684109000.Iff2f4ea677fe2d88659d7814dab0f792f5004fb3@...2715...>
References: <gerrit.1757684109000.Iff2f4ea677fe2d88659d7814dab0f792f5004fb3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <523c35953ddf97b7e1db2f10f58c404a7ce42cd6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p9pUo+EWgQ0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: win: replace
 wmic invocation with powershell
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--p9pUo+EWgQ0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1183?usp=3Demail )

Change subject: win: replace wmic invocation with powershell
......................................................................


Patch Set 2: Code-Review+1

(1 comment)

Patchset:

PS2:
I have tested this on win11 24h2 / arm64.

With 2.6.14 "standard" and DCO, setting DNS domain does not work (no useful=
 error log findable though, see github #842).  Stopping the service, replac=
ing openvpnsrv.exe with one from Lev's repo, and restarting, makes DNS doma=
in work.

Did not test running openvpn.exe in privileged mode.

For a +2 someone who understands this better should do an actual review ;-)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1183?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Iff2f4ea677fe2d88659d7814dab0f792f5004fb3
Gerrit-Change-Number: 1183
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Sun, 14 Sep 2025 19:54:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--p9pUo+EWgQ0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1183?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1183?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">I have tested this on win11 24h2 / arm64.</p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">With 2.6.14 &qu=
ot;standard&quot; and DCO, setting DNS domain does not work (no useful erro=
r log findable though, see github #842).  Stopping the service, replacing o=
penvpnsrv.exe with one from Lev&#39;s repo, and restarting, makes DNS domai=
n work.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Did n=
ot test running openvpn.exe in privileged mode.</p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">For a +2 someone who understands this be=
tter should do an actual review ;-)</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1183?usp=3Demail">change=
 1183</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1183?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iff2f4ea677fe2d88659d7814dab=
0f792f5004fb3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1183 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 14 Sep 2025 19:54:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--p9pUo+EWgQ0=--

