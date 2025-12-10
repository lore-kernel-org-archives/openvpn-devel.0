From: Gert Doering <gert@...1296...>
Date: Wed, 10 Dec 2025 11:48:33 +0100
Message-ID: <20251210104839.8270-1-gert@...1296...>
In-Reply-To: <gerrit.1762271909000.Id0bb4c45d373437ab8dbaff7a311745f9b538cbf@...2715...>
References: <gerrit.1762271909000.Id0bb4c45d373437ab8dbaff7a311745f9b538cbf@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] mudp: fix unaligned 32-bit read when
 parsing peer ID
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

The code previously read a 32-bit value from a uint8_t
buffer using a direct cast and dereference.
This can cause unaligned memory access and undefined
behavior on architectures that do not support unaligned
reads, potentially leading to a one-packet crash.

Fix this by reading the bytes individually and
combining them manually.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)

Change-Id: Id0bb4c45d373437ab8dbaff7a311745f9b538cbf
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1348
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1348
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index b03e165..5de3af6 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -209,7 +209,7 @@
         /* make sure buffer has enough length to read opcode (1 byte) and peer-id (3 bytes) */
         if (v2)
         {
-            uint32_t peer_id = ntohl(*(uint32_t *)ptr) & 0xFFFFFF;
+            uint32_t peer_id = ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
             peer_id_disabled = (peer_id == MAX_PEER_ID);
 
             if (!peer_id_disabled && (peer_id < m->max_clients) && (m->instances[peer_id]))

