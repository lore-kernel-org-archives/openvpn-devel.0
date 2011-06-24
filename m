From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:08 +0200
Message-ID: <1308909312-17824-16-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 24/28] Added PRNG doxygen
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
 crypto.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/crypto.h b/crypto.h
index 1f9eca9..2888021 100644
--- a/crypto.h
+++ b/crypto.h
@@ -407,10 +407,39 @@ void crypto_adjust_frame_parameters(struct frame *frame,
 				    bool packet_id,
 				    bool packet_id_long_form);
 
+
+/* Minimum length of the nonce used by the PRNG */
 #define NONCE_SECRET_LEN_MIN 16
+
+/* Maximum length of the nonce used by the PRNG */
 #define NONCE_SECRET_LEN_MAX 64
+
+/**
+ * Pseudo-random number generator initialisation.
+ * (see \c prng_rand_bytes())
+ *
+ * @param md_name			Name of the message digest to use
+ * @param nonce_secret_len_param	Length of the nonce to use
+ */
 void prng_init (const char *md_name, const int nonce_secret_len_parm);
+
+/*
+ * Message digest-based pseudo random number generator.
+ *
+ * If the PRNG was initialised with a certain message digest, uses the digest
+ * to calculate the next random number, and prevent depletion of the entropy
+ * pool.
+ *
+ * This PRNG is aimed at IV generation and similar miscellaneous tasks. Use
+ * \c rand_bytes() for higher-assurance functionality.
+ *
+ * Retrieves len bytes of pseudo random data, and places it in output.
+ *
+ * @param output	Output buffer
+ * @param len		Length of the output buffer
+ */
 void prng_bytes (uint8_t *output, int len);
+
 void prng_uninit ();
 
 void test_crypto (const struct crypto_options *co, struct frame* f);
-- 
1.7.4.1


