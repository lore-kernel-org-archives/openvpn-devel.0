From: selva.nair@...277...
Date: Thu, 19 Jan 2023 21:18:41 -0500
Message-Id: <20230120021841.2048791-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Warn when pkcs11-id or pkcs11-id-management
 options are ignored
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

From: Selva Nair <selva.nair@...277...>

- If there are no pkcs11-providers either directly specified or
  through p11-kit-proxy made available through a build-time detection,
  these options are ignored. Log a warning in such cases.

  Especially important on Windows where automatic loading of p11-kit
  is not enabled in our release builds.

- Document this behaviour.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/man-sections/pkcs11-options.rst | 23 ++++++++++++++---------
 src/openvpn/options.c               |  9 +++++++++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/doc/man-sections/pkcs11-options.rst b/doc/man-sections/pkcs11-options.rst
index c064aca5..de1662b7 100644
--- a/doc/man-sections/pkcs11-options.rst
+++ b/doc/man-sections/pkcs11-options.rst
@@ -13,7 +13,8 @@ PKCS#11 / SmartCard options
 
 --pkcs11-id name
   Specify the serialized certificate id to be used. The id can be gotten
-  by the standalone ``--show-pkcs11-ids`` option.
+  by the standalone ``--show-pkcs11-ids`` option. See also the description
+  of ``--pkcs11-providers`` option.
 
 --pkcs11-id-management
   Acquire PKCS#11 id from management interface. In this case a
@@ -21,6 +22,7 @@ PKCS#11 / SmartCard options
   application may use pkcs11-id-count command to retrieve available number of
   certificates, and pkcs11-id-get command to retrieve certificate id and
   certificate body.
+  See also the description of ``--pkcs11-providers`` option.
 
 --pkcs11-pin-cache seconds
   Specify how many seconds the PIN can be cached, the default is until the
@@ -51,15 +53,18 @@ PKCS#11 / SmartCard options
      pkcs11-protected-authentication 0
      pkcs11-protected-authentication 1
 
---pkcs11-providers provider
+--pkcs11-providers providers
   Specify an RSA Security Inc. PKCS #11 Cryptographic Token Interface
-  (Cryptoki) providers to load. This option can be used instead of
-  ``--cert``, ``--key`` and ``--pkcs12``.
-
-  If p11-kit is present on the system, its :code:`p11-kit-proxy.so` module
-  will be loaded by default if either the ``--pkcs11-id`` or
-  ``--pkcs11-id-management`` options are specified without
-  ``--pkcs11-provider`` being given.
+  (Cryptoki) providers to load. A space-separated list of one or more
+  provider library names may be specified. This option along with ``--pkcs11-id``
+  or ``pkcs11-id-management`` can be used instead of
+  ``--cert`` and ``--key`` or ``--pkcs12``.
+
+  If p11-kit is present on the system and was enabled during build, its
+  :code:`p11-kit-proxy.so` module will be loaded by default if either
+  the ``--pkcs11-id`` or ``--pkcs11-id-management`` options is present without
+  ``--pkcs11-providers``. If default loading is not enabled in the build and
+  no providers are specified, the former options will be ignored.
 
 --show-pkcs11-ids args
   (Standalone) Show PKCS#11 token object list.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4932a869..f24af3d7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2855,6 +2855,15 @@ options_postprocess_verify_ce(const struct options *options,
     {
         check_ca_required(options);
 #ifdef ENABLE_PKCS11
+        if (!options->pkcs11_providers[0] && options->pkcs11_id)
+        {
+            msg(M_WARN, "Option pkcs11-id is ignored as no pkcs11-providers are specified");
+        }
+        else if (!options->pkcs11_providers[0] && options->pkcs11_id_management)
+        {
+            msg(M_WARN, "Option pkcs11-id-management is ignored as no pkcs11-providers are specified");
+        }
+
         if (options->pkcs11_providers[0])
         {
             if (options->pkcs11_id_management && options->pkcs11_id != NULL)
-- 
2.34.1


