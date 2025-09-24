From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 14:57:58 +0000
In-Reply-To: <gerrit.1758036965000.Id070d1a45d45f9029309d23df7f3cab9ce792205@...2715...>
References: <gerrit.1758036965000.Id070d1a45d45f9029309d23df7f3cab9ce792205@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4714245336b14774b4e3e1ccfbb5c779818500cb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H3d46lcw0ts="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ps: Fix conversion
 warnings related to send/recv return values
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--H3d46lcw0ts=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1194?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: ps: Fix conversion warnings related to send/recv return val=
ues
......................................................................

ps: Fix conversion warnings related to send/recv return values

We know that these values can't be big since they are limited
to the size of the input buffer. So we can explicitly cast
them to int if required.

Change-Id: Id070d1a45d45f9029309d23df7f3cab9ce792205
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1194
Message-Id: <20250924082121.23139-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59237926/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ps.c
1 file changed, 9 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1194/8

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 1d14367..31e7c25 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -475,11 +475,6 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * This function runs in the context of the background proxy process.
  * Receive a control message from the parent (sent by the port_share_sendm=
sg
@@ -539,7 +534,7 @@

             if (status >=3D 2 && command =3D=3D COMMAND_REDIRECT)
             {
-                buf.len =3D status - 1;
+                buf.len =3D (int)status - 1;
                 if (proxy_entry_new(list, es, server_addr, received_fd, &b=
uf, journal_dir))
                 {
                     CLEAR(buf); /* we gave the buffer to proxy_entry_new */
@@ -566,7 +561,7 @@
 proxy_connection_io_recv(struct proxy_connection *pc)
 {
     /* recv data from socket */
-    const int status =3D recv(pc->sd, BPTR(&pc->buf), BCAP(&pc->buf), MSG_=
NOSIGNAL);
+    const ssize_t status =3D recv(pc->sd, BPTR(&pc->buf), BCAP(&pc->buf), =
MSG_NOSIGNAL);
     if (status < 0)
     {
         return (errno =3D=3D EAGAIN) ? IOSTAT_EAGAIN_ON_READ : IOSTAT_READ=
_ERROR;
@@ -577,8 +572,8 @@
         {
             return IOSTAT_READ_ERROR;
         }
-        dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: read[%d] %d", (int)pc->s=
d, status);
-        pc->buf.len =3D status;
+        dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: read[%d] %zd", (int)pc->=
sd, status);
+        pc->buf.len =3D (int)status;
     }
     return IOSTAT_GOOD;
 }
@@ -587,7 +582,7 @@
 proxy_connection_io_send(struct proxy_connection *pc, int *bytes_sent)
 {
     const socket_descriptor_t sd =3D pc->counterpart->sd;
-    const int status =3D send(sd, BPTR(&pc->buf), BLEN(&pc->buf), MSG_NOSI=
GNAL);
+    const ssize_t status =3D send(sd, BPTR(&pc->buf), BLEN(&pc->buf), MSG_=
NOSIGNAL);

     if (status < 0)
     {
@@ -596,17 +591,17 @@
     }
     else
     {
-        *bytes_sent +=3D status;
+        *bytes_sent +=3D (int)status;
         if (status !=3D pc->buf.len)
         {
-            dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: partial write[%d], t=
ried=3D%d got=3D%d", (int)sd,
+            dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: partial write[%d], t=
ried=3D%d got=3D%zd", (int)sd,
                  pc->buf.len, status);
-            buf_advance(&pc->buf, status);
+            buf_advance(&pc->buf, (int)status);
             return IOSTAT_EAGAIN_ON_WRITE;
         }
         else
         {
-            dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: wrote[%d] %d", (int)=
sd, status);
+            dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: wrote[%d] %zd", (int=
)sd, status);
             pc->buf.len =3D 0;
             pc->buf.offset =3D 0;
         }
@@ -797,10 +792,6 @@
     msg(M_INFO, "PORT SHARE PROXY: proxy exiting");
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Called from the main OpenVPN process to enable the port
  * share proxy.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1194?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id070d1a45d45f9029309d23df7f3cab9ce792205
Gerrit-Change-Number: 1194
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--H3d46lcw0ts=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #8</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1194?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">ps: Fix conversion warnings related to send/recv ret=
urn values<br><br>We know that these values can&#39;t be big since they are=
 limited<br>to the size of the input buffer. So we can explicitly cast<br>t=
