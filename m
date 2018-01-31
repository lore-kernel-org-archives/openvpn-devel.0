From: David Sommerseth <davids@...515...>
Date: Wed, 31 Jan 2018 15:03:14 +0100
Message-Id: <20180131140314.11103-1-davids@...515...>
In-Reply-To: <20180129084320.3157-1-list@...1798...>
References: <20180129084320.3157-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH] Update copyright to include 2018 plus
 company name change
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

The autumn of 2017, OpenVPN Technologies, Inc changed name to just
OpenVPN Inc.  Otherwise, extend the copyright to cover 2018 as well.

With the exception of the company name change, all changes have been
performed by the dev-tools/update-copyright.sh script.

Signed-off-by: David Sommerseth <davids@...515...>
---
 COPYING                                                           | 8 ++++----
 ChangeLog                                                         | 2 +-
 INSTALL                                                           | 2 +-
 Makefile.am                                                       | 2 +-
 PORTS                                                             | 2 +-
 README                                                            | 2 +-
 build/Makefile.am                                                 | 2 +-
 build/msvc/Makefile.am                                            | 2 +-
 build/msvc/msvc-generate/Makefile.am                              | 2 +-
 configure.ac                                                      | 2 +-
 contrib/pull-resolv-conf/client.down                              | 2 +-
 contrib/pull-resolv-conf/client.up                                | 2 +-
 dev-tools/gen-release-tarballs.sh                                 | 2 +-
 dev-tools/lz4-rebaser.sh                                          | 2 +-
 dev-tools/reformat-all.sh                                         | 2 +-
 dev-tools/update-copyright.sh                                     | 2 +-
 distro/Makefile.am                                                | 2 +-
 distro/rpm/Makefile.am                                            | 2 +-
 distro/systemd/Makefile.am                                        | 2 +-
 doc/Makefile.am                                                   | 2 +-
 doc/doxygen/Makefile.am                                           | 2 +-
 doc/doxygen/doc_compression.h                                     | 2 +-
 doc/doxygen/doc_control_processor.h                               | 2 +-
 doc/doxygen/doc_control_tls.h                                     | 2 +-
 doc/doxygen/doc_data_control.h                                    | 2 +-
 doc/doxygen/doc_data_crypto.h                                     | 2 +-
 doc/doxygen/doc_eventloop.h                                       | 2 +-
 doc/doxygen/doc_external_multiplexer.h                            | 2 +-
 doc/doxygen/doc_fragmentation.h                                   | 2 +-
 doc/doxygen/doc_internal_multiplexer.h                            | 2 +-
 doc/doxygen/doc_key_generation.h                                  | 2 +-
 doc/doxygen/doc_mainpage.h                                        | 2 +-
 doc/doxygen/doc_memory_management.h                               | 2 +-
 doc/doxygen/doc_protocol_overview.h                               | 2 +-
 doc/doxygen/doc_reliable.h                                        | 2 +-
 doc/doxygen/doc_tunnel_state.h                                    | 2 +-
 doc/openvpn.8                                                     | 6 +++---
 include/Makefile.am                                               | 2 +-
 include/openvpn-msg.h                                             | 2 +-
 include/openvpn-plugin.h.in                                       | 2 +-
 sample/Makefile.am                                                | 2 +-
 sample/sample-plugins/defer/simple.c                              | 2 +-
 .../keying-material-exporter-demo/keyingmaterialexporter.c        | 2 +-
 sample/sample-plugins/log/log.c                                   | 2 +-
 sample/sample-plugins/log/log_v3.c                                | 2 +-
 sample/sample-plugins/simple/simple.c                             | 2 +-
 src/Makefile.am                                                   | 2 +-
 src/compat/Makefile.am                                            | 2 +-
 src/compat/compat-gettimeofday.c                                  | 2 +-
 src/openvpn/Makefile.am                                           | 2 +-
 src/openvpn/argv.c                                                | 2 +-
 src/openvpn/argv.h                                                | 2 +-
 src/openvpn/basic.h                                               | 2 +-
 src/openvpn/block_dns.c                                           | 2 +-
 src/openvpn/buffer.c                                              | 2 +-
 src/openvpn/buffer.h                                              | 2 +-
 src/openvpn/circ_list.h                                           | 2 +-
 src/openvpn/clinat.c                                              | 2 +-
 src/openvpn/clinat.h                                              | 2 +-
 src/openvpn/common.h                                              | 2 +-
 src/openvpn/comp-lz4.c                                            | 4 ++--
 src/openvpn/comp-lz4.h                                            | 4 ++--
 src/openvpn/comp.c                                                | 2 +-
 src/openvpn/comp.h                                                | 2 +-
 src/openvpn/compstub.c                                            | 2 +-
 src/openvpn/console.c                                             | 4 ++--
 src/openvpn/console.h                                             | 4 ++--
 src/openvpn/console_builtin.c                                     | 4 ++--
 src/openvpn/crypto.c                                              | 4 ++--
 src/openvpn/crypto.h                                              | 4 ++--
 src/openvpn/crypto_backend.h                                      | 4 ++--
 src/openvpn/crypto_mbedtls.c                                      | 4 ++--
 src/openvpn/crypto_mbedtls.h                                      | 4 ++--
 src/openvpn/crypto_openssl.c                                      | 4 ++--
 src/openvpn/crypto_openssl.h                                      | 4 ++--
 src/openvpn/dhcp.c                                                | 2 +-
 src/openvpn/dhcp.h                                                | 2 +-
 src/openvpn/errlevel.h                                            | 2 +-
 src/openvpn/error.c                                               | 2 +-
 src/openvpn/error.h                                               | 2 +-
 src/openvpn/event.c                                               | 2 +-
 src/openvpn/event.h                                               | 2 +-
 src/openvpn/fdmisc.c                                              | 2 +-
 src/openvpn/fdmisc.h                                              | 2 +-
 src/openvpn/forward-inline.h                                      | 2 +-
 src/openvpn/forward.c                                             | 2 +-
 src/openvpn/forward.h                                             | 2 +-
 src/openvpn/fragment.c                                            | 2 +-
 src/openvpn/fragment.h                                            | 2 +-
 src/openvpn/gremlin.c                                             | 2 +-
 src/openvpn/gremlin.h                                             | 2 +-
 src/openvpn/helper.c                                              | 2 +-
 src/openvpn/helper.h                                              | 2 +-
 src/openvpn/httpdigest.c                                          | 2 +-
 src/openvpn/httpdigest.h                                          | 2 +-
 src/openvpn/init.c                                                | 2 +-
 src/openvpn/init.h                                                | 2 +-
 src/openvpn/integer.h                                             | 2 +-
 src/openvpn/interval.c                                            | 2 +-
 src/openvpn/interval.h                                            | 2 +-
 src/openvpn/list.c                                                | 2 +-
 src/openvpn/list.h                                                | 2 +-
 src/openvpn/lzo.c                                                 | 2 +-
 src/openvpn/lzo.h                                                 | 2 +-
 src/openvpn/manage.c                                              | 2 +-
 src/openvpn/manage.h                                              | 2 +-
 src/openvpn/mbuf.c                                                | 2 +-
 src/openvpn/mbuf.h                                                | 2 +-
 src/openvpn/memdbg.h                                              | 2 +-
 src/openvpn/misc.c                                                | 4 ++--
 src/openvpn/misc.h                                                | 2 +-
 src/openvpn/mroute.c                                              | 2 +-
 src/openvpn/mroute.h                                              | 2 +-
 src/openvpn/mss.c                                                 | 2 +-
 src/openvpn/mss.h                                                 | 2 +-
 src/openvpn/mstats.c                                              | 2 +-
 src/openvpn/mstats.h                                              | 2 +-
 src/openvpn/mtcp.c                                                | 2 +-
 src/openvpn/mtcp.h                                                | 2 +-
 src/openvpn/mtu.c                                                 | 2 +-
 src/openvpn/mtu.h                                                 | 2 +-
 src/openvpn/mudp.c                                                | 2 +-
 src/openvpn/mudp.h                                                | 2 +-
 src/openvpn/multi.c                                               | 2 +-
 src/openvpn/multi.h                                               | 2 +-
 src/openvpn/occ-inline.h                                          | 2 +-
 src/openvpn/occ.c                                                 | 2 +-
 src/openvpn/occ.h                                                 | 2 +-
 src/openvpn/openssl_compat.h                                      | 4 ++--
 src/openvpn/openvpn.c                                             | 2 +-
 src/openvpn/openvpn.h                                             | 2 +-
 src/openvpn/options.c                                             | 4 ++--
 src/openvpn/options.h                                             | 2 +-
 src/openvpn/otime.c                                               | 2 +-
 src/openvpn/otime.h                                               | 2 +-
 src/openvpn/packet_id.c                                           | 2 +-
 src/openvpn/packet_id.h                                           | 2 +-
 src/openvpn/perf.c                                                | 2 +-
 src/openvpn/perf.h                                                | 2 +-
 src/openvpn/pf-inline.h                                           | 2 +-
 src/openvpn/pf.c                                                  | 2 +-
 src/openvpn/pf.h                                                  | 2 +-
 src/openvpn/ping-inline.h                                         | 2 +-
 src/openvpn/ping.c                                                | 2 +-
 src/openvpn/ping.h                                                | 2 +-
 src/openvpn/pkcs11.c                                              | 2 +-
 src/openvpn/pkcs11.h                                              | 2 +-
 src/openvpn/pkcs11_backend.h                                      | 4 ++--
 src/openvpn/pkcs11_mbedtls.c                                      | 4 ++--
 src/openvpn/pkcs11_openssl.c                                      | 4 ++--
 src/openvpn/platform.c                                            | 2 +-
 src/openvpn/platform.h                                            | 2 +-
 src/openvpn/plugin.c                                              | 2 +-
 src/openvpn/plugin.h                                              | 2 +-
 src/openvpn/pool.c                                                | 2 +-
 src/openvpn/pool.h                                                | 2 +-
 src/openvpn/proto.c                                               | 2 +-
 src/openvpn/proto.h                                               | 2 +-
 src/openvpn/proxy.c                                               | 2 +-
 src/openvpn/proxy.h                                               | 2 +-
 src/openvpn/ps.c                                                  | 2 +-
 src/openvpn/ps.h                                                  | 2 +-
 src/openvpn/push.c                                                | 2 +-
 src/openvpn/push.h                                                | 2 +-
 src/openvpn/pushlist.h                                            | 2 +-
 src/openvpn/reliable.c                                            | 2 +-
 src/openvpn/reliable.h                                            | 2 +-
 src/openvpn/route.c                                               | 2 +-
 src/openvpn/route.h                                               | 2 +-
 src/openvpn/schedule.c                                            | 2 +-
 src/openvpn/schedule.h                                            | 2 +-
 src/openvpn/session_id.c                                          | 2 +-
 src/openvpn/session_id.h                                          | 2 +-
 src/openvpn/shaper.c                                              | 2 +-
 src/openvpn/shaper.h                                              | 2 +-
 src/openvpn/sig.c                                                 | 2 +-
 src/openvpn/sig.h                                                 | 2 +-
 src/openvpn/socket.c                                              | 2 +-
 src/openvpn/socket.h                                              | 2 +-
 src/openvpn/socks.c                                               | 2 +-
 src/openvpn/socks.h                                               | 2 +-
 src/openvpn/ssl.c                                                 | 4 ++--
 src/openvpn/ssl.h                                                 | 4 ++--
 src/openvpn/ssl_backend.h                                         | 4 ++--
 src/openvpn/ssl_common.h                                          | 4 ++--
 src/openvpn/ssl_mbedtls.c                                         | 4 ++--
 src/openvpn/ssl_mbedtls.h                                         | 4 ++--
 src/openvpn/ssl_openssl.c                                         | 4 ++--
 src/openvpn/ssl_openssl.h                                         | 4 ++--
 src/openvpn/ssl_verify.c                                          | 4 ++--
 src/openvpn/ssl_verify.h                                          | 4 ++--
 src/openvpn/ssl_verify_backend.h                                  | 4 ++--
 src/openvpn/ssl_verify_mbedtls.c                                  | 4 ++--
 src/openvpn/ssl_verify_mbedtls.h                                  | 4 ++--
 src/openvpn/ssl_verify_openssl.c                                  | 4 ++--
 src/openvpn/ssl_verify_openssl.h                                  | 4 ++--
 src/openvpn/status.c                                              | 2 +-
 src/openvpn/status.h                                              | 2 +-
 src/openvpn/syshead.h                                             | 2 +-
 src/openvpn/tls_crypt.c                                           | 2 +-
 src/openvpn/tls_crypt.h                                           | 2 +-
 src/openvpn/tun.c                                                 | 2 +-
 src/openvpn/tun.h                                                 | 2 +-
 src/openvpn/win32.c                                               | 2 +-
 src/openvpn/win32.h                                               | 2 +-
 src/openvpnserv/Makefile.am                                       | 2 +-
 src/openvpnserv/automatic.c                                       | 2 +-
 src/openvpnserv/common.c                                          | 2 +-
 src/openvpnserv/interactive.c                                     | 2 +-
 src/openvpnserv/service.h                                         | 2 +-
 src/plugins/Makefile.am                                           | 2 +-
 src/plugins/auth-pam/auth-pam.c                                   | 2 +-
 src/plugins/auth-pam/utils.c                                      | 2 +-
 src/plugins/auth-pam/utils.h                                      | 2 +-
 src/plugins/down-root/down-root.c                                 | 2 +-
 tests/Makefile.am                                                 | 2 +-
 tests/unit_tests/openvpn/mock_msg.c                               | 2 +-
 tests/unit_tests/openvpn/mock_msg.h                               | 2 +-
 tests/unit_tests/openvpn/test_buffer.c                            | 2 +-
 tests/unit_tests/openvpn/test_packet_id.c                         | 2 +-
 tests/unit_tests/openvpn/test_tls_crypt.c                         | 2 +-
 221 files changed, 259 insertions(+), 259 deletions(-)

