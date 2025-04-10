From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 10 Apr 2025 12:29:31 +0000
In-Reply-To: <gerrit.1744182251000.I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c@...2715...>
References: <gerrit.1744182251000.I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <ceab3b9b37dd5d9143bab9e4e165ef8211991ad0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pHt/4is0/0Q="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pHt/4is0/0Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/935?usp=3Demail

to look at the new patch set (#4).


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

Github: #720

Change-Id: I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/mtcp.c
M src/openvpn/multi_io.c
3 files changed, 13 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/935/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-MessageType: newpatchset

--pHt/4is0/0Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/935?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Fix dco_win and multisocket interaction<br><br>The recent introductio=
n of the multisocket support<br>did not account for some Windows-specific D=
CO paths.<br>This patch restores correct behavior on Windows.<br><br>Key ch=
anges:<br><br> - Add WIN32 guards around DCO-specifc code.<br> - Disable wa=
it_signal() when running in<br>   server mode, as it conflicts with the<br>=
   event engine since Windows handles<br>   signals as I/Os.<br> - Ensure c=
orrect socket handling for TCP<br>   vs UDP.<br><br>Github: #720<br><br>Cha=
nge-Id: I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c<br>Signed-off-by: Gianmar=
co De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/forward.=
c<br>M src/openvpn/mtcp.c<br>M src/openvpn/multi_io.c<br>3 files changed, 1=
3 insertions(+), 7 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/35/935/4</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forwa=
rd.c b/src/openvpn/forward.c</span><br><span>index af1d008..0b8b262 100644<=
/span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openv=
pn/forward.c</span><br><span>@@ -2072,7 +2072,7 @@</span><br><span>     /*<=
/span><br><span>      * Calculate the flags based on the provided &#39;flag=
s&#39; argument.</span><br><span>      */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (flags &amp; IOW_WAIT_SIGNAL)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if ((c-&gt;options.mode !=3D MODE_=
SERVER) &amp;&amp; (flags &amp; IOW_WAIT_SIGNAL))</span><br><span>     {</s=
pan><br><span>         wait_signal(es, (void *)err_shift);</span><br><span>=
     }</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c=
</span><br><span>index 1d62ea6..86c5160 100644</span><br><span>--- a/src/op=
envpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -1=
81,7 +181,8 @@</span><br><span> </span><br><span>     if (mi)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
defer || mbuf_defined(mi-&gt;tcp_link_out_deferred))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if ((defer &amp;&amp; !proto_is_d=
gram(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            || mbuf_defined(mi-&gt;tcp_=
link_out_deferred))</span><br><span>         {</span><br><span>            =
 /* save to queue */</span><br><span>             struct buffer *buf =3D &a=
mp;mi-&gt;context.c2.to_link;</span><br><span>diff --git a/src/openvpn/mult=
i_io.c b/src/openvpn/multi_io.c</span><br><span>index f1751ff..f4ca4df 1006=
44</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/o=
penvpn/multi_io.c</span><br><span>@@ -176,10 +176,13 @@</span><br><span>   =
  int status, i;</span><br><span>     unsigned int *persistent =3D &amp;m-&=
gt;multi_io-&gt;tun_rwflags;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; m-&gt;top.c1.link_sockets=
_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
tuntap_is_dco_win(m-&gt;top.c1.tuntap))</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        socket_set_listen_persiste=
nt(m-&gt;top.c2.link_sockets[i], m-&gt;multi_io-&gt;es,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                     &amp=
;m-&gt;top.c2.link_sockets[i]-&gt;ev_arg);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt; m-&gt;top.c1.link_socke=
ts_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            socke=
t_set_listen_persistent(m-&gt;top.c2.link_sockets[i], m-&gt;multi_io-&gt;es=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                       &amp;m-&gt;top.c2.link_sockets[i]-&gt;ev_arg);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
>     }</span><br><span> </span><br><span>     if (has_udp_in_local_list(&a=
mp;m-&gt;top.options))</span><br><span>@@ -202,7 +205,8 @@</span><br><span>=
     }</span><br><span> #endif</span><br><span>     tun_set(m-&gt;top.c1.tu=
ntap, m-&gt;multi_io-&gt;es, EVENT_READ, MULTI_IO_TUN, persistent);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || =
defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(ENABLE_DCO) \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) =
|| defined(TARGET_WIN32))</span><br><span>     dco_event_set(&amp;m-&gt;top=
.c1.tuntap-&gt;dco, m-&gt;multi_io-&gt;es, MULTI_IO_DCO);</span><br><span> =
#endif</span><br><span> </span><br><span>@@ -535,7 +539,8 @@</span><br><spa=
n>                     multi_io_action(m, mi, TA_INITIAL, false);</span><br=
><span>                 }</span><br><span>             }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DCO) &amp;&amp; (defi=
ned(TARGET_LINUX) || defined(TARGET_FREEBSD))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO) \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (defined(TARGET_LI=
NUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))</span><br><span> =
            /* incoming data on DCO? */</span><br><span>             else i=
f (e-&gt;arg =3D=3D MULTI_IO_DCO)</span><br><span>             {</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/935?usp=3Demail">change 935</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/93=
5?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I719b1aa2d2f4d63dc9c18d8e313=
fba339e3e4b0c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 935 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--pHt/4is0/0Q=--

