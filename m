From: Gert Doering <gert@...1296...>
Date: Thu,  8 Jan 2026 08:49:06 +0100
Message-ID: <20260108074915.9417-1-gert@...1296...>
In-Reply-To: <gerrit.1767796357000.I1728fcb75284ba106e5c37ef53f6e568b64fb647@...2715...>
References: <gerrit.1767796357000.I1728fcb75284ba106e5c37ef53f6e568b64fb647@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Update Copyright statements to 2026
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

Change-Id: I1728fcb75284ba106e5c37ef53f6e568b64fb647
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1456
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1456
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/COPYING b/COPYING
index e276079..b95dec7 100644
--- a/COPYING
+++ b/COPYING
@@ -1,6 +1,6 @@
 OpenVPN (TM) -- An Open Source VPN daemon
 
-Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 
 This distribution contains multiple components, some
 of which fall under different licenses.  By using OpenVPN
diff --git a/ChangeLog b/ChangeLog
index e5c76cf..9e46b95 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,5 +1,5 @@
 OpenVPN ChangeLog
-Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 
 2025.12.17 -- Version 2.7_rc4
 
diff --git a/Makefile.am b/Makefile.am
index a62200d..362ae96 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -5,8 +5,8 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2010-2025 David Sommerseth <dazo@...2108...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2010-2026 David Sommerseth <dazo@...2108...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/PORTS b/PORTS
index 099ea1a..8ee3975 100644
--- a/PORTS
+++ b/PORTS
@@ -1,5 +1,5 @@
 OpenVPN
-Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 
   OpenVPN has been written to try to avoid features
   that are not standardized well across different
diff --git a/configure.ac b/configure.ac
index f363e0f..8ba5673 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,7 +4,7 @@
 dnl             packet encryption, packet authentication, and
 dnl             packet compression.
 dnl
-dnl  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+dnl  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 dnl  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 dnl
 dnl  This program is free software; you can redistribute it and/or modify
diff --git a/contrib/cmake/git-version.py b/contrib/cmake/git-version.py
index fc390f3..4902726 100644
--- a/contrib/cmake/git-version.py
+++ b/contrib/cmake/git-version.py
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2022-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/contrib/cmake/parse-version.m4.py b/contrib/cmake/parse-version.m4.py
index 8c95ffc..241f3b9 100644
--- a/contrib/cmake/parse-version.m4.py
+++ b/contrib/cmake/parse-version.m4.py
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2022-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2022-2022 Lev Stipakov <lev@...2698...>
 #
 #  This program is free software; you can redistribute it and/or modify
diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarballs.sh
index 7b97aa6..6071b57 100755
--- a/dev-tools/gen-release-tarballs.sh
+++ b/dev-tools/gen-release-tarballs.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # gen-release-tarballs.sh  -  Generates release tarballs with signatures
 #
-# Copyright (C) 2017-2025 - David Sommerseth <davids@...515...>
+# Copyright (C) 2017-2026 - David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/dev-tools/gerrit-send-mail.py b/dev-tools/gerrit-send-mail.py
index 450e920..ae904d5 100755
--- a/dev-tools/gerrit-send-mail.py
+++ b/dev-tools/gerrit-send-mail.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
-#  Copyright (C) 2023-2025 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2023-2025 Frank Lichtenheld <frank.lichtenheld@...515...>
+#  Copyright (C) 2023-2026 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2023-2026 Frank Lichtenheld <frank.lichtenheld@...515...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
index 15e7428..96546dd 100755
--- a/dev-tools/update-copyright.sh
+++ b/dev-tools/update-copyright.sh
@@ -2,8 +2,8 @@
 # update-copyright-sh - Simple tool to update the Copyright lines
 #                       in all files checked into git
 #
-# Copyright (C) 2016-2025 OpenVPN Inc <sales@...515...>
-# Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
+# Copyright (C) 2016-2026 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2016-2026 David Sommerseth <davids@...515...>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
diff --git a/distro/Makefile.am b/distro/Makefile.am
index 94e4d59..e27fe61 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/distro/dns-scripts/Makefile.am b/distro/dns-scripts/Makefile.am
index e3f9043..882b61a 100644
--- a/distro/dns-scripts/Makefile.am
+++ b/distro/dns-scripts/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/systemd-dns-updown.sh
index ed3947a..f91cde6 100644
--- a/distro/dns-scripts/systemd-dns-updown.sh
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -2,7 +2,7 @@
 #
 # dns-updown - add/remove openvpn provided DNS information
 #
