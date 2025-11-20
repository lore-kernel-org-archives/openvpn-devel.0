From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 20 Nov 2025 10:57:50 +0000
In-Reply-To: <gerrit.1762862118000.I6a5110a0583b8b33496b06d9c27c1084df38e842@...2715...>
References: <gerrit.1762862118000.I6a5110a0583b8b33496b06d9c27c1084df38e842@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <6d10a4c7fe809b1ac312ad034ef0f57434c80ed3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3tDdTmdJUuQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi-socket: do not
 return tuntap flags on server-side
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

--3tDdTmdJUuQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, plais=
thos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: multi-socket: do not return tuntap flags on server-side
......................................................................

multi-socket: do not return tuntap flags on server-side

Tuntap flags are already handled within
multi_io_process_io() so return them by
multi_io_process_flags() would be redoundant,
since we need them only for tun_set().

While at it, removed part of the I/O process
from multi_process_io_udp() since those are
also handled within multi_io_process_io(),
and changed the IO debug to a more useful
style.

Change-Id: I6a5110a0583b8b33496b06d9c27c1084df38e842
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/mudp.c
2 files changed, 5 insertions(+), 71 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1364/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f01fb4c..d57cbe0 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2170,10 +2170,10 @@
 void
 get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io, cons=
t unsigned int flags)
 {
-    unsigned int out_socket, out_tuntap;
+    unsigned int out_socket;

-    multi_io_process_flags(c, multi_io->es, flags, &out_socket, &out_tunta=
p);
-    multi_io->udp_flags =3D out_socket | out_tuntap;
+    multi_io_process_flags(c, multi_io->es, flags, &out_socket, NULL);
+    multi_io->udp_flags =3D (out_socket << SOCKET_SHIFT);
 }

 void
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 31134be..317c2dc 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -343,88 +343,22 @@
                                        ? (MPP_CONDITIONAL_PRE_SELECT | MPP=
_CLOSE_ON_SIGNAL)
                                        : (MPP_PRE_SELECT | MPP_CLOSE_ON_SI=
GNAL);

-#ifdef MULTI_DEBUG_EVENT_LOOP
-    char buf[16];
-    buf[0] =3D 0;
-    if (status & SOCKET_READ)
-    {
-        strcat(buf, "SR/");
-    }
-    else if (status & SOCKET_WRITE)
-    {
-        strcat(buf, "SW/");
-    }
-    else if (status & TUN_READ)
-    {
-        strcat(buf, "TR/");
-    }
-    else if (status & TUN_WRITE)
-    {
-        strcat(buf, "TW/");
-    }
-    else if (status & FILE_CLOSED)
-    {
-        strcat(buf, "FC/");
-    }
-    printf("IO %s\n", buf);
-#endif /* ifdef MULTI_DEBUG_EVENT_LOOP */
-
-#ifdef ENABLE_MANAGEMENT
-    if (status & (MANAGEMENT_READ | MANAGEMENT_WRITE))
-    {
-        ASSERT(management);
-        management_io(management);
-    }
-#endif
-
     /* UDP port ready to accept write */
     if (status & SOCKET_WRITE)
     {
+        dmsg(D_MULTI_DEBUG, "UDP socket write fd=3D" SOCKET_PRINTF, sock->=
sd);
         multi_process_outgoing_link(m, mpp_flags);
     }
-    /* TUN device ready to accept write */
-    else if (status & TUN_WRITE)
-    {
-        multi_process_outgoing_tun(m, mpp_flags);
-    }
     /* Incoming data on UDP port */
     else if (status & SOCKET_READ)
     {
+        dmsg(D_MULTI_DEBUG, "UDP socket read fd=3D" SOCKET_PRINTF, sock->s=
d);
         read_incoming_link(&m->top, sock);
         if (!IS_SIG(&m->top))
         {
             multi_process_incoming_link(m, NULL, mpp_flags, sock);
         }
     }
-    /* Incoming data on TUN device */
-    else if (status & TUN_READ)
-    {
-        read_incoming_tun(&m->top);
-        if (!IS_SIG(&m->top))
-        {
-            multi_process_incoming_tun(m, mpp_flags);
-        }
-    }
-#ifdef ENABLE_ASYNC_PUSH
-    /* INOTIFY callback */
-    else if (status & FILE_CLOSED)
-    {
-        multi_process_file_closed(m, mpp_flags);
-    }
-#endif
-#if defined(ENABLE_DCO)
-    else if (status & DCO_READ)
-    {
-        if (!IS_SIG(&m->top))
-        {
-            bool ret =3D true;
-            while (ret)
-            {
-                ret =3D multi_process_incoming_dco(m);
-            }
-        }
-    }
-#endif

     m->multi_io->udp_flags =3D ES_ERROR;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6a5110a0583b8b33496b06d9c27c1084df38e842
