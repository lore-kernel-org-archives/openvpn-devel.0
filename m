From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 24 Nov 2025 08:02:22 +0000
In-Reply-To: <gerrit.1762862118000.I6a5110a0583b8b33496b06d9c27c1084df38e842@...2715...>
References: <gerrit.1762862118000.I6a5110a0583b8b33496b06d9c27c1084df38e842@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <04789ece90b1957226c72dfed39581650ebe554b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MPy9CdFw3ow="; charset=UTF-8
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

--MPy9CdFw3ow=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail

to look at the new patch set (#3).


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
removed the FILE_CLOSED and FILE_SHIFT
defines since we now handle that kind of
event in multi_io_process_io() through
the MULTI_IO_FILE_CLOSE_WRITE define.

Change-Id: I6a5110a0583b8b33496b06d9c27c1084df38e842
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/event.h
M src/openvpn/forward.c
M src/openvpn/mudp.c
3 files changed, 4 insertions(+), 74 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1364/3

diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index f6aa9c4..c2c63f6 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -68,8 +68,6 @@
 #define MANAGEMENT_SHIFT 6
 #define MANAGEMENT_READ  (1 << (MANAGEMENT_SHIFT + READ_SHIFT))
 #define MANAGEMENT_WRITE (1 << (MANAGEMENT_SHIFT + WRITE_SHIFT))
-#define FILE_SHIFT       8
-#define FILE_CLOSED      (1 << (FILE_SHIFT + READ_SHIFT))
 #define DCO_SHIFT        10
 #define DCO_READ         (1 << (DCO_SHIFT + READ_SHIFT))
 #define DCO_WRITE        (1 << (DCO_SHIFT + WRITE_SHIFT))
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a6d3394..ccb8404 100644
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
index 31134be..b03e165 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -333,7 +333,7 @@
 }

 /*
- * Process an I/O event.
+ * Process a UDP socket event.
  */
 void
 multi_process_io_udp(struct multi_context *m, struct link_socket *sock)
@@ -343,50 +343,11 @@
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
@@ -396,35 +357,6 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--MPy9CdFw3ow=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">multi-socket: do not return tuntap flags on server-=
side<br><br>Tuntap flags are already handled within<br>multi_io_process_io(=
) so return them by<br>multi_io_process_flags() would be redoundant,<br>sin=
ce we need them only for tun_set().<br><br>While at it, removed part of the=
 I/O process<br>from multi_process_io_udp() since those are<br>also handled=
 within multi_io_process_io(),<br>removed the FILE_CLOSED and FILE_SHIFT<br=
>defines since we now handle that kind of<br>event in multi_io_process_io()=
 through<br>the MULTI_IO_FILE_CLOSE_WRITE define.<br><br>Change-Id: I6a5110=
a0583b8b33496b06d9c27c1084df38e842<br>Signed-off-by: Gianmarco De Gregori &=
lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/event.h<br>M src/openvp=
n/forward.c<br>M src/openvpn/mudp.c<br>3 files changed, 4 insertions(+), 74=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/64/1364/3</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/event=
.h b/src/openvpn/event.h</span><br><span>index f6aa9c4..c2c63f6 100644</spa=
n><br><span>--- a/src/openvpn/event.h</span><br><span>+++ b/src/openvpn/eve=
nt.h</span><br><span>@@ -68,8 +68,6 @@</span><br><span> #define MANAGEMENT_=
SHIFT 6</span><br><span> #define MANAGEMENT_READ  (1 &lt;&lt; (MANAGEMENT_S=
HIFT + READ_SHIFT))</span><br><span> #define MANAGEMENT_WRITE (1 &lt;&lt; (=
MANAGEMENT_SHIFT + WRITE_SHIFT))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define FILE_SHIFT       8</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define FILE_CLOSED      (1 &lt;&lt; (FILE_SHIFT + READ_SHI=
FT))</span><br><span> #define DCO_SHIFT        10</span><br><span> #define =
DCO_READ         (1 &lt;&lt; (DCO_SHIFT + READ_SHIFT))</span><br><span> #de=
fine DCO_WRITE        (1 &lt;&lt; (DCO_SHIFT + WRITE_SHIFT))</span><br><spa=
n>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><spa=
n>index a6d3394..ccb8404 100644</span><br><span>--- a/src/openvpn/forward.c=
</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -2170,10 +2=
170,10 @@</span><br><span> void</span><br><span> get_io_flags_dowork_udp(st=
ruct context *c, struct multi_io *multi_io, const unsigned int flags)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsi=
gned int out_socket, out_tuntap;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    unsigned int out_socket;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    multi_io_process_flags(c, multi_i=
o-&gt;es, flags, &amp;out_socket, &amp;out_tuntap);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    multi_io-&gt;udp_flags =3D out_socket |=
 out_tuntap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mul=
