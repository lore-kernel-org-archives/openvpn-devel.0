From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 11 Nov 2025 11:55:22 +0000
References: <gerrit.1762862118000.I6a5110a0583b8b33496b06d9c27c1084df38e842@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e6708c60498c0f5917239ce2ed51d5fdc32d9b0d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X9GwdYl0cfc="; charset=UTF-8
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

--X9GwdYl0cfc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail

to review the following change.


Change subject: multi-socket: do not return tuntap flags on server-side
......................................................................

multi-socket: do not return tuntap flags on server-side

Tuntap flags are already handled within
multi_io_process_io() so return them by
multi_io_process_flags() would be redoundant,
since we need them only for tun_set().

While at it, removed part of the I/O process
from multi_process_io_udp() since those are
also handled within multi_io_process_io().

Change-Id: I6a5110a0583b8b33496b06d9c27c1084df38e842
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/mudp.c
2 files changed, 3 insertions(+), 57 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1364/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index c355f66..211cdc8 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2158,10 +2158,10 @@
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
index 31134be..71c742f 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -354,39 +354,14 @@
     {
         strcat(buf, "SW/");
     }
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
     printf("IO %s\n", buf);
 #endif /* ifdef MULTI_DEBUG_EVENT_LOOP */

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
@@ -396,35 +371,6 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6a5110a0583b8b33496b06d9c27c1084df38e842
Gerrit-Change-Number: 1364
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--X9GwdYl0cfc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1364?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">multi-socket: do not return tuntap flags on=
 server-side<br><br>Tuntap flags are already handled within<br>multi_io_pro=
cess_io() so return them by<br>multi_io_process_flags() would be redoundant=
,<br>since we need them only for tun_set().<br><br>While at it, removed par=
t of the I/O process<br>from multi_process_io_udp() since those are<br>also=
 handled within multi_io_process_io().<br><br>Change-Id: I6a5110a0583b8b334=
96b06d9c27c1084df38e842<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarc=
o@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/mudp.c<=
br>2 files changed, 3 insertions(+), 57 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1364/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><=
br><span>index c355f66..211cdc8 100644</span><br><span>--- a/src/openvpn/fo=
rward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -215=
8,10 +2158,10 @@</span><br><span> void</span><br><span> get_io_flags_dowork=
_udp(struct context *c, struct multi_io *multi_io, const unsigned int flags=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   unsigned int out_socket, out_tuntap;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    unsigned int out_socket;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    multi_io_process_flags(c, =
multi_io-&gt;es, flags, &amp;out_socket, &amp;out_tuntap);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    multi_io-&gt;udp_flags =3D out_soc=
ket | out_tuntap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  multi_io_process_flags(c, multi_io-&gt;es, flags, &amp;out_socket, NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;ud=
p_flags =3D (out_socket &lt;&lt; SOCKET_SHIFT);</span><br><span> }</span><b=
r><span> </span><br><span> void</span><br><span>diff --git a/src/openvpn/mu=
dp.c b/src/openvpn/mudp.c</span><br><span>index 31134be..71c742f 100644</sp=
an><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mud=
p.c</span><br><span>@@ -354,39 +354,14 @@</span><br><span>     {</span><br>=
<span>         strcat(buf, &quot;SW/&quot;);</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (status &amp; TUN=
_READ)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        strcat(buf, &quot;TR/&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else if (status &amp; TUN_W=
RITE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        strcat(buf, &quot;TW/&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    else if (status &amp; FILE_C=
LOSED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        strcat(buf, &quot;FC/&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span>     printf(&quot;IO %s\n&quot;, buf);</span><br><span> #endif /* if=
def MULTI_DEBUG_EVENT_LOOP */</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (status &amp; (MANAGEMENT_READ | MANAGE=
MENT_WRITE))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(management=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        management_=
io(management);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* UDP port rea=
dy to accept write */</span><br><span>     if (status &amp; SOCKET_WRITE)</=
span><br><span>     {</span><br><span>         multi_process_outgoing_link(=
m, mpp_flags);</span><br><span>     }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    /* TUN device ready to accept write */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    else if (status &amp; TUN_WRITE)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        multi_process_outgoing_tun(m, m=
pp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span>     /* Incoming data on UDP port */</span><br><span>     else i=
f (status &amp; SOCKET_READ)</span><br><span>     {</span><br><span>@@ -396=
,35 +371,6 @@</span><br><span>             multi_process_incoming_link(m, N=
ULL, mpp_flags, sock);</span><br><span>         }</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Incoming data on =
TUN device */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else=
 if (status &amp; TUN_READ)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
ad_incoming_tun(&amp;m-&gt;top);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            multi_process_incoming_tun(m, mpp_flags);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* INOTIFY callback */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    else if (status &amp; FILE_CLOSED)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        multi_process_file_closed(m, mpp_flags);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(ENABLE_DCO)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    else if (status &amp; DCO_READ)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (!IS_SIG(&amp;m-&gt;top))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            bool ret =3D true;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            while (ret)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                ret =3D multi_process_incoming=
_dco(m);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br><span>     m-&=
gt;multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span> }</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1364?usp=3Demail">change 1364</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1364?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a5110a0583b8b33496b06d9c27=
c1084df38e842 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1364 </div>
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

</body></html>=

--X9GwdYl0cfc=--