diff --git a/COPYING b/COPYING
index f88ad79b..9c21c177 100644
--- a/COPYING
+++ b/COPYING
@@ -1,6 +1,6 @@
 OpenVPN (TM) -- An Open Source VPN daemon
 
-Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 
 This distribution contains multiple components, some
 of which fall under different licenses.  By using OpenVPN
@@ -11,7 +11,7 @@ each respective component.
 OpenVPN trademark
 -----------------
 
-  "OpenVPN" is a trademark of OpenVPN Technologies, Inc.
+  "OpenVPN" is a trademark of OpenVPN Inc
 
 
 OpenVPN license:
@@ -21,7 +21,7 @@ OpenVPN license:
 
   Special exception for linking OpenVPN with OpenSSL:
 
-  In addition, as a special exception, OpenVPN Technologies, Inc. gives
+  In addition, as a special exception, OpenVPN Inc gives
   permission to link the code of this program with the OpenSSL
   library (or with modified versions of OpenSSL that use the same
   license as OpenSSL), and distribute linked combinations including
@@ -52,7 +52,7 @@ TAP-Win32/TAP-Win64 Driver license:
   Damion K. Wilson.
 
   The source and object code of the TAP-Win32/TAP-Win64 driver
-  is Copyright (C) 2002-2010 OpenVPN Technologies, Inc., and is released under
+  is Copyright (C) 2002-2018 OpenVPN Inc, and is released under
   the GPL version 2.
 
 Windows DDK Samples:
