From: Antonio Quartulli <a@...2181...>
Date: Sun, 30 Dec 2018 21:29:01 +1000
Message-Id: <20181230112901.29241-5-a@...2181...>
In-Reply-To: <20181230112901.29241-1-a@...2181...>
References: <20181230112901.29241-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] transport-plugin: add sample obfs-test
 plugin
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
Cc: antonio@...515..., Robin Tarsiger <rtt@...2484...>

From: Robin Tarsiger <rtt@...2484...>

Add a sample plugin to explain how the new transport API is expected to
be implemented and work. It can be used for testing.

Signed-off-by: Robin Tarsiger <rtt@...2484...>
[antonio@...515...: refactored commits, restyled code]
---
 configure.ac                              |   9 +
 src/plugins/Makefile.am                   |   2 +-
 src/plugins/obfs-test/Makefile.am         |  29 ++
 src/plugins/obfs-test/README.obfs-test    |  26 +
 src/plugins/obfs-test/obfs-test-args.c    |  60 +++
 src/plugins/obfs-test/obfs-test-munging.c | 129 +++++
 src/plugins/obfs-test/obfs-test-posix.c   | 207 ++++++++
 src/plugins/obfs-test/obfs-test-win32.c   | 579 ++++++++++++++++++++++
 src/plugins/obfs-test/obfs-test.c         |  94 ++++
 src/plugins/obfs-test/obfs-test.exports   |   4 +
 src/plugins/obfs-test/obfs-test.h         |  42 ++
 11 files changed, 1180 insertions(+), 1 deletion(-)
 create mode 100644 src/plugins/obfs-test/Makefile.am
 create mode 100644 src/plugins/obfs-test/README.obfs-test
 create mode 100644 src/plugins/obfs-test/obfs-test-args.c
 create mode 100644 src/plugins/obfs-test/obfs-test-munging.c
 create mode 100644 src/plugins/obfs-test/obfs-test-posix.c
 create mode 100644 src/plugins/obfs-test/obfs-test-win32.c
 create mode 100644 src/plugins/obfs-test/obfs-test.c
 create mode 100644 src/plugins/obfs-test/obfs-test.exports
 create mode 100644 src/plugins/obfs-test/obfs-test.h

diff --git a/configure.ac b/configure.ac
index 1e6891b1..b4196812 100644
--- a/configure.ac
+++ b/configure.ac
@@ -200,6 +200,13 @@ AC_ARG_ENABLE(
 	]
 )
 
+AC_ARG_ENABLE(
+	[plugin-obfs-test],
+	[AS_HELP_STRING([--disable-plugin-obfs-test], [disable obfs-test plugin @<:@default=platform specific@:>@])],
+	,
+	[enable_plugin_obfs_test="no"]
+)
+
 AC_ARG_ENABLE(
 	[pam-dlopen],
 	[AS_HELP_STRING([--enable-pam-dlopen], [dlopen libpam @<:@default=no@:>@])],
@@ -1344,6 +1351,7 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "yes"])
+AM_CONDITIONAL([ENABLE_PLUGIN_OBFS_TEST], [test "${enable_plugin_obfs_test}" = "yes"])
 AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" = "yes"])
 
 sampledir="\$(docdir)/sample"
