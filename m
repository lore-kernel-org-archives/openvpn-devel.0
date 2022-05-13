From: Heiko Hund <heiko@...2662...>
Date: Fri, 13 May 2022 11:37:40 +0200
Message-Id: <20220513093740.1091639-1-heiko@...2662...>
In-Reply-To: <20220512231105.1076835-1-heiko@...2662...>
References: <20220512231105.1076835-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] signal --dns support in peer info
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

Have clients set a bit in IV_PROTO, so that servers can make an informed
decision on whether to push --dns to the client. While unknown options
are ignored by clients when pushed, they generate a warning in the log.
That can be circumvented by server backends by checking if bit 7 is set.

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 src/openvpn/ssl.c | 3 +++
 src/openvpn/ssl.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 61dea996..24d7f3f4 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1940,6 +1940,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         /* support for P_DATA_V2 */
         int iv_proto = IV_PROTO_DATA_V2;
 
+        /* support for the --dns option */
+        iv_proto |= IV_PROTO_DNS_OPTION;
+
         /* support for receiving push_reply before sending
          * push request, also signal that the client wants
          * to get push-reply messages without without requiring a round
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 0ba86d3e..c8802707 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -93,6 +93,9 @@
  * result. */
 #define IV_PROTO_NCP_P2P         (1<<5)
 
+/** Supports the --dns option introduced in version 2.6 */
+#define IV_PROTO_DNS_OPTION      (1<<6)
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
 
-- 
2.32.0


