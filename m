From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 10 Jan 2023 17:05:31 +0100
Message-Id: <20230110160531.81010-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update copyright year to 2023
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

Manually excluded ovpn_dco_win.h because it is an
imported file. ovpn_dco_linux.h is already excluded
because it still says 2021.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 COPYING                                                     | 2 +-
 ChangeLog                                                   | 2 +-
 Makefile.am                                                 | 4 ++--
 PORTS                                                       | 2 +-
 build/Makefile.am                                           | 2 +-
 build/msvc/Makefile.am                                      | 2 +-
 build/msvc/msvc-generate/Makefile.am                        | 2 +-
 build/msvc/msvc-generate/Makefile.mak                       | 2 +-
 build/msvc/msvc-generate/git-version.py                     | 2 +-
 configure.ac                                                | 2 +-
 dev-tools/gen-release-tarballs.sh                           | 2 +-
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
 src/openvpn/sig.c                                           | 2 +-
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
 tests/unit_tests/openvpn/test_misc.c                        | 2 +-
 tests/unit_tests/openvpn/test_ncp.c                         | 2 +-
 tests/unit_tests/openvpn/test_provider.c                    | 2 +-
 252 files changed, 284 insertions(+), 284 deletions(-)

diff --git a/COPYING b/COPYING
index 62e1a9d3..e12c5141 100644
--- a/COPYING
+++ b/COPYING
@@ -1,6 +1,6 @@
 OpenVPN (TM) -- An Open Source VPN daemon
 
-Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 
 This distribution contains multiple components, some
 of which fall under different licenses.  By using OpenVPN
diff --git a/ChangeLog b/ChangeLog
index 2685d330..6a04dbb6 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,5 +1,5 @@
 OpenVPN ChangeLog
-Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 
 This file is not maintained in this branch of the OpenVPN git repository.
 
diff --git a/Makefile.am b/Makefile.am
index 98942065..4ffe5118 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -5,8 +5,8 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2010-2022 David Sommerseth <dazo@...2108...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2010-2023 David Sommerseth <dazo@...2108...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/PORTS b/PORTS
index 2e5133b0..dd156d04 100644
--- a/PORTS
+++ b/PORTS
@@ -1,5 +1,5 @@
 OpenVPN
-Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 
   OpenVPN has been written to try to avoid features
   that are not standardized well across different
diff --git a/build/Makefile.am b/build/Makefile.am
index 6305ac1f..a914d572 100644
--- a/build/Makefile.am
+++ b/build/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/build/msvc/Makefile.am b/build/msvc/Makefile.am
index 77e14ea0..df3b41f3 100644
--- a/build/msvc/Makefile.am
+++ b/build/msvc/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-generate/Makefile.am
index 4c095c16..aa4f0dae 100644
--- a/build/msvc/msvc-generate/Makefile.am
+++ b/build/msvc/msvc-generate/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/build/msvc/msvc-generate/Makefile.mak b/build/msvc/msvc-generate/Makefile.mak
index 1c1c4bab..91907420 100644
--- a/build/msvc/msvc-generate/Makefile.mak
+++ b/build/msvc/msvc-generate/Makefile.mak
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
 #  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
 #
diff --git a/build/msvc/msvc-generate/git-version.py b/build/msvc/msvc-generate/git-version.py
index 00458955..c2b44527 100644
--- a/build/msvc/msvc-generate/git-version.py
+++ b/build/msvc/msvc-generate/git-version.py
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2022-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/configure.ac b/configure.ac
index be31889e..befdaa09 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,7 +4,7 @@ dnl             session authentication and key exchange,
 dnl             packet encryption, packet authentication, and
 dnl             packet compression.
 dnl
-dnl  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+dnl  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 dnl  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 dnl
 dnl  This program is free software; you can redistribute it and/or modify
diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarballs.sh
index 14734f62..13c58111 100755
--- a/dev-tools/gen-release-tarballs.sh
+++ b/dev-tools/gen-release-tarballs.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # gen-release-tarballs.sh  -  Generates release tarballs with signatures
 #
-# Copyright (C) 2017-2022 - David Sommerseth <davids@...515...>
+# Copyright (C) 2017-2023 - David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
index ff126b0f..ed472289 100755
--- a/dev-tools/reformat-all.sh
+++ b/dev-tools/reformat-all.sh
@@ -2,7 +2,7 @@
 # reformat-all.sh - Reformat all git files in the checked out
 #                   git branch using uncrustify.
 #
