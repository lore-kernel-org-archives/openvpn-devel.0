From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 28 Jan 2026 10:58:22 +0000
In-Reply-To: <gerrit.1769550961000.Iabc117848ad7b67d240c392f1a6aa2d7531fd5bb@...2715...>
References: <gerrit.1769550961000.Iabc117848ad7b67d240c392f1a6aa2d7531fd5bb@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 gert@...1296...
Message-ID: <5c2cf92578a68ffa999fc3ba987a1591d2333029-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oo9xWj/hLhc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tunnel_server():
 close correct inotify fd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oo9xWj/hLhc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2.

plaisthos has posted comments on this change by cron2. ( http://gerrit.open=
vpn.net/c/openvpn/+/1497?usp=3Demail )

Change subject: tunnel_server(): close correct inotify fd
......................................................................


Patch Set 1: Code-Review+2

(2 comments)

File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1497/comment/079de3b1_4b96fdc7?usp=3D=
email :
PS1, Line 4237:     multi.top.c2.inotify_fd =3D inotify_init();
We set inotify_fd here in (multi->top, which is also CM_TOP_CLONE) instead =
of top which is CM_TOP.

We should probably rename top in this function to something like root_top o=
r something else to avoid the confusion between multi->top and the local to=
p variable.


http://gerrit.openvpn.net/c/openvpn/+/1497/comment/de71ce2b_74df9b13?usp=3D=
email :
PS1, Line 4247:     close(top->c2.inotify_fd);
and then we close top of the other context.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1497?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iabc117848ad7b67d240c392f1a6aa2d7531fd5bb
Gerrit-Change-Number: 1497
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Wed, 28 Jan 2026 10:58:22 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--oo9xWj/hLhc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1497?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1497/comment/079de3b1_4b96fdc7?usp=3Demail">Patch Set =
#1, Line 4237:</a> <code style=3D"font-family:monospace,monospace">    mult=
i.top.c2.inotify_fd =3D inotify_init();</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">We set inotify_fd here i=
n (multi-&gt;top, which is also CM_TOP_CLONE) instead of top which is CM_TO=
P. </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">We should probably rename top in this function to something like ro=
ot_top or something else to avoid the confusion between multi-&gt;top and t=
he local top variable.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1497/comment/de71ce2b_74df9b13?usp=3Demail">Patch Set #1, Line 424=
7:</a> <code style=3D"font-family:monospace,monospace">    close(top-&gt;c2=
.inotify_fd);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">and then we close top of the other context.</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1497?usp=3Demail">change 1497</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1497?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iabc117848ad7b67d240c392f1a6=
aa2d7531fd5bb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1497 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Jan 2026 10:58:22=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--oo9xWj/hLhc=--

