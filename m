From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 9 Apr 2025 14:42:25 +0000
In-Reply-To: <gerrit.1744182251000.I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c@...2715...>
References: <gerrit.1744182251000.I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <97917fc53f7bf2c4f86fc41fab9a6e1f1fd3305b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bsc2gS5puMM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, stipa <lstipakov@...277...>

--Bsc2gS5puMM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/935?usp=3Demail

to look at the new patch set (#2).


Change subject: Fix dco_win and multisocket interaction
......................................................................

Fix dco_win and multisocket interaction

Change-Id: I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/multi_io.c
2 files changed, 13 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/935/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--Bsc2gS5puMM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/935?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Fix dco_win and multisocket interaction<br><br>Change-Id: I719b1aa2d2=
f4d63dc9c18d8e313fba339e3e4b0c<br>Signed-off-by: Gianmarco De Gregori &lt;g=
ianmarco@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/=
multi_io.c<br>2 files changed, 13 insertions(+), 7 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/935/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><spa=
n>index af1d008..4eaa4f2 100644</span><br><span>--- a/src/openvpn/forward.c=
</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -2072,9 +20=
72,12 @@</span><br><span>     /*</span><br><span>      * Calculate the flag=
s based on the provided &#39;flags&#39; argument.</span><br><span>      */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (flags &amp; IO=
W_WAIT_SIGNAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (c-&gt;options.mode !=3D MODE_SERVER)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        wait_signal(es, (void *)er=
r_shift);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (flags &amp; IOW_WAIT_SIGNAL)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            wait_signal(es, (void *)err_shift);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><sp=
an> </span><br><span>     if (flags &amp; IOW_TO_LINK)</span><br><span>diff=
 --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>in=
dex f1751ff..f2f40b0 100644</span><br><span>--- a/src/openvpn/multi_io.c</s=
pan><br><span>+++ b/src/openvpn/multi_io.c</span><br><span>@@ -176,10 +176,=
13 @@</span><br><span>     int status, i;</span><br><span>     unsigned int=
 *persistent =3D &amp;m-&gt;multi_io-&gt;tun_rwflags;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; =
m-&gt;top.c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!tuntap_is_dco_win(m-&gt;top.c1.tuntap))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
ocket_set_listen_persistent(m-&gt;top.c2.link_sockets[i], m-&gt;multi_io-&g=
t;es,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                     &amp;m-&gt;top.c2.link_sockets[i]-&gt;ev_arg);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt=
; m-&gt;top.c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            socket_set_listen_persistent(m-&gt;top.c2.link_sockets[=
i], m-&gt;multi_io-&gt;es,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                         &amp;m-&gt;top.c2.link_sock=
ets[i]-&gt;ev_arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span>     }</span><br><span> </span><br><span>     if =
(has_udp_in_local_list(&amp;m-&gt;top.options))</span><br><span>@@ -202,7 +=
205,7 @@</span><br><span>     }</span><br><span> #endif</span><br><span>   =
  tun_set(m-&gt;top.c1.tuntap, m-&gt;multi_io-&gt;es, EVENT_READ, MULTI_IO_=
TUN, persistent);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FR=
EEBSD) || defined(TARGET_WIN32)</span><br><span>     dco_event_set(&amp;m-&=
gt;top.c1.tuntap-&gt;dco, m-&gt;multi_io-&gt;es, MULTI_IO_DCO);</span><br><=
span> #endif</span><br><span> </span><br><span>@@ -535,7 +538,7 @@</span><b=
r><span>                     multi_io_action(m, mi, TA_INITIAL, false);</sp=
an><br><span>                 }</span><br><span>             }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DCO) &amp;&amp;=
 (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO) &amp;&amp; (defin=
ed(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))</span=
><br><span>             /* incoming data on DCO? */</span><br><span>       =
      else if (e-&gt;arg =3D=3D MULTI_IO_DCO)</span><br><span>             =
{</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/935?usp=3Demail">change 935</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/935?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I719b1aa2d2f4d63dc9c18d8e313=
fba339e3e4b0c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 935 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Bsc2gS5puMM=--