diff --git a/ChangeLog b/ChangeLog
index 8ae08637..1c06c7f1 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,5 +1,5 @@
 OpenVPN Change Log
-Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 
 2016.12.16 -- Version 2.4_rc2
 David Sommerseth (9):
diff --git a/INSTALL b/INSTALL
index 3a31e6f1..0f12a636 100644
--- a/INSTALL
+++ b/INSTALL
@@ -1,6 +1,6 @@
 Installation instructions for OpenVPN, a Secure Tunneling Daemon
 
-Copyright (C) 2002-2010 OpenVPN Technologies, Inc. This program is free software;
+Copyright (C) 2002-2018 OpenVPN Inc. This program is free software;
 you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2
 as published by the Free Software Foundation.
diff --git a/Makefile.am b/Makefile.am
index 773b7867..a4dbb34b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2010      David Sommerseth <dazo@...384...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
diff --git a/PORTS b/PORTS
index 5a9de662..1d8d5e09 100644
--- a/PORTS
+++ b/PORTS
@@ -1,5 +1,5 @@
 OpenVPN
-Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 
   OpenVPN has been written to try to avoid features
   that are not standardized well across different
diff --git a/README b/README
index 103a75a6..b75a568e 100644
--- a/README
+++ b/README
@@ -1,6 +1,6 @@
 OpenVPN -- A Secure tunneling daemon
 
