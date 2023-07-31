From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 31 Jul 2023 09:29:57 +0000
In-Reply-To: <gerrit.1690550288000.I47c22dcb728011dcedaae47cd03a57219e9c7607@...2715...>
References: <gerrit.1690550288000.I47c22dcb728011dcedaae47cd03a57219e9c7607@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277..., a@...2181...
Message-ID: <e6525fea8c5accc882a731b1f1f4389cb3ae70a3-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NNX8Cf7Sx6c="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Set WINS
 servers via interactice service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, selvanair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NNX8Cf7Sx6c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos, selvanair, s=
tipa.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/321?usp=3Demail )

Change subject: Set WINS servers via interactice service
......................................................................


Patch Set 1:

(4 comments)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/321/comment/e7e6ec3b_6554de56 :
PS1, Line 1089:  * @param  action      "delete" or "add"
This says "add" but the rest of the function seems to use "set". But also s=
ee below for "add" vs "set".


http://gerrit.openvpn.net/c/openvpn/+/321/comment/9fdd7e73_de5a661e :
PS1, Line 1094:  * if action =3D "set" then "static" is added before $addr
Why are you using "set" here? The documentation (https://learn.microsoft.co=
m/en-us/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc=
731521(v=3Dws.10)#set-winsserver) seems to suggest that that can only set o=
ne WINS server ("If the interface is already statically configured, the sta=
tic parameter replaces the existing WINS server address list with the one s=
pecified in the set winsserver command.") Shouldn't you use "add" instead?


http://gerrit.openvpn.net/c/openvpn/+/321/comment/a93a828d_867cc63f :
PS1, Line 1406:     if (addr_len > 0 || msg->header.type =3D=3D msg_del_win=
s_cfg)
Is there ever a case where this would be false?


http://gerrit.openvpn.net/c/openvpn/+/321/comment/f983786a_f046e4f1 :
PS1, Line 1436:     if (msg->addr_len > 0)
Nitpick: Should be addr_len, not msg->addr_len



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/321?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I47c22dcb728011dcedaae47cd03a57219e9c7607
Gerrit-Change-Number: 321
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Mon, 31 Jul 2023 09:29:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--NNX8Cf7Sx6c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, ordex, plaisthos, selvanai=
r, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/321?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/321/comment/e7e6ec3b_6554de56">Patch Set #1, Line=
 1089:</a> <code style=3D"font-family:monospace,monospace"> * @param  actio=
n      &quot;delete&quot; or &quot;add&quot;</code></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">This says &quot;add&quot; but the re=
st of the function seems to use &quot;set&quot;. But also see below for &qu=
ot;add&quot; vs &quot;set&quot;.</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/321/comment/9fdd7e73_de5a661e">Patch Set #1, Line 1094:<=
/a> <code style=3D"font-family:monospace,monospace"> * if action =3D &quot;=
set&quot; then &quot;static&quot; is added before $addr</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Why are you using &quot;=
set&quot; here? The documentation (https://learn.microsoft.com/en-us/previo=
us-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731521(v=3Dws.=
10)#set-winsserver) seems to suggest that that can only set one WINS server=
 (&quot;If the interface is already statically configured, the static param=
eter replaces the existing WINS server address list with the one specified =
in the set winsserver command.&quot;) Shouldn&#39;t you use &quot;add&quot;=
 instead?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/321/=
comment/a93a828d_867cc63f">Patch Set #1, Line 1406:</a> <code style=3D"font=
-family:monospace,monospace">    if (addr_len &gt; 0 || msg-&gt;header.type=
 =3D=3D msg_del_wins_cfg)</code></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Is there ever a case where this would be false?</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/321/comment/f983786a_=
f046e4f1">Patch Set #1, Line 1436:</a> <code style=3D"font-family:monospace=
,monospace">    if (msg-&gt;addr_len &gt; 0)</code></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Nitpick: Should be addr_len, not msg=
-&gt;addr_len</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/321?usp=3Demail">change 321</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/321?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47c22dcb728011dcedaae47cd03=
a57219e9c7607 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 321 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 31 Jul 2023 09:29:57=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--NNX8Cf7Sx6c=--

