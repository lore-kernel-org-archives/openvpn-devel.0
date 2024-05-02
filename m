From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 2 May 2024 17:44:31 +0000
In-Reply-To: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
References: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296..., a@...2181...
Message-ID: <435d7cdd2a3eaa674549ac186898dbb1385559bd-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IBD2h0MD0DM="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IBD2h0MD0DM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/547?usp=3Demail )

Change subject: Remove openvpn_snprintf and similar functions
......................................................................


Patch Set 3:

(2 comments)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/547/comment/a795b02d_09b66782 :
PS2, Line 2007:              sud.options, svc_pipe);
> This makes GHA msbuild build fails now, with [=E2=80=A6]
Done


File tests/unit_tests/openvpn/test_buffer.c:

http://gerrit.openvpn.net/c/openvpn/+/547/comment/f9701207_7c4b904b :
PS2, Line 369:      * for this unit test. We know that are doing this that =
are truncated
> I think there is some typ0 here. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07096977e3b562bcb5d2c6f11673a4175b8e12ac
Gerrit-Change-Number: 547
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Thu, 02 May 2024 17:44:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--IBD2h0MD0DM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/547/comment/a795b02d_09b66782">Patch Set #2, Line=
 2007:</a> <code style=3D"font-family:monospace,monospace">             sud=
.options, svc_pipe);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">This makes GHA msbuild build fai=
ls now, with [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File tests/unit_tests/openvpn/test_buffer.c:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/547/comment/f9701207_7c4b904b">Patch Set #2, Line 369:</a> <code st=
yle=3D"font-family:monospace,monospace">     * for this unit test. We know =
that are doing this that are truncated</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I think there =
is some typ0 here. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail">change =
547</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07096977e3b562bcb5d2c6f1167=
3a4175b8e12ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 547 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 02 May 2024 17:44:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--IBD2h0MD0DM=--

