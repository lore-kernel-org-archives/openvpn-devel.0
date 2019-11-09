From: Lev Stipakov <lstipakov@...277...>
Date: Sat,  9 Nov 2019 14:04:54 +0200
Message-Id: <1573301094-5346-1-git-send-email-lstipakov@...277...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10BDA4B8B9@...2294...>
References: <99D61A626FDA8A4B90A270669121BE10BDA4B8B9@...2294...>
Subject: [Openvpn-devel] [PATCH v3 4/7] wintun: ring buffers based I/O
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

 v3:
  - simplified convoluted #ifdefs
  - replaced "greater than" with "greater or equal than"

 v2:
  - rebased on top of master

 src/openvpn/forward.c |  32 ++++++++++++-
 src/openvpn/forward.h |  45 ++++++++++++++++++-
 src/openvpn/mtcp.c    |  26 ++++++++++-
 src/openvpn/mudp.c    |  14 ++++++
 src/openvpn/options.c |   4 +-
 src/openvpn/syshead.h |   1 +
 src/openvpn/tun.c     |  45 +++++++++++++++++++
 src/openvpn/tun.h     | 121 +++++++++++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/win32.c   | 120 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/win32.h   |  47 ++++++++++++++++++++
 10 files changed, 447 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8451706..484975b 100644
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
@@ -2103,7 +2119,19 @@ io_wait_dowork(struct context *c, const unsigned int flags)
      * Configure event wait based on socket, tuntap flags.
      */
     socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)&socket_shift, NULL);
-    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift, NULL);
+
+#ifdef _WIN32
+    if (c->c1.tuntap && c->c1.tuntap->wintun)
+    {
+        /* add ring buffer event */
+        struct rw_handle rw = {.read = c->c1.tuntap->send_tail_moved };
+        event_ctl(c->c2.event_set, &rw, EVENT_READ, (void *)&tun_shift);
+    }
+    else
+#endif
+    {
+        tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift, NULL);
+    }
 
 #ifdef ENABLE_MANAGEMENT
     if (management)
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 48202c0..b2c6152 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -375,6 +375,19 @@ p2p_iow_flags(const struct context *c)
     {
         flags |= IOW_TO_TUN;
     }
+#ifdef _WIN32
+    {
+        struct tuntap *tt = c->c1.tuntap;
+        if (tt && tt->wintun)
+        {
+            if (tt->send_ring->head == tt->send_ring->tail)
+            {
+                /* nothing to read from tun -> remove tun read flag set by IOW_READ */
+                flags &= ~IOW_READ_TUN;
+            }
+        }
+    }
+#endif
     return flags;
 }
 
@@ -403,8 +416,36 @@ io_wait(struct context *c, const unsigned int flags)
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
+        if (c->c1.tuntap && c->c1.tuntap->wintun && skip_iowait)
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
index abe2059..02e9016 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -270,7 +270,31 @@ multi_tcp_wait(const struct context *c,
 {
     int status;
     socket_set_listen_persistent(c->c2.link_socket, mtcp->es, MTCP_SOCKET);
-    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwflags);
+
+#ifdef _WIN32
+    if (c->c1.tuntap && c->c1.tuntap->wintun)
+    {
+        if (c->c1.tuntap->send_ring->head != c->c1.tuntap->send_ring->tail)
+        {
+            /* there is a data in wintun ring buffer, read it immediately */
+            mtcp->esr[0].arg = MTCP_TUN;
+            mtcp->esr[0].rwflags = EVENT_READ;
+            mtcp->n_esr = 1;
+            return 1;
+        }
+        else
+        {
+            /* add ring buffer event */
+            struct rw_handle rw = { .read = c->c1.tuntap->send_tail_moved };
+            event_ctl(mtcp->es, &rw, EVENT_READ, MTCP_TUN);
+        }
+    }
+    else
+#endif
+    {
+        tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwflags);
+    }
+
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b7f061a..7715063 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -279,6 +279,20 @@ p2mp_iow_flags(const struct multi_context *m)
         flags |= IOW_READ;
     }
 
