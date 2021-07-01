From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Thu, 1 Jul 2021 19:14:58 +0200
Message-ID: <20210701171458.8897-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update Fox e-mail address in copyright
 notices
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

Replace openvpn@...1435... with openvpn@...2625...

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 doc/doxygen/Makefile.am                    | 2 +-
 doc/doxygen/doc_compression.h              | 2 +-
 doc/doxygen/doc_control_processor.h        | 2 +-
 doc/doxygen/doc_control_tls.h              | 2 +-
 doc/doxygen/doc_data_control.h             | 2 +-
 doc/doxygen/doc_data_crypto.h              | 2 +-
 doc/doxygen/doc_eventloop.h                | 2 +-
 doc/doxygen/doc_external_multiplexer.h     | 2 +-
 doc/doxygen/doc_fragmentation.h            | 2 +-
 doc/doxygen/doc_internal_multiplexer.h     | 2 +-
 doc/doxygen/doc_key_generation.h           | 2 +-
 doc/doxygen/doc_mainpage.h                 | 2 +-
 doc/doxygen/doc_memory_management.h        | 2 +-
 doc/doxygen/doc_protocol_overview.h        | 2 +-
 doc/doxygen/doc_reliable.h                 | 2 +-
 doc/doxygen/doc_tunnel_state.h             | 2 +-
 src/openvpn/crypto.c                       | 2 +-
 src/openvpn/crypto.h                       | 2 +-
 src/openvpn/crypto_backend.h               | 2 +-
 src/openvpn/crypto_mbedtls.c               | 2 +-
 src/openvpn/crypto_mbedtls.h               | 2 +-
 src/openvpn/crypto_openssl.c               | 2 +-
 src/openvpn/crypto_openssl.h               | 2 +-
 src/openvpn/openssl_compat.h               | 2 +-
 src/openvpn/pkcs11_backend.h               | 2 +-
 src/openvpn/pkcs11_mbedtls.c               | 2 +-
 src/openvpn/pkcs11_openssl.c               | 2 +-
 src/openvpn/ssl.c                          | 2 +-
 src/openvpn/ssl.h                          | 2 +-
 src/openvpn/ssl_backend.h                  | 2 +-
 src/openvpn/ssl_common.h                   | 2 +-
 src/openvpn/ssl_mbedtls.c                  | 2 +-
 src/openvpn/ssl_mbedtls.h                  | 2 +-
 src/openvpn/ssl_ncp.c                      | 2 +-
 src/openvpn/ssl_ncp.h                      | 2 +-
 src/openvpn/ssl_openssl.c                  | 2 +-
 src/openvpn/ssl_openssl.h                  | 2 +-
 src/openvpn/ssl_verify.c                   | 2 +-
 src/openvpn/ssl_verify.h                   | 2 +-
 src/openvpn/ssl_verify_backend.h           | 2 +-
 src/openvpn/ssl_verify_mbedtls.c           | 2 +-
 src/openvpn/ssl_verify_mbedtls.h           | 2 +-
 src/openvpn/ssl_verify_openssl.c           | 2 +-
 src/openvpn/ssl_verify_openssl.h           | 2 +-
 src/openvpn/tls_crypt.c                    | 2 +-
 src/openvpn/tls_crypt.h                    | 2 +-
 tests/unit_tests/openvpn/mock_get_random.c | 2 +-
 tests/unit_tests/openvpn/mock_msg.c        | 2 +-
 tests/unit_tests/openvpn/mock_msg.h        | 2 +-
 tests/unit_tests/openvpn/test_auth_token.c | 2 +-
 tests/unit_tests/openvpn/test_buffer.c     | 2 +-
 tests/unit_tests/openvpn/test_crypto.c     | 2 +-
 tests/unit_tests/openvpn/test_packet_id.c  | 2 +-
 tests/unit_tests/openvpn/test_tls_crypt.c  | 2 +-
 54 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/doc/doxygen/Makefile.am b/doc/doxygen/Makefile.am
