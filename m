From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 21 Nov 2024 18:07:58 +0000
References: <gerrit.1732212459000.Iedc10616225f6769c66d3c29d4a462b622ebbc6e@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9bf069abf30837051fe449c2b42c8083da4b822e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gh05uuuCf+A="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: kernel
 notifications
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

--gh05uuuCf+A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail

to review the following change.


Change subject: dco-win: kernel notifications
......................................................................

dco-win: kernel notifications

The driver supports notifications mechanism, which
is used to notify userspace about various events,
such as peer keepalive timeout, key expire and so on.

This uses existing framework of subscribing and
receiving dco notifications, used by FreeBSD and Linux
implementations. On Windows we use overlapped IO,
which state we keep in DCO context. We create an event,
which is associated with overlapped operation,
and inject it into openvpn event loop. When event is
signalled, we read overlapped result into DCO context,
which is later used by already existing code which
handles peer deletion.

Change-Id: Iedc10616225f6769c66d3c29d4a462b622ebbc6e
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/forward.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
5 files changed, 124 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/816/1

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 7be6fdb..702b4bf 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -136,6 +136,17 @@
         return true;
     }

+    /* Use manual reset event so it remains signalled until
+     * explicitly reset. This way we won't lose notifications
+     */
+    dco->ov.hEvent =3D CreateEvent(NULL, TRUE, FALSE, NULL);
+    if (dco->ov.hEvent =3D=3D NULL)
+    {
+        msg(M_ERR, "Error: ovpn_dco_init: CreateEvent failed");
+    }
+
+    dco->rwhandle.read =3D dco->ov.hEvent;
+
     /* open DCO device */
     struct gc_arena gc =3D gc_new();
     const char *device_guid;
@@ -690,11 +701,63 @@
     }
 }

+static void
+dco_handle_overlapped_success(dco_context_t *dco, bool queued)
+{
+    DWORD bytes_read =3D 0;
+    BOOL res =3D GetOverlappedResult(dco->tt->hand, &dco->ov, &bytes_read,=
 FALSE);
+    if (res)
+    {
+        msg(D_DCO_DEBUG, "%s: completion%s success [%ld]", __func__, queue=
d ? "" : " non-queued", bytes_read);
+
+        dco->dco_message_peer_id =3D dco->notif_buf.PeerId;
+        dco->dco_message_type =3D dco->notif_buf.Cmd;
+        dco->dco_del_peer_reason =3D dco->notif_buf.DelPeerReason;
+    }
+    else
+    {
+        msg(D_DCO_DEBUG | M_ERRNO, "%s: completion%s error", __func__, que=
ued ? "" : " non-queued");
+    }
+}
+
 int
 dco_do_read(dco_context_t *dco)
 {
-    /* no-op on windows */
-    ASSERT(0);
+    if (dco->mode !=3D dco_mode_mp)
+    {
+        ASSERT(false);
+    }
+
+    dco->dco_message_peer_id =3D -1;
+    dco->dco_message_type =3D 0;
+
+    switch (dco->iostate)
+    {
+        case IOSTATE_QUEUED:
+            dco_handle_overlapped_success(dco, true);
+
+            ASSERT(ResetEvent(dco->ov.hEvent));
+            dco->iostate =3D IOSTATE_INITIAL;
+
+            break;
+
+        case IOSTATE_IMMEDIATE_RETURN:
+            dco->iostate =3D IOSTATE_INITIAL;
+            ASSERT(ResetEvent(dco->ov.hEvent));
+
+            if (dco->ov_ret =3D=3D ERROR_SUCCESS)
+            {
+                dco_handle_overlapped_success(dco, false);
+            }
+            else
+            {
+                SetLastError(dco->ov_ret);
+                msg(D_DCO_DEBUG | M_ERRNO, "%s: completion non-queued erro=
r", __func__);
+            }
+
+            break;
+    }
+
     return 0;
 }

@@ -737,8 +800,48 @@
 void
 dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 {
-    /* no-op on windows */
-    ASSERT(0);
+    if (dco->mode !=3D dco_mode_mp)
+    {
+        /* mp only */
+        return;
+    }
+
+    event_ctl(es, &dco->rwhandle, EVENT_READ, arg);
+
+    if (dco->iostate =3D=3D IOSTATE_INITIAL)
+    {
+        /* the overlapped IOCTL will signal this event on I/O completion */
+        ASSERT(ResetEvent(dco->ov.hEvent));
+
+        if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_NOTIFY_EVENT, NULL,=
 0, &dco->notif_buf, sizeof(dco->notif_buf), NULL, &dco->ov))
+        {
+            DWORD err =3D GetLastError();
+            if (err =3D=3D ERROR_IO_PENDING) /* operation queued? */
+            {
+                dco->iostate =3D IOSTATE_QUEUED;
+                dco->ov_ret =3D ERROR_SUCCESS;
+
+                msg(D_DCO_DEBUG, "%s: notify ioctl queued", __func__);
+            }
+            else
+            {
+                /* error occured */
+                ASSERT(SetEvent(dco->ov.hEvent));
+                dco->iostate =3D IOSTATE_IMMEDIATE_RETURN;
+                dco->ov_ret =3D err;
+
+                msg(D_DCO_DEBUG | M_ERRNO, "%s: notify ioctl error", __fun=
c__);
+            }
+        }
+        else
+        {
+            ASSERT(SetEvent(dco->ov.hEvent));
+            dco->iostate =3D IOSTATE_IMMEDIATE_RETURN;
+            dco->ov_ret =3D ERROR_SUCCESS;
+
+            msg(D_DCO_DEBUG, "%s: notify ioctl immediate return", __func__=
);
+        }
+    }
 }

 const char *
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 3e1c2f3..65c5d26 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -41,6 +41,18 @@
     struct tuntap *tt;
     dco_mode_type mode;

