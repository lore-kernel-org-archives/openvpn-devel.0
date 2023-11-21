From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 21 Nov 2023 11:42:54 +0100
Message-Id: <20231121104254.15701-1-frank@...2641...>
In-Reply-To: <gerrit.1700480182000.I91f739f5cb43386b2ce767cf3603a76e6b93e216@...2715...>
References: <gerrit.1700480182000.I91f739f5cb43386b2ce767cf3603a76e6b93e216@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Introduce report_command_status helper
 function
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

From: Arne Schwabe <arne@...1227...>

Instead of repeating near identical code several times
in manage.c, use a small helper function instead.

Change-Id: I91f739f5cb43386b2ce767cf3603a76e6b93e216
Acked-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/450
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index feb62b2..3cf392a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -284,6 +284,24 @@
 #endif
 }
 
+
+/**
+ * Small function to report the success or failure of a command to
+ * the management interface
+ */
+static void
+report_command_status(const bool status, const char *command)
+{
+    if (status)
+    {
+        msg(M_CLIENT, "SUCCESS: %s command succeeded", command);
+    }
+    else
+    {
+        msg(M_CLIENT, "ERROR: %s command failed", command);
+    }
+}
+
 static void
 man_delete_unix_socket(struct management *man)
 {
@@ -974,14 +992,7 @@
                                         NULL,
                                         man->connection.in_extra);
                 man->connection.in_extra = NULL;
-                if (status)
-                {
-                    msg(M_CLIENT, "SUCCESS: client-auth command succeeded");
-                }
-                else
-                {
-                    msg(M_CLIENT, "ERROR: client-auth command failed");
-                }
+                report_command_status(status, "client_auth");
             }
             else
             {
@@ -1260,14 +1271,7 @@
     if (man->persist.callback.proxy_cmd)
     {
         const bool status = (*man->persist.callback.proxy_cmd)(man->persist.callback.arg, p);
-        if (status)
-        {
-            msg(M_CLIENT, "SUCCESS: proxy command succeeded");
-        }
-        else
-        {
-            msg(M_CLIENT, "ERROR: proxy command failed");
-        }
+        report_command_status(status, "proxy");
     }
     else
     {
@@ -1281,14 +1285,7 @@
     if (man->persist.callback.remote_cmd)
     {
         const bool status = (*man->persist.callback.remote_cmd)(man->persist.callback.arg, p);
-        if (status)
-        {
-            msg(M_CLIENT, "SUCCESS: remote command succeeded");
-        }
-        else
-        {
-            msg(M_CLIENT, "ERROR: remote command failed");
-        }
+        report_command_status(status, "remote");
     }
     else
     {

