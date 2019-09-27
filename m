From: David Sommerseth <davids@...515...>
Date: Sat, 28 Sep 2019 00:45:34 +0200
Message-Id: <20190927224536.27480-2-davids@...515...>
In-Reply-To: <20190927224536.27480-1-davids@...515...>
References: <20190927224536.27480-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH 1/3] auth-token: Fix building with
 --disable-server
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

The final patches of the auth-token hmac support patches had a typo in
the P2MP_SERVER fencing breaking --disable-server builds.  It used #if
instead of #ifdef.

While at it, also fix another missing P2MP_SERVER fencing causing the
compiler to complain about an unused variable in push.c

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/push.c       | 2 ++
 src/openvpn/ssl_common.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index dc1a536a..49b9d1be 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -39,7 +39,9 @@
 
 #if P2MP
 
+#ifdef P2MP_SERVER
 static char push_reply_cmd[] = "PUSH_REPLY";
+#endif
 
 /*
  * Auth username/password
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 406601bc..5e21009e 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -530,7 +530,7 @@ struct tls_multi
     time_t tas_last;
 #endif
 
-#if P2MP_SERVER
+#ifdef P2MP_SERVER
     /*
      * An error message to send to client on AUTH_FAILED
      */
-- 
2.17.1


