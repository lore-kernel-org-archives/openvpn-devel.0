From: luca.boccassi@...277...
Date: Sun, 22 Mar 2026 01:44:48 +0000
Message-ID: <20260322014606.1415363-1-luca.boccassi@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] management: add multi-line base64 input for
 passwords
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

From: Luca Boccassi <luca.boccassi@...277...>

Allow management clients to send long passwords via the
usual multi-line base64 encoded protocol.

A client sends a 'password <type>' line, followed by
as many lines (each up to 1024 bytes) as needed, in base64
encoded format, terminated by 'END'.

This is useful when a password is a JIT-generated use-once
token.

Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
---
As suggested by:

https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/CAKuzo_gRotwfVONQSn-yj1otvUNocAeUZqX8YjkRhP_L9jfb7A%40mail.gmail.com/#msg59309940

I have kept the same keyword 'password'. Currently sending
'password <type>' without a third field results in an hard error,
so I hope this is ok, but can of course use a different token if
preferred/needed.

 doc/management-notes.txt | 14 ++++++++
 src/openvpn/manage.c     | 76 ++++++++++++++++++++++++++++++++++++++--
 src/openvpn/manage.h     |  1 +
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 41e2a914..dc5a71dc 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -313,6 +313,20 @@ COMMAND -- password and username
   The escaping rules are the same as for the config file.
   See the "Command Parsing" section below for more info.
 
+  If the password is too long to fit in a single command line
+  (longer than 256 bytes), the management interface client should
+  use the multi-line base64 format instead:
+
+    password "Auth"
+    [BASE64_PASSWORD_LINE]
+    ...
+    END
+
+  In this format, the password is base64-encoded and split across
+  multiple lines, followed by END.  Each line can be at most 1024
+  bytes.  This is the same format used by pk-sig and certificate
+  commands.
+
   The PASSWORD real-time message type can also be used to
   indicate password or other types of authentication failure:
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index df72f15f..a155d1fd 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -31,6 +31,7 @@
 #include "error.h"
 #include "fdmisc.h"
 #include "options.h"
+#include "base64.h"
 #include "sig.h"
 #include "event.h"
 #include "otime.h"
@@ -107,6 +108,8 @@ man_help(void)
     msg(M_CLIENT, "                         where action is reply string.");
     msg(M_CLIENT, "net                    : (Windows only) Show network info and routing table.");
     msg(M_CLIENT, "password type p        : Enter password p for a queried OpenVPN password.");
+    msg(M_CLIENT, "password type          : Enter password for a queried OpenVPN password");
+    msg(M_CLIENT, "                         base64-encoded on subsequent lines followed by END.");
     msg(M_CLIENT, "remote type [host port] : Override remote directive, type=ACCEPT|MOD|SKIP.");
     msg(M_CLIENT, "remote-entry-count     : Get number of available remote entries.");
     msg(M_CLIENT, "remote-entry-get  i|all [j]: Get remote entry at index = i to to j-1 or all.");
@@ -1012,6 +1015,41 @@ in_extra_reset(struct man_connection *mc, const int mode)
     }
 }
 
+/**
+ * Enter multi-line base64 mode for receiving a password that exceeds the
+ * single-line parameter size limit. The management client sends:
+ *
+ *  password TYPE
+ *  <base64-encoded password line 1>
+ *  <base64-encoded password line 2>
+ *  ...
+ *  END
+ *
+ * @param man           The management interface struct
+ * @param type          The type of password being entered (e.g. "Auth", "TLS-Auth", etc)
+ */
+static void
+man_query_password_base64(struct management *man, const char *type)
+{
+    const bool needed = ((man->connection.up_query_mode == UP_QUERY_PASS
+                          || man->connection.up_query_mode == UP_QUERY_USER_PASS)
+                         && man->connection.up_query_type);
+    if (!needed)
+    {
+        msg(M_CLIENT, "ERROR: no password is currently needed at this time");
+        return;
+    }
+    if (!man->connection.up_query_type || !streq(man->connection.up_query_type, type))
+    {
+        msg(M_CLIENT, "ERROR: password of type '%s' entered, but we need one of type '%s'",
+            type, man->connection.up_query_type);
+        return;
+    }
+    struct man_connection *mc = &man->connection;
+    mc->in_extra_cmd = IEC_PASSWORD;
+    in_extra_reset(mc, IER_NEW);
+}
+
 static void
 in_extra_dispatch(struct management *man)
 {
@@ -1045,6 +1083,33 @@ in_extra_dispatch(struct management *man)
             man->connection.ext_cert_input = man->connection.in_extra;
             man->connection.in_extra = NULL;
             return;
+
+        case IEC_PASSWORD:
+        {
+            char decoded[USER_PASS_LEN];
+            CLEAR(decoded);
+
+            buffer_list_aggregate(man->connection.in_extra,
+                                  OPENVPN_BASE64_LENGTH(USER_PASS_LEN));
+            struct buffer *buf = buffer_list_peek(man->connection.in_extra);
+
+            if (buf && BLEN(buf) > 0)
+            {
+                int len = openvpn_base64_decode(BSTR(buf), decoded,
+                                                USER_PASS_LEN - 1);
+                if (len < 0)
+                {
+                    msg(M_CLIENT, "ERROR: could not base64-decode password");
+                    break;
+                }
+                decoded[len] = '\0';
+            }
+
+            man_query_password(man, man->connection.up_query_type,
+                               decoded);
+            secure_memzero(decoded, sizeof(decoded));
+            break;
+        }
     }
     in_extra_reset(&man->connection, IER_RESET);
 }
@@ -1591,9 +1656,16 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
     }
     else if (streq(p[0], "password"))
     {
-        if (man_need(man, p, 2, 0))
+        if (man_need(man, p, 1, MN_AT_LEAST))
         {
-            man_query_password(man, p[1], p[2]);
+            if (p[2])
+            {
+                man_query_password(man, p[1], p[2]);
+            }
+            else
+            {
+                man_query_password_base64(man, p[1]);
+            }
         }
     }
     else if (streq(p[0], "forget-passwords"))
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 38f437f4..797021d3 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -296,6 +296,7 @@ struct man_connection
 #define IEC_RSA_SIGN    3
 #define IEC_CERTIFICATE 4
 #define IEC_PK_SIGN     5
+#define IEC_PASSWORD    6
     int in_extra_cmd;
     struct buffer_list *in_extra;
     unsigned long in_extra_cid;
-- 
2.47.3