+#ifdef _WIN32
+    {
+        struct tuntap* tt = m->top.c1.tuntap;
+        if (tt && tt->wintun)
+        {
+            if (tt->send_ring->head == tt->send_ring->tail)
+            {
+                /* nothing to read from tun -> remove tun read flag set by IOW_READ */
+                flags &= ~IOW_READ_TUN;
+            }
+        }
+    }
+#endif
+
     return flags;
 }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a70a822..0a40d2d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2996,10 +2996,10 @@ options_postprocess_mutate_invariant(struct options *options)
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
index 899aa59..e9accb5 100644
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
index 37bf065..b909b89 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -798,6 +798,18 @@ init_tun_post(struct tuntap *tt,
     tt->rw_handle.read = tt->reads.overlapped.hEvent;
     tt->rw_handle.write = tt->writes.overlapped.hEvent;
     tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
+
+    tt->send_ring = malloc(sizeof(struct tun_ring));
+    tt->receive_ring = malloc(sizeof(struct tun_ring));
+    if ((tt->send_ring == NULL) || (tt->receive_ring == NULL))
+    {
+        msg(M_FATAL, "Cannot allocate memory for receive ring");
+    }
+    ZeroMemory(tt->send_ring, sizeof(struct tun_ring));
+    ZeroMemory(tt->receive_ring, sizeof(struct tun_ring));
+
+    tt->send_tail_moved = CreateEvent(NULL, FALSE, FALSE, NULL);
+    tt->receive_tail_moved = CreateEvent(NULL, FALSE, FALSE, NULL);
 #endif
 }
 
@@ -6207,6 +6219,30 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
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
+            if (!register_ring_buffers(tt->hand, tt->send_ring, tt->receive_ring, tt->send_tail_moved, tt->receive_tail_moved))
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
@@ -6345,6 +6381,15 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         free(tt->actual_name);
     }
 
+    CloseHandle(tt->receive_tail_moved);
+    CloseHandle(tt->send_tail_moved);
+
+    free(tt->receive_ring);
+    free(tt->send_ring);
+
+    tt->receive_ring = NULL;
+    tt->send_ring = NULL;
+
     clear_tuntap(tt);
     free(tt);
     gc_free(&gc);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 19cab7e..2ca61a5 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -183,6 +183,11 @@ struct tuntap
 
     bool wintun; /* true if wintun is used instead of tap-windows6 */
     int standby_iter;
+
+    struct tun_ring *send_ring;
+    struct tun_ring *receive_ring;
+    HANDLE send_tail_moved;
+    HANDLE receive_tail_moved;
 #else  /* ifdef _WIN32 */
     int fd; /* file descriptor for TUN/TAP dev */
 #endif
@@ -479,10 +484,124 @@ read_tun_buffered(struct tuntap *tt, struct buffer *buf)
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
+    struct tun_ring *ring = tt->send_ring;
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
+static inline int
+write_wintun(struct tuntap *tt, struct buffer *buf)
+{
+    struct tun_ring *ring = tt->receive_ring;
+    ULONG head = ring->head;
+    ULONG tail = ring->tail;
+    ULONG aligned_packet_size;
+    ULONG buf_space;
+    struct TUN_PACKET *packet;
+
+    if ((head >= WINTUN_RING_CAPACITY) || (tail >= WINTUN_RING_CAPACITY))
+    {
+        msg(M_INFO, "Wintun: head/tail value is over capacity");
+        return -1;
+    }
+
+    aligned_packet_size = wintun_ring_packet_align(sizeof(struct TUN_PACKET_HEADER) + BLEN(buf));
+    buf_space = wintun_ring_wrap(head - tail - WINTUN_PACKET_ALIGN);
+    if (aligned_packet_size > buf_space)
+    {
+        msg(M_INFO, "Wintun: ring is full");
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
+        SetEvent(tt->receive_tail_moved);
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
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index eb4c030..e9e0258 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1493,4 +1493,124 @@ send_msg_iservice(HANDLE pipe, const void *data, size_t size,
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
+    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr), NULL, 0, NULL, NULL);
+
+    return res == TRUE;
+}
+
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 4814bbc..007c7d7 100644
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
@@ -323,5 +325,50 @@ bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
 int
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags);
 
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
2.7.4


