From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:54:59 +0200
Message-ID: <1308909312-17824-7-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 15/28] Refactored SSL_clear_error()
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

---
 crypto.c         |    6 +++---
 crypto_backend.h |    2 ++
 crypto_openssl.c |    6 ++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/crypto.c b/crypto.c
index 409c298..bdb3b1d 100644
--- a/crypto.c
+++ b/crypto.c
@@ -191,8 +191,8 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
   gc_free (&gc);
   return;
 
- err:
-  ERR_clear_error ();
+err:
+  crypto_clear_error();
   buf->len = 0;
   gc_free (&gc);
   return;
@@ -363,7 +363,7 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
   return true;
 
  error_exit:
-  ERR_clear_error ();
+  crypto_clear_error();
   buf->len = 0;
   gc_free (&gc);
   return false;
diff --git a/crypto_backend.h b/crypto_backend.h
index b099f47..50eef7b 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -38,6 +38,8 @@
 
 #include "basic.h"
 
+void crypto_clear_error (void);
+
 void show_available_ciphers (void);
 
 void show_available_digests (void);
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 9edcf40..8e228ee 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -87,6 +87,12 @@ cipher_ok (const char* name)
 #endif
 
 void
+crypto_clear_error (void)
+{
+  ERR_clear_error ();
+}
+
+void
 show_available_ciphers ()
 {
   int nid;
-- 
1.7.4.1


