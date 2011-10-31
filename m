From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 31 Oct 2011 16:29:14 +0100
Message-ID: <1320074961-3809-2-git-send-email-dejong@...1435...>
In-Reply-To: <1320074961-3809-1-git-send-email-dejong@...1435...>
References: <1320074961-3809-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/8] Moved prng_uninit out of
	crypto_uninit_lib
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

Since prng_uninit is SSL-library agnostic, but crypto_uninit_lib isn't, the function was moved up a level.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 crypto.c          |    1 +
 crypto_openssl.c  |    2 --
 crypto_polarssl.c |    1 -
 ssl.c             |    4 ++--
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/crypto.c b/crypto.c
index d17f706..375d35a 100644
--- a/crypto.c
+++ b/crypto.c
@@ -1388,6 +1388,7 @@ void
 free_ssl_lib (void)
 {
   crypto_uninit_lib ();
+  prng_uninit();
   EVP_cleanup ();
   ERR_free_strings ();
 }
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 9906479..db6b78e 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -277,8 +277,6 @@ crypto_uninit_lib (void)
       engine_initialized = false;
     }
 #endif
-
-  prng_uninit ();
 }
 
 void
diff --git a/crypto_polarssl.c b/crypto_polarssl.c
index 8119d58..e7470d5 100644
--- a/crypto_polarssl.c
+++ b/crypto_polarssl.c
@@ -69,7 +69,6 @@ crypto_init_lib (void)
 void
 crypto_uninit_lib (void)
 {
-  prng_uninit();
 }
 
 void
diff --git a/ssl.c b/ssl.c
index 30f6eb2..955a0d1 100644
--- a/ssl.c
+++ b/ssl.c
@@ -162,7 +162,8 @@ void
 free_ssl_lib ()
 {
   crypto_uninit_lib ();
-
+  prng_uninit();
+  
   tls_free_lib();
 }
 
@@ -1168,7 +1169,6 @@ tls1_P_hash(const md_kt_t *md_kt,
 {
   struct gc_arena gc = gc_new ();
   int chunk,n;
-  unsigned int j;
   hmac_ctx_t ctx;
   hmac_ctx_t ctx_tmp;
   uint8_t A1[MAX_HMAC_KEY_LENGTH];
-- 
1.7.5.4


