From: Antonio Quartulli <a@...2181...>
Date: Wed, 26 Jan 2022 13:43:29 +0100
Message-Id: <20220126124329.14784-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2.5] update copyright year to 2022
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
Cc: Antonio Quartulli <a@...2181...>, David Sommerseth <davids@...515...>

Cc: David Sommerseth <davids@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 COPYING                                                     | 2 +-
 ChangeLog                                                   | 2 +-
 Makefile.am                                                 | 4 ++--
 PORTS                                                       | 2 +-
 build/Makefile.am                                           | 2 +-
 build/msvc/Makefile.am                                      | 2 +-
 build/msvc/msvc-generate/Makefile.am                        | 2 +-
 configure.ac                                                | 2 +-
 dev-tools/gen-release-tarballs.sh                           | 2 +-
 dev-tools/lz4-rebaser.sh                                    | 2 +-
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
 sample/sample-plugins/defer/simple.c                        | 2 +-
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
 src/openvpn/dhcp.c                                          | 2 +-
 src/openvpn/dhcp.h                                          | 2 +-
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
 src/openvpn/otime.c                                         | 2 +-
 src/openvpn/otime.h                                         | 2 +-
 src/openvpn/packet_id.c                                     | 2 +-
 src/openvpn/packet_id.h                                     | 2 +-
 src/openvpn/perf.c                                          | 2 +-
 src/openvpn/perf.h                                          | 2 +-
 src/openvpn/pf.c                                            | 2 +-
 src/openvpn/pf.h                                            | 2 +-
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
 src/openvpn/sitnl.h                                         | 2 +-
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
 src/openvpn/win32.c                                         | 2 +-
 src/openvpn/win32.h                                         | 2 +-
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
 src/openvpnserv/automatic.c                                 | 2 +-
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
 tests/unit_tests/openvpn/test_ncp.c                         | 2 +-
 231 files changed, 252 insertions(+), 252 deletions(-)

diff --git a/COPYING b/COPYING
index 9044a39c..62e1a9d3 100644
--- a/COPYING
+++ b/COPYING
@@ -1,6 +1,6 @@
 OpenVPN (TM) -- An Open Source VPN daemon
 
-Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 
 This distribution contains multiple components, some
 of which fall under different licenses.  By using OpenVPN
diff --git a/ChangeLog b/ChangeLog
index edba539e..df9eb373 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,5 +1,5 @@
 OpenVPN Change Log
-Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 
 2021.12.14 -- Version 2.5.5
 
diff --git a/Makefile.am b/Makefile.am
index 80924486..3f0fdd4c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -5,8 +5,8 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2010-2021 David Sommerseth <dazo@...2108...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2010-2022 David Sommerseth <dazo@...2108...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/PORTS b/PORTS
index d158e1f8..ff76850d 100644
--- a/PORTS
+++ b/PORTS
@@ -1,5 +1,5 @@
 OpenVPN
-Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 
   OpenVPN has been written to try to avoid features
   that are not standardized well across different
diff --git a/build/Makefile.am b/build/Makefile.am
index 46973b44..6305ac1f 100644
--- a/build/Makefile.am
+++ b/build/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/build/msvc/Makefile.am b/build/msvc/Makefile.am
index 820e3129..77e14ea0 100644
--- a/build/msvc/Makefile.am
+++ b/build/msvc/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/build/msvc/msvc-generate/Makefile.am b/build/msvc/msvc-generate/Makefile.am
index 3f189cf4..4c095c16 100644
--- a/build/msvc/msvc-generate/Makefile.am
+++ b/build/msvc/msvc-generate/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/configure.ac b/configure.ac
index 7efd7109..3c700aac 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,7 +4,7 @@ dnl             session authentication and key exchange,
 dnl             packet encryption, packet authentication, and
 dnl             packet compression.
 dnl
-dnl  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+dnl  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 dnl  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 dnl
 dnl  This program is free software; you can redistribute it and/or modify
diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarballs.sh
index f56a1326..14734f62 100755
--- a/dev-tools/gen-release-tarballs.sh
+++ b/dev-tools/gen-release-tarballs.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # gen-release-tarballs.sh  -  Generates release tarballs with signatures
 #
