From: Richard Bonhomme <tincanteksup@...277...>
Date: Thu, 25 Jun 2020 22:01:49 +0100
Message-Id: <20200625210149.2864-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [PATCH] New man page - Simple corrections
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

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
 doc/man-sections/connection-profiles.rst | 2 +-
 doc/man-sections/examples.rst            | 2 +-
 doc/man-sections/pkcs11-options.rst      | 2 +-
 doc/man-sections/plugin-options.rst      | 4 ++--
 doc/man-sections/signals.rst             | 2 +-
 doc/man-sections/unsupported-options.rst | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections/connection-profiles.rst
index f72db56e..fd3382b2 100644
--- a/doc/man-sections/connection-profiles.rst
+++ b/doc/man-sections/connection-profiles.rst
@@ -5,5 +5,5 @@ Client configuration files may contain multiple remote servers which
 it will attempt to connect against.  But there are some configuration
 options which are related to specific ``--remote`` options.  For these
-use cases, connection profiles is the solution.
+use cases, connection profiles are the solution.
 
 By enacpulating the ``--remote`` option and related options within
diff --git a/doc/man-sections/examples.rst b/doc/man-sections/examples.rst
index ecc2a29f..20cc55ef 100644
--- a/doc/man-sections/examples.rst
+++ b/doc/man-sections/examples.rst
@@ -219,5 +219,5 @@ documentation how to properly configure IP forwarding, which is also
 persistent through system boots.
 
-If you system is configured with a firewall.  Please see your operating
+If your system is configured with a firewall.  Please see your operating
 systems guide on how to configure the firewall.  You typically want to
 allow traffic coming from and going to the tun/tap adapter OpenVPN is
diff --git a/doc/man-sections/pkcs11-options.rst b/doc/man-sections/pkcs11-options.rst
index 5495c187..d40ce9ea 100644
--- a/doc/man-sections/pkcs11-options.rst
+++ b/doc/man-sections/pkcs11-options.rst
@@ -53,5 +53,5 @@ PKCS#11 / SmartCard options
 
 --pkcs11-providers provider
-  Specify a RSA Security Inc. PKCS #11 Cryptographic Token Interface
+  Specify an RSA Security Inc. PKCS #11 Cryptographic Token Interface
   (Cryptoki) providers to load. This option can be used instead of
   ``--cert``, ``--key`` and ``--pkcs12``.
diff --git a/doc/man-sections/plugin-options.rst b/doc/man-sections/plugin-options.rst
index 75dfd5c0..20b74edd 100644
--- a/doc/man-sections/plugin-options.rst
+++ b/doc/man-sections/plugin-options.rst
@@ -3,8 +3,8 @@ Plug-in Interface Options
 
 OpenVPN can be extended by loading external plug-in modules at runtime.  These
-plug-ins must be prebuild and adhere to the OpenVPN Plug-In API.
+plug-ins must be prebuilt and adhere to the OpenVPN Plug-In API.
 
 --plugin args
-  Loads a given plug-in module.  The ``module-name`` need to be the first
+  Loads a given plug-in module.  The ``module-name`` needs to be the first
   argument, indicating the plug-in to load.  The second argument is an
   optional init string which will be passed directly to the plug-in.
diff --git a/doc/man-sections/signals.rst b/doc/man-sections/signals.rst
index fce43d84..63611b3c 100644
--- a/doc/man-sections/signals.rst
+++ b/doc/man-sections/signals.rst
@@ -21,5 +21,5 @@ SIGNALS
     when the underlying parameters of the host's network interface change
     such as when the host is a DHCP client and is assigned a new IP address.
-    See ``--ipchange`` above for more information.
+    See ``--ipchange`` for more information.
 
 :code:`SIGUSR2`
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index ae7c1bcc..67d3f54e 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -3,5 +3,5 @@ UNSUPPORTED OPTIONS
 ===================
 
-Options listed in this section has been removed from OpenVPN and is no
+Options listed in this section have been removed from OpenVPN and are no
 longer supported
 
@@ -22,5 +22,5 @@ longer supported
   VPN tunnel security.
 
---no-reply
+--no-replay
   Removed in OpenVPN 2.5.  This option should not be used as it weakens the
   VPN tunnel security.
-- 
2.17.1