-Copyright (C) 2002-2010 OpenVPN Technologies, Inc. This program is free software;
+Copyright (C) 2002-2018 OpenVPN Inc. This program is free software;
 you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2
 as published by the Free Software Foundation.
diff --git a/build/Makefile.am b/build/Makefile.am
index 4191a994..b011141e 100644
--- a/build/Makefile.am
+++ b/build/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/build/msvc/Makefile.am b/build/msvc/Makefile.am
index 85a613b2..3e9c3fe1 100644
--- a/build/msvc/Makefile.am
+++ b/build/msvc/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-generate/Makefile.am
index 2151b423..4ae850f1 100644
--- a/build/msvc/msvc-generate/Makefile.am
+++ b/build/msvc/msvc-generate/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/configure.ac b/configure.ac
index b4fd1b3f..05709afd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,7 +4,7 @@ dnl             session authentication and key exchange,
 dnl             packet encryption, packet authentication, and
 dnl             packet compression.
 dnl
-dnl  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+dnl  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 dnl  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 dnl
 dnl  This program is free software; you can redistribute it and/or modify
diff --git a/contrib/pull-resolv-conf/client.down b/contrib/pull-resolv-conf/client.down
index c9090b56..0cbb4765 100644
--- a/contrib/pull-resolv-conf/client.down
+++ b/contrib/pull-resolv-conf/client.down
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-# Copyright (c) 2005-2010 OpenVPN Technologies, Inc.
+# Copyright (c) 2005-2018 OpenVPN Inc
 # Licensed under the GPL version 2
 
 # First version by Jesse Adelman
