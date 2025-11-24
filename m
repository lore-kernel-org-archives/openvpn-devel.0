From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 24 Nov 2025 18:50:03 +0000
In-Reply-To: <gerrit.1762862118000.I6a5110a0583b8b33496b06d9c27c1084df38e842@...2715...>
References: <gerrit.1762862118000.I6a5110a0583b8b33496b06d9c27c1084df38e842@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5a41f3c5388989b2770fd13c489aeeb0326f97b4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BcmgBzbjpKg="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BcmgBzbjpKg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
64?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1364
Message-Id: <20251124175832.21352-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
650.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/event.h
M src/openvpn/forward.c
M src/openvpn/mudp.c
3 files changed, 4 insertions(+), 74 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6a5110a0583b8b33496b06d9c27c1084df38e842
Gerrit-Change-Number: 1364
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BcmgBzbjpKg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1364?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">multi-socket: do not return tuntap flags on serv=
er-side<br><br>Tuntap flags are already handled within<br>multi_io_process_=
io() so return them by<br>multi_io_process_flags() would be redoundant,<br>=
since we need them only for tun_set().<br><br>While at it, removed part of =
the I/O process<br>from multi_process_io_udp() since those are<br>also hand=
led within multi_io_process_io(),<br>removed the FILE_CLOSED and FILE_SHIFT=
<br>defines since we now handle that kind of<br>event in multi_io_process_i=
o() through<br>the MULTI_IO_FILE_CLOSE_WRITE define.<br><br>Change-Id: I6a5=
110a0583b8b33496b06d9c27c1084df38e842<br>Signed-off-by: Gianmarco De Gregor=
i &lt;gianmarco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1364<br>Message=
-Id: &lt;20251124175832.21352-1-gert@...1296...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg34650.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/event.h=
<br>M src/openvpn/forward.c<br>M src/openvpn/mudp.c<br>3 files changed, 4 i=
nsertions(+), 74 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/event.h b/src/openvpn/event.h</span><br><span>i=
ndex f6aa9c4..c2c63f6 100644</span><br><span>--- a/src/openvpn/event.h</spa=
n><br><span>+++ b/src/openvpn/event.h</span><br><span>@@ -68,8 +68,6 @@</sp=
an><br><span> #define MANAGEMENT_SHIFT 6</span><br><span> #define MANAGEMEN=
T_READ  (1 &lt;&lt; (MANAGEMENT_SHIFT + READ_SHIFT))</span><br><span> #defi=
ne MANAGEMENT_WRITE (1 &lt;&lt; (MANAGEMENT_SHIFT + WRITE_SHIFT))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define FILE_SHIFT       8</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define FILE_CLOSED      (=
1 &lt;&lt; (FILE_SHIFT + READ_SHIFT))</span><br><span> #define DCO_SHIFT   =
     10</span><br><span> #define DCO_READ         (1 &lt;&lt; (DCO_SHIFT + =
READ_SHIFT))</span><br><span> #define DCO_WRITE        (1 &lt;&lt; (DCO_SHI=
FT + WRITE_SHIFT))</span><br><span>diff --git a/src/openvpn/forward.c b/src=
/openvpn/forward.c</span><br><span>index a6d3394..ccb8404 100644</span><br>=
<span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward=
.c</span><br><span>@@ -2170,10 +2170,10 @@</span><br><span> void</span><br>=
<span> get_io_flags_dowork_udp(struct context *c, struct multi_io *multi_io=
, const unsigned int flags)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    unsigned int out_socket, out_tuntap;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int out_socket;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
multi_io_process_flags(c, multi_io-&gt;es, flags, &amp;out_socket, &amp;out=
_tuntap);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_io=
-&gt;udp_flags =3D out_socket | out_tuntap;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    multi_io_process_flags(c, multi_io-&gt;es, flag=
s, &amp;out_socket, NULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    multi_io-&gt;udp_flags =3D (out_socket &lt;&lt; SOCKET_SHIFT);</=
span><br><span> }</span><br><span> </span><br><span> void</span><br><span>d=
iff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 3=
1134be..b03e165 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><=
span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -333,7 +333,7 @@</span><br=
><span> }</span><br><span> </span><br><span> /*</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Process an I/O event.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Process a UDP socket event.</span><br><sp=
an>  */</span><br><span> void</span><br><span> multi_process_io_udp(struct =
multi_context *m, struct link_socket *sock)</span><br><span>@@ -343,50 +343=
,11 @@</span><br><span>                                        ? (MPP_CONDI=
TIONAL_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)</span><br><span>                  =
                      : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef MULTI_DE=
BUG_EVENT_LOOP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cha=
r buf[16];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf[0] =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status =
&amp; SOCKET_READ)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strcat(buf,=
 &quot;SR/&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (status=
 &amp; SOCKET_WRITE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strcat(bu=
f, &quot;SW/&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (stat=
us &amp; TUN_READ)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strcat(buf,=
 &quot;TR/&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (status=
 &amp; TUN_WRITE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strcat(buf, =
&quot;TW/&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (status =
&amp; FILE_CLOSED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strcat(buf,=
 &quot;FC/&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;IO=
 %s\n&quot;, buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif /* ifdef MULTI_DEBUG_EVENT_LOOP */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (status &amp; (MANAGEMENT_READ | MANAGEMENT_WRITE))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        ASSERT(management);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        management_io(management);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span>     /* UDP port ready to accept write */</span><b=
r><span>     if (status &amp; SOCKET_WRITE)</span><br><span>     {</span><b=
r><span>         multi_process_outgoing_link(m, mpp_flags);</span><br><span=
>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TUN dev=
ice ready to accept write */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else if (status &amp; TUN_WRITE)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        multi_process_outgoing_tun(m, mpp_flags);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     /* Incoming da=
ta on UDP port */</span><br><span>     else if (status &amp; SOCKET_READ)</=
span><br><span>     {</span><br><span>@@ -396,35 +357,6 @@</span><br><span>=
             multi_process_incoming_link(m, NULL, mpp_flags, sock);</span><=
br><span>         }</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* Incoming data on TUN device */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    else if (status &amp; TUN_READ)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        read_incoming_tun(&amp;m-&gt;top=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!IS_SIG=
(&amp;m-&gt;top))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mult=
i_process_incoming_tun(m, mpp_flags);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABL=
E_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* IN=
OTIFY callback */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else if (status &amp; FILE_CLOSED)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     multi_process_file_closed(m, mpp_flags);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(ENABLE_DCO)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse if (status &amp; DCO_READ)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (!IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        bool ret =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            while (ret)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               ret =3D multi_process_incoming_dco(m);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span> </span><br><span>     m-&gt;multi_io-&gt;udp_flags =3D =
ES_ERROR;</span><br><span> }</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail">cha=
nge 1364</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a5110a0583b8b33496b06d9c27=
c1084df38e842 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1364 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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

</body></html>=

--BcmgBzbjpKg=--

