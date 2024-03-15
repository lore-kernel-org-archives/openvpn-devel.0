From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 15 Mar 2024 18:00:54 +0100
Message-Id: <20240315170054.2368254-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update Copyright statements to 2024
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

Change-Id: Ic377958d303b1dcfa9d877d3a63ecf39bdff7aef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 COPYING                                                     | 2 +-
 ChangeLog                                                   | 2 +-
 Makefile.am                                                 | 4 ++--
 PORTS                                                       | 2 +-
 configure.ac                                                | 2 +-
 contrib/cmake/git-version.py                                | 2 +-
 contrib/cmake/parse-version.m4.py                           | 2 +-
 dev-tools/gen-release-tarballs.sh                           | 2 +-
 dev-tools/gerrit-send-mail.py                               | 4 ++--
 dev-tools/reformat-all.sh                                   | 2 +-
 dev-tools/update-copyright.sh                               | 4 ++--
 distro/Makefile.am                                          | 2 +-
 distro/systemd/Makefile.am                                  | 2 +-
 doc/Makefile.am                                             | 2 +-
 include/Makefile.am                                         | 2 +-
 include/openvpn-msg.h                                       | 2 +-
 include/openvpn-plugin.h.in                                 | 2 +-
 sample/Makefile.am                                          | 2 +-
 sample/sample-keys/gen-sample-keys.sh                       | 2 +-
 sample/sample-plugins/Makefile.am                           | 2 +-
 sample/sample-plugins/Makefile.plugins                      | 2 +-
 .../sample-plugins/client-connect/sample-client-connect.c   | 2 +-
 sample/sample-plugins/defer/multi-auth.c                    | 2 +-
 .../keying-material-exporter-demo/keyingmaterialexporter.c  | 2 +-
 sample/sample-plugins/log/log.c                             | 2 +-
 sample/sample-plugins/log/log_v3.c                          | 4 ++--
 sample/sample-plugins/simple/base64.c                       | 2 +-
 sample/sample-plugins/simple/simple.c                       | 2 +-
 src/Makefile.am                                             | 2 +-
 src/compat/Makefile.am                                      | 2 +-
 src/compat/compat-gettimeofday.c                            | 2 +-
 src/compat/compat-strsep.c                                  | 2 +-
 src/openvpn/Makefile.am                                     | 2 +-
 src/openvpn/argv.c                                          | 2 +-
 src/openvpn/argv.h                                          | 2 +-
 src/openvpn/auth_token.h                                    | 2 +-
 src/openvpn/basic.h                                         | 2 +-
 src/openvpn/block_dns.c                                     | 2 +-
 src/openvpn/block_dns.h                                     | 2 +-
 src/openvpn/buffer.c                                        | 2 +-
 src/openvpn/buffer.h                                        | 2 +-
 src/openvpn/circ_list.h                                     | 2 +-
 src/openvpn/clinat.c                                        | 2 +-
 src/openvpn/clinat.h                                        | 2 +-
 src/openvpn/common.h                                        | 2 +-
 src/openvpn/comp-lz4.c                                      | 4 ++--
 src/openvpn/comp-lz4.h                                      | 4 ++--
 src/openvpn/comp.c                                          | 2 +-
 src/openvpn/comp.h                                          | 2 +-
 src/openvpn/compstub.c                                      | 2 +-
 src/openvpn/console.c                                       | 4 ++--
 src/openvpn/console.h                                       | 4 ++--
 src/openvpn/console_builtin.c                               | 4 ++--
 src/openvpn/crypto.c                                        | 2 +-
 src/openvpn/crypto.h                                        | 2 +-
 src/openvpn/crypto_backend.h                                | 2 +-
 src/openvpn/crypto_mbedtls.c                                | 2 +-
 src/openvpn/crypto_mbedtls.h                                | 2 +-
 src/openvpn/crypto_openssl.c                                | 2 +-
 src/openvpn/crypto_openssl.h                                | 2 +-
 src/openvpn/dco.c                                           | 6 +++---
 src/openvpn/dco.h                                           | 6 +++---
 src/openvpn/dco_internal.h                                  | 4 ++--
 src/openvpn/dco_linux.c                                     | 6 +++---
 src/openvpn/dco_linux.h                                     | 6 +++---
 src/openvpn/dco_win.c                                       | 4 ++--
 src/openvpn/dco_win.h                                       | 4 ++--
 src/openvpn/dhcp.c                                          | 2 +-
 src/openvpn/dhcp.h                                          | 2 +-
 src/openvpn/dns.c                                           | 2 +-
 src/openvpn/dns.h                                           | 2 +-
 src/openvpn/env_set.c                                       | 4 ++--
 src/openvpn/env_set.h                                       | 2 +-
 src/openvpn/errlevel.h                                      | 2 +-
 src/openvpn/error.c                                         | 2 +-
 src/openvpn/error.h                                         | 2 +-
 src/openvpn/event.c                                         | 2 +-
 src/openvpn/event.h                                         | 2 +-
 src/openvpn/fdmisc.c                                        | 2 +-
 src/openvpn/fdmisc.h                                        | 2 +-
 src/openvpn/forward.c                                       | 2 +-
 src/openvpn/forward.h                                       | 2 +-
 src/openvpn/fragment.c                                      | 2 +-
 src/openvpn/fragment.h                                      | 2 +-
 src/openvpn/gremlin.c                                       | 2 +-
 src/openvpn/gremlin.h                                       | 2 +-
 src/openvpn/helper.c                                        | 2 +-
 src/openvpn/helper.h                                        | 2 +-
 src/openvpn/httpdigest.c                                    | 2 +-
 src/openvpn/httpdigest.h                                    | 2 +-
 src/openvpn/init.c                                          | 2 +-
 src/openvpn/init.h                                          | 2 +-
 src/openvpn/integer.h                                       | 2 +-
 src/openvpn/interval.c                                      | 2 +-
 src/openvpn/interval.h                                      | 2 +-
 src/openvpn/list.c                                          | 2 +-
 src/openvpn/list.h                                          | 2 +-
 src/openvpn/lzo.c                                           | 2 +-
 src/openvpn/lzo.h                                           | 2 +-
 src/openvpn/manage.c                                        | 2 +-
 src/openvpn/manage.h                                        | 2 +-
 src/openvpn/mbuf.c                                          | 2 +-
 src/openvpn/mbuf.h                                          | 2 +-
 src/openvpn/memdbg.h                                        | 2 +-
 src/openvpn/misc.c                                          | 4 ++--
 src/openvpn/misc.h                                          | 2 +-
 src/openvpn/mroute.c                                        | 2 +-
 src/openvpn/mroute.h                                        | 2 +-
 src/openvpn/mss.c                                           | 2 +-
 src/openvpn/mss.h                                           | 2 +-
 src/openvpn/mstats.c                                        | 2 +-
 src/openvpn/mstats.h                                        | 2 +-
 src/openvpn/mtcp.c                                          | 2 +-
 src/openvpn/mtcp.h                                          | 2 +-
 src/openvpn/mtu.c                                           | 2 +-
 src/openvpn/mtu.h                                           | 2 +-
 src/openvpn/mudp.c                                          | 2 +-
 src/openvpn/mudp.h                                          | 2 +-
 src/openvpn/multi.c                                         | 2 +-
 src/openvpn/multi.h                                         | 2 +-
 src/openvpn/networking.h                                    | 2 +-
 src/openvpn/networking_iproute2.c                           | 2 +-
 src/openvpn/networking_iproute2.h                           | 2 +-
 src/openvpn/networking_sitnl.c                              | 2 +-
 src/openvpn/networking_sitnl.h                              | 2 +-
 src/openvpn/occ.c                                           | 2 +-
 src/openvpn/occ.h                                           | 2 +-
 src/openvpn/openssl_compat.h                                | 2 +-
 src/openvpn/openvpn.c                                       | 2 +-
 src/openvpn/openvpn.h                                       | 2 +-
 src/openvpn/options.c                                       | 6 +++---
 src/openvpn/options.h                                       | 2 +-
 src/openvpn/options_util.c                                  | 2 +-
 src/openvpn/options_util.h                                  | 2 +-
 src/openvpn/otime.c                                         | 2 +-
 src/openvpn/otime.h                                         | 2 +-
 src/openvpn/packet_id.c                                     | 2 +-
 src/openvpn/packet_id.h                                     | 2 +-
 src/openvpn/perf.c                                          | 2 +-
 src/openvpn/perf.h                                          | 2 +-
 src/openvpn/ping.c                                          | 2 +-
 src/openvpn/ping.h                                          | 2 +-
 src/openvpn/pkcs11.c                                        | 2 +-
 src/openvpn/pkcs11.h                                        | 2 +-
 src/openvpn/pkcs11_backend.h                                | 2 +-
 src/openvpn/pkcs11_mbedtls.c                                | 2 +-
 src/openvpn/pkcs11_openssl.c                                | 2 +-
 src/openvpn/platform.c                                      | 2 +-
 src/openvpn/platform.h                                      | 2 +-
 src/openvpn/plugin.c                                        | 2 +-
 src/openvpn/plugin.h                                        | 2 +-
 src/openvpn/pool.c                                          | 2 +-
 src/openvpn/pool.h                                          | 2 +-
 src/openvpn/proto.c                                         | 2 +-
 src/openvpn/proto.h                                         | 2 +-
 src/openvpn/proxy.c                                         | 2 +-
 src/openvpn/proxy.h                                         | 2 +-
 src/openvpn/ps.c                                            | 2 +-
 src/openvpn/ps.h                                            | 2 +-
 src/openvpn/push.c                                          | 2 +-
 src/openvpn/push.h                                          | 2 +-
 src/openvpn/pushlist.h                                      | 2 +-
 src/openvpn/reflect_filter.c                                | 2 +-
 src/openvpn/reflect_filter.h                                | 2 +-
 src/openvpn/reliable.c                                      | 2 +-
 src/openvpn/reliable.h                                      | 2 +-
 src/openvpn/ring_buffer.h                                   | 2 +-
 src/openvpn/route.c                                         | 2 +-
 src/openvpn/route.h                                         | 2 +-
 src/openvpn/run_command.c                                   | 2 +-
 src/openvpn/run_command.h                                   | 2 +-
 src/openvpn/schedule.c                                      | 2 +-
 src/openvpn/schedule.h                                      | 2 +-
 src/openvpn/session_id.c                                    | 2 +-
 src/openvpn/session_id.h                                    | 2 +-
 src/openvpn/shaper.c                                        | 2 +-
 src/openvpn/shaper.h                                        | 2 +-
 src/openvpn/sig.c                                           | 4 ++--
 src/openvpn/sig.h                                           | 2 +-
 src/openvpn/socket.c                                        | 2 +-
 src/openvpn/socket.h                                        | 2 +-
 src/openvpn/socks.c                                         | 2 +-
 src/openvpn/socks.h                                         | 2 +-
 src/openvpn/ssl.c                                           | 4 ++--
 src/openvpn/ssl.h                                           | 2 +-
 src/openvpn/ssl_backend.h                                   | 2 +-
 src/openvpn/ssl_common.h                                    | 2 +-
 src/openvpn/ssl_mbedtls.c                                   | 2 +-
 src/openvpn/ssl_mbedtls.h                                   | 2 +-
 src/openvpn/ssl_ncp.c                                       | 4 ++--
 src/openvpn/ssl_ncp.h                                       | 2 +-
 src/openvpn/ssl_openssl.c                                   | 2 +-
 src/openvpn/ssl_openssl.h                                   | 2 +-
 src/openvpn/ssl_pkt.c                                       | 2 +-
 src/openvpn/ssl_pkt.h                                       | 2 +-
 src/openvpn/ssl_util.c                                      | 2 +-
 src/openvpn/ssl_util.h                                      | 2 +-
 src/openvpn/ssl_verify.c                                    | 2 +-
 src/openvpn/ssl_verify.h                                    | 2 +-
 src/openvpn/ssl_verify_backend.h                            | 2 +-
 src/openvpn/ssl_verify_mbedtls.c                            | 2 +-
 src/openvpn/ssl_verify_mbedtls.h                            | 2 +-
 src/openvpn/ssl_verify_openssl.c                            | 2 +-
 src/openvpn/ssl_verify_openssl.h                            | 2 +-
 src/openvpn/status.c                                        | 2 +-
 src/openvpn/status.h                                        | 2 +-
 src/openvpn/syshead.h                                       | 2 +-
 src/openvpn/tun.c                                           | 2 +-
 src/openvpn/tun.h                                           | 2 +-
 src/openvpn/vlan.c                                          | 2 +-
 src/openvpn/vlan.h                                          | 2 +-
 src/openvpn/win32-util.c                                    | 2 +-
 src/openvpn/win32-util.h                                    | 2 +-
 src/openvpn/win32.c                                         | 2 +-
 src/openvpn/win32.h                                         | 2 +-
 src/openvpn/xkey_common.h                                   | 2 +-
 src/openvpn/xkey_helper.c                                   | 2 +-
 src/openvpn/xkey_provider.c                                 | 2 +-
 src/openvpnmsica/Makefile.am                                | 4 ++--
 src/openvpnmsica/dllmain.c                                  | 2 +-
 src/openvpnmsica/msica_arg.c                                | 2 +-
 src/openvpnmsica/msica_arg.h                                | 2 +-
 src/openvpnmsica/msiex.c                                    | 2 +-
 src/openvpnmsica/msiex.h                                    | 2 +-
 src/openvpnmsica/openvpnmsica.c                             | 2 +-
 src/openvpnmsica/openvpnmsica.h                             | 2 +-
 src/openvpnmsica/openvpnmsica_resources.rc                  | 2 +-
 src/openvpnserv/Makefile.am                                 | 2 +-
 src/openvpnserv/common.c                                    | 2 +-
 src/openvpnserv/interactive.c                               | 2 +-
 src/openvpnserv/service.h                                   | 2 +-
 src/openvpnserv/validate.c                                  | 2 +-
 src/openvpnserv/validate.h                                  | 2 +-
 src/plugins/Makefile.am                                     | 2 +-
 src/plugins/auth-pam/auth-pam.c                             | 4 ++--
 src/plugins/auth-pam/utils.c                                | 2 +-
 src/plugins/auth-pam/utils.h                                | 2 +-
 src/plugins/down-root/down-root.c                           | 2 +-
 src/tapctl/Makefile.am                                      | 4 ++--
 src/tapctl/basic.h                                          | 4 ++--
 src/tapctl/error.c                                          | 4 ++--
 src/tapctl/error.h                                          | 4 ++--
 src/tapctl/main.c                                           | 4 ++--
 src/tapctl/tap.c                                            | 2 +-
 src/tapctl/tap.h                                            | 2 +-
 src/tapctl/tapctl_resources.rc                              | 2 +-
 tests/Makefile.am                                           | 2 +-
 tests/ntlm_support.c                                        | 2 +-
 tests/unit_tests/openvpn/cert_data.h                        | 2 +-
 tests/unit_tests/openvpn/mock_management.c                  | 2 +-
 tests/unit_tests/openvpn/mock_ssl_dependencies.c            | 2 +-
 tests/unit_tests/openvpn/mock_win32_execve.c                | 4 ++--
 tests/unit_tests/openvpn/pkey_test_utils.c                  | 2 +-
 tests/unit_tests/openvpn/test_cryptoapi.c                   | 2 +-
 tests/unit_tests/openvpn/test_misc.c                        | 2 +-
 tests/unit_tests/openvpn/test_ncp.c                         | 2 +-
 tests/unit_tests/openvpn/test_pkcs11.c                      | 2 +-
 tests/unit_tests/openvpn/test_provider.c                    | 2 +-
 tests/unit_tests/openvpn/test_ssl.c                         | 2 +-
 tests/unit_tests/openvpn/test_user_pass.c                   | 2 +-
 260 files changed, 295 insertions(+), 295 deletions(-)

