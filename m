From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 12:04:13 +0000
In-Reply-To: <gerrit.1761324750000.I3309265edf8d6bea7bd73b21eef589a92ede6e0a@...2715...>
References: <gerrit.1761324750000.I3309265edf8d6bea7bd73b21eef589a92ede6e0a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <0802d299799d34b9efee9d181e4030274e4b34da-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hS0mzLZV54o="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Clean up type
 handling in write_string()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hS0mzLZV54o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change by flichtenheld. ( http://g=
errit.openvpn.net/c/openvpn/+/1300?usp=3Demail )

Change subject: ssl: Clean up type handling in write_string()
......................................................................


Patch Set 4:

(1 comment)

File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1300/comment/24c81aca_9a5c48f2?usp=3D=
email :
PS3, Line 1788:     if (len < 2 || len > real_maxlen)
> changing this from "< 1" to "< 2" is surprising, and I think, not correct=
 - we can and do write empt [=E2=80=A6]
Right, removed the check completely.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3309265edf8d6bea7bd73b21eef589a92ede6e0a
Gerrit-Change-Number: 1300
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Mon, 03 Nov 2025 12:04:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>

--hS0mzLZV54o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1300/comment/24c81aca_9a5c48f2?usp=3Demail">Patch Set #3, Lin=
e 1788:</a> <code style=3D"font-family:monospace,monospace">    if (len &lt=
; 2 || len &gt; real_maxlen)</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">changing this from &quot=
;&lt; 1&quot; to &quot;&lt; 2&quot; is surprising, and I think, not correct=
 - we can and do write empt [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Right, removed the=
 check completely.</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail">change 1300</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1300?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3309265edf8d6bea7bd73b21eef=
589a92ede6e0a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1300 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 03 Nov 2025 12:04:13=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>

</body></html>=

--hS0mzLZV54o=--

