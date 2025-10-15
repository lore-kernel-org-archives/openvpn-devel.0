From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 15 Oct 2025 10:56:17 +0000
In-Reply-To: <gerrit.1760523707000.If91d14f31368a93182bcf23b1d82b06ea94381d8@...2715...>
References: <gerrit.1760523707000.If91d14f31368a93182bcf23b1d82b06ea94381d8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3248645bab9bf1f6b52cd60c6d3bb3c9d29227b0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tEu+2/lEBoQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Wrap winsock
 functions to avoid common conversion warnings
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

--tEu+2/lEBoQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1277?usp=3Demail

to look at the new patch set (#2).


Change subject: socket: Wrap winsock functions to avoid common conversion w=
arnings
......................................................................

socket: Wrap winsock functions to avoid common conversion warnings

Before I had done those at the call site but we have
several very similar issues with multiple occurrences.
So handle them together.

Change-Id: If91d14f31368a93182bcf23b1d82b06ea94381d8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/proxy.c
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/socks.c
4 files changed, 51 insertions(+), 25 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1277/2

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 02554ba..dfe1e59 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -54,11 +54,6 @@
 }


-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /* cached proxy username/password */
 static struct user_pass static_proxy_user_pass;

@@ -93,7 +88,7 @@
         tv.tv_sec =3D timeout_sec;
         tv.tv_usec =3D 0;

-        status =3D select(sd + 1, &reads, NULL, NULL, &tv);
+        status =3D openvpn_select(sd + 1, &reads, NULL, NULL, &tv);

         get_signal(signal_received);
         if (*signal_received)
