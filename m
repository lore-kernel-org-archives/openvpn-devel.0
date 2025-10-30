From: Gert Doering <gert@...1296...>
Date: Thu, 30 Oct 2025 15:51:19 +0100
Message-ID: <20251030145124.2607-1-gert@...1296...>
In-Reply-To: <gerrit.1761703996000.Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043@...2715...>
References: <gerrit.1761703996000.Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] mudp/mtcp: Remove -Wconversion pragmas
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

These were implictly fixed by the fixes to
the hash API in commit
a69aac41c4b2ccff1084736c158d7cf8474be533.
("list: Make types of hash elements consistent")

Change-Id: Iacec5920cdc3e16aaf777f843ef1f4a00a6a9043
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1324
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1324
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 83edec6..81310a2 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -45,11 +45,6 @@
     unsigned int sock;
 };
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 struct multi_instance *
 multi_create_instance_tcp(struct multi_context *m, struct link_socket *sock)
 {
@@ -125,10 +120,6 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 multi_tcp_instance_specific_free(struct multi_instance *mi)
 {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index a373a6a..31134be 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -180,11 +180,6 @@
     return false;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Get a client instance based on real address.  If
  * the instance doesn't exist, create it while
@@ -315,10 +310,6 @@
     return mi;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Send a packet to UDP socket.
  */

