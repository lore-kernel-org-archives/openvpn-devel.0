From: Gert Doering <gert@...1296...>
Date: Thu, 28 Nov 2024 13:30:16 +0100
Message-ID: <20241128123016.10444-1-gert@...1296...>
In-Reply-To: <gerrit.1732795471000.Ifad21a2841e97e910775f3618ddac1c483d74b65@...2715...>
References: <gerrit.1732795471000.Ifad21a2841e97e910775f3618ddac1c483d74b65@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Various typo fixes
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

This collects some minor typo fixes that are not
worth each their own commit.

Fixes: OpenVPN/openvpn#644
Fixes: OpenVPN/openvpn#442

Change-Id: Ifad21a2841e97e910775f3618ddac1c483d74b65
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/822
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections/connection-profiles.rst
index 520bbef..767ff3a 100644
--- a/doc/man-sections/connection-profiles.rst
+++ b/doc/man-sections/connection-profiles.rst
@@ -6,7 +6,7 @@
 options which are related to specific ``--remote`` options.  For these
 use cases, connection profiles are the solution.
 
-By enacpulating the ``--remote`` option and related options within
+By encapsulating the ``--remote`` option and related options within
 ``<connection>`` and ``</connection>``, these options are handled as a
 group.
 
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
index 48716a0..f6d9e65 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -199,7 +199,7 @@
 # all clients to redirect their default
 # network gateway through the VPN, causing
 # all IP traffic such as web browsing and
-# and DNS lookups to go through the VPN
+# DNS lookups to go through the VPN
 # (The OpenVPN server machine may need to NAT
 # or bridge the TUN/TAP interface to the internet
 # in order for this to work properly).
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 043b240..d8dd518 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -879,7 +879,7 @@
     o->pkcs11_pin_cache_period = -1;
 #endif                  /* ENABLE_PKCS11 */
 
-/* P2MP server context features */
+    /* P2MP server context features */
     o->auth_token_generate = false;
 
     /* Set default --tmp-dir */
@@ -2966,7 +2966,7 @@
         if (options->pkcs12_file)
         {
 #ifdef ENABLE_CRYPTO_MBEDTLS
-            msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed TLS version version of OpenVPN.");
+            msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed TLS version of OpenVPN.");
 #else
             if (options->ca_path)
             {
@@ -2995,7 +2995,7 @@
 #ifdef ENABLE_CRYPTO_MBEDTLS
             if (options->ca_path)
             {
-                msg(M_USAGE, "Parameter --capath cannot be used with the mbed TLS version version of OpenVPN.");
+                msg(M_USAGE, "Parameter --capath cannot be used with the mbed TLS version of OpenVPN.");
             }
 #endif  /* ifdef ENABLE_CRYPTO_MBEDTLS */
             if (pull)

