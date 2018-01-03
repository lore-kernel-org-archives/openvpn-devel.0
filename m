From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 3 Jan 2018 10:40:48 +0100
Message-ID: <1514972448-7010-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] reliable: remove reliable_unique_retry()
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

This function has been in the code since 2005, and enabled since 2010, but
it's not clear why we'd want this behaviour.

Running some simple tests, where I simulate an server->client link of
1mbit with 30ms delay and 1% packet loss, and a client->server link of
200kbit, 200ms delay, I get the following connection setup times over
100 runs when pushing ~100kb of options (e.g. a lot of routes):

With reliable_unique_retry:    Mean: 14.9 s, Std dev: 9.1 s
Without reliable_unique_retry: Mean: 11.8 s, Std dev: 5.8 s

For more standard push sizes (~1kb), the effect is of course smaller:

With reliable_unique_retry:    Mean: 2.7 s, Std dev: 0.6 s
Without reliable_unique_retry: Mean: 2.6 s, Std dev: 0.7 s

This shows that this mechanism hurts performance under packet loss
conditions.  (Without packet loss, there are no retransmissions and this
has no influence, of course.)  Querying the openvpn collective memory
(read: James, David and Gert) did not yield any arguments to keep it.
James even mentioned that OpenVPN 3 doesn't include this mechanism.

So, improve our connection setup performance by removing some code :)

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/reliable.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 972af61..f484483 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -565,30 +565,6 @@ reliable_can_send(const struct reliable *rel)
     return n_current > 0 && !rel->hold;
 }
 
-#ifdef EXPONENTIAL_BACKOFF
-/* return a unique point-in-time to trigger retry */
-static time_t
-reliable_unique_retry(struct reliable *rel, time_t retry)
-{
-    int i;
-    while (true)
-    {
-        for (i = 0; i < rel->size; ++i)
-        {
-            struct reliable_entry *e = &rel->array[i];
-            if (e->active && e->next_try == retry)
-            {
-                goto again;
-            }
-        }
-        break;
-again:
-        ++retry;
-    }
-    return retry;
-}
-#endif /* ifdef EXPONENTIAL_BACKOFF */
-
 /* return next buffer to send to remote */
 struct buffer *
 reliable_send(struct reliable *rel, int *opcode)
@@ -612,7 +588,7 @@ reliable_send(struct reliable *rel, int *opcode)
     {
 #ifdef EXPONENTIAL_BACKOFF
         /* exponential backoff */
-        best->next_try = reliable_unique_retry(rel, local_now + best->timeout);
+        best->next_try = local_now + best->timeout;
         best->timeout *= 2;
 #else
         /* constant timeout, no backoff */
-- 
2.7.4


