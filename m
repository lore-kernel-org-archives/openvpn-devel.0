From: Arne Schwabe <arne@...1227...>
Date: Thu,  9 Jul 2020 12:16:02 +0200
Message-Id: <20200709101603.11941-7-arne@...1227...>
In-Reply-To: <20200709101603.11941-1-arne@...1227...>
References: <20200709101603.11941-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 7/8] Removed unused definition
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
 src/openvpn/ssl.c | 5 +++--
 src/openvpn/ssl.h | 7 -------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 668bcbd9..4ee4c245 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1988,8 +1988,9 @@ tls_session_update_crypto_params(struct tls_session *session,
     }
     else
     {
-      /* Very hacky workaround and quick fix for our calculation
-       * not correct to avoid a regression */
+      /* Very hacky workaround and quick fix for frame calculation
+       * different when adjusting frame size when the original and new cipher
+       * are identical to avoid a regression with client without NCP */
         return tls_session_generate_data_channel_keys(session);
     }
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 2f6f7657..58a9b0d4 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -89,13 +89,6 @@
 #define TLS_MULTI_HORIZON 2     /* call tls_multi_process frequently for n seconds after
                                  * every packet sent/received action */
 
-/*
- * The SSL/TLS worker thread will wait at most this many seconds for the
- * interprocess communication pipe to the main thread to be ready to accept
- * writes.
- */
-#define TLS_MULTI_THREAD_SEND_TIMEOUT 5
-
 /* Interval that tls_multi_process should call tls_authentication_status */
 #define TLS_MULTI_AUTH_STATUS_INTERVAL 10
 
-- 
2.26.2


