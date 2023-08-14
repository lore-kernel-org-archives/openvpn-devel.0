From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 14 Aug 2023 09:36:51 +0000
In-Reply-To: <gerrit.1691675487000.I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7@...2715...>
References: <gerrit.1691675487000.I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <091d82e8ed5daef8999b075f1544e232c54e030a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QxOEu4OkcEk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add warning if a p2p
 NCP client connects to a p2mp server
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

--QxOEu4OkcEk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/323?usp=3Demail )

Change subject: Add warning if a p2p NCP client connects to a p2mp server
......................................................................


Patch Set 1: Code-Review-1

(3 comments)

Patchset:

PS1:
Looked some more at it, would prefer to move the code. Doesn't change anyth=
ing about the functionality though.


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/323/comment/5b44de9c_0e26824c :
PS1, Line 262:     /* For client doing the newer version of NCP (that send =
IV_CIPHER)
> Since you have done other drive-by typo fixes, should say "clients" here.
Also should be "IV_CIPHERS"


http://gerrit.openvpn.net/c/openvpn/+/323/comment/e732bec1_3e5463dc :
PS1, Line 270:     if (extract_iv_proto(peer_info) & IV_PROTO_NCP_P2P)
This function is only called from multi_client_set_protocol_options which a=
lready extracts proto and does do various things based on it. I think this =
code would be better added there instead of here.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7
Gerrit-Change-Number: 323
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 14 Aug 2023 09:36:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--QxOEu4OkcEk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/323?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Looked some more at it, would prefer to move =
the code. Doesn&#39;t change anything about the functionality though.</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_n=
cp.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/323/comment/5b44de9c_0e26824c">Patch Set #1,=
 Line 262:</a> <code style=3D"font-family:monospace,monospace">    /* For c=
lient doing the newer version of NCP (that send IV_CIPHER)</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">Since you have done other drive-by typo fixes, should say &quot;clien=
ts&quot; here.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Also should be &quot;IV_CIPHERS&quot;</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/323/comment/e732bec1_3e5463dc">Patch=
 Set #1, Line 270:</a> <code style=3D"font-family:monospace,monospace">    =
if (extract_iv_proto(peer_info) &amp; IV_PROTO_NCP_P2P)</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">This function is only ca=
lled from multi_client_set_protocol_options which already extracts proto an=
d does do various things based on it. I think this code would be better add=
ed there instead of here.</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail">change 323</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/323?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I85ae4e1167e1395b4f59d5d0ecf=
6c38befcaa8a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 323 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 14 Aug 2023 09:36:51=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--QxOEu4OkcEk=--

