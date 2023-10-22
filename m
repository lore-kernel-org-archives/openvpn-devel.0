From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 22 Oct 2023 10:49:05 +0000
In-Reply-To: <gerrit.1696685196000.I8cb2cb083e3cdadf187b7874979d79af3974e759@...2715...>
References: <gerrit.1696685196000.I8cb2cb083e3cdadf187b7874979d79af3974e759@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <443b081af9d3342fc0c5bbd059f473635ace46bd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uCyZhSKvm7I="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uCyZhSKvm7I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/368?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/368/4

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
Gerrit-MessageType: newpatchset

--uCyZhSKvm7I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/368?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco: warn if DATA_V1 packets are sent to userspace<b=
r><br>Servers 2.4.0 - 2.4.4 support peer-id and AEAD ciphers,<br>but only s=
end DATA_V1 packets. With DCO enabled on the<br>client, connection is estab=
lished but not working.<br><br>This is because DCO driver(s) are unable to =
handle<br>DATA_V1 packets and forwards them to userspace, where<br>they sil=
ently disappear since crypto context is in<br>DCO and not in userspace.<br>=
<br>Starting from 2.4.5 server sends DATA_V2 so problem<br>doesn&#39;t happ=
en.<br><br>We cannot switch to non-DCO on the fly, so we log this<br>and ad=
vice user to upgrade the server to 2.4.5 or newer.<br><br>Github: fixes Ope=
nVPN/openvpn#422<br><br>Change-Id: I8cb2cb083e3cdadf187b7874979d79af3974e75=
9<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20231022082751.8868-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg27272.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>(cherry picked from commit df7beea404df48745a608c584d863c5a377b7=
a1e)<br>---<br>M src/openvpn/forward.c<br>1 file changed, 18 insertions(+),=
 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/68/368/4</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvp=
n/forward.c</span><br><span>index d8ad0d1..2510410 100644</span><br><span>-=
-- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</spa=
n><br><span>@@ -1047,6 +1047,24 @@</span><br><span> </span><br><span>      =
   if (c-&gt;c2.tls_multi)</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            uint8_t opcode =3D *BPTR(&amp=
;c-&gt;c2.buf) &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
         * If DCO is enabled, the kernel drivers require that the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+             * other end only=
 sends P_DATA_V2 packets. V1 are unknown</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+             * to kernel and passed to userland, but w=
e cannot handle them</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+             * either because crypto context is missing - so drop the pack=
et.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * This c=
an only happen with particular old (2.4.0-2.4.4) servers.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+             */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if ((opcode =3D=3D P_DATA_V1)=
 &amp;&amp; dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                msg(D_LINK_ERRORS,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;Data Channel Of=
fload doesn&#39;t support DATA_V1 packets. &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    &quot;Upgrade your server=
 to 2.4.5 or newer.&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                c-&gt;c2.buf.len =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>             /*</span><br><span>    =
          * If tls_pre_decrypt returns true, it means the incoming</span><b=
r><span>              * packet was a good TLS control channel packet.  If s=
o, TLS code</span><br><span>@@ -1057,7 +1075,6 @@</span><br><span>         =
     * will load crypto_options with the correct encryption key</span><br><=
span>              * and return false.</span><br><span>              */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            uint8_t opcod=
e =3D *BPTR(&amp;c-&gt;c2.buf) &gt;&gt; P_OPCODE_SHIFT;</span><br><span>   =
          if (tls_pre_decrypt(c-&gt;c2.tls_multi, &amp;c-&gt;c2.from, &amp;=
c-&gt;c2.buf, &amp;co,</span><br><span>                                 flo=
ated, &amp;ad_start))</span><br><span>             {</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/368?usp=3Demail">change 368</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/368?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--uCyZhSKvm7I=--

