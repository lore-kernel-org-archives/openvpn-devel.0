From: "mrbff (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 10:07:42 +0000
References: <gerrit.1760090860000.I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ade52455c39c23f844307cce3de73c5c0be96071-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ygD9a7MaIPU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ygD9a7MaIPU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1264?usp=3Demail

to review the following change.


Change subject: PUSH_UPDATE server: bug-fix, reset buffer after processing
......................................................................

PUSH_UPDATE server: bug-fix, reset buffer after processing

In the send_single_push_update() function the buffer containing
the message was not reset after processing, so o in a push-update-broad
the messages sent starting from the second client would have been
shrunk (offset advanced and size decreased).

Change-Id: I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/push_util.c
1 file changed, 6 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1264/1

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 9138bdb..43f2cb3 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -171,8 +171,13 @@
          * to check the return value here because we just want to `advance=
`,
          * meaning we skip the `push_update_cmd' we added earlier.
          */
+        int original_size =3D msgs[i].len;
         buf_string_compare_advance(&msgs[i], push_update_cmd);
-        if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &msgs[i], true) =3D=3D PUSH_MSG_ERROR)
+        int ret =3D process_incoming_push_update(c, pull_permission_mask(c=
), option_types_found, &msgs[i], true);
+        /* We reset the processed buffer */
+        msgs[i].offset =3D 0;
+        msgs[i].len =3D original_size;
+        if (ret =3D=3D PUSH_MSG_ERROR)
         {
             msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u",
                 c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1264?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0
Gerrit-Change-Number: 1264
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--ygD9a7MaIPU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1264?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">PUSH_UPDATE server: bug-fix, reset buffer a=
fter processing<br><br>In the send_single_push_update() function the buffer=
 containing<br>the message was not reset after processing, so o in a push-u=
pdate-broad<br>the messages sent starting from the second client would have=
 been<br>shrunk (offset advanced and size decreased).<br><br>Change-Id: I41=
d08a9a2e79ac1f1104e72dd5b7b7617e2071a0<br>Signed-off-by: Marco Baffo &lt;ma=
rco@...2726...&gt;<br>---<br>M src/openvpn/push_util.c<br>1 file changed, 6=
 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/64/1264/1</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/s=
rc/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><span>index 9138=
bdb..43f2cb3 100644</span><br><span>--- a/src/openvpn/push_util.c</span><br=
><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -171,8 +171,13 @@</=
span><br><span>          * to check the return value here because we just w=
ant to `advance`,</span><br><span>          * meaning we skip the `push_upd=
ate_cmd&#39; we added earlier.</span><br><span>          */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        int original_size =3D msgs[=
i].len;</span><br><span>         buf_string_compare_advance(&amp;msgs[i], p=
ush_update_cmd);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (process_incoming_push_update(c, pull_permission_mask(c), option_type=
s_found, &amp;msgs[i], true) =3D=3D PUSH_MSG_ERROR)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int ret =3D process_incoming_push=
_update(c, pull_permission_mask(c), option_types_found, &amp;msgs[i], true)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* We rese=
t the processed buffer */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msgs[i].offset =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msgs[i].len =3D original_size;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (ret =3D=3D PUSH_MSG_ERROR)</=
span><br><span>         {</span><br><span>             msg(M_WARN, &quot;Fa=
iled to process push update message sent to client ID: %u&quot;,</span><br>=
<span>                 c-&gt;c2.tls_multi ? c-&gt;c2.tls_multi-&gt;peer_id =
: UINT32_MAX);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1264?usp=3Demail">change 1264</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1264?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41d08a9a2e79ac1f1104e72dd5b=
7b7617e2071a0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1264 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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

</body></html>=

--ygD9a7MaIPU=--

