From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 12 Sep 2025 15:36:40 +0000
In-Reply-To: <gerrit.1757600733000.I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb@...2715...>
References: <gerrit.1757600733000.I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <73e80c0abc4c0fd3c578b1e3c530bc53fa4fedde-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Di0wRq14b8A="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: push-update-server:
 comment about buf_string_compare_advance() usage ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Di0wRq14b8A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 mrbff. ( http://gerrit.openvpn.net/c/openvpn/+/1177?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: push-update-server: comment about buf_string_compare_advanc=
e() usage in send_single_push_update()
......................................................................

push-update-server: comment about buf_string_compare_advance() usage in sen=
d_single_push_update()

Change-Id: I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250912131519.43222-1-frank@...2641...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59232447/
URL: https://gerrit.openvpn.net/c/openvpn/+/1177
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/push_util.c
1 file changed, 4 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1177/4

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index bd3992b..f7a4fca 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -161,6 +161,10 @@
          * will not be routed towards the client.
          * For the same reason we later update the vhash too in
          * `send_push_update()` function.
+         * Using `buf_string_compare_advance()` we mimic the behavior
+         * inside `process_incoming_push_msg()`. However, we don't need
+         * to check the return value here because we just want to `advance=
`,
+         * meaning we skip the `push_update_cmd' we added earlier.
          */
         buf_string_compare_advance(&msgs[i], push_update_cmd);
         if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &msgs[i], true) =3D=3D PUSH_MSG_ERROR)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1177?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb
Gerrit-Change-Number: 1177
Gerrit-PatchSet: 4
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--Di0wRq14b8A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by mrbff.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1177=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">push-update-server: comment about buf_string_=
compare_advance() usage in send_single_push_update()<br><br>Change-Id: I73f=
8ad9bf105920f4bde357ea9dcf0e485f3f3cb<br>Signed-off-by: Marco Baffo &lt;mar=
co@...2726...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>Message-Id: &lt;20250912131519.43222-1-frank@...2641...&gt;<br>URL: https=
://sourceforge.net/p/openvpn/mailman/message/59232447/<br>URL: https://gerr=
it.openvpn.net/c/openvpn/+/1177<br>Signed-off-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>---<br>M src/openvpn/push_util.c<br>1 file changed, 4 insert=
ions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/77/1177/4</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/push_util.c =
b/src/openvpn/push_util.c</span><br><span>index bd3992b..f7a4fca 100644</sp=
an><br><span>--- a/src/openvpn/push_util.c</span><br><span>+++ b/src/openvp=
n/push_util.c</span><br><span>@@ -161,6 +161,10 @@</span><br><span>        =
  * will not be routed towards the client.</span><br><span>          * For =
the same reason we later update the vhash too in</span><br><span>          =
* `send_push_update()` function.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * Using `buf_string_compare_advance()` we mimic the b=
ehavior</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * i=
nside `process_incoming_push_msg()`. However, we don&#39;t need</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * to check the return =
value here because we just want to `advance`,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * meaning we skip the `push_update_cmd&#=
39; we added earlier.</span><br><span>          */</span><br><span>        =
 buf_string_compare_advance(&amp;msgs[i], push_update_cmd);</span><br><span=
>         if (process_incoming_push_update(c, pull_permission_mask(c), opti=
on_types_found, &amp;msgs[i], true) =3D=3D PUSH_MSG_ERROR)</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1177?usp=3Demail">change 1177</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1177?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73f8ad9bf105920f4bde357ea9d=
cf0e485f3f3cb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1177 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Di0wRq14b8A=--

