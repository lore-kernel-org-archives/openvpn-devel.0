From: Antonio Quartulli <a@...2181...>
Date: Sun, 30 Dec 2018 21:28:58 +1000
Message-Id: <20181230112901.29241-2-a@...2181...>
In-Reply-To: <20181230112901.29241-1-a@...2181...>
References: <20181230112901.29241-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] transport: introduce tranport API
 plugin codebase
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

This API will allow plugins to provide virtual socket implementations
with their own table of functions for operations on these sockets,
with limited but functional integration with the main OpenVPN event
loop.

This new mechanism can be used to implement alternative transport
protocols via external plugins, without interfering with the OpenVPN
core codebase.

A sample user of this API might be an obsufcation schema which
manipulates the traffic before sending/receiving it.

Signed-off-by: Robin Tarsiger <rtt@...2484...>
[antonio@...515...: refactored commits, restyled code]
---
 include/Makefile.am         |   1 +
 include/openvpn-plugin.h.in |  31 +++-
 include/openvpn-transport.h | 240 ++++++++++++++++++++++++++++
 src/openvpn/Makefile.am     |   1 +
 src/openvpn/plugin.c        |   4 +
 src/openvpn/plugin.h        |   1 +
 src/openvpn/socket.h        |   3 +
 src/openvpn/transport.c     | 303 ++++++++++++++++++++++++++++++++++++
 src/openvpn/transport.h     |  94 +++++++++++
 9 files changed, 677 insertions(+), 1 deletion(-)
 create mode 100644 include/openvpn-transport.h
 create mode 100644 src/openvpn/transport.c
 create mode 100644 src/openvpn/transport.h

diff --git a/include/Makefile.am b/include/Makefile.am
index 484e4e12..5c0ffcc4 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -15,4 +15,5 @@ MAINTAINERCLEANFILES = \
 
 include_HEADERS = \
 	openvpn-plugin.h \