-# Copyright (C) 2017-2021 - David Sommerseth <davids@...515...>
+# Copyright (C) 2017-2022 - David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/lz4-rebaser.sh b/dev-tools/lz4-rebaser.sh
index 03debcb4..547a4d89 100755
--- a/dev-tools/lz4-rebaser.sh
+++ b/dev-tools/lz4-rebaser.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # lz4-rebaser.sh   - Does the LZ4 rebase process in an automated fashion
 #
-# Copyright (C) 2017-2018 David Sommerseth <davids@...515...>
+# Copyright (C) 2017-2022 David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
index db2c3c42..dc2bfc4e 100755
--- a/dev-tools/reformat-all.sh
+++ b/dev-tools/reformat-all.sh
@@ -2,7 +2,7 @@
 # reformat-all.sh - Reformat all git files in the checked out
 #                   git branch using uncrustify.
 #
-# Copyright (C) 2016-2021 - David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2022 - David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
index 7f87c7ac..497b709e 100755
--- a/dev-tools/update-copyright.sh
+++ b/dev-tools/update-copyright.sh
@@ -2,8 +2,8 @@
 # update-copyright-sh - Simple tool to update the Copyright lines
 #                       in all files checked into git
 #
-# Copyright (C) 2016-2021 OpenVPN Inc <sales@...515...>
-# Copyright (C) 2016-2021 David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2022 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/distro/Makefile.am b/distro/Makefile.am
index 1049f006..8f4e3498 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index 59e09946..322bd535 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2017-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2017-2022 OpenVPN Inc <sales@...515...>
 #
 
 %.service: %.service.in Makefile
diff --git a/doc/Makefile.am b/doc/Makefile.am
index 1e4fcdea..db73cef5 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/include/Makefile.am b/include/Makefile.am
index bd4f21dc..3a4870f2 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 83344eeb..b16577cc 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2021 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2022 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 7ee68bbc..6b712087 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/Makefile.am b/sample/Makefile.am
index 06ba0ff3..1f466586 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index 82f08806..b9e73703 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -3,7 +3,7 @@
 # Run this script to set up a test CA, and test key-certificate pair for a
 # server, and various clients.
 #
-# Copyright (C) 2014-2021 Steffan Karger <steffan@...1856...>
+# Copyright (C) 2014-2022 Steffan Karger <steffan@...1856...>
 set -eu
 
 command -v openssl >/dev/null 2>&1 || { echo >&2 "Unable to find openssl. Please make sure openssl is installed and in your path."; exit 1; }
diff --git a/sample/sample-plugins/Makefile.am b/sample/sample-plugins/Makefile.am
index 9539d050..06d701df 100644
--- a/sample/sample-plugins/Makefile.am
+++ b/sample/sample-plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/sample/sample-plugins/Makefile.plugins b/sample/sample-plugins/Makefile.plugins
index 44c9cea1..73ce5916 100644
--- a/sample/sample-plugins/Makefile.plugins
+++ b/sample/sample-plugins/Makefile.plugins
@@ -1,6 +1,6 @@
 #  SPDX-License-Identifier: GPL-2.0-only
 #