index fe0eafc4..82d909dd 100644
--- a/doc/doxygen/Makefile.am
+++ b/doc/doxygen/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2017-2021 Fox-IT B.V. <openvpn@...1435...>
+#  Copyright (C) 2017-2021 Fox-IT B.V. <openvpn@...2507...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
index a6180913..f67eba35 100644
--- a/doc/doxygen/doc_compression.h
+++ b/doc/doxygen/doc_compression.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/doc_control_processor.h
index 58124789..3e9c5921 100644
--- a/doc/doxygen/doc_control_processor.h
+++ b/doc/doxygen/doc_control_processor.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_control_tls.h b/doc/doxygen/doc_control_tls.h
index e6988a1c..7ff5e996 100644
--- a/doc/doxygen/doc_control_tls.h
+++ b/doc/doxygen/doc_control_tls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_data_control.h b/doc/doxygen/doc_data_control.h
index 66d8c54e..ccb0117a 100644
--- a/doc/doxygen/doc_data_control.h
+++ b/doc/doxygen/doc_data_control.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
index ba989cf3..165ce44f 100644
--- a/doc/doxygen/doc_data_crypto.h
+++ b/doc/doxygen/doc_data_crypto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_eventloop.h b/doc/doxygen/doc_eventloop.h
index 67b7a954..48d0c500 100644
--- a/doc/doxygen/doc_eventloop.h
+++ b/doc/doxygen/doc_eventloop.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_external_multiplexer.h b/doc/doxygen/doc_external_multiplexer.h
index dee32cca..61b2d8fc 100644
--- a/doc/doxygen/doc_external_multiplexer.h
+++ b/doc/doxygen/doc_external_multiplexer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_fragmentation.h b/doc/doxygen/doc_fragmentation.h
index 5778f6f6..03b63101 100644
--- a/doc/doxygen/doc_fragmentation.h
+++ b/doc/doxygen/doc_fragmentation.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_internal_multiplexer.h b/doc/doxygen/doc_internal_multiplexer.h
index e17858b5..0085fbf5 100644
--- a/doc/doxygen/doc_internal_multiplexer.h
+++ b/doc/doxygen/doc_internal_multiplexer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
index 502719d8..d32f9d89 100644
--- a/doc/doxygen/doc_key_generation.h
+++ b/doc/doxygen/doc_key_generation.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_mainpage.h b/doc/doxygen/doc_mainpage.h
index 5bb77a48..7b1b80e8 100644
--- a/doc/doxygen/doc_mainpage.h
+++ b/doc/doxygen/doc_mainpage.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_memory_management.h b/doc/doxygen/doc_memory_management.h
index e52d56ae..27d9188d 100644
--- a/doc/doxygen/doc_memory_management.h
+++ b/doc/doxygen/doc_memory_management.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
index bab7de3e..f26ce3a3 100644
--- a/doc/doxygen/doc_protocol_overview.h
+++ b/doc/doxygen/doc_protocol_overview.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_reliable.h b/doc/doxygen/doc_reliable.h
index c89e3d58..57186999 100644
--- a/doc/doxygen/doc_reliable.h
+++ b/doc/doxygen/doc_reliable.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_tunnel_state.h b/doc/doxygen/doc_tunnel_state.h
index 6a00657d..cbc1fa27 100644
--- a/doc/doxygen/doc_tunnel_state.h
+++ b/doc/doxygen/doc_tunnel_state.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 96e00b72..b9c95225 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index d6b6fa30..759da4bf 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 9babb865..e9447f82 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 0ed2944d..c632849d 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index ba5f2977..019de01d 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 603c67b0..b55d32b2 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index ea3401aa..59a31aac 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index bcd6f226..ce8e2b36 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index 73cfddc4..eebfc559 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 60df78c1..3cfcacc2 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index d3095344..b29504b6 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3288628c..fbe43143 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *  Copyright (C) 2008-2021 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index e7178e70..933e0559 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index d288afaa..fe93263c 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 33ddaac1..6bfb4067 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 939ed033..265ea36f 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *  Copyright (C) 2006-2010, Brainspark B.V.
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index d2d448af..7e7d3fc8 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index c67ad355..5a5c7855 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *  Copyright (C) 2008-2021 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 3c130e00..3fa68e26 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 69691709..000da296 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index dcf98a35..2eeb716c 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 759b752d..bbb1878a 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 0a0a1915..11518d96 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index d011128c..ca04261e 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 50dfb265..68afd1f3 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
index bea9bbc6..6f2de99a 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index f85ece39..d1749569 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index d62a9925..70a9d503 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 2b262082..663f5e16 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index af97a75a..81d0a10e 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/openvpn/mock_get_random.c
index 3e864e59..d0d2574a 100644
--- a/tests/unit_tests/openvpn/mock_get_random.c
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2017-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2017-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index e252d9d2..3ede98c0 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
index 1ac05b9c..be5f2e51 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index c75b00d8..4030052e 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index bf0fe155..5e854c22 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index c33e8190..f4cc81a0 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index 88a2db97..a3d4db28 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index f0a65646..3e604d67 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
-- 
2.11.0


