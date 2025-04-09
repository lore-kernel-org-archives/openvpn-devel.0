From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 9 Apr 2025 07:04:15 +0000
References: <gerrit.1744182251000.I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dbeae5e8740f603a0f6c730c4ced89a0368f241d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4ZwvbtI0oJw="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4ZwvbtI0oJw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/935?usp=3Demail

to review the following change.


Change subject: Fix dco_win and multisocket interaction
......................................................................

Fix dco_win and multisocket interaction

Change-Id: I719b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/multi_io.c
1 file changed, 8 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/935/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--4ZwvbtI0oJw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/935?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix dco_win and multisocket interaction<br><br>Change-Id: I71=
9b1aa2d2f4d63dc9c18d8e313fba339e3e4b0c<br>Signed-off-by: Gianmarco De Grego=
ri &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/multi_io.c<br>1 fil=
e changed, 8 insertions(+), 5 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/35/935/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>index f1751ff..f2=
f40b0 100644</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+=
++ b/src/openvpn/multi_io.c</span><br><span>@@ -176,10 +176,13 @@</span><br=
><span>     int status, i;</span><br><span>     unsigned int *persistent =
=3D &amp;m-&gt;multi_io-&gt;tun_rwflags;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; m-&gt;top.c1.=
link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!tuntap_is_dco_win(m-&gt;top.c1.tuntap))</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket_set_lis=
ten_persistent(m-&gt;top.c2.link_sockets[i], m-&gt;multi_io-&gt;es,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
        &amp;m-&gt;top.c2.link_sockets[i]-&gt;ev_arg);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt; m-&gt;top.c=
1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       socket_set_listen_persistent(m-&gt;top.c2.link_sockets[i], m-&gt;mul=
ti_io-&gt;es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                   &amp;m-&gt;top.c2.link_sockets[i]-&gt;ev=
_arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span>     }</span><br><span> </span><br><span>     if (has_udp_in_l=
ocal_list(&amp;m-&gt;top.options))</span><br><span>@@ -202,7 +205,7 @@</spa=
n><br><span>     }</span><br><span> #endif</span><br><span>     tun_set(m-&=
gt;top.c1.tuntap, m-&gt;multi_io-&gt;es, EVENT_READ, MULTI_IO_TUN, persiste=
nt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGE=
T_LINUX) || defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || def=
ined(TARGET_WIN32)</span><br><span>     dco_event_set(&amp;m-&gt;top.c1.tun=
tap-&gt;dco, m-&gt;multi_io-&gt;es, MULTI_IO_DCO);</span><br><span> #endif<=
/span><br><span> </span><br><span>@@ -535,7 +538,7 @@</span><br><span>     =
                multi_io_action(m, mi, TA_INITIAL, false);</span><br><span>=
                 }</span><br><span>             }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DCO) &amp;&amp; (defined(TAR=
GET_LINUX) || defined(TARGET_FREEBSD))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX=
) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))</span><br><span>    =
         /* incoming data on DCO? */</span><br><span>             else if (=
e-&gt;arg =3D=3D MULTI_IO_DCO)</span><br><span>             {</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/935?usp=3Demail">change 935</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/935?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I719b1aa2d2f4d63dc9c18d8e313=
fba339e3e4b0c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 935 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--4ZwvbtI0oJw=--

