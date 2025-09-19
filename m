From: "MaxF (Code Review)" <gerrit@...515...>
Date: Fri, 19 Sep 2025 15:50:20 +0000
References: <gerrit.1758297014000.Ic9912627b707bf4edd4fe4bfc37b8a639feaba08@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <71134bfb88fa38fe22ccd2dbbfca6f3c09f60b52-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0Jp8uj0zgBc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename Fox Crypto to
 Sentyron in copyright notices
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0Jp8uj0zgBc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1047?usp=3Demail

to review the following change.


Change subject: Rename Fox Crypto to Sentyron in copyright notices
......................................................................

Rename Fox Crypto to Sentyron in copyright notices

Fox Crypto has been renamed to Sentyron on September 4th 2025.

See https://sentyron.com/press-release-foxcrypto-sentyron/ for the
announcement.

Change-Id: Ic9912627b707bf4edd4fe4bfc37b8a639feaba08
---
M dev-tools/update-copyright.sh
M doc/doxygen/Makefile.am
M doc/doxygen/doc_compression.h
M doc/doxygen/doc_control_processor.h
M doc/doxygen/doc_control_tls.h
M doc/doxygen/doc_data_control.h
M doc/doxygen/doc_data_crypto.h
M doc/doxygen/doc_eventloop.h
M doc/doxygen/doc_external_multiplexer.h
M doc/doxygen/doc_fragmentation.h
M doc/doxygen/doc_internal_multiplexer.h
M doc/doxygen/doc_key_generation.h
M doc/doxygen/doc_mainpage.h
M doc/doxygen/doc_memory_management.h
M doc/doxygen/doc_protocol_overview.h
M doc/doxygen/doc_reliable.h
M doc/doxygen/doc_tunnel_state.h
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls.h
M src/openvpn/crypto_openssl.c
M src/openvpn/crypto_openssl.h
M src/openvpn/mbedtls_compat.h
M src/openvpn/openssl_compat.h
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M src/openvpn/pkcs11_backend.h
M src/openvpn/pkcs11_mbedtls.c
M src/openvpn/pkcs11_openssl.c
M src/openvpn/ssl.c
M src/openvpn/ssl.h
M src/openvpn/ssl_backend.h
M src/openvpn/ssl_common.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_ncp.h
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_openssl.h
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify.h
M src/openvpn/ssl_verify_backend.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_mbedtls.h
M src/openvpn/ssl_verify_openssl.c
M src/openvpn/ssl_verify_openssl.h
M src/openvpn/tls_crypt.c
M src/openvpn/tls_crypt.h
M tests/unit_tests/openvpn/mock_get_random.c
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/mock_msg.h
M tests/unit_tests/openvpn/test_auth_token.c
M tests/unit_tests/openvpn/test_buffer.c
M tests/unit_tests/openvpn/test_common.h
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_packet_id.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_tls_crypt.c
60 files changed, 60 insertions(+), 60 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/1047/1

diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
index d19343f..15e7428 100755
--- a/dev-tools/update-copyright.sh
+++ b/dev-tools/update-copyright.sh
@@ -30,7 +30,7 @@

 # Only update Copyright lines with these owners
 # The 'or' operator is GNU sed specific, and must be \|
-UPDATE_COPYRIGHT_LINES=3D"@openvpn\.net\|@fox-it\.com\|@sophos.com\|@eurep=
hia\.org\|@greenie\.muc\.de\|@rozman.si\|@unstable\.cc\|@rfc2549.org\|@karg=
er\.me\|selva.nair@"
+UPDATE_COPYRIGHT_LINES=3D"@openvpn\.net\|@sentyron\.com\|@sophos.com\|@eur=
ephia\.org\|@greenie\.muc\.de\|@rozman.si\|@unstable\.cc\|@rfc2549.org\|@ka=
rger\.me\|selva.nair@"
 COPY_YEAR=3D"$1"

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

 MAINTAINERCLEANFILES =3D \
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
diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/doc_control_=
processor.h
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
diff --git a/doc/doxygen/doc_external_multiplexer.h b/doc/doxygen/doc_exter=
nal_multiplexer.h
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
diff --git a/doc/doxygen/doc_fragmentation.h b/doc/doxygen/doc_fragmentatio=
n.h
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
diff --git a/doc/doxygen/doc_internal_multiplexer.h b/doc/doxygen/doc_inter=
nal_multiplexer.h
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
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generat=
ion.h
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
diff --git a/doc/doxygen/doc_memory_management.h b/doc/doxygen/doc_memory_m=
anagement.h
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
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol=
_overview.h
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
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
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
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
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
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbed=
tls.h
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
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
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
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_open=
ssl.h
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
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/=
openvpn/mock_get_random.c
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
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn=
/mock_msg.c
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
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn=
/mock_msg.h
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
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/=
openvpn/test_auth_token.c
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
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
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
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/open=
vpn/test_common.h
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
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
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
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
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
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
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
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1047?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9912627b707bf4edd4fe4bfc37b8a639feaba08
Gerrit-Change-Number: 1047
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--0Jp8uj0zgBc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1047?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Rename Fox Crypto to Sentyron in copyright notices<br><br>Fo=
x Crypto has been renamed to Sentyron on September 4th 2025.<br><br>See htt=
ps://sentyron.com/press-release-foxcrypto-sentyron/ for the<br>announcement=
.<br><br>Change-Id: Ic9912627b707bf4edd4fe4bfc37b8a639feaba08<br>---<br>M d=
ev-tools/update-copyright.sh<br>M doc/doxygen/Makefile.am<br>M doc/doxygen/=
doc_compression.h<br>M doc/doxygen/doc_control_processor.h<br>M doc/doxygen=
/doc_control_tls.h<br>M doc/doxygen/doc_data_control.h<br>M doc/doxygen/doc=
_data_crypto.h<br>M doc/doxygen/doc_eventloop.h<br>M doc/doxygen/doc_extern=
al_multiplexer.h<br>M doc/doxygen/doc_fragmentation.h<br>M doc/doxygen/doc_=
internal_multiplexer.h<br>M doc/doxygen/doc_key_generation.h<br>M doc/doxyg=
en/doc_mainpage.h<br>M doc/doxygen/doc_memory_management.h<br>M doc/doxygen=
/doc_protocol_overview.h<br>M doc/doxygen/doc_reliable.h<br>M doc/doxygen/d=
oc_tunnel_state.h<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>M =
src/openvpn/crypto_backend.h<br>M src/openvpn/crypto_mbedtls.c<br>M src/ope=
nvpn/crypto_mbedtls.h<br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/cr=
ypto_openssl.h<br>M src/openvpn/mbedtls_compat.h<br>M src/openvpn/openssl_c=
ompat.h<br>M src/openvpn/options_util.c<br>M src/openvpn/options_util.h<br>=
M src/openvpn/pkcs11_backend.h<br>M src/openvpn/pkcs11_mbedtls.c<br>M src/o=
penvpn/pkcs11_openssl.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl.h<br>M =
src/openvpn/ssl_backend.h<br>M src/openvpn/ssl_common.h<br>M src/openvpn/ss=
l_mbedtls.c<br>M src/openvpn/ssl_mbedtls.h<br>M src/openvpn/ssl_ncp.c<br>M =
src/openvpn/ssl_ncp.h<br>M src/openvpn/ssl_openssl.c<br>M src/openvpn/ssl_o=
penssl.h<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/ssl_verify.h<br>M s=
rc/openvpn/ssl_verify_backend.h<br>M src/openvpn/ssl_verify_mbedtls.c<br>M =
src/openvpn/ssl_verify_mbedtls.h<br>M src/openvpn/ssl_verify_openssl.c<br>M=
 src/openvpn/ssl_verify_openssl.h<br>M src/openvpn/tls_crypt.c<br>M src/ope=