-# Copyright (C) 2016-2022 - David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2023 - David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
index 497b709e..50fcd098 100755
--- a/dev-tools/update-copyright.sh
+++ b/dev-tools/update-copyright.sh
@@ -2,8 +2,8 @@
 # update-copyright-sh - Simple tool to update the Copyright lines
 #                       in all files checked into git
 #
-# Copyright (C) 2016-2022 OpenVPN Inc <sales@...515...>
-# Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2023 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/distro/Makefile.am b/distro/Makefile.am
index 8f4e3498..177dcee4 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index d35c137d..7e8f4753 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2017-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2017-2023 OpenVPN Inc <sales@...515...>
 #
 
 %.service: %.service.in Makefile
diff --git a/doc/Makefile.am b/doc/Makefile.am
index c9e83750..13e6a64e 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/include/Makefile.am b/include/Makefile.am
index 3a4870f2..e0d49867 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index b16577cc..8cd26319 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2022 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2023 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index e498f94d..ffbdbfcb 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/Makefile.am b/sample/Makefile.am
index 1f466586..10f199b6 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index b9e73703..1bbc3809 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -3,7 +3,7 @@
 # Run this script to set up a test CA, and test key-certificate pair for a
 # server, and various clients.
 #
-# Copyright (C) 2014-2022 Steffan Karger <steffan@...1856...>
+# Copyright (C) 2014-2023 Steffan Karger <steffan@...1856...>
 set -eu
 
 command -v openssl >/dev/null 2>&1 || { echo >&2 "Unable to find openssl. Please make sure openssl is installed and in your path."; exit 1; }
diff --git a/sample/sample-plugins/Makefile.am b/sample/sample-plugins/Makefile.am
index 06d701df..3d66ab82 100644
--- a/sample/sample-plugins/Makefile.am
+++ b/sample/sample-plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/sample/sample-plugins/Makefile.plugins b/sample/sample-plugins/Makefile.plugins
index 917b02b6..1ef5b000 100644
--- a/sample/sample-plugins/Makefile.plugins
+++ b/sample/sample-plugins/Makefile.plugins
@@ -1,6 +1,6 @@
 #  SPDX-License-Identifier: GPL-2.0-only
 #
