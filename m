From: Antonio Quartulli <a@...2181...>
Date: Sun,  7 Aug 2022 12:04:04 +0200
Message-Id: <20220807100404.8618-1-a@...2181...>
In-Reply-To: <20220624083809.23487-19-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 18/18] dco: turn supported ciphers list
 into a function
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
Cc: Antonio Quartulli <a@...2181...>, Lev Stipakov <lev@...515...>

Other platforms may need more complex logic to decide whether a cipher
is supported or not, therefore turn hardcoded list into a function that
can be implemented by each platform independently.

Signed-off-by: Lev Stipakov <lev@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* rebased
---
 src/openvpn/dco.c       |  4 ++--
 src/openvpn/dco.h       | 13 +++++++++++++
 src/openvpn/dco_linux.c |  6 ++++++
 src/openvpn/dco_linux.h |  1 -
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 09855643..889ae270 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -306,7 +306,7 @@ dco_check_option_conflict(int msglevel, const struct options *o)
 
     /* At this point the ciphers have already been normalised */
     if (o->enable_ncp_fallback
-        && !tls_item_in_cipher_list(o->ciphername, DCO_SUPPORTED_CIPHERS))
+        && !tls_item_in_cipher_list(o->ciphername, dco_get_supported_ciphers()))
     {
         msg(msglevel, "Note: --data-cipher-fallback with cipher '%s' "
             "disables data channel offload.", o->ciphername);
@@ -358,7 +358,7 @@ dco_check_option_conflict(int msglevel, const struct options *o)
     const char *token;
     while ((token = strsep(&tmp_ciphers, ":")))
     {
-        if (!tls_item_in_cipher_list(token, DCO_SUPPORTED_CIPHERS))
+        if (!tls_item_in_cipher_list(token, dco_get_supported_ciphers()))
         {
             msg(msglevel, "Note: cipher '%s' in --data-ciphers is not supported "
                 "by ovpn-dco, disabling data channel offload.", token);
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 72569083..6b5c016a 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -213,6 +213,13 @@ void dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
  */
 void dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi);
 
+/**
+ * Retrieve the list of ciphers supported by the current platform
+ *
+ * @return                   list of colon-separated ciphers
+ */
+const char *dco_get_supported_ciphers();
+
 #else /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -320,5 +327,11 @@ dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
 {
 }
 
+static inline const char *
+dco_get_supported_ciphers()
+{
+    return "";
+}
+
 #endif /* defined(ENABLE_DCO) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 5e77139a..f86ea819 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -931,4 +931,10 @@ dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
     }
 }
 
+const char *
+dco_get_supported_ciphers()
+{
+    return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
+}
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index e0e59fa6..416ea30a 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -34,7 +34,6 @@
 typedef enum ovpn_key_slot dco_key_slot_t;
 typedef enum ovpn_cipher_alg dco_cipher_t;
 
-#define DCO_SUPPORTED_CIPHERS "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305"
 
 typedef struct
 {
-- 
2.35.1


