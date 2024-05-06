From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 6 May 2024 10:00:53 +0000
In-Reply-To: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
References: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296..., a@...2181...
Message-ID: <1fef64a6886b8c1e3a0791b291219763c8a67228-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cJFbrZphjNI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove
 openvpn_snprintf and similar functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cJFbrZphjNI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/547?usp=3Demail )

Change subject: Remove openvpn_snprintf and similar functions
......................................................................


Patch Set 5:

(1 comment)

File src/openvpn/proxy.c:

http://gerrit.openvpn.net/c/openvpn/+/547/comment/1cc5661d_bc0d1f81 :
PS4, Line 966:
> What do you mean with spurious? It changes openvpn_snprintf to snprintf
Sorry, seems I was too brief. I meant the empty line you inserted here. Eit=
her way, not important.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07096977e3b562bcb5d2c6f11673a4175b8e12ac
Gerrit-Change-Number: 547
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Mon, 06 May 2024 10:00:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--cJFbrZphjNI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/proxy.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/547/comment/1cc5661d_bc0d1f81">Patch Set #4, Line 966:</a> <=
code style=3D"font-family:monospace,monospace"></code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">What =
do you mean with spurious? It changes openvpn_snprintf to snprintf</blockqu=
ote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Sorry, s=
eems I was too brief. I meant the empty line you inserted here. Either way,=
 not important.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail">change 547</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/547?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07096977e3b562bcb5d2c6f1167=
3a4175b8e12ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 547 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 06 May 2024 10:00:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--cJFbrZphjNI=--

