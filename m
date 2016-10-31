From: David Sommerseth <davids@...515...>
Date: Tue,  1 Nov 2016 00:07:09 +0100
Message-Id: <1477955229-20164-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Fix builds with --disable-crypto
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

When building with --disable-crypto the P2MP_SERVER is not defined,
thus breaking one place where the struct options auth_token_generate
was provided with a default value.

Also remove a lot of compiler warnings from ssl_backend.h due to
various undefined structs when doing the same build type.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/options.c     | 5 +++--
 src/openvpn/ssl_backend.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f88e94d..be31ed3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -869,10 +869,11 @@ init_options (struct options *o, const bool init_gc)
 #ifdef ENABLE_PKCS11
   o->pkcs11_pin_cache_period = -1;
 #endif			/* ENABLE_PKCS11 */
-  o->auth_token_generate = false;
 
-/* tmp is only used in P2MP server context */
+/* P2MP server context features */
 #if P2MP_SERVER
+  o->auth_token_generate = false;
+
   /* Set default --tmp-dir */
 #ifdef WIN32
   /* On Windows, find temp dir via enviroment variables */
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 542c373..a61f03a 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -124,6 +124,8 @@ int tls_version_parse(const char *vstr, const char *extra);
  */
 int tls_version_max(void);
 
+#ifdef ENABLE_CRYPTO
+
 /**
  * Initialise a library-specific TLS context for a server.
  *
@@ -510,4 +512,5 @@ void get_highest_preference_tls_cipher (char *buf, int size);
  */
 const char * get_ssl_library_version(void);
 
+#endif /* ENABLE_CRYPTO */
 #endif /* SSL_BACKEND_H_ */
-- 
1.8.3.1


