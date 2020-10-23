From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 14:02:54 +0200
Message-Id: <20201023120259.29783-2-arne@...1227...>
In-Reply-To: <20201023120259.29783-1-arne@...1227...>
References: <20201023113244.26295-1-arne@...1227...>
 <20201023120259.29783-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/8] Add more documentation about our
 internal TLS functions
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
 src/openvpn/ssl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 618cc9cc..98ce38f9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1109,7 +1109,10 @@ tls_session_init(struct tls_multi *multi, struct tls_session *session)
  * @param session      - A pointer to the \c tls_session structure to be
  *                       cleaned up.
  * @param clear        - Whether the memory allocated for the \a session
- *                       object should be overwritten with 0s.
+ *                       object should be overwritten with 0s. This
+ *                       implicitly sets many states to 0/false,
+ *                       e.g. the validity of the keys in the structure
+ *
  */
 static void
 tls_session_free(struct tls_session *session, bool clear)
@@ -1118,6 +1121,9 @@ tls_session_free(struct tls_session *session, bool clear)
 
     for (size_t i = 0; i < KS_SIZE; ++i)
     {
+        /* we don't need clear=true for this call since
+         * the structs are part of session and get cleared
+         * as part of session */
         key_state_free(&session->key[i], false);
     }
 
-- 
2.26.2


