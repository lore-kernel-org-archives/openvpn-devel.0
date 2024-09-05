From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 5 Sep 2024 10:20:08 +0000
In-Reply-To: <gerrit.1723691967000.I42e17e09a02f01aedadc2b03f9527967f6e1e8ff@...2715...>
References: <gerrit.1723691967000.I42e17e09a02f01aedadc2b03f9527967f6e1e8ff@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <0d764d13628c6207a50cb0055eaa39ccb5e2a143-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jlI2hNK/P7Y="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Protect cached
 username, password and token on client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jlI2hNK/P7Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, selvanair.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/728?usp=3Demail )

Change subject: Protect cached username, password and token on client
......................................................................


Patch Set 2:

(1 comment)

File src/openvpn/auth_token.c:

http://gerrit.openvpn.net/c/openvpn/+/728/comment/b41404bb_7eba0f13 :
PS2, Line 307:     ASSERT(up && !up->protected);
doesn't make sense to test for up here, when we used up->password in the li=
ne above.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/728?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I42e17e09a02f01aedadc2b03f9527967f6e1e8ff
Gerrit-Change-Number: 728
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Thu, 05 Sep 2024 10:20:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--jlI2hNK/P7Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/728?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/auth_token.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/728/comment/b41404bb_7eba0f13">Patch Set #2, Line 307:<=
/a> <code style=3D"font-family:monospace,monospace">    ASSERT(up &amp;&amp=
; !up-&gt;protected);</code></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">doesn&#39;t make sense to test for up here, when we used up=
-&gt;password in the line above.</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/728?usp=3Demail">change 728=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/728?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I42e17e09a02f01aedadc2b03f95=
27967f6e1e8ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 728 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 05 Sep 2024 10:20:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--jlI2hNK/P7Y=--

