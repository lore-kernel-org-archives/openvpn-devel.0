From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 11 Nov 2024 01:59:38 +0000
References: <gerrit.1731290343000.I210fa255921e7115bd66ba5f3e431562552e3335@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <086667eab23225deb6e15a4c533c97f3893fa01a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HzOSNr+X4ks="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HzOSNr+X4ks=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/794?usp=3Demail

to review the following change.


Change subject: Move should_trigger_renegotiation into its own function
......................................................................

Move should_trigger_renegotiation into its own function

The if statement has become quite large and unreadable. Reformat it
and move it to a separate function.

Change-Id: I210fa255921e7115bd66ba5f3e431562552e3335
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl.c
1 file changed, 36 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/794/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 93e31f1..c48a85c 100644
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
@@ -2991,14 +3025,8 @@

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
-    {
+        && should_trigger_renegotiation(session, ks))
+   {
         msg(D_TLS_DEBUG_LOW, "TLS: soft reset sec=3D%d/%d bytes=3D" counte=
r_format
             "/%d pkts=3D" counter_format "/%d",
             (int) (now - ks->established), session->opt->renegotiate_secon=
ds,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/794?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I210fa255921e7115bd66ba5f3e431562552e3335
Gerrit-Change-Number: 794
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--HzOSNr+X4ks=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/794?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Move should_trigger_renegotiation into its own function<br><b=
r>The if statement has become quite large and unreadable. Reformat it<br>an=
d move it to a separate function.<br><br>Change-Id: I210fa255921e7115bd66ba=
5f3e431562552e3335<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<b=
r>---<br>M src/openvpn/ssl.c<br>1 file changed, 36 insertions(+), 8 deletio=
ns(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/94/794/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span=
><br><span>index 93e31f1..c48a85c 100644</span><br><span>--- a/src/openvpn/=
ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2962,8 +2=
962,42 @@</span><br><span>     return true;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Determines if a renegotiati=
on should be triggerred based on the various</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * factors that can trigger one</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+should_trigger_renegotiation(const struct tls_session *session=
, const struct key_state *ks)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* T=
ime limit */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(session-&gt;opt-&gt;renegotiate_seconds</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        &amp;&amp; now &gt;=3D ks-&gt;established + se=
ssion-&gt;opt-&gt;renegotiate_seconds)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Byte limit */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (session-&gt;opt-&gt;renegotiate_bytes &gt; 0</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; ks-&gt;n_byt=
es &gt;=3D session-&gt;opt-&gt;renegotiate_bytes)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Packet limit */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;renegotiate_packets</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; ks-&=
gt;n_packets &gt;=3D session-&gt;opt-&gt;renegotiate_packets)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Packet id approach the limit of the packet id */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (packet_id_close_to_wrapping(&amp;=
ks-&gt;crypto_options.packet_id.send))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> /*</span><=
br><span>  * This is the primary routine for processing TLS stuff inside th=
e</span><br><span>  * the main event loop.  When this routine exits</span><=
br><span>@@ -2991,14 +3025,8 @@</span><br><span> </span><br><span>     /* S=
hould we trigger a soft reset? -- new key, keeps old key for a while */</sp=
an><br><span>     if (ks-&gt;state &gt;=3D S_GENERATED_KEYS</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; ((session-&gt;opt-=
&gt;renegotiate_seconds</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-             &amp;&amp; now &gt;=3D ks-&gt;established + session-&gt;opt-=
&gt;renegotiate_seconds)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            || (session-&gt;opt-&gt;renegotiate_bytes &gt; 0</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                &amp;&amp; ks-&gt=
;n_bytes &gt;=3D session-&gt;opt-&gt;renegotiate_bytes)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            || (session-&gt;opt-&gt;reneg=
otiate_packets</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         &amp;&amp; ks-&gt;n_packets &gt;=3D session-&gt;opt-&gt;renegotiat=
e_packets)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 || (packet_id_close_to_wrapping(&amp;ks-&gt;crypto_options.packet_id.send)=
)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; should_trigge=
r_renegotiation(session, ks))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   {</span><br><span>         msg(D_TLS_DEBUG_LOW, &quot;TLS: sof=
t reset sec=3D%d/%d bytes=3D&quot; counter_format</span><br><span>         =
    &quot;/%d pkts=3D&quot; counter_format &quot;/%d&quot;,</span><br><span=
>             (int) (now - ks-&gt;established), session-&gt;opt-&gt;renegot=
iate_seconds,</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/794?usp=3Demail">change 794</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/794?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I210fa255921e7115bd66ba5f3e4=
31562552e3335 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 794 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--HzOSNr+X4ks=--