-# Copyright (C) 2024-2025 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2024-2026 OpenVPN Inc <sales@...515...>
 #
 # SPDX-License-Identifier: GPL-2.0
 #
diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index f9fbe45..e3e6053 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2017-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2017-2026 OpenVPN Inc <sales@...515...>
 #
 
 %.service: %.service.in Makefile
diff --git a/doc/Makefile.am b/doc/Makefile.am
index 0e7b3d5..5ca1c4d 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/doc/doxygen/Makefile.am b/doc/doxygen/Makefile.am
index e0a52d0..1b544b1 100644
--- a/doc/doxygen/Makefile.am
+++ b/doc/doxygen/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2017-2021 Sentyron B.V. <openvpn@...2918...>
+#  Copyright (C) 2017-2026 Sentyron B.V. <openvpn@...2918...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
index cc04ae6..1f2e93b 100644
--- a/doc/doxygen/doc_compression.h
+++ b/doc/doxygen/doc_compression.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_control_processor.h b/doc/doxygen/doc_control_processor.h
index f265622..6e351dd 100644
--- a/doc/doxygen/doc_control_processor.h
+++ b/doc/doxygen/doc_control_processor.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_control_tls.h b/doc/doxygen/doc_control_tls.h
index 07251c0..24a9988 100644
--- a/doc/doxygen/doc_control_tls.h
+++ b/doc/doxygen/doc_control_tls.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_data_control.h b/doc/doxygen/doc_data_control.h
index 91e49c4..68561e9 100644
--- a/doc/doxygen/doc_data_control.h
+++ b/doc/doxygen/doc_data_control.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
index 64024a1..2b582e0 100644
--- a/doc/doxygen/doc_data_crypto.h
+++ b/doc/doxygen/doc_data_crypto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_eventloop.h b/doc/doxygen/doc_eventloop.h
index aa91166..55ecd73 100644
--- a/doc/doxygen/doc_eventloop.h
+++ b/doc/doxygen/doc_eventloop.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_external_multiplexer.h b/doc/doxygen/doc_external_multiplexer.h
index 03a0bb4..be5e6cb 100644
--- a/doc/doxygen/doc_external_multiplexer.h
+++ b/doc/doxygen/doc_external_multiplexer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_fragmentation.h b/doc/doxygen/doc_fragmentation.h
index 8b0ccee..1242908 100644
--- a/doc/doxygen/doc_fragmentation.h
+++ b/doc/doxygen/doc_fragmentation.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_internal_multiplexer.h b/doc/doxygen/doc_internal_multiplexer.h
index 40ef32e..413f2d0 100644
--- a/doc/doxygen/doc_internal_multiplexer.h
+++ b/doc/doxygen/doc_internal_multiplexer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_key_generation.h b/doc/doxygen/doc_key_generation.h
index 1c67fa7..edc2be0 100644
--- a/doc/doxygen/doc_key_generation.h
+++ b/doc/doxygen/doc_key_generation.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_mainpage.h b/doc/doxygen/doc_mainpage.h
index a78d31b..05dbcc62 100644
--- a/doc/doxygen/doc_mainpage.h
+++ b/doc/doxygen/doc_mainpage.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_memory_management.h b/doc/doxygen/doc_memory_management.h
index 74a47ba..b548036 100644
--- a/doc/doxygen/doc_memory_management.h
+++ b/doc/doxygen/doc_memory_management.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
index 3fb81c8..70d0883 100644
--- a/doc/doxygen/doc_protocol_overview.h
+++ b/doc/doxygen/doc_protocol_overview.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_reliable.h b/doc/doxygen/doc_reliable.h
index 73200e3..a2fff12 100644
--- a/doc/doxygen/doc_reliable.h
+++ b/doc/doxygen/doc_reliable.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/doc/doxygen/doc_tunnel_state.h b/doc/doxygen/doc_tunnel_state.h
index f2f788e..296e804 100644
--- a/doc/doxygen/doc_tunnel_state.h
+++ b/doc/doxygen/doc_tunnel_state.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/include/Makefile.am b/include/Makefile.am
index b4daa97..af02d88 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index a692137..a0cec53 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2025 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2026 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 0bf88fc..dde5dea 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/Makefile.am b/sample/Makefile.am
index 4ed78a6e..f3528ba 100644
--- a/sample/Makefile.am
+++ b/sample/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index 0cd2511..fa5f697 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -3,7 +3,7 @@
 # Run this script to set up a test CA, and test key-certificate pair for a
 # server, and various clients.
 #
