From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 28 Jul 2025 08:25:27 +0000
In-Reply-To: <gerrit.1753690218000.I6977d23b5289eba5db436608e0500216e0e689ec@...2715...>
References: <gerrit.1753690218000.I6977d23b5289eba5db436608e0500216e0e689ec@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1c983998a3ebaba907f54aa88fd1d803ed0ef560-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mote37BX9k4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mudp.c, multi.c,
 multi_io.c: get rid of "all three DCO platforms" #if...
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

--mote37BX9k4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1117?usp=3Demail

to look at the new patch set (#3).


Change subject: mudp.c, multi.c, multi_io.c: get rid of "all three DCO plat=
forms" #ifdefs
......................................................................

mudp.c, multi.c, multi_io.c: get rid of "all three DCO platforms" #ifdefs

With commit b66b80b2a all three platforms with DCO support have DCO float
notifications now, so the #ifdef inside multi_process_incoming_dco() is
no longer needed.

Also, the whole notification block (process_incoming_del_peer() and
multi_process_incoming_dco()) was surrounded by an

  #ifdef ENABLE_DCO "and all 3 platforms"

which is also not making sense anymore (if we add a fourth DCO platform,
we need to aim for having "all notifications from day 1", at least having
the stubs and defines).

Last not least, the event stuff in mudp.c and multi_io.c had grown the
same construct - and we'll need events for any future DCO platform, too.

So, fix those #ifdef as well, while at it.

Change-Id: I6977d23b5289eba5db436608e0500216e0e689ec
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/multi_io.c
3 files changed, 5 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1117/3

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index ee8446a..118c954 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -412,8 +412,7 @@
         multi_process_file_closed(m, mpp_flags);
     }
 #endif
-#if defined(ENABLE_DCO) \
-    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET=
_WIN32))
+#if defined(ENABLE_DCO)
     else if (status & DCO_READ)
     {
         if (!IS_SIG(&m->top))
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 49f5320..b2d2b6c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3337,8 +3337,7 @@
 }
 #endif

-#if defined(ENABLE_DCO) \
-    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET=
_WIN32))
+#if defined(ENABLE_DCO)
 static void
 process_incoming_del_peer(struct multi_context *m, struct multi_instance *=
mi,
                           dco_context_t *dco)
@@ -3409,7 +3408,6 @@
         {
             process_incoming_del_peer(m, mi, dco);
         }
-#if defined(TARGET_LINUX) || defined(TARGET_WIN32) || defined(TARGET_FREEB=
SD)
         else if (dco->dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)
         {
             ASSERT(mi->context.c2.link_sockets[0]);
@@ -3419,7 +3417,6 @@
             multi_process_float(m, mi, mi->context.c2.link_sockets[0]);
             CLEAR(dco->dco_float_peer_ss);
         }
-#endif /* if defined(TARGET_LINUX) || defined(TARGET_WIN32) */
         else if (dco->dco_message_type =3D=3D OVPN_CMD_SWAP_KEYS)
         {
             tls_session_soft_reset(mi->context.c2.tls_multi);
@@ -3452,7 +3449,7 @@
     dco->dco_write_bytes =3D 0;
     return ret > 0;
 }
