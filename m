From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 1 Apr 2025 13:51:40 +0000
References: <gerrit.1743515497000.Ib1db457c42a80f6b8fc0e3ceb4a895d4cf7f0155@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <26ebd4013ab6b45dd73c2693d66eb2defde72342-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eeZzYpSJW8I="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco-win: Fix crash
 when cancelling pending operation
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

--eeZzYpSJW8I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/928?usp=3Demail

to review the following change.


Change subject: dco-win: Fix crash when cancelling pending operation
......................................................................

dco-win: Fix crash when cancelling pending operation

The OVERLAPPED structure must remain valid for the entire duration of an
asynchronous operation. Previously, when a TCP connection was pending
inside the NEW_PEER call, the OVERLAPPED structure was defined as a
local variable within dco_p2p_new_peer().

When CancelIo() was called later from close_tun_handle(), the OVERLAPPED
structure was already out of scope, resulting in undefined behavior and
stack corruption.

This fix moves the OVERLAPPED structure to the tuntap struct, ensuring
it remains valid throughout the operation's lifetime.

GitHub: #715

Change-Id: Ib1db457c42a80f6b8fc0e3ceb4a895d4cf7f0155
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/socket.c
M src/openvpn/tun.h
4 files changed, 7 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/928/1

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 8b47124..a386e53 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -321,7 +321,7 @@
 }

 void
-dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct signal_in=
fo *sig_info)
+dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_socket *sock, =
struct signal_info *sig_info)
 {
     msg(D_DCO_DEBUG, "%s", __func__);

@@ -395,8 +395,8 @@
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
@@ -405,7 +405,7 @@
         }
         else
         {
-            dco_connect_wait(handle, &ov, get_server_poll_remaining_time(s=
ock->server_poll_timeout), sig_info);
+            dco_connect_wait(handle, ov, get_server_poll_remaining_time(so=
ck->server_poll_timeout), sig_info);
         }
     }
 }
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 95c95c8..e8e4e22 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -63,7 +63,7 @@
 dco_mp_start_vpn(HANDLE handle, struct link_socket *sock);

 void
-dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct signal_in=
fo *sig_info);
+dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_socket *sock, =
struct signal_info *sig_info);

 void
 dco_start_tun(struct tuntap *tt);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 09de1b0..beb31fa 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2242,7 +2242,7 @@
     }
     else
     {
-        dco_p2p_new_peer(c->c1.tuntap->hand, sock, sig_info);
+        dco_p2p_new_peer(c->c1.tuntap->hand, &c->c1.tuntap->dco_new_peer_o=
v, sock, sig_info);
     }
     sock->sockflags |=3D SF_DCO_WIN;

diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index b616f5d..bcc23b4 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -215,6 +215,7 @@

 #ifdef _WIN32
     HANDLE hand;
+    OVERLAPPED dco_new_peer_ov; /* used for async NEW_PEER dco call, which=
 might wait for TCP connect */
     struct overlapped_io reads;
     struct overlapped_io writes;
     struct rw_handle rw_handle;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/928?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib1db457c42a80f6b8fc0e3ceb4a895d4cf7f0155
Gerrit-Change-Number: 928
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--eeZzYpSJW8I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/928?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco-win: Fix crash when cancelling pending operation<br><br>T=
he OVERLAPPED structure must remain valid for the entire duration of an<br>=
asynchronous operation. Previously, when a TCP connection was pending<br>in=
side the NEW_PEER call, the OVERLAPPED structure was defined as a<br>local =
variable within dco_p2p_new_peer().<br><br>When CancelIo() was called later=
 from close_tun_handle(), the OVERLAPPED<br>structure was already out of sc=
