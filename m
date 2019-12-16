From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 16 Dec 2019 12:56:08 +0200
Message-Id: <20191216105608.395-1-lstipakov@...277...>
In-Reply-To: <3a52ffe7-4da4-be0f-d90f-948e8e9a1cec@...1856...>
References: <3a52ffe7-4da4-be0f-d90f-948e8e9a1cec@...1856...>
Subject: [Openvpn-devel] [PATCH v7 4/7] wintun: ring buffers based I/O
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Implemented according to Wintun documentation
and reference client code.

Wintun uses ring buffers to communicate between
kernel driver and user process. Client allocates
send and receive ring buffers, creates events
and passes it to kernel driver under LocalSystem
privileges.

When data is available for read, wintun modifies
"tail" pointer of send ring and signals via event.
User process reads data from "head" to "tail" and
updates "head" pointer.

When user process is ready to write, it writes
to receive ring, updates "tail" pointer and signals
to kernel via event.

In openvpn code we add send ring's event to event loop.
Before performing io wait, we compare "head" and "tail"
pointers of send ring and if they're different, we skip
io wait and perform read.

This also adds ring buffers support to tcp and udp
server code.

Signed-off-by: Lev Stipakov <lev@...515...>
---

 v7:
  - fix comments (no code changes)

 v6:
  - added a sanity check to write_wintun() to avoid 
    writing malformed IPv4/6 packet, which causes
    "ring buffer is out of capacity" error.

 v5:
  - fix crash at ring buffer registration on Win7
    (passing NULL to DeviceIOControl, reported by kitsune1)

 v4:
  - added helper function tuntap_ring_empty()
  - refactored event handling, got rid of separate
    event_ctl() call for wintun and send/receive_tail_moved
    members
  - added wintun_ prefix for ring buffer variables
  - added a comment explaining the size of wintun-specific buffers

 v3:
  - simplified convoluted #ifdefs
  - replaced "greater than" with "greater or equal than"

 v2:
  - rebased on top of master
 

 src/openvpn/forward.c |  29 +++++++-
 src/openvpn/forward.h |  38 +++++++++-
 src/openvpn/mtcp.c    |  19 ++++-
 src/openvpn/mudp.c    |   7 +-
 src/openvpn/options.c |   4 +-
 src/openvpn/syshead.h |   1 +
 src/openvpn/tun.c     |  62 +++++++++++++++-
 src/openvpn/tun.h     | 169 +++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/win32.c   | 122 ++++++++++++++++++++++++++++++
 src/openvpn/win32.h   |  51 +++++++++++++
 10 files changed, 491 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8451706b..6b823613 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1256,8 +1256,24 @@ read_incoming_tun(struct context *c)
     perf_push(PERF_READ_IN_TUN);
 
     c->c2.buf = c->c2.buffers->read_tun_buf;
+
 #ifdef _WIN32
-    read_tun_buffered(c->c1.tuntap, &c->c2.buf);
+    if (c->c1.tuntap->wintun)
+    {
+        read_wintun(c->c1.tuntap, &c->c2.buf);
+        if (c->c2.buf.len == -1)
+        {
+            register_signal(c, SIGHUP, "tun-abort");
+            c->persist.restart_sleep_seconds = 1;
+            msg(M_INFO, "Wintun read error, restarting");
+            perf_pop();
+            return;
+        }
+    }
+    else
+    {
+        read_tun_buffered(c->c1.tuntap, &c->c2.buf);
+    }
 #else
     ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
     ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame)));
@@ -2099,6 +2115,17 @@ io_wait_dowork(struct context *c, const unsigned int flags)
         tuntap |= EVENT_READ;
     }
 
+#ifdef _WIN32
+    if (tuntap_is_wintun(c->c1.tuntap))
+    {
+        /*
+         * With wintun we are only interested in read event. Ring buffer is
+         * always ready for write, so we don't do wait.
+         */
+        tuntap = EVENT_READ;
+    }
+#endif
+
     /*
      * Configure event wait based on socket, tuntap flags.
      */
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 48202c07..b711ff00 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -375,6 +375,12 @@ p2p_iow_flags(const struct context *c)
     {
         flags |= IOW_TO_TUN;
     }
+#ifdef _WIN32
+    if (tuntap_ring_empty(c->c1.tuntap))
+    {
+        flags &= ~IOW_READ_TUN;
+    }
+#endif
     return flags;
 }
 
