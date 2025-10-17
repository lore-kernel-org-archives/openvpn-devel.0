From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 17 Oct 2025 19:30:31 +0000
In-Reply-To: <gerrit.1760629750000.I7b718a14b81e3759398e7a52fe151102494cc821@...2715...>
References: <gerrit.1760629750000.I7b718a14b81e3759398e7a52fe151102494cc821@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <a822fad86d8bf4d76a1d7ac132b7462af84ea60a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Rtli/egRl4k="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Rtli/egRl4k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
80?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1280
Message-Id: <20251017191612.15642-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59248122/
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/renegotiation.rst
M src/openvpn/options.c
2 files changed, 23 insertions(+), 4 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7b718a14b81e3759398e7a52fe151102494cc821
Gerrit-Change-Number: 1280
Gerrit-PatchSet: 4
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Rtli/egRl4k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1280?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">options: warn and ignore --reneg-bytes/pkts when=
 DCO is enabled<br><br>Thresholds specified by --reneg-bytes and --reneg-pk=
ts cannot be<br>enforced when DCO is enabled, as it only provides global st=
atistics.<br><br>Rather than adding complexity to support these options, ig=
nore them when<br>DCO is enabled. Print a warning to inform users and updat=
e the manpage<br>accordingly.<br><br>Change-Id: I7b718a14b81e3759398e7a52fe=
151102494cc821<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>Acked=
-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.ope=
nvpn.net/c/openvpn/+/1280<br>Message-Id: &lt;20251017191612.15642-1-gert@...1186...=
.1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/5924=
8122/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M do=
c/man-sections/renegotiation.rst<br>M src/openvpn/options.c<br>2 files chan=
ged, 23 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/renegotiation.rst b/doc/man-sections/reneg=
otiation.rst</span><br><span>index 1e7c340..f5eb90d 100644</span><br><span>=
--- a/doc/man-sections/renegotiation.rst</span><br><span>+++ b/doc/man-sect=
ions/renegotiation.rst</span><br><span>@@ -19,10 +19,18 @@</span><br><span>=
   the SWEET32 attack vector. For more information see the ``--cipher``</sp=
an><br><span>   option.</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  When data channel offload (DCO) is enabled, this op=
tion is ignored. DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  does not support configurable renegotiation thresholds; automatic key</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  renegotiation mechan=
isms are sufficient for modern ciphers.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> --reneg-pkts n</span><br><span>   Ren=
egotiate data channel key after **n** packets sent and received</span><br><=
span>   (disabled by default).</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  When data channel offload (DCO) is enabled, =
this option is ignored. DCO</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  does not support configurable renegotiation thresholds; automatic=
 key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  renegotiation=
 mechanisms are sufficient for modern ciphers.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> --reneg-sec args</span><br><sp=
an>   Renegotiate data channel key after at most ``max`` seconds</span><br>=
<span>   (default :code:`3600`) and at least ``min`` seconds (default is 90=
% of</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/optio=
ns.c</span><br><span>index 44f68c7..65c6b3b 100644</span><br><span>--- a/sr=
c/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><=
span>@@ -3317,11 +3317,22 @@</span><br><span> </span><br><span>     dns_opt=
ions_verify(M_FATAL, &amp;o-&gt;dns_options);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (dco_enabled(o) &amp;&amp;=
 o-&gt;enable_c2c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (dco_enabled(o))</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Note: --client-to-client =
has no effect when using data &quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    &quot;channel offload: packets are alway=
s sent to the VPN &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    &quot;interface and then routed based on the system =
routing table&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (o-&gt;enable_c2c)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(M_WARN, &quot;Note: --client-to-client has no effect when=
 using data &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       &quot;channel offload: packets are always sent to th=
e VPN &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 &quot;interface and then routed based on the system routin=
g table&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;renegotiate_byt=
es &gt; 0 || o-&gt;renegotiate_packets)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(M_WARN, &quot;Note: &#39;--reneg-bytes&#39; and &=
#39;--reneg-pkts&#39; are not supported &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        &quot;by data channel of=
fload; automatic key renegotiation &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        &quot;mechanisms are sufficie=
nt for modern ciphers. &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        &quot;Ignoring these options.&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/128=
0?usp=3Demail">change 1280</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1280?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7b718a14b81e3759398e7a52fe1=
51102494cc821 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1280 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Rtli/egRl4k=--

