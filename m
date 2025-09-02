From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 12:05:21 +0000
References: <gerrit.1756814708000.I6e848df8104b6e3a6e2c3245ece91a20e473fb40@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <aec2dc336845a90a54b32275621dd80cc2d31dbe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y33lhxOrUZY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--y33lhxOrUZY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1165?usp=3Demail

to review the following change.


Change subject: socks: factor out socks_proxy_recv_char()
......................................................................

socks: factor out socks_proxy_recv_char()

This is basically identical code duplicated three
times.

Change-Id: I6e848df8104b6e3a6e2c3245ece91a20e473fb40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/socks.c
1 file changed, 51 insertions(+), 121 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/1165/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--y33lhxOrUZY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1165?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">socks: factor out socks_proxy_recv_char()<br><br>This is bas=
ically identical code duplicated three<br>times.<br><br>Change-Id: I6e848df=
8104b6e3a6e2c3245ece91a20e473fb40<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>---<br>M src/openvpn/socks.c<br>1 file changed, 51 i=
nsertions(+), 121 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/65/1165/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socks=
.c b/src/openvpn/socks.c</span><br><span>index 481d3fb..1102421 100644</spa=
n><br><span>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openvpn/soc=
ks.c</span><br><span>@@ -81,6 +81,54 @@</span><br><span> }</span><br><span>=
 </span><br><span> static bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+socks_proxy_recv_char(char *c, const char *name, socket_descript=
or_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
           struct event_timeout *server_poll_timeout,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      volatile int *signa=
l_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    fd_set reads;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    FD_ZERO(&amp;reads);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_fd_set(sd, =
&amp;reads);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct timeval tv;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    tv.tv_sec =3D get_s=
erver_poll_remaining_time(server_poll_timeout);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tv.tv_usec =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const int status =3D select(sd + 1, &amp;reads, NULL, NULL, =
&amp;tv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    get_signal(signal_receive=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (*signal_=
received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* timeout? */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (status =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(D_LINK_ERRORS | M_ERRNO, &quot;%s: TCP port read time=
out expired&quot;, name);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* error */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (status &lt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(D_LINK_ERRORS | M_ERRNO, &qu=
ot;%s: TCP port read failed on select()&quot;, name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* read single char */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const ssize_t size =3D recv(sd, c, 1, MSG_NOSIGNAL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* error? */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (size !=3D 1)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(D_LINK_ERRORS | M_ERRNO, &quot;%s: TCP port read fa=
iled on recv()&quot;, name);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static bool</span><br><span> socks_username_password_auth(st=
ruct socks_proxy_info *p, socket_descriptor_t sd,</span><br><span>         =
                     struct event_timeout *server_poll_timeout,</span><br><=
span>                              volatile int *signal_received)</span><br=
><span>@@ -121,52 +169,12 @@</span><br><span> </span><br><span>     while (=
len &lt; 2)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        int status;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        ssize_t size;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        fd_set reads;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        struct timeval tv;</span><br><span>         char c;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
FD_ZERO(&amp;reads);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       openvpn_fd_set(sd, &amp;reads);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        tv.tv_sec =3D get_server_poll_remaining_time(serve=
r_poll_timeout);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   tv.tv_usec =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =3D sel=
ect(sd + 1, &amp;reads, NULL, NULL, &amp;tv);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        get_signal(signal_received);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (*signal_received)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (!socks_proxy_recv_char(&amp;c, __fu=
nc__, sd, server_poll_timeout, signal_received))</span><br><span>         {=
</span><br><span>             goto cleanup;</span><br><span>         }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        /* timeout? */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (status =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_ERRNO,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                &quot;socks_user=
name_password_auth: TCP port read timeout expired&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            goto cleanup;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* error */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (status &lt; 0)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          msg(D_LINK_ERRORS | M_ERRNO,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                &quot;socks_username_password_auth: TCP po=
rt read failed on select()&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            goto cleanup;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* read =
single char */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 size =3D recv(sd, &amp;c, 1, MSG_NOSIGNAL);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        /* error? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (size !=3D 1)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(D_LINK_ERRORS | M_ERRNO,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                &quot;socks_username_password_auth: TCP port rea=
d failed on recv()&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            goto cleanup;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>         /* store char in buffer */</span><br><span>         =
buf[len++] =3D c;</span><br><span>     }</span><br><span>@@ -208,49 +216,12=
 @@</span><br><span> </span><br><span>     while (len &lt; 2)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int =
status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ssize_=
t size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fd_set=
 reads;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct=
 timeval tv;</span><br><span>         char c;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        FD_ZERO(&amp;reads);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_fd_set(sd,=
 &amp;reads);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeout);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        tv.tv_usec =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        status =3D select(sd + 1, &amp;reads, N=
ULL, NULL, &amp;tv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        get_signal(sig=
nal_received);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (*signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!socks_proxy_recv_char(&amp;c, __func__, sd, server_poll_tim=
eout, signal_received))</span><br><span>         {</span><br><span>        =
     return false;</span><br><span>         }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        /* timeout? */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (status =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           msg(D_LINK_ERRORS | M_ERRNO, &quot;socks_handshake: TCP port rea=
d timeout expired&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            return false;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* error */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (status &lt; 0)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_=
ERRNO, &quot;socks_handshake: TCP port read failed on select()&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            return false;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /* read single char */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        size =3D recv(sd, &amp;c, 1, MSG_NOSIG=
NAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* error? */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (size !=3D 1)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_ERRNO, &quot;=
socks_handshake: TCP port read failed on recv()&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>         /* store char in buffer=
 */</span><br><span>         buf[len++] =3D c;</span><br><span>     }</span=
><br><span>@@ -317,54 +288,13 @@</span><br><span> </span><br><span>     whi=
le (len &lt; 4 + alen + 2)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        int status;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        ssize_t size;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        fd_set reads;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        struct timeval tv;</span><br><span>      =
   char c;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        FD_ZERO(&amp;reads);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        openvpn_fd_set(sd, &amp;reads);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        tv.tv_sec =3D get_server_poll_remai=
ning_time(server_poll_timeout);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        tv.tv_usec =3D 0;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 status =3D select(sd + 1, &amp;reads, NULL, NULL, &amp;tv);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        get_signal(signal_received);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (*signal_received)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!socks_proxy_recv_ch=
ar(&amp;c, __func__, sd, server_poll_timeout, signal_received))</span><br><=
span>         {</span><br><span>             return false;</span><br><span>=
         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* timeout? */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (status =3D=3D 0)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(D_LINK_ERRORS | M_ERRNO, &quot;recv_socks_reply: TCP por=
t read timeout expired&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            return false;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* error */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (status &lt=
; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS=
 | M_ERRNO, &quot;recv_socks_reply: TCP port read failed on select()&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return f=
alse;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        /* read single char */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        size =3D recv(sd, &amp;c, 1, MSG=
_NOSIGNAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        /* error? */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (size &lt; 0)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS | M_ERRNO, =
&quot;recv_socks_reply: TCP port read failed on recv()&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            return false;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        else if (size =3D=3D 0)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(D_LINK_ERRORS, &quot;ERROR:=
 recv_socks_reply: empty response from socks server&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         if (len =3D=3D 3)=
</span><br><span>         {</span><br><span>             atyp =3D c;</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1165?usp=3Demail">change 1165</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1165?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6e848df8104b6e3a6e2c3245ece=
91a20e473fb40 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1165 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--y33lhxOrUZY=--

