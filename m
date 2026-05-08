From: Gert Doering <gert@...1296...>
Date: Fri,  8 May 2026 17:31:51 +0200
Message-ID: <20260508153156.13575-1-gert@...1296...>
In-Reply-To: <gerrit.1778239616000.I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2@...2715...>
References: <gerrit.1778239616000.I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] pool: Fix a potential NULL pointer
 de-reference in test code
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

From: Frank Lichtenheld <frank@...2641...>

Identified by cppcheck. Probably has been a long time
since that code has been compiled, though.

Change-Id: I09ebbf6f3555dd68ce8d75bfa844ecac518a0cf2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1676
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1676
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 15004c0..ff74e7c 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -757,7 +757,7 @@
             break;
         }
         msg(M_INFO | M_NOPREFIX, "IFCONFIG_POOL TEST pass 1: l=%s r=%s cn=%s",
-            print_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc), cn);
+            print_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc), cn ? cn : "[NULL]");
         array[i] = h;
     }
 
@@ -793,7 +793,7 @@
             break;
         }
         msg(M_INFO | M_NOPREFIX, "IFCONFIG_POOL TEST pass 3: l=%s r=%s cn=%s",
-            print_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc), cn);
+            print_in_addr_t(local, 0, &gc), print_in_addr_t(remote, 0, &gc), cn ? cn : "[NULL]");
         array[i] = h;
     }
 

