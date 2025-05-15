From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 15 May 2025 09:57:00 +0000
In-Reply-To: <gerrit.1747256571000.I7fc033a7ffee73045316763356a95d75ef23f5ad@...2715...>
References: <gerrit.1747256571000.I7fc033a7ffee73045316763356a95d75ef23f5ad@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...,
 antonio@...2726...
Message-ID: <66b86ac8ebba38a444a1bcb53b16c79d29b845aa-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+IqEwP60ZSQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement ovpn
 version detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+IqEwP60ZSQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos, ralf_=
lici.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1022?usp=3Demail )

Change subject: Implement ovpn version detection
......................................................................


Patch Set 2:

(1 comment)

Patchset:

PS2:
Running basic tests with "openvpn --version"

Test #1 "no ovpn.ko around": `DCO version: N/A`
Test #2 "ovpn.ko around, but not exporting anything" (older branch)": `DCO =
version:
N/A`
Test #3 "modprobe ovpn.ko": `DCO version: 5.4.0-215-generic #235-Ubuntu SMP=
 Fri Apr 11 21:55:32 UTC 2025`
Test #4: actually running an OpenVPN client, hoping for module autoload -> =
works.

so this is generally good (will add test #5 when I have a backports with ex=
ported module version).  Interesting to keep in mind: `openvpn --version` w=
ill not(!) autoload the module.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1022?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7fc033a7ffee73045316763356a95d75ef23f5ad
Gerrit-Change-Number: 1022
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Thu, 15 May 2025 09:57:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--+IqEwP60ZSQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos, r=
alf_lici. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1022?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1022?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Running basic tests with &quot;openvpn --version=
&quot;</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Test #=
1 &quot;no ovpn.ko around&quot;: `DCO version: N/A`<br>Test #2 &quot;ovpn.k=
o around, but not exporting anything&quot; (older branch)&quot;: `DCO versi=
on: <br>N/A`<br>Test #3 &quot;modprobe ovpn.ko&quot;: `DCO version: 5.4.0-2=
15-generic #235-Ubuntu SMP Fri Apr 11 21:55:32 UTC 2025`<br>Test #4: actual=
ly running an OpenVPN client, hoping for module autoload -&gt; works.</p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">so this is general=
ly good (will add test #5 when I have a backports with exported module vers=
ion).  Interesting to keep in mind: `openvpn --version` will not(!) autoloa=
d the module.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1022?usp=3Demail">change 1022</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1022?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7fc033a7ffee73045316763356a=
95d75ef23f5ad </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1022 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 15 May 2025 09:57:00=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--+IqEwP60ZSQ=--