diff --git a/COPYING b/COPYING
index 28525d76..00ecc27f 100644
--- a/COPYING
+++ b/COPYING
@@ -1,6 +1,6 @@
 OpenVPN (TM) -- An Open Source VPN daemon
 
-Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 
 This distribution contains multiple components, some
 of which fall under different licenses.  By using OpenVPN
diff --git a/ChangeLog b/ChangeLog
index 6a04dbb6..c26dd2e3 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,5 +1,5 @@
 OpenVPN ChangeLog
-Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 
 This file is not maintained in this branch of the OpenVPN git repository.
 
diff --git a/Makefile.am b/Makefile.am
index 792588a3..439346e5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -5,8 +5,8 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2010-2023 David Sommerseth <dazo@...2108...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2010-2024 David Sommerseth <dazo@...2108...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/PORTS b/PORTS
index dd156d04..dadc6f8e 100644
--- a/PORTS
+++ b/PORTS
@@ -1,5 +1,5 @@
 OpenVPN
-Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 
   OpenVPN has been written to try to avoid features
   that are not standardized well across different
diff --git a/configure.ac b/configure.ac
index 14f5be40..ce8b2b0e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,7 +4,7 @@ dnl             session authentication and key exchange,
 dnl             packet encryption, packet authentication, and
 dnl             packet compression.
 dnl
