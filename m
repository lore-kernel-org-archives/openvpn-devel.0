From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 14 Oct 2025 12:36:03 +0000
In-Reply-To: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
References: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <d834dc1164de048bd6e0f12967cb41a8c87c1189-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pEAQlbOyGbE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE server:
 remove old IP(s) from vhash after sending a messa...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pEAQlbOyGbE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, mrbff, plaisthos.

ordex has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/1253?usp=3Demail )

Change subject: PUSH_UPDATE server: remove old IP(s) from vhash after sendi=
ng a message containing ifconfig(-ipv6)
......................................................................


Patch Set 6:

(1 comment)

File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1253/comment/88c29763_372fcfb0?usp=3D=
email :
PS5, Line 4390:             mi->context.c2.push_ifconfig_local =3D htonl(ne=
w_addr.s_addr);
something is weird here. if we are calling ntohl(s_addr) a few lines above,=
 we can't just call htonl(s_addr) here.... @marco@...2726... you said you p=
rinted the values *byte by byte*?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde98702a9801616a5f
Gerrit-Change-Number: 1253
Gerrit-PatchSet: 6
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Tue, 14 Oct 2025 12:36:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--pEAQlbOyGbE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, mrbff, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1253/comment/88c29763_372fcfb0?usp=3Demail">Patch Set #5, L=
ine 4390:</a> <code style=3D"font-family:monospace,monospace">            m=
i-&gt;context.c2.push_ifconfig_local =3D htonl(new_addr.s_addr);</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>something is weird here. if we are calling ntohl(s_addr) a few lines above=
, we can&#39;t just call htonl(s_addr) here.... @marco@...2726... you said =
you printed the values *byte by byte*?</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">cha=
nge 1253</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde987=
02a9801616a5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1253 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 14 Oct 2025 12:36:03=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--pEAQlbOyGbE=--

