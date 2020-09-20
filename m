From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 20 Sep 2020 18:27:38 +0300
Message-Id: <20200920152738.20086-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Alias ADAPTER_DOMAIN_SUFFIX to DOMAIN
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

ADAPTER_DOMAIN_SUFFIX is an openvpn3 replacement for
DOMAIN, which is used there for split-dns. This is pushed by
modern Access Server.

This change improves compatibility between OpenVPN
community client and Access Server.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 doc/man-sections/vpn-network-options.rst |  3 +++
 src/openvpn/options.c                    | 21 +++++++++++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 825dd1ca..dbc51e6c 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -114,6 +114,9 @@ routing.
   :code:`DOMAIN` ``name``
         Set Connection-specific DNS Suffix to :code:`name`.
 
+  :code:`ADAPTER_DOMAIN_SUFFIX` ``name``
+        Set Connection-specific DNS Suffix to :code:`name`.
+
   :code:`DOMAIN-SEARCH` ``name``
         Add :code:`name` to the domain search list.
         Repeat this option to add more entries. Up to
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4b22d3d9..bcff0611 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -715,16 +715,17 @@ static const char usage_message[] =
     "                    be used with --ip-win32 dynamic.  For options\n"
     "                    which allow multiple addresses,\n"
     "                    --dhcp-option must be repeated.\n"
-    "                    DOMAIN name : Set DNS suffix\n"
+    "                    DOMAIN name         : Set DNS suffix\n"
+    "                    ADAPTER_DOMAIN_NAME : alias to DOMAIN\n"
     "                    DOMAIN-SEARCH entry : Add entry to DNS domain search list\n"
-    "                    DNS addr    : Set domain name server address(es) (IPv4 and IPv6)\n"
-    "                    NTP         : Set NTP server address(es)\n"
-    "                    NBDD        : Set NBDD server address(es)\n"
-    "                    WINS addr   : Set WINS server address(es)\n"
-    "                    NBT type    : Set NetBIOS over TCP/IP Node type\n"
-    "                                  1: B, 2: P, 4: M, 8: H\n"
-    "                    NBS id      : Set NetBIOS scope ID\n"
-    "                    DISABLE-NBT : Disable Netbios-over-TCP/IP.\n"
+    "                    DNS addr            : Set domain name server address(es) (IPv4 and IPv6)\n"
+    "                    NTP                 : Set NTP server address(es)\n"
+    "                    NBDD                : Set NBDD server address(es)\n"
+    "                    WINS addr           : Set WINS server address(es)\n"
+    "                    NBT type            : Set NetBIOS over TCP/IP Node type\n"
+    "                                          1: B, 2: P, 4: M, 8: H\n"
+    "                    NBS id              : Set NetBIOS scope ID\n"
+    "                    DISABLE-NBT         : Disable Netbios-over-TCP/IP.\n"
     "--dhcp-renew       : Ask Windows to renew the TAP adapter lease on startup.\n"
     "--dhcp-pre-release : Ask Windows to release the previous TAP adapter lease on\n"
     "                       startup.\n"
@@ -7440,7 +7441,7 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_IPWIN32);
         bool ipv6dns = false;
 
-        if (streq(p[1], "DOMAIN") && p[2])
+        if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX")) && p[2])
         {
             o->domain = p[2];
         }
-- 
2.17.1