@@ -1403,6 +1411,7 @@ AC_CONFIG_FILES([
 	src/plugins/Makefile
 	src/plugins/auth-pam/Makefile
 	src/plugins/down-root/Makefile
+	src/plugins/obfs-test/Makefile
 	tests/Makefile
         tests/unit_tests/Makefile
         tests/unit_tests/example_test/Makefile
diff --git a/src/plugins/Makefile.am b/src/plugins/Makefile.am
index f3461786..848bac03 100644
--- a/src/plugins/Makefile.am
+++ b/src/plugins/Makefile.am
@@ -12,4 +12,4 @@
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
-SUBDIRS = auth-pam down-root
+SUBDIRS = auth-pam down-root obfs-test
diff --git a/src/plugins/obfs-test/Makefile.am b/src/plugins/obfs-test/Makefile.am
new file mode 100644
index 00000000..4cc8d183
--- /dev/null
+++ b/src/plugins/obfs-test/Makefile.am
@@ -0,0 +1,29 @@
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+AM_CFLAGS = \
+	-I$(top_srcdir)/include \
+	$(OPTIONAL_CRYPTO_CFLAGS)
+
+if ENABLE_PLUGIN_OBFS_TEST
+plugin_LTLIBRARIES = openvpn-plugin-obfs-test.la
+endif
+
+openvpn_plugin_obfs_test_la_SOURCES = \
+	obfs-test.c \
+	obfs-test-munging.c \
+	obfs-test-args.c \
+	obfs-test.exports
+
+if WIN32
+openvpn_plugin_obfs_test_la_SOURCES += obfs-test-win32.c
+openvpn_plugin_obfs_test_la_LIBADD = -lws2_32 -lwininet
+else !WIN32
+openvpn_plugin_obfs_test_la_SOURCES += obfs-test-posix.c
+# No LIBADD necessary; we assume we can access the global symbol space,
+# and core OpenVPN will already link with everything needed for sockets.
+endif
+
+openvpn_plugin_obfs_test_la_LDFLAGS = $(AM_LDFLAGS) \
+	-export-symbols "$(srcdir)/obfs-test.exports" \
+	-module -shared -avoid-version -no-undefined
diff --git a/src/plugins/obfs-test/README.obfs-test b/src/plugins/obfs-test/README.obfs-test
new file mode 100644
index 00000000..5492ee02
--- /dev/null
+++ b/src/plugins/obfs-test/README.obfs-test
@@ -0,0 +1,26 @@
+obfs-test
+
+SYNOPSIS
+
+The obfs-test plugin is a proof of concept for supporting protocol
+obfuscation for OpenVPN via a socket intercept plugin.
+
+BUILD
+
+You must specify --enable-plugin-obfs-test at configure time to
+trigger building this plugin. It should function on POSIX-y platforms
+and Windows.
+
+USAGE
+
+To invoke this plugin, load it via an appropriate plugin line in the
+configuration file, and then specify 'proto indirect' rather than any
+other protocol. Packets will then be passed via UDP, but they will
+also undergo a very basic content transformation, and the bind port
+will be altered (see obfs-test-munging.c for details).
+
+CAVEATS
+
+This has undergone basic functionality testing, but not any kind of
+full-on stress test. Extended socket or I/O handling options are not
+supported at all.
diff --git a/src/plugins/obfs-test/obfs-test-args.c b/src/plugins/obfs-test/obfs-test-args.c
new file mode 100644
index 00000000..e6756f8f
--- /dev/null
+++ b/src/plugins/obfs-test/obfs-test-args.c
@@ -0,0 +1,60 @@
+#include "obfs-test.h"
+
+openvpn_transport_args_t
+obfs_test_parseargs(void *plugin_handle,
+                    const char *const *argv, int argc)
+{
+    struct obfs_test_args *args = calloc(1, sizeof(struct obfs_test_args));
+    if (!args)
+    {
+        return NULL;
+    }
+
+    if (argc < 2)
+    {
+        args->offset = 0;
+    }
+    else if (argc == 2)
+    {
+        char *end;
+        long offset = strtol(argv[1], &end, 10);
+        if (*end != '\0')
+        {
+            args->error = "offset must be a decimal number";
+        }
+        else if (!(0 <= offset && offset <= 42))
+        {
+            args->error = "offset must be between 0 and 42";
+        }
+        else
+        {
+            args->offset = (int) offset;
+        }
+    }
+    else
+    {
+        args->error = "too many arguments";
+    }
+
+    return args;
+}
+
+const char *
+obfs_test_argerror(openvpn_transport_args_t args_)
+{
+    if (!args_)
+    {
+        return "cannot allocate";
+    }
+    else
+    {
+        return ((struct obfs_test_args *) args_)->error;
+    }
+}
+
+void
+obfs_test_freeargs(openvpn_transport_args_t args_)
+{
+    free(args_);
+    struct obfs_test_args *args = (struct obfs_test_args *) args_;
+}
diff --git a/src/plugins/obfs-test/obfs-test-munging.c b/src/plugins/obfs-test/obfs-test-munging.c
new file mode 100644
index 00000000..37d27039
--- /dev/null
+++ b/src/plugins/obfs-test/obfs-test-munging.c
@@ -0,0 +1,129 @@
+#include <string.h>
+#include <errno.h>
+#include <stdbool.h>
+#include "obfs-test.h"
+#ifdef OPENVPN_TRANSPORT_PLATFORM_POSIX
+#include <sys/socket.h>
+#include <netinet/in.h>
+typedef in_port_t obfs_test_in_port_t;
+#else
+#include <winsock2.h>
+#include <ws2tcpip.h>
+typedef u_short obfs_test_in_port_t;
+#endif
+
+static obfs_test_in_port_t
+munge_port(obfs_test_in_port_t port)
+{
+    return port ^ 15;
+}
+
+/* Reversible. */
+void
+obfs_test_munge_addr(struct sockaddr *addr, openvpn_transport_socklen_t len)
+{
+    struct sockaddr_in *inet;
+    struct sockaddr_in6 *inet6;
+
+    switch (addr->sa_family)
+    {
+        case AF_INET:
+            inet = (struct sockaddr_in *) addr;
+            inet->sin_port = munge_port(inet->sin_port);
+            break;
+
+        case AF_INET6:
+            inet6 = (struct sockaddr_in6 *) addr;
+            inet6->sin6_port = munge_port(inet6->sin6_port);
+            break;
+
+        default:
+            break;
+    }
+}
+
+/* Six fixed bytes, six repeated bytes. It's only a silly transformation. */
+#define MUNGE_OVERHEAD 12
+
+size_t
+obfs_test_max_munged_buf_size(size_t clear_size)
+{
+    return clear_size + MUNGE_OVERHEAD;
+}
+
+ssize_t
+obfs_test_unmunge_buf(struct obfs_test_args *how,
+                      char *buf, size_t len)
+{
+    int i;
+
+    if (len < 6)
+    {
+        goto bad;
+    }
+    for (i = 0; i < 6; i++)
+    {
+        if (buf[i] != i + how->offset)
+        {
+            goto bad;
+        }
+    }
+
+    for (i = 0; i < 6 && (6 + 2*i) < len; i++)
+    {
+        if (len < (6 + 2*i + 1) || buf[6 + 2*i] != buf[6 + 2*i + 1])
+        {
+            goto bad;
+        }
+        buf[i] = buf[6 + 2*i];
+    }
+
+    if (len > 18)
+    {
+        memmove(buf + 6, buf + 18, len - 18);
+        len -= 12;
+    }
+    else
+    {
+        len -= 6;
+        len /= 2;
+    }
+
+    return len;
+
+bad:
+    /* TODO: this really isn't the best way to report this error */
+    errno = EIO;
+    return -1;
+}
+
+/* out must have space for len+MUNGE_OVERHEAD bytes. out and in must
+ * not overlap. */
+size_t
+obfs_test_munge_buf(struct obfs_test_args *how,
+                    char *out, const char *in, size_t len)
+{
+    int i, n;
+    size_t out_len = 6;
+
+    for (i = 0; i < 6; i++)
+    {
+        out[i] = i + how->offset;
+    }
+    n = len < 6 ? len : 6;
+    for (i = 0; i < n; i++)
+    {
+        out[6 + 2*i] = out[6 + 2*i + 1] = in[i];
+    }
+    if (len > 6)
+    {
+        memmove(out + 18, in + 6, len - 6);
+        out_len = len + 12;
+    }
+    else
+    {
+        out_len = 6 + 2*len;
+    }
+
+    return out_len;
+}
diff --git a/src/plugins/obfs-test/obfs-test-posix.c b/src/plugins/obfs-test/obfs-test-posix.c
new file mode 100644
index 00000000..826381c5
--- /dev/null
+++ b/src/plugins/obfs-test/obfs-test-posix.c
@@ -0,0 +1,207 @@
+#include "obfs-test.h"
+#include <stdbool.h>
+#include <string.h>
+#include <err.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+struct obfs_test_socket_posix
+{
+    struct openvpn_transport_socket handle;
+    struct obfs_test_args args;
+    struct obfs_test_context *ctx;
+    int fd;
+    unsigned last_rwflags;
+};
+
+static void
+free_socket(struct obfs_test_socket_posix *sock)
+{
+    if (!sock)
+    {
+        return;
+    }
+    if (sock->fd != -1)
+    {
+        close(sock->fd);
+    }
+    free(sock);
+}
+
+static openvpn_transport_socket_t
+obfs_test_posix_bind(void *plugin_handle, openvpn_transport_args_t args,
+                     const struct sockaddr *addr, socklen_t len)
+{
+    struct obfs_test_socket_posix *sock = NULL;
+    struct sockaddr *addr_rev = NULL;
+
+    addr_rev = calloc(1, len);
+    if (!addr_rev)
+    {
+        goto error;
+    }
+    memcpy(addr_rev, addr, len);
+    obfs_test_munge_addr(addr_rev, len);
+
+    sock = calloc(1, sizeof(struct obfs_test_socket_posix));
+    if (!sock)
+    {
+        goto error;
+    }
+    sock->handle.vtab = &obfs_test_socket_vtab;
+    sock->ctx = (struct obfs_test_context *) plugin_handle;
+    memcpy(&sock->args, args, sizeof(sock->args));
+    /* Note that sock->fd isn't -1 yet. Set it explicitly if there are ever any
+     * error exits before the socket() call. */
+
+    sock->fd = socket(addr->sa_family, SOCK_DGRAM, IPPROTO_UDP);
+    if (sock->fd == -1)
+    {
+        goto error;
+    }
+    if (fcntl(sock->fd, F_SETFL, fcntl(sock->fd, F_GETFL) | O_NONBLOCK))
+    {
+        goto error;
+    }
+
+    if (bind(sock->fd, addr_rev, len))
+    {
+        goto error;
+    }
+    free(addr_rev);
+    return &sock->handle;
+
+error:
+    free_socket(sock);
+    free(addr_rev);
+    return NULL;
+}
+
+static void
+obfs_test_posix_request_event(openvpn_transport_socket_t handle,
+                              openvpn_transport_event_set_handle_t event_set, unsigned rwflags)
+{
+    obfs_test_log(((struct obfs_test_socket_posix *) handle)->ctx,
+                  PLOG_DEBUG, "request-event: %d", rwflags);
+    ((struct obfs_test_socket_posix *) handle)->last_rwflags = 0;
+    if (rwflags)
+    {
+        event_set->vtab->set_event(event_set, ((struct obfs_test_socket_posix *) handle)->fd,
+                                   rwflags, handle);
+    }
+}
+
+static bool
+obfs_test_posix_update_event(openvpn_transport_socket_t handle, void *arg, unsigned rwflags)
+{
+    obfs_test_log(((struct obfs_test_socket_posix *) handle)->ctx,
+                  PLOG_DEBUG, "update-event: %p, %p, %d", handle, arg, rwflags);
+    if (arg != handle)
+    {
+        return false;
+    }
+    ((struct obfs_test_socket_posix *) handle)->last_rwflags |= rwflags;
+    return true;
+}
+
+static unsigned
+obfs_test_posix_pump(openvpn_transport_socket_t handle)
+{
+    obfs_test_log(((struct obfs_test_socket_posix *) handle)->ctx,
+                  PLOG_DEBUG, "pump -> %d", ((struct obfs_test_socket_posix *) handle)->last_rwflags);
+    return ((struct obfs_test_socket_posix *) handle)->last_rwflags;
+}
+
+static ssize_t
+obfs_test_posix_recvfrom(openvpn_transport_socket_t handle, void *buf, size_t len,
+                         struct sockaddr *addr, socklen_t *addrlen)
+{
+    int fd = ((struct obfs_test_socket_posix *) handle)->fd;
+    ssize_t result;
+
+again:
+    result = recvfrom(fd, buf, len, 0, addr, addrlen);
+    if (result < 0 && errno == EAGAIN)
+    {
+        ((struct obfs_test_socket_posix *) handle)->last_rwflags &= ~OPENVPN_TRANSPORT_EVENT_READ;
+    }
+    if (*addrlen > 0)
+    {
+        obfs_test_munge_addr(addr, *addrlen);
+    }
+    if (result > 0)
+    {
+        struct obfs_test_args *how = &((struct obfs_test_socket_posix *) handle)->args;
+        result = obfs_test_unmunge_buf(how, buf, result);
+        if (result < 0)
+        {
+            /* Pretend that read never happened. */
+            goto again;
+        }
+    }
+
+    obfs_test_log(((struct obfs_test_socket_posix *) handle)->ctx,
+                  PLOG_DEBUG, "recvfrom(%d) -> %d", (int)len, (int)result);
+    return result;
+}
+
+static ssize_t
+obfs_test_posix_sendto(openvpn_transport_socket_t handle, const void *buf, size_t len,
+                       const struct sockaddr *addr, socklen_t addrlen)
+{
+    int fd = ((struct obfs_test_socket_posix *) handle)->fd;
+    struct sockaddr *addr_rev = calloc(1, addrlen);
+    void *buf_munged = malloc(obfs_test_max_munged_buf_size(len));
+    size_t len_munged;
+    ssize_t result;
+    if (!addr_rev || !buf_munged)
+    {
+        goto error;
+    }
+
+    memcpy(addr_rev, addr, addrlen);
+    obfs_test_munge_addr(addr_rev, addrlen);
+    struct obfs_test_args *how = &((struct obfs_test_socket_posix *) handle)->args;
+    len_munged = obfs_test_munge_buf(how, buf_munged, buf, len);
+    result = sendto(fd, buf_munged, len_munged, 0, addr_rev, addrlen);
+    if (result < 0 && errno == EAGAIN)
+    {
+        ((struct obfs_test_socket_posix *) handle)->last_rwflags &= ~OPENVPN_TRANSPORT_EVENT_WRITE;
+    }
+    /* TODO: not clear what to do here for partial transfers. */
+    if (result > len)
+    {
+        result = len;
+    }
+    obfs_test_log(((struct obfs_test_socket_posix *) handle)->ctx,
+                  PLOG_DEBUG, "sendto(%d) -> %d", (int)len, (int)result);
+    free(addr_rev);
+    free(buf_munged);
+    return result;
+
+error:
+    free(addr_rev);
+    free(buf_munged);
+    return -1;
+}
+
+static void
+obfs_test_posix_close(openvpn_transport_socket_t handle)
+{
+    free_socket((struct obfs_test_socket_posix *) handle);
+}
+
+void
+obfs_test_initialize_vtabs_platform(void)
+{
+    obfs_test_bind_vtab.bind = obfs_test_posix_bind;
+    obfs_test_socket_vtab.request_event = obfs_test_posix_request_event;
+    obfs_test_socket_vtab.update_event = obfs_test_posix_update_event;
+    obfs_test_socket_vtab.pump = obfs_test_posix_pump;
+    obfs_test_socket_vtab.recvfrom = obfs_test_posix_recvfrom;
+    obfs_test_socket_vtab.sendto = obfs_test_posix_sendto;
+    obfs_test_socket_vtab.close = obfs_test_posix_close;
+}
diff --git a/src/plugins/obfs-test/obfs-test-win32.c b/src/plugins/obfs-test/obfs-test-win32.c
new file mode 100644
index 00000000..46c95f55
--- /dev/null
+++ b/src/plugins/obfs-test/obfs-test-win32.c
@@ -0,0 +1,579 @@
+#include "obfs-test.h"
+#include <stdbool.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdarg.h>
+#include <windows.h>
+#include <winsock2.h>
+#include <assert.h>
+
+static inline bool
+is_invalid_handle(HANDLE h)
+{
+    return h == NULL || h == INVALID_HANDLE_VALUE;
+}
+
+typedef enum {
+    IO_SLOT_DORMANT,            /* must be 0 for calloc purposes */
+    IO_SLOT_PENDING,
+    /* success/failure is determined by succeeded flag in COMPLETE state */
+    IO_SLOT_COMPLETE
+} io_slot_status_t;
+
+/* must be calloc'able */
+struct io_slot
+{
+    struct obfs_test_context *ctx;
+    io_slot_status_t status;
+    OVERLAPPED overlapped;
+    SOCKET socket;
+    SOCKADDR_STORAGE addr;
+    int addr_len, addr_cap;
+    DWORD bytes, flags;
+    bool succeeded;
+    int wsa_error;
+
+    /* realloc'd as needed; always private copy, never aliased */
+    char *buf;
+    size_t buf_len, buf_cap;
+};
+
+static bool
+setup_io_slot(struct io_slot *slot, struct obfs_test_context *ctx,
+              SOCKET socket, HANDLE event)
+{
+    slot->ctx = ctx;
+    slot->status = IO_SLOT_DORMANT;
+    slot->addr_cap = sizeof(SOCKADDR_STORAGE);
+    slot->socket = socket;
+    slot->overlapped.hEvent = event;
+    return true;
+}
+
+/* Note that this assumes any I/O has already been implicitly canceled (via closesocket),
+ * but not waited for yet. */
+static bool
+destroy_io_slot(struct io_slot *slot)
+{
+    if (slot->status == IO_SLOT_PENDING)
+    {
+        DWORD bytes, flags;
+        BOOL ok = WSAGetOverlappedResult(slot->socket, &slot->overlapped, &bytes,
+                                         TRUE /* wait */, &flags);
+        if (!ok && WSAGetLastError() == WSA_IO_INCOMPLETE)
+        {
+            obfs_test_log(slot->ctx, PLOG_ERR,
+                          "destroying I/O slot: canceled operation is still incomplete after wait?!");
+            return false;
+        }
+    }
+
+    slot->status = IO_SLOT_DORMANT;
+    return true;
+}
+
+/* FIXME: aborts on error. */
+static void
+resize_io_buf(struct io_slot *slot, size_t cap)
+{
+    if (slot->buf)
+    {
+        free(slot->buf);
+        slot->buf = NULL;
+    }
+
+    char *new_buf = malloc(cap);
+    if (!new_buf)
+    {
+        abort();
+    }
+    slot->buf = new_buf;
+    slot->buf_cap = cap;
+}
+
+struct obfs_test_socket_win32
+{
+    struct openvpn_transport_socket handle;
+    struct obfs_test_args args;
+    struct obfs_test_context *ctx;
+    SOCKET socket;
+
+    /* Write is ready when idle; read is not-ready when idle. Both level-triggered. */
+    struct openvpn_transport_win32_event_pair completion_events;
+    struct io_slot slot_read, slot_write;
+
+    int last_rwflags;
+};
+
+static void
+free_socket(struct obfs_test_socket_win32 *sock)
+{
+    /* This only ever becomes false in strange situations where we leak the entire structure for
+     * lack of anything else to do. */
+    bool can_free = true;
+
+    if (!sock)
+    {
+        return;
+    }
+    if (sock->socket != INVALID_SOCKET)
+    {
+        closesocket(sock->socket);
+    }
+
+    /* closesocket cancels any pending overlapped I/O, but we still have to potentially
+     * wait for it here before we can free the buffers. This has to happen before closing
+     * the event handles.
+     *
+     * If we can't figure out when the canceled overlapped I/O is done, for any reason, we defensively
+     * leak the entire structure; freeing it would be permitting the system to corrupt memory later.
+     * TODO: possibly abort() instead, but make sure we've handled all the possible "have to try again"
+     * cases above first
+     */
+    if (!destroy_io_slot(&sock->slot_read))
+    {
+        can_free = false;
+    }
+    if (!destroy_io_slot(&sock->slot_write))
+    {
+        can_free = false;
+    }
+    if (!can_free)
+    {
+        /* Skip deinitialization of everything else. Doomed. */
+        obfs_test_log(sock->ctx, PLOG_ERR, "doomed, leaking the entire socket structure");
+        return;
+    }
+
+    if (!is_invalid_handle(sock->completion_events.read))
+    {
+        CloseHandle(sock->completion_events.read);
+    }
+    if (!is_invalid_handle(sock->completion_events.write))
+    {
+        CloseHandle(sock->completion_events.write);
+    }
+
+    free(sock);
+}
+
+static openvpn_transport_socket_t
+obfs_test_win32_bind(void *plugin_handle, openvpn_transport_args_t args,
+                     const struct sockaddr *addr, openvpn_transport_socklen_t len)
+{
+    struct obfs_test_socket_win32 *sock = NULL;
+    struct sockaddr *addr_rev = NULL;
+
+    /* TODO: would be nice to factor out some of these sequences */
+    addr_rev = calloc(1, len);
+    if (!addr_rev)
+    {
+        goto error;
+    }
+    memcpy(addr_rev, addr, len);
+    obfs_test_munge_addr(addr_rev, len);
+
+    sock = calloc(1, sizeof(struct obfs_test_socket_win32));
+    if (!sock)
+    {
+        goto error;
+    }
+    sock->handle.vtab = &obfs_test_socket_vtab;
+    sock->ctx = (struct obfs_test_context *) plugin_handle;
+    memcpy(&sock->args, args, sizeof(sock->args));
+
+    /* Preemptively initialize the members of some Win32 types so error exits are okay later on.
+     * HANDLEs of NULL are considered invalid per above. */
+    sock->socket = INVALID_SOCKET;
+
+    sock->socket = socket(addr_rev->sa_family, SOCK_DGRAM, IPPROTO_UDP);
+    if (sock->socket == INVALID_SOCKET)
+    {
+        goto error;
+    }
+
+    /* See above: write is ready when idle, read is not-ready when idle. */
+    sock->completion_events.read = CreateEvent(NULL, TRUE, FALSE, NULL);
+    sock->completion_events.write = CreateEvent(NULL, TRUE, TRUE, NULL);
+    if (is_invalid_handle(sock->completion_events.read) || is_invalid_handle(sock->completion_events.write))
+    {
+        goto error;
+    }
+    if (!setup_io_slot(&sock->slot_read, sock->ctx,
+                       sock->socket, sock->completion_events.read))
+    {
+        goto error;
+    }
+    if (!setup_io_slot(&sock->slot_write, sock->ctx,
+                       sock->socket, sock->completion_events.write))
+    {
+        goto error;
+    }
+
+    if (bind(sock->socket, addr_rev, len))
+    {
+        goto error;
+    }
+    free(addr_rev);
+    return &sock->handle;
+
+error:
+    obfs_test_log((struct obfs_test_context *) plugin_handle, PLOG_ERR,
+                  "bind failure: WSA error = %d", WSAGetLastError());
+    free_socket(sock);
+    free(addr_rev);
+    return NULL;
+}
+
+static void
+handle_sendrecv_return(struct io_slot *slot, int status)
+{
+    if (status == 0)
+    {
+        /* Immediately completed. Set the event so it stays consistent. */
+        slot->status = IO_SLOT_COMPLETE;
+        slot->succeeded = true;
+        slot->buf_len = slot->bytes;
+        SetEvent(slot->overlapped.hEvent);
+    }
+    else if (WSAGetLastError() == WSA_IO_PENDING)
+    {
+        /* Queued. */
+        slot->status = IO_SLOT_PENDING;
+    }
+    else
+    {
+        /* Error. */
+        slot->status = IO_SLOT_COMPLETE;
+        slot->succeeded = false;
+        slot->wsa_error = WSAGetLastError();
+        slot->buf_len = 0;
+    }
+}
+
+static void
+queue_new_read(struct io_slot *slot, size_t cap)
+{
+    int status;
+    WSABUF sbuf;
+    assert(slot->status == IO_SLOT_DORMANT);
+
+    ResetEvent(slot->overlapped.hEvent);
+    resize_io_buf(slot, cap);
+    sbuf.buf = slot->buf;
+    sbuf.len = slot->buf_cap;
+    slot->addr_len = slot->addr_cap;
+    slot->flags = 0;
+    status = WSARecvFrom(slot->socket, &sbuf, 1, &slot->bytes, &slot->flags,
+                         (struct sockaddr *)&slot->addr, &slot->addr_len,
+                         &slot->overlapped, NULL);
+    handle_sendrecv_return(slot, status);
+}
+
+/* write slot buffer must already be full. */
+static void
+queue_new_write(struct io_slot *slot)
+{
+    int status;
+    WSABUF sbuf;
+    assert(slot->status == IO_SLOT_COMPLETE || slot->status == IO_SLOT_DORMANT);
+
+    ResetEvent(slot->overlapped.hEvent);
+    sbuf.buf = slot->buf;
+    sbuf.len = slot->buf_len;
+    slot->flags = 0;
+    status = WSASendTo(slot->socket, &sbuf, 1, &slot->bytes, 0 /* flags */,
+                       (struct sockaddr *)&slot->addr, slot->addr_len,
+                       &slot->overlapped, NULL);
+    handle_sendrecv_return(slot, status);
+}
+
+static void
+ensure_pending_read(struct obfs_test_socket_win32 *sock)
+{
+    struct io_slot *slot = &sock->slot_read;
+    switch (slot->status)
+    {
+        case IO_SLOT_PENDING:
+            return;
+
+        case IO_SLOT_COMPLETE:
+            /* Set the event manually here just in case. */
+            SetEvent(slot->overlapped.hEvent);
+            return;
+
+        case IO_SLOT_DORMANT:
+            /* TODO: we don't propagate max read size here, so we just have to assume the maximum. */
+            queue_new_read(slot, 65536);
+            return;
+
+        default:
+            abort();
+    }
+}
+
+static bool
+complete_pending_operation(struct io_slot *slot)
+{
+    DWORD bytes, flags;
+    BOOL ok;
+
+    switch (slot->status)
+    {
+        case IO_SLOT_DORMANT:
+            /* TODO: shouldn't get here? */
+            return false;
+
+        case IO_SLOT_COMPLETE:
+            return true;
+
+        case IO_SLOT_PENDING:
+            ok = WSAGetOverlappedResult(slot->socket, &slot->overlapped, &bytes,
+                                        FALSE /* don't wait */, &flags);
+            if (!ok && WSAGetLastError() == WSA_IO_INCOMPLETE)
+            {
+                /* Still waiting. */
+                return false;
+            }
+            else if (ok)
+            {
+                /* Completed. slot->addr_len has already been updated. */
+                slot->buf_len = bytes;
+                slot->status = IO_SLOT_COMPLETE;
+                slot->succeeded = true;
+                return true;
+            }
+            else
+            {
+                /* Error. */
+                slot->buf_len = 0;
+                slot->status = IO_SLOT_COMPLETE;
+                slot->succeeded = false;
+                slot->wsa_error = WSAGetLastError();
+                return true;
+            }
+
+        default:
+            abort();
+    }
+}
+
+static bool
+complete_pending_read(struct obfs_test_socket_win32 *sock)
+{
+    bool done = complete_pending_operation(&sock->slot_read);
+    if (done)
+    {
+        ResetEvent(sock->completion_events.read);
+    }
+    return done;
+}
+
+static void
+consumed_pending_read(struct obfs_test_socket_win32 *sock)
+{
+    struct io_slot *slot = &sock->slot_read;
+    assert(slot->status == IO_SLOT_COMPLETE);
+    slot->status = IO_SLOT_DORMANT;
+    slot->succeeded = false;
+    ResetEvent(slot->overlapped.hEvent);
+}
+
+static inline bool
+complete_pending_write(struct obfs_test_socket_win32 *sock)
+{
+    bool done = complete_pending_operation(&sock->slot_write);
+    if (done)
+    {
+        SetEvent(sock->completion_events.write);
+    }
+    return done;
+}
+
+static void
+obfs_test_win32_request_event(openvpn_transport_socket_t handle,
+                              openvpn_transport_event_set_handle_t event_set, unsigned rwflags)
+{
+    struct obfs_test_socket_win32 *sock = (struct obfs_test_socket_win32 *)handle;
+    obfs_test_log(sock->ctx, PLOG_DEBUG, "request-event: %d", rwflags);
+    sock->last_rwflags = 0;
+
+    if (rwflags & OPENVPN_TRANSPORT_EVENT_READ)
+    {
+        ensure_pending_read(sock);
+    }
+    if (rwflags)
+    {
+        event_set->vtab->set_event(event_set, &sock->completion_events, rwflags, handle);
+    }
+}
+
+static bool
+obfs_test_win32_update_event(openvpn_transport_socket_t handle, void *arg, unsigned rwflags)
+{
+    obfs_test_log(((struct obfs_test_socket_win32 *) handle)->ctx, PLOG_DEBUG,
+                  "update-event: %p, %p, %d", handle, arg, rwflags);
+    if (arg != handle)
+    {
+        return false;
+    }
+    ((struct obfs_test_socket_win32 *) handle)->last_rwflags |= rwflags;
+    return true;
+}
+
+static unsigned
+obfs_test_win32_pump(openvpn_transport_socket_t handle)
+{
+    struct obfs_test_socket_win32 *sock = (struct obfs_test_socket_win32 *)handle;
+    unsigned result = 0;
+
+    if ((sock->last_rwflags & OPENVPN_TRANSPORT_EVENT_READ) && complete_pending_read(sock))
+    {
+        result |= OPENVPN_TRANSPORT_EVENT_READ;
+    }
+    if ((sock->last_rwflags & OPENVPN_TRANSPORT_EVENT_WRITE)
+        && (sock->slot_write.status != IO_SLOT_PENDING || complete_pending_write(sock)))
+    {
+        result |= OPENVPN_TRANSPORT_EVENT_WRITE;
+    }
+
+    obfs_test_log(sock->ctx, PLOG_DEBUG, "pump -> %d", result);
+    return result;
+}
+
+static ssize_t
+obfs_test_win32_recvfrom(openvpn_transport_socket_t handle, void *buf, size_t len,
+                         struct sockaddr *addr, openvpn_transport_socklen_t *addrlen)
+{
+    struct obfs_test_socket_win32 *sock = (struct obfs_test_socket_win32 *)handle;
+    if (!complete_pending_read(sock))
+    {
+        WSASetLastError(WSA_IO_INCOMPLETE);
+        return -1;
+    }
+
+    if (!sock->slot_read.succeeded)
+    {
+        int wsa_error = sock->slot_read.wsa_error;
+        consumed_pending_read(sock);
+        WSASetLastError(wsa_error);
+        return -1;
+    }
+
+    /* sock->slot_read now has valid data. */
+    char *working_buf = sock->slot_read.buf;
+    ssize_t unmunged_len =
+        obfs_test_unmunge_buf(&sock->args, working_buf,
+                              sock->slot_read.buf_len);
+    if (unmunged_len < 0)
+    {
+        /* Act as though this read never happened. Assume one was queued before, so it should
+         * still remain queued. */
+        consumed_pending_read(sock);
+        ensure_pending_read(sock);
+        WSASetLastError(WSA_IO_INCOMPLETE);
+        return -1;
+    }
+
+    size_t copy_len = unmunged_len;
+    if (copy_len > len)
+    {
+        copy_len = len;
+    }
+    memcpy(buf, sock->slot_read.buf, copy_len);
+
+    /* TODO: shouldn't truncate, should signal error (but this shouldn't happen for any
+     * supported address families anyway). */
+    openvpn_transport_socklen_t addr_copy_len = *addrlen;
+    if (sock->slot_read.addr_len < addr_copy_len)
+    {
+        addr_copy_len = sock->slot_read.addr_len;
+    }
+    memcpy(addr, &sock->slot_read.addr, addr_copy_len);
+    *addrlen = addr_copy_len;
+    if (addr_copy_len > 0)
+    {
+        obfs_test_munge_addr(addr, addr_copy_len);
+    }
+
+    /* Reset the I/O slot before returning. */
+    consumed_pending_read(sock);
+    return copy_len;
+}
+
+static ssize_t
+obfs_test_win32_sendto(openvpn_transport_socket_t handle, const void *buf, size_t len,
+                       const struct sockaddr *addr, openvpn_transport_socklen_t addrlen)
+{
+    struct obfs_test_socket_win32 *sock = (struct obfs_test_socket_win32 *)handle;
+    complete_pending_write(sock);
+
+    if (sock->slot_write.status == IO_SLOT_PENDING)
+    {
+        /* This shouldn't really happen, but. */
+        WSASetLastError(WSAEWOULDBLOCK);
+        return -1;
+    }
+
+    if (addrlen > sock->slot_write.addr_cap)
+    {
+        /* Shouldn't happen. */
+        WSASetLastError(WSAEFAULT);
+        return -1;
+    }
+
+    /* TODO: propagate previous write errors---what does core expect here? */
+    memcpy(&sock->slot_write.addr, addr, addrlen);
+    sock->slot_write.addr_len = addrlen;
+    if (addrlen > 0)
+    {
+        obfs_test_munge_addr((struct sockaddr *)&sock->slot_write.addr, addrlen);
+    }
+    resize_io_buf(&sock->slot_write, obfs_test_max_munged_buf_size(len));
+    sock->slot_write.buf_len =
+        obfs_test_munge_buf(&sock->args, sock->slot_write.buf, buf, len);
+    queue_new_write(&sock->slot_write);
+    switch (sock->slot_write.status)
+    {
+        case IO_SLOT_PENDING:
+            /* The network hasn't given us an error yet, but _we've_ consumed all the bytes.
+             * ... sort of. */
+            return len;
+
+        case IO_SLOT_DORMANT:
+            /* Huh?? But we just queued a write. */
+            abort();
+
+        case IO_SLOT_COMPLETE:
+            if (sock->slot_write.succeeded)
+            {
+                /* TODO: more partial length handling */
+                return len;
+            }
+            else
+            {
+                return -1;
+            }
+
+        default:
+            abort();
+    }
+}
+
+static void
+obfs_test_win32_close(openvpn_transport_socket_t handle)
+{
+    free_socket((struct obfs_test_socket_win32 *) handle);
+}
+
+void
+obfs_test_initialize_vtabs_platform(void)
+{
+    obfs_test_bind_vtab.bind = obfs_test_win32_bind;
+    obfs_test_socket_vtab.request_event = obfs_test_win32_request_event;
+    obfs_test_socket_vtab.update_event = obfs_test_win32_update_event;
+    obfs_test_socket_vtab.pump = obfs_test_win32_pump;
+    obfs_test_socket_vtab.recvfrom = obfs_test_win32_recvfrom;
+    obfs_test_socket_vtab.sendto = obfs_test_win32_sendto;
+    obfs_test_socket_vtab.close = obfs_test_win32_close;
+}
diff --git a/src/plugins/obfs-test/obfs-test.c b/src/plugins/obfs-test/obfs-test.c
new file mode 100644
index 00000000..27a3d21e
--- /dev/null
+++ b/src/plugins/obfs-test/obfs-test.c
@@ -0,0 +1,94 @@
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include "openvpn-plugin.h"
+#include "openvpn-transport.h"
+#include "obfs-test.h"
+
+struct openvpn_transport_bind_vtab1 obfs_test_bind_vtab = { 0 };
+struct openvpn_transport_socket_vtab1 obfs_test_socket_vtab = { 0 };
+
+struct obfs_test_context
+{
+    struct openvpn_plugin_callbacks *global_vtab;
+};
+
+static void
+free_context(struct obfs_test_context *context)
+{
+    if (!context)
+    {
+        return;
+    }
+    free(context);
+}
+
+OPENVPN_EXPORT int
+openvpn_plugin_open_v3(int version, struct openvpn_plugin_args_open_in const *args,
+                       struct openvpn_plugin_args_open_return *out)
+{
+    struct obfs_test_context *context;
+
+    context = (struct obfs_test_context *) calloc(1, sizeof(struct obfs_test_context));
+    if (!context)
+    {
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    context->global_vtab = args->callbacks;
+    obfs_test_initialize_vtabs_platform();
+    obfs_test_bind_vtab.parseargs = obfs_test_parseargs;
+    obfs_test_bind_vtab.argerror = obfs_test_argerror;
+    obfs_test_bind_vtab.freeargs = obfs_test_freeargs;
+
+    out->type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TRANSPORT);
+    out->handle = (openvpn_plugin_handle_t *) context;
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+
+err:
+    free_context(context);
+    return OPENVPN_PLUGIN_FUNC_ERROR;
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
+{
+    free_context((struct obfs_test_context *) handle);
+}
+
+OPENVPN_EXPORT int
+openvpn_plugin_func_v3(int version,
+                       struct openvpn_plugin_args_func_in const *arguments,
+                       struct openvpn_plugin_args_func_return *retptr)
+{
+    /* We don't ask for any bits that use this interface. */
+    return OPENVPN_PLUGIN_FUNC_ERROR;
+}
+
+OPENVPN_EXPORT void *
+openvpn_plugin_get_vtab_v1(int selector, size_t *size_out)
+{
+    switch (selector)
+    {
+        case OPENVPN_VTAB_TRANSPORT_BIND_V1:
+            if (obfs_test_bind_vtab.bind == NULL)
+            {
+                return NULL;
+            }
+            *size_out = sizeof(struct openvpn_transport_bind_vtab1);
+            return &obfs_test_bind_vtab;
+
+        default:
+            return NULL;
+    }
+}
+
+void
+obfs_test_log(struct obfs_test_context *ctx,
+              openvpn_plugin_log_flags_t flags, const char *fmt, ...)
+{
+    va_list va;
+    va_start(va, fmt);
+    ctx->global_vtab->plugin_vlog(flags, OBFS_TEST_PLUGIN_NAME, fmt, va);
+    va_end(va);
+}
diff --git a/src/plugins/obfs-test/obfs-test.exports b/src/plugins/obfs-test/obfs-test.exports
new file mode 100644
index 00000000..e7baada4
--- /dev/null
+++ b/src/plugins/obfs-test/obfs-test.exports
@@ -0,0 +1,4 @@
+openvpn_plugin_open_v3
+openvpn_plugin_close_v1
+openvpn_plugin_get_vtab_v1
+openvpn_plugin_func_v3
diff --git a/src/plugins/obfs-test/obfs-test.h b/src/plugins/obfs-test/obfs-test.h
new file mode 100644
index 00000000..b9a6f8b4
--- /dev/null
+++ b/src/plugins/obfs-test/obfs-test.h
@@ -0,0 +1,42 @@
+#ifndef OPENVPN_PLUGIN_OBFS_TEST_H
+#define OPENVPN_PLUGIN_OBFS_TEST_H 1
+
+#include "openvpn-plugin.h"
+#include "openvpn-transport.h"
+
+#define OBFS_TEST_PLUGIN_NAME "obfs-test"
+
+struct obfs_test_context;
+
+struct obfs_test_args
+{
+    const char *error;
+    int offset;
+};
+
+extern struct openvpn_transport_bind_vtab1 obfs_test_bind_vtab;
+extern struct openvpn_transport_socket_vtab1 obfs_test_socket_vtab;
+
+void obfs_test_initialize_vtabs_platform(void);
+
+void obfs_test_munge_addr(struct sockaddr *addr, openvpn_transport_socklen_t len);
+
+size_t obfs_test_max_munged_buf_size(size_t clear_size);
+
+size_t obfs_test_munge_buf(struct obfs_test_args *how,
+                           char *out, const char *in, size_t len);
+
+ssize_t obfs_test_unmunge_buf(struct obfs_test_args *how,
+                              char *buf, size_t len);
+
+openvpn_transport_args_t obfs_test_parseargs(void *plugin_handle,
+                                             const char *const *argv, int argc);
+
+const char *obfs_test_argerror(openvpn_transport_args_t args);
+
+void obfs_test_freeargs(openvpn_transport_args_t args);
+
+void obfs_test_log(struct obfs_test_context *ctx,
+                   openvpn_plugin_log_flags_t flags, const char *fmt, ...);
+
+#endif /* !OPENVPN_PLUGIN_OBFS_TEST_H */
-- 
2.19.2


