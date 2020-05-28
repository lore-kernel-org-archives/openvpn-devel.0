From: James Bottomley <James.Bottomley@...2316...>
Date: Thu, 28 May 2020 15:59:19 -0700
Message-Id: <20200528225920.6983-3-James.Bottomley@...2316...>
In-Reply-To: <20200528225920.6983-1-James.Bottomley@...2316...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6 2/3] crypto_openssl: add initialization
 to pick up local configuration
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

The test programme for the new openssl engine code requires overriding
the system default configuration file to point to the location of the
test engine.  Add an initialization stanza that makes this behaviour
universal, so now anyone running openvpn configured with openssl can
specify their own configuration file with the OPENSSL_CONF environment
variable.

Signed-off-by: James Bottomley <James.Bottomley@...2316...>
---
 src/openvpn/crypto_openssl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 4ac77fde..fd57edd2 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -149,6 +149,11 @@ crypto_init_lib_engine(const char *engine_name)
 void
 crypto_init_lib(void)
 {
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
+    OPENSSL_init_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);
+#else
+    OPENSSL_config(NULL);
+#endif
     /*
      * If you build the OpenSSL library and OpenVPN with
      * CRYPTO_MDEBUG, you will get a listing of OpenSSL
-- 
2.26.2