diff --git a/contrib/pull-resolv-conf/client.up b/contrib/pull-resolv-conf/client.up
index 260c038e..f0769740 100644
--- a/contrib/pull-resolv-conf/client.up
+++ b/contrib/pull-resolv-conf/client.up
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-# Copyright (c) 2005-2010 OpenVPN Technologies, Inc.
+# Copyright (c) 2005-2018 OpenVPN Inc
 # Licensed under the GPL version 2
 
 # First version by Jesse Adelman
diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarballs.sh
index f9c620e3..9c4600e9 100755
--- a/dev-tools/gen-release-tarballs.sh
+++ b/dev-tools/gen-release-tarballs.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # gen-release-tarballs.sh  -  Generates release tarballs with signatures
 #
-# Copyright (C) 2017 - David Sommerseth <davids@...515...>
+# Copyright (C) 2017-2018 - David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/lz4-rebaser.sh b/dev-tools/lz4-rebaser.sh
index 4ef4de8f..03debcb4 100755
--- a/dev-tools/lz4-rebaser.sh
+++ b/dev-tools/lz4-rebaser.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # lz4-rebaser.sh   - Does the LZ4 rebase process in an automated fashion
 #
-# Copyright (C) 2017      David Sommerseth <davids@...515...>
+# Copyright (C) 2017-2018 David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
index e253ab2b..befc589a 100755
--- a/dev-tools/reformat-all.sh
+++ b/dev-tools/reformat-all.sh
@@ -2,7 +2,7 @@
 # reformat-all.sh - Reformat all git files in the checked out
 #                   git branch using uncrustify.
 #
-# Copyright (C) 2016-2017 - David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2018 - David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
index 755d1e03..a8746314 100755
--- a/dev-tools/update-copyright.sh
+++ b/dev-tools/update-copyright.sh
@@ -2,7 +2,7 @@
 # update-copyright-sh - Simple tool to update the Copyright lines
 #                       in all files checked into git
 #
-# Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2018 David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/distro/Makefile.am b/distro/Makefile.am
index eb0e5540..e2098c84 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/distro/rpm/Makefile.am b/distro/rpm/Makefile.am
index 37ee099a..d16a5ac7 100644
--- a/distro/rpm/Makefile.am
+++ b/distro/rpm/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index 5da926b6..69e12699 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2017-2018 OpenVPN Inc <sales@...515...>
 #
 
 %.service: %.service.in Makefile
