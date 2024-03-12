From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 12 Mar 2024 16:38:50 +0000
In-Reply-To: <gerrit.1709564073000.Icfc179490d6821e22d14817941fb0bad667c713f@...2715...>
References: <gerrit.1709564073000.Icfc179490d6821e22d14817941fb0bad667c713f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0b6b02d19594faeb07f7e6d732a39536a9d11d2e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IfEj30mJ0q0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Avoid SIGUR1 to
 SIGHUP when the configuration is read from stdin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IfEj30mJ0q0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/533?usp=3Demail )

Change subject: Avoid SIGUR1 to SIGHUP when the configuration is read from =
stdin
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/533/comment/2cfbe3af_29c12353 :
PS1, Line 7: Avoid SIGUR1 to SIGHUP when the configuration is read from std=
in
Typo -> "SIGUSR1"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/533?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icfc179490d6821e22d14817941fb0bad667c713f
Gerrit-Change-Number: 533
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Tue, 12 Mar 2024 16:38:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--IfEj30mJ0q0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/533?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/533/comment/2cfbe3af_29c12353">Patch Set #1, Line 7:</a> <code sty=
le=3D"font-family:monospace,monospace">Avoid SIGUR1 to SIGHUP when the conf=
iguration is read from stdin</code></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Typo -&gt; &quot;SIGUSR1&quot;</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/533?us=
p=3Demail">change 533</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/533?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icfc179490d6821e22d14817941f=
b0bad667c713f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 533 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 12 Mar 2024 16:38:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--IfEj30mJ0q0=--

