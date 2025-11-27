MIME-Version: 1.0
From: Moritz Fain <moritz-openvpn@...2969...>
Date: Thu, 27 Nov 2025 09:50:42 +0100
Message-ID: <CAM8w-qHW=pfTLiPFg6kn=MbpY_wcKL4gShDOLy33Y82gOhQc7A@...278...>
Subject: [Openvpn-devel] [PATCH 1/2] Management: add reload-push-options
 command
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

This adds a new management command 'reload-push-options' that allows reload=
ing
the push options from the configuration file without restarting the server.
This is useful for updating routes or DNS settings for new clients without
dropping existing connections.

The command supports an optional 'sync' argument. When provided, the server
will also synchronize the new options to currently connected clients by:
1. Calculating the difference between old and new push options.
2. Sending '-instruction' (e.g. -route) to remove old options.
3. Sending new options via PUSH_UPDATE.

This includes a comprehensive integration test suite in
tests/reload_push_options.
---
 .gitignore                                    |   1 +
 src/openvpn/manage.c                          |  29 ++
 src/openvpn/manage.h                          |   1 +
 src/openvpn/multi.c                           | 280 ++++++++++++++++++
 src/openvpn/options.c                         |   2 +
 src/openvpn/options.h                         |   1 +
 src/openvpn/options_util.c                    |   7 +-
 src/openvpn/options_util.h                    |   3 +
 tests/reload_push_options/.gitignore          |   6 +
 tests/reload_push_options/Dockerfile          |  46 +++
 tests/reload_push_options/README.md           |  84 ++++++
 .../reload_push_options/client-entrypoint.sh  |  35 +++
 tests/reload_push_options/configs/client.conf |  22 ++
 .../configs/server.conf.default               |  16 +
 tests/reload_push_options/docker-compose.yml  |  73 +++++
 tests/reload_push_options/run.sh              | 277 +++++++++++++++++
 .../scripts/client-entrypoint.sh              |  18 ++
 tests/reload_push_options/scripts/gen-keys.sh |  48 +++
 .../reload_push_options/scripts/log-routes.sh |  13 +
 .../scripts/server-entrypoint.sh              |  20 ++
 20 files changed, 979 insertions(+), 3 deletions(-)
 create mode 100644 tests/reload_push_options/.gitignore
 create mode 100644 tests/reload_push_options/Dockerfile
 create mode 100644 tests/reload_push_options/README.md
 create mode 100755 tests/reload_push_options/client-entrypoint.sh
 create mode 100644 tests/reload_push_options/configs/client.conf
 create mode 100644 tests/reload_push_options/configs/server.conf.default
 create mode 100644 tests/reload_push_options/docker-compose.yml
 create mode 100755 tests/reload_push_options/run.sh
 create mode 100755 tests/reload_push_options/scripts/client-entrypoint.sh
 create mode 100755 tests/reload_push_options/scripts/gen-keys.sh
 create mode 100755 tests/reload_push_options/scripts/log-routes.sh
 create mode 100755 tests/reload_push_options/scripts/server-entrypoint.sh

diff --git a/.gitignore b/.gitignore
index 04523af3..8a712be5 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,6 +15,7 @@ out
 .vs
 .deps
 .libs
