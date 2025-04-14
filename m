From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 14 Apr 2025 18:05:27 +0000
In-Reply-To: <gerrit.1744182251000.I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c@...2715...>
References: <gerrit.1744182251000.I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <5a1600084b608d47667b2084fed6dc9c75e646b0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u4vxPTCv+/w="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix dco_win and
 multisocket interaction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--u4vxPTCv+/w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/93=
5?usp=3Demail )

Change subject: Fix dco_win and multisocket interaction
......................................................................

Fix dco_win and multisocket interaction

The recent introduction of the multisocket support
did not account for some Windows-specific DCO paths.
This patch restores correct behavior on Windows.

Key changes:

 - Add WIN32 guards around DCO-specifc code.
 - Disable wait_signal() when running in
   server mode, as it conflicts with the
   event engine since Windows handles
   signals as I/Os.
 - Ensure correct socket handling for TCP
   vs UDP.

Github: closes openvpn/OpenVPN#720

Change-Id: I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20250410215037.11878-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
419.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
M src/openvpn/mtcp.c
M src/openvpn/multi_io.c
3 files changed, 13 insertions(+), 7 deletions(-)




diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index af1d008..0b8b262 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2072,7 +2072,7 @@
     /*
      * Calculate the flags based on the provided 'flags' argument.
      */
-    if (flags & IOW_WAIT_SIGNAL)
+    if ((c->options.mode !=3D MODE_SERVER) && (flags & IOW_WAIT_SIGNAL))
     {
         wait_signal(es, (void *)err_shift);
     }
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 1d62ea6..86c5160 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -181,7 +181,8 @@

     if (mi)
     {
-        if (defer || mbuf_defined(mi->tcp_link_out_deferred))
+        if ((defer && !proto_is_dgram(mi->context.c2.link_sockets[0]->info=
.proto))
+            || mbuf_defined(mi->tcp_link_out_deferred))
         {
             /* save to queue */
             struct buffer *buf =3D &mi->context.c2.to_link;
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index f1751ff..f4ca4df 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -176,10 +176,13 @@
     int status, i;
     unsigned int *persistent =3D &m->multi_io->tun_rwflags;

-    for (i =3D 0; i < m->top.c1.link_sockets_num; i++)
+    if (!tuntap_is_dco_win(m->top.c1.tuntap))
     {
-        socket_set_listen_persistent(m->top.c2.link_sockets[i], m->multi_i=
o->es,
-                                     &m->top.c2.link_sockets[i]->ev_arg);
+        for (i =3D 0; i < m->top.c1.link_sockets_num; i++)
+        {
+            socket_set_listen_persistent(m->top.c2.link_sockets[i], m->mul=
ti_io->es,
+                                         &m->top.c2.link_sockets[i]->ev_ar=
g);
+        }
     }

     if (has_udp_in_local_list(&m->top.options))
@@ -202,7 +205,8 @@
     }
 #endif
     tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, p=
ersistent);
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(ENABLE_DCO) \
+    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET=
_WIN32))
     dco_event_set(&m->top.c1.tuntap->dco, m->multi_io->es, MULTI_IO_DCO);
 #endif

@@ -535,7 +539,8 @@
                     multi_io_action(m, mi, TA_INITIAL, false);
                 }
             }
