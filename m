From: Gert Doering <gert@...1296...>
Date: Thu, 30 Apr 2026 15:03:48 +0200
Message-ID: <20260430130354.25337-1-gert@...1296...>
In-Reply-To: <gerrit.1777553270000.Id6832e3f56420debc8b19d0144d53ca41abb678b@...2715...>
References: <gerrit.1777553270000.Id6832e3f56420debc8b19d0144d53ca41abb678b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dns-scripts: Fix dnssec values in
 comments and Copyright statement format
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

- Fix the example value of dnssec to an actual valid one
- Fix the formatting of the Copyright statements to be
  consistent with all other files in the project

Change-Id: Id6832e3f56420debc8b19d0144d53ca41abb678b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1645
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1645
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scripts/haikuos_file-dns-updown.sh
index 6da0954..e19b2b7 100644
--- a/distro/dns-scripts/haikuos_file-dns-updown.sh
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # Simple OpenVPN up/down script for modifying Haiku OS resolv.conf
-# (C) Copyright 2024 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2024-2026 OpenVPN Inc <sales@...515...>
 #
 # SPDX-License-Identifier: BSD-2-Clause
 #
@@ -21,7 +21,7 @@
 #   dns_server_1_port_2 53
 #   dns_server_1_resolve_domain_1 mycorp.in
 #   dns_server_1_resolve_domain_2 eu.mycorp.com
-#   dns_server_1_dnssec true
+#   dns_server_1_dnssec yes
 #   dns_server_1_transport DoH
 #   dns_server_1_sni dns.mycorp.in
 #
diff --git a/distro/dns-scripts/macos-dns-updown.sh b/distro/dns-scripts/macos-dns-updown.sh
index fb17b2b0..fccc6b5 100644
--- a/distro/dns-scripts/macos-dns-updown.sh
+++ b/distro/dns-scripts/macos-dns-updown.sh
@@ -2,7 +2,7 @@
 #
 # dns-updown - add/remove openvpn provided DNS information
 #
-# (C) Copyright 2025 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2025-2026 OpenVPN Inc <sales@...515...>
 #
 # SPDX-License-Identifier: BSD-2-Clause
 #
@@ -21,7 +21,7 @@
 #   dns_server_1_port_2 53
 #   dns_server_1_resolve_domain_1 mycorp.in
 #   dns_server_1_resolve_domain_2 eu.mycorp.com
-#   dns_server_1_dnssec true
+#   dns_server_1_dnssec yes
 #   dns_server_1_transport DoH
 #   dns_server_1_sni dns.mycorp.in
 #
diff --git a/distro/dns-scripts/openresolv-dns-updown.sh b/distro/dns-scripts/openresolv-dns-updown.sh
index 1404819..4aca99f 100644
--- a/distro/dns-scripts/openresolv-dns-updown.sh
+++ b/distro/dns-scripts/openresolv-dns-updown.sh
@@ -1,8 +1,8 @@
 #!/bin/sh
 #
 # Simple OpenVPN up/down script for openresolv integration
-# (C) Copyright 2016 Baptiste Daroussin
-#               2024 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2016 Baptiste Daroussin
+# Copyright (C) 2024-2026 OpenVPN Inc <sales@...515...>
 #
 # SPDX-License-Identifier: BSD-2-Clause
 #
@@ -22,7 +22,7 @@
 #   dns_server_1_port_2 53
 #   dns_server_1_resolve_domain_1 mycorp.in
 #   dns_server_1_resolve_domain_2 eu.mycorp.com
-#   dns_server_1_dnssec true
+#   dns_server_1_dnssec yes
 #   dns_server_1_transport DoH
 #   dns_server_1_sni dns.mycorp.in
 #
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-scripts/resolvconf_file-dns-updown.sh
index 70872c7..8d23ed6 100644
--- a/distro/dns-scripts/resolvconf_file-dns-updown.sh
+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 #
 # Simple OpenVPN up/down script for modifying /etc/resolv.conf
-# (C) Copyright 2024 OpenVPN Inc <sales@...515...>
+# Copyright (C) 2024-2026 OpenVPN Inc <sales@...515...>
 #
 # SPDX-License-Identifier: BSD-2-Clause
 #
@@ -21,7 +21,7 @@
 #   dns_server_1_port_2 53
 #   dns_server_1_resolve_domain_1 mycorp.in
 #   dns_server_1_resolve_domain_2 eu.mycorp.com
-#   dns_server_1_dnssec true
+#   dns_server_1_dnssec yes
 #   dns_server_1_transport DoH
 #   dns_server_1_sni dns.mycorp.in
 #
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/systemd-dns-updown.sh
index f91cde6..553056b 100644
--- a/distro/dns-scripts/systemd-dns-updown.sh
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -29,7 +29,7 @@
 #   dns_server_1_port_2 53
 #   dns_server_1_resolve_domain_1 mycorp.in
 #   dns_server_1_resolve_domain_2 eu.mycorp.com
-#   dns_server_1_dnssec true
+#   dns_server_1_dnssec yes
 #   dns_server_1_transport DoH
 #   dns_server_1_sni dns.mycorp.in
 #

