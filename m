From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 2 Apr 2025 11:11:34 +0000
References: <gerrit.1743592292000.I44a73f06c0672c1d288bf46e9424dc0dc2abe054@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5c966917527b3a6ae08ddd71eb7632948f476d91-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LsQMqpytK4o="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: dco-win: Ensure
 correct OVERLAPPED scope
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

--LsQMqpytK4o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/933?usp=3Demail

to review the following change.


Change subject: dco-win: Ensure correct OVERLAPPED scope
......................................................................

dco-win: Ensure correct OVERLAPPED scope

This is a backport of the master commit

   f60a493 ("dco-win: Fix crash when cancelling pending operation")

Although I am unable to reproduce this issue on release branch,
the code is clearly wrong and has to be fixed.

The OVERLAPPED structure must remain valid for the entire duration of an
asynchronous operation. Previously, when a TCP connection was pending
inside the NEW_PEER call, the OVERLAPPED structure was defined as a
local variable within dco_p2p_new_peer().

When CancelIo() was called later from close_tun_handle(), the OVERLAPPED
structure was already out of scope, resulting in undefined behavior and
stack corruption.

This fix moves the OVERLAPPED structure to the tuntap struct, ensuring
it remains valid throughout the operation's lifetime.

Change-Id: I44a73f06c0672c1d288bf46e9424dc0dc2abe054
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/socket.c
M src/openvpn/tun.h
4 files changed, 9 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/933/1

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 3ec946f..0b8f831 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -156,7 +156,8 @@
 }

 void
-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_lo=
cal,
+dco_create_socket(HANDLE handle, OVERLAPPED *ov,
+                  struct addrinfo *remoteaddr, bool bind_local,
                   struct addrinfo *bind, int timeout,
                   struct signal_info *sig_info)
 {
@@ -229,8 +230,8 @@
         ASSERT(0);
     }

-    OVERLAPPED ov =3D { 0 };
-    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_PEER, &peer, sizeof(peer),=
 NULL, 0, NULL, &ov))
+    CLEAR(*ov);
+    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_PEER, &peer, sizeof(peer),=
 NULL, 0, NULL, ov))
     {
         DWORD err =3D GetLastError();
         if (err !=3D ERROR_IO_PENDING)
@@ -239,7 +240,7 @@
         }
         else
         {
-            dco_connect_wait(handle, &ov, timeout, sig_info);
+            dco_connect_wait(handle, ov, timeout, sig_info);
         }
     }
 }
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 4883629..dcf480e 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -41,7 +41,8 @@
 create_dco_handle(const char *devname, struct gc_arena *gc);

 void
-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_lo=
cal,
+dco_create_socket(HANDLE handle, OVERLAPPED *ov,
+                  struct addrinfo *remoteaddr, bool bind_local,
                   struct addrinfo *bind, int timeout,
                   struct signal_info *sig_info);

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index e070688..2eb2e74 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2148,7 +2148,7 @@
         c->c1.tuntap =3D tt;
     }

