From: Gert Doering <gert@...1296...>
Date: Mon,  8 Dec 2025 18:03:13 +0100
Message-ID: <20251208170320.4696-1-gert@...1296...>
In-Reply-To: <gerrit.1765212547000.I999916f9561a638214b70cf43de78060e9e0e792@...2715...>
References: <gerrit.1765212547000.I999916f9561a638214b70cf43de78060e9e0e792@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] socket: Initialize struct in_addr_t in
 getaddr()
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

We have false-positive "‘addr’ may be used uninitialized"
warnings with MinGW 13.0.0 compiler. Work around them.

Change-Id: I999916f9561a638214b70cf43de78060e9e0e792
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1420
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1420
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 80c2895..3e90833 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -202,7 +202,7 @@
 getaddr(unsigned int flags, const char *hostname, int resolve_retry_seconds, bool *succeeded,
         struct signal_info *sig_info)
 {
-    in_addr_t addr;
+    in_addr_t addr = { 0 };
     int status;
 
     status = get_addr_generic(AF_INET, flags, hostname, &addr, NULL, resolve_retry_seconds,

