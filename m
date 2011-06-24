From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:54:55 +0200
Message-ID: <1308909312-17824-3-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 11/28] Refactored to rand_bytes for
	OpenSSL-independency
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
 Makefile.am      |    7 +++++-
 crypto.c         |   11 +++++----
 crypto_backend.h |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 crypto_openssl.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++
 crypto_openssl.h |   37 ++++++++++++++++++++++++++++++++
 init.c           |    2 +-
 proxy.c          |    2 +-
 ssl.c            |    2 +-
 8 files changed, 166 insertions(+), 9 deletions(-)
 create mode 100644 crypto_backend.h
 create mode 100644 crypto_openssl.c
 create mode 100644 crypto_openssl.h

diff --git a/Makefile.am b/Makefile.am
index 32b40bb..aeba51c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -85,7 +85,7 @@ openvpn_SOURCES = \
 	clinat.c clinat.h \
 	common.h \
 	config-win32.h \
-	crypto.c crypto.h \
+	crypto.c crypto.h crypto_backend.h \
 	dhcp.c dhcp.h \
 	errlevel.h \
 	error.c error.h \
@@ -153,6 +153,11 @@ configure.h: Makefile
 	awk -f $(srcdir)/configure_h.awk config.h > $@
 	awk -f $(srcdir)/configure_log.awk config.log >> $@
 
+if USE_OPENSSL
+openvpn_SOURCES += \
+	crypto_openssl.c crypto_openssl.h
+endif
+
 dist-hook:
 	cd $(distdir) && for i in $(EXTRA_DIST) $(SUBDIRS) ; do find $$i -name .svn -type d -prune -exec rm -rf '{}' ';' ; rm -f `find $$i -type f | grep -E '(^|\/)\.?\#|\~$$|\.s?o$$'` ; done
 
diff --git a/crypto.c b/crypto.c
index 5cfc34a..68b8564 100644
--- a/crypto.c
+++ b/crypto.c
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -803,8 +804,8 @@ generate_key_random (struct key *key, const struct key_type *kt)
 	if (kt->digest && kt->hmac_length > 0 && kt->hmac_length <= hmac_len)
 	  hmac_len = kt->hmac_length;
       }
-    if (!RAND_bytes (key->cipher, cipher_len)
-	|| !RAND_bytes (key->hmac, hmac_len))
+    if (!rand_bytes (key->cipher, cipher_len)
+	|| !rand_bytes (key->hmac, hmac_len))
       msg (M_FATAL, "ERROR: Random number generator cannot obtain entropy for key generation");
 
     dmsg (D_SHOW_KEY_SOURCE, "Cipher source entropy: %s", format_hex (key->cipher, cipher_len, 0, &gc));
@@ -870,7 +871,7 @@ test_crypto (const struct crypto_options *co, struct frame* frame)
       ASSERT (buf_init (&src, 0));
       ASSERT (i <= src.capacity);
       src.len = i;
-      ASSERT (RAND_pseudo_bytes (BPTR (&src), BLEN (&src)));
+      ASSERT (rand_bytes (BPTR (&src), BLEN (&src)));
 
       /* copy source to input buf */
       buf = work;
@@ -1671,7 +1672,7 @@ prng_init (const char *md_name, const int nonce_secret_len_parm)
 	nonce_data = (uint8_t*) malloc (size);
 	check_malloc_return (nonce_data);
 #if 1 /* Must be 1 for real usage */
-	if (!RAND_bytes (nonce_data, size))
+	if (!rand_bytes (nonce_data, size))
 	  msg (M_FATAL, "ERROR: Random number generator cannot obtain entropy for PRNG");
 #else
 	/* Only for testing -- will cause a predictable PRNG sequence */
@@ -1716,7 +1717,7 @@ prng_bytes (uint8_t *output, int len)
 	}
     }
   else
-    RAND_bytes (output, len);
+    rand_bytes (output, len);
 }
 
 /* an analogue to the random() function, but use prng_bytes */