-    dco_create_socket(c->c1.tuntap->hand,
+    dco_create_socket(c->c1.tuntap->hand, &c->c1.tuntap->dco_new_peer_ov,
                       sock->info.lsa->current_remote,
                       sock->bind_local, sock->info.lsa->bind_local,
                       get_server_poll_remaining_time(sock->server_poll_tim=
eout),
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 33b9552..91dbeef 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -196,6 +196,7 @@

 #ifdef _WIN32
     HANDLE hand;
+    OVERLAPPED dco_new_peer_ov; /* used for async NEW_PEER dco call, which=
 might wait for TCP connect */
     struct overlapped_io reads;
     struct overlapped_io writes;
     struct rw_handle rw_handle;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/933?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I44a73f06c0672c1d288bf46e9424dc0dc2abe054
Gerrit-Change-Number: 933
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--LsQMqpytK4o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/933?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco-win: Ensure correct OVERLAPPED scope<br><br>This is a bac=
kport of the master commit<br><br>   f60a493 (&quot;dco-win: Fix crash when=
 cancelling pending operation&quot;)<br><br>Although I am unable to reprodu=
ce this issue on release branch,<br>the code is clearly wrong and has to be=
 fixed.<br><br>The OVERLAPPED structure must remain valid for the entire du=
ration of an<br>asynchronous operation. Previously, when a TCP connection w=
as pending<br>inside the NEW_PEER call, the OVERLAPPED structure was define=
d as a<br>local variable within dco_p2p_new_peer().<br><br>When CancelIo() =
was called later from close_tun_handle(), the OVERLAPPED<br>structure was a=
lready out of scope, resulting in undefined behavior and<br>stack corruptio=
n.<br><br>This fix moves the OVERLAPPED structure to the tuntap struct, ens=
uring<br>it remains valid throughout the operation&#39;s lifetime.<br><br>C=
hange-Id: I44a73f06c0672c1d288bf46e9424dc0dc2abe054<br>Signed-off-by: Lev S=
tipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco_win.c<br>M src/op=
envpn/dco_win.h<br>M src/openvpn/socket.c<br>M src/openvpn/tun.h<br>4 files=
 changed, 9 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/33/933/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index 3ec946f..0b8f8=
31 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b=
/src/openvpn/dco_win.c</span><br><span>@@ -156,7 +156,8 @@</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-dco_create_socket(HANDLE handle, struct addrinfo *remo=
teaddr, bool bind_local,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dco_create_socket(HANDLE handle, OVERLAPPED *ov,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  struct addrinfo *remote=
addr, bool bind_local,</span><br><span>                   struct addrinfo *=
bind, int timeout,</span><br><span>                   struct signal_info *s=
ig_info)</span><br><span> {</span><br><span>@@ -229,8 +230,8 @@</span><br><=
span>         ASSERT(0);</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    OVERLAPPED ov =3D { 0 };</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl=
(handle, OVPN_IOCTL_NEW_PEER, &amp;peer, sizeof(peer), NULL, 0, NULL, &amp;=
ov))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*ov);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoCo=
ntrol(handle, OVPN_IOCTL_NEW_PEER, &amp;peer, sizeof(peer), NULL, 0, NULL, =
ov))</span><br><span>     {</span><br><span>         DWORD err =3D GetLastE=
rror();</span><br><span>         if (err !=3D ERROR_IO_PENDING)</span><br><=
span>@@ -239,7 +240,7 @@</span><br><span>         }</span><br><span>       =
  else</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            dco_connect_wait(handle, &amp;ov, timeout, sig_info=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dco_c=
onnect_wait(handle, ov, timeout, sig_info);</span><br><span>         }</spa=
n><br><span>     }</span><br><span> }</span><br><span>diff --git a/src/open=
vpn/dco_win.h b/src/openvpn/dco_win.h</span><br><span>index 4883629..dcf480=
e 100644</span><br><span>--- a/src/openvpn/dco_win.h</span><br><span>+++ b/=
src/openvpn/dco_win.h</span><br><span>@@ -41,7 +41,8 @@</span><br><span> cr=
eate_dco_handle(const char *devname, struct gc_arena *gc);</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_l=
ocal,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_create_soc=
ket(HANDLE handle, OVERLAPPED *ov,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                  struct addrinfo *remoteaddr, bool bind_loc=
al,</span><br><span>                   struct addrinfo *bind, int timeout,<=
/span><br><span>                   struct signal_info *sig_info);</span><br=
><span> </span><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/so=
cket.c</span><br><span>index e070688..2eb2e74 100644</span><br><span>--- a/=
src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><=
span>@@ -2148,7 +2148,7 @@</span><br><span>         c-&gt;c1.tuntap =3D tt;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    dco_create_socket(c-&gt;c1.tuntap-&gt;hand,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_create_socket(c-&gt=
;c1.tuntap-&gt;hand, &amp;c-&gt;c1.tuntap-&gt;dco_new_peer_ov,</span><br><s=
pan>                       sock-&gt;info.lsa-&gt;current_remote,</span><br>=
<span>                       sock-&gt;bind_local, sock-&gt;info.lsa-&gt;bin=
d_local,</span><br><span>                       get_server_poll_remaining_t=
ime(sock-&gt;server_poll_timeout),</span><br><span>diff --git a/src/openvpn=
/tun.h b/src/openvpn/tun.h</span><br><span>index 33b9552..91dbeef 100644</s=
pan><br><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun=
.h</span><br><span>@@ -196,6 +196,7 @@</span><br><span> </span><br><span> #=
ifdef _WIN32</span><br><span>     HANDLE hand;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    OVERLAPPED dco_new_peer_ov; /* used for asyn=
c NEW_PEER dco call, which might wait for TCP connect */</span><br><span>  =
   struct overlapped_io reads;</span><br><span>     struct overlapped_io wr=
ites;</span><br><span>     struct rw_handle rw_handle;</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/933?usp=3Demail">change 933</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/933?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I44a73f06c0672c1d288bf46e942=
4dc0dc2abe054 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 933 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--LsQMqpytK4o=--