diff --git a/doc/Makefile.am b/doc/Makefile.am
index f9e7f4ae..cd1bcfdf 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/doc/doxygen/Makefile.am b/doc/doxygen/Makefile.am
index def09789..299a76c4 100644
--- a/doc/doxygen/Makefile.am
+++ b/doc/doxygen/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2017 Fox-IT B.V. <openvpn@...1435...>
+#  Copyright (C) 2017-2018 Fox-IT B.V. <openvpn@...1435...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
index beb8c749..3176bad7 100644
--- a/doc/doxygen/doc_compression.h
+++ b/doc/doxygen/doc_compression.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/doc_control_processor.h
index 59ace2c7..f87324cc 100644
--- a/doc/doxygen/doc_control_processor.h
+++ b/doc/doxygen/doc_control_processor.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_control_tls.h b/doc/doxygen/doc_control_tls.h
index e854fc62..5cb7c534 100644
--- a/doc/doxygen/doc_control_tls.h
+++ b/doc/doxygen/doc_control_tls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_data_control.h b/doc/doxygen/doc_data_control.h
index f9bd8d0a..ad2a3084 100644
--- a/doc/doxygen/doc_data_control.h
+++ b/doc/doxygen/doc_data_control.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
index a8cf8d3b..38280894 100644
--- a/doc/doxygen/doc_data_crypto.h
+++ b/doc/doxygen/doc_data_crypto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_eventloop.h b/doc/doxygen/doc_eventloop.h
index b93c2a90..8bd26355 100644
--- a/doc/doxygen/doc_eventloop.h
+++ b/doc/doxygen/doc_eventloop.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_external_multiplexer.h b/doc/doxygen/doc_external_multiplexer.h
index b69d7eb5..692c15cc 100644
--- a/doc/doxygen/doc_external_multiplexer.h
+++ b/doc/doxygen/doc_external_multiplexer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_fragmentation.h b/doc/doxygen/doc_fragmentation.h
index 26f6be9c..90e8d9e3 100644
--- a/doc/doxygen/doc_fragmentation.h
+++ b/doc/doxygen/doc_fragmentation.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_internal_multiplexer.h b/doc/doxygen/doc_internal_multiplexer.h
index da872e56..c68a09c7 100644
--- a/doc/doxygen/doc_internal_multiplexer.h
+++ b/doc/doxygen/doc_internal_multiplexer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
index 4109ac5d..efe61155 100644
--- a/doc/doxygen/doc_key_generation.h
+++ b/doc/doxygen/doc_key_generation.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_mainpage.h b/doc/doxygen/doc_mainpage.h
index 645561ec..6016d077 100644
--- a/doc/doxygen/doc_mainpage.h
+++ b/doc/doxygen/doc_mainpage.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_memory_management.h b/doc/doxygen/doc_memory_management.h
index 451c9d6e..1f16328b 100644
--- a/doc/doxygen/doc_memory_management.h
+++ b/doc/doxygen/doc_memory_management.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
index 6ac5d9f2..db24d3b4 100644
--- a/doc/doxygen/doc_protocol_overview.h
+++ b/doc/doxygen/doc_protocol_overview.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_reliable.h b/doc/doxygen/doc_reliable.h
index 0a8f1eca..70556d7f 100644
--- a/doc/doxygen/doc_reliable.h
+++ b/doc/doxygen/doc_reliable.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_tunnel_state.h b/doc/doxygen/doc_tunnel_state.h
index 7560672b..46e750fd 100644
--- a/doc/doxygen/doc_tunnel_state.h
+++ b/doc/doxygen/doc_tunnel_state.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2b5cab12..c36c4466 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4,7 +4,7 @@
 .\"             packet encryption, packet authentication, and
 .\"             packet compression.
 .\"
-.\"  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+.\"  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 .\"
 .\"  This program is free software; you can redistribute it and/or modify
 .\"  it under the terms of the GNU General Public License version 2
@@ -33,7 +33,7 @@
 .\" .ft -- normal face
 .\" .in +|-{n} -- indent
 .\"
-.TH openvpn 8 "04 April 2017"
+.TH openvpn 8 "31 January 2018"
 .\"*********************************************************
 .SH NAME
 openvpn \- secure IP tunnel daemon.
@@ -7284,7 +7284,7 @@ For more information on the LZO real\-time compression library see
 .I http://www.oberhumer.com/opensource/lzo/
 .\"*********************************************************
 .SH COPYRIGHT
-Copyright (C) 2002\-2017 OpenVPN Technologies, Inc. This program is free software;
+Copyright (C) 2002\-2018 OpenVPN Inc This program is free software;
 you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2
 as published by the Free Software Foundation.