@@ -192,7 +187,7 @@
 static bool
 send_line(socket_descriptor_t sd, const char *buf)
 {
-    const ssize_t size =3D send(sd, buf, strlen(buf), MSG_NOSIGNAL);
+    const ssize_t size =3D openvpn_send(sd, buf, strlen(buf), MSG_NOSIGNAL=
);
     if (size !=3D (ssize_t)strlen(buf))
     {
         msg(D_LINK_ERRORS | M_ERRNO, "send_line: TCP port write failed on =
send()");
@@ -903,7 +898,7 @@

                 if (opaque)
                 {
-                    const int len =3D strlen(opaque) + 16;
+                    const size_t len =3D strlen(opaque) + 16;
                     opaque_kv =3D gc_malloc(len, false, &gc);
                     snprintf(opaque_kv, len, ", opaque=3D\"%s\"", opaque);
                 }
@@ -1068,7 +1063,3 @@
     gc_free(&gc);
     return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index f71d891..40a86fb 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -849,6 +849,10 @@
     gc_free(&gc);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static socket_descriptor_t
 socket_listen_accept(socket_descriptor_t sd, struct link_socket_actual *ac=
t,
                      const char *remote_dynamic, const struct addrinfo *lo=
cal, bool do_listen,
@@ -873,7 +877,7 @@
         tv.tv_sec =3D 0;
         tv.tv_usec =3D 0;

-        status =3D select(sd + 1, &reads, NULL, NULL, &tv);
+        status =3D openvpn_select(sd + 1, &reads, NULL, NULL, &tv);

         get_signal(signal_received);
         if (*signal_received)
@@ -979,7 +983,7 @@
             msg(M_NONFATAL | M_ERRNO, "Setting IPV6_V6ONLY=3D%d failed", v=
6only);
         }
     }
-    if (bind(sd, cur->ai_addr, cur->ai_addrlen))
+    if (openvpn_bind(sd, cur->ai_addr, cur->ai_addrlen))
     {
         msg(M_FATAL | M_ERRNO, "%s: Socket bind failed on local address %s=
", prefix,
             print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
@@ -1026,7 +1030,7 @@
             tv.tv_sec =3D (connect_timeout > 0) ? 1 : 0;
             tv.tv_usec =3D 0;

-            status =3D select(sd + 1, NULL, &writes, NULL, &tv);
+            status =3D openvpn_select(sd + 1, NULL, &writes, NULL, &tv);
 #endif
             if (signal_received)
             {
@@ -1183,6 +1187,11 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 resolve_bind_local(struct link_socket *sock, const sa_family_t af)
 {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2c79a11..e986c9c 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -291,9 +291,38 @@
     sh.is_handle ? SetLastError(ERROR_INVALID_FUNCTION) : WSASetLastError(=
WSAEINVAL);
 }

+/* winsock(2).h uses slightly different types so to avoid conversion
+   errors we wrap these functions on Windows */
+
+static inline int
+openvpn_select(socket_descriptor_t nfds, fd_set *readfds, fd_set *writefds,
+               fd_set *exceptfds, struct timeval *timeout)
+{
+    (void)nfds; /* first argument ignored on Windows */
+    return select(0, readfds, writefds, exceptfds, timeout);
+}
+
+static inline ssize_t
+openvpn_send(socket_descriptor_t sockfd, const void *buf, size_t len, int =
flags)
+{
+    ASSERT(len <=3D INT_MAX);
+    return send(sockfd, buf, (int)len, flags);
+}
+
+static inline int
+openvpn_bind(socket_descriptor_t sockfd, const struct sockaddr *addr, size=
_t addrlen)
+{
+    ASSERT(addrlen <=3D INT_MAX);
+    return bind(sockfd, addr, (int)addrlen);
+}
+
 #else /* ifdef _WIN32 */

 #define openvpn_close_socket(s) close(s)
+#define openvpn_select(nfds, readfds, writefds, exceptfds, timeout) \
+    select(nfds, readfds, writefds, exceptfds, timeout)
+#define openvpn_send(sockfd, buf, len, flags) send(sockfd, buf, len, flags)
+#define openvpn_bind(sockfd, addr, addrlen)   bind(sockfd, addr, addrlen)

 #endif /* ifdef _WIN32 */

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 6467baf..d383ef7 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -93,8 +93,7 @@
     tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeout);
     tv.tv_usec =3D 0;

-    /* NB: first argument ignored on Windows where socket_descriptor_t !=
=3D int */
-    const int status =3D select((int)sd + 1, &reads, NULL, NULL, &tv);
+    const int status =3D openvpn_select(sd + 1, &reads, NULL, NULL, &tv);

     get_signal(signal_received);
     if (*signal_received)
@@ -156,10 +155,9 @@
                         creds.username, (int)strlen(creds.password), creds=
.password);
     ASSERT(sret >=3D 0 && sret <=3D sizeof(to_send));

-    /* NB: int because Windows APIs */
-    ssize_t size =3D send(sd, to_send, (int)strlen(to_send), MSG_NOSIGNAL);
+    ssize_t size =3D openvpn_send(sd, to_send, strlen(to_send), MSG_NOSIGN=
AL);

-    if (size !=3D strlen(to_send))
+    if (size !=3D (ssize_t)strlen(to_send))
     {
         msg(D_LINK_ERRORS | M_ERRNO,
             "socks_username_password_auth: TCP port write failed on send()=
");
@@ -208,7 +206,7 @@
     {
         method_sel[2] =3D 0x02; /* METHODS =3D [2 (plain login)] */
     }
-    size =3D send(sd, method_sel, sizeof(method_sel), MSG_NOSIGNAL);
+    size =3D openvpn_send(sd, method_sel, sizeof(method_sel), MSG_NOSIGNAL=
);
     if (size !=3D sizeof(method_sel))
     {
         msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port write fail=
ed on send()");
@@ -415,10 +413,9 @@
     buf[5 + len + 1] =3D (char)(port & 0xff);

     {
-        /* int because Windows APIs */
-        int send_len =3D 5 + (int)len + 2;
-        const ssize_t size =3D send(sd, buf, send_len, MSG_NOSIGNAL);
-        if (size !=3D send_len)
+        size_t send_len =3D 5 + len + 2;
+        const ssize_t size =3D openvpn_send(sd, buf, send_len, MSG_NOSIGNA=
L);
+        if (size !=3D (ssize_t)send_len)
         {
             msg(D_LINK_ERRORS | M_ERRNO,
                 "establish_socks_proxy_passthru: TCP port write failed on =
send()");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1277?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If91d14f31368a93182bcf23b1d82b06ea94381d8
Gerrit-Change-Number: 1277
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--tEu+2/lEBoQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1277?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">socket: Wrap winsock functions to avoid common c=
onversion warnings<br><br>Before I had done those at the call site but we h=
ave<br>several very similar issues with multiple occurrences.<br>So handle =
them together.<br><br>Change-Id: If91d14f31368a93182bcf23b1d82b06ea94381d8<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M sr=
c/openvpn/proxy.c<br>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>M =
src/openvpn/socks.c<br>4 files changed, 51 insertions(+), 25 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/77/1277/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/proxy.c b/src/openvp=
n/proxy.c</span><br><span>index 02554ba..dfe1e59 100644</span><br><span>---=
 a/src/openvpn/proxy.c</span><br><span>+++ b/src/openvpn/proxy.c</span><br>=
<span>@@ -54,11 +54,6 @@</span><br><span> }</span><br><span> </span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* cached proxy username/=
password */</span><br><span> static struct user_pass static_proxy_user_pass=
;</span><br><span> </span><br><span>@@ -93,7 +88,7 @@</span><br><span>     =
    tv.tv_sec =3D timeout_sec;</span><br><span>         tv.tv_usec =3D 0;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   status =3D select(sd + 1, &amp;reads, NULL, NULL, &amp;tv);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        status =3D openvpn_selec=
t(sd + 1, &amp;reads, NULL, NULL, &amp;tv);</span><br><span> </span><br><sp=
an>         get_signal(signal_received);</span><br><span>         if (*sign=
al_received)</span><br><span>@@ -192,7 +187,7 @@</span><br><span> static bo=
ol</span><br><span> send_line(socket_descriptor_t sd, const char *buf)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st ssize_t size =3D send(sd, buf, strlen(buf), MSG_NOSIGNAL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =3D openvp=
n_send(sd, buf, strlen(buf), MSG_NOSIGNAL);</span><br><span>     if (size !=
=3D (ssize_t)strlen(buf))</span><br><span>     {</span><br><span>         m=
sg(D_LINK_ERRORS | M_ERRNO, &quot;send_line: TCP port write failed on send(=
)&quot;);</span><br><span>@@ -903,7 +898,7 @@</span><br><span> </span><br><=
span>                 if (opaque)</span><br><span>                 {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    const in=
t len =3D strlen(opaque) + 16;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    const size_t len =3D strlen(opaque) + 16;</s=
pan><br><span>                     opaque_kv =3D gc_malloc(len, false, &amp=
;gc);</span><br><span>                     snprintf(opaque_kv, len, &quot;,=
 opaque=3D\&quot;%s\&quot;&quot;, opaque);</span><br><span>                =
 }</span><br><span>@@ -1068,7 +1063,3 @@</span><br><span>     gc_free(&amp;=
gc);</span><br><span>     return ret;</span><br><span> }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>diff --git =
a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index f71d891=
..40a86fb 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span=
>+++ b/src/openvpn/socket.c</span><br><span>@@ -849,6 +849,10 @@</span><br>=
<span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defi=
ned(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> static socket_descriptor_t</span><br><span> socket_listen_accept(soc=
ket_descriptor_t sd, struct link_socket_actual *act,</span><br><span>      =
                const char *remote_dynamic, const struct addrinfo *local, b=
ool do_listen,</span><br><span>@@ -873,7 +877,7 @@</span><br><span>        =
 tv.tv_sec =3D 0;</span><br><span>         tv.tv_usec =3D 0;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =3D=
 select(sd + 1, &amp;reads, NULL, NULL, &amp;tv);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        status =3D openvpn_select(sd + 1, &am=
p;reads, NULL, NULL, &amp;tv);</span><br><span> </span><br><span>         g=
et_signal(signal_received);</span><br><span>         if (*signal_received)<=
/span><br><span>@@ -979,7 +983,7 @@</span><br><span>             msg(M_NONF=
ATAL | M_ERRNO, &quot;Setting IPV6_V6ONLY=3D%d failed&quot;, v6only);</span=
><br><span>         }</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (bind(sd, cur-&gt;ai_addr, cur-&gt;ai_addrlen=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (openvpn_b=
ind(sd, cur-&gt;ai_addr, cur-&gt;ai_addrlen))</span><br><span>     {</span>=
<br><span>         msg(M_FATAL | M_ERRNO, &quot;%s: Socket bind failed on l=
ocal address %s&quot;, prefix,</span><br><span>             print_sockaddr_=
ex(local-&gt;ai_addr, &quot;:&quot;, PS_SHOW_PORT, &amp;gc));</span><br><sp=
an>@@ -1026,7 +1030,7 @@</span><br><span>             tv.tv_sec =3D (connec=
t_timeout &gt; 0) ? 1 : 0;</span><br><span>             tv.tv_usec =3D 0;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       status =3D select(sd + 1, NULL, &amp;writes, NULL, &amp;tv);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            status =3D open=
vpn_select(sd + 1, NULL, &amp;writes, NULL, &amp;tv);</span><br><span> #end=
if</span><br><span>             if (signal_received)</span><br><span>      =
       {</span><br><span>@@ -1183,6 +1187,11 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored=
 &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> static void</span><br><span> resolve_bind_local(struct link_sock=
et *sock, const sa_family_t af)</span><br><span> {</span><br><span>diff --g=
it a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span>index 2c79=
a11..e986c9c 100644</span><br><span>--- a/src/openvpn/socket.h</span><br><s=
pan>+++ b/src/openvpn/socket.h</span><br><span>@@ -291,9 +291,38 @@</span><=
br><span>     sh.is_handle ? SetLastError(ERROR_INVALID_FUNCTION) : WSASetL=
astError(WSAEINVAL);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* winsock(2).h uses slightly differe=
nt types so to avoid conversion</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+   errors we wrap these functions on Windows */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static inline int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+openvpn_select(socket_descriptor_t nfds, fd_set *readfds=
, fd_set *writefds,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
               fd_set *exceptfds, struct timeval *timeout)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    (void)nfds; /* first argument ignored on Windows *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return select(=
0, readfds, writefds, exceptfds, timeout);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline =
ssize_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_send=
(socket_descriptor_t sockfd, const void *buf, size_t len, int flags)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ASSERT(len &lt;=3D INT_MAX);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return send(sockfd, buf, (i=
nt)len, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+openvpn_bind(socket_descriptor_t sockfd, =
const struct sockaddr *addr, size_t addrlen)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ASSERT(addrlen &lt;=3D INT_MAX);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return bind(sockfd, addr, (int)addrlen);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> #else /* ifdef _WIN32 */</=
span><br><span> </span><br><span> #define openvpn_close_socket(s) close(s)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define openvpn_sele=
ct(nfds, readfds, writefds, exceptfds, timeout) \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    select(nfds, readfds, writefds, exceptfds=
, timeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define o=
penvpn_send(sockfd, buf, len, flags) send(sockfd, buf, len, flags)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define openvpn_bind(sockfd,=
 addr, addrlen)   bind(sockfd, addr, addrlen)</span><br><span> </span><br><=
span> #endif /* ifdef _WIN32 */</span><br><span> </span><br><span>diff --gi=
t a/src/openvpn/socks.c b/src/openvpn/socks.c</span><br><span>index 6467baf=
..d383ef7 100644</span><br><span>--- a/src/openvpn/socks.c</span><br><span>=
+++ b/src/openvpn/socks.c</span><br><span>@@ -93,8 +93,7 @@</span><br><span=
>     tv.tv_sec =3D get_server_poll_remaining_time(server_poll_timeout);</s=
pan><br><span>     tv.tv_usec =3D 0;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* NB: first argument ignored on Windo=
ws where socket_descriptor_t !=3D int */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const int status =3D select((int)sd + 1, &amp;reads,=
 NULL, NULL, &amp;tv);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const int status =3D openvpn_select(sd + 1, &amp;reads, NULL, NULL, =
&amp;tv);</span><br><span> </span><br><span>     get_signal(signal_received=
);</span><br><span>     if (*signal_received)</span><br><span>@@ -156,10 +1=
55,9 @@</span><br><span>                         creds.username, (int)strle=
n(creds.password), creds.password);</span><br><span>     ASSERT(sret &gt;=
=3D 0 &amp;&amp; sret &lt;=3D sizeof(to_send));</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* NB: int because Windows =
APIs */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ssize_t si=
ze =3D send(sd, to_send, (int)strlen(to_send), MSG_NOSIGNAL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ssize_t size =3D openvpn_send=
(sd, to_send, strlen(to_send), MSG_NOSIGNAL);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (size !=3D strlen(to_send)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (size !=3D =
(ssize_t)strlen(to_send))</span><br><span>     {</span><br><span>         m=
sg(D_LINK_ERRORS | M_ERRNO,</span><br><span>             &quot;socks_userna=
me_password_auth: TCP port write failed on send()&quot;);</span><br><span>@=
@ -208,7 +206,7 @@</span><br><span>     {</span><br><span>         method_s=
el[2] =3D 0x02; /* METHODS =3D [2 (plain login)] */</span><br><span>     }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D send(sd, =
method_sel, sizeof(method_sel), MSG_NOSIGNAL);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    size =3D openvpn_send(sd, method_sel, sizeof=
(method_sel), MSG_NOSIGNAL);</span><br><span>     if (size !=3D sizeof(meth=
od_sel))</span><br><span>     {</span><br><span>         msg(D_LINK_ERRORS =
| M_ERRNO, &quot;socks_handshake: TCP port write failed on send()&quot;);</=
span><br><span>@@ -415,10 +413,9 @@</span><br><span>     buf[5 + len + 1] =
=3D (char)(port &amp; 0xff);</span><br><span> </span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* int because Wind=
ows APIs */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in=
t send_len =3D 5 + (int)len + 2;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        const ssize_t size =3D send(sd, buf, send_len, MSG_NOSIG=
NAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (size=
 !=3D send_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    size_t send_len =3D 5 + len + 2;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        const ssize_t size =3D openvpn_send(sd, buf, send_=
len, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (size !=3D (ssize_t)send_len)</span><br><span>         {</span><=
br><span>             msg(D_LINK_ERRORS | M_ERRNO,</span><br><span>        =
         &quot;establish_socks_proxy_passthru: TCP port write failed on sen=
d()&quot;);</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1277?usp=3Demail">change 1277</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1277?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If91d14f31368a93182bcf23b1d8=
2b06ea94381d8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1277 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--tEu+2/lEBoQ=--