-#  Copyright (C) 2020-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2020-2023 OpenVPN Inc <sales@...515...>
 #
 
 #
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index bd691a94..391de344 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c
index c2672981..c7f3e263 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 63c10fb5..6a0a1f69 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index 2adbb2df..4b62fa80 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 5f569c92..de726120 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2022 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2023 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
index e94ee963..553facda 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2017-2022 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2017-2023 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
index 57c3a719..2ba636df 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/Makefile.am b/src/Makefile.am
index 40bcda2c..a1f590fc 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 23346be5..a42ec39c 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index f2f91ba6..0dc74607 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/compat/compat-strsep.c b/src/compat/compat-strsep.c
index 760573ae..6db013f7 100644
--- a/src/compat/compat-strsep.c
+++ b/src/compat/compat-strsep.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2019-2022 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2019-2023 Arne Schwabe <arne@...1227...>
  *  Copyright (C) 1992-2019 Free Software Foundation, Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 35d60a65..3ed73fa4 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index f1542a47..cef0da9a 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 138f6bd9..4e3abccb 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 5e23d8c4..ab0ba659 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index f33ce875..f6d07ddb 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index 7849ec53..4af429be 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *                2015-2016  <iam@...2070...>
  *                2016 Selva Nair <selva.nair@...277...>
  *
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
index b937a922..89b88d6c 100644
--- a/src/openvpn/block_dns.h
+++ b/src/openvpn/block_dns.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2022 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2023 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index e3d5ba24..d099795b 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 185226f7..2461a207 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index bfd29880..7469acd9 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 1f272231..514bd438 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index 0135c5ea..ef872701 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index d0eaf562..f77685c8 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index b54775b7..e544a8dc 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2013-2022 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2023 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
index 827253da..5f16c586 100644
--- a/src/openvpn/comp-lz4.h
+++ b/src/openvpn/comp-lz4.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2013-2022 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2023 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 099ac027..3b8d7899 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 874036dc..685f4039 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index 3acfaa5e..496e60e5 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 6ee179fe..bbdd59c5 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 97d5ae81..35dc684e 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 3b97aad9..4101feb8 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015  David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d735d716..073f47e4 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 5ea88908..3459c43e 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 8b489938..842e73e9 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 9087ff6a..cd43ee58 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 394defa8..cfb39a49 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 5c86268d..c2ac80b7 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index c1c04840..32849fd3 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 2f4d0f77..3087a0df 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2022 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2021-2022 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2021-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2021-2023 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2023 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2021-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 866aa0fb..18a9d78b 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2022 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2021-2022 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2021-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2021-2023 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2023 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2021-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index b973d743..7afcfc44 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2023 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index d4bca555..5524cdbc 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1,9 +1,9 @@
 /*
  *  Interface to linux dco networking code
  *
- *  Copyright (C) 2020-2022 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2020-2022 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2023 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020-2023 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 7d56308b..4d996d98 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -1,9 +1,9 @@
 /*
  *  Interface to linux dco networking code
  *
- *  Copyright (C) 2020-2022 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2020-2022 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2023 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020-2023 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 825b1cd3..7594024c 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -1,8 +1,8 @@
 /*
  *  Interface to ovpn-win-dco networking code
  *
- *  Copyright (C) 2020-2022 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2023 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index bba7b340..f20c47eb 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -1,8 +1,8 @@
 /*
  *  Interface to ovpn-win-dco networking code
  *
- *  Copyright (C) 2020-2022 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2023 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index b1274255..b9cd3c61 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index 65fecf75..1557439c 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 0b8be594..9f2a7d5e 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index f49d1f33..03a894f2 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 12d83643..79059141 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index 81e39982..45999771 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 5bb1e65e..64ba4a33 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index c8c77358..89a08cec 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 89adb3e6..1225b139 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 8546dff7..fa5aee23 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index f2438f97..62828733 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index c83cb581..3f74171b 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index 7343d8ae..d0f0ee41 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 53f7525c..257c7c75 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index bd2d9601..7376bca2 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index e7ca12f2..50391de2 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index 0d330bc1..cc6829aa 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index aca48fc4..c77fc406 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h
index b75ae7e0..f4ef6159 100644
--- a/src/openvpn/gremlin.h
+++ b/src/openvpn/gremlin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 2185b2ee..7c219fdf 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
index 0f0d0f11..5f7a787b 100644
--- a/src/openvpn/helper.h
+++ b/src/openvpn/helper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index f2821886..6714ef94 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index b3909a65..bb69a1f6 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 6715e2d2..45badcd3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 2315b3ca..7731f5a0 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index b1612045..215c159f 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index 7e317b8c..8308df4a 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index 6850c922..38e44343 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 3f60438e..f65d8a8e 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index e66f6052..94d14f2a 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index ef6c4c8d..848cb06a 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index d0430d2c..c5723546 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index d2d2ca9a..8397d3cf 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index b98cc061..a90dab39 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 2f63359a..a44f8c3b 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index e6b68507..8227d0c1 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index e7dd7892..6bb4d1be 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 551606e0..774ea062 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2023 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 6a883f70..b000b729 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 64404cdb..2683b405 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 8eb20249..a06e8724 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 381e61a2..429aa1e9 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 8e2986b7..1c4704bd 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
index dd252d2c..1e92b41e 100644
--- a/src/openvpn/mstats.c
+++ b/src/openvpn/mstats.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.h b/src/openvpn/mstats.h
index a66700d1..91bac6cb 100644
--- a/src/openvpn/mstats.h
+++ b/src/openvpn/mstats.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index ac06ddc6..59131ac9 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 4f3fb266..bacf7239 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index a74a0815..1d9ebe01 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index badb3a6a..0ff4f7bf 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 77560425..8698aefc 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 90f9177d..8383c64d 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b639d3c6..77dcaa60 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 713c63ee..6b1c68d6 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 225cfaee..a7377d56 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2022 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2023 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 3062c1da..f93756d6 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -1,7 +1,7 @@
 /*
  *  Networking API implementation for iproute2
  *
- *  Copyright (C) 2018-2022 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2018-2023 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_iproute2.h b/src/openvpn/networking_iproute2.h
index 5f0c2ce3..88fbd549 100644
--- a/src/openvpn/networking_iproute2.h
+++ b/src/openvpn/networking_iproute2.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2022 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2023 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index fe124616..dece83c2 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1,7 +1,7 @@
 /*
  *  Simplified Interface To NetLink
  *
- *  Copyright (C) 2016-2022 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2023 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
index afd320c6..85f8061f 100644
--- a/src/openvpn/networking_sitnl.h
+++ b/src/openvpn/networking_sitnl.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2022 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2023 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 0b291756..0fa803cd 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index f7683481..4320bd11 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 9d89bd0a..56b1dcf1 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 413a750b..cba58276 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 5981e4d5..1ad0ae97 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e756af94..9f027e76 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2008-2022 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2008-2023 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -4836,7 +4836,7 @@ usage_version(void)
     show_windows_version( M_INFO|M_NOPREFIX );
 #endif
     msg(M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
-    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>");
+    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>");
 #ifndef ENABLE_SMALL
 #ifdef CONFIGURE_DEFINES
     msg(M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 48315b10..a1414ade 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 72c8bda4..b071f37d 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 17d62047..5115880b 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 80eac149..0bbed81d 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 2b1b0d50..c27be892 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 1872bd13..bb790f03 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 3e74ab52..af62c89d 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index adab5bc2..5eb89265 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
index 41dff705..3d92e6fe 100644
--- a/src/openvpn/perf.h
+++ b/src/openvpn/perf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index cf1861a6..25822c99 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 3c8b748f..6243cf6b 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index aa027337..b6c3bf13 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index 554bc295..0365fbc4 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index c46b66ed..8a95c33f 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index dbc45fb2..a286a231 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 60bc1c47..71347d31 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 327a2d23..1b5fa9ad 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 1ffd81e3..a35a571c 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 4c2fec06..d662998e 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index c6fa206a..ee780d8e 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 88af4b55..f899b95d 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index 9b1a80bc..bf0f603c 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 88abd199..7a844074 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 5b52a10a..65c80804 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 120ba85e..aa10363c 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 4fe2a08f..83b799ed 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index a69da2f9..3609630a 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index 434c13cf..2fe0c4c5 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 9796da4e..4d64ad1a 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 7138055a..5e594a30 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
index 7113fc2a..9585bc7e 100644
--- a/src/openvpn/pushlist.h
+++ b/src/openvpn/pushlist.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
index 323184cb..cfe69a63 100644
--- a/src/openvpn/reflect_filter.c
+++ b/src/openvpn/reflect_filter.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reflect_filter.h b/src/openvpn/reflect_filter.h
index 6dfa8755..b708d4fd 100644
--- a/src/openvpn/reflect_filter.h
+++ b/src/openvpn/reflect_filter.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 209ca6ed..32b346b4 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 01ce7287..349b3510 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h
index cc48c024..e86162a4 100644
--- a/src/openvpn/ring_buffer.h
+++ b/src/openvpn/ring_buffer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *                2019 Lev Stipakov <lev@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 99f948ba..21dce6af 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 1c940a9b..71b4cf4e 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 8b44d177..8c2a6d78 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index 966283ab..3891fdb2 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 0027d198..b0fca033 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index 52c52880..967eab23 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index 5c6b9324..89c67efb 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
index e2072453..8b139319 100644
--- a/src/openvpn/session_id.h
+++ b/src/openvpn/session_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index 18d40639..6a0d7ddf 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 7e42e81c..7cffcea5 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index d6b18cb1..0d534601 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 83adc543..4858eb93 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index bb3be428..a883ac4a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 9d2c1efe..605b6ad2 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 8f2ae226..6a672c25 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 55c75c60..3a89245b 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b1dc80c4..cbb596c1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
- *  Copyright (C) 2008-2022 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2008-2023 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index bd27e57a..b0a2823f 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 215425d4..0ce24987 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 7d9c2460..eeb056f5 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b0e42d8f..49989d94 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *  Copyright (C) 2006-2010, Brainspark B.V.
  *
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 8ca26791..eb4974b7 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index b6884af9..fe6f6fa7 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
- *  Copyright (C) 2008-2022 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2008-2023 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 97c04302..d27ed244 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index dbf90926..2b932af9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 752b69ce..3889ceff 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 46bca21d..b0d1a7f3 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 9bb3ca95..dd3c3de0 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index 5f5a3720..e12ed3d8 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index 3695ca3c..4c46f88b 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 228cf16e..996aee01 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 30dfc9bc..06627d00 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index be857960..3b798811 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 5463c8da..e3437f74 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
index 9d31a65e..68984da5 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 78efa70a..e24ce4e4 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index ca78a407..b2145b62 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 071eb62b..737f340b 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index fc3a97d7..1a9ea3de 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 5a673a7b..fe91bc11 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b204bc40..01c85f9f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index ed22770a..3b0a0d24 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 661be4ab..25100428 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
index 89dc7d46..f70e2975 100644
--- a/src/openvpn/vlan.h
+++ b/src/openvpn/vlan.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 0a88ecfb..35f2a311 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
index 317a3bb9..b24242c8 100644
--- a/src/openvpn/win32-util.h
+++ b/src/openvpn/win32-util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 569e086e..44176936 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 26d5ef8f..a1a45503 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 6d6a1e2c..07b70c08 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2022 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2023 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 27e87d79..052c60c4 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2022 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2023 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index c6965718..b0f414f6 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2022 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2023 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index d3053c42..6da0754d 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -1,8 +1,8 @@
 #
 #  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index d5440115..7cff41ac 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
index ed1f4d7c..ad6968f2 100644
--- a/src/openvpnmsica/msica_arg.c
+++ b/src/openvpnmsica/msica_arg.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h
index 7444f442..44beee14 100644
--- a/src/openvpnmsica/msica_arg.h
+++ b/src/openvpnmsica/msica_arg.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index a3e797ed..3ea2c1ac 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h
index a944ff01..79664e2c 100644
--- a/src/openvpnmsica/msiex.h
+++ b/src/openvpnmsica/msiex.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 538cdbaa..229eff00 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index ec059706..64f73733 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/openvpnmsica_resources.rc
index 2b383d27..d7c14ded 100644
--- a/src/openvpnmsica/openvpnmsica_resources.rc
+++ b/src/openvpnmsica/openvpnmsica_resources.rc
@@ -1,7 +1,7 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index b79b3a34..b8b2a378 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index f9406120..bb237a2b 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2011-2022 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2011-2023 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 47ddd4e8..03361d66 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2012-2022 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2012-2023 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 93c3440a..fc5ecdaf 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2022 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2023 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index e3042e54..341524ed 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2022 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2023 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index 735485be..363e1fb0 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -6,7 +6,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2022 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2023 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/Makefile.am b/src/plugins/Makefile.am
index 4c72bf06..61d6cb45 100644
--- a/src/plugins/Makefile.am
+++ b/src/plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 32bcea15..949b0eb5 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2016-2022 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2016-2023 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index e65ed21b..30ddf4b5 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index 23d30f67..f6627099 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index 95a8b52d..1bb64931 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2013      David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index ff61fb7f..3896351b 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -1,8 +1,8 @@
 #
 #  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index 9a563569..05a0ebb8 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -2,8 +2,8 @@
  *  basic -- Basic macros
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/error.c b/src/tapctl/error.c
index 7fcab1bc..33a3e69d 100644
--- a/src/tapctl/error.c
+++ b/src/tapctl/error.c
@@ -2,8 +2,8 @@
  *  error -- OpenVPN compatible error reporting API
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index 7316af5f..cd466caf 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -2,8 +2,8 @@
  *  error -- OpenVPN compatible error reporting API
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 0724cc4d..1194036f 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -2,8 +2,8 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 80cbc85c..44fcdde5 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 670903b3..45de8749 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tapctl_resources.rc b/src/tapctl/tapctl_resources.rc
index d98bd8eb..fc65b5a6 100644
--- a/src/tapctl/tapctl_resources.rc
+++ b/src/tapctl/tapctl_resources.rc
@@ -1,7 +1,7 @@
 /*
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *
- *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2023 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 89180f60..87dd7e17 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 90c9a121..5a8978d0 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2022 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2023 Arne Schwabe <arne@...1227...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index bb9a2824..0e52ea24 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2019-2022 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2019-2023 Arne Schwabe <arne@...1227...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 9451a6e7..255067c7 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2022 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2023 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
-- 
2.34.1


