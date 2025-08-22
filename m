From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 22 Aug 2025 15:51:59 +0000
References: <gerrit.1755877911000.I5e240c35cd4236e1d845195e4634fd5008f61814@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7b58f3a5058bdb42ddf052cdf2671dce5478e874-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZlkOefkJ1mA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZlkOefkJ1mA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1152?usp=3Demail

to review the following change.


Change subject: Clean up documentation for --tun-mtu-max
......................................................................

Clean up documentation for --tun-mtu-max

There was some confusion about how the option
was called...

Change-Id: I5e240c35cd4236e1d845195e4634fd5008f61814
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/vpn-network-options.rst
M src/openvpn/init.c
M src/openvpn/mtu.h
M src/openvpn/options.c
M src/openvpn/push.c
5 files changed, 13 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/1152/1

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
=20
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--ZlkOefkJ1mA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1152?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Clean up documentation for --tun-mtu-max<br><br>There was so=
me confusion about how the option<br>was called...<br><br>Change-Id: I5e240=
c35cd4236e1d845195e4634fd5008f61814<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>---<br>M doc/man-sections/vpn-network-options.rst<=
br>M src/openvpn/init.c<br>M src/openvpn/mtu.h<br>M src/openvpn/options.c<b=
r>M src/openvpn/push.c<br>5 files changed, 13 insertions(+), 6 deletions(-)=
<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/=
1152/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/doc/man-sections/vpn-network-options.rst b/doc/=
man-sections/vpn-network-options.rst</span><br><span>index 4a64e8d..2a06ef6=
 100644</span><br><span>--- a/doc/man-sections/vpn-network-options.rst</spa=
n><br><span>+++ b/doc/man-sections/vpn-network-options.rst</span><br><span>=
@@ -587,7 +587,7 @@</span><br><span>   packets larger than ``tun-mtu`` (e.g=
. Linux and FreeBSD) but other platforms</span><br><span>   (like macOS) li=
mit received packets to the same size as the MTU.</span><br><span> </span><=
br><span>---tun-max-mtu maxmtu</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+--tun-mtu-max maxmtu</span><br><span>   This configures the maxi=
mum MTU size that a server can push to ``maxmtu``,</span><br><span>   by co=
nfiguring the internal buffers to allow at least this packet size.</span><b=
r><span>   The default for ``maxmtu`` is 1600. Currently, only increasing b=
eyond 1600</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/in=
it.c</span><br><span>index 5583274..9dd3b96 100644</span><br><span>--- a/sr=
c/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@=
@ -2916,7 +2916,7 @@</span><br><span> </span><br><span>     /* We always al=
low at least 1600 MTU packets to be received in our buffer</span><br><span>=
      * space to allow server to push &quot;baby giant&quot; MTU sizes */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    frame-&gt;tun_max_m=
tu =3D max_int(1600, frame-&gt;tun_max_mtu);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    frame-&gt;tun_max_mtu =3D max_int(TUN_MTU_MAX_=
MIN, frame-&gt;tun_max_mtu);</span><br><span> </span><br><span>     size_t =
payload_size =3D frame-&gt;tun_max_mtu;</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h</span><br><span>index 925=
ef0b..c092461 100644</span><br><span>--- a/src/openvpn/mtu.h</span><br><spa=
n>+++ b/src/openvpn/mtu.h</span><br><span>@@ -69,6 +69,11 @@</span><br><spa=
n> #define TUN_MTU_DEFAULT 1500</span><br><span> </span><br><span> /*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Minimum maximum MTU</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define TUN_MTU_MAX_MIN 1600</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/*</span><br><span>  * MTU Defaults for TAP devi=
ces</span><br><span>  */</span><br><span> #define TAP_MTU_EXTRA_DEFAULT 32<=
/span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c<=
/span><br><span>index e9584a8..0b16c5a 100644</span><br><span>--- a/src/ope=
nvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>=
@@ -297,6 +297,7 @@</span><br><span>     &quot;--tun-mtu-extra n : Assume t=
hat tun/tap device might return as many\n&quot;</span><br><span>     &quot;=
                  as n bytes more than the tun-mtu size on read\n&quot;</sp=
an><br><span>     &quot;                  (default TUN=3D0 TAP=3D%d).\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--tun-m=
tu-max n : Maximum pushable MTU (default and minimum=3D%d).\n&quot;</span><=
br><span>     &quot;--link-mtu n    : Take the TCP/UDP device MTU to be n a=
nd derive the tun MTU\n&quot;</span><br><span>     &quot;                  =
from it.\n&quot;</span><br><span>     &quot;--mtu-disc type : Should we do =
Path MTU discovery on TCP/UDP channel?\n&quot;</span><br><span>@@ -4844,8 +=
4845,9 @@</span><br><span> </span><br><span>     fprintf(fp, usage_message,=
 title_string, o.ce.connect_retry_seconds,</span><br><span>             o.c=
e.connect_retry_seconds_max, o.ce.local_port, o.ce.remote_port, TUN_MTU_DEF=
AULT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            TAP_=
MTU_EXTRA_DEFAULT, o.verbosity, o.authname, o.replay_window, o.replay_time,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o.tls_tim=
eout, o.renegotiate_seconds, o.handshake_window, o.transition_window);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            TAP_MTU_EXTR=
A_DEFAULT, TUN_MTU_MAX_MIN, o.verbosity, o.authname, o.replay_window,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            o.replay_time=
, o.tls_timeout, o.renegotiate_seconds, o.handshake_window,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            o.transition_window);</=
span><br><span>     fflush(fp);</span><br><span> </span><br><span> #endif  =
                                     /* ENABLE_SMALL */</span><br><span>@@ =
-7011,7 +7013,7 @@</span><br><span>             options-&gt;ce.occ_mtu =3D =
0;</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;tun-mtu-max&=
quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else if (streq(p[0], &quot;tun-mtu-max&quot;) &amp=
;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>      =
   VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);</span><br><span>       =
  int max_mtu =3D positive_atoi(p[1], msglevel);</span><br><span>diff --git=
 a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index 889b268..4=
f6adfc 100644</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ =
b/src/openvpn/push.c</span><br><span>@@ -721,7 +721,7 @@</span><br><span>  =
       {</span><br><span>             msg(M_WARN,</span><br><span>         =
        &quot;Warning: reported maximum MTU from client (%d) is lower &quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quo=
t;than MTU used on the server (%d). Add tun-max-mtu %d &quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                &quot;than MTU us=
ed on the server (%d). Add tun-mtu-max %d &quot;</span><br><span>          =
       &quot;to client configuration.&quot;,</span><br><span>              =
   client_max_mtu, o-&gt;ce.tun_mtu, o-&gt;ce.tun_mtu);</span><br><span>   =
      }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1152?usp=3Demail">change 1152</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1152?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5e240c35cd4236e1d845195e463=
4fd5008f61814 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1152 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--ZlkOefkJ1mA=--

