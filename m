From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 18 Jul 2018 16:27:52 +0200
Message-ID: <1531924073-29243-3-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1531924073-29243-1-git-send-email-steffan.karger@...1435...>
References: <1531924073-29243-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Make second parameter to
 reliable_send_purge() const
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
Cc: Gert van Dijk <gert.vandijk@...1435...>, Steffan Karger <steffan.karger@...1435...>

From: Gert van Dijk <gert.vandijk@...1435...>

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/reliable.c | 2 +-
 src/openvpn/reliable.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index b62ab54..d295076 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -352,7 +352,7 @@ reliable_empty(const struct reliable *rel)
 
 /* del acknowledged items from send buf */
 void
-reliable_send_purge(struct reliable *rel, struct reliable_ack *ack)
+reliable_send_purge(struct reliable *rel, const struct reliable_ack *ack)
 {
     int i, j;
     for (i = 0; i < ack->len; ++i)
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 4d8fc37..688c65c 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -123,7 +123,7 @@ bool reliable_ack_read(struct reliable_ack *ack,
  * @param ack The acknowledgment structure containing received
  *     acknowledgments.
  */
-void reliable_send_purge(struct reliable *rel, struct reliable_ack *ack);
+void reliable_send_purge(struct reliable *rel, const struct reliable_ack *ack);
 
 /** @} name Functions for processing incoming acknowledgments */
 
-- 
2.7.4


