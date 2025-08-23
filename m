From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 23 Aug 2025 15:43:34 +0000
In-Reply-To: <gerrit.1755877911000.I5e240c35cd4236e1d845195e4634fd5008f61814@...2715...>
References: <gerrit.1755877911000.I5e240c35cd4236e1d845195e4634fd5008f61814@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <aac62c636519d59c9d499811b06c48bd2557b0d9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JGTyMdHknKc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Clean up
 documentation for --tun-mtu-max
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JGTyMdHknKc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
52?usp=3Demail )

Change subject: Clean up documentation for --tun-mtu-max
......................................................................

Clean up documentation for --tun-mtu-max

There was some confusion about how the option
was called...

Change-Id: I5e240c35cd4236e1d845195e4634fd5008f61814
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250823153652.30938-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
663.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/vpn-network-options.rst
M src/openvpn/init.c
M src/openvpn/mtu.h
M src/openvpn/options.c
M src/openvpn/push.c
5 files changed, 13 insertions(+), 6 deletions(-)




diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 4a64e8d..2a06ef6 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -587,7 +587,7 @@
   packets larger than ``tun-mtu`` (e.g. Linux and FreeBSD) but other platf=
orms
   (like macOS) limit received packets to the same size as the MTU.

---tun-max-mtu maxmtu
+--tun-mtu-max maxmtu
   This configures the maximum MTU size that a server can push to ``maxmtu`=
`,
   by configuring the internal buffers to allow at least this packet size.
   The default for ``maxmtu`` is 1600. Currently, only increasing beyond 16=
00
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5583274..9dd3b96 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2916,7 +2916,7 @@

     /* We always allow at least 1600 MTU packets to be received in our buf=
fer
      * space to allow server to push "baby giant" MTU sizes */
-    frame->tun_max_mtu =3D max_int(1600, frame->tun_max_mtu);
+    frame->tun_max_mtu =3D max_int(TUN_MTU_MAX_MIN, frame->tun_max_mtu);

     size_t payload_size =3D frame->tun_max_mtu;

diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 925ef0b..c092461 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -69,6 +69,11 @@
 #define TUN_MTU_DEFAULT 1500

 /*
+ * Minimum maximum MTU
+ */
+#define TUN_MTU_MAX_MIN 1600
+
+/*
  * MTU Defaults for TAP devices
  */
 #define TAP_MTU_EXTRA_DEFAULT 32
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e9584a8..0b16c5a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -297,6 +297,7 @@
     "--tun-mtu-extra n : Assume that tun/tap device might return as many\n"
     "                  as n bytes more than the tun-mtu size on read\n"
     "                  (default TUN=3D0 TAP=3D%d).\n"
+    "--tun-mtu-max n : Maximum pushable MTU (default and minimum=3D%d).\n"
     "--link-mtu n    : Take the TCP/UDP device MTU to be n and derive the =
tun MTU\n"
     "                  from it.\n"
     "--mtu-disc type : Should we do Path MTU discovery on TCP/UDP channel?=
\n"
@@ -4844,8 +4845,9 @@

     fprintf(fp, usage_message, title_string, o.ce.connect_retry_seconds,
             o.ce.connect_retry_seconds_max, o.ce.local_port, o.ce.remote_p=
ort, TUN_MTU_DEFAULT,
-            TAP_MTU_EXTRA_DEFAULT, o.verbosity, o.authname, o.replay_windo=
w, o.replay_time,
-            o.tls_timeout, o.renegotiate_seconds, o.handshake_window, o.tr=
ansition_window);
+            TAP_MTU_EXTRA_DEFAULT, TUN_MTU_MAX_MIN, o.verbosity, o.authnam=
e, o.replay_window,
+            o.replay_time, o.tls_timeout, o.renegotiate_seconds, o.handsha=
ke_window,
+            o.transition_window);
     fflush(fp);

 #endif                                       /* ENABLE_SMALL */
@@ -7011,7 +7013,7 @@
             options->ce.occ_mtu =3D 0;
         }
     }
