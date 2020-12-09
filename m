From: Arne Schwabe <arne@...1227...>
Date: Wed,  9 Dec 2020 15:20:45 +0100
Message-Id: <20201209142045.4489-3-arne@...1227...>
In-Reply-To: <20201209142045.4489-1-arne@...1227...>
References: <20201209142045.4489-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/3] Restore also ping related options on a
 reconnect
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

This fixes the issue that if a client reconnects the next connection
entries inherits the keepalive settings that were pushed or set by
the previous entry. Since UDP+PULL entries have an implicit 120s
timeout, this timeout also got applied to a TCP session after an
UDP entry.

Reported-By: Jan Just Keijser <janjust@...1147...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 9 +++++++++
 src/openvpn/options.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9ab2ead2..95201094 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3600,6 +3600,11 @@ pre_pull_save(struct options *o)
         o->pre_pull->ciphername = o->ciphername;
         o->pre_pull->authname = o->authname;
         o->pre_pull->keysize = o->keysize;
+
+        /* Ping related options should be reset to the config values on reconnect */
+        o->pre_pull->ping_rec_timeout = o->ping_rec_timeout;
+        o->pre_pull->ping_rec_timeout_action = o->ping_rec_timeout_action;
+        o->pre_pull->ping_send_timeout = o->ping_send_timeout;
     }
 
 }
@@ -3651,6 +3656,10 @@ pre_pull_restore(struct options *o, struct gc_arena *gc)
         o->ciphername = pp->ciphername;
         o->authname = pp->authname;
         o->keysize = pp->keysize;
+
+        o->ping_rec_timeout = pp->ping_rec_timeout;
+        o->ping_rec_timeout_action = pp->ping_rec_timeout_action;
+        o->ping_send_timeout = pp->ping_send_timeout;
     }
 
     o->push_continuation = 0;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index df0b4030..830ede47 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -79,6 +79,10 @@ struct options_pre_pull
     const char* authname;
     int keysize;
 
+    int ping_send_timeout;
+    int ping_rec_timeout;
+    int ping_rec_timeout_action;
+
     int foreign_option_index;
 };
 
-- 
2.26.2


