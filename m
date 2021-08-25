From: selva.nair@...277...
Date: Wed, 25 Aug 2021 17:02:30 -0400
Message-Id: <20210825210232.22509-1-selva.nair@...277...>
In-Reply-To: <20210825040122.14244-1-selva.nair@...277...>
References: <20210825040122.14244-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/3] Add remote-count and remote-entry
 query via management
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

From: Selva Nair <selva.nair@...277...>

Selecting the remote host via the management iterface
(management-query-remote) provides a restrictive user
experience as there is no easy way to tabulate all available
remote entries and show a list to the user to choose from.
Fix that.

Two new commands for querying the management interface are added:
(i) remote-entry-count : returns the number of remotes specified
    in the config file. Example result:
    >REMOTE-ENTRY-COUNT:10

(ii) remote-entry-get index : returns the remote entry at index in
     the form index,host,port,protocol. Example result for index = 2:
     >REMOTE-ENTRY:2,ovpn.example.com,1194,udp

v2: use independent callback functions for the two commands

See also management-notes.txt

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 Changes.rst              |  5 ++++
 doc/management-notes.txt | 22 +++++++++++++++++
 src/openvpn/init.c       | 43 ++++++++++++++++++++++++++++++++
 src/openvpn/manage.c     | 53 ++++++++++++++++++++++++++++++++++++++++
 src/openvpn/manage.h     |  4 ++-
 5 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index 0323a7f7..e5ac8098 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -4,6 +4,11 @@ Overview of changes in 2.6
 
 New features
 ------------
+New management commands to enumerate and list remote entries
+    Use ``remote-entry-count`` and ``remote-entry-get index``
+    commands from the management interface to get the number of
+    remote entries and the entry at index respectively.
+
 Keying Material Exporters (RFC 5705) based key generation
     As part of the cipher negotiation OpenVPN will automatically prefer
     the RFC5705 based key material generation to the current custom
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 84e3d04b..f7a0fe1f 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -897,6 +897,28 @@ the 10.0.0.0/8 netblock is allowed: 10.10.0.1.  Also, the client
 may not interact with external IP addresses using an "unknown"
 protocol (i.e. one that is not IPv4 or ARP).
 
+COMMAND -- remote-entry-count (OpenVPN 2.6+ management version > 3)
+-------------------------------------------------------------------
+
+Retrieve available number of remote host/port entries
+
+Example:
+
+     remote-entry-count
+     >REMOTE-ENTRY-COUNT:5
+
+COMMAND -- remote-entry-get  (OpenVPN 2.6+ management version > 3)
+------------------------------------------------------------------
+
+Retrieve remote entry (host, port and protocol) by index.
+
+Example:
+
+     remote-entgry-get 1
+     REMOTE-ENTRY:1,vpn.example.com,1194,udp
+
+The protocol could be tcp-client or udp on client.
+
 COMMAND -- remote  (OpenVPN AS 2.1.5/OpenVPN 2.3 or higher)
 --------------------------------------------
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 386aee23..7c550b6a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -330,6 +330,47 @@ management_callback_send_cc_message(void *arg,
     return status;
 }
 
+static unsigned int
+management_callback_remote_entry_count(void *arg)
+{
+    struct context *c = (struct context *) arg;
+    struct connection_list *l = c->options.connection_list;
+
+    return l->len;
+}
+
+static bool
+management_callback_remote_entry_get(void *arg, unsigned int index, char **remote)
+{
+    assert(arg);
+    assert(remote);
+
+    struct context *c = (struct context *) arg;
+    struct connection_list *l = c->options.connection_list;
+    bool ret = true;
+
+    if (index < l->len)
+    {
+        struct connection_entry *ce = l->array[index];
+        const char *proto = proto2ascii(ce->proto, ce->af, false);
+
+        /* space for output including 2 commas and a nul */
+        int len = strlen(ce->remote) + strlen(ce->remote_port) + strlen(proto) + 2 + 1;
+        char *out = malloc(len);
+        check_malloc_return(out);
+
+        openvpn_snprintf(out, len, "%s,%s,%s", ce->remote, ce->remote_port, proto);
+        *remote = out;
+    }
+    else
+    {
+        ret = false;
+        msg(M_WARN, "Out of bounds index in management query for remote entry: index = %u", index);
+    }
+
+    return ret;
+}
+
 static bool
 management_callback_remote_cmd(void *arg, const char **p)
 {
@@ -3944,6 +3985,8 @@ init_management_callback_p2p(struct context *c)
 #ifdef TARGET_ANDROID
         cb.network_change = management_callback_network_change;
 #endif
+        cb.remote_entry_count = management_callback_remote_entry_count;
+        cb.remote_entry_get = management_callback_remote_entry_get;
         management_set_callback(management, &cb);
     }
 #endif
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index f86c87f2..214ea4be 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -94,6 +94,8 @@ man_help(void)
     msg(M_CLIENT, "net                    : (Windows only) Show network info and routing table.");
     msg(M_CLIENT, "password type p        : Enter password p for a queried OpenVPN password.");
     msg(M_CLIENT, "remote type [host port] : Override remote directive, type=ACCEPT|MOD|SKIP.");
