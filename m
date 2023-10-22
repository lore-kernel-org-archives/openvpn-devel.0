From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 22 Oct 2023 10:49:06 +0000
In-Reply-To: <gerrit.1696685196000.I8cb2cb083e3cdadf187b7874979d79af3974e759@...2715...>
References: <gerrit.1696685196000.I8cb2cb083e3cdadf187b7874979d79af3974e759@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <443b081af9d3342fc0c5bbd059f473635ace46bd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rbjT9k3x2z0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: dco: warn if
 DATA_V1 packets are sent to userspace
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rbjT9k3x2z0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/36=
8?usp=3Demail )

Change subject: dco: warn if DATA_V1 packets are sent to userspace
......................................................................

dco: warn if DATA_V1 packets are sent to userspace

Servers 2.4.0 - 2.4.4 support peer-id and AEAD ciphers,
but only send DATA_V1 packets. With DCO enabled on the
client, connection is established but not working.

This is because DCO driver(s) are unable to handle
DATA_V1 packets and forwards them to userspace, where
they silently disappear since crypto context is in
DCO and not in userspace.

Starting from 2.4.5 server sends DATA_V2 so problem
doesn't happen.

We cannot switch to non-DCO on the fly, so we log this
and advice user to upgrade the server to 2.4.5 or newer.

Github: fixes OpenVPN/openvpn#422

Change-Id: I8cb2cb083e3cdadf187b7874979d79af3974e759
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20231022082751.8868-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
272.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit df7beea404df48745a608c584d863c5a377b7a1e)
---
M src/openvpn/forward.c
1 file changed, 18 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d8ad0d1..2510410 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1047,6 +1047,24 @@

         if (c->c2.tls_multi)
         {
+            uint8_t opcode =3D *BPTR(&c->c2.buf) >> P_OPCODE_SHIFT;
+
+            /*
+             * If DCO is enabled, the kernel drivers require that the
+             * other end only sends P_DATA_V2 packets. V1 are unknown
+             * to kernel and passed to userland, but we cannot handle them
+             * either because crypto context is missing - so drop the pack=
et.
+             *
+             * This can only happen with particular old (2.4.0-2.4.4) serv=
ers.
+             */
+            if ((opcode =3D=3D P_DATA_V1) && dco_enabled(&c->options))
+            {
+                msg(D_LINK_ERRORS,
+                    "Data Channel Offload doesn't support DATA_V1 packets.=
 "
+                    "Upgrade your server to 2.4.5 or newer.");
+                c->c2.buf.len =3D 0;
+            }
+
             /*
              * If tls_pre_decrypt returns true, it means the incoming
              * packet was a good TLS control channel packet.  If so, TLS c=
ode
@@ -1057,7 +1075,6 @@
              * will load crypto_options with the correct encryption key
              * and return false.
              */
-            uint8_t opcode =3D *BPTR(&c->c2.buf) >> P_OPCODE_SHIFT;
             if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.buf, =
&co,
                                 floated, &ad_start))
             {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/368?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I8cb2cb083e3cdadf187b7874979d79af3974e759
Gerrit-Change-Number: 368
Gerrit-PatchSet: 4
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--rbjT9k3x2z0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/368?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dco: warn if DATA_V1 packets are sent to users=
pace<br><br>Servers 2.4.0 - 2.4.4 support peer-id and AEAD ciphers,<br>but =
only send DATA_V1 packets. With DCO enabled on the<br>client, connection is=
 established but not working.<br><br>This is because DCO driver(s) are unab=
le to handle<br>DATA_V1 packets and forwards them to userspace, where<br>th=
ey silently disappear since crypto context is in<br>DCO and not in userspac=
e.<br><br>Starting from 2.4.5 server sends DATA_V2 so problem<br>doesn&#39;=
t happen.<br><br>We cannot switch to non-DCO on the fly, so we log this<br>=
and advice user to upgrade the server to 2.4.5 or newer.<br><br>Github: fix=
es OpenVPN/openvpn#422<br><br>Change-Id: I8cb2cb083e3cdadf187b7874979d79af3=
974e759<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: G=
ert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20231022082751.8868-=
1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg27272.html<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>(cherry picked from commit df7beea404df48745a608c584d863c5=
a377b7a1e)<br>---<br>M src/openvpn/forward.c<br>1 file changed, 18 insertio=
ns(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><sp=
an>index d8ad0d1..2510410 100644</span><br><span>--- a/src/openvpn/forward.=
c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1047,6 +1=
047,24 @@</span><br><span> </span><br><span>         if (c-&gt;c2.tls_multi=
)</span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            uint8_t opcode =3D *BPTR(&amp;c-&gt;c2.buf) &gt;&gt; P=
_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+             * If DCO is enab=
led, the kernel drivers require that the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+             * other end only sends P_DATA_V2 packets.=
 V1 are unknown</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
         * to kernel and passed to userland, but we cannot handle them</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+             * either be=
cause crypto context is missing - so drop the packet.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             * This can only happen with parti=
cular old (2.4.0-2.4.4) servers.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+             */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if ((opcode =3D=3D P_DATA_V1) &amp;&amp; dco_enabled(&=
amp;c-&gt;options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          msg(D_LINK_ERRORS,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    &quot;Data Channel Offload doesn&#39;t support=
 DATA_V1 packets. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    &quot;Upgrade your server to 2.4.5 or newer.&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                c=
-&gt;c2.buf.len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>             /*</span><br><span>              * If tls_pre_de=
crypt returns true, it means the incoming</span><br><span>              * p=
acket was a good TLS control channel packet.  If so, TLS code</span><br><sp=
an>@@ -1057,7 +1075,6 @@</span><br><span>              * will load crypto_o=
ptions with the correct encryption key</span><br><span>              * and =
return false.</span><br><span>              */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            uint8_t opcode =3D *BPTR(&amp;c-&gt;c2=
.buf) &gt;&gt; P_OPCODE_SHIFT;</span><br><span>             if (tls_pre_dec=
rypt(c-&gt;c2.tls_multi, &amp;c-&gt;c2.from, &amp;c-&gt;c2.buf, &amp;co,</s=
pan><br><span>                                 floated, &amp;ad_start))</sp=
an><br><span>             {</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/368?usp=3Demail">chang=
e 368</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/368?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8cb2cb083e3cdadf187b7874979=
d79af3974e759 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 368 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--rbjT9k3x2z0=--