+    OVPN_NOTIFY_EVENT notif_buf; /**< Buffer for incoming notifications. */
+    OVERLAPPED ov; /**< Used by overlapped I/O for async IOCTL. */
+    int iostate; /**< State of overlapped I/O; see definitions in win32.h.=
 */
+    struct rw_handle rwhandle; /**< Used to hook async I/O to the OpenVPN =
event loop. */
+    int ov_ret; /**< Win32 error code for overlapped operation, 0 for succ=
ess */
+
+    int dco_message_peer_id;
+    int dco_message_type;
+    int dco_del_peer_reason;
+
+    uint64_t dco_read_bytes;
+    uint64_t dco_write_bytes;
 };

 typedef struct dco_context dco_context_t;
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0a3936a..6468011 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2076,8 +2076,8 @@
 #ifdef ENABLE_ASYNC_PUSH
     static uintptr_t file_shift =3D FILE_SHIFT;
 #endif
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    static uintptr_t dco_shift =3D DCO_SHIFT;    /* Event from DCO linux k=
ernel module */
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN=
32)
+    static uintptr_t dco_shift =3D DCO_SHIFT;    /* Event from DCO kernel =
module */
 #endif

     /*
@@ -2187,7 +2187,7 @@
     socket_set(c->c2.link_socket, c->c2.event_set, socket,
                &c->c2.link_socket->ev_arg, NULL);
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL=
);
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN=
32)
     if (socket & EVENT_READ && c->c2.did_open_tun)
     {
         dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)dco_shi=
ft);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index d8e3d69..959d0a2 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -404,7 +404,7 @@
         multi_process_file_closed(m, mpp_flags);
     }
 #endif
-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D) || defined(TARGET_WIN32))
     else if (status & DCO_READ)
     {
         if (!IS_SIG(&m->top))
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 45b3cfa..6ebf573 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3219,7 +3219,7 @@
 }
 #endif

-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D) || defined(TARGET_WIN32))
 static void
 process_incoming_del_peer(struct multi_context *m, struct multi_instance *=
mi,
                           dco_context_t *dco)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iedc10616225f6769c66d3c29d4a462b622ebbc6e
Gerrit-Change-Number: 816
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--gh05uuuCf+A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco-win: kernel notifications<br><br>The driver supports noti=
fications mechanism, which<br>is used to notify userspace about various eve=
nts,<br>such as peer keepalive timeout, key expire and so on.<br><br>This u=
ses existing framework of subscribing and<br>receiving dco notifications, u=
sed by FreeBSD and Linux<br>implementations. On Windows we use overlapped I=
O,<br>which state we keep in DCO context. We create an event,<br>which is a=
ssociated with overlapped operation,<br>and inject it into openvpn event lo=
op. When event is<br>signalled, we read overlapped result into DCO context,=
<br>which is later used by already existing code which<br>handles peer dele=
tion.<br><br>Change-Id: Iedc10616225f6769c66d3c29d4a462b622ebbc6e<br>Signed=
-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco_win=
.c<br>M src/openvpn/dco_win.h<br>M src/openvpn/forward.c<br>M src/openvpn/m=
udp.c<br>M src/openvpn/multi.c<br>5 files changed, 124 insertions(+), 9 del=
etions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/16/816/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco=
_win.c</span><br><span>index 7be6fdb..702b4bf 100644</span><br><span>--- a/=
src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br=
><span>@@ -136,6 +136,17 @@</span><br><span>         return true;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Use manual reset event so it remains signalled until</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * explicitly reset=
. This way we won&#39;t lose notifications</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    dco-&gt;ov.hEvent =3D CreateEvent(NULL, TRUE, FALSE, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ov.h=
Event =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_E=
RR, &quot;Error: ovpn_dco_init: CreateEvent failed&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    dco-&gt;rwhandle.read =3D dco-&gt;ov.hEvent;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* open DCO device=
 */</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> =
    const char *device_guid;</span><br><span>@@ -690,11 +701,63 @@</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+dco_handle_overlapped_success(dco_context_t *dco,=
 bool queued)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_read =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL res =3D=
 GetOverlappedResult(dco-&gt;tt-&gt;hand, &amp;dco-&gt;ov, &amp;bytes_read,=
 FALSE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (res=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%=
s: completion%s success [%ld]&quot;, __func__, queued ? &quot;&quot; : &quo=
t; non-queued&quot;, bytes_read);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   dco-&gt;dco_message_peer_id =3D dco-&gt;notif_buf.PeerId;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        dco-&gt;dco_message_type =
=3D dco-&gt;notif_buf.Cmd;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        dco-&gt;dco_del_peer_reason =3D dco-&gt;notif_buf.DelPeerRea=
son;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(D_DCO_DEBUG | M_ERRNO, &quot;%s: completio=
n%s error&quot;, __func__, queued ? &quot;&quot; : &quot; non-queued&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> dco_do_read=
(dco_context_t *dco)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* no-op on windows */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ASSERT(0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (dco-&gt;mode !=3D dco_mode_mp)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        ASSERT(false);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco=
-&gt;dco_message_peer_id =3D -1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    dco-&gt;dco_message_type =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    switch (dco-&gt;iostate)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        case IOSTATE_QUEUED:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            dco_handle_overlapped_success(dco, true);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            ASSERT(ResetEvent(dco-&gt;ov.hEven=
t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dco=
-&gt;iostate =3D IOSTATE_INITIAL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        case IOSTATE_IMME=
DIATE_RETURN:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      dco-&gt;iostate =3D IOSTATE_INITIAL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            ASSERT(ResetEvent(dco-&gt;ov.hEvent));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (dco-&gt;ov_ret =3D=3D ER=
ROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   dco_handle_overlapped_success(dco, false);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                SetLastError(dco-&gt;ov_ret);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                msg(D_DCO_DEBUG | M_ER=
RNO, &quot;%s: completion non-queued error&quot;, __func__);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     return 0;</span><br><span> }</span><br><span> </span=
><br><span>@@ -737,8 +800,48 @@</span><br><span> void</span><br><span> dco_=
event_set(dco_context_t *dco, struct event_set *es, void *arg)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* no-op on=
 windows */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT=
(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt=
;mode !=3D dco_mode_mp)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 mp only */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    event_ctl(es, &amp;dco-&gt;rwhandle, EVEN=
T_READ, arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;iostate =
=3D=3D IOSTATE_INITIAL)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 the overlapped IOCTL will signal this event on I/O completion */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(ResetEvent(dco=
-&gt;ov.hEvent));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!DeviceIo=
Control(dco-&gt;tt-&gt;hand, OVPN_IOCTL_NOTIFY_EVENT, NULL, 0, &amp;dco-&gt=
;notif_buf, sizeof(dco-&gt;notif_buf), NULL, &amp;dco-&gt;ov))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            DWORD err =3D GetLastError();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (err=
 =3D=3D ERROR_IO_PENDING) /* operation queued? */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                dco-&gt;iostate =3D IOSTATE_QUEUED;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                dco=
-&gt;ov_ret =3D ERROR_SUCCESS;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        msg(D_DCO_DEBUG, &quot;%s: notify ioctl queued&quot;, __func__);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                /* error occured */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ASSER=
T(SetEvent(dco-&gt;ov.hEvent));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                dco-&gt;iostate =3D IOSTATE_IMMEDIATE_RETURN;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                dco-&=
gt;ov_ret =3D err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
D_DCO_DEBUG | M_ERRNO, &quot;%s: notify ioctl error&quot;, __func__);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            ASSERT(SetEvent(dco-&gt;ov.hEvent));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            dco-&gt;iostate =
=3D IOSTATE_IMMEDIATE_RETURN;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            dco-&gt;ov_ret =3D ERROR_SUCCESS;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(D_DCO_DEBUG, &quot;%s: notify ioctl immedi=
ate return&quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span> }</span><br><span> </span><br><span> const char *</sp=
an><br><span>diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h</sp=
an><br><span>index 3e1c2f3..65c5d26 100644</span><br><span>--- a/src/openvp=
n/dco_win.h</span><br><span>+++ b/src/openvpn/dco_win.h</span><br><span>@@ =
-41,6 +41,18 @@</span><br><span>     struct tuntap *tt;</span><br><span>   =
  dco_mode_type mode;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    OVPN_NOTIFY_EVENT notif_buf; /**&lt; Buffer for inc=
oming notifications. */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    OVERLAPPED ov; /**&lt; Used by overlapped I/O for async IOCTL. */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int iostate; /**&=
lt; State of overlapped I/O; see definitions in win32.h. */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct rw_handle rwhandle; /**&=
lt; Used to hook async I/O to the OpenVPN event loop. */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int ov_ret; /**&lt; Win32 error co=
de for overlapped operation, 0 for success */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int dco_message_peer_id;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int dco_message_type;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int dco_del_peer_reason;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    uint64_t dco_read_bytes;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint64_t dco_write_bytes;</span><br><span> };</spa=
n><br><span> </span><br><span> typedef struct dco_context dco_context_t;</s=
pan><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</s=
pan><br><span>index 0a3936a..6468011 100644</span><br><span>--- a/src/openv=
pn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@=
 -2076,8 +2076,8 @@</span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><sp=
an>     static uintptr_t file_shift =3D FILE_SHIFT;</span><br><span> #endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LI=
NUX) || defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    static uintptr_t dco_shift =3D DCO_SHIFT;    /* Event from DC=
O linux kernel module */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET=
_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static u=
intptr_t dco_shift =3D DCO_SHIFT;    /* Event from DCO kernel module */</sp=
an><br><span> #endif</span><br><span> </span><br><span>     /*</span><br><s=
pan>@@ -2187,7 +2187,7 @@</span><br><span>     socket_set(c-&gt;c2.link_soc=
ket, c-&gt;c2.event_set, socket,</span><br><span>                &amp;c-&gt=
;c2.link_socket-&gt;ev_arg, NULL);</span><br><span>     tun_set(c-&gt;c1.tu=
ntap, c-&gt;c2.event_set, tuntap, (void *)tun_shift, NULL);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || defined(=
TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32)</=
span><br><span>     if (socket &amp; EVENT_READ &amp;&amp; c-&gt;c2.did_ope=
n_tun)</span><br><span>     {</span><br><span>         dco_event_set(&amp;c=
-&gt;c1.tuntap-&gt;dco, c-&gt;c2.event_set, (void *)dco_shift);</span><br><=
span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>i=
ndex d8e3d69..959d0a2 100644</span><br><span>--- a/src/openvpn/mudp.c</span=
><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -404,7 +404,7 @@</sp=
an><br><span>         multi_process_file_closed(m, mpp_flags);</span><br><s=
pan>     }</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || d=
efined(TARGET_FREEBSD))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TA=
RGET_FREEBSD) || defined(TARGET_WIN32))</span><br><span>     else if (statu=
s &amp; DCO_READ)</span><br><span>     {</span><br><span>         if (!IS_S=
IG(&amp;m-&gt;top))</span><br><span>diff --git a/src/openvpn/multi.c b/src/=
openvpn/multi.c</span><br><span>index 45b3cfa..6ebf573 100644</span><br><sp=
an>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</spa=
n><br><span>@@ -3219,7 +3219,7 @@</span><br><span> }</span><br><span> #endi=
f</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_F=
REEBSD))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) |=
| defined(TARGET_WIN32))</span><br><span> static void</span><br><span> proc=
ess_incoming_del_peer(struct multi_context *m, struct multi_instance *mi,</=
span><br><span>                           dco_context_t *dco)</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/816?usp=3Demail">change 816</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/816?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iedc10616225f6769c66d3c29d4a=
462b622ebbc6e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 816 </div>
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


--gh05uuuCf+A=--

