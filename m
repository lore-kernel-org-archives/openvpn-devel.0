From: selva.nair@...277...
Date: Wed, 11 Jan 2023 01:29:10 -0500
Message-Id: <20230111062910.1846688-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Include CE_DISABLED status of remote in
 "remote-entry-get" response
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

- The response to the management command "remote-entry-get" is
  amended to include the status of the remote entry. The status
  reads "disabled" if (ce->flag & DISABLED) is true, "enabled"
  otherwise.

- Update and correct the description of this option in
  management-notes.txt

  Example responses:
  In response to "remote-entry-get 0"

  0,vpn.example.com,udp,enabled
  END

  Or, in response to "remote-entry-get all"

  0,vpn.example.org,udp,enabled
  2,vpn.example.net,tcp-client,disabled
  1,vpn.example.com,udp,enabled
  END

This helps the management client to show only enabled remotes
to the user.
An alternative would require the  UI/GUI to have knowledge of
what makes the daemon set CE_DISABLED (--proto-force,
--htttp-proxy-override etc.).

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/management-notes.txt | 23 +++++++++++++----------
 src/openvpn/init.c       |  8 +++++---
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 6daa811a..34f301db 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -806,9 +806,12 @@ COMMAND -- remote-entry-get (OpenVPN 2.6+ management version > 3)
 
   remote-entry-get <start> [<end>]
 
-Retrieve remote entry (host, port and protocol) for index
-<start> or indices from <start> to <end>+1. Alternatively
-<start> = "all" retrieves all remote entries.
+Retrieve remote entry (host, port, protocol, and status) for index
+<start> or indices from <start> to <end>-1. Alternatively
+<start> = "all" retrieves all remote entries. The index is 0-based.
+If the entry is disabled due to protocol or proxy restrictions
+(i.e., ce->flag & CE_DISABLED == 1), the status is returned as "disabled",
+otherwise it reads "enabled" without quotes.
 
 Example 1:
 
@@ -818,8 +821,8 @@ Example 1:
 
   OpenVPN daemon responds with
 
-  1,vpn.example.com,1194,udp
-  END
+    1,vpn.example.com,1194,udp,enabled
+    END
 
 Example 2:
 
@@ -829,8 +832,8 @@ Example 2:
 
   OpenVPN daemon responds with
 
-    1,vpn.example.com,1194,udp
-    2,vpn.example.net,443,tcp-client
+    1,vpn.example.com,1194,udp,enabled
+    2,vpn.example.net,443,tcp-client,disabled
     END
 
 Example 3:
@@ -840,9 +843,9 @@ Example 3:
 
   OpenVPN daemon with 3 connection entries responds with
 
-    1,vpn.example.com,1194,udp
-    2,vpn.example.com,443,tcp-client
-    3,vpn.example.net,443,udp
+    0,vpn.example.com,1194,udp,enabled
+    1,vpn.example.com,443,tcp-client,enabled
+    2,vpn.example.net,443,udp,enabled
     END
 
 COMMAND -- remote  (OpenVPN AS 2.1.5/OpenVPN 2.3 or higher)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fc1943bc..c8651232 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -353,13 +353,15 @@ management_callback_remote_entry_get(void *arg, unsigned int index, char **remot
     {
         struct connection_entry *ce = l->array[index];
         const char *proto = proto2ascii(ce->proto, ce->af, false);
+        const char *status = (ce->flags & CE_DISABLED) ? "disabled" : "enabled";
 
-        /* space for output including 2 commas and a nul */
-        int len = strlen(ce->remote) + strlen(ce->remote_port) + strlen(proto) + 2 + 1;
+        /* space for output including 3 commas and a nul */
+        int len = strlen(ce->remote) + strlen(ce->remote_port) + strlen(proto)
+                  + strlen(status) + 3 + 1;
         char *out = malloc(len);
         check_malloc_return(out);
 
-        openvpn_snprintf(out, len, "%s,%s,%s", ce->remote, ce->remote_port, proto);
+        openvpn_snprintf(out, len, "%s,%s,%s,%s", ce->remote, ce->remote_port, proto, status);
         *remote = out;
     }
     else
-- 
2.34.1


