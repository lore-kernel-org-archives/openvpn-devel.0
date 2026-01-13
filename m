From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 13 Jan 2026 11:43:07 +0000
References: <gerrit.1768304582000.I0141945469dd11340bfb42ec37a3c5f90ed0ff52@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7866a4631d00e2a83c7580865aa1eabdfc8a4cdc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s96f/OAisB0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Remove old
 "dynamic remote" feature
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

--s96f/OAisB0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1468?usp=3Demail

to review the following change.


Change subject: socket: Remove old "dynamic remote" feature
......................................................................

socket: Remove old "dynamic remote" feature

So apparently when using --proto tcp-server --tls-server
--remote, AND the remote is not resolvable on startup
then we would preserve the remote name and resolve it
later on connect. Except that when the remote is not
resolvable I never managed to get it to create a
listening socket in the first place.

Originally I looked into this code because ZeroPath
claimed it was broken. I think that report was
correct but I think it is much easier to declare this
feature dead instead of trying to fix it. It is
undocumented and if it is usable then only in very
specific circumstances that are hard to figure out.

Github: openvpn-private-issues#13
Change-Id: I0141945469dd11340bfb42ec37a3c5f90ed0ff52
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/socket.c
1 file changed, 11 insertions(+), 53 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/1468/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index e2c5844..093f822 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -867,12 +867,10 @@

 static socket_descriptor_t
 socket_listen_accept(socket_descriptor_t sd, struct link_socket_actual *ac=
t,
-                     const char *remote_dynamic, const struct addrinfo *lo=
cal, bool do_listen,
+                     const struct addrinfo *local, bool do_listen,
                      bool nowait, volatile int *signal_received)
 {
     struct gc_arena gc =3D gc_new();
-    /* struct openvpn_sockaddr *remote =3D &act->dest; */
-    struct openvpn_sockaddr remote_verify =3D act->dest;
     socket_descriptor_t new_sd =3D SOCKET_UNDEFINED;

     CLEAR(*act);
@@ -913,31 +911,7 @@

         if (socket_defined(new_sd))
         {
-            struct addrinfo *ai =3D NULL;
-            if (remote_dynamic)
-            {
-                openvpn_getaddrinfo(0, remote_dynamic, NULL, 1, NULL,
-                                    remote_verify.addr.sa.sa_family, &ai);
-            }
-
-            if (ai && !addrlist_match(&remote_verify, ai))
-            {
-                msg(M_WARN, "TCP NOTE: Rejected connection attempt from %s=
 due to --remote setting",
-                    print_link_socket_actual(act, &gc));
-                if (openvpn_close_socket(new_sd))
-                {
-                    msg(M_ERR, "TCP: close socket failed (new_sd)");
-                }
-                freeaddrinfo(ai);
-            }
-            else
-            {
-                if (ai)
-                {
-                    freeaddrinfo(ai);
-                }
-                break;
-            }
+            break;
         }
         management_sleep(1);
     }
@@ -1255,8 +1229,7 @@
 }

 static void
-resolve_remote(struct link_socket *sock, int phase, const char **remote_dy=
namic,
-               struct signal_info *sig_info)
+resolve_remote(struct link_socket *sock, int phase, struct signal_info *si=
g_info)
 {
     volatile int *signal_received =3D sig_info ? &sig_info->signal_receive=
d : NULL;
     struct gc_arena gc =3D gc_new();
@@ -1351,10 +1324,6 @@
     {
         msg(M_INFO, "TCP/UDP: Preserving recently used remote address: %s",
             print_link_socket_actual(&sock->info.lsa->actual, &gc));
-        if (remote_dynamic)
-        {
-            *remote_dynamic =3D NULL;
-        }
     }
     else
     {
@@ -1516,7 +1485,7 @@
         {
             resolve_bind_local(sock, sock->info.af);
         }
-        resolve_remote(sock, 1, NULL, NULL);
+        resolve_remote(sock, 1, NULL);
     }
 }

@@ -1577,8 +1546,7 @@
 }

 static void
-phase2_tcp_server(struct link_socket *sock, const char *remote_dynamic,
-                  struct signal_info *sig_info)
+phase2_tcp_server(struct link_socket *sock, struct signal_info *sig_info)
 {
     ASSERT(sig_info);
     volatile int *signal_received =3D &sig_info->signal_received;
@@ -1586,8 +1554,9 @@
     {
         case LS_MODE_DEFAULT:
             sock->sd =3D
-                socket_listen_accept(sock->sd, &sock->info.lsa->actual, re=
mote_dynamic,
-                                     sock->info.lsa->bind_local, true, fal=
se, signal_received);
+                socket_listen_accept(sock->sd, &sock->info.lsa->actual,
+                                     sock->info.lsa->bind_local, true, fal=
se,
+                                     signal_received);
             break;

         case LS_MODE_TCP_LISTEN:
@@ -1675,7 +1644,7 @@
         sock->info.lsa->remote_list =3D NULL;
     }

-    resolve_remote(sock, 1, NULL, sig_info);
+    resolve_remote(sock, 1, sig_info);
 }

 #if defined(_WIN32)
