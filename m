From: "stipa (Code Review)" <gerrit@...515...>
Date: Sat, 7 Oct 2023 13:26:38 +0000
References: <gerrit.1696685196000.I8cb2cb083e3cdadf187b7874979d79af3974e759@...2715...>
Reply-To: lstipakov@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7dc953fc5d0953c52e177890fb6563d0ec2211be-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bx9/lhZeewI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Bx9/lhZeewI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/368?usp=3Demail

to review the following change.


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
1 file changed, 10 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/368/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d8ad0d1..66843b4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1058,8 +1058,16 @@
              * and return false.
              */
             uint8_t opcode =3D *BPTR(&c->c2.buf) >> P_OPCODE_SHIFT;
-            if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.buf, =
&co,
-                                floated, &ad_start))
+
+            if ((opcode =3D=3D P_DATA_V1) && dco_enabled(&c->options))
+            {
+                msg(D_LINK_ERRORS,
+                    "Data Channel Offload doesn't support DATA_V1 packets.=
 "
+                    "Upgrade your server to 2.4.5 or newer.");
+                c->c2.buf.len =3D 0;
+            }
+            else if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.=
buf,
+                                     &co, floated, &ad_start))
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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Bx9/lhZeewI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>stipa would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/368?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco: warn if DATA_V1 packets are sent to userspace<br><br>Ser=
vers 2.4.0 - 2.4.4 support peer-id and AEAD ciphers,<br>but only send DATA_=
V1 packets. With DCO enabled on the<br>client, connection is established bu=
t not working.<br><br>This is because DCO driver(s) are unable to handle<br=
>DATA_V1 packets and forwards them to userspace, where<br>they silently dis=
appear since crypto context is in<br>DCO and not in userspace.<br><br>Start=
ing from 2.4.5 server sends DATA_V2 so problem<br>doesn&#39;t happen.<br><b=
r>We cannot switch to non-DCO on the fly, so we log this<br>and advice user=
 to upgrade the server to 2.4.5 or newer.<br><br>This fixes https://github.=
com/OpenVPN/openvpn/issues/422<br><br>Change-Id: I8cb2cb083e3cdadf187b78749=
79d79af3974e759<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---=
<br>M src/openvpn/forward.c<br>1 file changed, 10 insertions(+), 2 deletion=
s(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/68/368/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.=
c</span><br><span>index d8ad0d1..66843b4 100644</span><br><span>--- a/src/o=
penvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><spa=
n>@@ -1058,8 +1058,16 @@</span><br><span>              * and return false.<=
/span><br><span>              */</span><br><span>             uint8_t opcod=
e =3D *BPTR(&amp;c-&gt;c2.buf) &gt;&gt; P_OPCODE_SHIFT;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            if (tls_pre_decrypt(c-&gt;c2.=
tls_multi, &amp;c-&gt;c2.from, &amp;c-&gt;c2.buf, &amp;co,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                floate=
d, &amp;ad_start))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if ((opc=
ode =3D=3D P_DATA_V1) &amp;&amp; dco_enabled(&amp;c-&gt;options))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                msg(D_LINK_ERRORS,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
&quot;Data Channel Offload doesn&#39;t support DATA_V1 packets. &quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quo=
t;Upgrade your server to 2.4.5 or newer.&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                c-&gt;c2.buf.len =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            else if (tls_pre_dec=
rypt(c-&gt;c2.tls_multi, &amp;c-&gt;c2.from, &amp;c-&gt;c2.buf,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
      &amp;co, floated, &amp;ad_start))</span><br><span>             {</spa=
n><br><span>                 /* Restore pre-NCP frame parameters */</span><=
br><span>                 if (is_hard_reset_method2(opcode))</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/368?usp=3Demail">change 368</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/368?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8cb2cb083e3cdadf187b7874979=
d79af3974e759 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 368 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Bx9/lhZeewI=--

