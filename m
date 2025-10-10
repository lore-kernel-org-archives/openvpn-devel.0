From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 10:53:55 +0000
In-Reply-To: <gerrit.1759942426000.I977bab08cb614c2d59c34ceebc112f3add9bd168@...2715...>
References: <gerrit.1759942426000.I977bab08cb614c2d59c34ceebc112f3add9bd168@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <7d23d487c02236a795c902116a5691bc1a5a1498-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9GZPEWaZv54="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socks: Fix
 conversion warnings with MinGW
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9GZPEWaZv54=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
62?usp=3Demail )

Change subject: socks: Fix conversion warnings with MinGW
......................................................................

socks: Fix conversion warnings with MinGW

The winsock2 APIs are a bit weird at times...

Change-Id: I977bab08cb614c2d59c34ceebc112f3add9bd168
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1262
Message-Id: <20251010095706.3779-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59244802/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socks.c
1 file changed, 11 insertions(+), 17 deletions(-)




diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 85bbde5..1a75daf 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -80,11 +80,6 @@
     free(sp);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static bool
 socks_proxy_recv_char(char *c, const char *name, socket_descriptor_t sd,
                       struct event_timeout *server_poll_timeout,
@@ -98,7 +93,8 @@
     tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeout);
     tv.tv_usec =3D 0;

-    const int status =3D select(sd + 1, &reads, NULL, NULL, &tv);
+    /* NB: first argument ignored on Windows where socket_descriptor_t !=
=3D int */
+    const int status =3D select((int)sd + 1, &reads, NULL, NULL, &tv);

     get_signal(signal_received);
     if (*signal_received)
@@ -139,10 +135,7 @@
                              volatile int *signal_received)
 {
     char to_send[516];
-    char buf[2];
-    int len =3D 0;
     struct user_pass creds;
-    ssize_t size;
     bool ret =3D false;

     CLEAR(creds);
@@ -161,9 +154,10 @@

     int sret =3D snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s", (int)s=
trlen(creds.username),
                         creds.username, (int)strlen(creds.password), creds=
.password);
-    ASSERT(sret <=3D sizeof(to_send));
+    ASSERT(sret >=3D 0 && sret <=3D sizeof(to_send));

-    size =3D send(sd, to_send, strlen(to_send), MSG_NOSIGNAL);
+    /* NB: int because Windows APIs */
+    ssize_t size =3D send(sd, to_send, (int)strlen(to_send), MSG_NOSIGNAL);

     if (size !=3D strlen(to_send))
     {
@@ -172,6 +166,8 @@
         goto cleanup;
     }

