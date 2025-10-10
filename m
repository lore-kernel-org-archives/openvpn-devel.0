From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 14:30:53 +0000
In-Reply-To: <gerrit.1760090860000.I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0@...2715...>
References: <gerrit.1760090860000.I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <622391b73626451044207d1dfa4d25857773e77f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VwImgoeSC8k="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: PUSH_UPDATE server:
 bug-fix, reset buffer after processing
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

--VwImgoeSC8k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 mrbff. ( http://gerrit.openvpn.net/c/openvpn/+/1264?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: PUSH_UPDATE server: bug-fix, reset buffer after processing
......................................................................

PUSH_UPDATE server: bug-fix, reset buffer after processing

In the send_single_push_update() function the buffer containing
the message was not reset after processing, so o in a push-update-broad
the messages sent starting from the second client would have been
shrunk (offset advanced and size decreased).

Change-Id: I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1264
Message-Id: <20251010142002.27308-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59244933/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/push_util.c
1 file changed, 5 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1264/5

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index f306104..b475d2e 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -170,9 +170,12 @@
          * inside `process_incoming_push_msg()`. However, we don't need
          * to check the return value here because we just want to `advance=
`,
          * meaning we skip the `push_update_cmd' we added earlier.
+         * Also we need to make a temporary copy so we can buf_advance()
+         * without modifying original buffer.
          */
-        buf_string_compare_advance(&msgs[i], push_update_cmd);
-        if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &msgs[i], true) =3D=3D PUSH_MSG_ERROR)
+        struct buffer tmp_msg =3D msgs[i];
+        buf_string_compare_advance(&tmp_msg, push_update_cmd);
+        if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         {
             msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u",
                 c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1264?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0
Gerrit-Change-Number: 1264
Gerrit-PatchSet: 5
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VwImgoeSC8k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by mrbff.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1264?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">PUSH_UPDATE server: bug-fix, reset =
buffer after processing<br><br>In the send_single_push_update() function th=
e buffer containing<br>the message was not reset after processing, so o in =
a push-update-broad<br>the messages sent starting from the second client wo=
uld have been<br>shrunk (offset advanced and size decreased).<br><br>Change=
-Id: I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0<br>Signed-off-by: Marco Baff=
o &lt;marco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt=
;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1264<br>Message-Id:=
 &lt;20251010142002.27308-1-gert@...1296...&gt;<br>URL: https://sourceforge=
.net/p/openvpn/mailman/message/59244933/<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M src/openvpn/push_util.c<br>1 file changed,=
 5 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/64/1264/5</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><span>ind=
ex f306104..b475d2e 100644</span><br><span>--- a/src/openvpn/push_util.c</s=
pan><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -170,9 +170,=
12 @@</span><br><span>          * inside `process_incoming_push_msg()`. How=
ever, we don&#39;t need</span><br><span>          * to check the return val=
ue here because we just want to `advance`,</span><br><span>          * mean=
ing we skip the `push_update_cmd&#39; we added earlier.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * Also we need to make a tempo=
rary copy so we can buf_advance()</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * without modifying original buffer.</span><br><span=
>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
buf_string_compare_advance(&amp;msgs[i], push_update_cmd);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (process_incoming_push_upda=
te(c, pull_permission_mask(c), option_types_found, &amp;msgs[i], true) =3D=
=3D PUSH_MSG_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct buffer tmp_msg =3D msgs[i];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        buf_string_compare_advance(&amp;tmp_msg, pus=
h_update_cmd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (process_incoming_push_update(c, pull_permission_mask(c), option_type=
s_found, &amp;tmp_msg, true) =3D=3D PUSH_MSG_ERROR)</span><br><span>       =
  {</span><br><span>             msg(M_WARN, &quot;Failed to process push u=
pdate message sent to client ID: %u&quot;,</span><br><span>                =
 c-&gt;c2.tls_multi ? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1264?usp=3Demail">change 1264</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1264?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41d08a9a2e79ac1f1104e72dd5b=
7b7617e2071a0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1264 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--VwImgoeSC8k=--