+	openvpn-transport.h \
 	openvpn-msg.h
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 103844f7..3539e534 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -129,7 +129,8 @@ extern "C" {
 #define OPENVPN_PLUGIN_TLS_FINAL             10
 #define OPENVPN_PLUGIN_ENABLE_PF             11
 #define OPENVPN_PLUGIN_ROUTE_PREDOWN         12
-#define OPENVPN_PLUGIN_N                     13
+#define OPENVPN_PLUGIN_TRANSPORT             13
+#define OPENVPN_PLUGIN_N                     14
 
 /*
  * Build a mask out of a set of plug-in types.
@@ -852,6 +853,34 @@ OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_select_initialization_
 OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_min_version_required_v1)
     (void);
 
+/*
+ * FUNCTION: openvpn_plugin_get_vtab_v1
+ *
+ * This is only used for TRANSPORT plugins presently.  It is called to
+ * retrieve a vtable structure to be used for binding virtual sockets
+ * which use the transport provided by the plugin. The selector is an
+ * OPENVPN_VTAB constant. *size_out must be set to the size of the
+ * structure returned.
+ *
+ * REQUIRED: only for TRANSPORT plugins
+ *
+ * RETURN VALUE
+ *
+ * A pointer to a vtable of the requested type, or NULL if no
+ * such vtable is provided by this plugin.
+ */
+
+enum {
+    /* Return type: struct openvpn_transport_bind_vtab1 *
+       Plugin should provide OPENVPN_PLUGIN_TRANSPORT at open time.
+     */
+    OPENVPN_VTAB_TRANSPORT_BIND_V1 = 0x54726e31 /* 'Trn1' */
+};
+
+
+OPENVPN_PLUGIN_DEF void *OPENVPN_PLUGIN_FUNC(openvpn_plugin_get_vtab_v1)
+    (int selector, size_t *size_out);
+
 /*
  * Deprecated functions which are still supported for backward compatibility.
  */
diff --git a/include/openvpn-transport.h b/include/openvpn-transport.h
new file mode 100644
index 00000000..72872d9c
--- /dev/null
+++ b/include/openvpn-transport.h
@@ -0,0 +1,240 @@
+/*
+ *  Transport API handling code
+ *
+ *  Copyright (C) 2018 Robin Tarsiger <rtt@...2484...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#ifndef OPENVPN_TRANSPORT_H_
+#define OPENVPN_TRANSPORT_H_
+
+/* PLATFORM: only POSIX-y platforms or Win32 here */
+
+#ifdef _WIN32
+
+/* Win32 */
+#define OPENVPN_TRANSPORT_PLATFORM_WIN32
+#include <stdbool.h>
+#include <windows.h>
+#include <winsock2.h>
+
+/* On Windows, platform-native events to wait on are provided to OpenVPN core as
+ * pairs of system events, normally corresponding to one potentially queued I/O
+ * operation in each direction. The read event is waited on if read events are
+ * requested, and the write event is waited on if write events are
+ * requested. Events need not be distinct, but usually will be. Two event
+ * handles must always be provided; neither is permitted to be NULL. */
+typedef const struct openvpn_transport_win32_event_pair {
+    HANDLE read;
+    HANDLE write;
+} *openvpn_transport_native_event_t;
+
+/* Windows doesn't have socklen_t; it uses int. */
+typedef int openvpn_transport_socklen_t;
+
+#else  /* ifdef _WIN32 */
+
+/* POSIX-y */
+#define OPENVPN_TRANSPORT_PLATFORM_POSIX
+#include <stdbool.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/socket.h>
+
+/* On POSIX-y platforms, platform-native events to wait on are provided to
+ * OpenVPN core as file descriptors.  Readiness for read and write are defined
+ * the same way as in poll, epoll, and similar system APIs. The file descriptor
+ * may be of any type which can be waited on. */
+typedef int openvpn_transport_native_event_t;
+
+/* Alias natural socklen_t definition. */
+typedef socklen_t openvpn_transport_socklen_t;
+
+#endif
+
+/* rwflags values are a bitwise OR of zero or more of these values, indicating
+ * what types of events are being requested or returned for a given object. */
+#define OPENVPN_TRANSPORT_EVENT_READ  (1<<0)
+#define OPENVPN_TRANSPORT_EVENT_WRITE (1<<1)
+
+/* Handle to an object that can accumulate requests to wait on platform-native
+ * event sources. Use the functions in the vtable to operate on it. */
+typedef struct openvpn_transport_event_set_handle *openvpn_transport_event_set_handle_t;
+
+struct openvpn_transport_event_set_vtab {
+    /* Request to be notified when ev becomes ready in any of the ways specified
+     * by the bitmask rwflags. Incoming notifications will have arg passed
+     * through as-is. See above for the definition of native events on different
+     * platforms.
+     *
+     * Note that arg must be a distinct, owned pointer and not NULL; see
+     * update_event below. */
+    void (*set_event)(openvpn_transport_event_set_handle_t handle,
+                      openvpn_transport_native_event_t ev, unsigned rwflags,
+                      void *arg);
+};
+
+/* Implementation extends this structure with state. Implementation is normally
+ * provided by OpenVPN core; see request_event in struct
+ * openvpn_transport_vtab. */
+struct openvpn_transport_event_set_handle {
+    const struct openvpn_transport_event_set_vtab *vtab;
+};
+
+/* Handle to a virtual datagram socket, non-connection-oriented. */
+typedef struct openvpn_transport_socket *openvpn_transport_socket_t;
+
+/* Implementation extends this structure with state. Implementation is normally
+ * provided by a plugin providing an indirect socket mechanism. */
+struct openvpn_transport_socket {
+    const struct openvpn_transport_socket_vtab1 *vtab;
+};
+
+/* Handle to opaque per-connection parameters. */
+typedef void *openvpn_transport_args_t;
+
+/* Virtual socket implementations should expect (and consumers must
+ * provide) vtable calls in the following order:
+ *
+ *   - bind must occur first, to create the virtual socket.
+ *   - request_event is followed by zero or more update_event calls, and then a
+ *     pump call, before any further request_event calls occur.
+ *   - recvfrom/sendto may occur at any time between bind and close, including
+ *     interleaved with the event request cycle above.
+ *   - close must occur last.
+ *
+ * Error reporting is platform-native: errno on POSIX-y systems, or
+ * Winsock errors on Windows systems.
+ */
+
+struct openvpn_transport_bind_vtab1 {
+    /* Producer should set to 0, consumer should ignore. May indicate
+     * extended functions in the future. */
+    unsigned features;
+
+    /* Parse connection-specific arguments as provided by a
+     * "transport-plugin" configuration line. argv[0] is normally the
+     * plugin shared object pathname. argc is the total number of
+     * valid strings in argv; argv[argc] is also NULL. plugin_handle
+     * is an openvpn_plugin_handle_t.  Memory for argv and its strings
+     * is borrowed and may not be retained by the plugin. Any syntax
+     * checking of text arguments should be done in this function.
+     *
+     * The value returned points to either opaque, valid parameters,
+     * or an error value. The distinction between the two is defined
+     * by the plugin, and can only be evaluated via the argerror
+     * function below.
+     *
+     * This function pointer is allowed to be NULL. In this case,
+     * argerror and freeargs must also be NULL, a nonempty
+     * connection-specific argument list will be rejected with an
+     * error, and the value of args in the subsequent bind call will
+     * always be NULL.
+     */
+    openvpn_transport_args_t (*parseargs)(void *plugin_handle,
+                                          const char *const *argv,
+                                          int argc);
+
+    /* If args is an error value, as defined by this plugin, then
+     * return a string describing the error. The string must remain
+     * valid until the next call to argerror or freeargs on the same
+     * value of args. If args is not an error value, return NULL.
+     * This function pointer must be NULL if and only if parseargs is
+     * NULL. */
+    const char *(*argerror)(openvpn_transport_args_t args);
+
+    /* Destroy any resources associated with args, which may be any
+     * return value of parseargs: either parsed parameters or an error
+     * value. This function pointer must be NULL if and only if
+     * parseargs is NULL. */
+    void (*freeargs)(openvpn_transport_args_t args);
+
+    /* Bind a new virtual socket to addr/len, given a plugin handle
+     * and any connection-specific parameters. addr must not be NULL.
+     * plugin_handle is actually of type openvpn_plugin_handle_t.
+     * args is any value returned by parseargs for which argerror
+     * would return NULL; however, it is still borrowed, and the
+     * caller may call freeargs after bind while the socket is still
+     * in use. */
+    openvpn_transport_socket_t (*bind)(void *plugin_handle,
+                                       openvpn_transport_args_t args,
+                                       const struct sockaddr *addr,
+                                       openvpn_transport_socklen_t len);
+};
+
+struct openvpn_transport_socket_vtab1 {
+    /* Producer should set to 0, consumer should ignore. May indicate
+     * extended functions in the future. */
+    unsigned features;
+
+    /* Given the bitmask rwflags, request that event_set be provided with all
+     * native events that should be waited on such that whenever this virtual
+     * socket may become ready in a way specified by rwflags, one of the
+     * native events will become ready. This function should call
+     *
+     *   event_set->vtab->set_event(event_set, ...)
+     *
+     * zero or more times for this purpose.
+     *
+     * The state of event_set should be assumed not to persist between calls to
+     * request_event; every native event must be provided every time. Currently,
+     * only one native event may be supplied (i.e., one call above). */
+    void (*request_event)(openvpn_transport_socket_t handle,
+                          openvpn_transport_event_set_handle_t event_set,
+                          unsigned rwflags);
+
+    /* Indicate to the virtual socket that a native event for which arg was
+     * provided to a set_event call above became ready in a manner indicated by
+     * the bitmask rwflags.  This function _must_ test for whether arg
+     * corresponds to an actual requested event from this virtual socket.
+     *
+     * If arg corresponds to a requested event, update_event does any necessary
+     * internal state updates and _returns true_ to consume the event.
+     *
+     * If arg does not correspond to a requested event, update_event
+     * does nothing and _returns false_. */
+    bool (*update_event)(openvpn_transport_socket_t handle, void *arg,
+                         unsigned rwflags);
+
+    /* Perform any pending processing that can be performed
+     * immediately, and return a bitmask of rwflags indicating whether
+     * this virtual socket is ready to receive/send more packets. */
+    unsigned (*pump)(openvpn_transport_socket_t handle);
+
+    /* Receive a packet into buf/len, storing the address into addr/(*addrlen)
+     * and updating *addrlen to match. Returns -1 on error, or the number of
+     * bytes received. Must not block; signals an error if there is nothing to
+     * receive. */
+    ssize_t (*recvfrom)(openvpn_transport_socket_t handle,
+                        void *buf, size_t len,
+                        struct sockaddr *addr,
+                        openvpn_transport_socklen_t *addrlen);
+
+    /* Send a packet from buf/len to the address addr/addrlen. Returns -1 on
+     * error, or the number of bytes sent. Must not block; signals an error if
+     * there is no room to send. */
+    ssize_t (*sendto)(openvpn_transport_socket_t handle,
+                      const void *buf, size_t len,
+                      const struct sockaddr *addr,
+                      openvpn_transport_socklen_t addrlen);
+
+    /* Destroy this virtual socket and free all resources allocated for it. The
+     * virtual socket must not be used afterward. */
+    void (*close)(openvpn_transport_socket_t handle);
+};
+
+#endif
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 197e62ba..41cd90aa 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -119,6 +119,7 @@ openvpn_SOURCES = \
 	status.c status.h \
 	syshead.h \
 	tls_crypt.c tls_crypt.h \
+	transport.c transport.h \
 	tun.c tun.h \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index b9708342..2ab81842 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -119,6 +119,9 @@ plugin_type_name(const int type)
         case OPENVPN_PLUGIN_ROUTE_PREDOWN:
             return "PLUGIN_ROUTE_PREDOWN";
 
+        case OPENVPN_PLUGIN_TRANSPORT:
+            return "PLUGIN_TRANSPORT";
+
         default:
             return "PLUGIN_???";
     }
