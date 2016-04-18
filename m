From: Steffan Karger <steffan@...1856...>
Date: Mon, 18 Apr 2016 20:25:58 +0200
Message-Id: <1461003958-14726-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (2.3)] Various Changes.rst fixes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This fixes some formatting issues, and updates the text for the cipher list
restriction to match the restrictions of 2.3 (rather than those of master
wrt 2.3).

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 40fd9df..1ab3013 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -100,23 +100,28 @@ Behavioral changes
 - Do not randomize resolving of IP addresses in getaddr()
 
 
-
 Version 2.3.11
 ==============
 
 Behavioral changes
 ------------------
 
-- Stricter default TLS cipher list (override with ``--tls-cipher``), that now
-  also disables:
+- Stricter default TLS cipher list: disable various old/weak ciphers.
 
-  * Non-ephemeral key exchange using static (EC)DH keys
-  * DSS private keys
+  This can lead to 'no shared cipher' errors if one of the peers only accepts
+  the older/weaker ciphers.  Check your ``--tls-cipher`` settings if this is
+  the case.  Disabled ciphers:
 
+  * Export ciphers (these are broken on purpose...)
+  * Ciphers in the LOW and MEDIUM security cipher list of OpenSSL.
+    The LOW group contains ciphers that are considered insecure (such as DES),
+    and will be completely removed from OpenSSL in 1.1.0, the MEDIUM group
+    contains less-secure ciphers like RC4 and SEED.
+  * Ciphers that were not supported by OpenVPN anyway (cleans up the list)
 
 
 Version 2.3.10
-=============
+==============
 
 New features
 ------------
@@ -126,7 +131,7 @@ New features
 Behavioral changes
 ------------------
 
-- PolarSSL support changed from PolarSSL v1.2 to PolarSSL v1.3, 
+- PolarSSL support changed from PolarSSL v1.2 to PolarSSL v1.3,
   as v1.2 is end-of-support 2015-12-31.
 
 - fall back to using interface names for netsh.exe calls on
-- 
2.5.0


