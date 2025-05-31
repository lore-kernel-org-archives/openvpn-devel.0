From: Gert Doering <gert@...1296...>
Date: Sat, 31 May 2025 22:35:39 +0200
Message-ID: <20250531203546.26593-1-gert@...1296...>
In-Reply-To: <gerrit.1748612098000.I3dfead8e60da93f223e3333db7b8e01ead01a856@...2715...>
References: <gerrit.1748612098000.I3dfead8e60da93f223e3333db7b8e01ead01a856@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Update copyright statements to 2025
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

From: Frank Lichtenheld <frank@...2641...>

Change-Id: I3dfead8e60da93f223e3333db7b8e01ead01a856
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1035
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/COPYING b/COPYING
index 00ecc27..3eb9468 100644
--- a/COPYING
+++ b/COPYING
@@ -1,6 +1,6 @@
 OpenVPN (TM) -- An Open Source VPN daemon
 
-Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 
 This distribution contains multiple components, some
 of which fall under different licenses.  By using OpenVPN
diff --git a/Makefile.am b/Makefile.am
index 84b7112..8a28149 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -5,8 +5,8 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2010-2024 David Sommerseth <dazo@...2108...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2010-2025 David Sommerseth <dazo@...2108...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/PORTS b/PORTS
index dadc6f8..6e68296 100644
--- a/PORTS
+++ b/PORTS
@@ -1,5 +1,5 @@
 OpenVPN
-Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 
   OpenVPN has been written to try to avoid features
   that are not standardized well across different
diff --git a/configure.ac b/configure.ac
index 1b908e6..c70892a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,7 +4,7 @@
 dnl             packet encryption, packet authentication, and
 dnl             packet compression.
 dnl
-dnl  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+dnl  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 dnl  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 dnl
 dnl  This program is free software; you can redistribute it and/or modify
diff --git a/contrib/cmake/git-version.py b/contrib/cmake/git-version.py
index a39cab4..a89b039 100644
--- a/contrib/cmake/git-version.py
+++ b/contrib/cmake/git-version.py
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/contrib/cmake/parse-version.m4.py b/contrib/cmake/parse-version.m4.py
index a7fbaf0..6297b92 100644
--- a/contrib/cmake/parse-version.m4.py
+++ b/contrib/cmake/parse-version.m4.py
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarballs.sh
index 32bee80..6262dd4 100755
--- a/dev-tools/gen-release-tarballs.sh
+++ b/dev-tools/gen-release-tarballs.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # gen-release-tarballs.sh  -  Generates release tarballs with signatures
 #
-# Copyright (C) 2017-2024 - David Sommerseth <davids@...515...>
+# Copyright (C) 2017-2025 - David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index b581765..ec1b2bc 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
-#  Copyright (C) 2023-2024 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2023-2024 Frank Lichtenheld <frank.lichtenheld@...515...>
+#  Copyright (C) 2023-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2023-2025 Frank Lichtenheld <frank.lichtenheld@...515...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
index 42d7368..02421c1 100755
--- a/dev-tools/reformat-all.sh
+++ b/dev-tools/reformat-all.sh
@@ -2,7 +2,7 @@
 # reformat-all.sh - Reformat all git files in the checked out
 #                   git branch using uncrustify.
 #
-# Copyright (C) 2016-2024 - David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2025 - David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
index f126ad5..f6c8cdf 100755
--- a/dev-tools/update-copyright.sh
+++ b/dev-tools/update-copyright.sh
@@ -2,8 +2,8 @@
 # update-copyright-sh - Simple tool to update the Copyright lines
 #                       in all files checked into git
 #
-# Copyright (C) 2016-2024 OpenVPN Inc <sales@...515...>
-# Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2025 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/distro/Makefile.am b/distro/Makefile.am
index 26f577b..94e4d59 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/distro/dns-scripts/Makefile.am b/distro/dns-scripts/Makefile.am
index fc2db08..9fcd3f7 100644
--- a/distro/dns-scripts/Makefile.am
+++ b/distro/dns-scripts/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/systemd-dns-updown.sh
index 6eadabc..9006e28 100644
--- a/distro/dns-scripts/systemd-dns-updown.sh
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -2,7 +2,7 @@
 #
 # dns-updown - add/remove openvpn provided DNS information
 #
-# Copyright (C) 2024 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2024-2025 OpenVPN Inc <sales@...515...>
 #
 # SPDX-License-Identifier: GPL-2.0
 #
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index 8503a0c..f9fbe45 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2017-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2017-2025 OpenVPN Inc <sales@...515...>
 #
 
 %.service: %.service.in Makefile