-# Copyright (C) 2014-2025 Steffan Karger <steffan@...1856...>
+# Copyright (C) 2014-2026 Steffan Karger <steffan@...1856...>
 set -eu
 
 command -v openssl >/dev/null 2>&1 || { echo >&2 "Unable to find openssl. Please make sure openssl is installed and in your path."; exit 1; }
diff --git a/sample/sample-plugins/Makefile.am b/sample/sample-plugins/Makefile.am
index 95f877c..29ca9f5 100644
--- a/sample/sample-plugins/Makefile.am
+++ b/sample/sample-plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #
 
 MAINTAINERCLEANFILES = \
diff --git a/sample/sample-plugins/Makefile.plugins b/sample/sample-plugins/Makefile.plugins
index e366555..58f2ca1 100644
--- a/sample/sample-plugins/Makefile.plugins
+++ b/sample/sample-plugins/Makefile.plugins
@@ -1,6 +1,6 @@
 #  SPDX-License-Identifier: GPL-2.0-only
 #
-#  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2020-2026 OpenVPN Inc <sales@...515...>
 #
 
 #
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index eaa07d2..420de61 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c
index 3c9c9c6..f6bbf44 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index e7556a1..25c9ff5 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index 70fa60d..330e3e0 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 1b43947..deae590 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2025 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
index 8ca0888..ab6aed8 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2017-2025 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2017-2026 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
index 8b2b793..687a633 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/Makefile.am b/src/Makefile.am
index 61879c3..bdd2c91 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 615a433..69b2990 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index 29ded6c..7207ee4 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/compat/compat-strsep.c b/src/compat/compat-strsep.c
index 3efe0bf..68d15e4 100644
--- a/src/compat/compat-strsep.c
+++ b/src/compat/compat-strsep.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2019-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2019-2026 Arne Schwabe <arne@...1227...>
  *  Copyright (C) 1992-2019 Free Software Foundation, Inc.
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index db87dfc..19c21c0f 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 79b541a..922ece0 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 969d7b1..4b1b867 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 1e4a413..7b66a81 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index aae84f5..22176f4 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index acab06b..dd74b38 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 1a6358d..7502050 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index eebf087..c29b0bb8 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 7751a47..f671fee 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index 7d787e0..1e8ceb3 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index 7779614..aa7b721 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 53a5b3f..45f138c 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2013-2025 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2026 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
index fb22c12..3d04771 100644
--- a/src/openvpn/comp-lz4.h
+++ b/src/openvpn/comp-lz4.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2013-2025 Gert Doering <gert@...1296...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2013-2026 Gert Doering <gert@...1296...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 9d35141..b88b79f 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 1717029..29a90a2 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index bf709df..f0c89f7 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 3cb23b3..78f445b 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2026 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index fba2a09..89550ce 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2026 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 2a925d6..2a9f3b6 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015  David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2026 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ddf3c17..e3d1fa5 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 6670deb..1744653 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index e95752a..e9fc2f3 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index f34dc8cc..d2df476 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2024-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2024-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2024-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2024-2026 Arne Schwabe <arne@...1227...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h
index a6fa116..2b3d345 100644
--- a/src/openvpn/crypto_epoch.h
+++ b/src/openvpn/crypto_epoch.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2024-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2024-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2024-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2024-2026 Arne Schwabe <arne@...1227...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 6688d48..e1a5cad 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 71514fc..af71037 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index ec0269c..64882f5 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index d0421e8..8c2c693 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 6a1a5c9..26b8645 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2025 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2021-2025 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2021-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2021-2026 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2026 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2021-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index cd6e32a..4e5aad5 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2025 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2021-2025 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2021-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2021-2026 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2026 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2021-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 97a7048..da07780 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2025 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2026 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2022-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 2664029..3ad8b90 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -1,9 +1,9 @@
 /*
  *  Interface to linux dco networking code
  *
- *  Copyright (C) 2020-2025 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2020-2025 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2026 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020-2026 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index efd5b27..e3e4824 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -1,9 +1,9 @@
 /*
  *  Interface to linux dco networking code
  *
- *  Copyright (C) 2020-2025 Antonio Quartulli <a@...2181...>
- *  Copyright (C) 2020-2025 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2026 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020-2026 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 94f043f..9599e9f3 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -1,8 +1,8 @@
 /*
  *  Interface to ovpn-win-dco networking code
  *
- *  Copyright (C) 2020-2025 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2026 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 02b8389..ac3ce33 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -1,8 +1,8 @@
 /*
  *  Interface to ovpn-win-dco networking code
  *
- *  Copyright (C) 2020-2025 Arne Schwabe <arne@...1227...>
- *  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2026 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index a34bfca..a54ab3f 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index 2ad31a6..38ebf8d 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 539023f..c00d4b9 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 3dd7847..882e474 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/domain_helper.h b/src/openvpn/domain_helper.h
index f1ecf86..be9c116 100644
--- a/src/openvpn/domain_helper.h
+++ b/src/openvpn/domain_helper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2025 Lev Stipakov <lev@...515...>
+ *  Copyright (C) 2025-2026 Lev Stipakov <lev@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 1311e6f..99ac45c 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2026 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index ddcfa14..fcfc3ca 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index f1ae8c5..d79efbb 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 83eb9eb..bc8cc98 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 3088dbb..44572b4 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index ca2d0c1..9e17807 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index c2c63f6..40ed161 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 2c6525b..6910f81 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index 4c0ab65..eac8075 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 492e667..d208c21 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 7f6f666..0d3e492 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 7fc42e5..c454434 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/fragment.h b/src/openvpn/fragment.h
index 9719bf5..d577517 100644
--- a/src/openvpn/fragment.h
+++ b/src/openvpn/fragment.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index a3dbff1..0bd9396 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h
index 2422338..cb53b4f 100644
--- a/src/openvpn/gremlin.h
+++ b/src/openvpn/gremlin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index b2ecb1e..9e7ad93 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/helper.h b/src/openvpn/helper.h
index 0ce12dd..d29257c 100644
--- a/src/openvpn/helper.h
+++ b/src/openvpn/helper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 3e6520a..ab8a710 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/httpdigest.h b/src/openvpn/httpdigest.h
index 1b51a62..9f3b075 100644
--- a/src/openvpn/httpdigest.h
+++ b/src/openvpn/httpdigest.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c0e4418..c014a91 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index d5c8c04..9c4cf71 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 2a6f14a..ecfbe3f 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index f9953a6..c40a29a 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index b133c44..f6d3503 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 0015674..f0e9908 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 5702b95..04cc3ab 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 8307b59..538c66d 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index 9d4fa30..bb9cc81 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 2191e55..8fa8784 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index dedcc15..38f437f 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 540f370..d457b5e 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2023-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 42858ec..5e1b585 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index f741e21..cfe698c 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index b92b971..ea620c2 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 188f44e..9ff281c 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2014-2015 David Sommerseth <davids@...1347...>
- *  Copyright (C) 2016-2025 David Sommerseth <davids@...515...>
+ *  Copyright (C) 2016-2026 David Sommerseth <davids@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index e87fd85..e9cfadb 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index d17902f..167d995 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index afd2e6c..c8daa15 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 10d61d1..3e19ea3 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index bcbb5a8..1d092bb 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 81310a2..b7bef46 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index f4b806c..9b7d1d2 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index e080ea9..67ae67f 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index b690149..29a7d04 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 92d4dda..8b2332e 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 7e377b9..005ee10 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 329d0a3..2af49d2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 1209dfb..11f68b0 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 997951e..f484fe2 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 4a3c60d..6b2f59a 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 6c253f9..bce0c19 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2025 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2026 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 773571d..a1f3525 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -1,7 +1,7 @@
 /*
  *  Networking API implementation for iproute2
  *
- *  Copyright (C) 2018-2025 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2018-2026 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_iproute2.h b/src/openvpn/networking_iproute2.h
index 07de8b7..dd7d8b3 100644
--- a/src/openvpn/networking_iproute2.h
+++ b/src/openvpn/networking_iproute2.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2025 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2026 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 3e20b70..a5b2905 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1,7 +1,7 @@
 /*
  *  Simplified Interface To NetLink
  *
- *  Copyright (C) 2016-2025 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2026 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
index 97ff443..481cc36 100644
--- a/src/openvpn/networking_sitnl.h
+++ b/src/openvpn/networking_sitnl.h
@@ -1,7 +1,7 @@
 /*
  *  Generic interface to platform specific networking code
  *
- *  Copyright (C) 2016-2025 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2016-2026 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 78013ae..aa262a8 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 369d94e..bda4f18 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index b9af132..ab011d3 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 0c22e27..b7eca19 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 9325e21..fa00822 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 22ec7fe..3d86fc4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2008-2025 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2008-2026 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -4914,7 +4914,7 @@
 #endif
     show_dco_version(M_INFO | M_NOPREFIX);
     msg(M_INFO | M_NOPREFIX, "Originally developed by James Yonan");
-    msg(M_INFO | M_NOPREFIX, "Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>");
+    msg(M_INFO | M_NOPREFIX, "Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>");
 #ifndef ENABLE_SMALL
 #ifdef CONFIGURE_DEFINES
     msg(M_INFO | M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 0561c25..9d89426 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
index 4cbd903..cb51ad2 100644
--- a/src/openvpn/options_parse.c
+++ b/src/openvpn/options_parse.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2008-2025 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2008-2026 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index eba7d39..8d0a143 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 5bb710a..511d189 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 1b3b096..1608458 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 60533fd..ad79120 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index e76770b..1eafd75 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -1,7 +1,7 @@
 /*
  *  ovpn-dco-win OpenVPN protocol accelerator for Windows
  *
- *  Copyright (C) 2020-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2020-2026 OpenVPN Inc <sales@...515...>
  *
  *  Author:	Lev Stipakov <lev@...515...>
  *
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 08d9d9b..a4b627c 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index e9d3647..ba59067 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index b9c0b96..526e64c 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 48d4c0a..6333e44 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 14118a9..cfcd372 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index d431db1..3ce3703 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index 4010bcf..b8b0eb0 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index eaaa07c..66aefac 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 1d527db..b6c1624 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index a612237..4f0eddf 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 0cb25f5..8e7ab7e 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index a105058..f8adde5 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 81d3739..7e9faf3 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 28ddd2c..15004c0 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index 36e9fca..e2d3f82 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index ab778875..a55a2ae 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 94952bd..3570582 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index ff6ea5a..efd4aad 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index d14725c..89c2da77 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 917f871..ed2d5c9f 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index e28c403..557ecf5 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 898d158..25df48d 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 09565b8..d18d058 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
index ef4de88..7478ddd 100644
--- a/src/openvpn/pushlist.h
+++ b/src/openvpn/pushlist.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
index 071df7c..e5226e4 100644
--- a/src/openvpn/reflect_filter.c
+++ b/src/openvpn/reflect_filter.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reflect_filter.h b/src/openvpn/reflect_filter.h
index 0601f4b..84915e8 100644
--- a/src/openvpn/reflect_filter.h
+++ b/src/openvpn/reflect_filter.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2022-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2022-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 0c8b552..52adacf 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 89a9b16..a5ed75c 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h
index e554296..aebcd9c 100644
--- a/src/openvpn/ring_buffer.h
+++ b/src/openvpn/ring_buffer.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *                2019 Lev Stipakov <lev@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 222a0fa..d90c84b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 3d19dbd..88107e9 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index a0c9484..905caa3 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index 234055e..e11b6a1 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Technologies, Inc. <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index bf6693f..6d9bb62 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index 3e2a2ad..3847186 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index f31b898..651f7c1 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
index 24e7ab0..93730f1 100644
--- a/src/openvpn/session_id.h
+++ b/src/openvpn/session_id.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index fb2621e..5f0e763 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 4483d15..9bcc4ee 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 42ad823..81654f9 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2016-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2016-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index b5d81fc..0f8eba3 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 3e90833..e2c5844 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 7cf5b72..850064d 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c
index fa566e7..0194f38 100644
--- a/src/openvpn/socket_util.c
+++ b/src/openvpn/socket_util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index f3dfd22..13deeaa 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 7ecf01a..ed2d9e9 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 4f1f094..846113d 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5ee51e9..69d0e4e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
- *  Copyright (C) 2008-2025 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2008-2026 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 9ee9f38..28a3b78 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 1c3c22e..816fb9c 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 2764840..1cf254f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 28b92ed..f902e17 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *  Copyright (C) 2006-2010, Brainspark B.V.
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 8380a116..f744945 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index d4519b0..1a2405c 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -5,9 +5,9 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
- *  Copyright (C) 2008-2025 David Sommerseth <dazo@...2108...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2008-2026 David Sommerseth <dazo@...2108...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 6edd074..837f662 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 35b75eb..09f23964 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 2c1f36d..3926e91 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 85a55b1..4e97ae4 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 96cdd68..ac9d4be 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index fb7cf3e..c0620a4 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index 007ed69..2177d94 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index a11003c..a3ba66e 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index accf558..3176d76 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 1d56533..9cad320 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index b7de550..74b21b0 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
index d3217d2..59a53b7 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 633f78d..32e55e6 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index 3c5cb29..8a1a8e2 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2010-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 5ca33cb..3f57244 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index 25e1663..7953a4e 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 627ba92..2e22204 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 9026cff..2b00e1c 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2016-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index f6604ba..b9b15c2 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2016-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 263c965..0399b4a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 8bc876e..34f4929 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index 42bcd0d..c410480 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/tun_afunix.h b/src/openvpn/tun_afunix.h
index 3346403..5b6a8e0 100644
--- a/src/openvpn/tun_afunix.h
+++ b/src/openvpn/tun_afunix.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index a6a6e93..85a54eb 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
index e2c9c44..9389f89 100644
--- a/src/openvpn/vlan.h
+++ b/src/openvpn/vlan.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010      Fabian Knittel <fabian.knittel@...1547...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c
index 506d41b..212a4b2 100644
--- a/src/openvpn/wfp_block.c
+++ b/src/openvpn/wfp_block.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *                2015-2016  <iam@...2070...>
  *                2016 Selva Nair <selva.nair@...277...>
  *
diff --git a/src/openvpn/wfp_block.h b/src/openvpn/wfp_block.h
index 5ca093c..8bc093a 100644
--- a/src/openvpn/wfp_block.h
+++ b/src/openvpn/wfp_block.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 305a4dc..9d38cb7 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
index df4f8b3..6636cf3 100644
--- a/src/openvpn/win32-util.h
+++ b/src/openvpn/win32-util.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index df29dd7..b938d7b 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 07a58d8..ef32062 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 3d65e1f..849b8d5 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 29208a0..69be67a 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 168b554..a349d4d 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index 8dc3749..87bf9a7 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -1,8 +1,8 @@
 #
 #  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index e7d4a4b..ac9379d 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
index d750fb0..a334710 100644
--- a/src/openvpnmsica/msica_arg.c
+++ b/src/openvpnmsica/msica_arg.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h
index 858fdb6..b5adf95 100644
--- a/src/openvpnmsica/msica_arg.h
+++ b/src/openvpnmsica/msica_arg.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index 12dc0db..f8bf6ae 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h
index 60c26b5..67aa30d 100644
--- a/src/openvpnmsica/msiex.h
+++ b/src/openvpnmsica/msiex.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 7779a1e..b5d8cd2 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index c3e0445..7d6df33 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/openvpnmsica_resources.rc
index d4e0274..3cc53f9 100644
--- a/src/openvpnmsica/openvpnmsica_resources.rc
+++ b/src/openvpnmsica/openvpnmsica_resources.rc
@@ -1,7 +1,7 @@
 /*
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index f45d770..ac97eb4 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index b1c89c9..f60e2f2 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2011-2025 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2011-2026 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 9327dfa..aa7da00 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2012-2025 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2012-2026 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 3d3b82b..c67d67f 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2013-2025 Heiko Hund <heiko.hund@...1489...>
+ *  Copyright (C) 2013-2026 Heiko Hund <heiko.hund@...1489...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 3381503..5cf8325 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index 6f3bf09..12150f1 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -6,7 +6,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2016-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/Makefile.am b/src/plugins/Makefile.am
index 4344fe5..79cdcae 100644
--- a/src/plugins/Makefile.am
+++ b/src/plugins/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 15169ca..c012320 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2016-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2016-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index 0da162d..d7b544a 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index a733feb..a239885 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index da476fc..c0ea7a6 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *  Copyright (C) 2013      David Sommerseth <davids@...1347...>
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index 07fd714..58cd580 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -1,8 +1,8 @@
 #
 #  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index 620c1ca..98a2489 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -2,8 +2,8 @@
  *  basic -- Basic macros
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/error.c b/src/tapctl/error.c
index 9f5094e..9f5d365 100644
--- a/src/tapctl/error.c
+++ b/src/tapctl/error.c
@@ -2,8 +2,8 @@
  *  error -- OpenVPN compatible error reporting API
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index fb24a61..9632b2f 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -2,8 +2,8 @@
  *  error -- OpenVPN compatible error reporting API
  *           https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index c92c122..6bb4119 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -2,8 +2,8 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 9731602..16e3c0b 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index ee5fb09..de6a7b6 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/src/tapctl/tapctl_resources.rc b/src/tapctl/tapctl_resources.rc
index f84fd6d..093444a 100644
--- a/src/tapctl/tapctl_resources.rc
+++ b/src/tapctl/tapctl_resources.rc
@@ -1,7 +1,7 @@
 /*
  *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
  *
- *  Copyright (C) 2018-2025 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2026 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 4b4bcaa..bf8f960 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -5,7 +5,7 @@
 #             packet encryption, packet authentication, and
 #             packet compression.
 #
-#  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c
index 7007051..4fd044e 100644
--- a/tests/ntlm_support.c
+++ b/tests/ntlm_support.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- * Copyright (C) 2023-2025 OpenVPN Inc <sales@...515...>
+ * Copyright (C) 2023-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvpn/cert_data.h
index 9e2974a..c5d897e 100644
--- a/tests/unit_tests/openvpn/cert_data.h
+++ b/tests/unit_tests/openvpn/cert_data.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/openvpn/mock_get_random.c
index 4077afa..0840e31 100644
--- a/tests/unit_tests/openvpn/mock_get_random.c
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2017-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2017-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/openvpn/mock_management.c
index 28e541c..77f6ce2 100644
--- a/tests/unit_tests/openvpn/mock_management.c
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index 2cd1336..8176d2a 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2016-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
index 62afde5..da96b212 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2016-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
index f2fa93a..b22dd89 100644
--- a/tests/unit_tests/openvpn/mock_ssl_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/mock_win32_execve.c b/tests/unit_tests/openvpn/mock_win32_execve.c
index 0666fe8..4ca588d 100644
--- a/tests/unit_tests/openvpn/mock_win32_execve.c
+++ b/tests/unit_tests/openvpn/mock_win32_execve.c
@@ -5,8 +5,8 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2025 OpenVPN Inc <sales@...515...>
- *  Copyright (C) 2023-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2023-2026 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2023-2026 Arne Schwabe <arne@...1227...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
diff --git a/tests/unit_tests/openvpn/pkey_test_utils.c b/tests/unit_tests/openvpn/pkey_test_utils.c
index c9aef46..a7d0338 100644
--- a/tests/unit_tests/openvpn/pkey_test_utils.c
+++ b/tests/unit_tests/openvpn/pkey_test_utils.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 68e4693..e1fcc69 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2016-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 8855e5b..16949bc 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2016-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h
index 3a0598d..f898e89 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2016-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index ba386bd..d8e09c9 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2016-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 2edfba9b..4b5baf8 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_dhcp.c b/tests/unit_tests/openvpn/test_dhcp.c
index 729ca58..150a3aa 100644
--- a/tests/unit_tests/openvpn/test_dhcp.c
+++ b/tests/unit_tests/openvpn/test_dhcp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2025-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 954794e..a9ae33f 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2026 Arne Schwabe <arne@...1227...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 0a1c774..9f569a7 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2019-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2019-2026 Arne Schwabe <arne@...1227...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tests/openvpn/test_options_parse.c
index 5af84f5..bb34f01 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2025-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index ec71bc3..b7538bd 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2016-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 44bfa1d..722f9b1 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2023-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index c2aff8c..ca62b38 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2016-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 48adb96..5619f36 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2025 Selva Nair <selva.nair@...277...>
+ *  Copyright (C) 2021-2026 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the
diff --git a/tests/unit_tests/openvpn/test_socket.c b/tests/unit_tests/openvpn/test_socket.c
index 7f740ac..0fc9c8b 100644
--- a/tests/unit_tests/openvpn/test_socket.c
+++ b/tests/unit_tests/openvpn/test_socket.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2021-2025 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2026 Arne Schwabe <arne@...1227...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 8dc9b66..8ef9a3d 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- * Copyright (C) 2023-2025 OpenVPN Inc <sales@...515...>
+ * Copyright (C) 2023-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 6fe64b2..4a80a4c 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2016-2021 Sentyron B.V. <openvpn@...2918...>
+ *  Copyright (C) 2016-2026 Sentyron B.V. <openvpn@...2918...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index a109201..16e0535 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2023-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2023-2026 OpenVPN Inc <sales@...515...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by the

