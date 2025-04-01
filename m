From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 1 Apr 2025 20:53:39 +0000
In-Reply-To: <gerrit.1743515497000.Ib1db457c42a80f6b8fc0e3ceb4a895d4cf7f0155@...2715...>
References: <gerrit.1743515497000.Ib1db457c42a80f6b8fc0e3ceb4a895d4cf7f0155@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <216cd5e5058336330d341078e688efd1a4855911-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9AUnl+vlvHU="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9AUnl+vlvHU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/928?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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

Github: closes OpenVPN/openvpn#715

Change-Id: Ib1db457c42a80f6b8fc0e3ceb4a895d4cf7f0155
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250401181535.7854-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59168247/
URL: https://gerrit.openvpn.net/c/openvpn/+/928
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/socket.c
M src/openvpn/tun.h
4 files changed, 7 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/928/2

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 8b47124..a386e53 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -321,7 +321,7 @@
 }
=20
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
index 4fb6fe6..bd7a449 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2247,7 +2247,7 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--9AUnl+vlvHU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/928?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco-win: Fix crash when cancelling pending operation=
<br><br>The OVERLAPPED structure must remain valid for the entire duration =
of an<br>asynchronous operation. Previously, when a TCP connection was pend=
ing<br>inside the NEW_PEER call, the OVERLAPPED structure was defined as a<=
br>local variable within dco_p2p_new_peer().<br><br>When CancelIo() was cal=
led later from close_tun_handle(), the OVERLAPPED<br>structure was already =
out of scope, resulting in undefined behavior and<br>stack corruption.<br><=
br>This fix moves the OVERLAPPED structure to the tuntap struct, ensuring<b=
r>it remains valid throughout the operation&#39;s lifetime.<br><br>Github: =
closes OpenVPN/openvpn#715<br><br>Change-Id: Ib1db457c42a80f6b8fc0e3ceb4a89=
5d4cf7f0155<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-b=
y: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250401181535.7=
854-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman=
/message/59168247/<br>URL: https://gerrit.openvpn.net/c/openvpn/+/928<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/d=
co_win.c<br>M src/openvpn/dco_win.h<br>M src/openvpn/socket.c<br>M src/open=
vpn/tun.h<br>4 files changed, 7 insertions(+), 6 deletions(-)<br><br></pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/928/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>=
index 8b47124..a386e53 100644</span><br><span>--- a/src/openvpn/dco_win.c</=
span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -321,7 +321,7=
 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-dco_p2p_new_peer(HANDLE handle, st=
ruct link_socket *sock, struct signal_info *sig_info)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_p2p_new_peer(HANDLE handle, OVERLAPPE=
D *ov, struct link_socket *sock, struct signal_info *sig_info)</span><br><s=
pan> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s&quot;, __func__);</sp=
an><br><span> </span><br><span>@@ -395,8 +395,8 @@</span><br><span>        =
 ASSERT(0);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    OVERLAPPED ov =3D { 0 };</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(handle, OVP=
N_IOCTL_NEW_PEER, &amp;peer, sizeof(peer), NULL, 0, NULL, &amp;ov))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*ov);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(handle=
, OVPN_IOCTL_NEW_PEER, &amp;peer, sizeof(peer), NULL, 0, NULL, ov))</span><=
br><span>     {</span><br><span>         DWORD err =3D GetLastError();</spa=
n><br><span>         if (err !=3D ERROR_IO_PENDING)</span><br><span>@@ -405=
,7 +405,7 @@</span><br><span>         }</span><br><span>         else</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            dco_connect_wait(handle, &amp;ov, get_server_poll_remaining_tim=
e(sock-&gt;server_poll_timeout), sig_info);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            dco_connect_wait(handle, ov, get_server=
_poll_remaining_time(sock-&gt;server_poll_timeout), sig_info);</span><br><s=
pan>         }</span><br><span>     }</span><br><span> }</span><br><span>di=
ff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h</span><br><span>in=
dex 95c95c8..e8e4e22 100644</span><br><span>--- a/src/openvpn/dco_win.h</sp=
an><br><span>+++ b/src/openvpn/dco_win.h</span><br><span>@@ -63,7 +63,7 @@<=
/span><br><span> dco_mp_start_vpn(HANDLE handle, struct link_socket *sock);=
</span><br><span> </span><br><span> void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-dco_p2p_new_peer(HANDLE handle, struct link_socket *sock=
, struct signal_info *sig_info);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_so=
cket *sock, struct signal_info *sig_info);</span><br><span> </span><br><spa=
n> void</span><br><span> dco_start_tun(struct tuntap *tt);</span><br><span>=
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>in=
dex 4fb6fe6..bd7a449 100644</span><br><span>--- a/src/openvpn/socket.c</spa=
n><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -2247,7 +2247,7 @=
@</span><br><span>     }</span><br><span>     else</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_p2p_new_pee=
r(c-&gt;c1.tuntap-&gt;hand, sock, sig_info);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        dco_p2p_new_peer(c-&gt;c1.tuntap-&gt;hand,=
 &amp;c-&gt;c1.tuntap-&gt;dco_new_peer_ov, sock, sig_info);</span><br><span=
>     }</span><br><span>     sock-&gt;sockflags |=3D SF_DCO_WIN;</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h<=
/span><br><span>index b616f5d..bcc23b4 100644</span><br><span>--- a/src/ope=
nvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span><br><span>@@ -215,=
6 +215,7 @@</span><br><span> </span><br><span> #ifdef _WIN32</span><br><spa=
n>     HANDLE hand;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    OVERLAPPED dco_new_peer_ov; /* used for async NEW_PEER dco call, which =
might wait for TCP connect */</span><br><span>     struct overlapped_io rea=
ds;</span><br><span>     struct overlapped_io writes;</span><br><span>     =
struct rw_handle rw_handle;</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/928?usp=3Demail">chang=
e 928</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/928?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib1db457c42a80f6b8fc0e3ceb4a=
895d4cf7f0155 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 928 </div>
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


--9AUnl+vlvHU=--