-#  Copyright (C) 2020-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2020-2022 OpenVPN Inc <sales@...515...>
 #
 
 #
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index cc85aeb5..f31032d4 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index ba2e03eb..aeb32880 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 787fc54c..1f47cb35 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index 661ec5d4..2adbb2df 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 7ae77a88..5f569c92 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2022 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
index 363a1231..e94ee963 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2017-2021 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2017-2022 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
index 0f26dd27..57c3a719 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/Makefile.am b/src/Makefile.am
index 5d7935b1..40bcda2c 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index c9856793..522797e7 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index 8ce586be..30ed162e 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/compat/compat-strsep.c b/src/compat/compat-strsep.c
index 7a6e6b30..760573ae 100644
--- a/src/compat/compat-strsep.c
+++ b/src/compat/compat-strsep.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2019-2021 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2019-2022 Arne Schwabe <arne@...1227...>
  *  Copyright (C) 1992-2019 Free Software Foundation, Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 781148b9..2c522009 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 2c61e663..f1542a47 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 1b027148..138f6bd9 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 73a00ddd..0fa4dbae 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index 6372e621..f33ce875 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index b2af457d..88e933fb 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *                2015-2016  <iam@...2070...>
  *                2016 Selva Nair <selva.nair@...277...>
  *
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
index 78e5e5d1..b937a922 100644
--- a/src/openvpn/block_dns.h
+++ b/src/openvpn/block_dns.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2022 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 54e758af..e422ab7c 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 1a795d27..94d63b7f 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index d9fd2e22..225dfae1 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 2dd55f52..1f272231 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index a7725f10..0135c5ea 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index e1a2cde5..f36df3e6 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 3cb427ef..620c1f48 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2013-2021 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2022 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
index f02d46f4..827253da 100644
--- a/src/openvpn/comp-lz4.h
+++ b/src/openvpn/comp-lz4.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2013-2021 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2022 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 72b1511e..fbc920bc 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index dfd70bb1..94f3fa7e 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index a65e8ea6..8adf5084 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 9bf9ef18..6ee179fe 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2021 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 2994c232..97d5ae81 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2021 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 3a977ee0..b00594e4 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015  David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2021 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 6945cc0f..6e2e2356 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 93c33c17..ffb44692 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index b5e3bd90..b5a122ee 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 8f0a283c..1da99d14 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 019de01d..816e1397 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index ef520928..0908e9aa 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 59a31aac..ecc66fbf 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 47fe733e..b1274255 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index b2fe8a5c..65fecf75 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index a410388f..12d83643 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2021 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index f73dea63..81e39982 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 4131cf0a..13cd9efa 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 10be3e00..54796d03 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index bd152821..d2d83c8a 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index fcddeb19..40bb36e3 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 5b6647f4..9eff8471 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 729bdb3d..0b3fa5d7 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index 86957f0e..d55150c8 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 042ba9e2..392a5c9f 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 5585366a..5d937ee4 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 4f8bd0f2..b70e610d 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index 68154469..0d330bc1 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index 23ce3f08..9c9dfbde 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h
index 52f65ac2..b75ae7e0 100644
--- a/src/openvpn/gremlin.h
+++ b/src/openvpn/gremlin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index ebb5142c..ff492867 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
index 084bf380..0f0d0f11 100644
--- a/src/openvpn/helper.h
+++ b/src/openvpn/helper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 26b0ed1a..3c518b02 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index 75c465b3..b3909a65 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 27c6cac9..da4d60af 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 52581f8a..0c5a2e99 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 07614752..88c3711b 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index d06b6e59..2f0fc42d 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index 3ba197c4..f58bfacf 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index c4537260..7e4e8081 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 04354143..e66f6052 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 01888147..da28ecb5 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index d19d6025..d0430d2c 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index c831f8a6..a4264056 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 3c9028f7..86e727f2 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 1032f238..4c62fcf4 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index ea2bfe3c..cd9b339c 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index 69aac009..e7dd7892 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 046d937e..dceccd22 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2021 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2022 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index ef94ca1d..570e473b 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 4e76fb0b..851047dd 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 8f7e0924..3210ac23 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index aa5b68ce..94ae52b9 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 41254e2a..fa29bf1a 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
index 1051e807..dd252d2c 100644
--- a/src/openvpn/mstats.c
+++ b/src/openvpn/mstats.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.h b/src/openvpn/mstats.h
index 0f710db8..a66700d1 100644
--- a/src/openvpn/mstats.h
+++ b/src/openvpn/mstats.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 2b40ae83..bb62ebc2 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 716939a4..4f3fb266 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 3200a37f..5e2f3a64 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index d0df0ef0..b24ef512 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index d5459f8a..d9c6efb8 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 2e071c29..ea89b2ce 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 66f5ada5..752cfd89 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 721b24f0..2da63536 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index d43979f0..4e7610ec 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2021 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2022 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 67b8894b..3ca2bb35 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -1,7 +1,7 @@
 /*
  *  Networking API implementation for iproute2
  *
- *  Copyright (C) 2018-2021 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2018-2022 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_iproute2.h b/src/openvpn/networking_iproute2.h
index 8a1ab3ab..5f0c2ce3 100644
--- a/src/openvpn/networking_iproute2.h
+++ b/src/openvpn/networking_iproute2.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2021 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2022 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 8610e1d2..959c897f 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1,7 +1,7 @@
 /*
  *  Simplified Interface To NetLink
  *
- *  Copyright (C) 2016-2021 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2022 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
index f040020e..afd320c6 100644
--- a/src/openvpn/networking_sitnl.h
+++ b/src/openvpn/networking_sitnl.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2021 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2022 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 3a2bcabe..90510594 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 067a6589..f7683481 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 3819d4c9..0fc51d5d 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 0ac96142..a21b21e2 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index ce0cd98c..07174ebc 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f88cf2ef..f09cb339 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2008-2021 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2008-2022 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -4388,7 +4388,7 @@ usage_version(void)
     show_windows_version( M_INFO|M_NOPREFIX );
 #endif
     msg(M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
-    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>");
+    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>");
 #ifndef ENABLE_SMALL
 #ifdef CONFIGURE_DEFINES
     msg(M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index dea96423..b1d8e6d6 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index f31d8825..bf12c400 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index f8472967..00d6992a 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index baa70545..b73363ec 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 8f705964..bb613282 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index 2ad58258..3835d447 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
index 27c645fb..41dff705 100644
--- a/src/openvpn/perf.h
+++ b/src/openvpn/perf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 36456315..152342fa 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
index 609c842e..f0e6ae2b 100644
--- a/src/openvpn/pf.h
+++ b/src/openvpn/pf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index 67bbca14..4ef6bda0 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 75184044..3c8b748f 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 367d67d9..7029be54 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index ec524706..554bc295 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index eebfc559..c46b66ed 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 3cfcacc2..dbc45fb2 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index f5d3add2..2e0cb224 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 964d5783..2604c27b 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 1b9340c5..de1d339d 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 73c25ff7..e8f8830d 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 98b30789..c6fa206a 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index b3f0bcd9..03fdedbf 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index e8db68ee..39fc1b0d 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index cff0ef01..88abd199 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index f73e50c0..542ae2ce 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 8822998e..d0aaa03d 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 7668dc99..9d719382 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index a6117617..e79cb0d3 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index 2192034f..434c13cf 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index bc94c324..fab1d5f4 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index fa323f40..69196273 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
index a7b59983..5caca38f 100644
--- a/src/openvpn/pushlist.h
+++ b/src/openvpn/pushlist.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index d0a8d782..24db7c76 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 2daab6e4..d5513143 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h
index 9661ceb3..089076be 100644
--- a/src/openvpn/ring_buffer.h
+++ b/src/openvpn/ring_buffer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *                2019 Lev Stipakov <lev@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 5cfbb284..4fd4955c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 64d57a56..ce19d5b4 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index bdb0afbc..30d7bf1b 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index 5061f75a..edc08433 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index d3044d37..0027d198 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index d911f1ec..52c52880 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index 495db4fe..5c6b9324 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
index f0c4c9e0..e2072453 100644
--- a/src/openvpn/session_id.h
+++ b/src/openvpn/session_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index f97b0457..3150193c 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index f5650559..74f771df 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 25af9deb..2db60ab4 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 3ce57abf..091f16b3 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sitnl.h b/src/openvpn/sitnl.h
index a127d730..41a6a0b8 100644
--- a/src/openvpn/sitnl.h
+++ b/src/openvpn/sitnl.h
@@ -1,7 +1,7 @@
 /*
  *  Simplified Interface To NetLink
  *
- *  Copyright (C) 2016-2021 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2022 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index cd41893e..28fabe76 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index c02c8486..2ad6155f 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 71f82b25..fe6dc91b 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 9bda2e80..88cf9523 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d66299fb..841a649a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
- *  Copyright (C) 2008-2021 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2008-2022 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index ebc1bf60..4fe8004a 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 9d25321d..96b8bc90 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 74faf687..f4855286 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 0fe70e45..4a64e6d3 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *  Copyright (C) 2006-2010, Brainspark B.V.
  *
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index c7eaec8f..15170f4b 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index aabfc6d9..b94c786e 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
- *  Copyright (C) 2008-2021 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2008-2022 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 3fa68e26..ce330ee6 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 27fb66aa..595057d6 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 46338c24..5f4d4992 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0ccd43d0..7f977c0d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index ffba6a99..623b965c 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index ca04261e..be857960 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index c767178a..9f592114 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
index 6f2de99a..9d31a65e 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index aadc5178..93de088e 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index 70a9d503..ca78a407 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 8476b4d7..0541ec21 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index da1775d7..fc3a97d7 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 24ee27cc..e769167e 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index db8fdec3..ca79b095 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index ff0919d2..ea19620d 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 573a9904..661be4ab 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
index d4b93c41..89dc7d46 100644
--- a/src/openvpn/vlan.h
+++ b/src/openvpn/vlan.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 920a3b37..e91e742b 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 5c3bcc37..3dd8b7e3 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index 0fdc1f6f..a1a04afe 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -1,8 +1,8 @@
 #
 #  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 73155435..d5440115 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
index cde0577d..ed1f4d7c 100644
--- a/src/openvpnmsica/msica_arg.c
+++ b/src/openvpnmsica/msica_arg.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h
index 4bf3c095..7444f442 100644
--- a/src/openvpnmsica/msica_arg.h
+++ b/src/openvpnmsica/msica_arg.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index 54b2b972..a3e797ed 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h
index cae42981..a944ff01 100644
--- a/src/openvpnmsica/msiex.h
+++ b/src/openvpnmsica/msiex.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 98111fbe..f44515df 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index bfc40ea3..8c53de45 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/openvpnmsica_resources.rc
index 323f0e79..2b383d27 100644
--- a/src/openvpnmsica/openvpnmsica_resources.rc
+++ b/src/openvpnmsica/openvpnmsica_resources.rc
@@ -1,7 +1,7 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index b067fb90..f72d7243 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
index 3f2ca345..7800bfdc 100644
--- a/src/openvpnserv/automatic.c
+++ b/src/openvpnserv/automatic.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index f7b061cc..28cf07cb 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2011-2021 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2011-2022 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index de36e85e..3b120ae9 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2012-2021 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2012-2022 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 500f3902..84ac309c 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2021 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2022 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 93f92e3f..e987d53c 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2022 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index 710e1367..735485be 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -6,7 +6,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2022 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/Makefile.am b/src/plugins/Makefile.am
index 9e98a67d..4c72bf06 100644
--- a/src/plugins/Makefile.am
+++ b/src/plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 235610af..3a3a2409 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2016-2021 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2016-2022 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index 51c6ce36..1d2fd4f4 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index 33a14d02..23d30f67 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index 555b4d56..499b033d 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2013      David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index 7ebbbf26..305181bf 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -1,8 +1,8 @@
 #
 #  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index 3de237d0..9a563569 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -2,8 +2,8 @@
  *  basic -- Basic macros
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/error.c b/src/tapctl/error.c
index 16662ec9..7fcab1bc 100644
--- a/src/tapctl/error.c
+++ b/src/tapctl/error.c
@@ -2,8 +2,8 @@
  *  error -- OpenVPN compatible error reporting API
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index fa6e3ff3..bbcb9412 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -2,8 +2,8 @@
  *  error -- OpenVPN compatible error reporting API
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 73ec40b4..ab3758ae 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -2,8 +2,8 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index dd4a10a3..e399a38a 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018-2020 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 847040c8..670903b3 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tapctl_resources.rc b/src/tapctl/tapctl_resources.rc
index a1953969..d98bd8eb 100644
--- a/src/tapctl/tapctl_resources.rc
+++ b/src/tapctl/tapctl_resources.rc
@@ -1,7 +1,7 @@
 /*
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *
- *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2022 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/Makefile.am b/tests/Makefile.am
index bb23a9c1..89180f60 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2021 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index bcafd232..e38a5738 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2019-2021 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2019-2022 Arne Schwabe <arne@...1227...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
-- 
2.34.1