-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
+#if defined(ENABLE_DCO) \
+            && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || define=
d(TARGET_WIN32))
             /* incoming data on DCO? */
             else if (e->arg =3D=3D MULTI_IO_DCO)
             {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/935?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c
Gerrit-Change-Number: 935
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--u4vxPTCv+/w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/935?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix dco_win and multisocket interaction<br><br=
>The recent introduction of the multisocket support<br>did not account for =
some Windows-specific DCO paths.<br>This patch restores correct behavior on=
 Windows.<br><br>Key changes:<br><br> - Add WIN32 guards around DCO-specifc=
 code.<br> - Disable wait_signal() when running in<br>   server mode, as it=
 conflicts with the<br>   event engine since Windows handles<br>   signals =
as I/Os.<br> - Ensure correct socket handling for TCP<br>   vs UDP.<br><br>=
Github: closes openvpn/OpenVPN#720<br><br>Change-Id: I719b1aa2d2f4d63dc9c18=
d8e313fba339e3e4b0c<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...1186...=
.2726...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Messa=
ge-Id: &lt;20250410215037.11878-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg31419.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/forwa=
rd.c<br>M src/openvpn/mtcp.c<br>M src/openvpn/multi_io.c<br>3 files changed=
, 13 insertions(+), 7 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><sp=
an>index af1d008..0b8b262 100644</span><br><span>--- a/src/openvpn/forward.=
c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -2072,7 +2=
072,7 @@</span><br><span>     /*</span><br><span>      * Calculate the flag=
s based on the provided &#39;flags&#39; argument.</span><br><span>      */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (flags &amp; IO=
W_WAIT_SIGNAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f ((c-&gt;options.mode !=3D MODE_SERVER) &amp;&amp; (flags &amp; IOW_WAIT_S=
IGNAL))</span><br><span>     {</span><br><span>         wait_signal(es, (vo=
id *)err_shift);</span><br><span>     }</span><br><span>diff --git a/src/op=
envpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 1d62ea6..86c5160 10=
0644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/ope=
nvpn/mtcp.c</span><br><span>@@ -181,7 +181,8 @@</span><br><span> </span><br=
><span>     if (mi)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (defer || mbuf_defined(mi-&gt;tcp_link_out_=
deferred))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f ((defer &amp;&amp; !proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;=
info.proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     || mbuf_defined(mi-&gt;tcp_link_out_deferred))</span><br><span>       =
  {</span><br><span>             /* save to queue */</span><br><span>      =
       struct buffer *buf =3D &amp;mi-&gt;context.c2.to_link;</span><br><sp=
an>diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c</span><br><=
span>index f1751ff..f4ca4df 100644</span><br><span>--- a/src/openvpn/multi_=
io.c</span><br><span>+++ b/src/openvpn/multi_io.c</span><br><span>@@ -176,1=
0 +176,13 @@</span><br><span>     int status, i;</span><br><span>     unsig=
ned int *persistent =3D &amp;m-&gt;multi_io-&gt;tun_rwflags;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; =
i &lt; m-&gt;top.c1.link_sockets_num; i++)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!tuntap_is_dco_win(m-&gt;top.c1.tuntap))</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      socket_set_listen_persistent(m-&gt;top.c2.link_sockets[i], m-&gt;mult=
i_io-&gt;es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                            &amp;m-&gt;top.c2.link_sockets[i]-&gt;ev_arg);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0=
; i &lt; m-&gt;top.c1.link_sockets_num; i++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            socket_set_listen_persistent(m-&gt;top.c2.link_s=
ockets[i], m-&gt;multi_io-&gt;es,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                         &amp;m-&gt;top.c2.li=
nk_sockets[i]-&gt;ev_arg);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span>     }</span><br><span> </span><br><span> =
    if (has_udp_in_local_list(&amp;m-&gt;top.options))</span><br><span>@@ -=
202,7 +205,8 @@</span><br><span>     }</span><br><span> #endif</span><br><s=
pan>     tun_set(m-&gt;top.c1.tuntap, m-&gt;multi_io-&gt;es, EVENT_READ, MU=
LTI_IO_TUN, persistent);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO) \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &amp;&amp; (defined(TARGET_LI=
NUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))</span><br><span> =
    dco_event_set(&amp;m-&gt;top.c1.tuntap-&gt;dco, m-&gt;multi_io-&gt;es, =
MULTI_IO_DCO);</span><br><span> #endif</span><br><span> </span><br><span>@@=
 -535,7 +539,8 @@</span><br><span>                     multi_io_action(m, m=
i, TA_INITIAL, false);</span><br><span>                 }</span><br><span> =
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABL=
E_DCO) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TA=
RGET_WIN32))</span><br><span>             /* incoming data on DCO? */</span=
><br><span>             else if (e-&gt;arg =3D=3D MULTI_IO_DCO)</span><br><=
span>             {</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/935?usp=3Demail">change 935</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/935?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I719b1aa2d2f4d63dc9c18d8e313=
fba339e3e4b0c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 935 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--u4vxPTCv+/w=--

