From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 16 Oct 2023 12:08:26 +0000
In-Reply-To: <gerrit.1696685196000.I8cb2cb083e3cdadf187b7874979d79af3974e759@...2715...>
References: <gerrit.1696685196000.I8cb2cb083e3cdadf187b7874979d79af3974e759@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7600425edad23da4e2fdab976af9e637919cd164-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K7AUZ8yJrKM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--K7AUZ8yJrKM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/368?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review+2 by plaisthos

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


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

This fixes https://github.com/OpenVPN/openvpn/issues/422

Change-Id: I8cb2cb083e3cdadf187b7874979d79af3974e759
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/forward.c
1 file changed, 20 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/368/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d8ad0d1..40f21bc 100644
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
@@ -1057,9 +1075,8 @@
              * will load crypto_options with the correct encryption key
              * and return false.
              */
-            uint8_t opcode =3D *BPTR(&c->c2.buf) >> P_OPCODE_SHIFT;
-            if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.buf, =
&co,
-                                floated, &ad_start))
+            if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.buf,
+                                &co, floated, &ad_start))
             {
                 /* Restore pre-NCP frame parameters */
                 if (is_hard_reset_method2(opcode))

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/368?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I8cb2cb083e3cdadf187b7874979d79af3974e759
Gerrit-Change-Number: 368
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--K7AUZ8yJrKM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/368?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review+2 by plaisthos</p><p>The change =
is no longer submittable: Code-Review and checks~ChecksSubmitRule are unsat=
isfied now.</p><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">dco: warn if DATA_V1 packets are sent to userspace<br><br>Serve=
rs 2.4.0 - 2.4.4 support peer-id and AEAD ciphers,<br>but only send DATA_V1=
 packets. With DCO enabled on the<br>client, connection is established but =
not working.<br><br>This is because DCO driver(s) are unable to handle<br>D=
ATA_V1 packets and forwards them to userspace, where<br>they silently disap=
pear since crypto context is in<br>DCO and not in userspace.<br><br>Startin=
g from 2.4.5 server sends DATA_V2 so problem<br>doesn&#39;t happen.<br><br>=
We cannot switch to non-DCO on the fly, so we log this<br>and advice user t=
o upgrade the server to 2.4.5 or newer.<br><br>This fixes https://github.co=
m/OpenVPN/openvpn/issues/422<br><br>Change-Id: I8cb2cb083e3cdadf187b7874979=
d79af3974e759<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<b=
r>M src/openvpn/forward.c<br>1 file changed, 20 insertions(+), 3 deletions(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/6=
8/368/2</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c<=
/span><br><span>index d8ad0d1..40f21bc 100644</span><br><span>--- a/src/ope=
nvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>=
@@ -1047,6 +1047,24 @@</span><br><span> </span><br><span>         if (c-&gt=
;c2.tls_multi)</span><br><span>         {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            uint8_t opcode =3D *BPTR(&amp;c-&gt;c2.bu=
f) &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * I=
f DCO is enabled, the kernel drivers require that the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             * other end only sends P_DAT=
A_V2 packets. V1 are unknown</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+             * to kernel and passed to userland, but we cannot han=
dle them</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
  * either because crypto context is missing - so drop the packet.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+             *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             * This can only happ=
en with particular old (2.4.0-2.4.4) servers.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if ((opcode =3D=3D P_DATA_V1) &amp;&amp; =
dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                msg(D_LINK_ERRORS,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &quot;Data Channel Offload doesn&=
#39;t support DATA_V1 packets. &quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    &quot;Upgrade your server to 2.4.5 or=
 newer.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            c-&gt;c2.buf.len =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>             /*</span><br><span>              * =
If tls_pre_decrypt returns true, it means the incoming</span><br><span>    =
          * packet was a good TLS control channel packet.  If so, TLS code<=
/span><br><span>@@ -1057,9 +1075,8 @@</span><br><span>              * will =
load crypto_options with the correct encryption key</span><br><span>       =
       * and return false.</span><br><span>              */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            uint8_t opcode =3D *BPTR(=
&amp;c-&gt;c2.buf) &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            if (tls_pre_decrypt(c-&gt;c2.tls_multi, &=
amp;c-&gt;c2.from, &amp;c-&gt;c2.buf, &amp;co,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                floated, &amp;ad_s=
tart))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (tls_pre_decrypt(c-&gt;c2.tls_multi, &amp;c-&gt;c2.from, &amp;c-&gt;c2.bu=
f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
               &amp;co, floated, &amp;ad_start))</span><br><span>          =
   {</span><br><span>                 /* Restore pre-NCP frame parameters *=
/</span><br><span>                 if (is_hard_reset_method2(opcode))</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/368?usp=3Demail">change 368</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/368?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8cb2cb083e3cdadf187b7874979=
d79af3974e759 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 368 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--K7AUZ8yJrKM=--

