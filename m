From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 1 Aug 2025 09:18:28 +0000
In-Reply-To: <gerrit.1753960651000.I41c5dfc7489352a9534ff6b1585a5a81e0623ab1@...2715...>
References: <gerrit.1753960651000.I41c5dfc7489352a9534ff6b1585a5a81e0623ab1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., antonio@...2726...
Message-ID: <41d4baf0e50458d638e62e1c67a99490fa415ed6-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y26Nt087g+4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: dco linux:
 avoid redefining ovpn enums (2.6)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Y26Nt087g+4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos, ralf_lici.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1122?usp=3Demail )

Change subject: dco linux: avoid redefining ovpn enums (2.6)
......................................................................


Patch Set 2:

(1 comment)

File src/openvpn/dco_linux.h:

http://gerrit.openvpn.net/c/openvpn/+/1122/comment/3ccd01a6_50ffc7c4 :
PS1, Line 32: #include "ovpn_dco_linux.h"
> should we add a comment here that instructs to keep this include always l=
ast? (and maybe explain why [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1122?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I41c5dfc7489352a9534ff6b1585a5a81e0623ab1
Gerrit-Change-Number: 1122
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: ralf_lici <ralf@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Fri, 01 Aug 2025 09:18:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@...2726...>
Gerrit-MessageType: comment

--Y26Nt087g+4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: ordex, plaisthos, ralf_lici. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1122?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux.h:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1122/comment/3ccd01a6_50ffc7c4">Patch Set #1, Line 32:<=
/a> <code style=3D"font-family:monospace,monospace">#include &quot;ovpn_dco=
_linux.h&quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">should we add a comment here that inst=
ructs to keep this include always last? (and maybe explain why [=E2=80=A6]<=
/blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1122?usp=3Demail">change 1122</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1122?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41c5dfc7489352a9534ff6b1585=
a5a81e0623ab1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1122 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 01 Aug 2025 09:18:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Y26Nt087g+4=--

