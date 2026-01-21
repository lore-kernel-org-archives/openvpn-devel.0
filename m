From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 21 Jan 2026 12:32:09 +0000
In-Reply-To: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@...2715...>
References: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <16a3610a664a2d25ad2f0d355432228b81dcc45a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="24QBJJZNXWs="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: Fix conversion
 issues related to timeout in send_auth_pending_m...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--24QBJJZNXWs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

plaisthos has posted comments on this change by flichtenheld. ( http://gerr=
it.openvpn.net/c/openvpn/+/1293?usp=3Demail )

Change subject: push: Fix conversion issues related to timeout in send_auth=
_pending_messages
......................................................................


Patch Set 9:

(1 comment)

File src/openvpn/push.c:

http://gerrit.openvpn.net/c/openvpn/+/1293/comment/1ede80cb_484f24b6?usp=3D=
email :
PS5, Line 451:     }
> But isn't that correct? In that case "max_timeout" has already expired, s=
o shouldn't we fail?
Since this return value is only what the management interface gets back, it=
 is probably okay to return false here.

I don't think we need time_elapsed < 0 here since that now < ks->inital is =
something that should never happen and checking for it here might be more c=
onfusing than good.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1293?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icc31b7fa0da86220df45552aecc15dc6c769cd54
Gerrit-Change-Number: 1293
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 21 Jan 2026 12:32:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--24QBJJZNXWs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1293?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1293/comment/1ede80cb_484f24b6?usp=3Demail">Patch Set #5, Li=
ne 451:</a> <code style=3D"font-family:monospace,monospace">    }</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">But isn&#39;t that correct? In that case &quot;max_timeout&quo=
t; has already expired, so shouldn&#39;t we fail?</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Since t=
his return value is only what the management interface gets back, it is pro=
bably okay to return false here. </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">I don&#39;t think we need time_elapse=
d &lt; 0 here since that now &lt; ks-&gt;inital is something that should ne=
ver happen and checking for it here might be more confusing than good.</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1293?usp=3Demail">change 1293</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1293?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icc31b7fa0da86220df45552aecc=
15dc6c769cd54 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1293 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 21 Jan 2026 12:32:09=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--24QBJJZNXWs=--