@@ -1733,7 +1702,6 @@
     const struct frame *frame =3D &c->c2.frame;
     struct signal_info *sig_info =3D c->sig;

-    const char *remote_dynamic =3D NULL;
     struct signal_info sig_save =3D { 0 };

     ASSERT(sock);
@@ -1748,18 +1716,8 @@
     /* initialize buffers */
     socket_frame_init(frame, sock);

-    /*
-     * Pass a remote name to connect/accept so that
-     * they can test for dynamic IP address changes
-     * and throw a SIGUSR1 if appropriate.
-     */
-    if (sock->resolve_retry_seconds)
-    {
-        remote_dynamic =3D sock->remote_host;
-    }
-
     /* Second chance to resolv/create socket */
-    resolve_remote(sock, 2, &remote_dynamic, sig_info);
+    resolve_remote(sock, 2, sig_info);

     /* If a valid remote has been found, create the socket with its addrin=
fo */
 #if defined(_WIN32)
@@ -1809,7 +1767,7 @@

     if (sock->info.proto =3D=3D PROTO_TCP_SERVER)
     {
-        phase2_tcp_server(sock, remote_dynamic, sig_info);
+        phase2_tcp_server(sock, sig_info);
     }
     else if (sock->info.proto =3D=3D PROTO_TCP_CLIENT)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1468?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0141945469dd11340bfb42ec37a3c5f90ed0ff52
