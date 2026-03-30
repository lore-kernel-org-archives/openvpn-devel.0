From: Gert Doering <gert@...1296...>
Date: Mon, 30 Mar 2026 20:08:54 +0200
Message-ID: <20260330180900.16608-1-gert@...1296...>
In-Reply-To: <gerrit.1774477871000.Ib99f171fb69d51f2260b44edf8ebe21ac958f233@...2715...>
References: <gerrit.1774477871000.Ib99f171fb69d51f2260b44edf8ebe21ac958f233@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v11] management: add base64 multi-line input
 for passwords
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

A client declares MCV 5 support and sends a 'password <type>'
line, followed by as many lines (each up to 1024 bytes) as
needed, in base64 encoded format, terminated by 'END'.

This is useful when a password is a JIT-generated use-once
token.

Declare management version 6 for this feature.

Change-Id: Ib99f171fb69d51f2260b44edf8ebe21ac958f233
Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
Acked-by: Selva Nair <selva.nair@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1593
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1593
This mail reflects revision 11 of this Change.

Acked-by according to Gerrit (reflected above):
Selva Nair <selva.nair@...277...>

        
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 7da4aaf..1126468 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -326,6 +326,22 @@
   The escaping rules are the same as for the config file.
   See the "Command Parsing" section below for more info.
 
+  If the password is too long to fit in a single command line
+  (longer than 256 bytes), the management interface client should
+  use the multi-line base64 format instead.  This requires that
+  the management client has announced version >= 5 via the
+  "version" command:
+
+    password "Auth"
+    [BASE64_PASSWORD_LINE]
+    ...
+    END
+
+  In this format, the password is base64-encoded and split across
+  multiple lines, followed by END.  Each line can be at most 1024
+  bytes.  This is the same format used by pk-sig and certificate
+  commands. Requires OpenVPN management version >= 6.
+
   The PASSWORD real-time message type can also be used to
   indicate password or other types of authentication failure:
 
@@ -513,6 +529,7 @@
     >PK_SIGN:[base64]           -- version 2 or greater
     >PK_SIGN:[base64],[alg]     -- version 3 or greater
     >PASSWORD:Need 'Auth' username -- version 4 or greater
+    multiline password from client -- version 5 or greater
 
 COMMAND -- auth-retry
 ---------------------
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 6cab7db..c22a2a4 100644
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
@@ -68,6 +69,7 @@
     MCV_PKSIGN = 2,
     MCV_PKSIGN_ALG = 3,
     MCV_USERNAME_ONLY = 4,
+    MCV_MULTILINE_PASSWORD = 5,
 };
 
 struct management *management; /* GLOBAL */
@@ -105,6 +107,8 @@
     msg(M_CLIENT, "                         where action is reply string.");
     msg(M_CLIENT, "net                    : (Windows only) Show network info and routing table.");
     msg(M_CLIENT, "password type p        : Enter password p for a queried OpenVPN password.");
+    msg(M_CLIENT, "password type          : (version >=5) Enter password base64-encoded on");
+    msg(M_CLIENT, "                         subsequent lines followed by END.");
     msg(M_CLIENT, "remote type [host port] : Override remote directive, type=ACCEPT|MOD|SKIP.");
     msg(M_CLIENT, "remote-entry-count     : Get number of available remote entries.");
     msg(M_CLIENT, "remote-entry-get  i|all [j]: Get remote entry at index = i to to j-1 or all.");
@@ -1019,6 +1023,41 @@
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
+ * @param type          The type of password being entered (e.g. "Auth", "Private Key", etc)
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
@@ -1052,6 +1091,41 @@
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
+                                  OPENVPN_BASE64_LENGTH(USER_PASS_LEN) + 1024);
+            struct buffer *buf = buffer_list_peek(man->connection.in_extra);
+
+            if (buf && BLEN(buf) > 0)
+            {
+                if (OPENVPN_BASE64_DECODED_LENGTH(BLEN(buf)) >= USER_PASS_LEN)
+                {
+                    msg(M_CLIENT, "ERROR: password too long");
+                    buf_clear(buf);
+                    break;
+                }
+                int len = openvpn_base64_decode(BSTR(buf), decoded,
+                                                USER_PASS_LEN - 1);
+                if (len < 0)
+                {
+                    msg(M_CLIENT, "ERROR: could not base64-decode password");
+                    buf_clear(buf);
+                    break;
+                }
+                decoded[len] = '\0';
+                buf_clear(buf);
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
@@ -1598,9 +1672,20 @@
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
+            else if (man->connection.client_version >= MCV_MULTILINE_PASSWORD)
+            {
+                man_query_password_base64(man, p[1]);
+            }
+            else
+            {
+                msg(M_CLIENT, "ERROR: the 'password' command requires 2 parameters");
+            }
         }
     }
     else if (streq(p[0], "forget-passwords"))
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index e5ad23f..27d3b60 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -50,7 +50,7 @@
 #include "socket_util.h"
 #include "mroute.h"
 
-#define MANAGEMENT_VERSION                  5
+#define MANAGEMENT_VERSION                  6
 #define MANAGEMENT_N_PASSWORD_RETRIES       3
 #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE 100
 #define MANAGEMENT_ECHO_BUFFER_SIZE         100
@@ -297,6 +297,7 @@
 #define IEC_RSA_SIGN    3
 #define IEC_CERTIFICATE 4
 #define IEC_PK_SIGN     5
+#define IEC_PASSWORD    6
     int in_extra_cmd;
     struct buffer_list *in_extra;
     unsigned long in_extra_cid;