ope, resulting in undefined behavior and<br>stack corruption.<br><br>This f=
ix moves the OVERLAPPED structure to the tuntap struct, ensuring<br>it rema=
ins valid throughout the operation&#39;s lifetime.<br><br>GitHub: #715<br><=
br>Change-Id: Ib1db457c42a80f6b8fc0e3ceb4a895d4cf7f0155<br>Signed-off-by: L=
ev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco_win.c<br>M sr=
c/openvpn/dco_win.h<br>M src/openvpn/socket.c<br>M src/openvpn/tun.h<br>4 f=
iles changed, 7 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/28/928/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index 8b47124..a=
386e53 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+=
++ b/src/openvpn/dco_win.c</span><br><span>@@ -321,7 +321,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-dco_p2p_new_peer(HANDLE handle, struct link_socket=
 *sock, struct signal_info *sig_info)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct li=
nk_socket *sock, struct signal_info *sig_info)</span><br><span> {</span><br=
><span>     msg(D_DCO_DEBUG, &quot;%s&quot;, __func__);</span><br><span> </=
span><br><span>@@ -395,8 +395,8 @@</span><br><span>         ASSERT(0);</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    OVERLAPPED ov =3D { 0 };</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_PEER,=
 &amp;peer, sizeof(peer), NULL, 0, NULL, &amp;ov))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    CLEAR(*ov);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_=
PEER, &amp;peer, sizeof(peer), NULL, 0, NULL, ov))</span><br><span>     {</=
span><br><span>         DWORD err =3D GetLastError();</span><br><span>     =
    if (err !=3D ERROR_IO_PENDING)</span><br><span>@@ -405,7 +405,7 @@</spa=
n><br><span>         }</span><br><span>         else</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dco_c=
onnect_wait(handle, &amp;ov, get_server_poll_remaining_time(sock-&gt;server=
_poll_timeout), sig_info);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            dco_connect_wait(handle, ov, get_server_poll_remaining_t=
ime(sock-&gt;server_poll_timeout), sig_info);</span><br><span>         }</s=
pan><br><span>     }</span><br><span> }</span><br><span>diff --git a/src/op=
envpn/dco_win.h b/src/openvpn/dco_win.h</span><br><span>index 95c95c8..e8e4=
e22 100644</span><br><span>--- a/src/openvpn/dco_win.h</span><br><span>+++ =
b/src/openvpn/dco_win.h</span><br><span>@@ -63,7 +63,7 @@</span><br><span> =
dco_mp_start_vpn(HANDLE handle, struct link_socket *sock);</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct signal_i=
nfo *sig_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_=
p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_socket *sock, struc=
t signal_info *sig_info);</span><br><span> </span><br><span> void</span><br=
><span> dco_start_tun(struct tuntap *tt);</span><br><span>diff --git a/src/=
openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 09de1b0..beb3=
1fa 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b=
/src/openvpn/socket.c</span><br><span>@@ -2242,7 +2242,7 @@</span><br><span=
>     }</span><br><span>     else</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        dco_p2p_new_peer(c-&gt;c1.tuntap=
-&gt;hand, sock, sig_info);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        dco_p2p_new_peer(c-&gt;c1.tuntap-&gt;hand, &amp;c-&gt;c1.tu=
ntap-&gt;dco_new_peer_ov, sock, sig_info);</span><br><span>     }</span><br=
><span>     sock-&gt;sockflags |=3D SF_DCO_WIN;</span><br><span> </span><br=
><span>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>i=
ndex b616f5d..bcc23b4 100644</span><br><span>--- a/src/openvpn/tun.h</span>=
<br><span>+++ b/src/openvpn/tun.h</span><br><span>@@ -215,6 +215,7 @@</span=
><br><span> </span><br><span> #ifdef _WIN32</span><br><span>     HANDLE han=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVERLAPPED dc=
o_new_peer_ov; /* used for async NEW_PEER dco call, which might wait for TC=
P connect */</span><br><span>     struct overlapped_io reads;</span><br><sp=
an>     struct overlapped_io writes;</span><br><span>     struct rw_handle =
rw_handle;</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/928?usp=3Demail">change 928</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/928?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib1db457c42a80f6b8fc0e3ceb4a=
895d4cf7f0155 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 928 </div>
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


--eeZzYpSJW8I=--

