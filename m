From: "MaxF (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 18:32:47 +0000
In-Reply-To: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
References: <gerrit.1731290343000.I2a104decdb1e77a460f7a6976bcd0560b67a07b5@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <aa5bb19f19b8bf9e6b250c3bf604526f1502820f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HF7aTiJX8MA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add methods to
 read/write packet ids for epoch data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HF7aTiJX8MA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

MaxF has posted comments on this change. ( http://gerrit.openvpn.net/c/open=
vpn/+/803?usp=3Demail )

Change subject: Add methods to read/write packet ids for epoch data
......................................................................


Patch Set 8:

(5 comments)

Patchset:

PS8:
Nitpicks about comments, code looks good to me.


File src/openvpn/packet_id.h:

http://gerrit.openvpn.net/c/openvpn/+/803/comment/c836da37_30744229 :
PS8, Line 49: Maks
Mask


http://gerrit.openvpn.net/c/openvpn/+/803/comment/ecbf03a7_cb2058dd :
PS8, Line 331: packed
I'm thinking this is a typo. Or is it actually a packed struct?


http://gerrit.openvpn.net/c/openvpn/+/803/comment/8101af1b_44e6d50f :
PS8, Line 333: epcoh
epoch


File tests/unit_tests/openvpn/test_packet_id.c:

http://gerrit.openvpn.net/c/openvpn/+/803/comment/230d5a2f_40d775b3 :
PS8, Line 241: /* test writing/checking the 48 bit overflow */
I don't get it, what overflow?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2a104decdb1e77a460f7a6976bcd0560b67a07b5
Gerrit-Change-Number: 803
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Fri, 27 Dec 2024 18:32:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--HF7aTiJX8MA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
803?tab=3Dcomments">Patch Set #8:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Nitpicks about comments, code looks good to me.</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/p=
acket_id.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/803/comment/c836da37_30744229">Patch S=
et #8, Line 49:</a> <code style=3D"font-family:monospace,monospace">Maks</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Mask</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/803/comment/ecbf0=
3a7_cb2058dd">Patch Set #8, Line 331:</a> <code style=3D"font-family:monosp=
ace,monospace">packed</code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">I&#39;m thinking this is a typo. Or is it actually a packed=
 struct?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/803/c=
omment/8101af1b_44e6d50f">Patch Set #8, Line 333:</a> <code style=3D"font-f=
amily:monospace,monospace">epcoh</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">epoch</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File tests/unit_tests/openvpn/test_packet_id.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/803/comment/230d5a2f_40d775b3">Patch Set #8, Line 241:</a> <c=
ode style=3D"font-family:monospace,monospace">/* test writing/checking the =
48 bit overflow */</code></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">I don&#39;t get it, what overflow?</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Dem=
ail">change 803</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/803?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2a104decdb1e77a460f7a6976bc=
d0560b67a07b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 803 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Dec 2024 18:32:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--HF7aTiJX8MA=--