+.cache
 Makefile
 Makefile.in
 aclocal.m4
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 6efa1001..f5dd36a9 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -137,6 +137,8 @@ man_help(void)
     msg(M_CLIENT, "push-update-broad options : Broadcast a message to
update the specified options.");
     msg(M_CLIENT, "                            Ex. push-update-broad
\"route something, -dns\"");
     msg(M_CLIENT, "push-update-cid CID options : Send an update
message to the client identified by CID.");
+    msg(M_CLIENT, "reload-push-options [sync] : Reload push options
from config file for new clients.");
+    msg(M_CLIENT, "                            With 'sync': also sync
options to connected clients (add new, remove old).");
     msg(M_CLIENT, "END");
 }

@@ -1723,6 +1725,33 @@ man_dispatch_command(struct management *man,
struct status_output *so, const cha
             man_push_update(man, p, UPT_BY_CID);
         }
     }
+    else if (streq(p[0], "reload-push-options"))
+    {
+        if (man->persist.callback.reload_push_options)
+        {
+            bool sync =3D (p[1] && streq(p[1], "sync"));
+            bool status =3D
(*man->persist.callback.reload_push_options)(man->persist.callback.arg,
sync);
+            if (status)
+            {
+                if (sync)
+                {
+                    msg(M_CLIENT, "SUCCESS: push options reloaded and
synced to all clients");
+                }
+                else
+                {
+                    msg(M_CLIENT, "SUCCESS: push options reloaded
from config file");
+                }
+            }
+            else
+            {
+                msg(M_CLIENT, "ERROR: failed to reload push options");
+            }
+        }
+        else
+        {
+            man_command_unsupported("reload-push-options");
+        }
+    }
 #if 1
     else if (streq(p[0], "test"))
     {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index dedcc155..2c4305e7 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -198,6 +198,7 @@ struct management_callback
     bool (*remote_entry_get)(void *arg, unsigned int index, char **remote);
     bool (*push_update_broadcast)(void *arg, const char *options);
     bool (*push_update_by_cid)(void *arg, unsigned long cid, const
char *options);
+    bool (*reload_push_options)(void *arg, bool sync);
 };

 /*
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2b944667..1452bf3d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -34,6 +34,7 @@
 #include "forward.h"
 #include "multi.h"
 #include "push.h"
+#include "options_util.h"
 #include "run_command.h"
 #include "otime.h"
 #include "gremlin.h"
@@ -4100,6 +4101,284 @@ management_get_peer_info(void *arg, const
unsigned long cid)
     return ret;
 }

+/**
+ * Check if an option string exists in a push_list.
+ */
+static bool
+push_option_exists(const struct push_list *list, const char *option)
+{
+    const struct push_entry *e =3D list->head;
+    while (e)
+    {
+        if (e->enable && e->option && strcmp(e->option, option) =3D=3D 0)
+        {
+            return true;
+        }
+        e =3D e->next;
+    }
+    return false;
+}
+
+/*
+ * Helper to append to push list using specific GC.
+ */
+static void
+push_list_add(struct push_list *list, const char *opt, struct gc_arena *gc)
+{
+    struct push_entry *e;
+    ALLOC_OBJ_CLEAR_GC(e, struct push_entry, gc);
+    e->enable =3D true;
+    e->option =3D opt;
+
+    if (list->tail)
+    {
+        list->tail->next =3D e;
+        list->tail =3D e;
+    }
+    else
+    {
+        list->head =3D e;
+        list->tail =3D e;
+    }
+}
+
+/**
+ * Find the index of an updatable option type for a given option string.
+ * @param option  The option string to check (e.g., "route 10.0.0.0 255.0.=
0.0")
+ * @return        Index into updatable_options[] or -1 if not found
+ */
+static ssize_t
+find_updatable_option_index(const char *option)
+{
+    size_t len =3D strlen(option);
+    for (size_t i =3D 0; i < updatable_options_count; ++i)
+    {
+        size_t opt_len =3D strlen(updatable_options[i]);
+        if (len >=3D opt_len
+            && strncmp(option, updatable_options[i], opt_len) =3D=3D 0
+            && (option[opt_len] =3D=3D '\0' || option[opt_len] =3D=3D ' '))
+        {
+            return (ssize_t)i;
+        }
+    }
+    return -1;
+}
+
+/**
+ * Reload push options from the configuration file.
+ * This function re-reads the config file and updates the push_list
+ * that will be sent to new connecting clients.
+ *
+ * Thread safety: OpenVPN uses a single-threaded event loop, so this
+ * function runs sequentially with all other operations.
+ *
+ * @param arg   Pointer to multi_context
+ * @param sync  If true, sync options to connected clients (add new,
remove old)
+ * @return true on success, false on failure
+ */
+static bool
+management_callback_reload_push_options(void *arg, bool sync)
+{
+    struct multi_context *m =3D (struct multi_context *)arg;
+    struct gc_arena gc =3D gc_new();
+    bool ret =3D false;
+
+    msg(M_INFO, "MANAGEMENT: Reloading push options from config file");
+
+    /* Check if we have a config file to reload from */
+    if (!m->top.options.config)
+    {
+        msg(M_WARN, "MANAGEMENT: Cannot reload push options - no
config file specified");
+        goto cleanup;
+    }
+
+    /* Save reference to old push_list for sync comparison */
+    struct push_list old_push_list =3D m->top.options.push_list;
+
+    /* Create a temporary options structure to parse the config */
+    struct options new_options;
+    CLEAR(new_options);
+
+    /* Initialize the gc_arena for the new options */
+    new_options.gc =3D gc_new();
+
+    /* Set up environment for config parsing */
+    struct env_set *es =3D env_set_create(&gc);
+    unsigned int option_types_found =3D 0;
+
+    /* Re-read the configuration file */
+    read_config_file(&new_options, m->top.options.config, 0,
+                     m->top.options.config, 0, M_WARN,
+                     OPT_P_DEFAULT, &option_types_found, es);
+
+    /* Validate we got a sensible result - if old list had entries
but new is empty,
+     * this likely indicates a parsing error */
+    if (old_push_list.head && !new_options.push_list.head)
+    {
+        msg(M_WARN, "MANAGEMENT: Config reload returned empty push
list - aborting");
+        gc_free(&new_options.gc);
+        goto cleanup;
+    }
+
+    /* Create a new GC arena for the new push list */
+    struct gc_arena new_push_list_gc =3D gc_new();
+    struct push_list new_push_list =3D { NULL, NULL };
+
+    /* Copy each push entry from the parsed config to the new push_list
+     * using the new dedicated push_list_gc */
+    const struct push_entry *e =3D new_options.push_list.head;
+    while (e)
+    {
+        if (e->enable && e->option)
+        {
+            /* Copy the option string to the new dedicated gc_arena */
+            const char *opt =3D string_alloc(e->option, &new_push_list_gc);
+            push_list_add(&new_push_list, opt, &new_push_list_gc);
+        }
+        e =3D e->next;
+    }
+
+    /* Free the temporary options gc_arena (parsed config) */
+    gc_free(&new_options.gc);
+
+    /* Sync options to connected clients if requested */
+    /* We do this BEFORE swapping the lists so we can compare old vs new */
+    if (sync)
+    {
+        /* Calculate required buffer size: sum of all option lengths
+ separators */
+        size_t opts_size =3D 0;
+        const struct push_entry *size_e =3D new_push_list.head;
+        while (size_e)
+        {
+            if (size_e->enable && size_e->option)
+            {
+                opts_size +=3D strlen(size_e->option) + 2; /* option + ", =
" */
+            }
+            size_e =3D size_e->next;
+        }
+        /* Add space for removal commands: "-type, " for each
updatable option type */
+        opts_size +=3D updatable_options_count * 32;
+        /* Minimum size to avoid edge cases */
+        if (opts_size < PUSH_BUNDLE_SIZE)
+        {
+            opts_size =3D PUSH_BUNDLE_SIZE;
+        }
+
+        struct buffer opts =3D alloc_buf_gc(opts_size, &gc);
+        bool first =3D true;
+        int added =3D 0, removed =3D 0;
+
+        /* Set of option types that have been removed/modified */
+        bool *type_removed =3D gc_malloc(updatable_options_count *
sizeof(bool), true, &gc);
+
+        /* 1. Detect removed options and mark their types */
+        const struct push_entry *old_e =3D old_push_list.head;
+        while (old_e)
+        {
+            if (old_e->enable && old_e->option)
+            {
+                if (!push_option_exists(&new_push_list, old_e->option))
+                {
+                    ssize_t type_idx =3D
find_updatable_option_index(old_e->option);
+                    if (type_idx >=3D 0)
+                    {
+                        type_removed[type_idx] =3D true;
+                        removed++;
+                        msg(D_PUSH, "MANAGEMENT: Sync removing: %s",
old_e->option);
+                    }
+                    else
+                    {
+                        msg(M_WARN, "MANAGEMENT: Cannot sync removal
of option '%s' (not updatable)", old_e->option);
+                    }
+                }
+            }
+            old_e =3D old_e->next;
+        }
+
+        /* 2. Add removal commands for all marked types */
+        for (size_t i =3D 0; i < updatable_options_count; ++i)
+        {
+            if (type_removed[i])
+            {
+                if (!first)
+                {
+                    buf_printf(&opts, ", ");
+                }
+                /* Send -type to remove all options of that type */
+                buf_printf(&opts, "-%s", updatable_options[i]);
+                first =3D false;
+            }
+        }
+
+        /* 3. Add new options AND re-add options belonging to removed type=
s */
+        const struct push_entry *new_e =3D new_push_list.head;
+        while (new_e)
+        {
+            if (new_e->enable && new_e->option)
+            {
+                bool should_send =3D false;
+                bool is_existing =3D push_option_exists(&old_push_list,
new_e->option);
+
+                /* Check if this option belongs to a type that was reset */
+                bool type_was_reset =3D false;
+                ssize_t type_idx =3D find_updatable_option_index(new_e->op=
tion);
+                if (type_idx >=3D 0 && type_removed[type_idx])
+                {
+                    type_was_reset =3D true;
+                }
+
+                /* Always send new options */
+                if (!is_existing)
+                {
+                    should_send =3D true;
+                    added++;
+                    msg(D_PUSH, "MANAGEMENT: Sync adding: %s", new_e->opti=
on);
+                }
+                /* Also resend options if their type was reset
(because we sent -type) */
+                else if (type_was_reset)
+                {
+                    should_send =3D true;
+                    msg(D_PUSH, "MANAGEMENT: Sync re-adding (type
reset): %s", new_e->option);
+                }
+
+                if (should_send)
+                {
+                    if (!first)
+                    {
+                        buf_printf(&opts, ", ");
+                    }
+                    buf_printf(&opts, "%s", new_e->option);
+                    first =3D false;
+                }
+            }
+            new_e =3D new_e->next;
+        }
+
+        if (BLEN(&opts) > 0)
+        {
+            msg(M_INFO, "MANAGEMENT: Syncing push options to clients
(added=3D%d, removed=3D%d)",
+                added, removed);
+            management_callback_send_push_update_broadcast(m, BSTR(&opts));
+        }
+        else
+        {
+            msg(M_INFO, "MANAGEMENT: No changes to sync to clients");
+        }
+    }
+
+    /* Now replace the old push_list with the new one and free old memory =
*/
+    gc_free(&m->top.options.push_list_gc);
+    m->top.options.push_list_gc =3D new_push_list_gc;
+    m->top.options.push_list =3D new_push_list;
+
+    msg(M_INFO, "MANAGEMENT: Push options reloaded successfully");
+    ret =3D true;
+
+cleanup:
+    gc_free(&gc);
+    return ret;
+}
+
 #endif /* ifdef ENABLE_MANAGEMENT */


@@ -4125,6 +4404,7 @@ init_management_callback_multi(struct multi_context *=
m)
         cb.get_peer_info =3D management_get_peer_info;
         cb.push_update_broadcast =3D
management_callback_send_push_update_broadcast;
         cb.push_update_by_cid =3D management_callback_send_push_update_by_=
cid;
+        cb.reload_push_options =3D management_callback_reload_push_options;
         management_set_callback(management, &cb);
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4794315c..8a97374e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -807,6 +807,7 @@ init_options(struct options *o, const bool init_gc)
     if (init_gc)
     {
         gc_init(&o->gc);
+        gc_init(&o->push_list_gc);
         gc_init(&o->dns_options.gc);
         o->gc_owned =3D true;
     }
@@ -942,6 +943,7 @@ uninit_options(struct options *o)
     if (o->gc_owned)
     {
         gc_free(&o->gc);
+        gc_free(&o->push_list_gc);
         gc_free(&o->dns_options.gc);
     }
 }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 42db9cae..bd013dba 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -487,6 +487,7 @@ struct options
     in_addr_t server_bridge_pool_end;

     struct push_list push_list;
+    struct gc_arena push_list_gc;
     bool ifconfig_pool_defined;
     in_addr_t ifconfig_pool_start;
     in_addr_t ifconfig_pool_end;
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index eba7d396..5fd35eda 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -193,7 +193,7 @@ atoi_constrained(const char *str, int *value,
const char *name, int min, int max
     return true;
 }

-static const char *updatable_options[] =3D { "block-ipv6", "block-outside-=
dns",
+const char *updatable_options[] =3D { "block-ipv6", "block-outside-dns",
                                            "dhcp-option", "dns",
                                            "ifconfig", "ifconfig-ipv6",
                                            "push-continuation",
"redirect-gateway",
@@ -202,6 +202,8 @@ static const char *updatable_options[] =3D {
"block-ipv6", "block-outside-dns",
                                            "route-metric", "topology",
                                            "tun-mtu", "keepalive" };

+const size_t updatable_options_count =3D sizeof(updatable_options) /
sizeof(char *);
+
 bool
 check_push_update_option_flags(char *line, int *i, unsigned int *flags)
 {
@@ -232,8 +234,7 @@ check_push_update_option_flags(char *line, int *i,
unsigned int *flags)
     }

     size_t len =3D strlen(&line[*i]);
-    int count =3D sizeof(updatable_options) / sizeof(char *);
-    for (int j =3D 0; j < count; ++j)
+    for (size_t j =3D 0; j < updatable_options_count; ++j)
     {
         size_t opt_len =3D strlen(updatable_options[j]);
         if (len < opt_len)
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 5bb710a6..50988b1b 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -108,4 +108,7 @@ bool apply_pull_filter(const struct options *o, char *l=
ine);
  */
 bool check_push_update_option_flags(char *line, int *i, unsigned int *flag=
s);

+extern const char *updatable_options[];
+extern const size_t updatable_options_count;
+
 #endif /* ifndef OPTIONS_UTIL_H_ */
diff --git a/tests/reload_push_options/.gitignore
b/tests/reload_push_options/.gitignore
new file mode 100644
index 00000000..d174b9ac
--- /dev/null
+++ b/tests/reload_push_options/.gitignore
@@ -0,0 +1,6 @@
+# Generated during tests
+keys/
+results/
+
+
+
diff --git a/tests/reload_push_options/Dockerfile
b/tests/reload_push_options/Dockerfile
new file mode 100644
index 00000000..4677aa73
--- /dev/null
+++ b/tests/reload_push_options/Dockerfile
@@ -0,0 +1,46 @@
+# Build OpenVPN from source
+FROM debian:bookworm-slim AS builder
+
+RUN apt-get update && apt-get install -y \
+    build-essential \
+    autoconf \
+    automake \
+    libtool \
+    pkg-config \
+    libssl-dev \
+    liblz4-dev \
+    liblzo2-dev \
+    libpam0g-dev \
+    libcap-ng-dev \
+    libnl-genl-3-dev \
+    && rm -rf /var/lib/apt/lists/*
+
+WORKDIR /src
+COPY . .
+
+RUN autoreconf -fvi && \
+    ./configure --disable-systemd --disable-plugins && \
+    make -j$(nproc)
+
+# Runtime image
+FROM debian:bookworm-slim
+
+RUN apt-get update && apt-get install -y \
+    libssl3 \
+    liblz4-1 \
+    liblzo2-2 \
+    libcap-ng0 \
+    libnl-genl-3-200 \
+    iproute2 \
+    iptables \
+    netcat-openbsd \
+    gettext-base \
+    && rm -rf /var/lib/apt/lists/*
+
+COPY --from=3Dbuilder /src/src/openvpn/openvpn /usr/local/sbin/openvpn
+
+# Copy default server config into the image
+COPY tests/reload_push_options/configs/server.conf.default
/etc/openvpn/server.conf.default
+
+RUN mkdir -p /dev/net && \
+    mknod /dev/net/tun c 10 200 || true
diff --git a/tests/reload_push_options/README.md
b/tests/reload_push_options/README.md
new file mode 100644
index 00000000..0b35e125
--- /dev/null
+++ b/tests/reload_push_options/README.md
@@ -0,0 +1,84 @@
+# reload-push-options Test Suite
+
+Integration tests for the `reload-push-options` management command.
+
+## Prerequisites
+
+- Docker & Docker Compose
+- OpenSSL (for key generation)
+
+## Quick Start
+
+```bash
+cd tests/reload_push_options
+./run.sh
+```
+
+## What it tests
+
+| Test | Description |
+|------|-------------|
+| 1 | Basic reload without sync - existing clients unchanged |
+| 2 | Sync with new route added |
+| 3 | Sync with route removed |
+| 4 | Sync with all routes removed |
+| 5 | Sync with only new routes (complete replacement) |
+| 6 | Sync with mixed changes (add + remove) |
+| 7 | New client receives updated config |
+| 8 | Stress test with 500 routes |
+
+## Architecture
+
+```
+=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=90
+=E2=94=82                Docker Network                   =E2=94=82
+=E2=94=82                 10.100.0.0/24                   =E2=94=82
+=E2=94=82                                                 =E2=94=82
+=E2=94=82  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90    =E2=94=8C=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90   =E2=94=82
+=E2=94=82  =E2=94=82  Server  =E2=94=82    =E2=94=82 Client1  =E2=94=82   =
 =E2=94=82 Client2  =E2=94=82   =E2=94=82
+=E2=94=82  =E2=94=82 .0.2     =E2=94=82=E2=97=84=E2=94=80=E2=94=80=E2=94=
=80=E2=94=82 .0.10    =E2=94=82    =E2=94=82 .0.11    =E2=94=82   =E2=94=82
+=E2=94=82  =E2=94=82          =E2=94=82=E2=97=84=E2=94=80=E2=94=80=E2=94=
=80=E2=94=82          =E2=94=82    =E2=94=82          =E2=94=82   =E2=94=82
+=E2=94=82  =E2=94=82 :7505    =E2=94=82    =E2=94=82          =E2=94=82   =
 =E2=94=82          =E2=94=82   =E2=94=82
+=E2=94=82  =E2=94=82 (mgmt)   =E2=94=82    =E2=94=82          =E2=94=82   =
 =E2=94=82          =E2=94=82   =E2=94=82
+=E2=94=82  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=94=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=98    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98   =E2=94=82
+=E2=94=82       =E2=94=82                                         =E2=94=82
+=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98
+        =E2=94=82
+   localhost:7505 (management interface)
+```
+
+## Manual Testing
+
+```bash
+# Start the environment
+docker compose up -d
+
+# Connect to management interface
+nc localhost 7505
+
+# Commands to try:
+help
+status
+reload-push-options
+reload-push-options sync
+```
+
+## Files
+
+- `docker-compose.yml` - Container orchestration
+- `Dockerfile` - Builds OpenVPN from source
+- `configs/server.conf.default` - Default server config (baked into image)
+- `configs/client.conf` - Client config
+- `keys/` - PKI (auto-generated)
+- `scripts/` - Entrypoints and helpers
+- `results/` - Test output and logs
+
+## How Config Updates Work
+
+1. Default server config (`server.conf.default`) is copied into the
Docker image
+2. On container start, `server-entrypoint.sh` restores it to
`/etc/openvpn/server.conf`
+3. During tests, config is updated inside the container via `docker
compose exec`
+4. This ensures each test run starts from a clean, known state
+
+
+
diff --git a/tests/reload_push_options/client-entrypoint.sh
b/tests/reload_push_options/client-entrypoint.sh
new file mode 100755
index 00000000..638d76d4
--- /dev/null
+++ b/tests/reload_push_options/client-entrypoint.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+set -e
+
+CLIENT_NAME=3D${CLIENT_NAME:-client}
+LOG_FILE=3D"/var/log/openvpn/${CLIENT_NAME}.log"
+
+# Function to log routes
+log_routes() {
+    echo "=3D=3D=3D Routes at $(date -Iseconds) =3D=3D=3D" >> "$LOG_FILE"
+    ip route show | grep -E "^(10\.|172\.|192\.168\.)" >> "$LOG_FILE"
2>/dev/null || echo "(no VPN routes)" >> "$LOG_FILE"
+    echo "" >> "$LOG_FILE"
+}
+
+# Monitor route changes in background
+monitor_routes() {
+    while true; do
+        ip monitor route 2>/dev/null | while read -r line; do
+            echo "[$(date -Iseconds)] ROUTE CHANGE: $line" >> "$LOG_FILE"
+        done
+        sleep 1
+    done
+}
+
+# Start route monitor
+monitor_routes &
+
+# Log initial routes
+echo "=3D=3D=3D Client $CLIENT_NAME starting =3D=3D=3D" > "$LOG_FILE"
+log_routes
+
+# Start OpenVPN
+exec /usr/local/sbin/openvpn --config /etc/openvpn/client.conf \
+    --log-append "$LOG_FILE" \
+    --verb 4
+
diff --git a/tests/reload_push_options/configs/client.conf
b/tests/reload_push_options/configs/client.conf
new file mode 100644
index 00000000..1ce2ea84
--- /dev/null
+++ b/tests/reload_push_options/configs/client.conf
@@ -0,0 +1,22 @@
+# OpenVPN Client Config for reload-push-options testing
+client
+dev tun
+proto udp
+remote 10.100.0.2 1194
+
+ca /etc/openvpn/keys/ca.crt
+# cert and key are set via command line based on client name
+
+nobind
+persist-key
+persist-tun
+
+# Verbose logging
+verb 4
+
+# Allow scripts to run
+script-security 2
+
+# Script to log route changes
+route-up /scripts/log-routes.sh
+route-pre-down /scripts/log-routes.sh
diff --git a/tests/reload_push_options/configs/server.conf.default
b/tests/reload_push_options/configs/server.conf.default
new file mode 100644
index 00000000..2445b718
--- /dev/null
+++ b/tests/reload_push_options/configs/server.conf.default
@@ -0,0 +1,16 @@
+dev tun
+proto udp
+port 1194
+server 10.8.0.0 255.255.255.0
+ca /etc/openvpn/keys/ca.crt
+cert /etc/openvpn/keys/server.crt
+key /etc/openvpn/keys/server.key
+dh /etc/openvpn/keys/dh.pem
+keepalive 10 120
+persist-key
+persist-tun
+management 0.0.0.0 7505
+verb 4
+log /var/log/openvpn.log
+${PUSH_OPTIONS}
+
diff --git a/tests/reload_push_options/docker-compose.yml
b/tests/reload_push_options/docker-compose.yml
new file mode 100644
index 00000000..69668c88
--- /dev/null
+++ b/tests/reload_push_options/docker-compose.yml
@@ -0,0 +1,73 @@
+services:
+  server:
+    build:
+      context: ../..
+      dockerfile: tests/reload_push_options/Dockerfile
+    cap_add:
+      - NET_ADMIN
+    devices:
+      - /dev/net/tun:/dev/net/tun
+    networks:
+      vpn_net:
+        ipv4_address: 10.100.0.2
+    volumes:
+      - ./keys:/etc/openvpn/keys:ro
+      - ./scripts:/scripts:ro
+    ports:
+      - "7505:7505"  # Management interface
+    command: ["/scripts/server-entrypoint.sh"]
+    healthcheck:
+      test: ["CMD", "sh", "-c", "ip link show tun0 >/dev/null 2>&1"]
+      interval: 2s
+      timeout: 2s
+      retries: 15
+      start_period: 5s
+
+  client1:
+    build:
+      context: ../..
+      dockerfile: tests/reload_push_options/Dockerfile
+    cap_add:
+      - NET_ADMIN
+    devices:
+      - /dev/net/tun:/dev/net/tun
+    networks:
+      vpn_net:
+        ipv4_address: 10.100.0.10
+    volumes:
+      - ./configs:/etc/openvpn:ro
+      - ./keys:/etc/openvpn/keys:ro
+      - ./scripts:/scripts:ro
+      - ./results:/results
+    depends_on:
+      server:
+        condition: service_healthy
+    command: ["/scripts/client-entrypoint.sh", "client1"]
+
+  client2:
+    build:
+      context: ../..
+      dockerfile: tests/reload_push_options/Dockerfile
+    cap_add:
+      - NET_ADMIN
+    devices:
+      - /dev/net/tun:/dev/net/tun
+    networks:
+      vpn_net:
+        ipv4_address: 10.100.0.11
+    volumes:
+      - ./configs:/etc/openvpn:ro
+      - ./keys:/etc/openvpn/keys:ro
+      - ./scripts:/scripts:ro
+      - ./results:/results
+    depends_on:
+      server:
+        condition: service_healthy
+    command: ["/scripts/client-entrypoint.sh", "client2"]
+
+networks:
+  vpn_net:
+    driver: bridge
+    ipam:
+      config:
+        - subnet: 10.100.0.0/24
diff --git a/tests/reload_push_options/run.sh b/tests/reload_push_options/r=
un.sh
new file mode 100755
index 00000000..21c93b84
--- /dev/null
+++ b/tests/reload_push_options/run.sh
@@ -0,0 +1,277 @@
+#!/bin/bash
+# Test suite for reload-push-options management command
+set -e
+
+SCRIPT_DIR=3D"$(cd "$(dirname "$0")" && pwd)"
+cd "$SCRIPT_DIR"
+
+# Colors
+RED=3D'\033[0;31m'
+GREEN=3D'\033[0;32m'
+YELLOW=3D'\033[1;33m'
+NC=3D'\033[0m'
+
+pass() { echo -e "${GREEN}=E2=9C=93 PASS${NC}: $1"; }
+fail() {
+    echo -e "${RED}=E2=9C=97 FAIL${NC}: $1"
+    info "Debug: Server logs (last 30 lines):"
+    docker compose exec -T server tail -30 /var/log/openvpn.log
2>/dev/null || true
+    info "Debug: Client1 logs (last 30 lines):"
+    docker compose exec -T client1 tail -30 /results/client1.log
2>/dev/null || true
+    docker compose down -v 2>/dev/null || true
+    exit 1
+}
+info() { echo -e "${YELLOW}=E2=86=92${NC} $1"; }
+
+mgmt() {
+    echo "$1" | nc -q1 localhost 7505 2>/dev/null || echo "$1" | nc
-w1 localhost 7505 2>/dev/null
+}
+
+get_client_log_lines() {
+    local client=3D"$1"
+    docker compose exec -T "$client" wc -l /results/${client}.log
2>/dev/null | awk '{print $1}' || echo "0"
+}
+
+wait_for_client_ready() {
+    local client=3D"$1"
+    local lines_before=3D"$2"
+    local max_wait=3D20
+
+    for i in $(seq 1 $max_wait); do
+        sleep 1
+        if docker compose exec -T "$client" tail -n +$((lines_before
+ 1)) /results/${client}.log 2>/dev/null | grep -q "Initialization
Sequence Completed"; then
+            return 0
+        fi
+    done
+    return 1
+}
+
+get_client_routes() {
+    local client=3D"$1"
+    if ! docker compose exec -T "$client" ip link show tun0 &>/dev/null; t=
hen
+        echo "(tun0 not found)"
+        return
+    fi
+    docker compose exec -T "$client" ip route show 2>/dev/null | grep
-E "^(192\.168\.|10\.|172\.)" || echo "(no matching routes)"
+}
+
+update_server_config() {
+    local config_content=3D"$1"
+    # Generate config from template inside the container using envsubst
+    docker compose exec -T -e PUSH_OPTIONS=3D"$config_content" server \
+        sh -c 'envsubst '"'"'${PUSH_OPTIONS}'"'"' <
/etc/openvpn/server.conf.default > /etc/openvpn/server.conf'
+}
+
+wait_for_clients() {
+    info "Waiting for clients to connect..."
+    for i in {1..30}; do
+        local count=3D$(mgmt "status" | grep -c "^client" || true)
+        if [ "$count" -ge 2 ]; then
+            return 0
+        fi
+        sleep 1
+    done
+    fail "Clients did not connect in time"
+}
+
+cleanup() {
+    info "Cleaning up..."
+    docker compose down -v 2>/dev/null || true
+    rm -rf results/*
+}
+
+# Run test: update config, reload (with or without sync), verify routes
+# Args: test_name, client, sync (0|1|skip), config_content,
must_have_pattern, must_not_have_pattern
+# sync=3Dskip: don't send mgmt command, just verify routes (for reconnect =
tests)
+run_test() {
+    local test_name=3D"$1"
+    local client=3D"$2"
+    local sync=3D"$3"
+    local config_content=3D"$4"
+    local must_have=3D"$5"
+    local must_not_have=3D"$6"
+
+    echo ""
+    echo "--- $test_name ---"
+
+    local routes_before=3D$(get_client_routes "$client")
+    local log_lines=3D$(get_client_log_lines "$client")
+
+    update_server_config "$config_content"
+
+    if [ "$sync" !=3D "skip" ]; then
+        local cmd=3D"reload-push-options"
+        [ "$sync" =3D "1" ] && cmd=3D"reload-push-options sync"
+
+        local result=3D$(mgmt "$cmd")
+        echo "Management response: $result"
+
+        if ! echo "$result" | grep -q "SUCCESS"; then
+            fail "$test_name: command failed"
+        fi
+        pass "$test_name: command succeeded"
+
+        if [ "$sync" =3D "1" ]; then
+            wait_for_client_ready "$client" "$log_lines"
+        else
+            sleep 2
+        fi
+    fi
+
+    local routes=3D$(get_client_routes "$client")
+    info "Routes: $routes"
+
+    if [ -n "$must_have" ]; then
+        if echo "$routes" | grep -qE "$must_have"; then
+            pass "$test_name: expected routes present"
+        else
+            fail "$test_name: expected routes ($must_have) not found"
+        fi
+    fi
+
+    if [ -n "$must_not_have" ]; then
+        if echo "$routes" | grep -qE "$must_not_have"; then
+            fail "$test_name: removed routes ($must_not_have) still presen=
t"
+        else
+            pass "$test_name: routes correctly removed"
+        fi
+    fi
+}
+
+trap cleanup EXIT
+
+# Generate keys if needed
+if [ ! -f keys/ca.crt ]; then
+    info "Generating test PKI..."
+    chmod +x scripts/gen-keys.sh
+    ./scripts/gen-keys.sh
+fi
+
+chmod +x scripts/*.sh
+rm -rf results/*
+mkdir -p results
+
+echo ""
+echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
+echo " reload-push-options Test Suite"
+echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
+echo ""
+
+docker compose down -v 2>/dev/null || true
+
+# Initial config is now baked into the image (server.conf.default)
+# and restored on container start by server-entrypoint.sh
+
+info "Building and starting containers..."
+docker compose build
+docker compose up -d --wait
+wait_for_clients
+
+# Test 1: No sync - routes must NOT change (still have initial
routes, not the new 192.168.30.0)
+run_test "Test 1: No sync" client1 0 \
+    'push "route 192.168.10.0 255.255.255.0"
+push "route 192.168.20.0 255.255.255.0"
+push "route 192.168.30.0 255.255.255.0"
+push "dhcp-option DNS 8.8.8.8"' \
+    "192\.168\.10\.0|192\.168\.20\.0" "192\.168\.30\.0"
+
+# Test 2: Add route
+run_test "Test 2: Add route" client1 1 \
+    'push "route 192.168.10.0 255.255.255.0"
+push "route 192.168.20.0 255.255.255.0"
+push "route 192.168.30.0 255.255.255.0"
+push "route 192.168.40.0 255.255.255.0"
+push "dhcp-option DNS 8.8.8.8"' \
+    "192\.168\.40\.0" ""
+
+# Test 3: Remove route
+run_test "Test 3: Remove route" client1 1 \
+    'push "route 192.168.10.0 255.255.255.0"
+push "route 192.168.30.0 255.255.255.0"
+push "route 192.168.40.0 255.255.255.0"
+push "dhcp-option DNS 8.8.8.8"' \
+    "" "192\.168\.20\.0"
+
+# Test 4: Remove all routes
+run_test "Test 4: Remove all routes" client1 1 \
+    'push "dhcp-option DNS 8.8.8.8"' \
+    "" "192\.168\."
+
+# Test 5: Add new routes
+run_test "Test 5: New routes" client1 1 \
+    'push "route 172.16.0.0 255.255.0.0"
+push "route 172.17.0.0 255.255.0.0"
+push "dhcp-option DNS 1.1.1.1"' \
+    "172\.(16|17)\.0\.0" ""
+
+# Test 6: Mixed - remove 172.16, keep 172.17, add 10.10
+run_test "Test 6: Mixed changes" client1 1 \
+    'push "route 172.17.0.0 255.255.0.0"
+push "route 10.10.0.0 255.255.0.0"
+push "dhcp-option DNS 1.1.1.1"' \
+    "172\.17\.0\.0|10\.10\.0\.0" "172\.16\.0\.0"
+
+# Test 7: Reconnected client gets current config
+echo ""
+echo "--- Test 7: Reconnect ---"
+info "Updating config and restarting client2"
+
+update_server_config 'push "route 172.17.0.0 255.255.0.0"
+push "route 10.10.0.0 255.255.0.0"
+push "route 192.168.100.0 255.255.255.0"
+push "route 192.168.200.0 255.255.255.0"
+push "dhcp-option DNS 1.1.1.1"'
+
+docker compose restart client2
+sleep 5
+
+run_test "Test 7: Reconnect" client2 skip \
+    'push "route 172.17.0.0 255.255.0.0"
+push "route 10.10.0.0 255.255.0.0"
+push "route 192.168.100.0 255.255.255.0"
+push "route 192.168.200.0 255.255.255.0"
+push "dhcp-option DNS 1.1.1.1"' \
+    "172\.17\.0\.0|10\.10\.0\.0|192\.168\.100\.0|192\.168\.200\.0" ""
+
+# Test 8: Stress test with 500 routes
+echo ""
+echo "--- Test 8: 500 routes stress test ---"
+info "Generating config with 500 routes..."
+
+# Generate 500 routes: 10.{1-250}.{0,128}.0/25
+routes_config=3D""
+for i in $(seq 1 250); do
+    routes_config+=3D"push \"route 10.$i.0.0 255.255.128.0\"
+"
+    routes_config+=3D"push \"route 10.$i.128.0 255.255.128.0\"
+"
+done
+routes_config+=3D'push "dhcp-option DNS 8.8.8.8"'
+
+update_server_config "$routes_config"
+
+log_lines=3D$(get_client_log_lines client1)
+result=3D$(mgmt "reload-push-options sync")
+echo "Management response: $result"
+
+if ! echo "$result" | grep -q "SUCCESS"; then
+    fail "Test 8: 500 routes - command failed"
+fi
+pass "Test 8: 500 routes - command succeeded"
+
+wait_for_client_ready client1 "$log_lines"
+
+routes=3D$(get_client_routes client1)
+route_count=3D$(echo "$routes" | grep -c "^10\." || true)
+info "Route count: $route_count"
+
+if [ "$route_count" -ge 450 ]; then
+    pass "Test 8: 500 routes - received $route_count routes"
+else
+    fail "Test 8: 500 routes - expected ~500 routes, got $route_count"
+fi
+
+echo ""
+echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
+echo -e "${GREEN}All tests completed!${NC}"
+echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
diff --git a/tests/reload_push_options/scripts/client-entrypoint.sh
b/tests/reload_push_options/scripts/client-entrypoint.sh
new file mode 100755
index 00000000..9b65aeaa
--- /dev/null
+++ b/tests/reload_push_options/scripts/client-entrypoint.sh
@@ -0,0 +1,18 @@
+#!/bin/bash
+set -e
+
+CLIENT_NAME=3D"${1:-client1}"
+echo "Starting OpenVPN client: $CLIENT_NAME"
+
+# Wait for server to be ready
+sleep 3
+
+# Start OpenVPN with client-specific cert/key
+exec /usr/local/sbin/openvpn \
+    --config /etc/openvpn/client.conf \
+    --cert /etc/openvpn/keys/${CLIENT_NAME}.crt \
+    --key /etc/openvpn/keys/${CLIENT_NAME}.key \
+    --log /results/${CLIENT_NAME}.log
+
+
+
diff --git a/tests/reload_push_options/scripts/gen-keys.sh
b/tests/reload_push_options/scripts/gen-keys.sh
new file mode 100755
index 00000000..a0b8dee4
--- /dev/null
+++ b/tests/reload_push_options/scripts/gen-keys.sh
@@ -0,0 +1,48 @@
+#!/bin/bash
+# Generate test PKI for OpenVPN testing
+set -e
+
+SCRIPT_DIR=3D"$(cd "$(dirname "$0")" && pwd)"
+KEYS_DIR=3D"$SCRIPT_DIR/../keys"
+mkdir -p "$KEYS_DIR"
+cd "$KEYS_DIR"
+
+# Generate CA
+openssl genrsa -out ca.key 2048
+openssl req -new -x509 -days 365 -key ca.key -out ca.crt \
+    -subj "/CN=3DTest CA"
+
+# Generate server cert
+openssl genrsa -out server.key 2048
+openssl req -new -key server.key -out server.csr \
+    -subj "/CN=3Dserver"
+openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key \
+    -CAcreateserial -out server.crt
+
+# Generate client1 cert
+openssl genrsa -out client1.key 2048
+openssl req -new -key client1.key -out client1.csr \
+    -subj "/CN=3Dclient1"
+openssl x509 -req -days 365 -in client1.csr -CA ca.crt -CAkey ca.key \
+    -CAcreateserial -out client1.crt
+
+# Generate client2 cert
+openssl genrsa -out client2.key 2048
+openssl req -new -key client2.key -out client2.csr \
+    -subj "/CN=3Dclient2"
+openssl x509 -req -days 365 -in client2.csr -CA ca.crt -CAkey ca.key \
+    -CAcreateserial -out client2.crt
+
+# Generate DH params (2048 required by modern OpenSSL)
+openssl dhparam -out dh.pem 2048
+
+# Generate TLS auth key
+openvpn --genkey secret ta.key 2>/dev/null || \
+    dd if=3D/dev/urandom of=3Dta.key bs=3D256 count=3D1 2>/dev/null
+
+# Cleanup CSRs
+rm -f *.csr
+
+echo "Keys generated in $KEYS_DIR"
+ls -la "$KEYS_DIR"
+
diff --git a/tests/reload_push_options/scripts/log-routes.sh
b/tests/reload_push_options/scripts/log-routes.sh
new file mode 100755
index 00000000..88d9a229
--- /dev/null
+++ b/tests/reload_push_options/scripts/log-routes.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+# Log current routes to results file
+TIMESTAMP=3D$(date +%Y%m%d_%H%M%S)
+ROUTES_FILE=3D"/results/routes_${common_name:-unknown}_${TIMESTAMP}.txt"
+
+echo "=3D=3D=3D Route event at $TIMESTAMP =3D=3D=3D" >> "$ROUTES_FILE"
+echo "Script: $script_type" >> "$ROUTES_FILE"
+echo "Routes:" >> "$ROUTES_FILE"
+ip route show >> "$ROUTES_FILE"
+echo "" >> "$ROUTES_FILE"
+
+
+
diff --git a/tests/reload_push_options/scripts/server-entrypoint.sh
b/tests/reload_push_options/scripts/server-entrypoint.sh
new file mode 100755
index 00000000..9f476f99
--- /dev/null
+++ b/tests/reload_push_options/scripts/server-entrypoint.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+set -e
+
+echo "Starting OpenVPN server..."
+
+# Default push options (used on initial start)
+export PUSH_OPTIONS=3D'push "route 192.168.10.0 255.255.255.0"
+push "route 192.168.20.0 255.255.255.0"
+push "dhcp-option DNS 8.8.8.8"'
+
+# Generate config from template
+envsubst '${PUSH_OPTIONS}' < /etc/openvpn/server.conf.default >
/etc/openvpn/server.conf
+echo "Generated server config with default push options"
+
+# Enable IP forwarding (ignore error in container)
+echo 1 > /proc/sys/net/ipv4/ip_forward 2>/dev/null || true
+
+# Start OpenVPN
+exec /usr/local/sbin/openvpn --config /etc/openvpn/server.conf
+

