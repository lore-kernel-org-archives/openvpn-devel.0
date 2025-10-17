From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 17 Oct 2025 15:20:56 +0000
In-Reply-To: <gerrit.1760629750000.I7b718a14b81e3759398e7a52fe151102494cc821@...2715...>
References: <gerrit.1760629750000.I7b718a14b81e3759398e7a52fe151102494cc821@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b39e65f634a0c9a24910585dde6bd04dc920fc9c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Mr0w6o7xt1o="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: warn and
 ignore --reneg-bytes/pkts when DCO is enabled
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

--Mr0w6o7xt1o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail

to look at the new patch set (#3).


Change subject: options: warn and ignore --reneg-bytes/pkts when DCO is ena=
bled
......................................................................

options: warn and ignore --reneg-bytes/pkts when DCO is enabled

Thresholds specified by --reneg-bytes and --reneg-pkts cannot be
enforced when DCO is enabled, as it only provides global statistics.

Rather than adding complexity to support these options, ignore them when
DCO is enabled. Print a warning to inform users and update the manpage
accordingly.

Change-Id: I7b718a14b81e3759398e7a52fe151102494cc821
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M doc/man-sections/renegotiation.rst
M src/openvpn/options.c
2 files changed, 23 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1280/3

diff --git a/doc/man-sections/renegotiation.rst b/doc/man-sections/renegoti=
ation.rst
index 1e7c340..f5eb90d 100644
--- a/doc/man-sections/renegotiation.rst
+++ b/doc/man-sections/renegotiation.rst
@@ -19,10 +19,18 @@
   the SWEET32 attack vector. For more information see the ``--cipher``
   option.

+  When data channel offload (DCO) is enabled, this option is ignored. DCO
+  does not support configurable renegotiation thresholds; automatic key
+  renegotiation mechanisms are sufficient for modern ciphers.
+
 --reneg-pkts n
   Renegotiate data channel key after **n** packets sent and received
   (disabled by default).

+  When data channel offload (DCO) is enabled, this option is ignored. DCO
+  does not support configurable renegotiation thresholds; automatic key
+  renegotiation mechanisms are sufficient for modern ciphers.
+
 --reneg-sec args
   Renegotiate data channel key after at most ``max`` seconds
   (default :code:`3600`) and at least ``min`` seconds (default is 90% of
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 44f68c7..65c6b3b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3317,11 +3317,22 @@

     dns_options_verify(M_FATAL, &o->dns_options);

-    if (dco_enabled(o) && o->enable_c2c)
+    if (dco_enabled(o))
     {
-        msg(M_WARN, "Note: --client-to-client has no effect when using dat=
a "
-                    "channel offload: packets are always sent to the VPN "
-                    "interface and then routed based on the system routing=
 table");
+        if (o->enable_c2c)
+        {
+            msg(M_WARN, "Note: --client-to-client has no effect when using=
 data "
+                        "channel offload: packets are always sent to the V=
PN "
+                        "interface and then routed based on the system rou=
ting table");
+        }
+
+        if (o->renegotiate_bytes > 0 || o->renegotiate_packets)
+        {
+            msg(M_WARN, "Note: '--reneg-bytes' and '--reneg-pkts' are not =
supported "
+                        "by data channel offload; automatic key renegotiat=
ion "
+                        "mechanisms are sufficient for modern ciphers. "
+                        "Ignoring these options.");
+        }
     }
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7b718a14b81e3759398e7a52fe151102494cc821
Gerrit-Change-Number: 1280
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Mr0w6o7xt1o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">options: warn and ignore --reneg-bytes/pkts when DC=
O is enabled<br><br>Thresholds specified by --reneg-bytes and --reneg-pkts =
cannot be<br>enforced when DCO is enabled, as it only provides global stati=
stics.<br><br>Rather than adding complexity to support these options, ignor=
e them when<br>DCO is enabled. Print a warning to inform users and update t=
he manpage<br>accordingly.<br><br>Change-Id: I7b718a14b81e3759398e7a52fe151=
102494cc821<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M=
 doc/man-sections/renegotiation.rst<br>M src/openvpn/options.c<br>2 files c=
hanged, 23 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1280/3</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/doc/man-sections/renegotiation.rst b/doc/man-sections/renegotiati=
on.rst</span><br><span>index 1e7c340..f5eb90d 100644</span><br><span>--- a/=
doc/man-sections/renegotiation.rst</span><br><span>+++ b/doc/man-sections/r=
enegotiation.rst</span><br><span>@@ -19,10 +19,18 @@</span><br><span>   the=
 SWEET32 attack vector. For more information see the ``--cipher``</span><br=
><span>   option.</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  When data channel offload (DCO) is enabled, this option i=
s ignored. DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  doe=
s not support configurable renegotiation thresholds; automatic key</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  renegotiation mechanisms a=
re sufficient for modern ciphers.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> --reneg-pkts n</span><br><span>   Renegotia=
te data channel key after **n** packets sent and received</span><br><span> =
  (disabled by default).</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  When data channel offload (DCO) is enabled, this o=
ption is ignored. DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  does not support configurable renegotiation thresholds; automatic key</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  renegotiation mecha=
nisms are sufficient for modern ciphers.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> --reneg-sec args</span><br><span>   =
Renegotiate data channel key after at most ``max`` seconds</span><br><span>=
   (default :code:`3600`) and at least ``min`` seconds (default is 90% of</=
span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</=
span><br><span>index 44f68c7..65c6b3b 100644</span><br><span>--- a/src/open=
vpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@=
@ -3317,11 +3317,22 @@</span><br><span> </span><br><span>     dns_options_v=
erify(M_FATAL, &amp;o-&gt;dns_options);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (dco_enabled(o) &amp;&amp; o-&gt=
;enable_c2c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(dco_enabled(o))</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(M_WARN, &quot;Note: --client-to-client has no=
 effect when using data &quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    &quot;channel offload: packets are always sent=
 to the VPN &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 &quot;interface and then routed based on the system routin=
g table&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (o-&gt;enable_c2c)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_WARN, &quot;Note: --client-to-client has no effect when using=
 data &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 &quot;channel offload: packets are always sent to the VPN =
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           &quot;interface and then routed based on the system routing tabl=
e&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;renegotiate_bytes &gt=
; 0 || o-&gt;renegotiate_packets)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(M_WARN, &quot;Note: &#39;--reneg-bytes&#39; and &#39;--=
reneg-pkts&#39; are not supported &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        &quot;by data channel offload;=
 automatic key renegotiation &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        &quot;mechanisms are sufficient for=
 modern ciphers. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        &quot;Ignoring these options.&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1280?usp=
=3Demail">change 1280</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7b718a14b81e3759398e7a52fe1=
51102494cc821 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1280 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
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

</body></html>=

--Mr0w6o7xt1o=--

