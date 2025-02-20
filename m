From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 20 Feb 2025 08:06:12 +0000
In-Reply-To: <gerrit.1732212459000.Iedc10616225f6769c66d3c29d4a462b622ebbc6e@...2715...>
References: <gerrit.1732212459000.Iedc10616225f6769c66d3c29d4a462b622ebbc6e@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <96f6b673a2b00e19ac711ee8ff8fe227d46be831-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MQAb4y9fxDI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MQAb4y9fxDI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail

to look at the new patch set (#21).

The following approvals got outdated and were removed:
Code-Review+1 by cron2


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
5 files changed, 137 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/816/21

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index a3c7b63..f46c93d 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -126,6 +126,17 @@
     ASSERT(dco->ifmode =3D=3D DCO_MODE_UNINIT);
     dco->ifmode =3D DCO_MODE_MP;

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
@@ -629,11 +640,74 @@
     }
 }

+/**
+ * @brief Handles successful completion of overlapped operation.
+ *
+ * We use overlapped I/O (Windows term for asynchronous I/O) to get
+ * notifications from kernel to userspace. This gets the result of overlap=
ped
+ * operation and, in case of success, copies data from kernel-filled buffer
+ * into userspace-provided dco context.
+ *
+ * @param dco Pointer to the dco context
+ * @param queued true if operation was queued, false if it has completed i=
mmediately
+ */
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
+    if (dco->ifmode !=3D DCO_MODE_MP)
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

@@ -676,8 +750,48 @@
 void
 dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 {
-    /* no-op on windows */
-    ASSERT(0);
+    if (dco->ifmode !=3D DCO_MODE_MP)
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
index dc7fbc1..309badf 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -41,6 +41,18 @@
     struct tuntap *tt;
     dco_mode_type ifmode;

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
index 82c54c2..8b94469 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2083,8 +2083,8 @@
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
@@ -2197,7 +2197,7 @@
                    &c->c2.link_sockets[i]->ev_arg, NULL);
     }
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
index 5f43db9..e0b27af 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -406,7 +406,8 @@
         multi_process_file_closed(m, mpp_flags);
     }
 #endif
-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
+#if defined(ENABLE_DCO) \
+    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET=
_WIN32))
     else if (status & DCO_READ)
     {
         if (!IS_SIG(&m->top))
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f76dad8..7ab9289 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3234,7 +3234,8 @@
 }
 #endif

-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
+#if defined(ENABLE_DCO) \
+    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET=
_WIN32))
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
Gerrit-PatchSet: 21
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--MQAb4y9fxDI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p>stipa <strong>uploaded patch set #21</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco-win: kernel notifications<br><br>The driver supp=
orts notifications mechanism, which<br>is used to notify userspace about va=
rious events,<br>such as peer keepalive timeout, key expire and so on.<br><=
br>This uses existing framework of subscribing and<br>receiving dco notific=
ations, used by FreeBSD and Linux<br>implementations. On Windows we use ove=
rlapped IO,<br>which state we keep in DCO context. We create an event,<br>w=
hich is associated with overlapped operation,<br>and inject it into openvpn=
 event loop. When event is<br>signalled, we read overlapped result into DCO=
 context,<br>which is later used by already existing code which<br>handles =
peer deletion.<br><br>Change-Id: Iedc10616225f6769c66d3c29d4a462b622ebbc6e<=
br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvp=
n/dco_win.c<br>M src/openvpn/dco_win.h<br>M src/openvpn/forward.c<br>M src/=
openvpn/mudp.c<br>M src/openvpn/multi.c<br>5 files changed, 137 insertions(=
+), 9 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/16/816/21</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_win.c b/src/o=
penvpn/dco_win.c</span><br><span>index a3c7b63..f46c93d 100644</span><br><s=
pan>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c=
</span><br><span>@@ -126,6 +126,17 @@</span><br><span>     ASSERT(dco-&gt;i=
fmode =3D=3D DCO_MODE_UNINIT);</span><br><span>     dco-&gt;ifmode =3D DCO_=
MODE_MP;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Use manual reset event so it remains signalled until</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * explicitly reset. Thi=
s way we won&#39;t lose notifications</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    dco-&gt;ov.hEvent =3D CreateEvent(NULL, TRUE, FALSE, NULL);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ov.hEvent=
 =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &=
