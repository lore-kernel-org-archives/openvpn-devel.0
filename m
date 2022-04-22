From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 15:40:38 +0200
Message-Id: <20220422134038.3801239-10-arne@...1227...>
In-Reply-To: <20220422134038.3801239-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 09/28] Remove inc_pid argument from
 reliable_mark_deleted that is always true
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

This is a small cleanup to remove a superfluous argument
---
 src/openvpn/reliable.c | 7 ++-----
 src/openvpn/reliable.h | 2 +-
 src/openvpn/ssl.c      | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 274f937ab..2aae152bb 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -738,7 +738,7 @@ reliable_mark_active_outgoing(struct reliable *rel, struct buffer *buf, int opco
 
 /* delete a buffer previously activated by reliable_mark_active() */
 void
-reliable_mark_deleted(struct reliable *rel, struct buffer *buf, bool inc_pid)
+reliable_mark_deleted(struct reliable *rel, struct buffer *buf)
 {
     int i;
     for (i = 0; i < rel->size; ++i)
@@ -747,10 +747,7 @@ reliable_mark_deleted(struct reliable *rel, struct buffer *buf, bool inc_pid)
         if (buf == &e->buf)
         {
             e->active = false;
-            if (inc_pid)
-            {
-                rel->packet_id = e->packet_id + 1;
-            }
+            rel->packet_id = e->packet_id + 1;
             return;
         }
     }
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 05426fd8c..cf6de0506 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -367,7 +367,7 @@ struct buffer *reliable_get_buf_sequenced(struct reliable *rel);
  * @param inc_pid If true, the reliable structure's packet ID counter
  *     will be incremented.
  */
-void reliable_mark_deleted(struct reliable *rel, struct buffer *buf, bool inc_pid);
+void reliable_mark_deleted(struct reliable *rel, struct buffer *buf);
 
 /** @} name Functions for extracting incoming packets */
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cdf3e31da..6669c4719 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2610,7 +2610,7 @@ tls_process(struct tls_multi *multi,
             }
             if (status == 1)
             {
-                reliable_mark_deleted(ks->rec_reliable, buf, true);
+                reliable_mark_deleted(ks->rec_reliable, buf);
                 state_change = true;
                 dmsg(D_TLS_DEBUG, "Incoming Ciphertext -> TLS");
             }
-- 
2.32.0 (Apple Git-132)


