From: "Karl O. Pinc" <kop@...1206...>
Date: Thu, 18 Feb 2010 11:58:28 -0600
Message-Id: <1266515908-24807-2-git-send-email-kop@...1304...>
In-Reply-To: <1266515908-24807-1-git-send-email-kop@...1304...>
References: <1266515908-24807-1-git-send-email-kop@...1304...>
Subject: [Openvpn-devel] [PATCH] Change verify-cn so cn is no longer
	hardcoded in openvpn's config file
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

---
 sample-scripts/verify-cn |   42 +++++++++++++++++++++++++++---------------
 1 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/sample-scripts/verify-cn b/sample-scripts/verify-cn
index 5d56d95..f9fea0f 100755
--- a/sample-scripts/verify-cn
+++ b/sample-scripts/verify-cn
@@ -7,24 +7,28 @@
 #
 # For example in OpenVPN, you could use the directive:
 #
-#   tls-verify "./verify-cn Test-Client"
+#   tls-verify "./verify-cn /etc/openvpn/allowed_clients"
 #
 # This would cause the connection to be dropped unless
-# the client common name is "Test-Client"
+# the client common name is listed on a line in the
+# allowed_clients file.
 
-die "usage: verify-cn cn certificate_depth X509_NAME_oneline" if (@ARGV != 3);
+die "usage: verify-cn cnfile certificate_depth X509_NAME_oneline" if (@ARGV != 3);
 
 # Parse out arguments:
-#   cn    -- The common name which the client is required to have,
-#            taken from the argument to the tls-verify directive
-#            in the OpenVPN config file.
-#   depth -- The current certificate chain depth.  In a typical
-#            bi-level chain, the root certificate will be at level
-#            1 and the client certificate will be at level 0.
-#            This script will be called separately for each level.
-#   x509  -- the X509 subject string as extracted by OpenVPN from
-#            the client's provided certificate.
-($cn, $depth, $x509) = @ARGV;
+#   cnfile -- The file containing the list of common names, one per
+#             line, which the client is required to have,
+#             taken from the argument to the tls-verify directive
+#             in the OpenVPN config file.
+#             The file can have blank lines and comment lines that begin
+#             with the # character.
+#   depth  -- The current certificate chain depth.  In a typical
+#             bi-level chain, the root certificate will be at level
+#             1 and the client certificate will be at level 0.
+#             This script will be called separately for each level.
+#   x509   -- the X509 subject string as extracted by OpenVPN from
+#             the client's provided certificate.
+($cnfile, $depth, $x509) = @ARGV;
 
 if ($depth == 0) {
     # If depth is zero, we know that this is the final
@@ -34,11 +38,19 @@ if ($depth == 0) {
     # the X509 subject string.
 
     if ($x509 =~ /\/CN=([^\/]+)/) {
+        $cn = $1;
 	# Accept the connection if the X509 common name
 	# string matches the passed cn argument.
-	if ($cn eq $1) {
-	    exit 0;
+	open(FH, '<', $cnfile) or exit 1; # can't open, nobody authenticates!
+        while (defined($line = <FH>)) {
+	    if ($line !~ /^[[:space:]]*(#|$)/o) {
+		chop($line);
+		if ($line eq $cn) {
+		    exit 0;
+		}
+	    }
 	}
+	close(FH);
     }
 
     # Authentication failed -- Either we could not parse
-- 
1.5.6.5


