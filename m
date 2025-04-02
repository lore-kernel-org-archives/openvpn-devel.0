From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 2 Apr 2025 14:33:34 +0000
In-Reply-To: <gerrit.1743592292000.I44a73f06c0672c1d288bf46e9424dc0dc2abe054@...2715...>
References: <gerrit.1743592292000.I44a73f06c0672c1d288bf46e9424dc0dc2abe054@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <fa42fa26960e0efd78356ff2b066939487ea4b87-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OmZTUqKfYyY="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OmZTUqKfYyY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/933?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250402113016.14980-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
316.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/socket.c
M src/openvpn/tun.h
4 files changed, 9 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/933/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--OmZTUqKfYyY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/933?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco-win: Ensure correct OVERLAPPED scope<br><br>This=
 is a backport of the master commit<br><br>   f60a493 (&quot;dco-win: Fix c=
rash when cancelling pending operation&quot;)<br><br>Although I am unable t=
o reproduce this issue on release branch,<br>the code is clearly wrong and =
has to be fixed.<br><br>The OVERLAPPED structure must remain valid for the =
entire duration of an<br>asynchronous operation. Previously, when a TCP con=
nection was pending<br>inside the NEW_PEER call, the OVERLAPPED structure w=
as defined as a<br>local variable within dco_p2p_new_peer().<br><br>When Ca=
ncelIo() was called later from close_tun_handle(), the OVERLAPPED<br>struct=
ure was already out of scope, resulting in undefined behavior and<br>stack =
corruption.<br><br>This fix moves the OVERLAPPED structure to the tuntap st=
ruct, ensuring<br>it remains valid throughout the operation&#39;s lifetime.=
<br><br>Change-Id: I44a73f06c0672c1d288bf46e9424dc0dc2abe054<br>Signed-off-=
by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>Message-Id: &lt;20250402113016.14980-1-gert@...1296...&gt;=
<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg31316.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<=
br>M src/openvpn/dco_win.c<br>M src/openvpn/dco_win.h<br>M src/openvpn/sock=
et.c<br>M src/openvpn/tun.h<br>4 files changed, 9 insertions(+), 6 deletion=
s(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/33/933/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.=
c</span><br><span>index 3ec946f..0b8f831 100644</span><br><span>--- a/src/o=
penvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><spa=
n>@@ -156,7 +156,8 @@</span><br><span> }</span><br><span> </span><br><span>=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_create_socke=
t(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+dco_create_socket(HANDLE handle,=
 OVERLAPPED *ov,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
               struct addrinfo *remoteaddr, bool bind_local,</span><br><spa=
n>                   struct addrinfo *bind, int timeout,</span><br><span>  =
                 struct signal_info *sig_info)</span><br><span> {</span><br=
><span>@@ -229,8 +230,8 @@</span><br><span>         ASSERT(0);</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    OVERLAPPED ov =3D { 0 };</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_PEER, &amp;pe=
er, sizeof(peer), NULL, 0, NULL, &amp;ov))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    CLEAR(*ov);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_PEER, &a=
mp;peer, sizeof(peer), NULL, 0, NULL, ov))</span><br><span>     {</span><br=
><span>         DWORD err =3D GetLastError();</span><br><span>         if (=
err !=3D ERROR_IO_PENDING)</span><br><span>@@ -239,7 +240,7 @@</span><br><s=
pan>         }</span><br><span>         else</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            dco_connect_w=
ait(handle, &amp;ov, timeout, sig_info);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            dco_connect_wait(handle, ov, timeout, sig_=
info);</span><br><span>         }</span><br><span>     }</span><br><span> }=
</span><br><span>diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h=
</span><br><span>index 4883629..dcf480e 100644</span><br><span>--- a/src/op=
envpn/dco_win.h</span><br><span>+++ b/src/openvpn/dco_win.h</span><br><span=
>@@ -41,7 +41,8 @@</span><br><span> create_dco_handle(const char *devname, =
struct gc_arena *gc);</span><br><span> </span><br><span> void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-dco_create_socket(HANDLE handle, st=
ruct addrinfo *remoteaddr, bool bind_local,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dco_create_socket(HANDLE handle, OVERLAPPED *ov,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                  stru=
ct addrinfo *remoteaddr, bool bind_local,</span><br><span>                 =
  struct addrinfo *bind, int timeout,</span><br><span>                   st=
ruct signal_info *sig_info);</span><br><span> </span><br><span>diff --git a=
/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index e070688.=
.2eb2e74 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>=
+++ b/src/openvpn/socket.c</span><br><span>@@ -2148,7 +2148,7 @@</span><br>=
<span>         c-&gt;c1.tuntap =3D tt;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_create_so=
cket(c-&gt;c1.tuntap-&gt;hand,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    dco_create_socket(c-&gt;c1.tuntap-&gt;hand, &amp;c-&gt;c1.tu=
ntap-&gt;dco_new_peer_ov,</span><br><span>                       sock-&gt;i=
nfo.lsa-&gt;current_remote,</span><br><span>                       sock-&gt=
;bind_local, sock-&gt;info.lsa-&gt;bind_local,</span><br><span>            =
           get_server_poll_remaining_time(sock-&gt;server_poll_timeout),</s=
pan><br><span>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br>=
<span>index 33b9552..91dbeef 100644</span><br><span>--- a/src/openvpn/tun.h=
</span><br><span>+++ b/src/openvpn/tun.h</span><br><span>@@ -196,6 +196,7 @=
@</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span>     HAN=
DLE hand;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVERLA=
PPED dco_new_peer_ov; /* used for async NEW_PEER dco call, which might wait=
 for TCP connect */</span><br><span>     struct overlapped_io reads;</span>=
<br><span>     struct overlapped_io writes;</span><br><span>     struct rw_=
handle rw_handle;</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/933?usp=3Demail">change 933</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/933?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I44a73f06c0672c1d288bf46e942=
4dc0dc2abe054 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 933 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--OmZTUqKfYyY=--

