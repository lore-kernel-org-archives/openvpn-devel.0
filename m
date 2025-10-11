From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 11 Oct 2025 11:01:42 +0000
In-Reply-To: <gerrit.1741271846000.I6841e2f2a85275254a04e2d8ae3defe4420db8f6@...2715...>
References: <gerrit.1741271846000.I6841e2f2a85275254a04e2d8ae3defe4420db8f6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <9c5af6ee24f89ef055e371ba77dac3efbb07a134-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q3WOcWvoMgY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make recursive
 routing check more fine-grained
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--q3WOcWvoMgY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

cron2 has posted comments on this change by stipa. ( http://gerrit.openvpn.=
net/c/openvpn/+/903?usp=3Demail )

Change subject: Make recursive routing check more fine-grained
......................................................................


Patch Set 3: Code-Review-1

(3 comments)

Patchset:

PS3:
close :-) - one code rearrangement, one comment (in two places), then this =
can move on.

I have tested it, and the main difference is "it logs more"... but with som=
e policy routing twists, we could end up at a setup where it makes a differ=
ence.


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/903/comment/72c2ad29_60c1bde2?usp=3De=
mail :
PS3, Line 1427:         }
This one should go up where it was, before the `openvpn_iphdr *pip` assignm=
ent (because we do not need to look for "proto" if we already know the AFI =
is different).

For IPv6, the old order has been kept...


http://gerrit.openvpn.net/c/openvpn/+/903/comment/18f831f2_47078c77?usp=3De=
mail :
PS3, Line 1432:         uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + =
sizeof(uint16_t)));
while at it, maybe add a comment about "TCP and UDP ports are at the same p=
lace in the header, and other protocols can not happen here due to the lsi-=
>proto check above"?  Because my first thought was "why is he not using ope=
nvpn_tcphdr here?"...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/903?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6841e2f2a85275254a04e2d8ae3defe4420db8f6
Gerrit-Change-Number: 903
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Sat, 11 Oct 2025 11:01:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--q3WOcWvoMgY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/903?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/903?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">close :-) - =
one code rearrangement, one comment (in two places), then this can move on.=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">I have tested it, and the main difference is &quot;it logs more&quot;.=
.. but with some policy routing twists, we could end up at a setup where it=
 makes a difference.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/forward.c:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/903/comment/72c2ad=
29_60c1bde2?usp=3Demail">Patch Set #3, Line 1427:</a> <code style=3D"font-f=
amily:monospace,monospace">        }</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">This one should go up where=
 it was, before the `openvpn_iphdr *pip` assignment (because we do not need=
 to look for &quot;proto&quot; if we already know the AFI is different).</p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">For IPv6, the old order has been kept...</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/903/comment/18f831f2_47078c77?usp=3Demail">Pat=
ch Set #3, Line 1432:</a> <code style=3D"font-family:monospace,monospace"> =
       uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t))=
);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">while at it, maybe add a comment about &quot;TCP and UDP port=
s are at the same place in the header, and other protocols can not happen h=
ere due to the lsi-&gt;proto check above&quot;?  Because my first thought w=
as &quot;why is he not using openvpn_tcphdr here?&quot;...</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/9=
03?usp=3Demail">change 903</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/903?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6841e2f2a85275254a04e2d8ae3=
defe4420db8f6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 903 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 11 Oct 2025 11:01:42=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--q3WOcWvoMgY=--

