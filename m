From: "mrbff (Code Review)" <gerrit@...515...>
Date: Thu, 11 Sep 2025 14:52:11 +0000
In-Reply-To: <gerrit.1757600733000.I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb@...2715...>
References: <gerrit.1757600733000.I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <435400bd3b377fac160906c49186af08a4f88aa3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zlTJVJoGjnM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: push-update-server:
 comment about `buf_string_compare_advance()` usag...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zlTJVJoGjnM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1177?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: push-update-server: comment about `buf_string_compare_advan=
ce()` usage in `send_single_push_update()`
......................................................................

push-update-server: comment about `buf_string_compare_advance()` usage in `=
send_single_push_update()`

Change-Id: I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/push_util.c
1 file changed, 4 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1177/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--zlTJVJoGjnM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1177?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">push-update-server: comment about `buf_string=
_compare_advance()` usage in `send_single_push_update()`<br><br>Change-Id: =
I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb<br>Signed-off-by: Marco Baffo &lt=
;marco@...2726...&gt;<br>---<br>M src/openvpn/push_util.c<br>1 file changed=
, 4 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/77/1177/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/pu=
sh_util.c b/src/openvpn/push_util.c</span><br><span>index bd3992b..f7a4fca =
100644</span><br><span>--- a/src/openvpn/push_util.c</span><br><span>+++ b/=
src/openvpn/push_util.c</span><br><span>@@ -161,6 +161,10 @@</span><br><spa=
n>          * will not be routed towards the client.</span><br><span>      =
    * For the same reason we later update the vhash too in</span><br><span>=
          * `send_push_update()` function.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * Using `buf_string_compare_advance()` we m=
imic the behavior</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * inside `process_incoming_push_msg()`. However, we don&#39;t need</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * to check t=
he return value here because we just want to `advance`,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * meaning we skip the `push_up=
date_cmd&#39; we added earlier.</span><br><span>          */</span><br><spa=
n>         buf_string_compare_advance(&amp;msgs[i], push_update_cmd);</span=
><br><span>         if (process_incoming_push_update(c, pull_permission_mas=
k(c), option_types_found, &amp;msgs[i], true) =3D=3D PUSH_MSG_ERROR)</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1177?usp=3Demail">change 1177</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1177?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I73f8ad9bf105920f4bde357ea9d=
cf0e485f3f3cb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1177 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--zlTJVJoGjnM=--