quot;Error: ovpn_dco_init: CreateEvent failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    dco-&gt;rwhandle.read =3D dco-&gt;ov.hEvent;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     /* open DCO device */</=
span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     c=
onst char *device_guid;</span><br><span>@@ -629,11 +640,74 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @brief Handles successful completion of overlapped operation.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * We use overlapped I/O (Windows te=
rm for asynchronous I/O) to get</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * notifications from kernel to userspace. This gets the result=
 of overlapped</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * op=
eration and, in case of success, copies data from kernel-filled buffer</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * into userspace-provid=
ed dco context.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dco Pointer=
 to the dco context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param queued true if operation was queued, false if it has completed im=
mediately</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+dco_handle_overlapped_success(dco_=
context_t *dco, bool queued)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD=
 bytes_read =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   BOOL res =3D GetOverlappedResult(dco-&gt;tt-&gt;hand, &amp;dco-&gt;ov, &=
amp;bytes_read, FALSE);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (res)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO=
_DEBUG, &quot;%s: completion%s success [%ld]&quot;, __func__, queued ? &quo=
t;&quot; : &quot; non-queued&quot;, bytes_read);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        dco-&gt;dco_message_peer_id =3D dco-&gt;notif_buf.PeerId;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco-&gt;dco=
_message_type =3D dco-&gt;notif_buf.Cmd;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        dco-&gt;dco_del_peer_reason =3D dco-&gt;notif_=
buf.DelPeerReason;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG | M_ERRNO, &quot=
;%s: completion%s error&quot;, __func__, queued ? &quot;&quot; : &quot; non=
-queued&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><spa=
n> dco_do_read(dco_context_t *dco)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* no-op on windows */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode !=3D DCO_MODE_MP)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(false);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    dco-&gt;dco_message_peer_id =3D -1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_type =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    switch (dco-&gt;iostate)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        case IOSTATE_QUEUED:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            dco_handle_overlapped_success=
(dco, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(ResetEv=
ent(dco-&gt;ov.hEvent));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            dco-&gt;iostate =3D IOSTATE_INITIAL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case IOSTATE_IMMEDIATE_RETURN:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            dco-&gt;iostate =3D IOSTATE_INITIAL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(ResetEvent(dc=
o-&gt;ov.hEvent));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (dco-=
&gt;ov_ret =3D=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                dco_handle_overlapped_success(dco, false);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                SetLastError(dco-&gt;ov_ret)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ms=
g(D_DCO_DEBUG | M_ERRNO, &quot;%s: completion non-queued error&quot;, __fun=
c__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     return 0;</span><br><span> }</sp=
an><br><span> </span><br><span>@@ -676,8 +750,48 @@</span><br><span> void</=
span><br><span> dco_event_set(dco_context_t *dco, struct event_set *es, voi=
d *arg)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* no-op on windows */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ASSERT(0);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (dco-&gt;ifmode !=3D DCO_MODE_MP)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* mp only */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    event_ctl(es, &amp;=
dco-&gt;rwhandle, EVENT_READ, arg);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (dco-&gt;iostate =3D=3D IOSTATE_INITIAL)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* the overlapped IOCTL will signal this event on I/O co=
mpletion */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ASSERT(ResetEvent(dco-&gt;ov.hEvent));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_NOTIFY_EVENT, =
NULL, 0, &amp;dco-&gt;notif_buf, sizeof(dco-&gt;notif_buf), NULL, &amp;dco-=
&gt;ov))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            DWORD err=
 =3D GetLastError();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (err =3D=3D ERROR_IO_PENDING) /* operation queued? */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                dco-&gt;iostate=
 =3D IOSTATE_QUEUED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                dco-&gt;ov_ret =3D ERROR_SUCCESS;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                msg(D_DCO_DEBUG, &quot;%s: notify ioctl queued&=
quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /=
* error occured */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               ASSERT(SetEvent(dco-&gt;ov.hEvent));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                dco-&gt;iostate =3D IOSTA=
TE_IMMEDIATE_RETURN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                dco-&gt;ov_ret =3D err;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                msg(D_DCO_DEBUG | M_ERRNO, &quot;%s: notify ioctl error&q=
uot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(SetEvent(dco-&gt;=
ov.hEvent));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     dco-&gt;iostate =3D IOSTATE_IMMEDIATE_RETURN;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            dco-&gt;ov_ret =3D ERROR_SUCCESS=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO_DEBUG, &quot;%s=
: notify ioctl immediate return&quot;, __func__);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><s=
pan> const char *</span><br><span>diff --git a/src/openvpn/dco_win.h b/src/=
openvpn/dco_win.h</span><br><span>index dc7fbc1..309badf 100644</span><br><=
span>--- a/src/openvpn/dco_win.h</span><br><span>+++ b/src/openvpn/dco_win.=
h</span><br><span>@@ -41,6 +41,18 @@</span><br><span>     struct tuntap *tt=
;</span><br><span>     dco_mode_type ifmode;</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NOTIFY_EVENT notif_buf;=
 /**&lt; Buffer for incoming notifications. */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    OVERLAPPED ov; /**&lt; Used by overlapped I/=
O for async IOCTL. */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int iostate; /**&lt; State of overlapped I/O; see definitions in win3=
2.h. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct r=
w_handle rwhandle; /**&lt; Used to hook async I/O to the OpenVPN event loop=
. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ov_ret;=
 /**&lt; Win32 error code for overlapped operation, 0 for success */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int dco_message_peer_id;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int dco_message_type;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int dco_del_peer_reason;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint64_t dco_read_bytes;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t dco_write_bytes;</=
span><br><span> };</span><br><span> </span><br><span> typedef struct dco_co=
ntext dco_context_t;</span><br><span>diff --git a/src/openvpn/forward.c b/s=
rc/openvpn/forward.c</span><br><span>index 82c54c2..8b94469 100644</span><b=
r><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forwa=
rd.c</span><br><span>@@ -2083,8 +2083,8 @@</span><br><span> #ifdef ENABLE_A=
SYNC_PUSH</span><br><span>     static uintptr_t file_shift =3D FILE_SHIFT;<=
/span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    static uintptr_t dco_shift =3D DCO_SHI=
FT;    /* Event from DCO linux kernel module */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FRE=
EBSD) || defined(TARGET_WIN32)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    static uintptr_t dco_shift =3D DCO_SHIFT;    /* Event from D=
CO kernel module */</span><br><span> #endif</span><br><span> </span><br><sp=
an>     /*</span><br><span>@@ -2197,7 +2197,7 @@</span><br><span>          =
          &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg, NULL);</span><br><span>=
     }</span><br><span>     tun_set(c-&gt;c1.tuntap, c-&gt;c2.event_set, tu=
ntap, (void *)tun_shift, NULL);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || def=
ined(TARGET_FREEBSD) || defined(TARGET_WIN32)</span><br><span>     if (sock=
et &amp; EVENT_READ &amp;&amp; c-&gt;c2.did_open_tun)</span><br><span>     =
{</span><br><span>         dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, c-&g=
t;c2.event_set, (void *)dco_shift);</span><br><span>diff --git a/src/openvp=
n/mudp.c b/src/openvpn/mudp.c</span><br><span>index 5f43db9..e0b27af 100644=
</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn=
/mudp.c</span><br><span>@@ -406,7 +406,8 @@</span><br><span>         multi_=
process_file_closed(m, mpp_flags);</span><br><span>     }</span><br><span> =
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENA=
BLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO) =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &amp;&amp; (de=
fined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))</s=
pan><br><span>     else if (status &amp; DCO_READ)</span><br><span>     {</=
span><br><span>         if (!IS_SIG(&amp;m-&gt;top))</span><br><span>diff -=
-git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index f76d=
ad8..7ab9289 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><sp=
an>+++ b/src/openvpn/multi.c</span><br><span>@@ -3234,7 +3234,8 @@</span><b=
r><span> }</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DCO) &amp;&amp; (defined=
(TARGET_LINUX) || defined(TARGET_FREEBSD))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO) \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &amp;&amp; (defined(TARGET_LINUX) || defin=
ed(TARGET_FREEBSD) || defined(TARGET_WIN32))</span><br><span> static void</=
span><br><span> process_incoming_del_peer(struct multi_context *m, struct m=
ulti_instance *mi,</span><br><span>                           dco_context_t=
 *dco)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/816?usp=3Demail">change 816</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/816?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iedc10616225f6769c66d3c29d4a=
462b622ebbc6e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 816 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--MQAb4y9fxDI=--