@@ -403,8 +409,36 @@ io_wait(struct context *c, const unsigned int flags)
     }
     else
     {
-        /* slow path */
-        io_wait_dowork(c, flags);
+#ifdef _WIN32
+        bool skip_iowait = flags & IOW_TO_TUN;
+        if (flags & IOW_READ_TUN)
+        {
+            /*
+             * don't read from tun if we have pending write to link,
+             * since every tun read overwrites to_link buffer filled
+             * by previous tun read
+             */
+            skip_iowait = !(flags & IOW_TO_LINK);
+        }
+        if (tuntap_is_wintun(c->c1.tuntap) && skip_iowait)
+        {
+            unsigned int ret = 0;
+            if (flags & IOW_TO_TUN)
+            {
+                ret |= TUN_WRITE;
+            }
+            if (flags & IOW_READ_TUN)
+            {
+                ret |= TUN_READ;
+            }
+            c->c2.event_set_status = ret;
+        }
+        else
+#endif
+        {
+            /* slow path */
+            io_wait_dowork(c, flags);
+        }
     }
 }
 
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index abe20593..ee28a710 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -269,8 +269,25 @@ multi_tcp_wait(const struct context *c,
                struct multi_tcp *mtcp)
 {
     int status;
+    unsigned int *persistent = &mtcp->tun_rwflags;
     socket_set_listen_persistent(c->c2.link_socket, mtcp->es, MTCP_SOCKET);
-    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwflags);
+
+#ifdef _WIN32
+    if (tuntap_is_wintun(c->c1.tuntap))
+    {
+        if (!tuntap_ring_empty(c->c1.tuntap))
+        {
+            /* there is data in wintun ring buffer, read it immediately */
+            mtcp->esr[0].arg = MTCP_TUN;
+            mtcp->esr[0].rwflags = EVENT_READ;
+            mtcp->n_esr = 1;
+            return 1;
+        }
+        persistent = NULL;
+    }
+#endif
+    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
+
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b7f061a2..6a29ccc8 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -278,7 +278,12 @@ p2mp_iow_flags(const struct multi_context *m)
     {
         flags |= IOW_READ;
     }
-
+#ifdef _WIN32
+    if (tuntap_ring_empty(m->top.c1.tuntap))
+    {
+        flags &= ~IOW_READ_TUN;
+    }
+#endif
     return flags;
 }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 49affc29..cebcbb07 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3016,10 +3016,10 @@ options_postprocess_mutate_invariant(struct options *options)
         options->ifconfig_noexec = false;
     }
 
-    /* for wintun kernel doesn't send DHCP requests, so use ipapi to set IP address and netmask */
+    /* for wintun kernel doesn't send DHCP requests, so use netsh to set IP address and netmask */
     if (options->wintun)
     {
-        options->tuntap_options.ip_win32_type = IPW32_SET_IPAPI;
+        options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
     }
 
     remap_redirect_gateway_flags(options);
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 899aa59e..e9accb52 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -39,6 +39,7 @@
 #ifdef _WIN32
 #include <windows.h>
 #include <winsock2.h>
+#include <tlhelp32.h>
 #define sleep(x) Sleep((x)*1000)
 #define random rand
 #define srandom srand
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 599fd817..3f66b216 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -775,9 +775,27 @@ init_tun_post(struct tuntap *tt,
 #ifdef _WIN32
     overlapped_io_init(&tt->reads, frame, FALSE, true);
     overlapped_io_init(&tt->writes, frame, TRUE, true);
-    tt->rw_handle.read = tt->reads.overlapped.hEvent;
-    tt->rw_handle.write = tt->writes.overlapped.hEvent;
     tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
+
+    if (tt->wintun)
+    {
+        tt->wintun_send_ring = malloc(sizeof(struct tun_ring));
+        tt->wintun_receive_ring = malloc(sizeof(struct tun_ring));
+        if ((tt->wintun_send_ring == NULL) || (tt->wintun_receive_ring == NULL))
+        {
+            msg(M_FATAL, "Cannot allocate memory for ring buffer");
+        }
+        ZeroMemory(tt->wintun_send_ring, sizeof(struct tun_ring));
+        ZeroMemory(tt->wintun_receive_ring, sizeof(struct tun_ring));
+
+        tt->rw_handle.read = CreateEvent(NULL, FALSE, FALSE, NULL);
+        tt->rw_handle.write = CreateEvent(NULL, FALSE, FALSE, NULL);
+    }
+    else
+    {
+        tt->rw_handle.read = tt->reads.overlapped.hEvent;
+        tt->rw_handle.write = tt->writes.overlapped.hEvent;
+    }
 #endif
 }
 
@@ -6177,6 +6195,34 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             tt->ipapi_context_defined = true;
         }
     }
