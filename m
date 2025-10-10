From: "mrbff (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 12:48:23 +0000
In-Reply-To: <gerrit.1760090860000.I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0@...2715...>
References: <gerrit.1760090860000.I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <45a1bd5995abad73fa0ac82b9c53be5e8634cc5b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PwA4/X41z84="; charset=UTF-8
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

--PwA4/X41z84=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1264?usp=3Demail

to look at the new patch set (#3).


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
1 file changed, 4 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1264/3

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index f306104..eee68da 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -171,8 +171,10 @@
          * to check the return value here because we just want to `advance=
`,
          * meaning we skip the `push_update_cmd' we added earlier.
          */
-        buf_string_compare_advance(&msgs[i], push_update_cmd);
-        if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &msgs[i], true) =3D=3D PUSH_MSG_ERROR)
+        struct buffer buf;
+        buf_set_read(&buf, (uint8_t *)BSTR(&msgs[i]), BLEN(&msgs[i]));
+        buf_string_compare_advance(&buf, push_update_cmd);
+        if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &buf, true) =3D=3D PUSH_MSG_ERROR)
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
Gerrit-PatchSet: 3
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--PwA4/X41z84=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>mrbff <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1264?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">PUSH_UPDATE server: bug-fix, reset buffer after process=
ing<br><br>In the send_single_push_update() function the buffer containing<=
br>the message was not reset after processing, so o in a push-update-broad<=
br>the messages sent starting from the second client would have been<br>shr=
unk (offset advanced and size decreased).<br><br>Change-Id: I41d08a9a2e79ac=
1f1104e72dd5b7b7617e2071a0<br>Signed-off-by: Marco Baffo &lt;marco@...2786...=
..&gt;<br>---<br>M src/openvpn/push_util.c<br>1 file changed, 4 insertions(=
+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/64/1264/3</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
push_util.c b/src/openvpn/push_util.c</span><br><span>index f306104..eee68d=
a 100644</span><br><span>--- a/src/openvpn/push_util.c</span><br><span>+++ =
b/src/openvpn/push_util.c</span><br><span>@@ -171,8 +171,10 @@</span><br><s=
pan>          * to check the return value here because we just want to `adv=
ance`,</span><br><span>          * meaning we skip the `push_update_cmd&#39=
; we added earlier.</span><br><span>          */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        buf_string_compare_advance(&amp;msgs[i],=
 push_update_cmd);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (process_incoming_push_update(c, pull_permission_mask(c), option_ty=
pes_found, &amp;msgs[i], true) =3D=3D PUSH_MSG_ERROR)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct buffer buf;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        buf_set_read(&amp;buf, (ui=
nt8_t *)BSTR(&amp;msgs[i]), BLEN(&amp;msgs[i]));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        buf_string_compare_advance(&amp;buf, p=
ush_update_cmd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (process_incoming_push_update(c, pull_permission_mask(c), option_ty=
pes_found, &amp;buf, true) =3D=3D PUSH_MSG_ERROR)</span><br><span>         =
{</span><br><span>             msg(M_WARN, &quot;Failed to process push upd=
ate message sent to client ID: %u&quot;,</span><br><span>                 c=
-&gt;c2.tls_multi ? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1264?usp=3Demail">change 1264</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1264?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41d08a9a2e79ac1f1104e72dd5b=
7b7617e2071a0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1264 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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

--PwA4/X41z84=--

