From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 16 Oct 2025 11:21:16 +0000
In-Reply-To: <gerrit.1760525463000.I70620aca638847168f06b0fb23cc04bd279d7df9@...2715...>
References: <gerrit.1760525463000.I70620aca638847168f06b0fb23cc04bd279d7df9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d9e1f7c6a8a55df40cf4cd3c641bc766e04bdcfe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8H8ktI5fkoo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: proxy: factor out
 recv_char code common with socks proxy
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

--8H8ktI5fkoo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
78?usp=3Demail )

Change subject: proxy: factor out recv_char code common with socks proxy
......................................................................

proxy: factor out recv_char code common with socks proxy

Change-Id: I70620aca638847168f06b0fb23cc04bd279d7df9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1278
Message-Id: <20251016103143.4461-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59247456/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/proxy.c
M src/openvpn/proxy.h
M src/openvpn/socks.c
3 files changed, 65 insertions(+), 94 deletions(-)




diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index dfe1e59..4205991 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -57,6 +57,50 @@
 /* cached proxy username/password */
 static struct user_pass static_proxy_user_pass;

+bool
+proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
+                struct timeval *timeout, volatile int *signal_received)
+{
+    fd_set reads;
+    FD_ZERO(&reads);
+    openvpn_fd_set(sd, &reads);
+
+    const int status =3D openvpn_select(sd + 1, &reads, NULL, NULL, timeou=
t);
+
+    get_signal(signal_received);
+    if (*signal_received)
+    {
+        return false;
+    }
+
+    /* timeout? */
+    if (status =3D=3D 0)
+    {
+        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read timeout expired", =
name);
+        return false;
+    }
+
+    /* error */
+    if (status < 0)
+    {
+        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read failed on select()=
", name);
+        return false;
+    }
+
+    /* read single char */
+    const ssize_t size =3D recv(sd, (void *)c, 1, MSG_NOSIGNAL);
+
+    /* error? */
+    if (size !=3D 1)
+    {
+        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read failed on recv()",=
 name);
+        return false;
+    }
+
+    return true;
+}
+
+
 static bool
 recv_line(socket_descriptor_t sd, char *buf, int len, const int timeout_se=
c, const bool verbose,
           struct buffer *lookahead, volatile int *signal_received)
@@ -72,9 +116,6 @@

     while (true)
     {
-        int status;
-        ssize_t size;
-        fd_set reads;
         struct timeval tv;
         uint8_t c;

@@ -83,50 +124,12 @@
             ASSERT(buf_init(&la, 0));
         }

-        FD_ZERO(&reads);
-        openvpn_fd_set(sd, &reads);
         tv.tv_sec =3D timeout_sec;
         tv.tv_usec =3D 0;

-        status =3D openvpn_select(sd + 1, &reads, NULL, NULL, &tv);
-
-        get_signal(signal_received);
-        if (*signal_received)
+        if (!proxy_recv_char(&c, "recv_line", sd, &tv, signal_received))
         {
-            goto error;
-        }
-
-        /* timeout? */
-        if (status =3D=3D 0)
-        {
-            if (verbose)
-            {
-                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read tim=
eout expired");
-            }
-            goto error;
-        }
-
-        /* error */
-        if (status < 0)
-        {
-            if (verbose)
-            {
-                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read fai=
led on select()");
-            }
-            goto error;
-        }
-
-        /* read single char */
-        size =3D recv(sd, (void *)&c, 1, MSG_NOSIGNAL);
-
-        /* error? */
-        if (size !=3D 1)
-        {
-            if (verbose)
-            {
-                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read fai=
led on recv()");
-            }
-            goto error;
+            return false;
         }

 #if 0
@@ -179,9 +182,6 @@
     }

     return true;
-
-error:
-    return false;
 }

 static bool
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index be16d83..3bfa687 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -80,6 +80,9 @@

 void http_proxy_close(struct http_proxy_info *hp);

+bool proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
+                     struct timeval *timeout, volatile int *signal_receive=
d);
+
 bool establish_http_proxy_passthru(struct http_proxy_info *p,
                                    socket_descriptor_t sd, /* already open=
 to proxy */
                                    const char *host,       /* openvpn serv=
er remote */
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index d383ef7..9dc013e 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -81,7 +81,7 @@
 }

 static bool
