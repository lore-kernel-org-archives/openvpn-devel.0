From: Christian Hesse <list@...1798...>
Date: Mon, 29 Jan 2018 09:43:20 +0100
Message-Id: <20180129084320.3157-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH 1/1] Update copyright notes
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

Now that the first release in 2018 is imminent let's update
the copyright notes.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 COPYING                                                             | 2 +-
 ChangeLog                                                           | 2 +-
 Makefile.am                                                         | 2 +-
 PORTS                                                               | 2 +-
 README                                                              | 2 +-
 build/Makefile.am                                                   | 2 +-
 build/msvc/Makefile.am                                              | 2 +-
 build/msvc/msvc-generate/Makefile.am                                | 2 +-
 configure.ac                                                        | 2 +-
 dev-tools/gen-release-tarballs.sh                                   | 2 +-
 dev-tools/lz4-rebaser.sh                                            | 2 +-
 dev-tools/reformat-all.sh                                           | 2 +-
 dev-tools/update-copyright.sh                                       | 2 +-
 distro/Makefile.am                                                  | 2 +-
 distro/rpm/Makefile.am                                              | 2 +-
 distro/systemd/Makefile.am                                          | 2 +-
 doc/Makefile.am                                                     | 2 +-
 doc/doxygen/Makefile.am                                             | 2 +-
 doc/doxygen/doc_compression.h                                       | 2 +-
 doc/doxygen/doc_control_processor.h                                 | 2 +-
 doc/doxygen/doc_control_tls.h                                       | 2 +-
 doc/doxygen/doc_data_control.h                                      | 2 +-
 doc/doxygen/doc_data_crypto.h                                       | 2 +-
 doc/doxygen/doc_eventloop.h                                         | 2 +-
 doc/doxygen/doc_external_multiplexer.h                              | 2 +-
 doc/doxygen/doc_fragmentation.h                                     | 2 +-
 doc/doxygen/doc_internal_multiplexer.h                              | 2 +-
 doc/doxygen/doc_key_generation.h                                    | 2 +-
 doc/doxygen/doc_mainpage.h                                          | 2 +-
 doc/doxygen/doc_memory_management.h                                 | 2 +-
 doc/doxygen/doc_protocol_overview.h                                 | 2 +-
 doc/doxygen/doc_reliable.h                                          | 2 +-
 doc/doxygen/doc_tunnel_state.h                                      | 2 +-
 doc/openvpn.8                                                       | 6 +++---
 include/Makefile.am                                                 | 2 +-
 include/openvpn-msg.h                                               | 2 +-
 include/openvpn-plugin.h.in                                         | 2 +-
 sample/Makefile.am                                                  | 2 +-
 sample/sample-plugins/defer/simple.c                                | 2 +-
 .../keying-material-exporter-demo/keyingmaterialexporter.c          | 2 +-
 sample/sample-plugins/log/log.c                                     | 2 +-
 sample/sample-plugins/log/log_v3.c                                  | 2 +-
 sample/sample-plugins/simple/simple.c                               | 2 +-
 src/Makefile.am                                                     | 2 +-
 src/compat/Makefile.am                                              | 2 +-
 src/compat/compat-gettimeofday.c                                    | 2 +-
 src/openvpn/Makefile.am                                             | 2 +-
 src/openvpn/argv.c                                                  | 2 +-
 src/openvpn/argv.h                                                  | 2 +-
 src/openvpn/basic.h                                                 | 2 +-
 src/openvpn/block_dns.c                                             | 2 +-
 src/openvpn/buffer.c                                                | 2 +-
 src/openvpn/buffer.h                                                | 2 +-
 src/openvpn/circ_list.h                                             | 2 +-
 src/openvpn/clinat.c                                                | 2 +-
 src/openvpn/clinat.h                                                | 2 +-
 src/openvpn/common.h                                                | 2 +-
 src/openvpn/comp-lz4.c                                              | 4 ++--
 src/openvpn/comp-lz4.h                                              | 4 ++--
 src/openvpn/comp.c                                                  | 2 +-
 src/openvpn/comp.h                                                  | 2 +-
 src/openvpn/compstub.c                                              | 2 +-
 src/openvpn/console.c                                               | 4 ++--
 src/openvpn/console.h                                               | 4 ++--
 src/openvpn/console_builtin.c                                       | 4 ++--
 src/openvpn/crypto.c                                                | 4 ++--
 src/openvpn/crypto.h                                                | 4 ++--
 src/openvpn/crypto_backend.h                                        | 4 ++--
 src/openvpn/crypto_mbedtls.c                                        | 4 ++--
 src/openvpn/crypto_mbedtls.h                                        | 4 ++--
 src/openvpn/crypto_openssl.c                                        | 4 ++--
 src/openvpn/crypto_openssl.h                                        | 4 ++--
 src/openvpn/dhcp.c                                                  | 2 +-
 src/openvpn/dhcp.h                                                  | 2 +-
 src/openvpn/errlevel.h                                              | 2 +-
 src/openvpn/error.c                                                 | 2 +-
 src/openvpn/error.h                                                 | 2 +-
 src/openvpn/event.c                                                 | 2 +-
 src/openvpn/event.h                                                 | 2 +-
 src/openvpn/fdmisc.c                                                | 2 +-
 src/openvpn/fdmisc.h                                                | 2 +-
 src/openvpn/forward-inline.h                                        | 2 +-
 src/openvpn/forward.c                                               | 2 +-
 src/openvpn/forward.h                                               | 2 +-
 src/openvpn/fragment.c                                              | 2 +-
 src/openvpn/fragment.h                                              | 2 +-
 src/openvpn/gremlin.c                                               | 2 +-
 src/openvpn/gremlin.h                                               | 2 +-
 src/openvpn/helper.c                                                | 2 +-
 src/openvpn/helper.h                                                | 2 +-
 src/openvpn/httpdigest.c                                            | 2 +-
 src/openvpn/httpdigest.h                                            | 2 +-
 src/openvpn/init.c                                                  | 2 +-
 src/openvpn/init.h                                                  | 2 +-
 src/openvpn/integer.h                                               | 2 +-
 src/openvpn/interval.c                                              | 2 +-
 src/openvpn/interval.h                                              | 2 +-
 src/openvpn/list.c                                                  | 2 +-
 src/openvpn/list.h                                                  | 2 +-
 src/openvpn/lzo.c                                                   | 2 +-
 src/openvpn/lzo.h                                                   | 2 +-
 src/openvpn/manage.c                                                | 2 +-
 src/openvpn/manage.h                                                | 2 +-
 src/openvpn/mbuf.c                                                  | 2 +-
 src/openvpn/mbuf.h                                                  | 2 +-
 src/openvpn/memdbg.h                                                | 2 +-
 src/openvpn/misc.c                                                  | 4 ++--
 src/openvpn/misc.h                                                  | 2 +-
 src/openvpn/mroute.c                                                | 2 +-
 src/openvpn/mroute.h                                                | 2 +-
 src/openvpn/mss.c                                                   | 2 +-
 src/openvpn/mss.h                                                   | 2 +-
 src/openvpn/mstats.c                                                | 2 +-
 src/openvpn/mstats.h                                                | 2 +-
 src/openvpn/mtcp.c                                                  | 2 +-
 src/openvpn/mtcp.h                                                  | 2 +-
 src/openvpn/mtu.c                                                   | 2 +-
 src/openvpn/mtu.h                                                   | 2 +-
 src/openvpn/mudp.c                                                  | 2 +-
 src/openvpn/mudp.h                                                  | 2 +-
 src/openvpn/multi.c                                                 | 2 +-
 src/openvpn/multi.h                                                 | 2 +-
 src/openvpn/occ-inline.h                                            | 2 +-
 src/openvpn/occ.c                                                   | 2 +-
 src/openvpn/occ.h                                                   | 2 +-
 src/openvpn/openssl_compat.h                                        | 4 ++--
 src/openvpn/openvpn.c                                               | 2 +-
 src/openvpn/openvpn.h                                               | 2 +-
 src/openvpn/options.c                                               | 4 ++--
 src/openvpn/options.h                                               | 2 +-
 src/openvpn/otime.c                                                 | 2 +-
 src/openvpn/otime.h                                                 | 2 +-
 src/openvpn/packet_id.c                                             | 2 +-
 src/openvpn/packet_id.h                                             | 2 +-
 src/openvpn/perf.c                                                  | 2 +-
 src/openvpn/perf.h                                                  | 2 +-
 src/openvpn/pf-inline.h                                             | 2 +-
 src/openvpn/pf.c                                                    | 2 +-
 src/openvpn/pf.h                                                    | 2 +-
 src/openvpn/ping-inline.h                                           | 2 +-
 src/openvpn/ping.c                                                  | 2 +-
 src/openvpn/ping.h                                                  | 2 +-
 src/openvpn/pkcs11.c                                                | 2 +-
 src/openvpn/pkcs11.h                                                | 2 +-
 src/openvpn/pkcs11_backend.h                                        | 4 ++--
 src/openvpn/pkcs11_mbedtls.c                                        | 4 ++--
 src/openvpn/pkcs11_openssl.c                                        | 4 ++--
 src/openvpn/platform.c                                              | 2 +-
 src/openvpn/platform.h                                              | 2 +-
 src/openvpn/plugin.c                                                | 2 +-
 src/openvpn/plugin.h                                                | 2 +-
 src/openvpn/pool.c                                                  | 2 +-
 src/openvpn/pool.h                                                  | 2 +-
 src/openvpn/proto.c                                                 | 2 +-
 src/openvpn/proto.h                                                 | 2 +-
 src/openvpn/proxy.c                                                 | 2 +-
 src/openvpn/proxy.h                                                 | 2 +-
 src/openvpn/ps.c                                                    | 2 +-
 src/openvpn/ps.h                                                    | 2 +-
 src/openvpn/push.c                                                  | 2 +-
 src/openvpn/push.h                                                  | 2 +-
 src/openvpn/pushlist.h                                              | 2 +-
 src/openvpn/reliable.c                                              | 2 +-
 src/openvpn/reliable.h                                              | 2 +-
 src/openvpn/route.c                                                 | 2 +-
 src/openvpn/route.h                                                 | 2 +-
 src/openvpn/schedule.c                                              | 2 +-
 src/openvpn/schedule.h                                              | 2 +-
 src/openvpn/session_id.c                                            | 2 +-
 src/openvpn/session_id.h                                            | 2 +-
 src/openvpn/shaper.c                                                | 2 +-
 src/openvpn/shaper.h                                                | 2 +-
 src/openvpn/sig.c                                                   | 2 +-
 src/openvpn/sig.h                                                   | 2 +-
 src/openvpn/socket.c                                                | 2 +-
 src/openvpn/socket.h                                                | 2 +-
 src/openvpn/socks.c                                                 | 2 +-
 src/openvpn/socks.h                                                 | 2 +-
 src/openvpn/ssl.c                                                   | 4 ++--
 src/openvpn/ssl.h                                                   | 4 ++--
 src/openvpn/ssl_backend.h                                           | 4 ++--
 src/openvpn/ssl_common.h                                            | 4 ++--
 src/openvpn/ssl_mbedtls.c                                           | 4 ++--
 src/openvpn/ssl_mbedtls.h                                           | 4 ++--
 src/openvpn/ssl_openssl.c                                           | 4 ++--
 src/openvpn/ssl_openssl.h                                           | 4 ++--
 src/openvpn/ssl_verify.c                                            | 4 ++--
 src/openvpn/ssl_verify.h                                            | 4 ++--
 src/openvpn/ssl_verify_backend.h                                    | 4 ++--
 src/openvpn/ssl_verify_mbedtls.c                                    | 4 ++--
 src/openvpn/ssl_verify_mbedtls.h                                    | 4 ++--
 src/openvpn/ssl_verify_openssl.c                                    | 4 ++--
 src/openvpn/ssl_verify_openssl.h                                    | 4 ++--
 src/openvpn/status.c                                                | 2 +-
 src/openvpn/status.h                                                | 2 +-
 src/openvpn/syshead.h                                               | 2 +-
 src/openvpn/tls_crypt.c                                             | 2 +-
 src/openvpn/tls_crypt.h                                             | 2 +-
 src/openvpn/tun.c                                                   | 2 +-
 src/openvpn/tun.h                                                   | 2 +-
 src/openvpn/win32.c                                                 | 2 +-
 src/openvpn/win32.h                                                 | 2 +-
 src/openvpnserv/Makefile.am                                         | 2 +-
 src/openvpnserv/automatic.c                                         | 2 +-
 src/openvpnserv/common.c                                            | 2 +-
 src/openvpnserv/interactive.c                                       | 2 +-
 src/openvpnserv/service.h                                           | 2 +-
 src/plugins/Makefile.am                                             | 2 +-
 src/plugins/auth-pam/auth-pam.c                                     | 2 +-
 src/plugins/auth-pam/utils.c                                        | 2 +-
 src/plugins/auth-pam/utils.h                                        | 2 +-
 src/plugins/down-root/down-root.c                                   | 2 +-
 tests/Makefile.am                                                   | 2 +-
 tests/unit_tests/openvpn/mock_msg.c                                 | 2 +-
 tests/unit_tests/openvpn/mock_msg.h                                 | 2 +-
 tests/unit_tests/openvpn/test_buffer.c                              | 2 +-
 tests/unit_tests/openvpn/test_tls_crypt.c                           | 2 +-
 217 files changed, 252 insertions(+), 252 deletions(-)