nvpn/tls_crypt.h<br>M tests/unit_tests/openvpn/mock_get_random.c<br>M tests=
/unit_tests/openvpn/mock_msg.c<br>M tests/unit_tests/openvpn/mock_msg.h<br>=
M tests/unit_tests/openvpn/test_auth_token.c<br>M tests/unit_tests/openvpn/=
test_buffer.c<br>M tests/unit_tests/openvpn/test_common.h<br>M tests/unit_t=
ests/openvpn/test_crypto.c<br>M tests/unit_tests/openvpn/test_packet_id.c<b=
r>M tests/unit_tests/openvpn/test_pkt.c<br>M tests/unit_tests/openvpn/test_=
tls_crypt.c<br>60 files changed, 60 insertions(+), 60 deletions(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/1047/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyrig=
ht.sh</span><br><span>index d19343f..15e7428 100755</span><br><span>--- a/d=
ev-tools/update-copyright.sh</span><br><span>+++ b/dev-tools/update-copyrig=
ht.sh</span><br><span>@@ -30,7 +30,7 @@</span><br><span> </span><br><span> =
# Only update Copyright lines with these owners</span><br><span> # The &#39=
;or&#39; operator is GNU sed specific, and must be \|</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-UPDATE_COPYRIGHT_LINES=3D&quot;@openvpn\.ne=
t\|@fox-it\.com\|@sophos.com\|@eurephia\.org\|@greenie\.muc\.de\|@rozman.si=
\|@unstable\.cc\|@rfc2549.org\|@karger\.me\|selva.nair@&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+UPDATE_COPYRIGHT_LINES=3D&quot;@o=
penvpn\.net\|@sentyron\.com\|@sophos.com\|@eurephia\.org\|@greenie\.muc\.de=
\|@rozman.si\|@unstable\.cc\|@rfc2549.org\|@karger\.me\|selva.nair@&quot;</=
span><br><span> COPY_YEAR=3D&quot;$1&quot;</span><br><span> </span><br><spa=
n> cd &quot;$(git rev-parse --show-toplevel)&quot;</span><br><span>diff --g=
it a/doc/doxygen/Makefile.am b/doc/doxygen/Makefile.am</span><br><span>inde=
x ec1045e..e0a52d0 100644</span><br><span>--- a/doc/doxygen/Makefile.am</sp=
an><br><span>+++ b/doc/doxygen/Makefile.am</span><br><span>@@ -5,7 +5,7 @@<=
/span><br><span> #             packet encryption, packet authentication, an=
d</span><br><span> #             packet compression.</span><br><span> #</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#  Copyright (C) 2017-202=
1 Fox-IT B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#  Copyright (C) 2017-2021 Sentyron B.V. &lt;openvpn@...220...=
..2918...&gt;</span><br><span> #</span><br><span> </span><br><span> MAINTAI=
NERCLEANFILES =3D \</span><br><span>diff --git a/doc/doxygen/doc_compressio=
n.h b/doc/doxygen/doc_compression.h</span><br><span>index d5a1bd9..51ad7c0 =
100644</span><br><span>--- a/doc/doxygen/doc_compression.h</span><br><span>=
+++ b/doc/doxygen/doc_compression.h</span><br><span>@@ -5,7 +5,7 @@</span><=
br><span>  *             packet encryption, packet authentication, and</spa=
n><br><span>  *             packet compression.</span><br><span>  *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 F=
ox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn=
@...2918...&gt;</span><br><span>  *</span><br><span>  *</span><br><span>  *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span>diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/=
doc_control_processor.h</span><br><span>index 03549e2..f265622 100644</span=
><br><span>--- a/doc/doxygen/doc_control_processor.h</span><br><span>+++ b/=
doc/doxygen/doc_control_processor.h</span><br><span>@@ -5,7 +5,7 @@</span><=
br><span>  *             packet encryption, packet authentication, and</spa=
n><br><span>  *             packet compression.</span><br><span>  *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 F=
ox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn=
@...2918...&gt;</span><br><span>  *</span><br><span>  *</span><br><span>  *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span>diff --git a/doc/doxygen/doc_control_tls.h b/doc/doxygen/doc_co=
ntrol_tls.h</span><br><span>index c6bbfe6..07251c0 100644</span><br><span>-=
-- a/doc/doxygen/doc_control_tls.h</span><br><span>+++ b/doc/doxygen/doc_co=
ntrol_tls.h</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *            =
 packet encryption, packet authentication, and</span><br><span>  *         =
    packet compression.</span><br><span>  *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openv=
pn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><b=
r><span>  *</span><br><span>  *</span><br><span>  *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span>diff --git a=
/doc/doxygen/doc_data_control.h b/doc/doxygen/doc_data_control.h</span><br>=
<span>index 010155b..91e49c4 100644</span><br><span>--- a/doc/doxygen/doc_d=
ata_control.h</span><br><span>+++ b/doc/doxygen/doc_data_control.h</span><b=
r><span>@@ -5,7 +5,7 @@</span><br><span>  *             packet encryption, =
packet authentication, and</span><br><span>  *             packet compressi=
on.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010=
-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><b=
r><span>  *</span><br><span>  *  This program is free software; you can red=
istribute it and/or modify</span><br><span>diff --git a/doc/doxygen/doc_dat=
a_crypto.h b/doc/doxygen/doc_data_crypto.h</span><br><span>index b2e50ab..6=
4024a1 100644</span><br><span>--- a/doc/doxygen/doc_data_crypto.h</span><br=
><span>+++ b/doc/doxygen/doc_data_crypto.h</span><br><span>@@ -5,7 +5,7 @@<=
/span><br><span>  *             packet encryption, packet authentication, a=
nd</span><br><span>  *             packet compression.</span><br><span>  *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010=
-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;=
openvpn@...2918...&gt;</span><br><span>  *</span><br><span>  *</span><br><s=
pan>  *  This program is free software; you can redistribute it and/or modi=
fy</span><br><span>diff --git a/doc/doxygen/doc_eventloop.h b/doc/doxygen/d=
oc_eventloop.h</span><br><span>index ec60afb..aa91166 100644</span><br><spa=
n>--- a/doc/doxygen/doc_eventloop.h</span><br><span>+++ b/doc/doxygen/doc_e=
ventloop.h</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *             =
packet encryption, packet authentication, and</span><br><span>  *          =
   packet compression.</span><br><span>  *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvp=
n@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br=
><span>  *</span><br><span>  *</span><br><span>  *  This program is free so=
ftware; you can redistribute it and/or modify</span><br><span>diff --git a/=
doc/doxygen/doc_external_multiplexer.h b/doc/doxygen/doc_external_multiplex=
er.h</span><br><span>index 15ae8bb..03a0bb4 100644</span><br><span>--- a/do=
c/doxygen/doc_external_multiplexer.h</span><br><span>+++ b/doc/doxygen/doc_=
external_multiplexer.h</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  * =
            packet encryption, packet authentication, and</span><br><span> =
 *             packet compression.</span><br><span>  *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V=
. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&g=
t;</span><br><span>  *</span><br><span>  *</span><br><span>  *  This progra=
m is free software; you can redistribute it and/or modify</span><br><span>d=
iff --git a/doc/doxygen/doc_fragmentation.h b/doc/doxygen/doc_fragmentation=
.h</span><br><span>index 02d8cb2..8b0ccee 100644</span><br><span>--- a/doc/=
doxygen/doc_fragmentation.h</span><br><span>+++ b/doc/doxygen/doc_fragmenta=
tion.h</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *             pack=
et encryption, packet authentication, and</span><br><span>  *             p=
acket compression.</span><br><span>  *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...1186...=
.2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Cop=
yright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><sp=
an>  *</span><br><span>  *</span><br><span>  *  This program is free softwa=
re; you can redistribute it and/or modify</span><br><span>diff --git a/doc/=
doxygen/doc_internal_multiplexer.h b/doc/doxygen/doc_internal_multiplexer.h=
</span><br><span>index 3da2df8..40ef32e 100644</span><br><span>--- a/doc/do=
xygen/doc_internal_multiplexer.h</span><br><span>+++ b/doc/doxygen/doc_inte=
rnal_multiplexer.h</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *     =
        packet encryption, packet authentication, and</span><br><span>  *  =
           packet compression.</span><br><span>  *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &l=
t;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</=
span><br><span>  *</span><br><span>  *</span><br><span>  *  This program is=
 free software; you can redistribute it and/or modify</span><br><span>diff =
--git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h=
</span><br><span>index 766f433..1c67fa7 100644</span><br><span>--- a/doc/do=
xygen/doc_key_generation.h</span><br><span>+++ b/doc/doxygen/doc_key_genera=
tion.h</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *             pack=
et encryption, packet authentication, and</span><br><span>  *             p=
acket compression.</span><br><span>  *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...1186...=
.2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Cop=
yright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><sp=
an>  *</span><br><span>  *</span><br><span>  *  This program is free softwa=
re; you can redistribute it and/or modify</span><br><span>diff --git a/doc/=
doxygen/doc_mainpage.h b/doc/doxygen/doc_mainpage.h</span><br><span>index 2=
5fd40e..1ff8f7a 100644</span><br><span>--- a/doc/doxygen/doc_mainpage.h</sp=
an><br><span>+++ b/doc/doxygen/doc_mainpage.h</span><br><span>@@ -5,7 +5,7 =
@@</span><br><span>  *             packet encryption, packet authentication=
, and</span><br><span>  *             packet compression.</span><br><span> =
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2=
010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V.=
 &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>  *</span><=
br><span>  *  This program is free software; you can redistribute it and/or=
 modify</span><br><span>diff --git a/doc/doxygen/doc_memory_management.h b/=
doc/doxygen/doc_memory_management.h</span><br><span>index 5e9a930..74a47ba =
100644</span><br><span>--- a/doc/doxygen/doc_memory_management.h</span><br>=
<span>+++ b/doc/doxygen/doc_memory_management.h</span><br><span>@@ -5,7 +5,=
7 @@</span><br><span>  *             packet encryption, packet authenticati=
on, and</span><br><span>  *             packet compression.</span><br><span=
>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C)=
 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V.=
 &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>  *</span><=