-    else if (streq(p[0], "tun-mtu-max") && p[1] && !p[3])
+    else if (streq(p[0], "tun-mtu-max") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
         int max_mtu =3D positive_atoi(p[1], msglevel);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 889b268..4f6adfc 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -721,7 +721,7 @@
         {
             msg(M_WARN,
                 "Warning: reported maximum MTU from client (%d) is lower "
-                "than MTU used on the server (%d). Add tun-max-mtu %d "
+                "than MTU used on the server (%d). Add tun-mtu-max %d "
                 "to client configuration.",
                 client_max_mtu, o->ce.tun_mtu, o->ce.tun_mtu);
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1152?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5e240c35cd4236e1d845195e4634fd5008f61814
Gerrit-Change-Number: 1152
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--JGTyMdHknKc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1152?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Clean up documentation for --tun-mtu-max<br><=
br>There was some confusion about how the option<br>was called...<br><br>Ch=
ange-Id: I5e240c35cd4236e1d845195e4634fd5008f61814<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>Message-Id: &lt;20250823153652.30938-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
32663.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M doc/man-sections/vpn-network-options.rst<br>M src/openvpn/init.c<br>M sr=
c/openvpn/mtu.h<br>M src/openvpn/options.c<br>M src/openvpn/push.c<br>5 fil=
es changed, 13 insertions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections=
/vpn-network-options.rst</span><br><span>index 4a64e8d..2a06ef6 100644</spa=
n><br><span>--- a/doc/man-sections/vpn-network-options.rst</span><br><span>=
+++ b/doc/man-sections/vpn-network-options.rst</span><br><span>@@ -587,7 +5=
87,7 @@</span><br><span>   packets larger than ``tun-mtu`` (e.g. Linux and =
FreeBSD) but other platforms</span><br><span>   (like macOS) limit received=
 packets to the same size as the MTU.</span><br><span> </span><br><span>---=
tun-max-mtu maxmtu</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-=
-tun-mtu-max maxmtu</span><br><span>   This configures the maximum MTU size=
 that a server can push to ``maxmtu``,</span><br><span>   by configuring th=
e internal buffers to allow at least this packet size.</span><br><span>   T=
he default for ``maxmtu`` is 1600. Currently, only increasing beyond 1600</=
span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><=
br><span>index 5583274..9dd3b96 100644</span><br><span>--- a/src/openvpn/in=
it.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2916,7 +2=
916,7 @@</span><br><span> </span><br><span>     /* We always allow at least=
 1600 MTU packets to be received in our buffer</span><br><span>      * spac=
e to allow server to push &quot;baby giant&quot; MTU sizes */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    frame-&gt;tun_max_mtu =3D max_i=
nt(1600, frame-&gt;tun_max_mtu);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    frame-&gt;tun_max_mtu =3D max_int(TUN_MTU_MAX_MIN, frame-&=
gt;tun_max_mtu);</span><br><span> </span><br><span>     size_t payload_size=
 =3D frame-&gt;tun_max_mtu;</span><br><span> </span><br><span>diff --git a/=
src/openvpn/mtu.h b/src/openvpn/mtu.h</span><br><span>index 925ef0b..c09246=
1 100644</span><br><span>--- a/src/openvpn/mtu.h</span><br><span>+++ b/src/=
openvpn/mtu.h</span><br><span>@@ -69,6 +69,11 @@</span><br><span> #define T=
UN_MTU_DEFAULT 1500</span><br><span> </span><br><span> /*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Minimum maximum MTU</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define TUN_MTU_MAX_MIN 1600</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span>  * MTU Defaults for TAP devices</span><b=
r><span>  */</span><br><span> #define TAP_MTU_EXTRA_DEFAULT 32</span><br><s=
pan>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><s=
pan>index e9584a8..0b16c5a 100644</span><br><span>--- a/src/openvpn/options=
.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -297,6 +2=
97,7 @@</span><br><span>     &quot;--tun-mtu-extra n : Assume that tun/tap =
device might return as many\n&quot;</span><br><span>     &quot;            =
      as n bytes more than the tun-mtu size on read\n&quot;</span><br><span=
>     &quot;                  (default TUN=3D0 TAP=3D%d).\n&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--tun-mtu-max n : M=
aximum pushable MTU (default and minimum=3D%d).\n&quot;</span><br><span>   =
  &quot;--link-mtu n    : Take the TCP/UDP device MTU to be n and derive th=
e tun MTU\n&quot;</span><br><span>     &quot;                  from it.\n&q=
uot;</span><br><span>     &quot;--mtu-disc type : Should we do Path MTU dis=
covery on TCP/UDP channel?\n&quot;</span><br><span>@@ -4844,8 +4845,9 @@</s=
pan><br><span> </span><br><span>     fprintf(fp, usage_message, title_strin=
g, o.ce.connect_retry_seconds,</span><br><span>             o.ce.connect_re=
try_seconds_max, o.ce.local_port, o.ce.remote_port, TUN_MTU_DEFAULT,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            TAP_MTU_EXTRA_DE=
FAULT, o.verbosity, o.authname, o.replay_window, o.replay_time,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            o.tls_timeout, o.rene=
gotiate_seconds, o.handshake_window, o.transition_window);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            TAP_MTU_EXTRA_DEFAULT, T=
UN_MTU_MAX_MIN, o.verbosity, o.authname, o.replay_window,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            o.replay_time, o.tls_time=
out, o.renegotiate_seconds, o.handshake_window,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            o.transition_window);</span><br><sp=
an>     fflush(fp);</span><br><span> </span><br><span> #endif              =
                         /* ENABLE_SMALL */</span><br><span>@@ -7011,7 +701=
3,7 @@</span><br><span>             options-&gt;ce.occ_mtu =3D 0;</span><br=
><span>         }</span><br><span>     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    else if (streq(p[0], &quot;tun-mtu-max&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    else if (streq(p[0], &quot;tun-mtu-max&quot;) &amp;&amp; p[1] &=
amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PER=
MISSION(OPT_P_MTU | OPT_P_CONNECTION);</span><br><span>         int max_mtu=
 =3D positive_atoi(p[1], msglevel);</span><br><span>diff --git a/src/openvp=
n/push.c b/src/openvpn/push.c</span><br><span>index 889b268..4f6adfc 100644=
</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn=
/push.c</span><br><span>@@ -721,7 +721,7 @@</span><br><span>         {</spa=
n><br><span>             msg(M_WARN,</span><br><span>                 &quot=
;Warning: reported maximum MTU from client (%d) is lower &quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                &quot;than MTU us=
ed on the server (%d). Add tun-max-mtu %d &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                &quot;than MTU used on the ser=
ver (%d). Add tun-mtu-max %d &quot;</span><br><span>                 &quot;=
to client configuration.&quot;,</span><br><span>                 client_max=
_mtu, o-&gt;ce.tun_mtu, o-&gt;ce.tun_mtu);</span><br><span>         }</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1152?usp=3Demail">change 1152</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1152?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5e240c35cd4236e1d845195e463=
4fd5008f61814 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1152 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--JGTyMdHknKc=--

