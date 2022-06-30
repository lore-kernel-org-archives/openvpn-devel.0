From: selva.nair@...277...
Date: Thu, 30 Jun 2022 15:05:49 -0400
Message-Id: <20220630190549.16675-3-selva.nair@...277...>
In-Reply-To: <20220630190549.16675-1-selva.nair@...277...>
References: <20220630190549.16675-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Log address of management client on
 accept
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

Currently when we are listening on the management
interface, the local address/port is logged as that of
the connecting client.

Fix it.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/manage.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 548d3b9a..7947c906 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1685,9 +1685,27 @@ man_new_connection_post(struct management *man, const char *description)
     }
     else
 #endif
-    msg(D_MANAGEMENT, "MANAGEMENT: %s %s",
-        description,
-        print_sockaddr(man->settings.local->ai_addr, &gc));
+    if (man->settings.flags & MF_CONNECT_AS_CLIENT)
+    {
+        msg(D_MANAGEMENT, "MANAGEMENT: %s %s",
+            description,
+            print_sockaddr(man->settings.local->ai_addr, &gc));
+    }
+    else
+    {
+        struct sockaddr_storage addr;
+        socklen_t addrlen = sizeof(addr);
+        if (!getpeername(man->connection.sd_cli, (struct sockaddr *) &addr,
+                         &addrlen))
+        {
+            msg(D_MANAGEMENT, "MANAGEMENT: %s %s", description,
+                print_sockaddr((struct sockaddr *) &addr, &gc));
+        }
+        else
+        {
+            msg(D_MANAGEMENT, "MANAGEMENT: %s %s", description, "unknown");
+        }
+    }
 
     buffer_list_reset(man->connection.out);
 
-- 
2.30.2


