From: Gert Doering <gert@...1296...>
Date: Tue, 24 Feb 2026 22:30:30 +0100
Message-ID: <20260224213036.31845-1-gert@...1296...>
In-Reply-To: <gerrit.1771205254000.I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a@...2715...>
References: <gerrit.1771205254000.I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Fixup version command on management
 interface
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

All commands to the management interface are supposed to be
responded with either a one-line "SUCCESS:/ERROR:" message
or a multi-line reply terminated by "END". But, curently we
silently accept the "version n" command wih no response. This
causes clients like OpenVPN-GUI lock-up if version command is
used, waiting for ever for a reply.

Fix this by adding a SUCCESS response if client version
is set to a value >= 4. As the highest client version in use
until now is 3, this should not affect any work-arounds in
existing clients. ERROR response is generated if the version
parameter is null which never happens in practice.

Change-Id: I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1528
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1528
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 1a5c311..86b74f3 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -492,6 +492,10 @@
   version 2  -- Change management version of client to 2 (default = 1)
   version    -- Show the version of OpenVPN and its Management Interface
 
+Note: Until version 3, no response was generated when client sets its
+version. This was fixed starting version 4: clients should expect
+"SUCCESS: .. " message only when setting the version to >= 4.
+
 COMMAND -- auth-retry
 ---------------------
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 37ae6b3..03ff5b3 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1333,6 +1333,15 @@
     if (version)
     {
         man->connection.client_version = atoi(version);
+        /* Prior to version 3, we missed to respond to this command. Acknowledge only if version >= 4 */
+        if (man->connection.client_version >= 4)
+        {
+            msg(M_CLIENT, "SUCCESS: Management client version set to %d", man->connection.client_version);
+        }
+    }
+    else
+    {
+        msg(M_CLIENT, "ERROR: Invalid value specified for management client version");
     }
 }
 

