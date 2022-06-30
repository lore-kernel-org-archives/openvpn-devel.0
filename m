From: selva.nair@...277...
Date: Thu, 30 Jun 2022 15:05:47 -0400
Message-Id: <20220630190549.16675-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Log the actual management interface
 port in use
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

When the port is specified as zero, log the actual port
bound to, instead of 0.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/manage.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 50f162a3..21c7ccdd 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1830,8 +1830,22 @@ man_listen(struct management *man)
         }
         else
 #endif
-        msg(D_MANAGEMENT, "MANAGEMENT: TCP Socket listening on %s",
-            print_sockaddr(man->settings.local->ai_addr, &gc));
+        {
+            const struct sockaddr *man_addr = man->settings.local->ai_addr;
+            struct sockaddr_storage addr;
+            socklen_t addrlen = sizeof(addr);
+            if (!getsockname(man->connection.sd_top, (struct sockaddr *) &addr, &addrlen))
+            {
+                man_addr = (struct sockaddr *) &addr;
+            }
+            else
+            {
+                msg(M_WARN|M_ERRNO,
+                    "Failed to get the management socket address");
+            }
+            msg(D_MANAGEMENT, "MANAGEMENT: TCP Socket listening on %s",
+                print_sockaddr(man_addr, &gc));
+        }
     }
 
 #ifdef _WIN32
-- 
2.30.2