@@ -295,6 +298,7 @@ plugin_init_item(struct plugin *p, const struct plugin_option *o)
     PLUGIN_SYM(client_destructor, "openvpn_plugin_client_destructor_v1", 0);
     PLUGIN_SYM(min_version_required, "openvpn_plugin_min_version_required_v1", 0);
     PLUGIN_SYM(initialization_point, "openvpn_plugin_select_initialization_point_v1", 0);
+    PLUGIN_SYM(get_vtab, "openvpn_plugin_get_vtab_v1", 0);
 
     if (!p->open1 && !p->open2 && !p->open3)
     {
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 791d476b..435c4763 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -76,6 +76,7 @@ struct plugin {
     openvpn_plugin_client_destructor_v1 client_destructor;
     openvpn_plugin_min_version_required_v1 min_version_required;
     openvpn_plugin_select_initialization_point_v1 initialization_point;
+    openvpn_plugin_get_vtab_v1 get_vtab;
 
     openvpn_plugin_handle_t plugin_handle;
 };
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 17801418..f49e6315 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -572,6 +572,9 @@ enum proto_num {
     PROTO_TCP,
     PROTO_TCP_SERVER,
     PROTO_TCP_CLIENT,
+#ifdef ENABLE_PLUGIN
+    PROTO_INDIRECT,
+#endif
     PROTO_N
 };
 
diff --git a/src/openvpn/transport.c b/src/openvpn/transport.c
new file mode 100644
index 00000000..427e0062
--- /dev/null
+++ b/src/openvpn/transport.c
@@ -0,0 +1,303 @@
+/*
+ *  Transport API handling code
+ *
+ *  Copyright (C) 2018 Robin Tarsiger <rtt@...2484...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#ifdef ENABLE_PLUGIN
+
+#include "error.h"
+#include "event.h"
+#include "plugin.h"
+#include "socket.h"
+#include "transport.h"
+#include "openvpn-transport.h"
+
+bool
+transport_prepare(const struct plugin_list *plugins,
+                  const char **transport_plugin_argv,
+                  struct openvpn_transport_bind_vtab1 **vtabp,
+                  openvpn_plugin_handle_t *handlep,
+                  openvpn_transport_args_t *argsp)
+{
+    const char *expected_so_pathname = transport_plugin_argv[0];
+    int argc = 0;
+
+    while (transport_plugin_argv[argc])
+    {
+        argc++;
+    }
+
+    for (int i = 0; i < plugins->common->n; i++)
+    {
+        struct plugin *p = &plugins->common->plugins[i];
+        if (p->so_pathname && !strcmp(p->so_pathname, expected_so_pathname))
+        {
+            /* Pathname matches; this is the plugin requested. */
+            if (!(p->plugin_type_mask
+                  & OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TRANSPORT)))
+            {
+                msg(M_FATAL,
+                    "INDIRECT: plugin %s does not indicate TRANSPORT functionality",
+                    p->so_pathname);
+            }
+
+            size_t size;
+            struct openvpn_transport_bind_vtab1 *vtab = NULL;
+            if (p->get_vtab)
+            {
+                vtab = p->get_vtab(OPENVPN_VTAB_TRANSPORT_BIND_V1, &size);
+            }
+
+            if (!vtab)
+            {
+                msg(M_FATAL,
+                    "INDIRECT: plugin %s has no TRANSPORT_BIND_V1 table",
+                    p->so_pathname);
+            }
+
+            /* Sanity checks on the vtable. */
+            if (!(size == sizeof(*vtab) && vtab->bind
+                  && ((vtab->parseargs && vtab->argerror && vtab->freeargs)
+                      || (!vtab->parseargs && !vtab->argerror
+                          && !vtab->freeargs))))
+            {
+                msg(M_FATAL,
+                    "INDIRECT: plugin %s returned a faulty TRANSPORT_BIND_V1 table",
+                    p->so_pathname);
+            }
+
+            openvpn_transport_args_t args = NULL;
+            if (vtab->parseargs)
+            {
+                args = vtab->parseargs(p->plugin_handle, transport_plugin_argv,
+                                       argc);
+
+                const char *argerror = vtab->argerror(args);
+                if (argerror)
+                {
+                    msg(M_FATAL,
+                        "INDIRECT: invalid arguments to transport-plugin %s: %s",
+                        p->so_pathname, argerror);
+                }
+            }
+
+            *vtabp = vtab;
+            *handlep = p->plugin_handle;
+            *argsp = args;
+
+            return true;
+        }
+    }
+
+    return false;
+}
+
+openvpn_transport_socket_t
+transport_bind(const struct plugin_list *plugins,
+               const char **transport_plugin_argv, sa_family_t ai_family,
+               struct addrinfo *bind_addresses)
+{
+    openvpn_plugin_handle_t handle;
+    openvpn_transport_args_t args;
+    openvpn_transport_socket_t indirect;
+    struct openvpn_transport_bind_vtab1 *vtab;
+    struct addrinfo *cur = NULL;
+    struct openvpn_sockaddr zero;
+
+    if (!transport_prepare(plugins, transport_plugin_argv, &vtab, &handle,
+                           &args))
+    {
+        msg(M_FATAL, "INDIRECT: Socket bind failed: provider plugin not found");
+    }
+
+    /* Partially replicates the functionality of socket_bind. No bind_ipv6_only
+     * or other such options, presently.
+     */
+    if (bind_addresses)
+    {
+        for (cur = bind_addresses; cur; cur = cur->ai_next)
+        {
+            if (cur->ai_family == ai_family)
+            {
+                break;
+            }
+        }
+
+        if (!cur)
+        {
+            msg(M_FATAL, "INDIRECT: Socket bind failed: Addr to bind has no %s record",
+                addr_family_name(ai_family));
+        }
+    }
+
+    if (cur)
+    {
+        indirect = vtab->bind(handle, args, cur->ai_addr, cur->ai_addrlen);
+    }
+    else if (ai_family == AF_UNSPEC)
+    {
+        msg(M_ERR, "INDIRECT: cannot bind with unspecified address family");
+    }
+    else
+    {
+        memset(&zero, 0, sizeof(zero));
+        zero.addr.sa.sa_family = ai_family;
+        addr_zero_host(&zero);
+        indirect = vtab->bind(handle, args, &zero.addr.sa, af_addr_size(ai_family));
+    }
+
+    if (!indirect)
+    {
+        msg(M_ERR, "INDIRECT: Socket bind failed");
+    }
+
+    if (vtab->freeargs)
+    {
+        vtab->freeargs(args);
+    }
+
+    return indirect;
+}
+
+struct encapsulated_event_set
+{
+    struct openvpn_transport_event_set_handle handle;
+    struct event_set *real;
+};
+
+#if EVENT_READ == OPENVPN_TRANSPORT_EVENT_READ \
+    && EVENT_WRITE == OPENVPN_TRANSPORT_EVENT_WRITE
+#define TRANSPORT_EVENT_BITS_IDENTICAL 1
+#else
+#define TRANSPORT_EVENT_BITS_IDENTICAL 0
+#endif
+
+static inline unsigned
+translate_rwflags_in(unsigned vrwflags)
+{
+#if TRANSPORT_EVENT_BITS_IDENTICAL
+    return vrwflags;
+#else
+    unsigned rwflags = 0;
+    if (vrwflags & OPENVPN_TRANSPORT_EVENT_READ)
+    {
+        rwflags |= EVENT_READ;
+    }
+    if (vrwflags & OPENVPN_TRANSPORT_EVENT_WRITE)
+    {
+        rwflags |= EVENT_WRITE;
+    }
+    return rwflags;
+#endif
+}
+
+static inline unsigned
+translate_rwflags_out(unsigned rwflags)
+{
+#if TRANSPORT_EVENT_BITS_IDENTICAL
+    return rwflags;
+#else
+    unsigned vrwflags = 0;
+    if (rwflags & EVENT_READ)
+    {
+        vrwflags |= OPENVPN_TRANSPORT_EVENT_READ;
+    }
+    if (rwflags & EVENT_WRITE)
+    {
+        vrwflags |= OPENVPN_TRANSPORT_EVENT_WRITE;
+    }
+    return vrwflags;
+#endif
+}
+
+static void
+encapsulated_event_set_set_event(openvpn_transport_event_set_handle_t handle,
+                                 openvpn_transport_native_event_t vev,
+                                 unsigned vrwflags, void *arg)
+{
+    unsigned rwflags = translate_rwflags_in(vrwflags);
+    event_t ev;
+#ifdef _WIN32
+    struct rw_handle rw;
+    rw.read = vev->read;
+    rw.write = vev->write;
+    ev = &rw;
+#else
+    ev = vev;
+#endif
+
+    struct event_set *es = ((struct encapsulated_event_set *) handle)->real;
+    /* If rwflags == 0, we do nothing, because this is always one-shot mode. */
+    if (rwflags != 0)
+    {
+        event_ctl(es, ev, rwflags, arg);
+    }
+}
+
+static const struct openvpn_transport_event_set_vtab encapsulated_event_set_vtab = {
+    encapsulated_event_set_set_event
+};
+
+unsigned
+transport_pump(openvpn_transport_socket_t indirect,
+               struct event_set_return *esr, int *esrlen)
+{
+    int i = 0;
+    while (i < *esrlen)
+    {
+        unsigned vrwflags = translate_rwflags_out(esr[i].rwflags);
+        if (indirect->vtab->update_event(indirect, esr[i].arg, vrwflags))
+        {
+            /* Consume the event; move the last one in place of it. */
+            if (i != *esrlen - 1)
+            {
+                memcpy(&esr[i], &esr[*esrlen-1], sizeof(*esr));
+            }
+            (*esrlen)--;
+        }
+        else
+        {
+            /* Don't consume the event; move to the next one. */
+            i++;
+        }
+    }
+
+    return translate_rwflags_in(indirect->vtab->pump(indirect));
+}
+
+void
+transport_request_events(openvpn_transport_socket_t indirect,
+                         struct event_set *es, unsigned rwflags)
+{
+    unsigned vrwflags = translate_rwflags_out(rwflags);
+    struct encapsulated_event_set encapsulated_es;
+    encapsulated_es.handle.vtab = &encapsulated_event_set_vtab;
+    encapsulated_es.real = es;
+    indirect->vtab->request_event(indirect, &encapsulated_es.handle, vrwflags);
+}
+
+#endif  /* ENABLE_PLUGIN */
diff --git a/src/openvpn/transport.h b/src/openvpn/transport.h
new file mode 100644
index 00000000..344ce44b
--- /dev/null
+++ b/src/openvpn/transport.h
@@ -0,0 +1,94 @@
+/*
+ *  Transport API handling code
+ *
+ *  Copyright (C) 2018 Robin Tarsiger <rtt@...2484...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#ifndef OPENVPN_TRANSPORT_H
+#define OPENVPN_TRANSPORT_H
+
+#ifdef ENABLE_PLUGIN
+
+#include "plugin.h"
+#include "openvpn-transport.h"
+
+/* Given a list of plugins and an argument list for a desired
+ * transport plugin instance, prepare to bind new link sockets using
+ * that transport plugin and args. If all succeeds, return true, and:
+ *
+ *   *vtabp is set to the vtable by which to bind new link sockets.
+ *   *handlep is set to the plugin handle to use in bind calls.
+ *   *argsp is set to the args value to use in bind calls. It is
+ *     the caller's responsibility to call freeargs on it later.
+ *
+ * Otherwise, return false, and the values of all of the above are
+ * undefined. None of the output pointers may be NULL.
+ */
+bool transport_prepare(const struct plugin_list *plugins,
+                       const char **transport_plugin_argv,
+                       struct openvpn_transport_bind_vtab1 **vtabp,
+                       openvpn_plugin_handle_t *handlep,
+                       openvpn_transport_args_t *argsp);
+
+/* Bind a virtual socket given an address family and list of potential
+ * bind addresses. bind_addresses may be NULL, in which case an
+ * unspecified address of the correct family is used. The virtual
+ * socket comes from a transport plugin in the list of plugins which
+ * matches transport_plugin_argv, which is used for any
+ * connection-specific parameters the plugin may require.
+ *
+ * Raises a fatal error if the socket cannot be bound.
+ */
+openvpn_transport_socket_t
+transport_bind(const struct plugin_list *plugins,
+               const char **transport_plugin_argv, sa_family_t ai_family,
+               struct addrinfo *bind_addresses);
+
+/* Mutates esr/esrlen to consume events. */
+unsigned transport_pump(openvpn_transport_socket_t vsocket,
+                        struct event_set_return *esr, int *esrlen);
+
+void transport_request_events(openvpn_transport_socket_t indirect,
+                              struct event_set *es, unsigned rwflags);
+
+/* NOTE: transport_write and transport_read implicitly downcast from a
+ * ssize_t to an int on return. Various link_socket_* functions
+ * already do this, under the assumption that the return values will
+ * always fit in an int, because the requested lengths always fit in
+ * an int, otherwise the buffer structure would already be corrupted.
+ */
+
+static inline int
+transport_write(openvpn_transport_socket_t indirect,
+                struct buffer *buf, struct sockaddr *addr, socklen_t addrlen)
+{
+    return indirect->vtab->sendto(indirect, BPTR(buf), BLEN(buf), addr,
+                                  addrlen);
+}
+
+static inline int
+transport_read(openvpn_transport_socket_t indirect,
+               struct buffer *buf, struct sockaddr *addr, socklen_t *addrlen)
+{
+    return indirect->vtab->recvfrom(indirect, BPTR(buf),
+                                    buf_forward_capacity(buf), addr, addrlen);
+}
+
+#endif /* ENABLE_PLUGIN */
+
+#endif /* !OPENVPN_TRANSPORT_H */
-- 
2.19.2