diff --git a/doc/Makefile.am b/doc/Makefile.am
index 634e4ce..0e7b3d5 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/include/Makefile.am b/include/Makefile.am
index 3e93bf0..b4daa97 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 34b133b..e0d0bb0 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2024 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2025 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index cacef44..4d270da 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/Makefile.am b/sample/Makefile.am
index e8799c4..9443cf3 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index 726ba4a..0cd2511 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -3,7 +3,7 @@
 # Run this script to set up a test CA, and test key-certificate pair for a
 # server, and various clients.
 #
-# Copyright (C) 2014-2024 Steffan Karger <steffan@...1856...>
+# Copyright (C) 2014-2025 Steffan Karger <steffan@...1856...>
 set -eu
 
 command -v openssl >/dev/null 2>&1 || { echo >&2 "Unable to find openssl. Please make sure openssl is installed and in your path."; exit 1; }
diff --git a/sample/sample-plugins/Makefile.am b/sample/sample-plugins/Makefile.am
index 799fe4c..95f877c 100644
--- a/sample/sample-plugins/Makefile.am
+++ b/sample/sample-plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/sample/sample-plugins/Makefile.plugins b/sample/sample-plugins/Makefile.plugins
index 3d2ec46..e366555 100644
--- a/sample/sample-plugins/Makefile.plugins
+++ b/sample/sample-plugins/Makefile.plugins
@@ -1,6 +1,6 @@
 #  SPDX-License-Identifier: GPL-2.0-only
 #
-#  Copyright (C) 2020-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
 #
 
 #
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index 1037758..18c2c6f 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c
index 109fa40..38db07f 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index a1b622a..cc256dd 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index 0debd2b..82595cf 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 4601e2a..c90cc3d 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2024 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2025 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
index 3a09eb5..6855966 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2017-2024 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2017-2025 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
index 7a53224..e17f3fa 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/Makefile.am b/src/Makefile.am
index 9fbdd40..61879c3 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 83bf423..615a433 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index b03fd5a..997f360 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/compat/compat-strsep.c b/src/compat/compat-strsep.c
index e0b613b..25eae0c 100644
--- a/src/compat/compat-strsep.c
+++ b/src/compat/compat-strsep.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2019-2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2019-2025 Arne Schwabe <arne@...1227...>
  *  Copyright (C) 1992-2019 Free Software Foundation, Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index a6f2dc4..a5d4cdc 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 2ece991..95215c0 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 08b7368..098a1cb 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index e024f95..5859905 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index d1075b2..f603ecc 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index b2a5bf5..fd81323 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 02e72dc..5f2ad5d 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index 41db0a9..0189c8b 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 2d3b359..f040724 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index 94141f5..334b3f2 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index 3a84541..5d4cf2e 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index b35df4a..ab37164 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2013-2024 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2025 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