diff --git a/crypto_backend.h b/crypto_backend.h
new file mode 100644
index 0000000..9f8eb04
--- /dev/null
+++ b/crypto_backend.h
@@ -0,0 +1,61 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file Data Channel Cryptography SSL library-specific backend interface
+ */
+
+#ifndef CRYPTO_BACKEND_H_
+#define CRYPTO_BACKEND_H_
+
+#include "config.h"
+
+#ifdef USE_OPENSSL
+#include "crypto_openssl.h"
+#endif
+
+#include "basic.h"
+
+/*
+ *
+ * Random number functions, used in cases where we want
+ * reasonably strong cryptographic random number generation
+ * without depleting our entropy pool.  Used for random
+ * IV values and a number of other miscellaneous tasks.
+ *
+ */
+
+/**
+ * Wrapper for secure random number generator. Retrieves len bytes of random
+ * data, and places it in output.
+ *
+ * @param output	Output buffer
+ * @param len		Length of the output buffer, in bytes
+ *
+ * @return 		\c 1 on success, \c 0 on failure
+ */
+int rand_bytes (uint8_t *output, int len);
+
+#endif /* CRYPTO_BACKEND_H_ */
diff --git a/crypto_openssl.c b/crypto_openssl.c
new file mode 100644
index 0000000..cbe559a
--- /dev/null
+++ b/crypto_openssl.c
@@ -0,0 +1,53 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file Data Channel Cryptography OpenSSL-specific backend interface
+ */
+
+#include "syshead.h"
+
+#include "basic.h"
+#include "buffer.h"
+#include "integer.h"
+#include "crypto_backend.h"
+#include <openssl/objects.h>
+#include <openssl/evp.h>
+#include <openssl/des.h>
+
+/*
+ *
+ * Random number functions, used in cases where we want
+ * reasonably strong cryptographic random number generation
+ * without depleting our entropy pool.  Used for random
+ * IV values and a number of other miscellaneous tasks.
+ *
+ */
+
+int rand_bytes(uint8_t *output, int len)
+{
+  return RAND_bytes (output, len);
+}
+
diff --git a/crypto_openssl.h b/crypto_openssl.h
new file mode 100644
index 0000000..cae00b9
--- /dev/null
+++ b/crypto_openssl.h
@@ -0,0 +1,37 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file Data Channel Cryptography OpenSSL-specific backend interface
+ */
+
+#ifndef CRYPTO_OPENSSL_H_
+#define CRYPTO_OPENSSL_H_
+
+#include <openssl/evp.h>
+#include <openssl/hmac.h>
+#include <openssl/md5.h>
+
+#endif /* CRYPTO_OPENSSL_H_ */
diff --git a/init.c b/init.c
index 4a16fba..cb8dc42 100644
--- a/init.c
+++ b/init.c
@@ -664,7 +664,7 @@ init_static (void)
 #if 1
 	prng_bytes (rndbuf, sizeof (rndbuf));
 #else
-	ASSERT(RAND_bytes (rndbuf, sizeof (rndbuf)));
+	ASSERT(rand_bytes (rndbuf, sizeof (rndbuf)));
 #endif
 	printf ("[%d] %s\n", i, format_hex (rndbuf, sizeof (rndbuf), 0, &gc));
       }
diff --git a/proxy.c b/proxy.c
index fce64a1..7963673 100644
--- a/proxy.c
+++ b/proxy.c
@@ -745,7 +745,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 	      const char *opaque = get_pa_var("opaque", pa, &gc);
 
 	      /* generate a client nonce */
-	      ASSERT(RAND_bytes(cnonce_raw, sizeof(cnonce_raw)));
+	      ASSERT(rand_bytes(cnonce_raw, sizeof(cnonce_raw)));
 	      cnonce = make_base64_string2(cnonce_raw, sizeof(cnonce_raw), &gc);
 
 
diff --git a/ssl.c b/ssl.c
index 2260ccb..4477b54 100644
--- a/ssl.c
+++ b/ssl.c
@@ -3883,7 +3883,7 @@ random_bytes_to_buf (struct buffer *buf,
 		     uint8_t *out,
 		     int outlen)
 {
-  if (!RAND_bytes (out, outlen))
+  if (!rand_bytes (out, outlen))
     msg (M_FATAL, "ERROR: Random number generator cannot obtain entropy for key generation [SSL]");
   if (!buf_write (buf, out, outlen))
     return false;
-- 
1.7.4.1