+
+    if (tt->wintun)
+    {
+        if (tt->options.msg_channel)
+        {
+            /* TODO */
+        }
+        else
+        {
+            if (!impersonate_as_system())
+            {
+                msg(M_FATAL, "ERROR:  Failed to impersonate as SYSTEM, make sure process is running under privileged account");
+            }
+            if (!register_ring_buffers(tt->hand,
+                                       tt->wintun_send_ring,
+                                       tt->wintun_receive_ring,
+                                       tt->rw_handle.read,
+                                       tt->rw_handle.write))
+            {
+                msg(M_FATAL, "ERROR:  Failed to register ring buffers: %lu", GetLastError());
+            }
+            if (!RevertToSelf())
+            {
+                msg(M_FATAL, "ERROR:  RevertToSelf error: %lu", GetLastError());
+            }
+        }
+    }
+
     /*netcmd_semaphore_release ();*/
     gc_free(&gc);
 }
@@ -6315,6 +6361,18 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         free(tt->actual_name);
     }
 
+    if (tt->wintun)
+    {
+        CloseHandle(tt->rw_handle.read);
+        CloseHandle(tt->rw_handle.write);
+    }
+
+    free(tt->wintun_receive_ring);
+    free(tt->wintun_send_ring);
+
+    tt->wintun_receive_ring = NULL;
+    tt->wintun_send_ring = NULL;
+
     clear_tuntap(tt);
     free(tt);
     gc_free(&gc);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 66b75d93..10f687c5 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -182,6 +182,9 @@ struct tuntap
 
     bool wintun; /* true if wintun is used instead of tap-windows6 */
     int standby_iter;
+
+    struct tun_ring *wintun_send_ring;
+    struct tun_ring *wintun_receive_ring;
 #else  /* ifdef _WIN32 */
     int fd; /* file descriptor for TUN/TAP dev */
 #endif
@@ -211,6 +214,20 @@ tuntap_defined(const struct tuntap *tt)
 #endif
 }
 
+#ifdef _WIN32
+inline bool
+tuntap_is_wintun(struct tuntap *tt)
+{
+    return tt && tt->wintun;
+}
+
+inline bool
+tuntap_ring_empty(struct tuntap *tt)
+{
+    return tuntap_is_wintun(tt) && (tt->wintun_send_ring->head == tt->wintun_send_ring->tail);
+}
+#endif
+
 /*
  * Function prototypes
  */
@@ -478,10 +495,158 @@ read_tun_buffered(struct tuntap *tt, struct buffer *buf)
     return tun_finalize(tt->hand, &tt->reads, buf);
 }
 
