From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:35 +0200
Message-Id: <20220422142953.3805364-1-arne@...1227...>
In-Reply-To: <20220422134038.3801239-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 10/28] Remove EXPONENTIAL_BACKOFF define
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

We have EXPONENTIAL_BACKOFF as default forever (8c47de7, 2.1.1c,
2010). Remove the other code path that is dead code.
---
 src/openvpn/reliable.c | 5 -----
 src/openvpn/reliable.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 2aae152bb..d8711f7dc 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -602,14 +602,9 @@ reliable_send(struct reliable *rel, int *opcode)
     }
     if (best)
     {
-#ifdef EXPONENTIAL_BACKOFF
         /* exponential backoff */
         best->next_try = local_now + best->timeout;
         best->timeout *= 2;
-#else
-        /* constant timeout, no backoff */
-        best->next_try = local_now + best->timeout;
-#endif
         best->n_acks = 0;
         *opcode = best->opcode;
         dmsg(D_REL_DEBUG, "ACK reliable_send ID " packet_id_format " (size=%d to=%d)",
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index cf6de0506..b045410a7 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -41,8 +41,6 @@
  *  @{ */
 
 
-#define EXPONENTIAL_BACKOFF
-
 #define RELIABLE_ACK_SIZE 8     /**< The maximum number of packet IDs
                                  *   waiting to be acknowledged which can
                                  *   be stored in one \c reliable_ack
-- 
2.32.0 (Apple Git-132)


