From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 15:40:09 +0000
In-Reply-To: <gerrit.1756814708000.I6e848df8104b6e3a6e2c3245ece91a20e473fb40@...2715...>
References: <gerrit.1756814708000.I6e848df8104b6e3a6e2c3245ece91a20e473fb40@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fc24f2f7dfb96590212932de308f10e97551861a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oHaDNXYSVic="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socks: factor out
 socks_proxy_recv_char()
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

--oHaDNXYSVic=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
65?usp=3Demail )

Change subject: socks: factor out socks_proxy_recv_char()
......................................................................

socks: factor out socks_proxy_recv_char()

This is basically identical code duplicated three
times.

Change-Id: I6e848df8104b6e3a6e2c3245ece91a20e473fb40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1165
Message-Id: <20250923151050.27336-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
171.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socks.c
1 file changed, 51 insertions(+), 121 deletions(-)




diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 481d3fb..1102421 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -81,6 +81,54 @@
 }

 static bool
+socks_proxy_recv_char(char *c, const char *name, socket_descriptor_t sd,
+                      struct event_timeout *server_poll_timeout,
+                      volatile int *signal_received)
+{
+    fd_set reads;
+    FD_ZERO(&reads);
+    openvpn_fd_set(sd, &reads);
+
+    struct timeval tv;
+    tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeout);
+    tv.tv_usec =3D 0;
+
+    const int status =3D select(sd + 1, &reads, NULL, NULL, &tv);
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
+    const ssize_t size =3D recv(sd, c, 1, MSG_NOSIGNAL);
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
+static bool
 socks_username_password_auth(struct socks_proxy_info *p, socket_descriptor=
_t sd,
                              struct event_timeout *server_poll_timeout,
                              volatile int *signal_received)
@@ -121,52 +169,12 @@

     while (len < 2)
     {
-        int status;
-        ssize_t size;
-        fd_set reads;
-        struct timeval tv;
         char c;

-        FD_ZERO(&reads);
-        openvpn_fd_set(sd, &reads);
-        tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeout);
-        tv.tv_usec =3D 0;
-
-        status =3D select(sd + 1, &reads, NULL, NULL, &tv);
-
-        get_signal(signal_received);
-        if (*signal_received)
+        if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, =
signal_received))
         {
             goto cleanup;
         }
-
-        /* timeout? */
-        if (status =3D=3D 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO,
-                "socks_username_password_auth: TCP port read timeout expir=
ed");
-            goto cleanup;
-        }
-
-        /* error */
-        if (status < 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO,
-                "socks_username_password_auth: TCP port read failed on sel=
ect()");
-            goto cleanup;
-        }
-
-        /* read single char */
-        size =3D recv(sd, &c, 1, MSG_NOSIGNAL);
-
-        /* error? */
-        if (size !=3D 1)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO,
-                "socks_username_password_auth: TCP port read failed on rec=
v()");
-            goto cleanup;
-        }
-
         /* store char in buffer */
         buf[len++] =3D c;
     }
@@ -208,49 +216,12 @@

     while (len < 2)
     {
-        int status;
-        ssize_t size;
-        fd_set reads;
-        struct timeval tv;
         char c;

-        FD_ZERO(&reads);
-        openvpn_fd_set(sd, &reads);
-        tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeout);
-        tv.tv_usec =3D 0;
-
-        status =3D select(sd + 1, &reads, NULL, NULL, &tv);
-
-        get_signal(signal_received);
-        if (*signal_received)
+        if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, =
signal_received))
         {
             return false;
         }
-
-        /* timeout? */
-        if (status =3D=3D 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read t=
imeout expired");
-            return false;
-        }
-
-        /* error */
-        if (status < 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read f=
ailed on select()");
-            return false;
-        }
-
-        /* read single char */
-        size =3D recv(sd, &c, 1, MSG_NOSIGNAL);
-
-        /* error? */
-        if (size !=3D 1)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read f=
ailed on recv()");
-            return false;
-        }
-
         /* store char in buffer */
         buf[len++] =3D c;
     }