-dnl  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+dnl  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 dnl  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 dnl
 dnl  This program is free software; you can redistribute it and/or modify
diff --git a/contrib/cmake/git-version.py b/contrib/cmake/git-version.py
index 4f78ac42..a39cab41 100644
--- a/contrib/cmake/git-version.py
+++ b/contrib/cmake/git-version.py
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/contrib/cmake/parse-version.m4.py b/contrib/cmake/parse-version.m4.py
index 3dfb31fb..a7fbaf08 100644
--- a/contrib/cmake/parse-version.m4.py
+++ b/contrib/cmake/parse-version.m4.py
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarballs.sh
index 13c58111..32bee80d 100755
--- a/dev-tools/gen-release-tarballs.sh
+++ b/dev-tools/gen-release-tarballs.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # gen-release-tarballs.sh  -  Generates release tarballs with signatures
 #
-# Copyright (C) 2017-2023 - David Sommerseth <davids@...515...>
+# Copyright (C) 2017-2024 - David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index 10305e26..b5817650 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
-#  Copyright (C) 2023 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2023 Frank Lichtenheld <frank.lichtenheld@...515...>
+#  Copyright (C) 2023-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2023-2024 Frank Lichtenheld <frank.lichtenheld@...515...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
index ed472289..42d73686 100755
--- a/dev-tools/reformat-all.sh
+++ b/dev-tools/reformat-all.sh
@@ -2,7 +2,7 @@
 # reformat-all.sh - Reformat all git files in the checked out
 #                   git branch using uncrustify.
 #