+static inline ULONG
+wintun_ring_packet_align(ULONG size)
+{
+    return (size + (WINTUN_PACKET_ALIGN - 1)) & ~(WINTUN_PACKET_ALIGN - 1);
+}
+
+static inline ULONG
+wintun_ring_wrap(ULONG value)
+{
+    return value & (WINTUN_RING_CAPACITY - 1);
+}
+
+static inline void
+read_wintun(struct tuntap *tt, struct buffer* buf)
+{
+    struct tun_ring *ring = tt->wintun_send_ring;
+    ULONG head = ring->head;
+    ULONG tail = ring->tail;
+    ULONG content_len;
+    struct TUN_PACKET *packet;
+    ULONG aligned_packet_size;
+
+    *buf = tt->reads.buf_init;
+    buf->len = 0;
+
+    if ((head >= WINTUN_RING_CAPACITY) || (tail >= WINTUN_RING_CAPACITY))
+    {
+        msg(M_INFO, "Wintun: ring capacity exceeded");
+        buf->len = -1;
+        return;
+    }
+
+    if (head == tail)
+    {
+        /* nothing to read */
+        return;
+    }
+
+    content_len = wintun_ring_wrap(tail - head);
+    if (content_len < sizeof(struct TUN_PACKET_HEADER))
+    {
+        msg(M_INFO, "Wintun: incomplete packet header in send ring");
+        buf->len = -1;
+        return;
+    }
+
+    packet = (struct TUN_PACKET *) &ring->data[head];
+    if (packet->size > WINTUN_MAX_PACKET_SIZE)
+    {
+        msg(M_INFO, "Wintun: packet too big in send ring");
+        buf->len = -1;
+        return;
+    }
+
+    aligned_packet_size = wintun_ring_packet_align(sizeof(struct TUN_PACKET_HEADER) + packet->size);
+    if (aligned_packet_size > content_len)
+    {
+        msg(M_INFO, "Wintun: incomplete packet in send ring");
+        buf->len = -1;
+        return;
+    }
+
+    buf_write(buf, packet->data, packet->size);
+
+    head = wintun_ring_wrap(head + aligned_packet_size);
+    ring->head = head;
+}
+
+static inline bool
+is_ip_packet_valid(const struct buffer *buf)
+{
+    const struct openvpn_iphdr* ih = (const struct openvpn_iphdr *)BPTR(buf);
+
+    if (OPENVPN_IPH_GET_VER(ih->version_len) == 4)
+    {
+        if (BLEN(buf) < sizeof(struct openvpn_iphdr))
+        {
+            return false;
+        }
+    }
+    else if (OPENVPN_IPH_GET_VER(ih->version_len) == 6)
+    {
+        if (BLEN(buf) < sizeof(struct openvpn_ipv6hdr))
+        {
+            return false;
+        }
+    }
+    else
+    {
+        return false;
+    }
+
+    return true;
+}
+
+static inline int
+write_wintun(struct tuntap *tt, struct buffer *buf)
+{
+    struct tun_ring *ring = tt->wintun_receive_ring;
+    ULONG head = ring->head;
+    ULONG tail = ring->tail;
+    ULONG aligned_packet_size;
+    ULONG buf_space;
+    struct TUN_PACKET *packet;
+
+    /* wintun marks ring as corrupted (overcapacity) if it receives invalid IP packet */
+    if (!is_ip_packet_valid(buf))
+    {
+        msg(D_LOW, "write_wintun(): drop invalid IP packet");
+        return 0;
+    }
+
+    if ((head >= WINTUN_RING_CAPACITY) || (tail >= WINTUN_RING_CAPACITY))
+    {
+        msg(M_INFO, "write_wintun(): head/tail value is over capacity");
+        return -1;
+    }
+
+    aligned_packet_size = wintun_ring_packet_align(sizeof(struct TUN_PACKET_HEADER) + BLEN(buf));
+    buf_space = wintun_ring_wrap(head - tail - WINTUN_PACKET_ALIGN);
+    if (aligned_packet_size > buf_space)
+    {
+        msg(M_INFO, "write_wintun(): ring is full");
+        return 0;
+    }
+
+    /* copy packet size and data into ring */
+    packet = (struct TUN_PACKET* )&ring->data[tail];
+    packet->size = BLEN(buf);
+    memcpy(packet->data, BPTR(buf), BLEN(buf));
+
+    /* move ring tail */
+    ring->tail = wintun_ring_wrap(tail + aligned_packet_size);
+    if (ring->alertable != 0)
+    {
+        SetEvent(tt->rw_handle.write);
+    }
+
+    return BLEN(buf);
+}
+
 static inline int
 write_tun_buffered(struct tuntap *tt, struct buffer *buf)
 {
-    return tun_write_win32(tt, buf);
+    if (tt->wintun)
+    {
+        return write_wintun(tt, buf);
+    }
+    else
+    {
+        return tun_write_win32(tt, buf);
+    }
 }
 
 #else  /* ifdef _WIN32 */
@@ -544,7 +709,7 @@ tun_set(struct tuntap *tt,
             }
         }
 #ifdef _WIN32
-        if (rwflags & EVENT_READ)
+        if (!tt->wintun && (rwflags & EVENT_READ))
         {
             tun_read_queue(tt, 0);
         }
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index eb4c0307..5c168b3b 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1493,4 +1493,126 @@ send_msg_iservice(HANDLE pipe, const void *data, size_t size,
     return ret;
 }
 
