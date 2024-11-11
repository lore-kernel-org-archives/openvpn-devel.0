From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 08:06:39 +0000
In-Reply-To: <gerrit.1731290343000.I210fa255921e7115bd66ba5f3e431562552e3335@...2715...>
References: <gerrit.1731290343000.I210fa255921e7115bd66ba5f3e431562552e3335@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5e9363cdd2c73782962a006f6aa49f2422cd178c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+1UPJnaH9L0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Move
 should_trigger_renegotiation into its own function
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

--+1UPJnaH9L0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/794?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Move should_trigger_renegotiation into its own function
......................................................................

Move should_trigger_renegotiation into its own function

The if statement has become quite large and unreadable. Reformat it
and move it to a separate function.

Change-Id: I210fa255921e7115bd66ba5f3e431562552e3335
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241111074355.17918-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
740.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
1 file changed, 35 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/794/2

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 93e31f1..d44185e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2962,8 +2962,42 @@
     return true;
 }

+/**
+ * Determines if a renegotiation should be triggerred based on the various
+ * factors that can trigger one
+ */
+static bool
+should_trigger_renegotiation(const struct tls_session *session, const stru=
ct key_state *ks)
+{
+    /* Time limit */
+    if (session->opt->renegotiate_seconds
+        && now >=3D ks->established + session->opt->renegotiate_seconds)
+    {
+        return true;
+    }

+    /* Byte limit */
+    if (session->opt->renegotiate_bytes > 0
+        && ks->n_bytes >=3D session->opt->renegotiate_bytes)
+    {
+        return true;
+    }

+    /* Packet limit */
+    if (session->opt->renegotiate_packets
+        && ks->n_packets >=3D session->opt->renegotiate_packets)
+    {
+        return true;
+    }
+
+    /* Packet id approach the limit of the packet id */
+    if (packet_id_close_to_wrapping(&ks->crypto_options.packet_id.send))
+    {
+        return true;
+    }
+
+    return false;
+}
 /*
  * This is the primary routine for processing TLS stuff inside the
  * the main event loop.  When this routine exits
@@ -2991,13 +3025,7 @@

     /* Should we trigger a soft reset? -- new key, keeps old key for a whi=
le */
     if (ks->state >=3D S_GENERATED_KEYS
-        && ((session->opt->renegotiate_seconds
-             && now >=3D ks->established + session->opt->renegotiate_secon=
ds)
-            || (session->opt->renegotiate_bytes > 0
-                && ks->n_bytes >=3D session->opt->renegotiate_bytes)
-            || (session->opt->renegotiate_packets
-                && ks->n_packets >=3D session->opt->renegotiate_packets)
-            || (packet_id_close_to_wrapping(&ks->crypto_options.packet_id.=
send))))
+        && should_trigger_renegotiation(session, ks))
     {
         msg(D_TLS_DEBUG_LOW, "TLS: soft reset sec=3D%d/%d bytes=3D" counte=
r_format
             "/%d pkts=3D" counter_format "/%d",

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/794?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I210fa255921e7115bd66ba5f3e431562552e3335
Gerrit-Change-Number: 794
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--+1UPJnaH9L0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
794?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Move should_trigger_renegotiation into its own funct=
ion<br><br>The if statement has become quite large and unreadable. Reformat=
 it<br>and move it to a separate function.<br><br>Change-Id: I210fa255921e7=
115bd66ba5f3e431562552e3335<br>Signed-off-by: Arne Schwabe &lt;arne@...1830...=
...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &l=
t;20241111074355.17918-1-gert@...1296...&gt;<br>URL: https://www.mail-archi=
ve.com/openvpn-devel@lists.sourceforge.net/msg29740.html<br>Signed-off-by: =
Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 fil=
e changed, 35 insertions(+), 7 deletions(-)<br><br></pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/94/794/2</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 93e31f1..d44185e 100=
644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openv=
pn/ssl.c</span><br><span>@@ -2962,8 +2962,42 @@</span><br><span>     return=
 true;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Determines if a renegotiation should be triggerred based on the =
various</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * factors t=
hat can trigger one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+should_trigger_renegotia=
tion(const struct tls_session *session, const struct key_state *ks)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Time limit */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;renegotiate_seco=
nds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&am=
p; now &gt;=3D ks-&gt;established + session-&gt;opt-&gt;renegotiate_seconds=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Byte limit */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&g=
t;renegotiate_bytes &gt; 0</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        &amp;&amp; ks-&gt;n_bytes &gt;=3D session-&gt;opt-&gt;renego=
tiate_bytes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Packet li=
mit */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sessi=
on-&gt;opt-&gt;renegotiate_packets</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        &amp;&amp; ks-&gt;n_packets &gt;=3D session-&gt;opt-=
&gt;renegotiate_packets)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Packet id approach the limit of th=
e packet id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (packet_id_close_to_wrapping(&amp;ks-&gt;crypto_options.packet_id.send))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span> /*</span><br><span>  * This is the primary routin=
e for processing TLS stuff inside the</span><br><span>  * the main event lo=
op.  When this routine exits</span><br><span>@@ -2991,13 +3025,7 @@</span><=
br><span> </span><br><span>     /* Should we trigger a soft reset? -- new k=
ey, keeps old key for a while */</span><br><span>     if (ks-&gt;state &gt;=
=3D S_GENERATED_KEYS</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       &amp;&amp; ((session-&gt;opt-&gt;renegotiate_seconds</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-             &amp;&amp; now &gt;=3D k=
s-&gt;established + session-&gt;opt-&gt;renegotiate_seconds)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            || (session-&gt;opt-&gt;=
renegotiate_bytes &gt; 0</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                &amp;&amp; ks-&gt;n_bytes &gt;=3D session-&gt;opt-&gt;re=
negotiate_bytes)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       || (session-&gt;opt-&gt;renegotiate_packets</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                &amp;&amp; ks-&gt;n_packets &g=
t;=3D session-&gt;opt-&gt;renegotiate_packets)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            || (packet_id_close_to_wrapping(&amp;k=
s-&gt;crypto_options.packet_id.send))))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        &amp;&amp; should_trigger_renegotiation(session=
, ks))</span><br><span>     {</span><br><span>         msg(D_TLS_DEBUG_LOW,=
 &quot;TLS: soft reset sec=3D%d/%d bytes=3D&quot; counter_format</span><br>=
<span>             &quot;/%d pkts=3D&quot; counter_format &quot;/%d&quot;,<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/794?usp=3Demail">change 794</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/794?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I210fa255921e7115bd66ba5f3e4=
31562552e3335 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 794 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+1UPJnaH9L0=--