br><span>  *  This program is free software; you can redistribute it and/or=
 modify</span><br><span>diff --git a/doc/doxygen/doc_protocol_overview.h b/=
doc/doxygen/doc_protocol_overview.h</span><br><span>index a6e9369..3fb81c8 =
100644</span><br><span>--- a/doc/doxygen/doc_protocol_overview.h</span><br>=
<span>+++ b/doc/doxygen/doc_protocol_overview.h</span><br><span>@@ -5,7 +5,=
7 @@</span><br><span>  *             packet encryption, packet authenticati=
on, and</span><br><span>  *             packet compression.</span><br><span=
>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C)=
 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V.=
 &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>  *</span><=
br><span>  *  This program is free software; you can redistribute it and/or=
 modify</span><br><span>diff --git a/doc/doxygen/doc_reliable.h b/doc/doxyg=
en/doc_reliable.h</span><br><span>index e9a8b06..73200e3 100644</span><br><=
span>--- a/doc/doxygen/doc_reliable.h</span><br><span>+++ b/doc/doxygen/doc=
_reliable.h</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *            =
 packet encryption, packet authentication, and</span><br><span>  *         =
    packet compression.</span><br><span>  *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openv=
pn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><b=
r><span>  *</span><br><span>  *</span><br><span>  *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span>diff --git a=
/doc/doxygen/doc_tunnel_state.h b/doc/doxygen/doc_tunnel_state.h</span><br>=
<span>index 04a48f3..f2f788e 100644</span><br><span>--- a/doc/doxygen/doc_t=
unnel_state.h</span><br><span>+++ b/doc/doxygen/doc_tunnel_state.h</span><b=
r><span>@@ -5,7 +5,7 @@</span><br><span>  *             packet encryption, =
packet authentication, and</span><br><span>  *             packet compressi=
on.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010=
-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><b=
r><span>  *</span><br><span>  *  This program is free software; you can red=
istribute it and/or modify</span><br><span>diff --git a/src/openvpn/crypto.=
c b/src/openvpn/crypto.c</span><br><span>index 0abcd7f..ec7da43 100644</spa=
n><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/cr=
ypto.c</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *             pack=
et compression.</span><br><span>  *</span><br><span>  *  Copyright (C) 2002=
-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn=
@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br>=
<span>  *</span><br><span>  *  This program is free software; you can redis=
tribute it and/or modify</span><br><span>  *  it under the terms of the GNU=
 General Public License version 2</span><br><span>diff --git a/src/openvpn/=
