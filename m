From: Gert Doering <gert@...1296...>
Date: Sun, 18 May 2025 19:23:23 +0200
Message-ID: <20250518172329.21239-1-gert@...1296...>
In-Reply-To: <gerrit.1742977449000.Id9dbb4d3c550bd4c13f6ee97e67749686457d9fc@...2715...>
References: <gerrit.1742977449000.Id9dbb4d3c550bd4c13f6ee97e67749686457d9fc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Explicit-exit-notify and multisocket
 interaction
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

From: Gianmarco De Gregori <gianmarco@...2726...>

Check signals after timeout handling to avoid
unusual delay when using explicit-exit-notify.

Github: fixes OpenVPN/openvpn#702

Change-Id: Id9dbb4d3c550bd4c13f6ee97e67749686457d9fc
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/917
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a673ec1..8e2c4d4 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4265,13 +4265,13 @@
         {
             /* process the I/O which triggered select */
             multi_io_process_io(multi);
-            MULTI_CHECK_SIG(multi);
         }
         else if (status == 0)
         {
             multi_io_action(multi, NULL, TA_TIMEOUT, false);
         }
 
+        MULTI_CHECK_SIG(multi);
         perf_pop();
     }
 }

