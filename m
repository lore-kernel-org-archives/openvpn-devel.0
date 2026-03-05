From: Gert Doering <gert@...1296...>
Date: Thu,  5 Mar 2026 09:46:04 +0100
Message-ID: <20260305084610.1038-1-gert@...1296...>
In-Reply-To: <gerrit.1769513463000.I03f4c640a2adbea9bbb6f6334f12375041ec429c@...2715...>
References: <gerrit.1769513463000.I03f4c640a2adbea9bbb6f6334f12375041ec429c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] openvpnserv: Improve sanity check for
 addr_len in HandleWINSConfigMessage
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

Handle the case where the int is negative
explicitly. Zero is probably a safer value
to assume in this case.

Change-Id: I03f4c640a2adbea9bbb6f6334f12375041ec429c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1496
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1496
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 227431a..09c709e 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1247,11 +1247,6 @@
     return err;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /**
  * Check for a valid search list in a certain key of the registry
  *
@@ -2944,7 +2939,11 @@
     int addr_len = msg->addr_len;
 
     /* sanity check */
-    if (addr_len > _countof(msg->addr))
+    if (addr_len < 0)
+    {
+        addr_len = 0;
+    }
+    if ((unsigned int)addr_len > _countof(msg->addr))
     {
         addr_len = _countof(msg->addr);
     }
@@ -3005,10 +3004,6 @@
     return err;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static DWORD
 HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
 {

