From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 10 Nov 2023 13:49:54 +0000
In-Reply-To: <gerrit.1699611717000.Ie512544329a91fae15409cb18f29d8be617051a1@...2715...>
References: <gerrit.1699611717000.Ie512544329a91fae15409cb18f29d8be617051a1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <44b2cc38e060d8e471ab074d2732d36dbbdce777-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sErgd3foDlg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Warn if pushed
 options require DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--sErgd3foDlg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/424?usp=3Demail )

Change subject: Warn if pushed options require DHCP
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

Patchset:

PS1:
Text could use some improvement.


File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/424/comment/505f0e6f_dbd17325 :
PS1, Line 6832:         msg(M_WARN, "Some dhcp-options or --dns require DHC=
P server, which is not supported by the selected %s driver. Expect them not=
 to work.",
How about:

Some --dhcp-option or --dns options require DHCP server, which is not suppo=
rted by the selected %s driver. They will be ignored.

Same above.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/424?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ie512544329a91fae15409cb18f29d8be617051a1
Gerrit-Change-Number: 424
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Fri, 10 Nov 2023 13:49:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--sErgd3foDlg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, stipa. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/424?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/424?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Text could use some improvement.</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/424/comment/505f0e6f_dbd17325">Patch Set #1, Line 6832:=
</a> <code style=3D"font-family:monospace,monospace">        msg(M_WARN, &q=
uot;Some dhcp-options or --dns require DHCP server, which is not supported =
by the selected %s driver. Expect them not to work.&quot;,</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">How about:</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Some --dhcp-option or --=
dns options require DHCP server, which is not supported by the selected %s =
driver. They will be ignored.</p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Same above.</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/424?usp=3Demail">change 424</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/424?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie512544329a91fae15409cb18f2=
9d8be617051a1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 424 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 10 Nov 2023 13:49:54=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--sErgd3foDlg=--