diff --git a/COPYING b/COPYING
index f88ad79b..7b2fd47c 100644
--- a/COPYING
+++ b/COPYING
@@ -1,6 +1,6 @@
 OpenVPN (TM) -- An Open Source VPN daemon
 
-Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 
 This distribution contains multiple components, some
 of which fall under different licenses.  By using OpenVPN
diff --git a/ChangeLog b/ChangeLog
index 8ae08637..bf561004 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,5 +1,5 @@
 OpenVPN Change Log
-Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 
 2016.12.16 -- Version 2.4_rc2
 David Sommerseth (9):
diff --git a/Makefile.am b/Makefile.am
index 773b7867..ef18172d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #  Copyright (C) 2010      David Sommerseth <dazo@...384...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
diff --git a/PORTS b/PORTS
index 5a9de662..ed6e4a95 100644
--- a/PORTS
+++ b/PORTS
@@ -1,5 +1,5 @@
 OpenVPN
-Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 
   OpenVPN has been written to try to avoid features
   that are not standardized well across different
diff --git a/README b/README
index 103a75a6..9a9cf19d 100644
--- a/README
+++ b/README
@@ -1,6 +1,6 @@
 OpenVPN -- A Secure tunneling daemon
 
-Copyright (C) 2002-2010 OpenVPN Technologies, Inc. This program is free software;
+Copyright (C) 2002-2018 OpenVPN Technologies, Inc. This program is free software;
 you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2
 as published by the Free Software Foundation.
