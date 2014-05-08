From: James Yonan <james@...515...>
Date: Thu,  8 May 2014 16:50:36 -0600
Message-Id: <1399589436-8730-7-git-send-email-james@...515...>
In-Reply-To: <1399589436-8730-1-git-send-email-james@...515...>
References: <1399589436-8730-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 6/6] Fixed some compile issues with
	show_library_versions()
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
Cc: James Yonan <james@...515...>

* Refactored show_library_versions to work around the fact
  that some compilers (such as MSVC 2008) can't handle #ifdefs
  inside of macro references.

* Declare show_library_versions() in options.h because it's
  referenced by other files such as openvpn.c.

* Declare get_ssl_library_version() as returning const char *,
  to avoid loss of const qualifier in ssl_openssl.c.

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/options.c      | 15 +++++++++------
 src/openvpn/options.h      |  2 ++
 src/openvpn/ssl_backend.h  |  2 +-
 src/openvpn/ssl_openssl.c  |  2 +-
 src/openvpn/ssl_polarssl.c |  2 +-
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 59d7895..8406822 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3439,18 +3439,21 @@ usage_small (void)
 void
 show_library_versions(const unsigned int flags)
 {
-  msg (flags, "library versions: %s%s%s",
 #ifdef ENABLE_SSL
-			get_ssl_library_version(),
+#define SSL_LIB_VER_STR get_ssl_library_version()
 #else
-			"",
+#define SSL_LIB_VER_STR ""
 #endif
 #ifdef ENABLE_LZO
-			", LZO ", lzo_version_string()
+#define LZO_LIB_VER_STR ", LZO ", lzo_version_string()
 #else
-			"", ""
+#define LZO_LIB_VER_STR "", ""
 #endif
-	);
+
+  msg (flags, "library versions: %s%s%s", SSL_LIB_VER_STR, LZO_LIB_VER_STR);
+
+#undef SSL_LIB_VER_STR
+#undef LZO_LIB_VER_STR
 }
 
 static void
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c6378d8..7bb61e0 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -685,6 +685,8 @@ void notnull (const char *arg, const char *description);
 
 void usage_small (void);
 
+void show_library_versions(const unsigned int flags);
+
 void init_options (struct options *o, const bool init_gc);
 void uninit_options (struct options *o);
 
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index b37b1e5..fc23175 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -472,6 +472,6 @@ void get_highest_preference_tls_cipher (char *buf, int size);
  * return a pointer to a static memory area containing the
  * name and version number of the SSL library in use
  */
-char * get_ssl_library_version(void);
+const char * get_ssl_library_version(void);
 
 #endif /* SSL_BACKEND_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d845fd7..e77b736 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1354,7 +1354,7 @@ get_highest_preference_tls_cipher (char *buf, int size)
   SSL_CTX_free (ctx);
 }
 
-char *
+const char *
 get_ssl_library_version(void)
 {
     return SSLeay_version(SSLEAY_VERSION);
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 0dfffd6..e3e3017 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -1068,7 +1068,7 @@ get_highest_preference_tls_cipher (char *buf, int size)
   strncpynt (buf, cipher_name, size);
 }
 
-char *
+const char *
 get_ssl_library_version(void)
 {
     static char polar_version[30];
-- 
1.8.5.5


