From: Paul Howarth <paul@...775...>
Content-Type: multipart/mixed; boundary="=-ONzUZi09X0Dwr/B+f/vU"
Date: Wed, 13 Sep 2006 08:46:54 +0100
Message-Id: <1158133614.22429.11.camel@...776...>
Mime-Version: 1.0
Subject: [Openvpn-devel] beta15 loopback test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-ONzUZi09X0Dwr/B+f/vU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I found with beta15 that the TLS loopback test runs indefinitely, as
there is now sufficient data passing to hold off the inactivity timer.

The attached patch works for me.

Cheers, Paul.

--=-ONzUZi09X0Dwr/B+f/vU
Content-Disposition: attachment; filename=openvpn-2.1_beta15-test-timeout.patch
Content-Type: text/x-patch; name=openvpn-2.1_beta15-test-timeout.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- openvpn-2.1_beta15/sample-config-files/loopback-client	2006-09-12 18:21:43.000000000 +0100
+++ openvpn-2.1_beta15/sample-config-files/loopback-client	2006-09-12 18:22:40.000000000 +0100
@@ -22,4 +22,4 @@
 cert sample-keys/client.crt
 cipher DES-EDE3-CBC
 ping 1
-inactive 120
+inactive 120 10000000
--- openvpn-2.1_beta15/sample-config-files/loopback-server	2006-09-12 18:21:50.000000000 +0100
+++ openvpn-2.1_beta15/sample-config-files/loopback-server	2006-09-12 18:22:51.000000000 +0100
@@ -23,4 +23,4 @@
 cert sample-keys/server.crt
 cipher DES-EDE3-CBC
 ping 1
-inactive 120
+inactive 120 10000000

--=-ONzUZi09X0Dwr/B+f/vU--