diff --git a/build/Makefile.am b/build/Makefile.am
index 4191a994..093d688b 100644
--- a/build/Makefile.am
+++ b/build/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/build/msvc/Makefile.am b/build/msvc/Makefile.am
index 85a613b2..34886c3f 100644
--- a/build/msvc/Makefile.am
+++ b/build/msvc/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-generate/Makefile.am
index 2151b423..f11ebed3 100644
--- a/build/msvc/msvc-generate/Makefile.am
+++ b/build/msvc/msvc-generate/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/configure.ac b/configure.ac
index 2c1937e5..fe8386b5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,7 +4,7 @@ dnl             session authentication and key exchange,
 dnl             packet encryption, packet authentication, and
 dnl             packet compression.
 dnl
-dnl  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+dnl  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 dnl  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 dnl
 dnl  This program is free software; you can redistribute it and/or modify
diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarballs.sh
index f9c620e3..64c7692d 100755
--- a/dev-tools/gen-release-tarballs.sh
+++ b/dev-tools/gen-release-tarballs.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # gen-release-tarballs.sh  -  Generates release tarballs with signatures
 #
-# Copyright (C) 2017 - David Sommerseth <davids@...515...>
+# Copyright (C) 2017-2018 David Sommerseth <davids@...515...>
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
index e253ab2b..01f10338 100755
--- a/dev-tools/reformat-all.sh
+++ b/dev-tools/reformat-all.sh
@@ -2,7 +2,7 @@
 # reformat-all.sh - Reformat all git files in the checked out
 #                   git branch using uncrustify.
 #
