From: selva.nair@...277...
Date: Tue,  7 Sep 2021 18:31:26 -0400
Message-Id: <20210907223126.8440-3-selva.nair@...277...>
In-Reply-To: <20210907223126.8440-1-selva.nair@...277...>
References: <20210825210232.22509-1-selva.nair@...277...>
 <20210907223126.8440-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 3/3] Use a template for "unsupported
 management commands" error
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

The message
"ERROR: The 'foo' commmand is not supported by current daemon mode"
is repeatedly used in manage.c. Move it to a function for uniformity
in messaging.

v3, v3: no change
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/manage.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index f2a51d6c..b75014c2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -447,6 +447,12 @@ man_signal(struct management *man, const char *name)
     }
 }
 
+static void
+man_command_unsupported(const char *command_name)
+{
+    msg(M_CLIENT, "ERROR: The '%s' command is not supported by the current daemon mode", command_name);
+}
+
 static void
 man_status(struct management *man, const int version, struct status_output *so)
 {
@@ -456,7 +462,7 @@ man_status(struct management *man, const int version, struct status_output *so)
     }
     else
     {
-        msg(M_CLIENT, "ERROR: The 'status' command is not supported by the current daemon mode");
+        man_command_unsupported("status");
     }
 }
 
@@ -572,7 +578,7 @@ man_kill(struct management *man, const char *victim)
     }
     else
     {
-        msg(M_CLIENT, "ERROR: The 'kill' command is not supported by the current daemon mode");
+        man_command_unsupported("kill");
     }
 
     gc_free(&gc);
@@ -777,7 +783,7 @@ man_net(struct management *man)
     }
     else
     {
-        msg(M_CLIENT, "ERROR: The 'net' command is not supported by the current daemon mode");
+        man_command_unsupported("net");
     }
 }
 
@@ -799,7 +805,7 @@ man_send_cc_message(struct management *man, const char *message, const char *par
     }
     else
     {
-        msg(M_CLIENT, "ERROR: This command is not supported by the current daemon mode");
+        man_command_unsupported("cr-repsonse");
     }
 }
 #ifdef ENABLE_PKCS11
@@ -843,7 +849,7 @@ man_remote_entry_count(struct management *man)
     }
     else
     {
-        msg(M_CLIENT, "ERROR: The remote-entry-count command is not supported by the current daemon mode");
+        man_command_unsupported("remote-entry-count");
     }
 }
 
@@ -884,7 +890,7 @@ man_remote_entry_get(struct management *man, const char *p1, const char *p2)
     }
     else
     {
-        msg(M_CLIENT, "ERROR: The remote-entry command is not supported by the current daemon mode");
+        man_command_unsupported("remote-entry-get");
     }
 }
 
@@ -973,7 +979,7 @@ in_extra_dispatch(struct management *man)
             }
             else
             {
-                msg(M_CLIENT, "ERROR: The client-auth command is not supported by the current daemon mode");
+                man_command_unsupported("client-auth");
             }
             break;
 
@@ -997,7 +1003,7 @@ in_extra_dispatch(struct management *man)
             }
             else
             {
-                msg(M_CLIENT, "ERROR: The client-pf command is not supported by the current daemon mode");
+                man_command_unsupported("client-pf");
             }
             break;
 
@@ -1082,7 +1088,7 @@ man_client_pending_auth(struct management *man, const char *cid_str,
         }
         else
         {
-            msg(M_CLIENT, "ERROR: The client-pending-auth command is not supported by the current daemon mode");
+            man_command_unsupported("client-pending-auth");
         }
     }
 }
@@ -1133,7 +1139,7 @@ man_client_deny(struct management *man, const char *cid_str, const char *kid_str
         }
         else
         {
-            msg(M_CLIENT, "ERROR: The client-deny command is not supported by the current daemon mode");
+            man_command_unsupported("client-deny");
         }
     }
 }
@@ -1158,7 +1164,7 @@ man_client_kill(struct management *man, const char *cid_str, const char *kill_ms
         }
         else
         {
-            msg(M_CLIENT, "ERROR: The client-kill command is not supported by the current daemon mode");
+            man_command_unsupported("client-kill");
         }
     }
 }
@@ -1173,7 +1179,7 @@ man_client_n_clients(struct management *man)
     }
     else
     {
-        msg(M_CLIENT, "ERROR: The nclients command is not supported by the current daemon mode");
+        man_command_unsupported("nclients");
     }
 }
 
@@ -1297,7 +1303,7 @@ man_proxy(struct management *man, const char **p)
     }
     else
     {
-        msg(M_CLIENT, "ERROR: The proxy command is not supported by the current daemon mode");
+        man_command_unsupported("proxy");
     }
 }
 
@@ -1318,7 +1324,7 @@ man_remote(struct management *man, const char **p)
     }
     else
     {
-        msg(M_CLIENT, "ERROR: The remote command is not supported by the current daemon mode");
+        man_command_unsupported("remote");
     }
 }
 
-- 
2.20.1