index 38f76d4..09d0dc7 100644
--- a/src/openvpn/comp-lz4.h
+++ b/src/openvpn/comp-lz4.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2013-2024 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2025 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 21c6fd8..b2aa07e 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index f9f9598..0bb0d32 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index 449a6e8..109d691 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index fdfb001..617e146 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 81876d3..589f778 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index cb4cb16..ba61d3f 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015  David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ed70f51..7564f82 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 94f1f7f..5bd1ad5 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 71e8228..8bb7f47 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 67bc910..14727c7 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2024-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2024-2025 Arne Schwabe <arne@...1227...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h
index 9290482..c16f966 100644
--- a/src/openvpn/crypto_epoch.h
+++ b/src/openvpn/crypto_epoch.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2024-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2024-2025 Arne Schwabe <arne@...1227...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 2696330..c05902d 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 4a36d6f..6575bad 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 50e7a8f..88b3580 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index bed8844..85f53f6 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index c61cbda..98cbb72 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2024 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2021-2024 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2021-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2021-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2025 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2021-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index ed194cc..f38316d 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2024 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2021-2024 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2021-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2021-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2025 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2021-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 4bbcc82..27d03ef 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2024 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2025 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3f7965e..49dbdad 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1,9 +1,9 @@
 /*
  *  Interface to linux dco networking code
  *
- *  Copyright (C) 2020-2024 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2020-2024 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2025 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index f3abc15..273a6ad 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -1,9 +1,9 @@
 /*
  *  Interface to linux dco networking code
  *
- *  Copyright (C) 2020-2024 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2020-2024 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2025 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index a386e53..2a13658 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -1,8 +1,8 @@
 /*
  *  Interface to ovpn-win-dco networking code
  *
- *  Copyright (C) 2020-2024 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index e8e4e22..4513f3f 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -1,8 +1,8 @@
 /*
  *  Interface to ovpn-win-dco networking code
  *
- *  Copyright (C) 2020-2024 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index f137b01..da7a932 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index dabefd2..c578c6a 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 283ce67..7cf1b63 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index c56d603..60f5471 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 3fe23fd..f20ee8a 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index 70d01e2..52c5312 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 1f54ed8..fc3e64a 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index d5bb802..049cd92 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 9a4577b..e0a2730 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index a81ca1e..c3907b9 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index c212e07..389f80d 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 3d664ac..3d8654c 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index 8299f67..17b6994 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a83b258..a4f260a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 74c6036..318691f 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 2158a0b..287eb9b 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index 91f4a26..5003c96 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index 99ad803..b58defe 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h
index 27213fd..bf1cfea 100644
--- a/src/openvpn/gremlin.h
+++ b/src/openvpn/gremlin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 9e28e87..8761826 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
index 6b42e13..ec5fe9e 100644
--- a/src/openvpn/helper.h
+++ b/src/openvpn/helper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 59fb777..8665402 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index a3458dd..50cf451 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 15eacab..7d4eb85 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 50b38e3..5c6b9c1 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 34088ab..c568036 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index 8821e0b..f1abeee 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index 06db779..60030fd 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 6987def..1f33b5f 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 6af7262..783570f 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index bd7e2f9..01db221 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index c271527..03da2af 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 3936320..8836e79 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 02ceb82..eb19a4e 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 823babd..3346a11 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index e6c9162..b9c1645 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index c1fba48..6947275 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 70ba5e4..4695700 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2024 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 5f55a060..c6e2fa51 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 24b9543..a617b33 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index fbe102a..c359fd2 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 89dee7d..01ccdeb 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index b5a0a98..426af5e 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
index 8ab02d5..cbef26a 100644
--- a/src/openvpn/mstats.c
+++ b/src/openvpn/mstats.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mstats.h b/src/openvpn/mstats.h
index 6b44431..ea0237f 100644
--- a/src/openvpn/mstats.h
+++ b/src/openvpn/mstats.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 86c5160..71991dd 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 7f95529..334d6eb 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 269a9ef..78f1309 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 97aafc6..dca402a 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 7158d5c..93e65e0 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 2fa4c4d..4c83ad4 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b638fe8..169af43 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index e14ad60..40f7519 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 7f47319..2bce272 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 0887a5e..aecb65f 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index f06d6df..6f5a6d6 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2024 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2025 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 6f13ef5..28b5bfc 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -1,7 +1,7 @@
 /*
  *  Networking API implementation for iproute2
  *
- *  Copyright (C) 2018-2024 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2018-2025 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_iproute2.h b/src/openvpn/networking_iproute2.h
index c2c2e74..ae72099 100644
--- a/src/openvpn/networking_iproute2.h
+++ b/src/openvpn/networking_iproute2.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2024 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2025 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index a75de9b..79aba8d 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1,7 +1,7 @@
 /*
  *  Simplified Interface To NetLink
  *
- *  Copyright (C) 2016-2024 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2025 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
index d48a3ea..002b479 100644
--- a/src/openvpn/networking_sitnl.h
+++ b/src/openvpn/networking_sitnl.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2024 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2025 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 00c6c3c..773fcfd 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 11ecab6..8631bce 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index bd6f09c..6baaaea 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 977d02d..54d5a06 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 1023520..3c8ce39 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 937b74f..0d648ba 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2008-2024 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2008-2025 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -4837,7 +4837,7 @@
 #endif
     show_dco_version(M_INFO | M_NOPREFIX);
     msg(M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
-    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>");
+    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>");
 #ifndef ENABLE_SMALL
 #ifdef CONFIGURE_DEFINES
     msg(M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b0b8d96..b28ad58 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index fea4c3d..80d0c08 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index f34d997..2474e7f 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index d77c99e..e604a28 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 9543732..5c3e86f 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index f6d745c..865bb38 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -1,7 +1,7 @@
 /*
  *  ovpn-dco-win OpenVPN protocol accelerator for Windows
  *
- *  Copyright (C) 2020-2021 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
  *
  *  Author:	Lev Stipakov <lev@...515...>
  *
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 149dda2..c8dae32 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 07e92ff..6db939f 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index 02e4e75..71c00e5 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
index 04abe89..5ddebeb 100644
--- a/src/openvpn/perf.h
+++ b/src/openvpn/perf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index b577b54..f570d95 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 4a87895..4cb89b4 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 37cc167..00428d8 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index 772fa4e..72913eb 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index 6a67a7f..dce6822 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 0a930f9..13b8a86 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 9382049..e6baa43 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index d1cb7d1..b690192 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 81c222c..56f8909 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 944ce94..bafa469 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index ad2e086..5e91c60 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index e3c3708..ced172c 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index d4573b2..9c3905d 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 161c486..90930fe 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 0ffeaef..11c2a49 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 560db6f..0117a66 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 1475b87..cf1fbdb 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index d12ac9e..0f2b812 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index 1be29ae..59aecbe 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index c97ce28..fe289f1 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 6af0853..048b4c4 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
index d5ace29..d946a5f 100644
--- a/src/openvpn/pushlist.h
+++ b/src/openvpn/pushlist.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
index 538bbbc..a5bcf94 100644
--- a/src/openvpn/reflect_filter.c
+++ b/src/openvpn/reflect_filter.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reflect_filter.h b/src/openvpn/reflect_filter.h
index 12eb0a1..ae7be21 100644
--- a/src/openvpn/reflect_filter.h
+++ b/src/openvpn/reflect_filter.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 019ec18..6aef112 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 766c07d..2cbff01 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index dbdc01d..bd79a28 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index dda210a..aa3114c 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 192c8e6..8b5fa4f 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index b0b51c3..e9a6fe1 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index b1385e0..aaa9885 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index 03132c4..1608708 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index ada5000..47226fb 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
index 5f078c3..5ce9a96 100644
--- a/src/openvpn/session_id.h
+++ b/src/openvpn/session_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index f8a498d..1075954 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 4783ebc..2b3eeb9 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index b0f8935..9334b10 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2016-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 48ded1d..fe81af9 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 93d793b..980d8b4 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 29311de..6d71e83 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index d2105cb..cc2dbdf 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index d5658ee..0eaa9da 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5ecf42b..9c6616a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
- *  Copyright (C) 2008-2024 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2008-2025 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index c158b35..000992d 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 21abacc..1cf9e1d 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index d2c6393..e9e50da 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 6474f80..5936ca3 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *  Copyright (C) 2006-2010, Brainspark B.V.
  *
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 9ebb2ce..3841eff 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index a9cd470..74d7b43 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
- *  Copyright (C) 2008-2024 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2008-2025 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index d2e8300..6159264 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index f7be50c..2fc77d8 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 222dd4f..f26b44e 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index ac65203..bfd405f 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 0cd4127..98a39d3 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index 1ee4988..d3d7b2c 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index 25f169c..e50f899 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index d2cc3d1..41635c8 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 6d269b2..9a30db0 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 3c80324..eb80cc8 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 7b387ec..25ad09c 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
index 300b2f5..ff21157 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index ce1e7da..1546815 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index c31daa3..00c106d 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 6a5d84e..4b0e516 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index 80004b0..eaed22a 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 844e47a..00d7685 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d7c38a1..d15d9eb6 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index de1876a..ec0f4da 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index c626993..50ef765 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun_afunix.h b/src/openvpn/tun_afunix.h
index 265602f..21ae676 100644
--- a/src/openvpn/tun_afunix.h
+++ b/src/openvpn/tun_afunix.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index dd1365b..d0beb48 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
index 7a474f1..f6cf385 100644
--- a/src/openvpn/vlan.h
+++ b/src/openvpn/vlan.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c
index cf5b39c..2f13001 100644
--- a/src/openvpn/wfp_block.c
+++ b/src/openvpn/wfp_block.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *                2015-2016  <iam@...2070...>
  *                2016 Selva Nair <selva.nair@...277...>
  *
diff --git a/src/openvpn/wfp_block.h b/src/openvpn/wfp_block.h
index 56dabf6..fc5ec7e 100644
--- a/src/openvpn/wfp_block.h
+++ b/src/openvpn/wfp_block.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 1aa0069..dd55743 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
index 14e335a..bd7c03a 100644
--- a/src/openvpn/win32-util.h
+++ b/src/openvpn/win32-util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index caa14d6..8d6f9c3 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 685898c..4b07d9e 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 9017cd0..84c6329 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 10cdc0b..b5ed73c 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 964d2eb..deaca38 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index 40f0cd0..b463531 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -1,8 +1,8 @@
 #
 #  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index daade91..6f14a5c 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
index ce1c69a..0f5b2fb 100644
--- a/src/openvpnmsica/msica_arg.c
+++ b/src/openvpnmsica/msica_arg.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h
index 43f2b5b..2a3e931 100644
--- a/src/openvpnmsica/msica_arg.h
+++ b/src/openvpnmsica/msica_arg.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index 685fc60..c0f5853 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h
index 557ac98..ab029cc 100644
--- a/src/openvpnmsica/msiex.h
+++ b/src/openvpnmsica/msiex.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 4ff1b70..003da6e 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 9898067..b4e3aa8 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/openvpnmsica_resources.rc
index f972643..0bf7330 100644
--- a/src/openvpnmsica/openvpnmsica_resources.rc
+++ b/src/openvpnmsica/openvpnmsica_resources.rc
@@ -1,7 +1,7 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 852746d..ef5f3f3 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 198835e..fe360fa 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2011-2024 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2011-2025 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 6681b7c..3bd2722 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2012-2024 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2012-2025 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index cebc67f..bfbe466 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2024 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2025 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 9f176c0..9231417 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index 5cd6d16..3ef577b 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -6,7 +6,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/Makefile.am b/src/plugins/Makefile.am
index a9f9d01..4344fe5 100644
--- a/src/plugins/Makefile.am
+++ b/src/plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 54cab33..8692806 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2016-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index 97befd6..a6ccfbf 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index 3eac936..844d2d1 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index 384bc81..253adcd 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2013      David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index f3851ac..86c8dc1 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -1,8 +1,8 @@
 #
 #  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index 49a3cf6..3814db1 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -2,8 +2,8 @@
  *  basic -- Basic macros
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/error.c b/src/tapctl/error.c
index 1af1f8f..10c89d5 100644
--- a/src/tapctl/error.c
+++ b/src/tapctl/error.c
@@ -2,8 +2,8 @@
  *  error -- OpenVPN compatible error reporting API
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index 6631c0b..42c175e 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -2,8 +2,8 @@
  *  error -- OpenVPN compatible error reporting API
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 4569b87..58ab8cc 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -2,8 +2,8 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 0fdd750..39b43ac 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index c35176c..1ca512a 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tapctl_resources.rc b/src/tapctl/tapctl_resources.rc
index 28d0751..f2a1ae0 100644
--- a/src/tapctl/tapctl_resources.rc
+++ b/src/tapctl/tapctl_resources.rc
@@ -1,7 +1,7 @@
 /*
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *
- *  Copyright (C) 2018-2024 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 3246e34..4b4bcaa 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c
index 18d555a..f5eba88 100644
--- a/tests/ntlm_support.c
+++ b/tests/ntlm_support.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- * Copyright (C) 2023-2024 OpenVPN Inc <sales@...515...>
+ * Copyright (C) 2023-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvpn/cert_data.h
index d1cccbe..bbf3736 100644
--- a/tests/unit_tests/openvpn/cert_data.h
+++ b/tests/unit_tests/openvpn/cert_data.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/openvpn/mock_management.c
index dbbb56a..c3e38b9 100644
--- a/tests/unit_tests/openvpn/mock_management.c
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
index ac677a6..5cfe8d0 100644
--- a/tests/unit_tests/openvpn/mock_ssl_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_win32_execve.c b/tests/unit_tests/openvpn/mock_win32_execve.c
index e8294e8..26f8a84 100644
--- a/tests/unit_tests/openvpn/mock_win32_execve.c
+++ b/tests/unit_tests/openvpn/mock_win32_execve.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2024 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2023-2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2023-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2023-2025 Arne Schwabe <arne@...1227...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/tests/unit_tests/openvpn/pkey_test_utils.c b/tests/unit_tests/openvpn/pkey_test_utils.c
index f66b9a4..9a044ec 100644
--- a/tests/unit_tests/openvpn/pkey_test_utils.c
+++ b/tests/unit_tests/openvpn/pkey_test_utils.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 478995f..9225b4d 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 56e9d98..0c604ff 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2025 Arne Schwabe <arne@...1227...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index b744e96..9c40f5c 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2019-2024 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2019-2025 Arne Schwabe <arne@...1227...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 3fe3e46..adad40b 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index b92412d..fd38d3b 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2024 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2025 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index c383034..2a05c4f 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- * Copyright (C) 2023-2024 OpenVPN Inc <sales@...515...>
+ * Copyright (C) 2023-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index 620542d..400c0f4 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2023-2025 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the

