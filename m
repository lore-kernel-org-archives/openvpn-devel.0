From: Gert Doering <gert@...1296...>
Date: Thu, 20 Feb 2025 09:09:07 +0100
Message-ID: <20250220080907.9298-1-gert@...1296...>
In-Reply-To: <gerrit.1732212459000.Iedc10616225f6769c66d3c29d4a462b622ebbc6e@...2715...>
References: <gerrit.1732212459000.Iedc10616225f6769c66d3c29d4a462b622ebbc6e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v21] dco-win: kernel notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Lev Stipakov <lev@...515...>

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
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/816
This mail reflects revision 21 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index a3c7b63..f46c93d 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -126,6 +126,17 @@
     ASSERT(dco->ifmode == DCO_MODE_UNINIT);
     dco->ifmode = DCO_MODE_MP;
 
+    /* Use manual reset event so it remains signalled until
+     * explicitly reset. This way we won't lose notifications
+     */
+    dco->ov.hEvent = CreateEvent(NULL, TRUE, FALSE, NULL);
+    if (dco->ov.hEvent == NULL)
+    {
+        msg(M_ERR, "Error: ovpn_dco_init: CreateEvent failed");
+    }
+
+    dco->rwhandle.read = dco->ov.hEvent;
+
     /* open DCO device */
     struct gc_arena gc = gc_new();
     const char *device_guid;
@@ -629,11 +640,74 @@
     }
 }
 
+/**
+ * @brief Handles successful completion of overlapped operation.
+ *
+ * We use overlapped I/O (Windows term for asynchronous I/O) to get
+ * notifications from kernel to userspace. This gets the result of overlapped
+ * operation and, in case of success, copies data from kernel-filled buffer
+ * into userspace-provided dco context.
+ *
+ * @param dco Pointer to the dco context
+ * @param queued true if operation was queued, false if it has completed immediately
+ */
+static void
+dco_handle_overlapped_success(dco_context_t *dco, bool queued)
+{
+    DWORD bytes_read = 0;
+    BOOL res = GetOverlappedResult(dco->tt->hand, &dco->ov, &bytes_read, FALSE);
+    if (res)
+    {
+        msg(D_DCO_DEBUG, "%s: completion%s success [%ld]", __func__, queued ? "" : " non-queued", bytes_read);
+
+        dco->dco_message_peer_id = dco->notif_buf.PeerId;
+        dco->dco_message_type = dco->notif_buf.Cmd;
+        dco->dco_del_peer_reason = dco->notif_buf.DelPeerReason;
+    }
+    else
+    {
+        msg(D_DCO_DEBUG | M_ERRNO, "%s: completion%s error", __func__, queued ? "" : " non-queued");
+    }
+}
+
 int
 dco_do_read(dco_context_t *dco)
 {
-    /* no-op on windows */
-    ASSERT(0);
+    if (dco->ifmode != DCO_MODE_MP)
+    {
+        ASSERT(false);
+    }
+
+    dco->dco_message_peer_id = -1;
+    dco->dco_message_type = 0;
+
+    switch (dco->iostate)
+    {
+        case IOSTATE_QUEUED:
+            dco_handle_overlapped_success(dco, true);
+
+            ASSERT(ResetEvent(dco->ov.hEvent));
+            dco->iostate = IOSTATE_INITIAL;
+
+            break;
+
+        case IOSTATE_IMMEDIATE_RETURN:
+            dco->iostate = IOSTATE_INITIAL;
+            ASSERT(ResetEvent(dco->ov.hEvent));
+
+            if (dco->ov_ret == ERROR_SUCCESS)
+            {
+                dco_handle_overlapped_success(dco, false);
+            }
+            else
+            {
+                SetLastError(dco->ov_ret);
+                msg(D_DCO_DEBUG | M_ERRNO, "%s: completion non-queued error", __func__);
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
+    if (dco->ifmode != DCO_MODE_MP)
+    {
+        /* mp only */
+        return;
+    }
+
+    event_ctl(es, &dco->rwhandle, EVENT_READ, arg);
+
+    if (dco->iostate == IOSTATE_INITIAL)
+    {
+        /* the overlapped IOCTL will signal this event on I/O completion */
+        ASSERT(ResetEvent(dco->ov.hEvent));
+
+        if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_NOTIFY_EVENT, NULL, 0, &dco->notif_buf, sizeof(dco->notif_buf), NULL, &dco->ov))
+        {
+            DWORD err = GetLastError();
+            if (err == ERROR_IO_PENDING) /* operation queued? */
+            {
+                dco->iostate = IOSTATE_QUEUED;
+                dco->ov_ret = ERROR_SUCCESS;
+
+                msg(D_DCO_DEBUG, "%s: notify ioctl queued", __func__);
+            }
+            else
+            {
+                /* error occured */
+                ASSERT(SetEvent(dco->ov.hEvent));
+                dco->iostate = IOSTATE_IMMEDIATE_RETURN;
+                dco->ov_ret = err;
+
+                msg(D_DCO_DEBUG | M_ERRNO, "%s: notify ioctl error", __func__);
+            }
+        }
+        else
+        {
+            ASSERT(SetEvent(dco->ov.hEvent));
+            dco->iostate = IOSTATE_IMMEDIATE_RETURN;
+            dco->ov_ret = ERROR_SUCCESS;
+
+            msg(D_DCO_DEBUG, "%s: notify ioctl immediate return", __func__);
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
+    int iostate; /**< State of overlapped I/O; see definitions in win32.h. */
+    struct rw_handle rwhandle; /**< Used to hook async I/O to the OpenVPN event loop. */
+    int ov_ret; /**< Win32 error code for overlapped operation, 0 for success */
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
     static uintptr_t file_shift = FILE_SHIFT;
 #endif
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    static uintptr_t dco_shift = DCO_SHIFT;    /* Event from DCO linux kernel module */
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32)
+    static uintptr_t dco_shift = DCO_SHIFT;    /* Event from DCO kernel module */
 #endif
 
     /*
@@ -2197,7 +2197,7 @@
                    &c->c2.link_sockets[i]->ev_arg, NULL);
     }
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL);
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32)
     if (socket & EVENT_READ && c->c2.did_open_tun)
     {
         dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)dco_shift);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 5f43db9..e0b27af 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -406,7 +406,8 @@
         multi_process_file_closed(m, mpp_flags);
     }
 #endif
-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
+#if defined(ENABLE_DCO) \
+    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))
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
 
-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
+#if defined(ENABLE_DCO) \
+    && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(TARGET_WIN32))
 static void
 process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi,
                           dco_context_t *dco)