+    msg(M_CLIENT, "remote-entry-count     : Get number of available remote entries.");
+    msg(M_CLIENT, "remote-entry-get index : Get remote entry at index.");
     msg(M_CLIENT, "proxy type [host port flags] : Enter dynamic proxy server info.");
     msg(M_CLIENT, "pid                    : Show process ID of the current OpenVPN process.");
 #ifdef ENABLE_PKCS11
@@ -829,6 +831,46 @@ man_pkcs11_id_get(struct management *man, const int index)
 
 #endif /* ifdef ENABLE_PKCS11 */
 
+static void
+man_remote_entry_count(struct management *man)
+{
+    unsigned count = 0;
+    if (man->persist.callback.remote_entry_count)
+    {
+        count = (*man->persist.callback.remote_entry_count)(man->persist.callback.arg);
+        msg(M_CLIENT, ">REMOTE-ENTRY-COUNT:%u", count);
+    }
+    else
+    {
+        msg(M_CLIENT, "ERROR: The remote-entry-count command is not supported by the current daemon mode");
+    }
+}
+
+static void
+man_remote_entry_get(struct management *man, unsigned int index)
+{
+    char *remote = NULL;
+
+    if (man->persist.callback.remote_entry_get)
+    {
+        bool res = (*man->persist.callback.remote_entry_get)(man->persist.callback.arg, index, &remote);
+        if (res && remote)
+        {
+            msg(M_CLIENT, ">REMOTE-ENTRY:%u,%s", index, remote);
+        }
+        else
+        {
+            msg(M_CLIENT, ">REMOTE-ENTRY:%u", index);
+        }
+    }
+    else
+    {
+        msg(M_CLIENT, "ERROR: The remote-entry command is not supported by the current daemon mode");
+    }
+
+    free(remote);
+}
+
 static void
 man_hold(struct management *man, const char *cmd)
 {
@@ -1601,6 +1643,17 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
         }
     }
 #endif
+    else if (streq(p[0], "remote-entry-count"))
+    {
+        man_remote_entry_count(man);
+    }
+    else if (streq(p[0], "remote-entry-get"))
+    {
+        if (man_need(man, p, 1, 0))
+        {
+            man_remote_entry_get(man, atoi(p[1]));
+        }
+    }
     else if (streq(p[0], "proxy"))
     {
         if (man_need(man, p, 1, MN_AT_LEAST))
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 6d6f2fb1..5de0a7da 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -31,7 +31,7 @@
 #include "socket.h"
 #include "mroute.h"
 
-#define MANAGEMENT_VERSION                      3
+#define MANAGEMENT_VERSION                      4
 #define MANAGEMENT_N_PASSWORD_RETRIES           3
 #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE   100
 #define MANAGEMENT_ECHO_BUFFER_SIZE           100
@@ -186,6 +186,8 @@ struct management_callback
 #ifdef TARGET_ANDROID
     int (*network_change)(void *arg, bool samenetwork);
 #endif
+    unsigned int (*remote_entry_count)(void *arg);
+    bool (*remote_entry_get)(void *arg, unsigned int index, char **remote);
 };
 
 /*
-- 
2.20.1