ti_io_process_flags(c, multi_io-&gt;es, flags, &amp;out_socket, NULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;udp_fla=
gs =3D (out_socket &lt;&lt; SOCKET_SHIFT);</span><br><span> }</span><br><sp=
an> </span><br><span> void</span><br><span>diff --git a/src/openvpn/mudp.c =
b/src/openvpn/mudp.c</span><br><span>index 31134be..b03e165 100644</span><b=
r><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</=
span><br><span>@@ -333,7 +333,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Pr=
ocess an I/O event.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Process a UDP socket event.</span><br><span>  */</span><br><span> void</=
span><br><span> multi_process_io_udp(struct multi_context *m, struct link_s=
ocket *sock)</span><br><span>@@ -343,50 +343,11 @@</span><br><span>        =
                                ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOSE_O=
N_SIGNAL)</span><br><span>                                        : (MPP_PR=
E_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    char buf[16];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    buf[0] =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (status &amp; SOCKET_READ)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        strcat(buf, &quot;SR/&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    else if (status &amp; SOCKET_WRITE)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        strcat(buf, &quot;SW/&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    else if (status &amp; TUN_READ)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        strcat(buf, &quot;TR/&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    else if (status &amp; TUN_WRITE)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        strcat(buf, &quot;TW/&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else if (status &amp; FILE_CLOSED)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        strcat(buf, &quot;FC/&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    printf(&quot;IO %s\n&quot;, buf);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef MULTI_DEBUG_EVENT_=
LOOP */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (status &amp; (MANAGEMENT=
_READ | MANAGEMENT_WRITE))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASS=
ERT(management);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   management_io(management);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /=
* UDP port ready to accept write */</span><br><span>     if (status &amp; S=
OCKET_WRITE)</span><br><span>     {</span><br><span>         multi_process_=
outgoing_link(m, mpp_flags);</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* TUN device ready to accept write */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (status &a=
mp; TUN_WRITE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_process_o=
utgoing_tun(m, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span>     /* Incoming data on UDP port */</span><br><=
span>     else if (status &amp; SOCKET_READ)</span><br><span>     {</span><=
br><span>@@ -396,35 +357,6 @@</span><br><span>             multi_process_in=
coming_link(m, NULL, mpp_flags, sock);</span><br><span>         }</span><br=
><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* I=
ncoming data on TUN device */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    else if (status &amp; TUN_READ)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        read_incoming_tun(&amp;m-&gt;top);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (!IS_SIG(&amp;m-&gt;top))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            multi_process_incoming_tun(m, m=
pp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* INOTIFY callback */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else if (status &amp; FILE_=
CLOSED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        multi_process_file_clo=
sed(m, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DCO)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    else if (status &amp; DCO_RE=
AD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (!IS_SIG(&amp;m-&gt;top=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            bool ret =3D true;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            while (ret=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                ret =3D mult=
i_process_incoming_dco(m);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </span>=
<br><span>     m-&gt;multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span> =
}</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1364?usp=3Demail">change 1364</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1364?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a5110a0583b8b33496b06d9c27=
c1084df38e842 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1364 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--MPy9CdFw3ow=--

