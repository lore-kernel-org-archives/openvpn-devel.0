From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 17 Oct 2025 07:48:10 +0000
In-Reply-To: <gerrit.1760629750000.I7b718a14b81e3759398e7a52fe151102494cc821@...2715...>
References: <gerrit.1760629750000.I7b718a14b81e3759398e7a52fe151102494cc821@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e8c8b813ac0cd88887dedf5d6e4c09d8e5466c74-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2dYkkPJWlrs="; charset=UTF-8
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

--2dYkkPJWlrs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail

to look at the new patch set (#2).


Change subject: options: warn and ignore --reneg-bytes/pkts when DCO is ena=
bled
......................................................................

options: warn and ignore --reneg-bytes/pkts when DCO is enabled

The --reneg-bytes and --reneg-pkts options rely on per-key counters to
trigger key renegotiation. DCO, however, only provides global
statistics, making it incompatible with these options.

Rather than adding complexity to support legacy behavior, ignore these
options when DCO is enabled. Print a warning to inform users and update
the manpage accordingly.

Change-Id: I7b718a14b81e3759398e7a52fe151102494cc821
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M doc/man-sections/renegotiation.rst
M src/openvpn/options.c
2 files changed, 22 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1280/2

diff --git a/doc/man-sections/renegotiation.rst b/doc/man-sections/renegoti=
ation.rst
index 1e7c340..c689c6f 100644
--- a/doc/man-sections/renegotiation.rst
+++ b/doc/man-sections/renegotiation.rst
@@ -19,10 +19,18 @@
   the SWEET32 attack vector. For more information see the ``--cipher``
   option.

+  When data channel offload (DCO) is enabled, this option is ignored. DCO
+  does not support per-key renegotiation thresholds; automatic key
+  renegotiation mechanisms are preferred.
+
 --reneg-pkts n
   Renegotiate data channel key after **n** packets sent and received
   (disabled by default).

+  When data channel offload (DCO) is enabled, this option is ignored. DCO
+  does not support per-key renegotiation thresholds; automatic key
+  renegotiation mechanisms are preferred.
+
 --reneg-sec args
   Renegotiate data channel key after at most ``max`` seconds
   (default :code:`3600`) and at least ``min`` seconds (default is 90% of
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 44f68c7..58c7760 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3317,11 +3317,21 @@

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
+                        "mechanisms are preferred. Ignoring these options.=
");
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
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--2dYkkPJWlrs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">options: warn and ignore --reneg-bytes/pkts when DC=
O is enabled<br><br>The --reneg-bytes and --reneg-pkts options rely on per-=
key counters to<br>trigger key renegotiation. DCO, however, only provides g=
lobal<br>statistics, making it incompatible with these options.<br><br>Rath=
er than adding complexity to support legacy behavior, ignore these<br>optio=
ns when DCO is enabled. Print a warning to inform users and update<br>the m=
anpage accordingly.<br><br>Change-Id: I7b718a14b81e3759398e7a52fe151102494c=
c821<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M doc/ma=
n-sections/renegotiation.rst<br>M src/openvpn/options.c<br>2 files changed,=
 22 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/80/1280/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/doc/man-sections/renegotiation.rst b/doc/man-sections/renegotiation.r=
st</span><br><span>index 1e7c340..c689c6f 100644</span><br><span>--- a/doc/=
man-sections/renegotiation.rst</span><br><span>+++ b/doc/man-sections/reneg=
otiation.rst</span><br><span>@@ -19,10 +19,18 @@</span><br><span>   the SWE=
ET32 attack vector. For more information see the ``--cipher``</span><br><sp=
an>   option.</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  When data channel offload (DCO) is enabled, this option is ig=
nored. DCO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  does no=
t support per-key renegotiation thresholds; automatic key</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  renegotiation mechanisms are prefer=
red.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> --reneg-pkts n</span><br><span>   Renegotiate data channel key after **n=
** packets sent and received</span><br><span>   (disabled by default).</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  When=
 data channel offload (DCO) is enabled, this option is ignored. DCO</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  does not support per-key =
renegotiation thresholds; automatic key</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  renegotiation mechanisms are preferred.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --reneg-sec arg=
s</span><br><span>   Renegotiate data channel key after at most ``max`` sec=
onds</span><br><span>   (default :code:`3600`) and at least ``min`` seconds=
 (default is 90% of</span><br><span>diff --git a/src/openvpn/options.c b/sr=
c/openvpn/options.c</span><br><span>index 44f68c7..58c7760 100644</span><br=
><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/option=
s.c</span><br><span>@@ -3317,11 +3317,21 @@</span><br><span> </span><br><sp=
an>     dns_options_verify(M_FATAL, &amp;o-&gt;dns_options);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco_enable=
d(o) &amp;&amp; o-&gt;enable_c2c)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (dco_enabled(o))</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Note: --cl=
ient-to-client has no effect when using data &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &quot;channel offload: =
packets are always sent to the VPN &quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    &quot;interface and then routed bas=
ed on the system routing table&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (o-&gt;enable_c2c)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(M_WARN, &quot;Note: --client-to-client h=
as no effect when using data &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        &quot;channel offload: packets are =
always sent to the VPN &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        &quot;interface and then routed based on =
the system routing table&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&g=
t;renegotiate_bytes &gt; 0 || o-&gt;renegotiate_packets)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;Note: &#39;--reneg=
-bytes&#39; and &#39;--reneg-pkts&#39; are not supported &quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        &quot;b=
y data channel offload; automatic key renegotiation &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        &quot;mechan=
isms are preferred. Ignoring these options.&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail">cha=
nge 1280</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1280?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7b718a14b81e3759398e7a52fe1=
51102494cc821 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1280 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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

--2dYkkPJWlrs=--

