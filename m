From: Gert Doering <gert@...1296...>
Date: Fri, 19 Sep 2025 18:44:34 +0200
Message-ID: <20250919164440.23251-1-gert@...1296...>
In-Reply-To: <gerrit.1758297014000.Ic9912627b707bf4edd4fe4bfc37b8a639feaba08@...2715...>
References: <gerrit.1758297014000.Ic9912627b707bf4edd4fe4bfc37b8a639feaba08@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Rename Fox Crypto to Sentyron in
 copyright notices
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

From: Max Fillinger <maximilian.fillinger@...2918...>

Fox Crypto has been renamed to Sentyron on September 4th 2025.

See https://sentyron.com/press-release-foxcrypto-sentyron/ for the
announcement.

Change-Id: Ic9912627b707bf4edd4fe4bfc37b8a639feaba08
Signed-off-by: MaxF <max@...2606...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1047
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1047
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
index d19343f..15e7428 100755
--- a/dev-tools/update-copyright.sh
+++ b/dev-tools/update-copyright.sh
@@ -30,7 +30,7 @@
 
 # Only update Copyright lines with these owners
 # The 'or' operator is GNU sed specific, and must be \|
-UPDATE_COPYRIGHT_LINES="@openvpn\.net\|@fox-it\.com\|@sophos.com\|@eurephia\.org\|@greenie\.muc\.de\|@rozman.si\|@unstable\.cc\|@rfc2549.org\|@karger\.me\|selva.nair@"
+UPDATE_COPYRIGHT_LINES="@openvpn\.net\|@sentyron\.com\|@sophos.com\|@eurephia\.org\|@greenie\.muc\.de\|@rozman.si\|@unstable\.cc\|@rfc2549.org\|@karger\.me\|selva.nair@"
 COPY_YEAR="$1"
 
 cd "$(git rev-parse --show-toplevel)"
diff --git a/doc/doxygen/Makefile.am b/doc/doxygen/Makefile.am
index ec1045e..e0a52d0 100644
--- a/doc/doxygen/Makefile.am
+++ b/doc/doxygen/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2017-2021 Fox-IT B.V. <openvpn@...2507...>
+#  Copyright (C) 2017-2021 Sentyron B.V. <openvpn@...2918...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
index d5a1bd9..51ad7c0 100644
--- a/doc/doxygen/doc_compression.h
+++ b/doc/doxygen/doc_compression.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/doc_control_processor.h
index 03549e2..f265622 100644
--- a/doc/doxygen/doc_control_processor.h
+++ b/doc/doxygen/doc_control_processor.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_control_tls.h b/doc/doxygen/doc_control_tls.h
index c6bbfe6..07251c0 100644
--- a/doc/doxygen/doc_control_tls.h
+++ b/doc/doxygen/doc_control_tls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_data_control.h b/doc/doxygen/doc_data_control.h
index 010155b..91e49c4 100644
--- a/doc/doxygen/doc_data_control.h
+++ b/doc/doxygen/doc_data_control.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
index b2e50ab..64024a1 100644
--- a/doc/doxygen/doc_data_crypto.h
+++ b/doc/doxygen/doc_data_crypto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_eventloop.h b/doc/doxygen/doc_eventloop.h
index ec60afb..aa91166 100644
--- a/doc/doxygen/doc_eventloop.h
+++ b/doc/doxygen/doc_eventloop.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_external_multiplexer.h b/doc/doxygen/doc_external_multiplexer.h
index 15ae8bb..03a0bb4 100644
--- a/doc/doxygen/doc_external_multiplexer.h
+++ b/doc/doxygen/doc_external_multiplexer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_fragmentation.h b/doc/doxygen/doc_fragmentation.h
index 02d8cb2..8b0ccee 100644
--- a/doc/doxygen/doc_fragmentation.h
+++ b/doc/doxygen/doc_fragmentation.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_internal_multiplexer.h b/doc/doxygen/doc_internal_multiplexer.h
index 3da2df8..40ef32e 100644
--- a/doc/doxygen/doc_internal_multiplexer.h
+++ b/doc/doxygen/doc_internal_multiplexer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
index 766f433..1c67fa7 100644
--- a/doc/doxygen/doc_key_generation.h
+++ b/doc/doxygen/doc_key_generation.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_mainpage.h b/doc/doxygen/doc_mainpage.h
index 25fd40e..1ff8f7a 100644
--- a/doc/doxygen/doc_mainpage.h
+++ b/doc/doxygen/doc_mainpage.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_memory_management.h b/doc/doxygen/doc_memory_management.h
index 5e9a930..74a47ba 100644
--- a/doc/doxygen/doc_memory_management.h
+++ b/doc/doxygen/doc_memory_management.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
index a6e9369..3fb81c8 100644
--- a/doc/doxygen/doc_protocol_overview.h
+++ b/doc/doxygen/doc_protocol_overview.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_reliable.h b/doc/doxygen/doc_reliable.h
index e9a8b06..73200e3 100644
--- a/doc/doxygen/doc_reliable.h
+++ b/doc/doxygen/doc_reliable.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_tunnel_state.h b/doc/doxygen/doc_tunnel_state.h
index 04a48f3..f2f788e 100644
--- a/doc/doxygen/doc_tunnel_state.h
+++ b/doc/doxygen/doc_tunnel_state.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 0abcd7f..ec7da43 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index d69db59..72c6821 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index b74cb7f..4d6a96c 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 2423435..2bab312 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 80f1d16..71514fc 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 98fe37f..1f95fba 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 6218b39..d0421e8 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 62ed257..68096c4 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2023 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 143a3cf..6fd7390 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index cb4229e..fdc0c55 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 1492eef..5bb710a 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index caa0735..4010bcf 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 245aa8d..eaaa07c 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index a912747..23c01ab 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c17e608..9159b8c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *  Copyright (C) 2008-2025 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 976808d..ffcc7c4 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index da3e1e1..1c3c22e 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index a40f18d..de89d30 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 635b53c..338de83 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *  Copyright (C) 2006-2010, Brainspark B.V.
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 513a07e..0f85d96 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 51f7f92..958acea 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *  Copyright (C) 2008-2025 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index ed5d281..6edd074 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index aa1ac11..8c8b1e21 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 08a3d53..2c1f36d 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 6f85dca..7658f2d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index fdf6bb5..accf558 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 2bad3eb..ceaef3f 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 3588071..61f64af 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
index 0b2f2d2..d3217d2 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 0f257e2..9cd2418 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index 7577cb2..3c5cb29 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 2892199..737b556 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 87aa8d2..f6604ba 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/openvpn/mock_get_random.c
index 77db18e..4077afa 100644
--- a/tests/unit_tests/openvpn/mock_get_random.c
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2017-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2017-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index 69d2d1d..a2aa3f9 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
index 6dddf0b..c6321dc 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 0c5467e..a2a10ea 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 0cfb918..c86c19e 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h
index 2f2207a..da98531 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 5df1046..3f327c2 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index d623c3d..0eacbab 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index b6c612b..b5211cd 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 44d51fe..950ce26 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
+ *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2

