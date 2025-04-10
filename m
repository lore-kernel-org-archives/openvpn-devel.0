From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 10 Apr 2025 09:18:33 +0000
In-Reply-To: <gerrit.1744182251000.I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c@...2715...>
References: <gerrit.1744182251000.I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <f4688e0c8d6eb27880d6fdb48ef160e001e5cdef-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YonvXKcrBPM="; charset=UTF-8
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

--YonvXKcrBPM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/935?usp=3Demail

to look at the new patch set (#3).


Change subject: Fix dco_win and multisocket interaction
......................................................................

Fix dco_win and multisocket interaction

Change-Id: I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/mtcp.c
M src/openvpn/multi_io.c
3 files changed, 15 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/935/3

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index af1d008..4eaa4f2 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2072,9 +2072,12 @@
     /*
      * Calculate the flags based on the provided 'flags' argument.
      */
-    if (flags & IOW_WAIT_SIGNAL)
+    if (c->options.mode !=3D MODE_SERVER)
     {
-        wait_signal(es, (void *)err_shift);
+        if (flags & IOW_WAIT_SIGNAL)
+        {
+            wait_signal(es, (void *)err_shift);
+        }
     }

     if (flags & IOW_TO_LINK)
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
index f1751ff..f2f40b0 100644
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
@@ -202,7 +205,7 @@
     }
 #endif
     tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, p=
ersistent);
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN=
32)
     dco_event_set(&m->top.c1.tuntap->dco, m->multi_io->es, MULTI_IO_DCO);
 #endif

@@ -535,7 +538,7 @@
                     multi_io_action(m, mi, TA_INITIAL, false);
                 }
             }
-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D) || defined(TARGET_WIN32))
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
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-MessageType: newpatchset

--YonvXKcrBPM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/935?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Fix dco_win and multisocket interaction<br><br>Change-Id: I719b1aa2d2=
f4d63dc9c18d8e313fba339e3e4b0c<br>Signed-off-by: Gianmarco De Gregori &lt;g=
ianmarco@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/=
mtcp.c<br>M src/openvpn/multi_io.c<br>3 files changed, 15 insertions(+), 8 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/35/935/3</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/=
forward.c</span><br><span>index af1d008..4eaa4f2 100644</span><br><span>---=
 a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span>=
<br><span>@@ -2072,9 +2072,12 @@</span><br><span>     /*</span><br><span>  =
    * Calculate the flags based on the provided &#39;flags&#39; argument.</=
span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (flags &amp; IOW_WAIT_SIGNAL)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (c-&gt;options.mode !=3D MODE_SERVER)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        wa=
it_signal(es, (void *)err_shift);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (flags &amp; IOW_WAIT_SIGNAL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            wait_signal(es, (void *)err_shift);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan>     }</span><br><span> </span><br><span>     if (flags &amp; IOW_TO_LI=
NK)</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</s=
pan><br><span>index 1d62ea6..86c5160 100644</span><br><span>--- a/src/openv=
pn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -181,=
7 +181,8 @@</span><br><span> </span><br><span>     if (mi)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (def=
er || mbuf_defined(mi-&gt;tcp_link_out_deferred))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if ((defer &amp;&amp; !proto_is_dgram=
(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            || mbuf_defined(mi-&gt;tcp_li=
nk_out_deferred))</span><br><span>         {</span><br><span>             /=
* save to queue */</span><br><span>             struct buffer *buf =3D &amp=
;mi-&gt;context.c2.to_link;</span><br><span>diff --git a/src/openvpn/multi_=
io.c b/src/openvpn/multi_io.c</span><br><span>index f1751ff..f2f40b0 100644=
</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/ope=
nvpn/multi_io.c</span><br><span>@@ -176,10 +176,13 @@</span><br><span>     =
int status, i;</span><br><span>     unsigned int *persistent =3D &amp;m-&gt=
;multi_io-&gt;tun_rwflags;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; m-&gt;top.c1.link_sockets_n=
um; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tu=
ntap_is_dco_win(m-&gt;top.c1.tuntap))</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        socket_set_listen_persistent=
(m-&gt;top.c2.link_sockets[i], m-&gt;multi_io-&gt;es,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                     &amp;m=
-&gt;top.c2.link_sockets[i]-&gt;ev_arg);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        for (i =3D 0; i &lt; m-&gt;top.c1.link_sockets=
_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            socket_=
set_listen_persistent(m-&gt;top.c2.link_sockets[i], m-&gt;multi_io-&gt;es,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                     &amp;m-&gt;top.c2.link_sockets[i]-&gt;ev_arg);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> =
    }</span><br><span> </span><br><span>     if (has_udp_in_local_list(&amp=
;m-&gt;top.options))</span><br><span>@@ -202,7 +205,7 @@</span><br><span>  =
   }</span><br><span> #endif</span><br><span>     tun_set(m-&gt;top.c1.tunt=
ap, m-&gt;multi_io-&gt;es, EVENT_READ, MULTI_IO_TUN, persistent);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || de=
fined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WI=
N32)</span><br><span>     dco_event_set(&amp;m-&gt;top.c1.tuntap-&gt;dco, m=
-&gt;multi_io-&gt;es, MULTI_IO_DCO);</span><br><span> #endif</span><br><spa=
n> </span><br><span>@@ -535,7 +538,7 @@</span><br><span>                   =
  multi_io_action(m, mi, TA_INITIAL, false);</span><br><span>              =
   }</span><br><span>             }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || =
defined(TARGET_FREEBSD))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(T=
ARGET_FREEBSD) || defined(TARGET_WIN32))</span><br><span>             /* in=
coming data on DCO? */</span><br><span>             else if (e-&gt;arg =3D=
=3D MULTI_IO_DCO)</span><br><span>             {</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/9=
35?usp=3Demail">change 935</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/935?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I719b1aa2d2f4d63dc9c18d8e313=
fba339e3e4b0c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 935 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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


--YonvXKcrBPM=--

