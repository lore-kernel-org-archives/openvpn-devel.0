From: selva.nair@...277...
Date: Mon, 22 Jan 2018 15:29:20 -0500
Message-Id: <1516652960-31891-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] A proposal to add management client version
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

RFC: only compile-tested

- Allow "version" command from client to management to set
  the version of management interface supported by the client
  by specifying an optional parameter.

  If no parameter is specified the current the version of OpenVPN
  and its management interface is returned (current behaviour).

  The client version defaults to 1 which is the current version of
  the Management Interface.

This will allow adding new features to the management interface without
breaking existing clients.

---
 doc/management-notes.txt |  6 +++++-
 src/openvpn/manage.c     | 17 ++++++++++++++++-
 src/openvpn/manage.h     |  4 +---
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index a9ba18a..e437966 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -430,8 +430,12 @@ Command examples:
 COMMAND -- version
 ------------------
 
-Show the current OpenVPN and Management Interface versions.
+Set the version of Management Interface supported by the client or
+show the current OpenVPN and Management Interface versions.
 
+Command examples:
+  version 1.1 -- Change management version of client to 1.1 (default = 1)
+  version     -- Show the version of OpenVPN and its Management Interface
 
 COMMAND -- auth-retry
 ---------------------
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 650f9e0..d695b76 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -123,7 +123,7 @@ man_help(void)
     msg(M_CLIENT, "test n                 : Produce n lines of output for testing/debugging.");
     msg(M_CLIENT, "username type u        : Enter username u for a queried OpenVPN username.");
     msg(M_CLIENT, "verb [n]               : Set log verbosity level to n, or show if n is absent.");
-    msg(M_CLIENT, "version                : Show current version number.");
+    msg(M_CLIENT, "version [x]            : Set client's version or show current version number of daemon.");
     msg(M_CLIENT, "END");
 }
 
@@ -1241,6 +1241,15 @@ man_network_change(struct management *man, bool samenetwork)
 #endif
 
 static void
+set_client_version(struct management *man, const char *version)
+{
+    if (version)
+    {
+        man->connection.client_version = strtof(version, NULL);
+    }
+}
+
+static void
 man_dispatch_command(struct management *man, struct status_output *so, const char **p, const int nparms)
 {
     struct gc_arena gc = gc_new();
@@ -1255,6 +1264,10 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
     {
         man_help();
     }
+    else if (streq(p[0], "version") && p[1])
+    {
+        set_client_version(man, p[1]);
+    }
     else if (streq(p[0], "version"))
     {
         msg(M_CLIENT, "OpenVPN Version: %s", title_string);
@@ -2508,6 +2521,8 @@ man_connection_init(struct management *man)
             man->connection.es = event_set_init(&maxevents, EVENT_METHOD_FAST);
         }
 
+        man->connection.client_version = 1; /* default version */
+
         /*
          * Listen/connect socket
          */
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 364488f..dc37b8c 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -311,13 +311,11 @@ struct man_connection {
     int up_query_mode;
     struct user_pass up_query;
 
 #ifdef MANAGMENT_EXTERNAL_KEY
     struct buffer_list *rsa_sig;
 #endif
 #ifdef TARGET_ANDROID
     int fdtosend;
     int lastfdreceived;
 #endif
+    float client_version;
 };
 
 struct management
-- 
2.1.4


