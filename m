From: "mattock (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 06:22:01 +0000
In-Reply-To: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
References: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <f1d43fbbc4dabd16a2014ccd51f11c80b9ead89e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bst/QB9sSJQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add lwip support to
 t_server_null
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bst/QB9sSJQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

mattock has posted comments on this change. ( http://gerrit.openvpn.net/c/o=
penvpn/+/811?usp=3Demail )

Change subject: Add lwip support to t_server_null
......................................................................


Patch Set 10:

(2 comments)

Patchset:

PS10:
I'll mark this as done with the assumption that its not a blocker.


File tests/t_server_null_client.sh:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/bb4c0ea7_9138308c :
PS8, Line 138:         server_pid=3D$(cat "$i.pid" 2> /dev/null)
> Yes, that seems to be the case. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250
Gerrit-Change-Number: 811
Gerrit-PatchSet: 10
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 28 Jan 2025 06:22:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: mattock <samuli@...515...>
Gerrit-MessageType: comment

--bst/QB9sSJQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
811?tab=3Dcomments">Patch Set #10:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">I&#39;ll mark this as done with the assumption t=
hat its not a blocker.</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File tests/t_server_null_client.sh:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811/comm=
ent/bb4c0ea7_9138308c">Patch Set #8, Line 138:</a> <code style=3D"font-fami=
ly:monospace,monospace">        server_pid=3D$(cat &quot;$i.pid&quot; 2&gt;=
 /dev/null)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">Yes, that seems to be the case. [=E2=80=
=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/811?usp=3Demail">change 811</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/811?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca=
6b8c029f0d250 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 811 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Jan 2025 06:22:01=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: mattock &lt;samuli@...2146...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--bst/QB9sSJQ=--