Gerrit-Change-Number: 1364
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--3tDdTmdJUuQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">multi-socket: do not return tuntap =
flags on server-side<br><br>Tuntap flags are already handled within<br>mult=
i_io_process_io() so return them by<br>multi_io_process_flags() would be re=
doundant,<br>since we need them only for tun_set().<br><br>While at it, rem=
oved part of the I/O process<br>from multi_process_io_udp() since those are=
<br>also handled within multi_io_process_io(),<br>and changed the IO debug =
to a more useful<br>style.<br><br>Change-Id: I6a5110a0583b8b33496b06d9c27c1=
084df38e842<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...=
&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/mudp.c<br>2 files c=
hanged, 5 insertions(+), 71 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1364/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>ind=
ex f01fb4c..d57cbe0 100644</span><br><span>--- a/src/openvpn/forward.c</spa=
n><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -2170,10 +2170,1=
0 @@</span><br><span> void</span><br><span> get_io_flags_dowork_udp(struct =
context *c, struct multi_io *multi_io, const unsigned int flags)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned =
int out_socket, out_tuntap;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    unsigned int out_socket;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    multi_io_process_flags(c, multi_io-&gt=
;es, flags, &amp;out_socket, &amp;out_tuntap);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    multi_io-&gt;udp_flags =3D out_socket | out_tu=
ntap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io_p=
rocess_flags(c, multi_io-&gt;es, flags, &amp;out_socket, NULL);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;udp_flags =3D =
(out_socket &lt;&lt; SOCKET_SHIFT);</span><br><span> }</span><br><span> </s=
pan><br><span> void</span><br><span>diff --git a/src/openvpn/mudp.c b/src/o=
penvpn/mudp.c</span><br><span>index 31134be..317c2dc 100644</span><br><span=
>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><b=
r><span>@@ -343,88 +343,22 @@</span><br><span>                             =
           ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)</span><br><=
span>                                        : (MPP_PRE_SELECT | MPP_CLOSE_=
ON_SIGNAL);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    char buf[16];</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    buf[0] =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (status &amp; SOCKET_READ)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        strcat(buf, &quot;SR/&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    else if (status &amp; SOCKET_WRITE)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        strcat(buf, &quot;SW/&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else if (status &amp; TUN_READ)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        strcat(buf, &quot;TR/&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    else if (status &amp; TUN_WRITE)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        strcat(buf, &quot;TW/&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    else if (status &amp; FILE_CLOSED)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        strcat(buf, &quot;FC/&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    printf(&quot;IO %s\n&quot;, buf);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif /* ifdef MULTI_DEBUG_EVENT_LOOP */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (status &amp; (MANAGEMENT_READ | MANAGEMENT_WR=
ITE))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(management);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        management_io(mana=
gement);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* UDP port ready to =
accept write */</span><br><span>     if (status &amp; SOCKET_WRITE)</span><=
br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    dmsg(D_MULTI_DEBUG, &quot;UDP socket write fd=3D&quot; SOCKET_PRINTF, s=
ock-&gt;sd);</span><br><span>         multi_process_outgoing_link(m, mpp_fl=
ags);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* TUN device ready to accept write */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    else if (status &amp; TUN_WRITE)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        multi_process_outgoing_tun(m, mpp_flags)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n>     /* Incoming data on UDP port */</span><br><span>     else if (status=
 &amp; SOCKET_READ)</span><br><span>     {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        dmsg(D_MULTI_DEBUG, &quot;UDP socket read fd=
=3D&quot; SOCKET_PRINTF, sock-&gt;sd);</span><br><span>         read_incomi=
ng_link(&amp;m-&gt;top, sock);</span><br><span>         if (!IS_SIG(&amp;m-=
&gt;top))</span><br><span>         {</span><br><span>             multi_pro=
cess_incoming_link(m, NULL, mpp_flags, sock);</span><br><span>         }</s=
pan><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* Incoming data on TUN device */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    else if (status &amp; TUN_READ)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        read_incoming_tun(&amp;m-&gt;top);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (!IS_SIG(&amp;m-&gt;top))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            multi_process_incoming_tun=
(m, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* INOTIFY callback */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (status &amp; =
FILE_CLOSED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_process_fil=
e_closed(m, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DCO)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (status &amp; D=
CO_READ)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!IS_SIG(&amp;m-&g=
t;top))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            bool ret =3D t=
rue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            while=
 (ret)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ret =3D=
 multi_process_incoming_dco(m);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </=
span><br><span>     m-&gt;multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><s=
pan> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail">change 1364</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1364?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a5110a0583b8b33496b06d9c27=
c1084df38e842 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1364 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--3tDdTmdJUuQ=--