Gerrit-Change-Number: 1468
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--s96f/OAisB0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1468?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">socket: Remove old &quot;dynamic remote&quo=
t; feature<br><br>So apparently when using --proto tcp-server --tls-server<=
br>--remote, AND the remote is not resolvable on startup<br>then we would p=
reserve the remote name and resolve it<br>later on connect. Except that whe=
n the remote is not<br>resolvable I never managed to get it to create a<br>=
listening socket in the first place.<br><br>Originally I looked into this c=
ode because ZeroPath<br>claimed it was broken. I think that report was<br>c=
orrect but I think it is much easier to declare this<br>feature dead instea=
d of trying to fix it. It is<br>undocumented and if it is usable then only =
in very<br>specific circumstances that are hard to figure out.<br><br>Githu=
b: openvpn-private-issues#13<br>Change-Id: I0141945469dd11340bfb42ec37a3c5f=
90ed0ff52<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>-=
--<br>M src/openvpn/socket.c<br>1 file changed, 11 insertions(+), 53 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/68/1468/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/s=
rc/openvpn/socket.c</span><br><span>index e2c5844..093f822 100644</span><br=
><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.=
c</span><br><span>@@ -867,12 +867,10 @@</span><br><span> </span><br><span> =
static socket_descriptor_t</span><br><span> socket_listen_accept(socket_des=
criptor_t sd, struct link_socket_actual *act,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                     const char *remote_dynamic, co=
nst struct addrinfo *local, bool do_listen,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                     const struct addrinfo *local, =
bool do_listen,</span><br><span>                      bool nowait, volatile=
 int *signal_received)</span><br><span> {</span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* struct openvpn_sockaddr *remote =3D &amp;act-&gt;dest; */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct openvpn_sockaddr remot=
e_verify =3D act-&gt;dest;</span><br><span>     socket_descriptor_t new_sd =
=3D SOCKET_UNDEFINED;</span><br><span> </span><br><span>     CLEAR(*act);</=
span><br><span>@@ -913,31 +911,7 @@</span><br><span> </span><br><span>     =
    if (socket_defined(new_sd))</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            struct addrinfo *ai =3D NU=
LL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (re=
mote_dynamic)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
openvpn_getaddrinfo(0, remote_dynamic, NULL, 1, NULL,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                    remote_=
verify.addr.sa.sa_family, &amp;ai);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if =
(ai &amp;&amp; !addrlist_match(&amp;remote_verify, ai))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                msg(M_WARN, &quot;TCP NOTE: Rejec=
ted connection attempt from %s due to --remote setting&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    print_link_sock=
et_actual(act, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                if (openvpn_close_socket(new_sd))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    msg(M_ERR, &quot;TCP: close=
 socket failed (new_sd)&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                freeaddrinfo(ai);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             if (ai)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               freeaddrinfo(ai);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                break;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            break;</span><br><span>         }</span><br><span>         ma=
nagement_sleep(1);</span><br><span>     }</span><br><span>@@ -1255,8 +1229,=
7 @@</span><br><span> }</span><br><span> </span><br><span> static void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-resolve_remote(struct link=
_socket *sock, int phase, const char **remote_dynamic,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-               struct signal_info *sig_inf=
o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+resolve_remote(st=
ruct link_socket *sock, int phase, struct signal_info *sig_info)</span><br>=
<span> {</span><br><span>     volatile int *signal_received =3D sig_info ? =
&amp;sig_info-&gt;signal_received : NULL;</span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span>@@ -1351,10 +1324,6 @@</span><br><span=
>     {</span><br><span>         msg(M_INFO, &quot;TCP/UDP: Preserving rece=
ntly used remote address: %s&quot;,</span><br><span>             print_link=
_socket_actual(&amp;sock-&gt;info.lsa-&gt;actual, &amp;gc));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (remote_dynamic)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            *remote_dynamic =3D NULL;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>=
     }</span><br><span>     else</span><br><span>     {</span><br><span>@@ =
-1516,7 +1485,7 @@</span><br><span>         {</span><br><span>             =
resolve_bind_local(sock, sock-&gt;info.af);</span><br><span>         }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        resolve_remote(soc=
k, 1, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       resolve_remote(sock, 1, NULL);</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span>@@ -1577,8 +1546,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-phase2_tcp_server(struct link_socket *sock,=
 const char *remote_dynamic,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                  struct signal_info *sig_info)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+phase2_tcp_server(struct link_socket *so=
ck, struct signal_info *sig_info)</span><br><span> {</span><br><span>     A=
SSERT(sig_info);</span><br><span>     volatile int *signal_received =3D &am=
p;sig_info-&gt;signal_received;</span><br><span>@@ -1586,8 +1554,9 @@</span=
><br><span>     {</span><br><span>         case LS_MODE_DEFAULT:</span><br>=
<span>             sock-&gt;sd =3D</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                socket_listen_accept(sock-&gt;sd, &amp;sock-&g=
t;info.lsa-&gt;actual, remote_dynamic,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                     sock-&gt;info.lsa-&gt=
;bind_local, true, false, signal_received);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                socket_listen_accept(sock-&gt;sd, &=
amp;sock-&gt;info.lsa-&gt;actual,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                     sock-&gt;info.lsa-&gt;bi=
nd_local, true, false,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                     signal_received);</span><br><span> =
            break;</span><br><span> </span><br><span>         case LS_MODE_=
TCP_LISTEN:</span><br><span>@@ -1675,7 +1644,7 @@</span><br><span>         =
sock-&gt;info.lsa-&gt;remote_list =3D NULL;</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    resolve_=
remote(sock, 1, NULL, sig_info);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    resolve_remote(sock, 1, sig_info);</span><br><span> }</spa=
n><br><span> </span><br><span> #if defined(_WIN32)</span><br><span>@@ -1733=
,7 +1702,6 @@</span><br><span>     const struct frame *frame =3D &amp;c-&gt=
;c2.frame;</span><br><span>     struct signal_info *sig_info =3D c-&gt;sig;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 const char *remote_dynamic =3D NULL;</span><br><span>     struct signal_in=
fo sig_save =3D { 0 };</span><br><span> </span><br><span>     ASSERT(sock);=
</span><br><span>@@ -1748,18 +1716,8 @@</span><br><span>     /* initialize =
buffers */</span><br><span>     socket_frame_init(frame, sock);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     * Pass a remote name to c=
onnect/accept so that</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     * they can test for dynamic IP address changes</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * and throw a SIGUSR1 if appropriate.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;resolve_retry_secon=
ds)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        remote_dynamic =3D sock-&g=
t;remote_host;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /=
* Second chance to resolv/create socket */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    resolve_remote(sock, 2, &amp;remote_dynamic, sig_i=
nfo);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    resolve_re=
mote(sock, 2, sig_info);</span><br><span> </span><br><span>     /* If a val=
id remote has been found, create the socket with its addrinfo */</span><br>=
<span> #if defined(_WIN32)</span><br><span>@@ -1809,7 +1767,7 @@</span><br>=
<span> </span><br><span>     if (sock-&gt;info.proto =3D=3D PROTO_TCP_SERVE=
R)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        phase2_tcp_server(sock, remote_dynamic, sig_info);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        phase2_tcp_server(sock, =
sig_info);</span><br><span>     }</span><br><span>     else if (sock-&gt;in=
fo.proto =3D=3D PROTO_TCP_CLIENT)</span><br><span>     {</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1468?usp=3Demail">change 1468</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1468?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0141945469dd11340bfb42ec37a=
3c5f90ed0ff52 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1468 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--s96f/OAisB0=--

