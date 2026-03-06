From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 11:39:26 +0000
In-Reply-To: <gerrit.1772721382000.If797f3fe178fba3f43fb12898e5484bfb38f05c3@...2715...>
References: <gerrit.1772721382000.If797f3fe178fba3f43fb12898e5484bfb38f05c3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5c27d3b7a16f51dbd4a2bddef4e9004deb7b0ca9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c+I3/qmoY/I="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Optimise performance
 of iterating over all client by remembering high...
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

--c+I3/qmoY/I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1557?usp=3Demail )

Change subject: Optimise performance of iterating over all client by rememb=
ering highest peer id
......................................................................


Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1557/comment/d4a87d22_1c3297f5?usp=3D=
email :
PS1, Line 4109:     if (mi->context.c2.tls_multi->peer_id > m->max_peerid)
I would suggest moving this code below the ASSERT. In the end it makes no d=
ifference. But I think it is easier to read if the code that checks that th=
e loop failed is directly below the loop.

As an aside I think the ASSERT is a bit unclear already. I think what it ac=
tually should check is against MAX_PEER_ID, not max_clients. From this code=
 it is not clear that it assumes that peer_id was initialized to MAX_PEER_I=
D. So I think it would be better to have an ASSERT at the top of the functi=
on that checks that peer_id is indeed MAX_PEER_ID and then an assert below =
that checks that peer_id is not MAX_PEER_ID. Much clearer. But not directly=
 the job of this patch.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1557?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If797f3fe178fba3f43fb12898e5484bfb38f05c3
Gerrit-Change-Number: 1557
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Fri, 06 Mar 2026 11:39:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--c+I3/qmoY/I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1557?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1557/comment/d4a87d22_1c3297f5?usp=3Demail">Patch Set #=
1, Line 4109:</a> <code style=3D"font-family:monospace,monospace">    if (m=
i-&gt;context.c2.tls_multi-&gt;peer_id &gt; m-&gt;max_peerid)</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I =
would suggest moving this code below the ASSERT. In the end it makes no dif=
ference. But I think it is easier to read if the code that checks that the =
loop failed is directly below the loop.</p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">As an aside I think the ASSERT =
is a bit unclear already. I think what it actually should check is against =
MAX_PEER_ID, not max_clients. From this code it is not clear that it assume=
s that peer_id was initialized to MAX_PEER_ID. So I think it would be bette=
r to have an ASSERT at the top of the function that checks that peer_id is =
indeed MAX_PEER_ID and then an assert below that checks that peer_id is not=
 MAX_PEER_ID. Much clearer. But not directly the job of this patch.</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1557?usp=3Demail">change 1557</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1557?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If797f3fe178fba3f43fb12898e5=
484bfb38f05c3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1557 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 06 Mar 2026 11:39:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--c+I3/qmoY/I=--

