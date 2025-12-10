From: Gert Doering <gert@...1296...>
Date: Wed, 10 Dec 2025 09:56:20 +0100
Message-ID: <20251210085625.32174-1-gert@...1296...>
In-Reply-To: <gerrit.1765292004000.I1d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33@...2715...>
References: <gerrit.1765292004000.I1d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Correct documentation for --ns-cert-type
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

Our documentation claimed this option was removed.
But it was not, for compatiblity reasons. So reflect
the correct status.

Change-Id: I1d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1428
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1428
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 846dfdd..c4aa810 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -222,6 +222,17 @@
   ``--cert file`` above). URI is supported only when built with OpenSSL 3.0
   or later and any required providers are loaded. (See ``--cert`` for more details).
 
+--ns-cert-type type
+  **DEPRECATED** The ``--remote-cert-tls`` option should be used instead.
+  The option is still available since it can't be silently ignored and needs
+  updates to certificates and configs on both sides of the connection.
+  However it should not be used for new clients or servers. It depends on the
+  deprecated ``nsCertType`` certificate field.
+
+  Might not work depending on the TLS library used.
+
+  Will be removed in a future release.
+
 --pkcs12 file
   Specify a PKCS #12 file containing local private key, local certificate,
   and root CA certificate. This option can be used instead of ``--ca``,
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index 6e77333..b646991 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -44,12 +44,6 @@
   VPN tunnel security.  Previously we claimed to have removed this in
   OpenVPN 2.5, but this wasn't actually the case.
 
---ns-cert-type
-  Removed in OpenVPN 2.5.  The ``nsCertType`` field is no longer supported
-  in recent SSL/TLS libraries.  If your certificates does not include *key
-  usage* and *extended key usage* fields, they must be upgraded and the
-  ``--remote-cert-tls`` option should be used instead.
-
 --prng
   Removed in OpenVPN 2.6.  We now always use the PRNG of the SSL library.
 

