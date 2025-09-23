From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 15:40:07 +0000
In-Reply-To: <gerrit.1756814708000.I6e848df8104b6e3a6e2c3245ece91a20e473fb40@...2715...>
References: <gerrit.1756814708000.I6e848df8104b6e3a6e2c3245ece91a20e473fb40@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fc24f2f7dfb96590212932de308f10e97551861a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uQbKyWQdFMM="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uQbKyWQdFMM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1165?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1165/3

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
Gerrit-MessageType: newpatchset

--uQbKyWQdFMM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1165?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">socks: factor out socks_proxy_recv_char()<br><br>Thi=
s is basically identical code duplicated three<br>times.<br><br>Change-Id: =
I6e848df8104b6e3a6e2c3245ece91a20e473fb40<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&g=
t;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1165<br>Message-Id=
: &lt;20250923151050.27336-1-gert@...1296...&gt;<br>URL: https://www.mail-a=
rchive.com/openvpn-devel@lists.sourceforge.net/msg33171.html<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/socks.c<br=
>1 file changed, 51 insertions(+), 121 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/65/1165/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/socks.c b/src/openvpn/socks.c</span><br><span>index 481d3=
fb..1102421 100644</span><br><span>--- a/src/openvpn/socks.c</span><br><spa=
n>+++ b/src/openvpn/socks.c</span><br><span>@@ -81,6 +81,54 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+socks_proxy_recv_char(char *c, const char=
 *name, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                      struct event_timeout *server_poll_timeout=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
    volatile int *signal_received)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 fd_set reads;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    F=
D_ZERO(&amp;reads);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    openvpn_fd_set(sd, &amp;reads);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct timeval tv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeout);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    tv.tv_usec =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const int status =3D select(sd + 1, &=
amp;reads, NULL, NULL, &amp;tv);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ge=
t_signal(signal_received);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (*signal_received)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* timeout? */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (status =3D=3D 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_LINK_ERRORS | M_ERRNO, &quo=
t;%s: TCP port read timeout expired&quot;, name);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* error */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (status &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_=
LINK_ERRORS | M_ERRNO, &quot;%s: TCP port read failed on select()&quot;, na=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* read single char */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =3D recv(sd, c, =
1, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* error? */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (size !=3D 1)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(D_LINK_ERRORS | M_ERRNO, =
&quot;%s: TCP port read failed on recv()&quot;, name);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span> socks_u=
sername_password_auth(struct socks_proxy_info *p, socket_descriptor_t sd,</=
span><br><span>                              struct event_timeout *server_p=
oll_timeout,</span><br><span>                              volatile int *si=
gnal_received)</span><br><span>@@ -121,52 +169,12 @@</span><br><span> </spa=
n><br><span>     while (len &lt; 2)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        int status;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        ssize_t size;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        fd_set reads;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        struct timeval tv;</span><br><sp=
an>         char c;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        FD_ZERO(&amp;reads);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        openvpn_fd_set(sd, &amp;reads);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        tv.tv_sec =3D get_server_p=
oll_remaining_time(server_poll_timeout);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        tv.tv_usec =3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        status =3D select(sd + 1, &amp;reads, NULL, NULL, &amp;tv);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        get_signal(signal_received);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (*signal_received)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!socks_prox=
y_recv_char(&amp;c, __func__, sd, server_poll_timeout, signal_received))</s=
pan><br><span>         {</span><br><span>             goto cleanup;</span><=
br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* timeout? */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRO=
RS | M_ERRNO,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        &quot;socks_username_password_auth: TCP port read timeout expired&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            got=
o cleanup;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* error */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (status &lt; 0)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_ERRNO,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;socks_use=
rname_password_auth: TCP port read failed on select()&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            goto cleanup;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* read single char */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        size =3D recv(sd, &amp;c, 1, MSG_NOSIGNAL);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        /* error? */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (size !=3D 1)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_ERRNO,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                &quot;socks_username=
_password_auth: TCP port read failed on recv()&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            goto cleanup;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span>         /* store char in buffer =
*/</span><br><span>         buf[len++] =3D c;</span><br><span>     }</span>=
<br><span>@@ -208,49 +216,12 @@</span><br><span> </span><br><span>     whil=
e (len &lt; 2)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        int status;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        ssize_t size;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        fd_set reads;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        struct timeval tv;</span><br><span>         char c;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   FD_ZERO(&amp;reads);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        openvpn_fd_set(sd, &amp;reads);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        tv.tv_sec =3D get_server_poll_remaining_time(se=
rver_poll_timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      tv.tv_usec =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =3D =
select(sd + 1, &amp;reads, NULL, NULL, &amp;tv);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        get_signal(signal_received);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (*signal_received)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!socks_proxy_recv_char(&amp;c, _=
_func__, sd, server_poll_timeout, signal_received))</span><br><span>       =
  {</span><br><span>             return false;</span><br><span>         }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* timeout? */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_ERRNO, &quot;=
socks_handshake: TCP port read timeout expired&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        /* error */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (status &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(D_LINK_ERRORS | M_ERRNO, &quot;socks_handshake: TCP port read fa=
iled on select()&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            return false;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* read single cha=
r */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        size =3D =
recv(sd, &amp;c, 1, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
/* error? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (size !=3D 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_=
LINK_ERRORS | M_ERRNO, &quot;socks_handshake: TCP port read failed on recv(=
)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>   =
      /* store char in buffer */</span><br><span>         buf[len++] =3D c;=
</span><br><span>     }</span><br><span>@@ -317,54 +288,13 @@</span><br><sp=
an> </span><br><span>     while (len &lt; 4 + alen + 2)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int status=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ssize_t size=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fd_set reads=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct timev=
al tv;</span><br><span>         char c;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        FD_ZERO(&amp;reads);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_fd_set(sd, &amp;=
reads);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tv.tv_=
sec =3D get_server_poll_remaining_time(server_poll_timeout);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        tv.tv_usec =3D 0;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        status =3D select(sd + 1, &amp;reads, NULL, N=
ULL, &amp;tv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        get_signal(signal_re=
ceived);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (*=
signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (!socks_proxy_recv_char(&amp;c, __func__, sd, server_poll_timeout, =
signal_received))</span><br><span>         {</span><br><span>             r=
eturn false;</span><br><span>         }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /* timeout? */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=3D 0)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_ERRNO, &q=
uot;recv_socks_reply: TCP port read timeout expired&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* error */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (status &lt; 0)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(D_LINK_ERRORS | M_ERRNO, &quot;recv_socks_reply: TCP port=
 read failed on select()&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            return false;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* read si=
ngle char */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
ize =3D recv(sd, &amp;c, 1, MSG_NOSIGNAL);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /* error? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (size &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(D_LINK_ERRORS | M_ERRNO, &quot;recv_socks_reply: TCP port read failed=
 on recv()&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        els=
e if (size =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
sg(D_LINK_ERRORS, &quot;ERROR: recv_socks_reply: empty response from socks =
server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n>         if (len =3D=3D 3)</span><br><span>         {</span><br><span>   =
          atyp =3D c;</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1165?usp=3Demail">change 116=
5</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1165?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--uQbKyWQdFMM=--

