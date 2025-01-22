From: "mattock (Code Review)" <gerrit@...515...>
Date: Wed, 22 Jan 2025 15:20:06 +0000
In-Reply-To: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
References: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <37b2cb3ec1ee8e353e8ee638107d64b1515954b8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7BiYtujuqGg="; charset=UTF-8
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

--7BiYtujuqGg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

mattock has posted comments on this change. ( http://gerrit.openvpn.net/c/o=
penvpn/+/811?usp=3Demail )

Change subject: Add lwip support to t_server_null
......................................................................


Patch Set 9:

(2 comments)

File tests/t_server_null_client.sh:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/20dab47b_dd38af2d :
PS8, Line 138:         server_pid=3D$(cat "$i.pid" 2> /dev/null)
> this looks like an unrelated change... [=E2=80=A6]
Yes, that seems to be the case. I recall the extra "tr" was required on one=
 of the BSDs which added whitespace before or after "wc -w" output. Why it =
worked before (or maybe it did not?) I do not know.

The latter part was probably just me fixing a small inconsistency when I sa=
w it.

Both can be split into a separate, trivial patch if we want.


http://gerrit.openvpn.net/c/openvpn/+/811/comment/c6b7e77a_aaf98854 :
PS8, Line 173: $RUN_SUDO rm -f ./*.ips
> running `sudo rm -f` gives me the creeps, tbh, though I see no obvious wa=
y this could explode (today [=E2=80=A6]
I believe you're correct. If RUN_SUDO was needed for some corner-case I wou=
ld probably have added a comment explaining that.

I removed RUN_SUDO and ran the code through Buildbot and manually on FreeBS=
D 14 and NetBSD 10. It still behaved as one would expect.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250
Gerrit-Change-Number: 811
Gerrit-PatchSet: 9
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 22 Jan 2025 15:20:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--7BiYtujuqGg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File tests/t_server_null_client.sh:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/811/comment/20dab47b_dd38af2d">Patch Set #8, Line=
 138:</a> <code style=3D"font-family:monospace,monospace">        server_pi=
d=3D$(cat &quot;$i.pid&quot; 2&gt; /dev/null)</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this lo=
oks like an unrelated change... [=E2=80=A6]</blockquote></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Yes, that seems to be the case.=
 I recall the extra &quot;tr&quot; was required on one of the BSDs which ad=
ded whitespace before or after &quot;wc -w&quot; output. Why it worked befo=
re (or maybe it did not?) I do not know.</p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">The latter part was probably just me fixing a s=
mall inconsistency when I saw it.</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Both can be split into a separate, trivial patch if we=
 want.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811/com=
ment/c6b7e77a_aaf98854">Patch Set #8, Line 173:</a> <code style=3D"font-fam=
ily:monospace,monospace">$RUN_SUDO rm -f ./*.ips</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">runn=
ing `sudo rm -f` gives me the creeps, tbh, though I see no obvious way this=
 could explode (today [=E2=80=A6]</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I believe you&#39;re correct. If RUN_SUDO=
 was needed for some corner-case I would probably have added a comment expl=
aining that.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
I removed RUN_SUDO and ran the code through Buildbot and manually on FreeBS=
D 14 and NetBSD 10. It still behaved as one would expect.</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/81=
1?usp=3Demail">change 811</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca=
6b8c029f0d250 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 811 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jan 2025 15:20:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--7BiYtujuqGg=--

