From: Arne Schwabe <arne@...1227...>
Date: Thu,  9 Jul 2020 12:16:03 +0200
Message-Id: <20200709101603.11941-8-arne@...1227...>
In-Reply-To: <20200709101603.11941-1-arne@...1227...>
References: <20200709101603.11941-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 8/8] Code cleanup: remove superflous variable
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4ee4c245..54a23011 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1231,11 +1231,10 @@ lame_duck_must_die(const struct tls_session *session, interval_t *wakeup)
     const struct key_state *lame = &session->key[KS_LAME_DUCK];
     if (lame->state >= S_INITIAL)
     {
-        const time_t local_now = now;
         ASSERT(lame->must_die); /* a lame duck key must always have an expiration */
-        if (local_now < lame->must_die)
+        if (now < lame->must_die)
         {
-            compute_earliest_wakeup(wakeup, lame->must_die - local_now);
+            compute_earliest_wakeup(wakeup, lame->must_die - now);
             return false;
         }
         else
-- 
2.26.2