diff --git a/include/Makefile.am b/include/Makefile.am
index a52c4278..484e4e12 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 91e0ccc2..82ecfe8b 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2017 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2018 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index f43f74b1..a90a998e 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/Makefile.am b/sample/Makefile.am
index 58ae9658..3be698e7 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index 4960497a..d18695b5 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 8ee78c53..9986461b 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index c59027f8..ecf62c0e 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 3ff80290..3ef4a1cb 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010 David Sommerseth <dazo@...384...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
index 0a05240f..950c547e 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/Makefile.am b/src/Makefile.am
index eb5b0070..c7f63027 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 444a8f8b..b4c3a4aa 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index fb57f2da..7cae641d 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index fcc22d68..59fc845d 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 95bdfeac..124e1c43 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 7d0754c9..9d9f3873 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index 3aa69ca2..eb9f2119 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index d43cbcfe..16a597cc 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *                2015-2016  <iam@...2070...>
  *                2016 Selva Nair <selva.nair@...277...>
  *
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index ecd3b17f..2b1831f8 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 84ad3efa..3d94690f 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index 386e18df..23b42d2a 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 633cec61..b08fd549 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index e0cfad5b..eec7a03f 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index 4ea3938d..4e6f4809 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 9598853f..f2916bdd 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2013-2017 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2018 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
index c256ba55..8c1ca3af 100644
--- a/src/openvpn/comp-lz4.h
+++ b/src/openvpn/comp-lz4.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2013-2017 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2018 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 4cda7e5e..a9459133 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index e56fd2b6..0dadd1e6 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index ca90924e..9123541b 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 7e170241..4d497221 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2018 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 3f74e77e..5a70e5fd 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2018 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index f005ed74..445928bf 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015  David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2018 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 3096f3b0..a23de65b 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 8e8ee8f5..63aa3a84 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 567fd9b2..bb53b8c9 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 8fa03da5..311f9a49 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 4417b924..452b06ed 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 20a519ec..4fb2f6d6 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 60a28123..0a413705 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index a2a54540..fb28b27d 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index dc41658e..32aa15e9 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 5bb043b2..5ca4fa8f 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 26455455..f337c447 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 023cec46..eaedf172 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 2fb112b8..925dc88e 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index ff795f4c..4af6371e 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 56e2250a..1cea505c 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index b6d71011..0fb8b934 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
index c977120e..feb0ba70 100644
--- a/src/openvpn/forward-inline.h
+++ b/src/openvpn/forward-inline.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 9bf9483e..b5b9684e 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 9fde5a30..924cc5e2 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 84f01214..4eb1dd28 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index 90ba8f76..6fa9692d 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index e85ce9cf..114cb198 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h
index 8b23b345..22c90b92 100644
--- a/src/openvpn/gremlin.h
+++ b/src/openvpn/gremlin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 17d15285..ff9df506 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
index c5b438b5..866a398e 100644
--- a/src/openvpn/helper.h
+++ b/src/openvpn/helper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index c553f939..7cf74fd9 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index aae7b8c4..959220fb 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 30beadb6..3fdd87bd 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 15feb677..c8ebe768 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 9bb00a38..a7e19d35 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index 16343865..00ee6271 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index dd5dfbc8..826a08ba 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 91765d20..09e393ad 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index c808efa6..b67301ce 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index f7548656..8d9efeaf 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index deaeb8df..11e1c39f 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 55b106cd..b4046674 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 676be640..78480ee3 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index f969a2b5..87faff08 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index e0643de1..4912c958 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index 0ba695f2..70c6365d 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 76b592f8..23e272cd 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2018 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index ec20ee7e..dad6a5de 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index bf174ad4..28940a8d 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 6a85b0e2..1063a187 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index c36e0046..facdf7b5 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 0de2042a..9350102d 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
index 9b091886..281a835c 100644
--- a/src/openvpn/mstats.c
+++ b/src/openvpn/mstats.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.h b/src/openvpn/mstats.h
index 486035fb..0d58cbf3 100644
--- a/src/openvpn/mstats.h
+++ b/src/openvpn/mstats.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 3cb52113..3756c270 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 79dcb136..bba455be 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 44bef681..04868cd6 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index d1e8c186..a82154af 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index eb28ca2b..b3690ab7 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index b9ceaf7b..7e311519 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 25b2d097..d5e8cbb7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 63afbaf0..d7e5c298 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ-inline.h b/src/openvpn/occ-inline.h
index 0fa8e5ba..7f6f1b24 100644
--- a/src/openvpn/occ-inline.h
+++ b/src/openvpn/occ-inline.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 40f7e768..80504af2 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 12d7bc57..f6ff5f97 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 70b19aea..e8480f20 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index e237ee50..b9e914a8 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index db168425..c5c767c0 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7be5f383..67582aa9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -4108,7 +4108,7 @@ usage_version(void)
     show_windows_version( M_INFO|M_NOPREFIX );
 #endif
     msg(M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
-    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>");
+    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>");
 #ifndef ENABLE_SMALL
 #ifdef CONFIGURE_DEFINES
     msg(M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f70760cf..f7d0145a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index d741ae07..30342771 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 87314725..a6f7ec25 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 4c3696de..b6ffa5aa 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index cde76483..ec03e348 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index 16cf7492..d8823585 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
index ae5ae082..9cf0343d 100644
--- a/src/openvpn/perf.h
+++ b/src/openvpn/perf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pf-inline.h b/src/openvpn/pf-inline.h
index ac19ac4c..90cc41c6 100644
--- a/src/openvpn/pf-inline.h
+++ b/src/openvpn/pf-inline.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 6e4107c5..cb22a1cb 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
index b839fd2e..96fc727b 100644
--- a/src/openvpn/pf.h
+++ b/src/openvpn/pf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping-inline.h b/src/openvpn/ping-inline.h
index 0642b851..1a5c8bc3 100644
--- a/src/openvpn/ping-inline.h
+++ b/src/openvpn/ping-inline.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index 728d6c2a..208170d3 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 5bd5c089..05793b4d 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index a0d0906a..93f8580a 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index f1722c0e..66c6a7e1 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index b47b757d..e8fb664e 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 45372e48..76206246 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index c37425b6..642769cc 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index e942ba94..fbffd0f0 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index cd2bbc92..288937df 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 7387f8be..0f091ef5 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index c9bf03bc..fc3b527e 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index a8f15b96..da28bc06 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index ee91d82b..6de28ac5 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 2cbea3ab..87c18e84 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 57f25c90..985aa99b 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index de0188a9..fdad3ed5 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 3ce79dea..707f7fa3 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 5136a20c..25ab3749 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index b8c6853c..b4490f54 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e7aecbb7..6a30e479 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 4d42e81f..5f6181e7 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
index 57216b2f..23b0ee5d 100644
--- a/src/openvpn/pushlist.h
+++ b/src/openvpn/pushlist.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 972af618..4f79f72e 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 0585d8b7..4d8fc378 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8c71e6ec..553008be 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 6414d6c9..2c6f9f16 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index b1ba5d4e..76cf7c3d 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index e6c1b7eb..74d37fb3 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index bc3c42af..d57609cb 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
index df9167c3..c0a128d3 100644
--- a/src/openvpn/session_id.h
+++ b/src/openvpn/session_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index de2da6db..1bf72aac 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 34f316fd..d2906078 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 87cef71e..d7f2abb8 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 7c41070c..887d8332 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0fc91f21..8445daac 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2d7f2187..479d1150 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 92747ec6..c61ef55c 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 39b96c50..aef873c7 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7b428455..6cf2da4e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index dd1ab0fd..a2501c9b 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 7cf5d830..f14c7043 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 60ed5f8a..08ef6ffa 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 8ac52d55..ffab6471 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *  Copyright (C) 2006-2010, Brainspark B.V.
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 341da7d4..dd8ca750 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 34c31b9d..13dd5bca 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 0377fea2..835878c3 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index ebb1da20..71271313 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index b17402b0..64f27efb 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index e8eaabe9..2a9e8bb7 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 5c4ad19e..fd31bbbd 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
index 2fba362f..00dc8a3d 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 02850fcb..57c56029 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index 4c8dbeb7..118e16fc 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index d2f0b133..91391d1a 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index 81999356..2a399d7d 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 221eed81..e83f9a3b 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index d9c67c38..36ead84d 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index e8080df9..067758ca 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 25831ce3..aecadee1 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 8782d697..6c57ad0d 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 95fea5df..4bafcbbb 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 7fc57ccc..4b99a5e3 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 21efc7c5..bc65070b 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 6f82b4e9..1f982837 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index d2c7f4ac..2311583c 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2011-2017 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2011-2018 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index c96e1fb8..a630c2fc 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2012-2017 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2012-2018 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 1afd20ee..af8f37fa 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2017 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2018 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/Makefile.am b/src/plugins/Makefile.am
index ca904963..f3461786 100644
--- a/src/plugins/Makefile.am
+++ b/src/plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index ae514d79..26b0eeba 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index 4b900c7a..4e0c5bf1 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index c0b4b105..90fff668 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index 41981848..c5e5023e 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2013      David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 53313de4..e6803864 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index 4bd11ca5..140e6376 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
index 2f8c8bf6..53cae26e 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index ba5aa670..b7a8148d 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index 0a785adb..ba420c49 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index cf40e4b6..f3228adc 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2016-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
-- 
2.13.5