-# Copyright (C) 2016-2023 - David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2024 - David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
index 50fcd098..f126ad5a 100755
--- a/dev-tools/update-copyright.sh
+++ b/dev-tools/update-copyright.sh
@@ -2,8 +2,8 @@
 # update-copyright-sh - Simple tool to update the Copyright lines
 #                       in all files checked into git
 #
-# Copyright (C) 2016-2023 OpenVPN Inc <sales@...515...>
-# Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2024 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/distro/Makefile.am b/distro/Makefile.am
index 177dcee4..7a588dac 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index d1c903f2..8503a0c0 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2017-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2017-2024 OpenVPN Inc <sales@...515...>
 #
 
 %.service: %.service.in Makefile
diff --git a/doc/Makefile.am b/doc/Makefile.am
index 087f0cee..634e4cef 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/include/Makefile.am b/include/Makefile.am
index e0d49867..3e93bf02 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index a1464cd1..657eb5e5 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2023 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2024 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index ffbdbfcb..cacef44a 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/Makefile.am b/sample/Makefile.am
index 10f199b6..e8799c4f 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index fcd9166e..726ba4a6 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -3,7 +3,7 @@
 # Run this script to set up a test CA, and test key-certificate pair for a
 # server, and various clients.
 #
-# Copyright (C) 2014-2023 Steffan Karger <steffan@...1856...>
+# Copyright (C) 2014-2024 Steffan Karger <steffan@...1856...>
 set -eu
 
 command -v openssl >/dev/null 2>&1 || { echo >&2 "Unable to find openssl. Please make sure openssl is installed and in your path."; exit 1; }