@@ -317,54 +288,13 @@

     while (len < 4 + alen + 2)
     {
-        int status;
-        ssize_t size;
-        fd_set reads;
-        struct timeval tv;
         char c;

-        FD_ZERO(&reads);
-        openvpn_fd_set(sd, &reads);
-        tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeout);
-        tv.tv_usec =3D 0;
-
-        status =3D select(sd + 1, &reads, NULL, NULL, &tv);
-
-        get_signal(signal_received);
-        if (*signal_received)
+        if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, =
signal_received))
         {
             return false;
         }

-        /* timeout? */
-        if (status =3D=3D 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read =
timeout expired");
-            return false;
-        }
-
-        /* error */
-        if (status < 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read =
failed on select()");
-            return false;
-        }
-
-        /* read single char */
-        size =3D recv(sd, &c, 1, MSG_NOSIGNAL);
-
-        /* error? */
-        if (size < 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read =
failed on recv()");
-            return false;
-        }
-        else if (size =3D=3D 0)
-        {
-            msg(D_LINK_ERRORS, "ERROR: recv_socks_reply: empty response fr=
om socks server");
-            return false;
-        }
-
         if (len =3D=3D 3)
         {
             atyp =3D c;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1165?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6e848df8104b6e3a6e2c3245ece91a20e473fb40
Gerrit-Change-Number: 1165
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--oHaDNXYSVic=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1165?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">socks: factor out socks_proxy_recv_char()<br>=
<br>This is basically identical code duplicated three<br>times.<br><br>Chan=
ge-Id: I6e848df8104b6e3a6e2c3245ece91a20e473fb40<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1165<br>Mes=
sage-Id: &lt;20250923151050.27336-1-gert@...1296...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33171.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/soc=
ks.c<br>1 file changed, 51 insertions(+), 121 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c</span><br><span>i=
ndex 481d3fb..1102421 100644</span><br><span>--- a/src/openvpn/socks.c</spa=
n><br><span>+++ b/src/openvpn/socks.c</span><br><span>@@ -81,6 +81,54 @@</s=
pan><br><span> }</span><br><span> </span><br><span> static bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+socks_proxy_recv_char(char *c, =
const char *name, socket_descriptor_t sd,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                      struct event_timeout *server_po=
ll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
              volatile int *signal_received)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    fd_set reads;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    FD_ZERO(&amp;reads);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    openvpn_fd_set(sd, &amp;reads);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct timeval tv;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    tv.tv_sec =3D get_server_poll_remaining_time(server_poll_time=
out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tv.tv_usec=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const int status =3D select=
(sd + 1, &amp;reads, NULL, NULL, &amp;tv);</span><br><span style=3D"color: =
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
sd, c, 1, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* error? =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (size !=3D=
 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LINK_ERRORS | M_=
ERRNO, &quot;%s: TCP port read failed on recv()&quot;, name);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span> =
socks_username_password_auth(struct socks_proxy_info *p, socket_descriptor_=
t sd,</span><br><span>                              struct event_timeout *s=
erver_poll_timeout,</span><br><span>                              volatile =
int *signal_received)</span><br><span>@@ -121,52 +169,12 @@</span><br><span=
> </span><br><span>     while (len &lt; 2)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        int status;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        ssize_t size;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        fd_set reads;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        struct timeval tv;</span>=
<br><span>         char c;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        FD_ZERO(&amp;reads);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        openvpn_fd_set(sd, &amp;reads);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        tv.tv_sec =3D get=
_server_poll_remaining_time(server_poll_timeout);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        tv.tv_usec =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        status =3D select(sd + 1, &amp;reads, NULL, NULL, &amp;t=
v);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        get_signal(signal_received);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (*signal_rece=
ived)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!s=
ocks_proxy_recv_char(&amp;c, __func__, sd, server_poll_timeout, signal_rece=
ived))</span><br><span>         {</span><br><span>             goto cleanup=
;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* tim=
eout? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (s=
tatus =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_=
LINK_ERRORS | M_ERRNO,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                &quot;socks_username_password_auth: TCP port read timeout =
expired&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      goto cleanup;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* error */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (status &lt; 0)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_ERRNO,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;so=
cks_username_password_auth: TCP port read failed on select()&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            goto cleanup;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        /* read single char */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        size =3D recv(sd, &amp;c, 1, MSG_NOSIGNA=
L);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /* error? */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (size !=3D 1)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_ERRNO,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;socks_us=
ername_password_auth: TCP port read failed on recv()&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            goto cleanup;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* store char in =
buffer */</span><br><span>         buf[len++] =3D c;</span><br><span>     }=
</span><br><span>@@ -208,49 +216,12 @@</span><br><span> </span><br><span>  =
   while (len &lt; 2)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        int status;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        ssize_t size;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        fd_set reads;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        struct timeval tv;</span><br><span>         ch=
ar c;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        FD_ZERO(&amp;reads);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        openvpn_fd_set(sd, &amp;reads);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        tv.tv_sec =3D get_server_poll_remaining_=
time(server_poll_timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        tv.tv_usec =3D 0;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        stat=
us =3D select(sd + 1, &amp;reads, NULL, NULL, &amp;tv);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        get_signal(signal_received);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (*signal_received)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!socks_proxy_recv_char(&a=
mp;c, __func__, sd, server_poll_timeout, signal_received))</span><br><span>=
         {</span><br><span>             return false;</span><br><span>     =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* timeout? */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=3D 0)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_ERRNO, =
&quot;socks_handshake: TCP port read timeout expired&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* error */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (status &lt; 0)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(D_LINK_ERRORS | M_ERRNO, &quot;socks_handshake: TCP port =
read failed on select()&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            return false;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* read sin=
gle char */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        si=
ze =3D recv(sd, &amp;c, 1, MSG_NOSIGNAL);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /* error? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (size !=3D 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(D_LINK_ERRORS | M_ERRNO, &quot;socks_handshake: TCP port read failed o=
n recv()&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan>         /* store char in buffer */</span><br><span>         buf[len++]=
 =3D c;</span><br><span>     }</span><br><span>@@ -317,54 +288,13 @@</span>=
<br><span> </span><br><span>     while (len &lt; 4 + alen + 2)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int=
 status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ssize=
_t size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fd_se=
t reads;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t timeval tv;</span><br><span>         char c;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        FD_ZERO(&amp;reads);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_fd_set(sd=
, &amp;reads);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeout);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        tv.tv_usec =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        status =3D select(sd + 1, &amp;reads, =
NULL, NULL, &amp;tv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        get_signal(si=
gnal_received);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (*signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (!socks_proxy_recv_char(&amp;c, __func__, sd, server_poll_ti=
meout, signal_received))</span><br><span>         {</span><br><span>       =
      return false;</span><br><span>         }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        /* timeout? */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=3D 0)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_ER=
RNO, &quot;recv_socks_reply: TCP port read timeout expired&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            return false;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        /* error */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (status &lt; 0)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(D_LINK_ERRORS | M_ERRNO, &quot;recv_socks_reply: TCP=
 port read failed on select()&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return false;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* re=
ad single char */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    size =3D recv(sd, &amp;c, 1, MSG_NOSIGNAL);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /* error? */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (size &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(D_LINK_ERRORS | M_ERRNO, &quot;recv_socks_reply: TCP port read f=
ailed on recv()&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            return false;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  else if (size =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(D_LINK_ERRORS, &quot;ERROR: recv_socks_reply: empty response from s=
ocks server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>         if (len =3D=3D 3)</span><br><span>         {</span><br><spa=
n>             atyp =3D c;</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1165?usp=3Demail">chang=
e 1165</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1165?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6e848df8104b6e3a6e2c3245ece=
91a20e473fb40 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1165 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--oHaDNXYSVic=--