+    int len =3D 0;
+    char buf[2];
     while (len < 2)
     {
         char c;
@@ -419,8 +415,10 @@
     buf[5 + len + 1] =3D (char)(port & 0xff);

     {
-        const ssize_t size =3D send(sd, buf, 5 + len + 2, MSG_NOSIGNAL);
-        if ((int)size !=3D 5 + (int)len + 2)
+        /* int because Windows APIs */
+        int send_len =3D 5 + (int)len + 2;
+        const ssize_t size =3D send(sd, buf, send_len, MSG_NOSIGNAL);
+        if (size !=3D send_len)
         {
             msg(D_LINK_ERRORS | M_ERRNO,
                 "establish_socks_proxy_passthru: TCP port write failed on =
send()");
@@ -443,10 +441,6 @@
     return;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
                                socket_descriptor_t ctrl_sd, /* already ope=
n to proxy */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1262?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I977bab08cb614c2d59c34ceebc112f3add9bd168
Gerrit-Change-Number: 1262
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9GZPEWaZv54=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1262?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">socks: Fix conversion warnings with MinGW<br><br=
>The winsock2 APIs are a bit weird at times...<br><br>Change-Id: I977bab08c=
b614c2d59c34ceebc112f3add9bd168<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>=
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1262<br>Message-Id: &lt;=
20251010095706.3779-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p=
/openvpn/mailman/message/59244802/<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M src/openvpn/socks.c<br>1 file changed, 11 insert=
ions(+), 17 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c</span><br><span>i=
ndex 85bbde5..1a75daf 100644</span><br><span>--- a/src/openvpn/socks.c</spa=
n><br><span>+++ b/src/openvpn/socks.c</span><br><span>@@ -80,11 +80,6 @@</s=
pan><br><span>     free(sp);</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static bool</span><br><span> socks_proxy=
_recv_char(char *c, const char *name, socket_descriptor_t sd,</span><br><sp=
an>                       struct event_timeout *server_poll_timeout,</span>=
<br><span>@@ -98,7 +93,8 @@</span><br><span>     tv.tv_sec =3D get_server_p=
oll_remaining_time(server_poll_timeout);</span><br><span>     tv.tv_usec =
=3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const int status =3D select(sd + 1, &amp;reads, NULL, NULL, &amp;tv)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* NB: first a=
rgument ignored on Windows where socket_descriptor_t !=3D int */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const int status =3D selec=
t((int)sd + 1, &amp;reads, NULL, NULL, &amp;tv);</span><br><span> </span><b=
r><span>     get_signal(signal_received);</span><br><span>     if (*signal_=
received)</span><br><span>@@ -139,10 +135,7 @@</span><br><span>            =
                  volatile int *signal_received)</span><br><span> {</span><=
br><span>     char to_send[516];</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    char buf[2];</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int len =3D 0;</span><br><span>     struct user_pass creds;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ssize_t size;</span><br=
><span>     bool ret =3D false;</span><br><span> </span><br><span>     CLEA=
R(creds);</span><br><span>@@ -161,9 +154,10 @@</span><br><span> </span><br>=
<span>     int sret =3D snprintf(to_send, sizeof(to_send), &quot;\x01%c%s%c=
%s&quot;, (int)strlen(creds.username),</span><br><span>                    =
     creds.username, (int)strlen(creds.password), creds.password);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(sret &lt;=3D sizeof=
(to_send));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSE=
RT(sret &gt;=3D 0 &amp;&amp; sret &lt;=3D sizeof(to_send));</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D send(s=
d, to_send, strlen(to_send), MSG_NOSIGNAL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* NB: int because Windows APIs */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ssize_t size =3D send(sd, to=
_send, (int)strlen(to_send), MSG_NOSIGNAL);</span><br><span> </span><br><sp=
an>     if (size !=3D strlen(to_send))</span><br><span>     {</span><br><sp=
an>@@ -172,6 +166,8 @@</span><br><span>         goto cleanup;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char buf[2];</span><br><span>     while (len &lt; 2)</span><br><=
span>     {</span><br><span>         char c;</span><br><span>@@ -419,8 +415=
,10 @@</span><br><span>     buf[5 + len + 1] =3D (char)(port &amp; 0xff);</=
span><br><span> </span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        const ssize_t size =3D send(sd, buf, 5 + len + 2,=
 MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if ((int)size !=3D 5 + (int)len + 2)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* int because Windows APIs */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        int send_len =3D 5 + (int)len=
 + 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
ssize_t size =3D send(sd, buf, send_len, MSG_NOSIGNAL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (size !=3D send_len)</span><=
br><span>         {</span><br><span>             msg(D_LINK_ERRORS | M_ERRN=
O,</span><br><span>                 &quot;establish_socks_proxy_passthru: T=
CP port write failed on send()&quot;);</span><br><span>@@ -443,10 +441,6 @@=
</span><br><span>     return;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
void</span><br><span> establish_socks_proxy_udpassoc(struct socks_proxy_inf=
o *p,</span><br><span>                                socket_descriptor_t c=
trl_sd, /* already open to proxy */</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1262?usp=3Dema=
il">change 1262</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1262?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I977bab08cb614c2d59c34ceebc1=
12f3add9bd168 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1262 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--9GZPEWaZv54=--