diff --git a/sample/sample-plugins/Makefile.am b/sample/sample-plugins/Makefile.am
index 3d66ab82..799fe4cd 100644
--- a/sample/sample-plugins/Makefile.am
+++ b/sample/sample-plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/sample/sample-plugins/Makefile.plugins b/sample/sample-plugins/Makefile.plugins
index 1ef5b000..3d2ec469 100644
--- a/sample/sample-plugins/Makefile.plugins
+++ b/sample/sample-plugins/Makefile.plugins
@@ -1,6 +1,6 @@
 #  SPDX-License-Identifier: GPL-2.0-only
 #
-#  Copyright (C) 2020-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2020-2024 OpenVPN Inc <sales@...515...>
 #
 
 #
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index eb242126..10377581 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c
index c7f3e263..2c482799 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 71badf2c..a1b622a0 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index 4b62fa80..0debd2b2 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index de726120..4601e2a6 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2023 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2024 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
index 553facda..daafc415 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2017-2023 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2017-2024 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
index 2ba636df..7a532244 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/Makefile.am b/src/Makefile.am
index a1f590fc..9fbdd409 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 5298dd86..83bf423c 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index 69843fb4..b03fd5a8 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/compat/compat-strsep.c b/src/compat/compat-strsep.c
index fbad98d3..e0b613b2 100644
--- a/src/compat/compat-strsep.c
+++ b/src/compat/compat-strsep.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2019-2023 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2019-2024 Arne Schwabe <arne@...1227...>
  *  Copyright (C) 1992-2019 Free Software Foundation, Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 1dc1dda2..7ceec0c9 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 50083baf..b87a42f6 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 4e3abccb..08b73688 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 9ec2e64c..e024f952 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index f6d07ddb..d1075b29 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index 05b2599c..5f4925f5 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *                2015-2016  <iam@...2070...>
  *                2016 Selva Nair <selva.nair@...277...>
  *
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
index 89b88d6c..68fea836 100644
--- a/src/openvpn/block_dns.h
+++ b/src/openvpn/block_dns.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 2ad34615..66fd63f9 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 61fc3a57..7c2f75a6 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index 7469acd9..41db0a96 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 2b91f7b1..2d3b359f 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index ef872701..94141f51 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index f77685c8..3a84541c 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 33a480cc..ac020a44 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2013-2023 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2024 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
index 5f16c586..38f76d43 100644
--- a/src/openvpn/comp-lz4.h
+++ b/src/openvpn/comp-lz4.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2013-2023 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2024 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 311f3e91..21c6fd8b 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 89940cf3..267f680b 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index adb1f28a..449a6e8e 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 5b367f23..fdfb0014 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 35dc684e..7358299d 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index b5264d8e..6af7a3ec 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015  David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 2fca1315..5d05cc42 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 42015243..85a0bfe9 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index a5371c83..8d37e64f 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index f4c1cd29..1a397528 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index cfb39a49..46f76e25 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 4fd5e6b8..50683b67 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index c5a53934..c0e95b48 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 14430d33..d7c9d48c 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2023 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2021-2023 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2021-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2021-2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2024 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2021-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 96d95c21..50ebb359 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2023 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2021-2023 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2021-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2021-2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2024 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2021-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 7afcfc44..624c1105 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2023 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2024 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3c91606b..b2584b97 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1,9 +1,9 @@
 /*
  *  Interface to linux dco networking code
  *
- *  Copyright (C) 2020-2023 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2020-2023 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2024 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020-2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index d28e3658..511519ae 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -1,9 +1,9 @@
 /*
  *  Interface to linux dco networking code
  *
- *  Copyright (C) 2020-2023 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2020-2023 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2024 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020-2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index a775c829..e3ada76a 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -1,8 +1,8 @@
 /*
  *  Interface to ovpn-win-dco networking code
  *
- *  Copyright (C) 2020-2023 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index f20c47eb..48836299 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -1,8 +1,8 @@
 /*
  *  Interface to ovpn-win-dco networking code
  *
- *  Copyright (C) 2020-2023 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index ac7f538c..f137b018 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index 1557439c..dabefd29 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index e073d0e8..7de39916 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index e4978579..a4ccb950 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 97b011fb..b13d01e1 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index 45999771..4294d6ea 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 1a4a8bf8..bf2e54e1 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 56addff7..245a2d51 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index be3484df..ab2872ae 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 6b6f9514..a81ca1e1 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 62828733..856551ad 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 3570ed4e..3d664ac0 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index d0f0ee41..8299f67b 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 556c465d..8d10f253 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index bc00ba51..6fb5a189 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 974ebda1..2158a0bf 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index 2d13dbb7..c3eb2ef9 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index 501d70cf..99ad803c 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h
index f4ef6159..27213fd9 100644
--- a/src/openvpn/gremlin.h
+++ b/src/openvpn/gremlin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index fa011ffb..1bab84c4 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
index 5f7a787b..d0fd17dd 100644
--- a/src/openvpn/helper.h
+++ b/src/openvpn/helper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 5c255b22..59fb777e 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index bb69a1f6..a3458ddf 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 52b3931b..6209fa8f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 7731f5a0..ea7eb301 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index a0125242..a1acaf94 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index bde9dd99..8821e0b8 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index 38e44343..06db7799 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index dc4b1df3..69f1510c 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 18afc546..6af7262d 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 19017802..b313284d 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index f05c0025..e951b49b 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 27b6f90e..43c55079 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 07317a40..18965108 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 318b9eda..823babda 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index 8227d0c1..e6c91629 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index 6bb4d1be..c1fba483 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index ac6df65e..3ff0857e 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 5ae61b5f..cb3bf68b 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 91af2b60..f4539dcf 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index a06e8724..bc584933 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 1566c64e..635557cc 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index b2a68cf7..b5a0a98a 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
index 04be449e..8ab02d57 100644
--- a/src/openvpn/mstats.c
+++ b/src/openvpn/mstats.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.h b/src/openvpn/mstats.h
index 91bac6cb..6b444310 100644
--- a/src/openvpn/mstats.h
+++ b/src/openvpn/mstats.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 62eb14b9..96408d11 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index bacf7239..886d2cc1 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index e1e8e028..269a9ef6 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index c64398de..97aafc63 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index e6c99ae5..268b430e 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 8383c64d..14e90d00 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 712456c8..162b23ef 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 6b1c68d6..7167639e 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index a7377d56..f06d6df7 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2023 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2024 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 9d2351cd..975282ca 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -1,7 +1,7 @@
 /*
  *  Networking API implementation for iproute2
  *
- *  Copyright (C) 2018-2023 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2018-2024 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_iproute2.h b/src/openvpn/networking_iproute2.h
index 88fbd549..c2c2e747 100644
--- a/src/openvpn/networking_iproute2.h
+++ b/src/openvpn/networking_iproute2.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2023 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2024 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 662e0e2d..f53f5ee9 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1,7 +1,7 @@
 /*
  *  Simplified Interface To NetLink
  *
- *  Copyright (C) 2016-2023 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2024 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
index 85f8061f..d48a3ea2 100644
--- a/src/openvpn/networking_sitnl.h
+++ b/src/openvpn/networking_sitnl.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2023 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2024 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 2871449e..00c6c3c8 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index e382482f..11ecab6d 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index f487b1bc..c9fa7196 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 874facf6..0e85ebc2 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index df93b0e0..e98c93e9 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 94a88f94..768332d1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2008-2023 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2008-2024 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -4888,7 +4888,7 @@ usage_version(void)
 #endif
     show_dco_version(M_INFO | M_NOPREFIX);
     msg(M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
-    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>");
+    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>");
 #ifndef ENABLE_SMALL
 #ifdef CONFIGURE_DEFINES
     msg(M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2b37d1fc..f608cb86 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 3660da06..a9e020a0 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 5115880b..29bc9dc4 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index b28a90f9..3cde5741 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index c27be892..c37673ef 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index ef832488..be28999b 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index af62c89d..558361a3 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index ca4f810d..02e4e75d 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
index 3d92e6fe..04abe891 100644
--- a/src/openvpn/perf.h
+++ b/src/openvpn/perf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index ccf9870a..b577b54f 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 6243cf6b..887172c4 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index cfe6cf6d..35a02c27 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index 0365fbc4..3caedc00 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index 8a95c33f..df5259ff 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 7e4be144..2f1b1acd 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 1824c6bb..a013b3f1 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 62acabe2..9853dacc 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index d8dad74b..181cb71d 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index b4d4a986..37721866 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index ee780d8e..ad2e0866 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 5ab0f95b..f706c1ab 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index bf0f603c..d4573b2c 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index cab60c3a..161c4866 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 65c80804..4b6d6d6e 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index eeb39892..c9043014 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 4e78772b..a502c9de 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 4659e17d..7d9f9b51 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index 2fe0c4c5..f0d4d7d7 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 22494340..1b406b9c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index f43ab096..4a133279 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
index 9585bc7e..d5ace296 100644
--- a/src/openvpn/pushlist.h
+++ b/src/openvpn/pushlist.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
index 0db456bc..538bbbcf 100644
--- a/src/openvpn/reflect_filter.c
+++ b/src/openvpn/reflect_filter.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reflect_filter.h b/src/openvpn/reflect_filter.h
index b708d4fd..12eb0a15 100644
--- a/src/openvpn/reflect_filter.h
+++ b/src/openvpn/reflect_filter.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index e7d4d5f8..a789990f 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 349b3510..766c07d7 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h
index e86162a4..c536980a 100644
--- a/src/openvpn/ring_buffer.h
+++ b/src/openvpn/ring_buffer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *                2019 Lev Stipakov <lev@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6c027d9f..909d6d2f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 71b4cf4e..eb98c71e 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 864b317d..292e81f7 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index 3891fdb2..52ab1155 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index e1bc24ae..b1385e00 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index 967eab23..03132c4c 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index 25c5faa8..ada5000f 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
index 8b139319..5f078c39 100644
--- a/src/openvpn/session_id.h
+++ b/src/openvpn/session_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index c65dec8f..f8a498d0 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 7cffcea5..8eb8db12 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 7f13c6cd..cfbd942b 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2016-2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 54c59950..48ded1d4 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 480f4e51..57eaee21 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index bfc1253b..47083ad3 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index a29eb83a..d842666e 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 3a89245b..9a8da063 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33c86704..7895a37a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
- *  Copyright (C) 2008-2023 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2008-2024 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 71b99dbe..98e59e88 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index b9466ce1..8c3403ca 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f085e0da..5a7dd605 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index cc884847..b44ddd59 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *  Copyright (C) 2006-2010, Brainspark B.V.
  *
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index eb4974b7..1fd0ce85 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 0ca6d42b..73ec9f5d 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
- *  Copyright (C) 2008-2023 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2008-2024 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index de7a0e44..afbe331b 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 9b6027cc..4383e981 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 3889ceff..cf00478a 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index afc5aab3..2ec0b2ff 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index ef4852e5..88b9e8c3 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index 447e739c..1ee49880 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index b3eaf9ff..e858d64c 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 75a4b2ec..c7d77993 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 06627d00..7012f416 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 5301a51d..550b3c31 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 24a89c31..a801cd3d 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
index 68984da5..d2ba6b67 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 00fdec31..ec3a7cf5 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index b2145b62..a73b8101 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 0cb44083..6a5d84eb 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index 1a9ea3de..80004b02 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index d2859fe0..83a48fc7 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8e961497..f550e9c2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index e19e1a2e..33b9552b 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 0bb7abc8..dd1365bd 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
index f70e2975..7a474f10 100644
--- a/src/openvpn/vlan.h
+++ b/src/openvpn/vlan.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index c5e75050..1aa00694 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
index 98bf74b9..14e335ac 100644
--- a/src/openvpn/win32-util.h
+++ b/src/openvpn/win32-util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 6b7ba5e4..9dae562e 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index aa8513b2..63307c76 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 51cdb5b7..9017cd0c 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 40839f28..c8033232 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index db316feb..f5fc9568 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index b10ce823..40f0cd0f 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -1,8 +1,8 @@
 #
 #  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 1bf3d564..e7379562 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
index d1eb4046..7c60983b 100644
--- a/src/openvpnmsica/msica_arg.c
+++ b/src/openvpnmsica/msica_arg.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h
index 44beee14..6cd272c1 100644
--- a/src/openvpnmsica/msica_arg.h
+++ b/src/openvpnmsica/msica_arg.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index 78017eb3..e29a60d4 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h
index 79664e2c..6d84de5b 100644
--- a/src/openvpnmsica/msiex.h
+++ b/src/openvpnmsica/msiex.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index e5312d69..5ffb5b3e 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 05889cc8..6640d7ea 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/openvpnmsica_resources.rc
index e30c8a14..f9726439 100644
--- a/src/openvpnmsica/openvpnmsica_resources.rc
+++ b/src/openvpnmsica/openvpnmsica_resources.rc
@@ -1,7 +1,7 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 0c64cce8..33d2d01a 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index bb237a2b..bd0a484e 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2011-2023 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2011-2024 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a6a2c7c6..e861e48e 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2012-2023 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2012-2024 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index d38a6652..3acf08cb 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2023 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2024 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 341524ed..5f7acd74 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index 363e1fb0..a9f1b9d8 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -6,7 +6,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/Makefile.am b/src/plugins/Makefile.am
index 61d6cb45..a9f9d01f 100644
--- a/src/plugins/Makefile.am
+++ b/src/plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 949b0eb5..54cab335 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2016-2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index 30ddf4b5..97befd67 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index f6627099..3eac9365 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index 1bb64931..384bc81a 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2013      David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index 4c2958b7..f3851ac9 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -1,8 +1,8 @@
 #
 #  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index 05a0ebb8..ca69aabb 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -2,8 +2,8 @@
  *  basic -- Basic macros
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/error.c b/src/tapctl/error.c
index 33a3e69d..1af1f8f9 100644
--- a/src/tapctl/error.c
+++ b/src/tapctl/error.c
@@ -2,8 +2,8 @@
  *  error -- OpenVPN compatible error reporting API
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index cd466caf..6631c0bc 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -2,8 +2,8 @@
  *  error -- OpenVPN compatible error reporting API
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index a946c2ca..9bfc870e 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -2,8 +2,8 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 5ae80443..2e535969 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 45de8749..9c403cce 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tapctl_resources.rc b/src/tapctl/tapctl_resources.rc
index c49f82d8..28d07519 100644
--- a/src/tapctl/tapctl_resources.rc
+++ b/src/tapctl/tapctl_resources.rc
@@ -1,7 +1,7 @@
 /*
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *
- *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 6bc02b4f..28857520 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c
index 2d7da861..ccf89624 100644
--- a/tests/ntlm_support.c
+++ b/tests/ntlm_support.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- * Copyright (C) 2023 OpenVPN Inc <sales@...515...>
+ * Copyright (C) 2023-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvpn/cert_data.h
index 0886b071..d1cccbe9 100644
--- a/tests/unit_tests/openvpn/cert_data.h
+++ b/tests/unit_tests/openvpn/cert_data.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/openvpn/mock_management.c
index 8936c3a1..dbbb56af 100644
--- a/tests/unit_tests/openvpn/mock_management.c
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
index 9231d655..ac677a6e 100644
--- a/tests/unit_tests/openvpn/mock_ssl_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_win32_execve.c b/tests/unit_tests/openvpn/mock_win32_execve.c
index 4d37ebe3..e8294e80 100644
--- a/tests/unit_tests/openvpn/mock_win32_execve.c
+++ b/tests/unit_tests/openvpn/mock_win32_execve.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2023 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2023-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2023-2024 Arne Schwabe <arne@...1227...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/tests/unit_tests/openvpn/pkey_test_utils.c b/tests/unit_tests/openvpn/pkey_test_utils.c
index dd0a7311..f66b9a41 100644
--- a/tests/unit_tests/openvpn/pkey_test_utils.c
+++ b/tests/unit_tests/openvpn/pkey_test_utils.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index e0479a8c..87f62086 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 04dbd5a6..563d4aef 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2023 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2024 Arne Schwabe <arne@...1227...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index ecf1e399..a8e10215 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2019-2023 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2019-2024 Arne Schwabe <arne@...1227...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 81cdf882..a48e404d 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 94deab6f..934b2d3b 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2023 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2024 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 8c1fb5b2..a9a31379 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- * Copyright (C) 2023 OpenVPN Inc <sales@...515...>
+ * Copyright (C) 2023-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index 5d3f9b6e..ac846546 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2023-2024 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
-- 
2.34.1


