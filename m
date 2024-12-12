From: "syzzer (Code Review)" <gerrit@...515...>
Date: Thu, 12 Dec 2024 20:02:46 +0000
In-Reply-To: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
References: <gerrit.1731290343000.I057f007577f10c6ac917ee4620ee3d2559187dc7@...2715...>
Reply-To: steffan@...1856..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606..., gert@...1296...
Message-ID: <85ce9192c2649af6e02fdbe55f8d4ee290e76847-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hpPCq+/wdQM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Trigger
 renegotiation of data key if getting close to the AEAD usage ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: MaxF <max@...2606...>, flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hpPCq+/wdQM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, plaisthos.

syzzer has posted comments on this change. ( http://gerrit.openvpn.net/c/op=
envpn/+/796?usp=3Demail )

Change subject: Trigger renegotiation of data key if getting close to the A=
EAD usage limit
......................................................................


Patch Set 13: Code-Review+1

(2 comments)

Patchset:

PS13:
Looks good conceptually. I don't have a dev/test setup available to actuall=
y do a full review, so sticking to +1.


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/796/comment/5601c42a_7ba38f22 :
PS12, Line 149:         PRIi64 " for block and packets before renegotiation=
",
> The hard limit of 2**32-1 is still there. [=E2=80=A6]
Ahh, I didn't realize the hard limit arrived with the epoch patches. That's=
 perfect.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I057f007577f10c6ac917ee4620ee3d2559187dc7
Gerrit-Change-Number: 796
Gerrit-PatchSet: 13
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: syzzer <steffan@...1856...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Thu, 12 Dec 2024 20:02:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: syzzer <steffan@...1856...>
Gerrit-MessageType: comment

--hpPCq+/wdQM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, cron2, plaisthos. </p>
<p>Patch set 13:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/796?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/796?tab=3Dcomments">Patch Set #13:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Looks good conceptually. I don&#39;t have a=
 dev/test setup available to actually do a full review, so sticking to +1.<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/796/comment/5601c42a_7ba38f22">Patch Set #1=
2, Line 149:</a> <code style=3D"font-family:monospace,monospace">        PR=
Ii64 &quot; for block and packets before renegotiation&quot;,</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">The hard limit of 2**32-1 is still there. [=E2=80=A6]</blockquote>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ahh, I didn&=
#39;t realize the hard limit arrived with the epoch patches. That&#39;s per=
fect.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/796?usp=3Demail">change 796</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/796?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I057f007577f10c6ac917ee4620e=
e3d2559187dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 796 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@...1856...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Dec 2024 20:02:46=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: syzzer &lt;steffan@...1852...=
6...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--hpPCq+/wdQM=--

