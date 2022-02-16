From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Wed, 16 Feb 2022 14:57:16 +0100
Message-ID: <20220216135716.6541-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add warning about mbed TLS licensing problem
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

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 README.mbedtls | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/README.mbedtls b/README.mbedtls
index 4875822d..b5604bb8 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -11,6 +11,23 @@ This version depends on mbed TLS 2.0 (and requires at least 2.0.0).
 
 *************************************************************************
 
+Warning:
+
+As of version 2.17, mbed TLS can be licensed *only* under the Apache v2.0
+license. That license is incompatible with OpenVPN's GPLv2.
+
+If you wish to distribute OpenVPN linked with mbed TLS, there are two options:
+
+ * Ensure that your case falls under the system library exception in GPLv2, or
+
+ * Use an earlier version of mbed TLS. Version 2.16.12 is the last release
+   that may be licensed under GPLv2. Unfortunately, this version is
+   unsupported and won't receive any more updates.
+
+Support for mbed TLS is likely to be removed in OpenVPN 2.17.
+
+*************************************************************************
+
 Due to limitations in the mbed TLS library, the following features are missing
 in the mbed TLS version of OpenVPN:
 
-- 
2.20.1


