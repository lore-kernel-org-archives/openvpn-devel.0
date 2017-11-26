From: Steffan Karger <steffan@...1856...>
Date: Sun, 26 Nov 2017 15:15:54 +0100
Message-Id: <20171126141555.25930-2-steffan@...1856...>
In-Reply-To: <20171126141555.25930-1-steffan@...1856...>
References: <20171126141555.25930-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/3] Add support for TLS 1.3 in
 --tls-version-{min, max}
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

Tested with the current openssl master branch for TLS 1.3 support.

mbed TLS has no public builds with TLS 1.3 support yet, so nothing to do
there right now.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c         |  4 ++++
 src/openvpn/ssl_backend.h |  1 +
 src/openvpn/ssl_openssl.c | 10 +++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 843bc393..d61688c5 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -530,6 +530,10 @@ tls_version_parse(const char *vstr, const char *extra)
     {
         return TLS_VER_1_2;
     }
+    else if (!strcmp(vstr, "1.3") && TLS_VER_1_3 <= max_version)
+    {
+        return TLS_VER_1_3;
+    }
     else if (extra && !strcmp(extra, "or-highest"))
     {
         return max_version;
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index f588110c..7f6057e6 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -114,6 +114,7 @@ void tls_clear_error(void);
 #define TLS_VER_1_0     1
 #define TLS_VER_1_1     2
 #define TLS_VER_1_2     3
+#define TLS_VER_1_3     4
 int tls_version_parse(const char *vstr, const char *extra);
 
 /**
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b645b469..18c0ba5f 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -206,7 +206,9 @@ info_callback(INFO_CALLBACK_SSL_CONST SSL *s, int where, int ret)
 int
 tls_version_max(void)
 {
-#if defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
+#if defined(TLS1_3_VERSION)
+    return TLS_VER_1_3;
+#elif defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
     return TLS_VER_1_2;
 #elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
     return TLS_VER_1_1;
@@ -231,6 +233,12 @@ openssl_tls_version(int ver)
     {
         return TLS1_2_VERSION;
     }
+#if defined(TLS1_3_VERSION)
+    else if (ver == TLS_VER_1_3)
+    {
+        return TLS1_3_VERSION;
+    }
+#endif
     return 0;
 }
 
-- 
2.14.1


