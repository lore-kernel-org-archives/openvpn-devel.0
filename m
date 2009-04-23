Date: Thu, 23 Apr 2009 17:04:33 -0500
From: "Karl O. Pinc" <kop@...1206...>
Message-Id: <1240524273l.15511l.1l@...1207...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-XNBa9cC7PRaPq79EV/Ra"
Subject: [Openvpn-devel] Patch for more useful tls-verify script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-XNBa9cC7PRaPq79EV/Ra
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The attached patch changes the verify-cn script sample
to be used with --tls-verify so that instead of having
to hardcode a cn in the configuration file the
allowed cns may be written into a separate file.

This makes the process of verifying cns a whole
lot more dynamic.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

--=-XNBa9cC7PRaPq79EV/Ra
Content-Type: text/x-patch; charset=us-ascii; name=verify-cn.patch
Content-Disposition: attachment; filename=verify-cn.patch
Content-Transfer-Encoding: quoted-printable

--- verify-cn.orig	2009-04-23 16:19:46.000000000 -0500
+++ verify-cn	2009-04-23 16:21:43.000000000 -0500
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
=20
-die "usage: verify-cn cn certificate_depth X509_NAME_oneline" if (@ARGV !=
=3D 3);
+die "usage: verify-cn cnfile certificate_depth X509_NAME_oneline" if (@ARG=
V !=3D 3);
=20
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
-($cn, $depth, $x509) =3D @ARGV;
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
+($cnfile, $depth, $x509) =3D @ARGV;
=20
 if ($depth =3D=3D 0) {
     # If depth is zero, we know that this is the final
@@ -34,11 +38,19 @@
     # the X509 subject string.
=20
     if ($x509 =3D~ /\/CN=3D([^\/]+)/) {
+        $cn =3D $1;
 	# Accept the connection if the X509 common name
 	# string matches the passed cn argument.
-	if ($cn eq $1) {
-	    exit 0;
+	open(FH, '<', $cnfile) or exit 1; # can't open, nobody authenticates!
+        while (defined($line =3D <FH>)) {
+	    if ($line !~ /^[[:space:]]*(#|$)/o) {
+		chop($line);
+		if ($line eq $cn) {
+		    exit 0;
+		}
+	    }
 	}
+	close(FH);
     }
=20
     # Authentication failed -- Either we could not parse


--=-XNBa9cC7PRaPq79EV/Ra--