-# Copyright (C) 2016-2017 - David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2018 David Sommerseth <davids@...515...>
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
index eb0e5540..709a5b37 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/distro/rpm/Makefile.am b/distro/rpm/Makefile.am
index 37ee099a..3b4f1e6e 100644
--- a/distro/rpm/Makefile.am
+++ b/distro/rpm/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index 5da926b6..f6be928a 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2017-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #
 
 %.service: %.service.in Makefile
diff --git a/doc/Makefile.am b/doc/Makefile.am
index f9e7f4ae..55521f96 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
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
index 2b5cab12..b37992aa 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4,7 +4,7 @@
 .\"             packet encryption, packet authentication, and
 .\"             packet compression.
 .\"
-.\"  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+.\"  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 .\"
 .\"  This program is free software; you can redistribute it and/or modify
 .\"  it under the terms of the GNU General Public License version 2
@@ -33,7 +33,7 @@
 .\" .ft -- normal face
 .\" .in +|-{n} -- indent
 .\"
-.TH openvpn 8 "04 April 2017"
+.TH openvpn 8 "29 January 2018"
 .\"*********************************************************
 .SH NAME
 openvpn \- secure IP tunnel daemon.
@@ -7284,7 +7284,7 @@ For more information on the LZO real\-time compression library see
 .I http://www.oberhumer.com/opensource/lzo/
 .\"*********************************************************
 .SH COPYRIGHT