-#endif /* if defined(ENABLE_DCO) && defined(TARGET_LINUX) */
+#endif /* if defined(ENABLE_DCO) */

 /*
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 4854f4b..102ee2f 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -191,8 +191,7 @@
     }

     tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, p=
ersistent);
-#if defined(ENABLE_DCO) \
-    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET=
_WIN32))
+#if defined(ENABLE_DCO)
     dco_event_set(&m->top.c1.tuntap->dco, m->multi_io->es, MULTI_IO_DCO);
 #endif

@@ -526,8 +525,7 @@
                     multi_io_action(m, mi, TA_INITIAL, false);
                 }
             }
-#if defined(ENABLE_DCO) \
-            && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || define=
d(TARGET_WIN32))
+#if defined(ENABLE_DCO)
             /* incoming data on DCO? */
             else if (e->arg =3D=3D MULTI_IO_DCO)
             {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1117?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6977d23b5289eba5db436608e0500216e0e689ec
Gerrit-Change-Number: 1117
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--mote37BX9k4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1117?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">mudp.c, multi.c, multi_io.c: get rid of &quot;all three DCO platforms&qu=
ot; #ifdefs<br><br>With commit b66b80b2a all three platforms with DCO suppo=
rt have DCO float<br>notifications now, so the #ifdef inside multi_process_=
incoming_dco() is<br>no longer needed.<br><br>Also, the whole notification =
block (process_incoming_del_peer() and<br>multi_process_incoming_dco()) was=
 surrounded by an<br><br>  #ifdef ENABLE_DCO &quot;and all 3 platforms&quot=
;<br><br>which is also not making sense anymore (if we add a fourth DCO pla=
tform,<br>we need to aim for having &quot;all notifications from day 1&quot=
;, at least having<br>the stubs and defines).<br><br>Last not least, the ev=
ent stuff in mudp.c and multi_io.c had grown the<br>same construct - and we=
&#39;ll need events for any future DCO platform, too.<br><br>So, fix those =
#ifdef as well, while at it.<br><br>Change-Id: I6977d23b5289eba5db436608e05=
00216e0e689ec<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M src/openvpn/mudp.c<br>M src/openvpn/multi.c<br>M src/openvpn/multi_io=
.c<br>3 files changed, 5 insertions(+), 11 deletions(-)<br><br></pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1117/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index ee844=
6a..118c954 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span=
>+++ b/src/openvpn/mudp.c</span><br><span>@@ -412,8 +412,7 @@</span><br><sp=
an>         multi_process_file_closed(m, mpp_flags);</span><br><span>     }=
</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(ENABLE_DCO) \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || =
defined(TARGET_WIN32))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(ENABLE_DCO)</span><br><span>     else if (status &amp; DCO_R=
EAD)</span><br><span>     {</span><br><span>         if (!IS_SIG(&amp;m-&gt=
;top))</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi=
.c</span><br><span>index 49f5320..b2d2b6c 100644</span><br><span>--- a/src/=
openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@=
@ -3337,8 +3337,7 @@</span><br><span> }</span><br><span> #endif</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENA=
BLE_DCO) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &amp;&a=
mp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN=
32))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENA=
BLE_DCO)</span><br><span> static void</span><br><span> process_incoming_del=
_peer(struct multi_context *m, struct multi_instance *mi,</span><br><span> =
                          dco_context_t *dco)</span><br><span>@@ -3409,7 +3=
408,6 @@</span><br><span>         {</span><br><span>             process_in=
coming_del_peer(m, mi, dco);</span><br><span>         }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || defined(TARG=
ET_WIN32) || defined(TARGET_FREEBSD)</span><br><span>         else if (dco-=
&gt;dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)</span><br><span>         {=
</span><br><span>             ASSERT(mi-&gt;context.c2.link_sockets[0]);</s=
pan><br><span>@@ -3419,7 +3417,6 @@</span><br><span>             multi_proc=
ess_float(m, mi, mi-&gt;context.c2.link_sockets[0]);</span><br><span>      =
       CLEAR(dco-&gt;dco_float_peer_ss);</span><br><span>         }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(TARGET_L=
INUX) || defined(TARGET_WIN32) */</span><br><span>         else if (dco-&gt=
;dco_message_type =3D=3D OVPN_CMD_SWAP_KEYS)</span><br><span>         {</sp=
an><br><span>             tls_session_soft_reset(mi-&gt;context.c2.tls_mult=
i);</span><br><span>@@ -3452,7 +3449,7 @@</span><br><span>     dco-&gt;dco_=
write_bytes =3D 0;</span><br><span>     return ret &gt; 0;</span><br><span>=
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if define=
d(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif /* if defined(ENABLE_DCO) */</span><br=
><span> </span><br><span> /*</span><br><span>  * Process packets in the TCP=
/UDP socket -&gt; TUN/TAP interface direction,</span><br><span>diff --git a=
/src/openvpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>index 4854=
f4b..102ee2f 100644</span><br><span>--- a/src/openvpn/multi_io.c</span><br>=
<span>+++ b/src/openvpn/multi_io.c</span><br><span>@@ -191,8 +191,7 @@</spa=
n><br><span>     }</span><br><span> </span><br><span>     tun_set(m-&gt;top=
.c1.tuntap, m-&gt;multi_io-&gt;es, EVENT_READ, MULTI_IO_TUN, persistent);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DCO)=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &amp;&amp; (def=
ined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)=
</span><br><span>     dco_event_set(&amp;m-&gt;top.c1.tuntap-&gt;dco, m-&gt=
;multi_io-&gt;es, MULTI_IO_DCO);</span><br><span> #endif</span><br><span> <=
/span><br><span>@@ -526,8 +525,7 @@</span><br><span>                     mu=
lti_io_action(m, mi, TA_INITIAL, false);</span><br><span>                 }=
</span><br><span>             }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(ENABLE_DCO) \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            &amp;&amp; (defined(TARGET_LINUX) || defined(TARG=
ET_FREEBSD) || defined(TARGET_WIN32))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(ENABLE_DCO)</span><br><span>             /* i=
ncoming data on DCO? */</span><br><span>             else if (e-&gt;arg =3D=
=3D MULTI_IO_DCO)</span><br><span>             {</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
117?usp=3Demail">change 1117</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1117?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6977d23b5289eba5db436608e05=
00216e0e689ec </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1117 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--mote37BX9k4=--