crypto.h b/src/openvpn/crypto.h</span><br><span>index d69db59..72c6821 1006=
44</span><br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/ope=
nvpn/crypto.h</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *          =
   packet compression.</span><br><span>  *</span><br><span>  *  Copyright (=
C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;=
openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</sp=
an><br><span>  *</span><br><span>  *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span>  *  it under the terms of =
the GNU General Public License version 2</span><br><span>diff --git a/src/o=
penvpn/crypto_backend.h b/src/openvpn/crypto_backend.h</span><br><span>inde=
x b74cb7f..4d6a96c 100644</span><br><span>--- a/src/openvpn/crypto_backend.=
h</span><br><span>+++ b/src/openvpn/crypto_backend.h</span><br><span>@@ -6,=
7 +6,7 @@</span><br><span>  *             packet compression.</span><br><sp=
an>  *</span><br><span>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...220...=
..515...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyr=
ight (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Senty=
ron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>  *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span>  *  it under the terms of the GNU General Public License versi=
on 2</span><br><span>diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvp=
n/crypto_mbedtls.c</span><br><span>index 2423435..2bab312 100644</span><br>=
<span>--- a/src/openvpn/crypto_mbedtls.c</span><br><span>+++ b/src/openvpn/=
crypto_mbedtls.c</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *       =
      packet compression.</span><br><span>  *</span><br><span>  *  Copyrigh=
t (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V.=
 &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt=
;</span><br><span>  *</span><br><span>  *  This program is free software; y=
ou can redistribute it and/or modify</span><br><span>  *  it under the term=
s of the GNU General Public License version 2</span><br><span>diff --git a/=
src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h</span><br><span=
>index 80f1d16..71514fc 100644</span><br><span>--- a/src/openvpn/crypto_mbe=
dtls.h</span><br><span>+++ b/src/openvpn/crypto_mbedtls.h</span><br><span>@=
@ -6,7 +6,7 @@</span><br><span>  *             packet compression.</span><b=
r><span>  *</span><br><span>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sa=
les@...515...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 =
Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><spa=
n>  *  This program is free software; you can redistribute it and/or modify=
</span><br><span>  *  it under the terms of the GNU General Public License =
version 2</span><br><span>diff --git a/src/openvpn/crypto_openssl.c b/src/o=
penvpn/crypto_openssl.c</span><br><span>index 98fe37f..1f95fba 100644</span=
><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/ope=
nvpn/crypto_openssl.c</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *  =
           packet compression.</span><br><span>  *</span><br><span>  *  Cop=
yright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B=
.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...=
&gt;</span><br><span>  *</span><br><span>  *  This program is free software=
; you can redistribute it and/or modify</span><br><span>  *  it under the t=
erms of the GNU General Public License version 2</span><br><span>diff --git=
 a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h</span><br><s=
pan>index 6218b39..d0421e8 100644</span><br><span>--- a/src/openvpn/crypto_=
openssl.h</span><br><span>+++ b/src/openvpn/crypto_openssl.h</span><br><spa=
n>@@ -6,7 +6,7 @@</span><br><span>  *             packet compression.</span=
><br><span>  *</span><br><span>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt=
;sales@...515...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-20=
21 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><=
span>  *  This program is free software; you can redistribute it and/or mod=
ify</span><br><span>  *  it under the terms of the GNU General Public Licen=
se version 2</span><br><span>diff --git a/src/openvpn/mbedtls_compat.h b/sr=
c/openvpn/mbedtls_compat.h</span><br><span>index 62ed257..68096c4 100644</s=
pan><br><span>--- a/src/openvpn/mbedtls_compat.h</span><br><span>+++ b/src/=
openvpn/mbedtls_compat.h</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  =
*             packet encryption, packet authentication, and</span><br><span=
>  *             packet compression.</span><br><span>  *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2023 Fox Crypto B.V. &=
lt;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  Copyright (C) 2023 Sentyron B.V. &lt;openvpn@...2918...&gt;</span=
><br><span>  *</span><br><span>  *  This program is free software; you can =
redistribute it and/or modify</span><br><span>  *  it under the terms of th=
e GNU General Public License version 2</span><br><span>diff --git a/src/ope=
nvpn/openssl_compat.h b/src/openvpn/openssl_compat.h</span><br><span>index =
143a3cf..6fd7390 100644</span><br><span>--- a/src/openvpn/openssl_compat.h<=
/span><br><span>+++ b/src/openvpn/openssl_compat.h</span><br><span>@@ -6,7 =
+6,7 @@</span><br><span>  *             packet compression.</span><br><span=
>  *</span><br><span>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...493...=
515...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyrig=
ht (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyro=
n B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>  *  =
This program is free software; you can redistribute it and/or modify</span>=
<br><span>  *  it under the terms of the GNU General Public License version=
 2</span><br><span>diff --git a/src/openvpn/options_util.c b/src/openvpn/op=
tions_util.c</span><br><span>index cb4229e..fdc0c55 100644</span><br><span>=
--- a/src/openvpn/options_util.c</span><br><span>+++ b/src/openvpn/options_=
util.c</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *             pack=
et compression.</span><br><span>  *</span><br><span>  *  Copyright (C) 2002=
-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn=
@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br>=
<span>  *</span><br><span>  *  This program is free software; you can redis=
tribute it and/or modify</span><br><span>  *  it under the terms of the GNU=
 General Public License version 2</span><br><span>diff --git a/src/openvpn/=
options_util.h b/src/openvpn/options_util.h</span><br><span>index 1492eef..=
5bb710a 100644</span><br><span>--- a/src/openvpn/options_util.h</span><br><=
span>+++ b/src/openvpn/options_util.h</span><br><span>@@ -6,7 +6,7 @@</span=
><br><span>  *             packet compression.</span><br><span>  *</span><b=
r><span>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2=
021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;op=
envpn@...2918...&gt;</span><br><span>  *</span><br><span>  *  This program =
is free software; you can redistribute it and/or modify</span><br><span>  *=
  it under the terms of the GNU General Public License version 2</span><br>=
<span>diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backen=
d.h</span><br><span>index caa0735..4010bcf 100644</span><br><span>--- a/src=
/openvpn/pkcs11_backend.h</span><br><span>+++ b/src/openvpn/pkcs11_backend.=
h</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *             packet co=
mpression.</span><br><span>  *</span><br><span>  *  Copyright (C) 2002-2025=
 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...1665...=
507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyr=
ight (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span=
>  *</span><br><span>  *  This program is free software; you can redistribu=
te it and/or modify</span><br><span>  *  it under the terms of the GNU Gene=
ral Public License version 2</span><br><span>diff --git a/src/openvpn/pkcs1=
1_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c</span><br><span>index 245aa8d..e=
aaa07c 100644</span><br><span>--- a/src/openvpn/pkcs11_mbedtls.c</span><br>=
<span>+++ b/src/openvpn/pkcs11_mbedtls.c</span><br><span>@@ -6,7 +6,7 @@</s=
pan><br><span>  *             packet compression.</span><br><span>  *</span=
><br><span>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 201=
0-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt=
;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>  *  This progr=
am is free software; you can redistribute it and/or modify</span><br><span>=
  *  it under the terms of the GNU General Public License version 2</span><=
br><span>diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_ope=
nssl.c</span><br><span>index a912747..23c01ab 100644</span><br><span>--- a/=
src/openvpn/pkcs11_openssl.c</span><br><span>+++ b/src/openvpn/pkcs11_opens=
sl.c</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *             packet=
 compression.</span><br><span>  *</span><br><span>  *  Copyright (C) 2002-2=
025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...220...=
..2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Co=
pyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><s=
pan>  *</span><br><span>  *  This program is free software; you can redistr=
ibute it and/or modify</span><br><span>  *  it under the terms of the GNU G=
eneral Public License version 2</span><br><span>diff --git a/src/openvpn/ss=
l.c b/src/openvpn/ssl.c</span><br><span>index c17e608..9159b8c 100644</span=
><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c<=
/span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *             packet comp=
ression.</span><br><span>  *</span><br><span>  *  Copyright (C) 2002-2025 O=
penVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2919...=
7...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrig=
ht (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span> =
 *  Copyright (C) 2008-2025 David Sommerseth &lt;dazo@...2108...&gt;</span>=
<br><span>  *</span><br><span>  *  This program is free software; you can r=
edistribute it and/or modify</span><br><span>diff --git a/src/openvpn/ssl.h=
 b/src/openvpn/ssl.h</span><br><span>index 976808d..ffcc7c4 100644</span><b=
r><span>--- a/src/openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</sp=
an><br><span>@@ -6,7 +6,7 @@</span><br><span>  *             packet compres=
sion.</span><br><span>  *</span><br><span>  *  Copyright (C) 2002-2025 Open=
VPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2782...=
.&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright =
(C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *<=
/span><br><span>  *  This program is free software; you can redistribute it=
 and/or modify</span><br><span>  *  it under the terms of the GNU General P=
ublic License version 2</span><br><span>diff --git a/src/openvpn/ssl_backen=
d.h b/src/openvpn/ssl_backend.h</span><br><span>index da3e1e1..1c3c22e 1006=
44</span><br><span>--- a/src/openvpn/ssl_backend.h</span><br><span>+++ b/sr=
c/openvpn/ssl_backend.h</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *=
             packet compression.</span><br><span>  *</span><br><span>  *  C=
opyright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto=
 B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2920...=
..&gt;</span><br><span>  *</span><br><span>  *  This program is free softwa=
re; you can redistribute it and/or modify</span><br><span>  *  it under the=
 terms of the GNU General Public License version 2</span><br><span>diff --g=
it a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>in=
dex a40f18d..de89d30 100644</span><br><span>--- a/src/openvpn/ssl_common.h<=
/span><br><span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -6,7 +6,7=
 @@</span><br><span>  *             packet compression.</span><br><span>  *=
</span><br><span>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...2092...=
..&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (=
C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.=
V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>  *  This=
 program is free software; you can redistribute it and/or modify</span><br>=
<span>  *  it under the terms of the GNU General Public License version 2</=
span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbe=
dtls.c</span><br><span>index 635b53c..338de83 100644</span><br><span>--- a/=
src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</=
span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *             packet compr=
ession.</span><br><span>  *</span><br><span>  *  Copyright (C) 2002-2025 Op=
enVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2754...=
...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrigh=
t (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  =
*  Copyright (C) 2006-2010, Brainspark B.V.</span><br><span>  *</span><br><=
span>  *  This program is free software; you can redistribute it and/or mod=
ify</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ss=
l_mbedtls.h</span><br><span>index 513a07e..0f85d96 100644</span><br><span>-=
-- a/src/openvpn/ssl_mbedtls.h</span><br><span>+++ b/src/openvpn/ssl_mbedtl=
s.h</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *             packet =
compression.</span><br><span>  *</span><br><span>  *  Copyright (C) 2002-20=
25 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...1186...=
.2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Cop=
yright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><sp=
an>  *</span><br><span>  *  This program is free software; you can redistri=
bute it and/or modify</span><br><span>  *  it under the terms of the GNU Ge=
neral Public License version 2</span><br><span>diff --git a/src/openvpn/ssl=
_ncp.c b/src/openvpn/ssl_ncp.c</span><br><span>index 51f7f92..958acea 10064=
4</span><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/ope=
nvpn/ssl_ncp.c</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *         =
    packet compression.</span><br><span>  *</span><br><span>  *  Copyright =
(C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt=
;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</s=
pan><br><span>  *  Copyright (C) 2008-2025 David Sommerseth &lt;dazo@...2921...=
8...&gt;</span><br><span>  *</span><br><span>  *  This program is free soft=
ware; you can redistribute it and/or modify</span><br><span>diff --git a/sr=
c/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h</span><br><span>index ed5d281..=
6edd074 100644</span><br><span>--- a/src/openvpn/ssl_ncp.h</span><br><span>=
+++ b/src/openvpn/ssl_ncp.h</span><br><span>@@ -6,7 +6,7 @@</span><br><span=
>  *             packet compression.</span><br><span>  *</span><br><span>  =
*  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Cr=
ypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...1665...=
918...&gt;</span><br><span>  *</span><br><span>  *  This program is free so=
ftware; you can redistribute it and/or modify</span><br><span>  *  it under=
 the terms of the GNU General Public License version 2</span><br><span>diff=
 --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><s=
pan>index aa1ac11..8c8b1e21 100644</span><br><span>--- a/src/openvpn/ssl_op=
enssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ =
-6,7 +6,7 @@</span><br><span>  *             packet compression.</span><br>=
<span>  *</span><br><span>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sale=
s@...515...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Co=
pyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Se=
ntyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>=
  *  This program is free software; you can redistribute it and/or modify</=
span><br><span>  *  it under the terms of the GNU General Public License ve=
rsion 2</span><br><span>diff --git a/src/openvpn/ssl_openssl.h b/src/openvp=
n/ssl_openssl.h</span><br><span>index 08a3d53..2c1f36d 100644</span><br><sp=
an>--- a/src/openvpn/ssl_openssl.h</span><br><span>+++ b/src/openvpn/ssl_op=
enssl.h</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *             pac=
ket compression.</span><br><span>  *</span><br><span>  *  Copyright (C) 200=
2-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvp=
n@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br=
><span>  *</span><br><span>  *  This program is free software; you can redi=
stribute it and/or modify</span><br><span>  *  it under the terms of the GN=
U General Public License version 2</span><br><span>diff --git a/src/openvpn=
/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index 6f85dca..765=
8f2d 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>=
+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -6,7 +6,7 @@</span><br><s=
pan>  *             packet compression.</span><br><span>  *</span><br><span=
>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox=
 Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...220...=
..2918...&gt;</span><br><span>  *</span><br><span>  *  This program is free=
 software; you can redistribute it and/or modify</span><br><span>  *  it un=
der the terms of the GNU General Public License version 2</span><br><span>d=
iff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h</span><br><=
span>index fdf6bb5..accf558 100644</span><br><span>--- a/src/openvpn/ssl_ve=
rify.h</span><br><span>+++ b/src/openvpn/ssl_verify.h</span><br><span>@@ -6=
,7 +6,7 @@</span><br><span>  *             packet compression.</span><br><s=
pan>  *</span><br><span>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@=
...515...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copy=
right (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sent=
yron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>  =
*  This program is free software; you can redistribute it and/or modify</sp=
an><br><span>  *  it under the terms of the GNU General Public License vers=
ion 2</span><br><span>diff --git a/src/openvpn/ssl_verify_backend.h b/src/o=
penvpn/ssl_verify_backend.h</span><br><span>index 2bad3eb..ceaef3f 100644</=
span><br><span>--- a/src/openvpn/ssl_verify_backend.h</span><br><span>+++ b=
/src/openvpn/ssl_verify_backend.h</span><br><span>@@ -6,7 +6,7 @@</span><br=
><span>  *             packet compression.</span><br><span>  *</span><br><s=
pan>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 =
Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvp=
n@...2918...&gt;</span><br><span>  *</span><br><span>  *  This program is f=
ree software; you can redistribute it and/or modify</span><br><span>  *  it=
 under the terms of the GNU General Public License version 2</span><br><spa=
n>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mb=
edtls.c</span><br><span>index 3588071..61f64af 100644</span><br><span>--- a=
/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_ver=
ify_mbedtls.c</span><br><span>@@ -6,7 +6,7 @@</span><br><span>  *          =
   packet compression.</span><br><span>  *</span><br><span>  *  Copyright (=
C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;=
openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</sp=
an><br><span>  *</span><br><span>  *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span>  *  it under the terms of =
the GNU General Public License version 2</span><br><span>diff --git a/src/o=
penvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h</span><br><s=
pan>index 0b2f2d2..d3217d2 100644</span><br><span>--- a/src/openvpn/ssl_ver=
ify_mbedtls.h</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.h</span>=
<br><span>@@ -6,7 +6,7 @@</span><br><span>  *             packet compressio=
n.</span><br><span>  *</span><br><span>  *  Copyright (C) 2002-2025 OpenVPN=
 Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *  Copyright (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2010-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</sp=
an><br><span>  *  This program is free software; you can redistribute it an=
d/or modify</span><br><span>  *  it under the terms of the GNU General Publ=
ic License version 2</span><br><span>diff --git a/src/openvpn/ssl_verify_op=
enssl.c b/src/openvpn/ssl_verify_openssl.c</span><br><span>index 0f257e2..9=
cd2418 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span>=
<br><span>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -6,7 +6=
,7 @@</span><br><span>  *             packet compression.</span><br><span> =
 *</span><br><span>  *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...1387...=
5...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright=
 (C) 2010-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron =
B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>  *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span>  *  it under the terms of the GNU General Public License version 2=
</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvp=
n/ssl_verify_openssl.h</span><br><span>index 7577cb2..3c5cb29 100644</span>=
<br><span>--- a/src/openvpn/ssl_verify_openssl.h</span><br><span>+++ b/src/=
openvpn/ssl_verify_openssl.h</span><br><span>@@ -6,7 +6,7 @@</span><br><spa=
n>  *             packet compression.</span><br><span>  *</span><br><span> =
 *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2021 Fox C=
rypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  Copyright (C) 2010-2021 Sentyron B.V. &lt;openvpn@...493...=
2918...&gt;</span><br><span>  *</span><br><span>  *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span>  *  it unde=
r the terms of the GNU General Public License version 2</span><br><span>dif=
f --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><span=
>index 2892199..737b556 100644</span><br><span>--- a/src/openvpn/tls_crypt.=
c</span><br><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -5,7 +5,=
7 @@</span><br><span>  *             packet encryption, packet authenticati=
on, and</span><br><span>  *             packet compression.</span><br><span=
>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C)=
 2016-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2016-2021 Sentyron B.V.=
 &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>  *  This p=
rogram is free software; you can redistribute it and/or modify</span><br><s=
pan>  *  it under the terms of the GNU General Public License version 2</sp=
an><br><span>diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h=
</span><br><span>index 87aa8d2..f6604ba 100644</span><br><span>--- a/src/op=
envpn/tls_crypt.h</span><br><span>+++ b/src/openvpn/tls_crypt.h</span><br><=
span>@@ -5,7 +5,7 @@</span><br><span>  *             packet encryption, pac=
ket authentication, and</span><br><span>  *             packet compression.=
</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2016-20=
21 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><=
span>  *  This program is free software; you can redistribute it and/or mod=
ify</span><br><span>  *  it under the terms of the GNU General Public Licen=
se version 2</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_get=
_random.c b/tests/unit_tests/openvpn/mock_get_random.c</span><br><span>inde=
x 77db18e..4077afa 100644</span><br><span>--- a/tests/unit_tests/openvpn/mo=
ck_get_random.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_get_ran=
dom.c</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *             packe=
t encryption, packet authentication, and</span><br><span>  *             pa=
cket compression.</span><br><span>  *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  Copyright (C) 2017-2021 Fox Crypto B.V. &lt;openvpn@...493...=
2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copy=
right (C) 2017-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><spa=
n>  *</span><br><span>  *  This program is free software; you can redistrib=
ute it and/or modify</span><br><span>  *  it under the terms of the GNU Gen=
eral Public License version 2</span><br><span>diff --git a/tests/unit_tests=
/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c</span><br><span>i=
ndex 69d2d1d..a2aa3f9 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/mock_msg.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_msg.c</span=
><br><span>@@ -5,7 +5,7 @@</span><br><span>  *             packet encryptio=
n, packet authentication, and</span><br><span>  *             packet compre=
ssion.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
016-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span=
><br><span>  *  This program is free software; you can redistribute it and/=
or modify</span><br><span>  *  it under the terms of the GNU General Public=
 License version 2</span><br><span>diff --git a/tests/unit_tests/openvpn/mo=
ck_msg.h b/tests/unit_tests/openvpn/mock_msg.h</span><br><span>index 6dddf0=
b..c6321dc 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_msg.h=
</span><br><span>+++ b/tests/unit_tests/openvpn/mock_msg.h</span><br><span>=
@@ -5,7 +5,7 @@</span><br><span>  *             packet encryption, packet a=
uthentication, and</span><br><span>  *             packet compression.</spa=
n><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Co=
pyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2016-2021 Se=
ntyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *</span><br><span>=
  *  This program is free software; you can redistribute it and/or modify</=
span><br><span>  *  it under the terms of the GNU General Public License ve=
rsion 2</span><br><span>diff --git a/tests/unit_tests/openvpn/test_auth_tok=
en.c b/tests/unit_tests/openvpn/test_auth_token.c</span><br><span>index 0c5=
467e..a2a10ea 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_au=
th_token.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_auth_token.c=
</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *             packet enc=
ryption, packet authentication, and</span><br><span>  *             packet =
compression.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...2755...=
..&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright=
 (C) 2016-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  *=
</span><br><span>  *  This program is free software; you can redistribute i=
t and/or modify</span><br><span>  *  it under the terms of the GNU General =
Public License version 2</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>=
index 0cfb918..c86c19e 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_buffer.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer.=
c</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *             packet en=
cryption, packet authentication, and</span><br><span>  *             packet=
 compression.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...2754...=
...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrigh=
t (C) 2016-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>  =
*</span><br><span>  *  This program is free software; you can redistribute =
it and/or modify</span><br><span>  *  it under the terms of the GNU General=
 Public License version 2</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h</span><br><span=
>index 2f2207a..da98531 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_common.h</span><br><span>+++ b/tests/unit_tests/openvpn/test_common=
.h</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *             packet e=
ncryption, packet authentication, and</span><br><span>  *             packe=
t compression.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...2919...=
7...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrig=
ht (C) 2016-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span> =
 *</span><br><span>  *  This program is free software; you can redistribute=
 it and/or modify</span><br><span>  *  it under the terms of the GNU Genera=
l Public License version 2</span><br><span>diff --git a/tests/unit_tests/op=
envpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><spa=
n>index 5df1046..3f327c2 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_crypto.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypt=
o.c</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *             packet =
encryption, packet authentication, and</span><br><span>  *             pack=
et compression.</span><br><span>  *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...2541...=
07...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyri=
ght (C) 2016-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><span>=
  *</span><br><span>  *  This program is free software; you can redistribut=
e it and/or modify</span><br><span>  *  it under the terms of the GNU Gener=
al Public License version 2</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c</span><=
br><span>index d623c3d..0eacbab 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/test_packet_id.c</span><br><span>+++ b/tests/unit_tests/openvpn/=
test_packet_id.c</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *       =
      packet encryption, packet authentication, and</span><br><span>  *    =
         packet compression.</span><br><span>  *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;=
openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  Copyright (C) 2016-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</sp=
an><br><span>  *</span><br><span>  *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span>  *  it under the terms of =
the GNU General Public License version 2</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span>=
<br><span>index b6c612b..b5211cd 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
pkt.c</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *             packe=
t encryption, packet authentication, and</span><br><span>  *             pa=
cket compression.</span><br><span>  *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  Copyright (C) 2016-2021 Fox Crypto B.V. &lt;openvpn@...493...=
2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copy=
right (C) 2016-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</span><br><spa=
n>  *</span><br><span>  *  This program is free software; you can redistrib=
ute it and/or modify</span><br><span>  *  it under the terms of the GNU Gen=
eral Public License version 2</span><br><span>diff --git a/tests/unit_tests=
/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c</span=
><br><span>index 44d51fe..950ce26 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/test_tls_crypt.c</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_tls_crypt.c</span><br><span>@@ -5,7 +5,7 @@</span><br><span>  *     =
        packet encryption, packet authentication, and</span><br><span>  *  =
           packet compression.</span><br><span>  *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2016-2021 Fox Crypto B.V. &l=
t;openvpn@...2507...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  Copyright (C) 2016-2021 Sentyron B.V. &lt;openvpn@...2918...&gt;</=
span><br><span>  *</span><br><span>  *  This program is free software; you =
can redistribute it and/or modify</span><br><span>  *  it under the terms o=
f the GNU General Public License version 2</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1047?us=
p=3Demail">change 1047</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1047?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9912627b707bf4edd4fe4bfc37=
b8a639feaba08 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1047 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--0Jp8uj0zgBc=--