-Copyright (C) 2002\-2017 OpenVPN Technologies, Inc. This program is free software;
+Copyright (C) 2002\-2018 OpenVPN Technologies, Inc. This program is free software;
 you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2
 as published by the Free Software Foundation.
diff --git a/include/Makefile.am b/include/Makefile.am
index a52c4278..52a1c107 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
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
index f43f74b1..71c08c49 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/Makefile.am b/sample/Makefile.am
index 58ae9658..50b22b4e 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index 4960497a..aa65f585 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 8ee78c53..004b8fa3 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index c59027f8..47ba9f43 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 3ff80290..8e58c3a9 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010 David Sommerseth <dazo@...384...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
index 0a05240f..cea8b700 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/Makefile.am b/src/Makefile.am
index eb5b0070..94d15fcb 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 444a8f8b..b5c546da 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index fb57f2da..0e7e668b 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 1a2f42e1..8eace4ff 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 95bdfeac..ede36419 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 7d0754c9..8c3d1b44 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index 3aa69ca2..4ab1a612 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index 8d5011d8..dd822a6e 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *                2015-2016  <iam@...2070...>
  *                2016 Selva Nair <selva.nair@...277...>
  *
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index cfe6f2ce..134c2c5f 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index e588b807..54dba52d 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index 386e18df..2a5d84ad 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 633cec61..8864577a 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index e0cfad5b..eeab36a9 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index 4ea3938d..397f15a5 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 9598853f..48b937ed 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2013-2017 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2013-2018 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
index c256ba55..748ea9c5 100644
--- a/src/openvpn/comp-lz4.h
+++ b/src/openvpn/comp-lz4.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2013-2017 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2013-2018 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 4cda7e5e..7ed59022 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index e56fd2b6..18582621 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index ca90924e..8061b7ac 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 7e170241..2ad441f7 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2018 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 3f74e77e..4a651bce 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2018 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index f005ed74..8a35e100 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2014-2015  David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2018 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 3096f3b0..83b06a4a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 8e8ee8f5..eadd4372 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 567fd9b2..5d610d45 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 8fc252f9..4e173279 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 4417b924..496411af 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 20a519ec..86b06cf0 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 60a28123..c5ec9eae 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index a2a54540..2b362270 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index dc41658e..33ea1042 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 5bb043b2..0dbff0b4 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 26455455..6658b424 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 023cec46..7f001c1a 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 2fb112b8..7ef56caa 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index ff795f4c..b1947762 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 56e2250a..51a91d84 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index b6d71011..08d1537f 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
index c977120e..da435063 100644
--- a/src/openvpn/forward-inline.h
+++ b/src/openvpn/forward-inline.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 9bf9483e..d87a803c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 9fde5a30..c71e7655 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 84f01214..1524dea6 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index 90ba8f76..164146f9 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index e85ce9cf..773c6ecb 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h
index 8b23b345..32379fd2 100644
--- a/src/openvpn/gremlin.h
+++ b/src/openvpn/gremlin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 17d15285..6382b9b2 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
index c5b438b5..e85bf260 100644
--- a/src/openvpn/helper.h
+++ b/src/openvpn/helper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index c553f939..8ad56336 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index aae7b8c4..b1ec4186 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index abf8da22..b58bbc92 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 15feb677..3ce35939 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 9bb00a38..11382bf2 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index 16343865..152cfdb9 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index dd5dfbc8..64c8d490 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 91765d20..eb430e6a 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index c808efa6..02883ad6 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index f7548656..cdbd5b5a 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index deaeb8df..d33b238c 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 650f9e08..f14a04ea 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 364488f4..029c2a60 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index f969a2b5..2c8d7429 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index e0643de1..09ede5f3 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index 0ba695f2..6440e993 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 76b592f8..23ac8fc2 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2017 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2018 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index ec20ee7e..99c18228 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index bf174ad4..5a1353bd 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 6a85b0e2..395a0862 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index c36e0046..46520ec8 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 0de2042a..2a625645 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
index 9b091886..df090356 100644
--- a/src/openvpn/mstats.c
+++ b/src/openvpn/mstats.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.h b/src/openvpn/mstats.h
index 486035fb..7cc619ca 100644
--- a/src/openvpn/mstats.h
+++ b/src/openvpn/mstats.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 3cb52113..eabf7f4c 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 79dcb136..9b81e8af 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 44bef681..88c1aa0c 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index d1e8c186..4a505b72 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index eb28ca2b..aca1e40f 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index b9ceaf7b..a962d6dc 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 25b2d097..e499f35d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 63afbaf0..67d76ee7 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ-inline.h b/src/openvpn/occ-inline.h
index 0fa8e5ba..301ffae3 100644
--- a/src/openvpn/occ-inline.h
+++ b/src/openvpn/occ-inline.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 40f7e768..ec0fd30c 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 12d7bc57..63b04fa8 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index c94341a5..0250c2b5 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index e237ee50..cc67e772 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index db168425..19df3e78 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 220c2e5f..3927b79f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -4090,7 +4090,7 @@ usage_version(void)
     show_windows_version( M_INFO|M_NOPREFIX );
 #endif
     msg(M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
-    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>");
+    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>");
 #ifndef ENABLE_SMALL
 #ifdef CONFIGURE_DEFINES
     msg(M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f70760cf..e167f7d4 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index d741ae07..710fc958 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 87314725..2204f193 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 4c3696de..32eea236 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index cde76483..cb42f22a 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index 16cf7492..997f9c2b 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
index ae5ae082..15448526 100644
--- a/src/openvpn/perf.h
+++ b/src/openvpn/perf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pf-inline.h b/src/openvpn/pf-inline.h
index ac19ac4c..e308ab91 100644
--- a/src/openvpn/pf-inline.h
+++ b/src/openvpn/pf-inline.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 6e4107c5..9c68e02f 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
index b839fd2e..38504e13 100644
--- a/src/openvpn/pf.h
+++ b/src/openvpn/pf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping-inline.h b/src/openvpn/ping-inline.h
index 0642b851..1ffcd7ab 100644
--- a/src/openvpn/ping-inline.h
+++ b/src/openvpn/ping-inline.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index 728d6c2a..2f26ab07 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 5bd5c089..556ee7ad 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index a0d0906a..8664ecdd 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index f1722c0e..a23c94c0 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index b47b757d..98a5425d 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 45372e48..c16f3a16 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index c37425b6..729d87cb 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index e942ba94..0810e3ad 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index cd2bbc92..94c09d38 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 7387f8be..819bf1bc 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index c9bf03bc..eeaeb5c2 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index a8f15b96..54c8d013 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index ee91d82b..b327b864 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 2cbea3ab..11aac825 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 57f25c90..b49d8fd3 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index de0188a9..e9f2609f 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 3ce79dea..1c2ceaf5 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 5136a20c..c239c8ba 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index b8c6853c..cd208765 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e7aecbb7..4f85eae7 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 4d42e81f..2aa4704d 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
index 57216b2f..0ab3891b 100644
--- a/src/openvpn/pushlist.h
+++ b/src/openvpn/pushlist.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 972af618..0875108b 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 0585d8b7..16474ff6 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index fe541b7d..b15be656 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 6414d6c9..d6d0a5ba 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index b1ba5d4e..1855f74a 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index e6c1b7eb..c03a0e98 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index bc3c42af..9c75d7f4 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
index df9167c3..93ef80fd 100644
--- a/src/openvpn/session_id.h
+++ b/src/openvpn/session_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index de2da6db..cb802e84 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 34f316fd..b50562da 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 87cef71e..7481bb21 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 7c41070c..7964e240 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0fc91f21..767756e3 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2d7f2187..48707451 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 92747ec6..821f863e 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 39b96c50..9162e99b 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index dff7e22d..09d5ea37 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index dd1ab0fd..1c6c6bb8 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 2b83febc..9c783d62 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 60ed5f8a..db00cf32 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index d503162a..6563f2c6 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *  Copyright (C) 2006-2010, Brainspark B.V.
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 341da7d4..7d0c0b36 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 01be656b..16d64653 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 0377fea2..4a401443 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 5ae4fbba..4f109685 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index b17402b0..2cf81715 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index e8eaabe9..884587f1 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 5c4ad19e..d15ae6c6 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
index 2fba362f..7ac4b695 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 238292fa..a583589d 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index 4c8dbeb7..43776a14 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index d2f0b133..cf90b81b 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index 81999356..268f2ffa 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 221eed81..7369d1c1 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
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
index 2644d996..96ccd803 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 8782d697..3b90c488 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 4b20298b..62e6b44f 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 7fc57ccc..ece23258 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 21efc7c5..89a224bd 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 6f82b4e9..373b85e0 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
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
index 7898aae2..fbc32f90 100644
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
index ca904963..13961767 100644
--- a/src/plugins/Makefile.am
+++ b/src/plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index ae514d79..488feed7 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index 4b900c7a..288efccf 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index c0b4b105..35f28ee6 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index 41981848..64d03266 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2013      David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 53313de4..468dd5a3 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2002-2018 OpenVPN Technologies, Inc. <sales@...515...>
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
index 743e586d..d083b78f 100644
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

