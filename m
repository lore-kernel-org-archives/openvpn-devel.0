From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 14 Nov 2023 12:21:33 +0100
Message-Id: <20231114112133.20475-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc: improve pkcs11 documentation
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

- Explicitely specify how to provide settings that are
  per-provider
- Misc grammar fixes

Change-Id: I176ba2cb885b5304a6897341f5f03dbb4a7f9028
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/pkcs11-options.rst | 34 +++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/doc/man-sections/pkcs11-options.rst b/doc/man-sections/pkcs11-options.rst
index de1662b7..911386a0 100644
--- a/doc/man-sections/pkcs11-options.rst
+++ b/doc/man-sections/pkcs11-options.rst
@@ -3,13 +3,19 @@ PKCS#11 / SmartCard options
 
 --pkcs11-cert-private args
   Set if access to certificate object should be performed after login.
-  Every provider has its own setting.
+  If you specified multiple providers with ``--pkcs11-providers``, every
+  provider has its own value for this setting, specified as a
+  space-separated list.
+
+  The default value is ``0``.
 
   Valid syntaxes:
   ::
 
      pkcs11-cert-private 0
      pkcs11-cert-private 1
+     # multiple providers
+     pkcs11-cert-private 1 0 0 1 [...]
 
 --pkcs11-id name
   Specify the serialized certificate id to be used. The id can be gotten
@@ -18,10 +24,10 @@ PKCS#11 / SmartCard options
 
 --pkcs11-id-management
   Acquire PKCS#11 id from management interface. In this case a
-  :code:`NEED-STR 'pkcs11-id-request'` real-time message will be triggered,
-  application may use pkcs11-id-count command to retrieve available number of
-  certificates, and pkcs11-id-get command to retrieve certificate id and
-  certificate body.
+  :code:`NEED-STR 'pkcs11-id-request'` real-time message will be triggered.
+  The application may use the ``pkcs11-id-count`` command to retrieve the
+  available number of certificates, and the ``pkcs11-id-get`` command to
+  retrieve certificate id and certificate body.
   See also the description of ``--pkcs11-providers`` option.
 
 --pkcs11-pin-cache seconds
@@ -30,8 +36,7 @@ PKCS#11 / SmartCard options
 
 --pkcs11-private-mode mode
   Specify which method to use in order to perform private key operations.
-  A different mode can be specified for each provider. Mode is encoded as
-  hex number, and can be a mask one of the following:
+  Mode is encoded as hex number, and can be a mask one of the following:
 
   :code:`0` (default)   Try to determine automatically.
 
@@ -43,18 +48,29 @@ PKCS#11 / SmartCard options
 
   :code:`8`             Use unwrap.
 
+  If you specified multiple providers with ``--pkcs11-providers``, every
+  provider has its own value for this setting, specified as a
+  space-separated list.
+
 --pkcs11-protected-authentication args
   Use PKCS#11 protected authentication path, useful for biometric and
-  external keypad devices. Every provider has its own setting.
+  external keypad devices.
+  If you specified multiple providers with ``--pkcs11-providers``, every
+  provider has its own value for this setting, specified as a
+  space-separated list.
+
+  The default value is ``0``.
 
   Valid syntaxes:
   ::
 
      pkcs11-protected-authentication 0
      pkcs11-protected-authentication 1
+     # multiple providers
+     pkcs11-protected-authentication 1 0 0 1 [...]
 
 --pkcs11-providers providers
-  Specify an RSA Security Inc. PKCS #11 Cryptographic Token Interface
+  Specify RSA Security Inc. PKCS #11 Cryptographic Token Interface
   (Cryptoki) providers to load. A space-separated list of one or more
   provider library names may be specified. This option along with ``--pkcs11-id``
   or ``pkcs11-id-management`` can be used instead of
-- 
2.34.1


