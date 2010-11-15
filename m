From: David Sommerseth <dazo@...384...>
Date: Mon, 15 Nov 2010 09:05:46 +0100
Message-Id: <1289808348-17463-6-git-send-email-dazo@...384...>
In-Reply-To: <1289808348-17463-1-git-send-email-dazo@...384...>
References: <1289808348-17463-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 4/6] Only add some functions when really
	needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

The GNU C compiler gave warnings about some functions not being used.
These functions where only used if certian #ifdef sections was enabled.

This patch encapsulates these function declarations with matching #ifdef's
to make it more clear when these functions are needed.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 options.c  |    2 ++
 reliable.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/options.c b/options.c
index f0b9310..d0cec7d 100644
--- a/options.c
+++ b/options.c
@@ -2785,6 +2785,7 @@ positive_atoi (const char *str)
   return i < 0 ? 0 : i;
 }
 
+#ifdef WIN32  /* This function is only used when compiling on Windows */
 static unsigned int
 atou (const char *str)
 {
@@ -2792,6 +2793,7 @@ atou (const char *str)
   sscanf (str, "%u", &val);
   return val;
 }
+#endif
 
 static inline bool
 space (unsigned char c)
diff --git a/reliable.c b/reliable.c
index a41f2bf..e68c236 100644
--- a/reliable.c
+++ b/reliable.c
@@ -516,6 +516,7 @@ reliable_can_send (const struct reliable *rel)
   return n_current > 0 && !rel->hold;
 }
 
+#ifdef EXPONENTIAL_BACKOFF
 /* return a unique point-in-time to trigger retry */
 static time_t
 reliable_unique_retry (struct reliable *rel, time_t retry)
@@ -535,6 +536,7 @@ reliable_unique_retry (struct reliable *rel, time_t retry)
     }
   return retry;
 }
+#endif
 
 /* return next buffer to send to remote */
 struct buffer *
-- 
1.7.2.3