-socks_proxy_recv_char(char *c, const char *name, socket_descriptor_t sd,
+socks_proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
                       struct event_timeout *server_poll_timeout,
                       volatile int *signal_received)
 {
@@ -93,39 +93,7 @@
     tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeout);
     tv.tv_usec =3D 0;

-    const int status =3D openvpn_select(sd + 1, &reads, NULL, NULL, &tv);
-
-    get_signal(signal_received);
-    if (*signal_received)
-    {
-        return false;
-    }
-
-    /* timeout? */
-    if (status =3D=3D 0)
-    {
-        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read timeout expired", =
name);
-        return false;
-    }
-
-    /* error */
-    if (status < 0)
-    {
-        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read failed on select()=
", name);
-        return false;
-    }
-
-    /* read single char */
-    const ssize_t size =3D recv(sd, c, 1, MSG_NOSIGNAL);
-
-    /* error? */
-    if (size !=3D 1)
-    {
-        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read failed on recv()",=
 name);
-        return false;
-    }
-
-    return true;
+    return proxy_recv_char(c, name, sd, &tv, signal_received);
 }

 static bool
@@ -165,10 +133,10 @@
     }

     int len =3D 0;
-    char buf[2];
+    uint8_t buf[2];
     while (len < 2)
     {
-        char c;
+        uint8_t c;

         if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, =
signal_received))
         {
@@ -196,12 +164,12 @@
 socks_handshake(struct socks_proxy_info *p, socket_descriptor_t sd,
                 struct event_timeout *server_poll_timeout, volatile int *s=
ignal_received)
 {
-    char buf[2];
+    uint8_t buf[2];
     int len =3D 0;
     ssize_t size;

     /* VER =3D 5, NMETHODS =3D 1, METHODS =3D [0 (no auth)] */
-    char method_sel[3] =3D { 0x05, 0x01, 0x00 };
+    uint8_t method_sel[3] =3D { 0x05, 0x01, 0x00 };
     if (p->authfile[0])
     {
         method_sel[2] =3D 0x02; /* METHODS =3D [2 (plain login)] */
@@ -215,7 +183,7 @@
=20
     while (len < 2)
     {
-        char c;
+        uint8_t c;

         if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, =
signal_received))
         {
@@ -226,7 +194,7 @@
     }

     /* VER =3D=3D 5 */
-    if (buf[0] !=3D '\x05')
+    if (buf[0] !=3D 5)
     {
         msg(D_LINK_ERRORS, "socks_handshake: Socks proxy returned bad stat=
us");
         return false;
@@ -273,7 +241,7 @@
 recv_socks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *addr,
                  struct event_timeout *server_poll_timeout, volatile int *=
signal_received)
 {
-    char atyp =3D '\0';
+    uint8_t atyp =3D 0;
     int alen =3D 0;
     int len =3D 0;
     char buf[270]; /* 4 + alen(max 256) + 2 */
@@ -287,7 +255,7 @@

     while (len < 4 + alen + 2)
     {
-        char c;
+        uint8_t c;

         if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, =
signal_received))
         {
@@ -303,18 +271,18 @@
         {
             switch (atyp)
             {
-                case '\x01': /* IP V4 */
+                case 1: /* IP V4 */
                     alen =3D 4;
                     break;

-                case '\x03': /* DOMAINNAME */
+                case 3: /* DOMAINNAME */
                     /* RFC 1928, section 5: 1 byte length, <n> bytes name,
                      * so the total "address length" is (length+1)
                      */
-                    alen =3D (unsigned char)c + 1;
+                    alen =3D c + 1;
                     break;

-                case '\x04': /* IP V6 */
+                case 4: /* IP V6 */
                     alen =3D 16;
                     break;

@@ -333,14 +301,14 @@
     }

     /* VER =3D=3D 5 && REP =3D=3D 0 (succeeded) */
-    if (buf[0] !=3D '\x05' || buf[1] !=3D '\x00')
+    if (buf[0] !=3D 5 || buf[1] !=3D 0)
     {
         msg(D_LINK_ERRORS, "recv_socks_reply: Socks proxy returned bad rep=
ly");
         return false;
     }

     /* ATYP =3D=3D 1 (IP V4 address) */
-    if (atyp =3D=3D '\x01' && addr !=3D NULL)
+    if (atyp =3D=3D 1 && addr !=3D NULL)
     {
         memcpy(&addr->addr.in4.sin_addr, buf + 4, sizeof(addr->addr.in4.si=
n_addr));
         memcpy(&addr->addr.in4.sin_port, buf + 8, sizeof(addr->addr.in4.si=
n_port));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1278?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70620aca638847168f06b0fb23cc04bd279d7df9
Gerrit-Change-Number: 1278
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8H8ktI5fkoo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1278?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">proxy: factor out recv_char code common with soc=
ks proxy<br><br>Change-Id: I70620aca638847168f06b0fb23cc04bd279d7df9<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/o=
penvpn/+/1278<br>Message-Id: &lt;20251016103143.4461-1-gert@...1296...&gt;<=
br>URL: https://sourceforge.net/p/openvpn/mailman/message/59247456/<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/pro=
xy.c<br>M src/openvpn/proxy.h<br>M src/openvpn/socks.c<br>3 files changed, =
65 insertions(+), 94 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>i=
ndex dfe1e59..4205991 100644</span><br><span>--- a/src/openvpn/proxy.c</spa=
n><br><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -57,6 +57,50 @@</s=
pan><br><span> /* cached proxy username/password */</span><br><span> static=
 struct user_pass static_proxy_user_pass;</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+proxy_recv_char(uint8_t *c, const char *name, sock=
et_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                struct timeval *timeout, volatile int *signal_received)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    fd_set reads;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    FD_ZERO(&amp;reads);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    openvpn_fd_set(sd, &amp;reads);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const int status =3D openvpn_select=
(sd + 1, &amp;reads, NULL, NULL, timeout);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    get_signal(signal_received);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (*signal_received)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* timeout? */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (status =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LINK_ERRORS | M_ER=
RNO, &quot;%s: TCP port read timeout expired&quot;, name);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* error */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (status &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(D_LINK_ERRORS | M_ERRNO, &quot;%s: TCP port read failed on select()&qu=
ot;, name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* read single char */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =3D recv(=
sd, (void *)c, 1, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 error? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (s=
ize !=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LINK_ERR=
ORS | M_ERRNO, &quot;%s: TCP port read failed on recv()&quot;, name);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> sta=
tic bool</span><br><span> recv_line(socket_descriptor_t sd, char *buf, int =
len, const int timeout_sec, const bool verbose,</span><br><span>           =
struct buffer *lookahead, volatile int *signal_received)</span><br><span>@@=
 -72,9 +116,6 @@</span><br><span> </span><br><span>     while (true)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 ssize_t size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 fd_set reads;</span><br><span>         struct timeval tv;</span><br><span>=
         uint8_t c;</span><br><span> </span><br><span>@@ -83,50 +124,12 @@<=
/span><br><span>             ASSERT(buf_init(&amp;la, 0));</span><br><span>=
         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        FD_ZERO(&amp;reads);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        openvpn_fd_set(sd, &amp;reads);</span><br><span>     =
    tv.tv_sec =3D timeout_sec;</span><br><span>         tv.tv_usec =3D 0;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   status =3D openvpn_select(sd + 1, &amp;reads, NULL, NULL, &amp;tv);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        get_signal(signal_received);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (*signal_received)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!proxy_rec=
v_char(&amp;c, &quot;recv_line&quot;, sd, &amp;tv, signal_received))</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        /* timeout? */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=3D 0)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (verbose)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                msg(D_LINK_ERRORS | M_ERR=
NO, &quot;recv_line: TCP port read timeout expired&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            goto error;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /* error */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (status &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (verbose)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 msg(D_LINK_ERRORS | M_ERRNO, &quot;recv_line: TCP port read failed on sele=
ct()&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto =
error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* read single char */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        size =3D recv(sd, (void *)&amp;=
c, 1, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* error? */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (size !=3D 1=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            if (verbose)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                msg(D_LINK_ERRORS | M=
_ERRNO, &quot;recv_line: TCP port read failed on recv()&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            goto error;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><=
span>         }</span><br><span> </span><br><span> #if 0</span><br><span>@@=
 -179,9 +182,6 @@</span><br><span>     }</span><br><span> </span><br><span>=
     return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-error:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br><span> }</sp=
an><br><span> </span><br><span> static bool</span><br><span>diff --git a/sr=
c/openvpn/proxy.h b/src/openvpn/proxy.h</span><br><span>index be16d83..3bfa=
687 100644</span><br><span>--- a/src/openvpn/proxy.h</span><br><span>+++ b/=
src/openvpn/proxy.h</span><br><span>@@ -80,6 +80,9 @@</span><br><span> </sp=
an><br><span> void http_proxy_close(struct http_proxy_info *hp);</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool proxy_r=
ecv_char(uint8_t *c, const char *name, socket_descriptor_t sd,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                     struct time=
val *timeout, volatile int *signal_received);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> bool establish_http_proxy_passt=
hru(struct http_proxy_info *p,</span><br><span>                            =
        socket_descriptor_t sd, /* already open to proxy */</span><br><span=
>                                    const char *host,       /* openvpn ser=
ver remote */</span><br><span>diff --git a/src/openvpn/socks.c b/src/openvp=
n/socks.c</span><br><span>index d383ef7..9dc013e 100644</span><br><span>---=
 a/src/openvpn/socks.c</span><br><span>+++ b/src/openvpn/socks.c</span><br>=
<span>@@ -81,7 +81,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_p=
roxy_recv_char(char *c, const char *name, socket_descriptor_t sd,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+socks_proxy_recv_char(uint8_t=
 *c, const char *name, socket_descriptor_t sd,</span><br><span>            =
           struct event_timeout *server_poll_timeout,</span><br><span>     =
                  volatile int *signal_received)</span><br><span> {</span><=
br><span>@@ -93,39 +93,7 @@</span><br><span>     tv.tv_sec =3D get_server_p=
oll_remaining_time(server_poll_timeout);</span><br><span>     tv.tv_usec =
=3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const int status =3D openvpn_select(sd + 1, &amp;reads, NULL, NULL, =
&amp;tv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    get_signal(signal_received);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (*signal_receiv=
ed)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* timeout? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (status =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
D_LINK_ERRORS | M_ERRNO, &quot;%s: TCP port read timeout expired&quot;, nam=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return fal=
se;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* error */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (status &lt; 0)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msg(D_LINK_ERRORS | M_ERRNO, &quot;%s: TCP port read failed on selec=
t()&quot;, name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* read single char */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const ssize_t size =3D recv(sd, =
c, 1, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* error? */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (size !=3D 1)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_LINK_ERRORS | M_ERRNO, &quot;=
%s: TCP port read failed on recv()&quot;, name);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return pr=
oxy_recv_char(c, name, sd, &amp;tv, signal_received);</span><br><span> }</s=
pan><br><span> </span><br><span> static bool</span><br><span>@@ -165,10 +13=
3,10 @@</span><br><span>     }</span><br><span> </span><br><span>     int l=
en =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char buf=
[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t buf=
[2];</span><br><span>     while (len &lt; 2)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        char c;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        uint8_t c;</span><br><spa=
n> </span><br><span>         if (!socks_proxy_recv_char(&amp;c, __func__, s=
d, server_poll_timeout, signal_received))</span><br><span>         {</span>=
<br><span>@@ -196,12 +164,12 @@</span><br><span> socks_handshake(struct soc=
ks_proxy_info *p, socket_descriptor_t sd,</span><br><span>                 =
struct event_timeout *server_poll_timeout, volatile int *signal_received)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
char buf[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t8_t buf[2];</span><br><span>     int len =3D 0;</span><br><span>     ssize=
_t size;</span><br><span> </span><br><span>     /* VER =3D 5, NMETHODS =3D =
1, METHODS =3D [0 (no auth)] */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    char method_sel[3] =3D { 0x05, 0x01, 0x00 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    uint8_t method_sel[3] =3D { 0x05=
, 0x01, 0x00 };</span><br><span>     if (p-&gt;authfile[0])</span><br><span=
>     {</span><br><span>         method_sel[2] =3D 0x02; /* METHODS =3D [2 =
(plain login)] */</span><br><span>@@ -215,7 +183,7 @@</span><br><span> </sp=
an><br><span>     while (len &lt; 2)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        char c;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uint8_t c;</span><br><span> </spa=
n><br><span>         if (!socks_proxy_recv_char(&amp;c, __func__, sd, serve=
r_poll_timeout, signal_received))</span><br><span>         {</span><br><spa=
n>@@ -226,7 +194,7 @@</span><br><span>     }</span><br><span> </span><br><s=
pan>     /* VER =3D=3D 5 */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (buf[0] !=3D &#39;\x05&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (buf[0] !=3D 5)</span><br><span>     {</span><=
br><span>         msg(D_LINK_ERRORS, &quot;socks_handshake: Socks proxy ret=
urned bad status&quot;);</span><br><span>         return false;</span><br><=
span>@@ -273,7 +241,7 @@</span><br><span> recv_socks_reply(socket_descripto=
r_t sd, struct openvpn_sockaddr *addr,</span><br><span>                  st=
ruct event_timeout *server_poll_timeout, volatile int *signal_received)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ch=
ar atyp =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint8_t atyp =3D 0;</span><br><span>     int alen =3D 0;</span><b=
r><span>     int len =3D 0;</span><br><span>     char buf[270]; /* 4 + alen=
(max 256) + 2 */</span><br><span>@@ -287,7 +255,7 @@</span><br><span> </spa=
n><br><span>     while (len &lt; 4 + alen + 2)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        char c;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t c;</span><br><s=
pan> </span><br><span>         if (!socks_proxy_recv_char(&amp;c, __func__,=
 sd, server_poll_timeout, signal_received))</span><br><span>         {</spa=
n><br><span>@@ -303,18 +271,18 @@</span><br><span>         {</span><br><spa=
n>             switch (atyp)</span><br><span>             {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                case &#39;\x01&#39;: =
/* IP V4 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        case 1: /* IP V4 */</span><br><span>                     alen =3D 4=
;</span><br><span>                     break;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                case &#39;\x03&#3=
9;: /* DOMAINNAME */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                case 3: /* DOMAINNAME */</span><br><span>                 =
    /* RFC 1928, section 5: 1 byte length, &lt;n&gt; bytes name,</span><br>=
<span>                      * so the total &quot;address length&quot; is (l=
ength+1)</span><br><span>                      */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    alen =3D (unsigned char)c +=
 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    alen =3D c + 1;</span><br><span>                     break;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 case &#39;\x04&#39;: /* IP V6 */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                case 4: /* IP V6 */</span><br><span>         =
            alen =3D 16;</span><br><span>                     break;</span>=
<br><span> </span><br><span>@@ -333,14 +301,14 @@</span><br><span>     }</s=
pan><br><span> </span><br><span>     /* VER =3D=3D 5 &amp;&amp; REP =3D=3D =
0 (succeeded) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (buf[0] !=3D &#39;\x05&#39; || buf[1] !=3D &#39;\x00&#39;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (buf[0] !=3D 5 || buf[1] !=
=3D 0)</span><br><span>     {</span><br><span>         msg(D_LINK_ERRORS, &=
quot;recv_socks_reply: Socks proxy returned bad reply&quot;);</span><br><sp=
an>         return false;</span><br><span>     }</span><br><span> </span><b=
r><span>     /* ATYP =3D=3D 1 (IP V4 address) */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (atyp =3D=3D &#39;\x01&#39; &amp;&amp; ad=
dr !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (atyp =3D=3D 1 &amp;&amp; addr !=3D NULL)</span><br><span>     {</span><br=
><span>         memcpy(&amp;addr-&gt;addr.in4.sin_addr, buf + 4, sizeof(add=
r-&gt;addr.in4.sin_addr));</span><br><span>         memcpy(&amp;addr-&gt;ad=
dr.in4.sin_port, buf + 8, sizeof(addr-&gt;addr.in4.sin_port));</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1278?usp=3Demail">change 1278</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1278?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70620aca638847168f06b0fb23c=
c04bd279d7df9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1278 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--8H8ktI5fkoo=--

