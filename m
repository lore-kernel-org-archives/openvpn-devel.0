From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 8 Jul 2024 16:32:44 +0000
In-Reply-To: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
References: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2724e23a183254cfd96ab68845da9ff87536a66c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yrG54OHiPk0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Allow trailing \r
 and \n in control channel message
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

--yrG54OHiPk0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/672?usp=3Demail )

Change subject: Allow trailing \r and \n in control channel message
......................................................................


Patch Set 2: Code-Review-1

(2 comments)

Patchset:

PS2:
I must say that I would feel better if we had a UT covering all this. Not s=
ure how difficult that would be?


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/672/comment/9a73fe6c_d79f0ee2 :
PS2, Line 318:                         format_hex(BPTR(&buf), BLEN(&cmdbuf)=
, 256, &gc));
While it is not actually wrong to use BPTR(&buf) here, I would recommend BP=
TR(&cmdbuf). It should make no difference to the output and looks less like=
 an error.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e
Gerrit-Change-Number: 672
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 08 Jul 2024 16:32:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--yrG54OHiPk0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/672?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">I must say that I would feel better if we had=
 a UT covering all this. Not sure how difficult that would be?</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/672/comment/9a73fe6c_d79f0ee2">Patch Set #2, Line 3=
18:</a> <code style=3D"font-family:monospace,monospace">                   =
     format_hex(BPTR(&amp;buf), BLEN(&amp;cmdbuf), 256, &amp;gc));</code></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">While it is no=
t actually wrong to use BPTR(&amp;buf) here, I would recommend BPTR(&amp;cm=
dbuf). It should make no difference to the output and looks less like an er=
ror.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/672?usp=3Demail">change 672</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/672?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f72=
0cf50dc1fbe3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 672 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Jul 2024 16:32:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--yrG54OHiPk0=--

