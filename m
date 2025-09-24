From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 14:58:01 +0000
In-Reply-To: <gerrit.1758036965000.Id070d1a45d45f9029309d23df7f3cab9ce792205@...2715...>
References: <gerrit.1758036965000.Id070d1a45d45f9029309d23df7f3cab9ce792205@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4714245336b14774b4e3e1ccfbb5c779818500cb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TkGVsgChGp4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TkGVsgChGp4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
94?usp=3Demail )

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
Gerrit-MessageType: merged

--TkGVsgChGp4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1194?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">ps: Fix conversion warnings related to send/r=
ecv return values<br><br>We know that these values can&#39;t be big since t=
hey are limited<br>to the size of the input buffer. So we can explicitly ca=
st<br>them to int if required.<br><br>Change-Id: Id070d1a45d45f9029309d23df=
7f3cab9ce792205<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://=
gerrit.openvpn.net/c/openvpn/+/1194<br>Message-Id: &lt;20250924082121.23139=
-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/me=
ssage/59237926/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M src/openvpn/ps.c<br>1 file changed, 9 insertions(+), 18 deletions(-=
)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span><br><span>index 1=
d14367..31e7c25 100644</span><br><span>--- a/src/openvpn/ps.c</span><br><sp=
an>+++ b/src/openvpn/ps.c</span><br><span>@@ -475,11 +475,6 @@</span><br><s=
pan>     return true;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> /*</span><br><span>  * This function runs in the=
 context of the background proxy process.</span><br><span>  * Receive a con=
trol message from the parent (sent by the port_share_sendmsg</span><br><spa=
n>@@ -539,7 +534,7 @@</span><br><span> </span><br><span>             if (st=
atus &gt;=3D 2 &amp;&amp; command =3D=3D COMMAND_REDIRECT)</span><br><span>=
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         buf.len =3D status - 1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                buf.len =3D (int)status - 1;</span><br><span> =
                if (proxy_entry_new(list, es, server_addr, received_fd, &am=
p;buf, journal_dir))</span><br><span>                 {</span><br><span>   =
                  CLEAR(buf); /* we gave the buffer to proxy_entry_new */</=
span><br><span>@@ -566,7 +561,7 @@</span><br><span> proxy_connection_io_rec=
v(struct proxy_connection *pc)</span><br><span> {</span><br><span>     /* r=
ecv data from socket */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const int status =3D recv(pc-&gt;sd, BPTR(&amp;pc-&gt;buf), BCAP(&amp=
;pc-&gt;buf), MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const ssize_t status =3D recv(pc-&gt;sd, BPTR(&amp;pc-&gt;buf)=
, BCAP(&amp;pc-&gt;buf), MSG_NOSIGNAL);</span><br><span>     if (status &lt=
; 0)</span><br><span>     {</span><br><span>         return (errno =3D=3D E=
AGAIN) ? IOSTAT_EAGAIN_ON_READ : IOSTAT_READ_ERROR;</span><br><span>@@ -577=
,8 +572,8 @@</span><br><span>         {</span><br><span>             return=
 IOSTAT_READ_ERROR;</span><br><span>         }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        dmsg(D_PS_PROXY_DEBUG, &quot;PORT SHARE PR=
OXY: read[%d] %d&quot;, (int)pc-&gt;sd, status);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        pc-&gt;buf.len =3D status;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        dmsg(D_PS_PROXY_DEBUG, &q=
uot;PORT SHARE PROXY: read[%d] %zd&quot;, (int)pc-&gt;sd, status);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        pc-&gt;buf.len =3D (=
int)status;</span><br><span>     }</span><br><span>     return IOSTAT_GOOD;=
</span><br><span> }</span><br><span>@@ -587,7 +582,7 @@</span><br><span> pr=
oxy_connection_io_send(struct proxy_connection *pc, int *bytes_sent)</span>=
<br><span> {</span><br><span>     const socket_descriptor_t sd =3D pc-&gt;c=
ounterpart-&gt;sd;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 const int status =3D send(sd, BPTR(&amp;pc-&gt;buf), BLEN(&amp;pc-&gt;buf)=
, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const ssize_t status =3D send(sd, BPTR(&amp;pc-&gt;buf), BLEN(&amp;pc-&gt;=
buf), MSG_NOSIGNAL);</span><br><span> </span><br><span>     if (status &lt;=
 0)</span><br><span>     {</span><br><span>@@ -596,17 +591,17 @@</span><br>=
<span>     }</span><br><span>     else</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        *bytes_sent +=3D status;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        *bytes_sent +=
=3D (int)status;</span><br><span>         if (status !=3D pc-&gt;buf.len)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            dmsg(D_PS_PROXY_DEBUG, &quot;PORT SHARE PROXY: partial writ=
e[%d], tried=3D%d got=3D%d&quot;, (int)sd,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            dmsg(D_PS_PROXY_DEBUG, &quot;PORT SHARE =
PROXY: partial write[%d], tried=3D%d got=3D%zd&quot;, (int)sd,</span><br><s=
pan>                  pc-&gt;buf.len, status);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            buf_advance(&amp;pc-&gt;buf, status);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_adva=
nce(&amp;pc-&gt;buf, (int)status);</span><br><span>             return IOST=
AT_EAGAIN_ON_WRITE;</span><br><span>         }</span><br><span>         els=
e</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            dmsg(D_PS_PROXY_DEBUG, &quot;PORT SHARE PROXY: wrote[%d]=
 %d&quot;, (int)sd, status);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            dmsg(D_PS_PROXY_DEBUG, &quot;PORT SHARE PROXY: wrote[%=
d] %zd&quot;, (int)sd, status);</span><br><span>             pc-&gt;buf.len=
 =3D 0;</span><br><span>             pc-&gt;buf.offset =3D 0;</span><br><sp=
an>         }</span><br><span>@@ -797,10 +792,6 @@</span><br><span>     msg=
(M_INFO, &quot;PORT SHARE PROXY: proxy exiting&quot;);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> /*</span><br><span>  * Called from the main OpenVP=
N process to enable the port</span><br><span>  * share proxy.</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1194?usp=3Demail">change 1194</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/119=
4?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--TkGVsgChGp4=--

