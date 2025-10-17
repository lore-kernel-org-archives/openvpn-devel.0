From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 17 Oct 2025 19:30:28 +0000
In-Reply-To: <gerrit.1760629750000.I7b718a14b81e3759398e7a52fe151102494cc821@...2715...>
References: <gerrit.1760629750000.I7b718a14b81e3759398e7a52fe151102494cc821@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <a822fad86d8bf4d76a1d7ac132b7462af84ea60a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ChmSV6fSEhE="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ChmSV6fSEhE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1280/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ChmSV6fSEhE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by ralf_lici.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">options: warn and ignore --reneg-by=
tes/pkts when DCO is enabled<br><br>Thresholds specified by --reneg-bytes a=
nd --reneg-pkts cannot be<br>enforced when DCO is enabled, as it only provi=
des global statistics.<br><br>Rather than adding complexity to support thes=
e options, ignore them when<br>DCO is enabled. Print a warning to inform us=
ers and update the manpage<br>accordingly.<br><br>Change-Id: I7b718a14b81e3=
759398e7a52fe151102494cc821<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...=
&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https=
://gerrit.openvpn.net/c/openvpn/+/1280<br>Message-Id: &lt;20251017191612.15=
642-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman=
/message/59248122/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M doc/man-sections/renegotiation.rst<br>M src/openvpn/options.c<br=
>2 files changed, 23 insertions(+), 4 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1280/4<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/doc/man-sections/renegotiation.rst b/doc/man-sections/=
renegotiation.rst</span><br><span>index 1e7c340..f5eb90d 100644</span><br><=
span>--- a/doc/man-sections/renegotiation.rst</span><br><span>+++ b/doc/man=
-sections/renegotiation.rst</span><br><span>@@ -19,10 +19,18 @@</span><br><=
span>   the SWEET32 attack vector. For more information see the ``--cipher`=
`</span><br><span>   option.</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  When data channel offload (DCO) is enabled, th=
is option is ignored. DCO</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  does not support configurable renegotiation thresholds; automatic k=
ey</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  renegotiation m=
echanisms are sufficient for modern ciphers.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> --reneg-pkts n</span><br><span> =
  Renegotiate data channel key after **n** packets sent and received</span>=
<br><span>   (disabled by default).</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  When data channel offload (DCO) is enab=
led, this option is ignored. DCO</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  does not support configurable renegotiation thresholds; auto=
matic key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  renegoti=
ation mechanisms are sufficient for modern ciphers.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --reneg-sec args</span>=
<br><span>   Renegotiate data channel key after at most ``max`` seconds</sp=
an><br><span>   (default :code:`3600`) and at least ``min`` seconds (defaul=
t is 90% of</span><br><span>diff --git a/src/openvpn/options.c b/src/openvp=
n/options.c</span><br><span>index 44f68c7..65c6b3b 100644</span><br><span>-=
-- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</spa=
n><br><span>@@ -3317,11 +3317,22 @@</span><br><span> </span><br><span>     =
dns_options_verify(M_FATAL, &amp;o-&gt;dns_options);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco_enabled(o) &am=
p;&amp; o-&gt;enable_c2c)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (dco_enabled(o))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Note: --client-to=
-client has no effect when using data &quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    &quot;channel offload: packets a=
re always sent to the VPN &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    &quot;interface and then routed based on the=
 system routing table&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (o-&gt;enable_c2c)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(M_WARN, &quot;Note: --client-to-client has no eff=
ect when using data &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        &quot;channel offload: packets are always se=
nt to the VPN &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        &quot;interface and then routed based on the syste=
m routing table&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;renegot=
iate_bytes &gt; 0 || o-&gt;renegotiate_packets)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(M_WARN, &quot;Note: &#39;--reneg-bytes&#3=
9; and &#39;--reneg-pkts&#39; are not supported &quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        &quot;by data ch=
annel offload; automatic key renegotiation &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        &quot;mechanisms are =
sufficient for modern ciphers. &quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        &quot;Ignoring these options.&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1280?usp=3Demail">change 1280</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1280?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--ChmSV6fSEhE=--