hem to int if required.<br><br>Change-Id: Id070d1a45d45f9029309d23df7f3cab9=
ce792205<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Ac=
ked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.=
openvpn.net/c/openvpn/+/1194<br>Message-Id: &lt;20250924082121.23139-1-gert=
@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/5=
9237926/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/openvpn/ps.c<br>1 file changed, 9 insertions(+), 18 deletions(-)<br><b=
r></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1194/8=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span><br><span>i=
ndex 1d14367..31e7c25 100644</span><br><span>--- a/src/openvpn/ps.c</span><=
br><span>+++ b/src/openvpn/ps.c</span><br><span>@@ -475,11 +475,6 @@</span>=
<br><span>     return true;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * This function run=
s in the context of the background proxy process.</span><br><span>  * Recei=
ve a control message from the parent (sent by the port_share_sendmsg</span>=
<br><span>@@ -539,7 +534,7 @@</span><br><span> </span><br><span>           =
  if (status &gt;=3D 2 &amp;&amp; command =3D=3D COMMAND_REDIRECT)</span><b=
r><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                buf.len =3D status - 1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                buf.len =3D (int)status - 1;</span><br=
><span>                 if (proxy_entry_new(list, es, server_addr, received=
_fd, &amp;buf, journal_dir))</span><br><span>                 {</span><br><=
span>                     CLEAR(buf); /* we gave the buffer to proxy_entry_=
new */</span><br><span>@@ -566,7 +561,7 @@</span><br><span> proxy_connectio=
n_io_recv(struct proxy_connection *pc)</span><br><span> {</span><br><span> =
    /* recv data from socket */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    const int status =3D recv(pc-&gt;sd, BPTR(&amp;pc-&gt;buf), B=
CAP(&amp;pc-&gt;buf), MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const ssize_t status =3D recv(pc-&gt;sd, BPTR(&amp;pc-=
&gt;buf), BCAP(&amp;pc-&gt;buf), MSG_NOSIGNAL);</span><br><span>     if (st=
atus &lt; 0)</span><br><span>     {</span><br><span>         return (errno =
=3D=3D EAGAIN) ? IOSTAT_EAGAIN_ON_READ : IOSTAT_READ_ERROR;</span><br><span=
>@@ -577,8 +572,8 @@</span><br><span>         {</span><br><span>           =
  return IOSTAT_READ_ERROR;</span><br><span>         }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_PS_PROXY_DEBUG, &quot;PORT =
SHARE PROXY: read[%d] %d&quot;, (int)pc-&gt;sd, status);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        pc-&gt;buf.len =3D status;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_PS_PROXY_D=
EBUG, &quot;PORT SHARE PROXY: read[%d] %zd&quot;, (int)pc-&gt;sd, status);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pc-&gt;buf.l=
en =3D (int)status;</span><br><span>     }</span><br><span>     return IOST=
AT_GOOD;</span><br><span> }</span><br><span>@@ -587,7 +582,7 @@</span><br><=
span> proxy_connection_io_send(struct proxy_connection *pc, int *bytes_sent=
)</span><br><span> {</span><br><span>     const socket_descriptor_t sd =3D =
pc-&gt;counterpart-&gt;sd;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const int status =3D send(sd, BPTR(&amp;pc-&gt;buf), BLEN(&amp;pc-=
&gt;buf), MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const ssize_t status =3D send(sd, BPTR(&amp;pc-&gt;buf), BLEN(&amp=
;pc-&gt;buf), MSG_NOSIGNAL);</span><br><span> </span><br><span>     if (sta=
tus &lt; 0)</span><br><span>     {</span><br><span>@@ -596,17 +591,17 @@</s=
pan><br><span>     }</span><br><span>     else</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        *bytes_sent +=3D st=
atus;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *bytes=
_sent +=3D (int)status;</span><br><span>         if (status !=3D pc-&gt;buf=
.len)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            dmsg(D_PS_PROXY_DEBUG, &quot;PORT SHARE PROXY: parti=
al write[%d], tried=3D%d got=3D%d&quot;, (int)sd,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            dmsg(D_PS_PROXY_DEBUG, &quot;PORT=
 SHARE PROXY: partial write[%d], tried=3D%d got=3D%zd&quot;, (int)sd,</span=
><br><span>                  pc-&gt;buf.len, status);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            buf_advance(&amp;pc-&gt;buf, st=
atus);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            b=
uf_advance(&amp;pc-&gt;buf, (int)status);</span><br><span>             retu=
rn IOSTAT_EAGAIN_ON_WRITE;</span><br><span>         }</span><br><span>     =
    else</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            dmsg(D_PS_PROXY_DEBUG, &quot;PORT SHARE PROXY: wr=
ote[%d] %d&quot;, (int)sd, status);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            dmsg(D_PS_PROXY_DEBUG, &quot;PORT SHARE PROXY: =
wrote[%d] %zd&quot;, (int)sd, status);</span><br><span>             pc-&gt;=
buf.len =3D 0;</span><br><span>             pc-&gt;buf.offset =3D 0;</span>=
<br><span>         }</span><br><span>@@ -797,10 +792,6 @@</span><br><span> =
    msg(M_INFO, &quot;PORT SHARE PROXY: proxy exiting&quot;);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> /*</span><br><span>  * Called from the main=
 OpenVPN process to enable the port</span><br><span>  * share proxy.</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1194?usp=3Demail">change 1194</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1194?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id070d1a45d45f9029309d23df7f=
3cab9ce792205 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1194 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--H3d46lcw0ts=--

