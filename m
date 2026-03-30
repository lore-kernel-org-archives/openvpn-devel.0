From: Gert Doering <gert@...1296...>
Date: Mon, 30 Mar 2026 13:38:19 +0200
Message-ID: <20260330113826.20057-1-gert@...1296...>
In-Reply-To: <gerrit.1769789455000.I2f6502da1832edcb273a0dfa9b3ef940bec2d711@...2715...>
References: <gerrit.1769789455000.I2f6502da1832edcb273a0dfa9b3ef940bec2d711@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v10] wfp_block: Avoid sign-compare warning
 with Fwpm* return types
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

FWP_E_ALREADY_EXISTS is explictly casted to HRESULT which
is LONG. But Fwpm* return DWORD. So if you compare an expected
result with the actual result you get an sign-compare warning...

Change-Id: I2f6502da1832edcb273a0dfa9b3ef940bec2d711
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1506
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1506
This mail reflects revision 10 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c
index 74d19ce..4d38fdb 100644
--- a/src/openvpn/wfp_block.c
+++ b/src/openvpn/wfp_block.c
@@ -131,11 +131,6 @@
     return err;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Block outgoing local traffic, possibly DNS only, except for
  * (i) adapter with the specified index (and loopback, if all is blocked)
@@ -198,7 +193,7 @@
        * do not treat "already exists" as an error */
         err = add_sublayer(OPENVPN_WFP_BLOCK_SUBLAYER);
 
-        if (err == FWP_E_ALREADY_EXISTS || err == ERROR_SUCCESS)
+        if (err == (DWORD)FWP_E_ALREADY_EXISTS || err == ERROR_SUCCESS)
         {
             msg_handler(0, "WFP Block: Added a persistent sublayer with pre-defined UUID");
         }
@@ -345,10 +340,6 @@
     return err;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 DWORD
 delete_wfp_block_filters(HANDLE engine_handle)
 {