+bool
+impersonate_as_system()
+{
+    HANDLE thread_token, process_snapshot, winlogon_process, winlogon_token, duplicated_token;
+    PROCESSENTRY32 entry;
+    BOOL ret;
+    DWORD pid = 0;
+    TOKEN_PRIVILEGES privileges;
+
+    CLEAR(entry);
+    CLEAR(privileges);
+
+    entry.dwSize = sizeof(PROCESSENTRY32);
+
+    privileges.PrivilegeCount = 1;
+    privileges.Privileges->Attributes = SE_PRIVILEGE_ENABLED;
+
+    if (!LookupPrivilegeValue(NULL, SE_DEBUG_NAME, &privileges.Privileges[0].Luid))
+    {
+        return false;
+    }
+
+    if (!ImpersonateSelf(SecurityImpersonation))
+    {
+        return false;
+    }
+
+    if (!OpenThreadToken(GetCurrentThread(), TOKEN_ADJUST_PRIVILEGES, FALSE, &thread_token))
+    {
+        RevertToSelf();
+        return false;
+    }
+    if (!AdjustTokenPrivileges(thread_token, FALSE, &privileges, sizeof(privileges), NULL, NULL))
+    {
+        CloseHandle(thread_token);
+        RevertToSelf();
+        return false;
+    }
+    CloseHandle(thread_token);
+
+    process_snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
+    if (process_snapshot == INVALID_HANDLE_VALUE)
+    {
+        RevertToSelf();
+        return false;
+    }
+    for (ret = Process32First(process_snapshot, &entry); ret; ret = Process32Next(process_snapshot, &entry))
+    {
+        if (!_stricmp(entry.szExeFile, "winlogon.exe"))
+        {
+            pid = entry.th32ProcessID;
+            break;
+        }
+    }
+    CloseHandle(process_snapshot);
+    if (!pid)
+    {
+        RevertToSelf();
+        return false;
+    }
+
+    winlogon_process = OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, pid);
+    if (!winlogon_process)
+    {
+        RevertToSelf();
+        return false;
+    }
+
+    if (!OpenProcessToken(winlogon_process, TOKEN_IMPERSONATE | TOKEN_DUPLICATE, &winlogon_token))
+    {
+        CloseHandle(winlogon_process);
+        RevertToSelf();
+        return false;
+    }
+    CloseHandle(winlogon_process);
+
+    if (!DuplicateToken(winlogon_token, SecurityImpersonation, &duplicated_token))
+    {
+        CloseHandle(winlogon_token);
+        RevertToSelf();
+        return false;
+    }
+    CloseHandle(winlogon_token);
+
+    if (!SetThreadToken(NULL, duplicated_token))
+    {
+        CloseHandle(duplicated_token);
+        RevertToSelf();
+        return false;
+    }
+    CloseHandle(duplicated_token);
+
+    return true;
+}
+
+bool
+register_ring_buffers(HANDLE device,
+                      struct tun_ring* send_ring,
+                      struct tun_ring* receive_ring,
+                      HANDLE send_tail_moved,
+                      HANDLE receive_tail_moved)
+{
+    struct tun_register_rings rr;
+    BOOL res;
+    DWORD bytes_returned;
+
+    ZeroMemory(&rr, sizeof(rr));
+
+    rr.send.ring = send_ring;
+    rr.send.ring_size = sizeof(send_ring->data);
+    rr.send.tail_moved = send_tail_moved;
+
+    rr.receive.ring = receive_ring;
+    rr.receive.ring_size = sizeof(receive_ring->data);
+    rr.receive.tail_moved = receive_tail_moved;
+
+    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr),
+                          NULL, 0, &bytes_returned, NULL);
+
+    return res == TRUE;
+}
+
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 4814bbc5..f6d45bdc 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -25,6 +25,8 @@
 #ifndef OPENVPN_WIN32_H
 #define OPENVPN_WIN32_H
 
+#include <winioctl.h>
+
 #include "mtu.h"
 #include "openvpn-msg.h"
 #include "argv.h"
@@ -323,5 +325,54 @@ bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
 int
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags);
 
+/*
+ * Values below are taken from Wireguard Windows client
+ * https://github.com/WireGuard/wireguard-go/blob/master/tun/wintun/ring_windows.go#L14
+ */
+#define WINTUN_RING_CAPACITY 0x800000
+#define WINTUN_RING_TRAILING_BYTES 0x10000
+#define WINTUN_RING_FRAMING_SIZE 12
+#define WINTUN_MAX_PACKET_SIZE 0xffff
+#define WINTUN_PACKET_ALIGN 4
+
+struct tun_ring
+{
+    volatile ULONG head;
+    volatile ULONG tail;
+    volatile LONG alertable;
+    UCHAR data[WINTUN_RING_CAPACITY + WINTUN_RING_TRAILING_BYTES + WINTUN_RING_FRAMING_SIZE];
+};
+
+struct tun_register_rings
+{
+    struct
+    {
+        ULONG ring_size;
+        struct tun_ring *ring;
+        HANDLE tail_moved;
+    } send, receive;
+};
+
+struct TUN_PACKET_HEADER
+{
+    uint32_t size;
+};
+
+struct TUN_PACKET
+{
+    uint32_t size;
+    UCHAR data[WINTUN_MAX_PACKET_SIZE];
+};
+
+#define TUN_IOCTL_REGISTER_RINGS CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
+
+bool impersonate_as_system();
+
+bool register_ring_buffers(HANDLE device,
+                           struct tun_ring *send_ring,
+                           struct tun_ring *receive_ring,
+                           HANDLE send_tail_moved,
+                           HANDLE receive_tail_moved);
+
 #endif /* ifndef OPENVPN_WIN32_H */
 #endif /* ifdef _WIN32 */
-- 
2.17.1


