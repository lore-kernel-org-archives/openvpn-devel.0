From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 2 May 2025 20:35:00 +0000
In-Reply-To: <gerrit.1744809221000.I009f4e7ad38636f1c0b78d267561194c2bb4c051@...2715...>
References: <gerrit.1744809221000.I009f4e7ad38636f1c0b78d267561194c2bb4c051@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., antonio@...2726...
Message-ID: <442fb6e065f57538e7e7de694e0acdf093ee68c4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8Qh1vtCv4VY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco_linux: Introduce
 new uAPIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8Qh1vtCv4VY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/941?usp=3Demail )

Change subject: dco_linux: Introduce new uAPIs
......................................................................


Patch Set 4: Code-Review-1

(5 comments)

Patchset:

PS4:
Overall it looks relatively straightforward, with most of the changes just =
replacing one define with another - easy enough.  Testing to come.

There are a few changes that break the style of this module, and I see no s=
trong reason why these are done, so -1 for now.


File src/openvpn/dco_linux.c:

http://gerrit.openvpn.net/c/openvpn/+/941/comment/006d280c_8ba3e1fe :
PS4, Line 547:     return -1;
this change looks unneccessary?


http://gerrit.openvpn.net/c/openvpn/+/941/comment/91377007_60a5d367 :
PS4, Line 574: }
same here... the code style with "one common free()/return at the end" is k=
ept in other places (like dco_del_key()), so why change it here, and in a d=
ifferent style than in dco_swap_keys()?


http://gerrit.openvpn.net/c/openvpn/+/941/comment/ed9e335b_8afd8a97 :
PS4, Line 591:     keyconf =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);
why wrap differently, and not keep `struct nlattr * nla_nest_start()...`?  =
Line too long?


http://gerrit.openvpn.net/c/openvpn/+/941/comment/333dacb6_0b189629 :
PS4, Line 860:         case OVPN_CMD_KEY_SWAP_NTF:
what is KEY_SWAP_NTF?  That's a new thing :-)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/941?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I009f4e7ad38636f1c0b78d267561194c2bb4c051
Gerrit-Change-Number: 941
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Fri, 02 May 2025 20:35:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--8Qh1vtCv4VY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/941?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/941?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Overall it looks relatively straightforward, =
with most of the changes just replacing one define with another - easy enou=
gh.  Testing to come.</p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">There are a few changes that break the style of this module, and I=
 see no strong reason why these are done, so -1 for now.</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/941/comment/006d280c_8ba3e1fe">Patch Set #4, Line 547:<=
/a> <code style=3D"font-family:monospace,monospace">    return -1;</code></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">this change lo=
oks unneccessary?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/941/comment/91377007_60a5d367">Patch Set #4, Line 574:</a> <code style=
=3D"font-family:monospace,monospace">}</code></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">same here... the code style with &quot;one=
 common free()/return at the end&quot; is kept in other places (like dco_de=
l_key()), so why change it here, and in a different style than in dco_swap_=
keys()?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/941/co=
mment/ed9e335b_8afd8a97">Patch Set #4, Line 591:</a> <code style=3D"font-fa=
mily:monospace,monospace">    keyconf =3D nla_nest_start(nl_msg, OVPN_A_KEY=
CONF);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>why wrap differently, and not keep `struct nlattr * nla_nest_start()...`? =
 Line too long?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/941/comment/333dacb6_0b189629">Patch Set #4, Line 860:</a> <code style=3D=
"font-family:monospace,monospace">        case OVPN_CMD_KEY_SWAP_NTF:</code=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">what is KEY=
_SWAP_NTF?  That&#39;s a new thing :-)</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/941?usp=3Demail">chan=
ge 941</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/941?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I009f4e7ad38636f1c0b78d26756=
1194c2bb4c051 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 941 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 02 May 2025 20:35:00=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--8Qh1vtCv4VY=--

