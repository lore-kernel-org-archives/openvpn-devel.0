From: Gert Doering <gert@...1296...>
Date: Sun, 20 Nov 2016 17:45:57 +0100
Message-Id: <1479660357-12843-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Stub implementation of "--dhcp-option DNS6
	<v6addr>"
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

This defines a new DHCP suboption "DNS6", but does not actually
implement anything but "document the option and understand it".

If received, it will be put into an "foreign_option_<n>" environment
variable where an --up script or plugin could receive and act upon it.

On non-Windows platforms, all "dhcp-option" sub-options end up there,
so v4 and v6 DNS options will be reflected like this:

   foreign_option_1=dhcp-option DNS6 2001:608::2
   foreign_option_2=dhcp-option DNS 195.30.0.2

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8         | 14 +++++++++++++-
 src/openvpn/options.c | 11 ++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 11564af..d454a36 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5627,9 +5627,21 @@ across the VPN.
 Set Connection-specific DNS Suffix.
 
 .B DNS addr \-\-
-Set primary domain name server address.  Repeat
+Set primary domain name server IPv4 address.  Repeat
 this option to set secondary DNS server addresses.
 
+.B DNS6 addr \-\-
+Set primary domain name server IPv6 address.  Repeat
+this option to set secondary DNS server IPv6 addresses.
+
+Note: currently this is somewhat of a placeholder option - it is
+understood, but OpenVPN has no code to tell Windows about it (the
+existing DHCP code can only do IPv4 DHCP, and that protocol only
+permits IPv4 addresses anywhere).  The option will be put into the
+environment, so an
+.B \-\-up
+script could act upon it.
+
 .B WINS addr \-\-
 Set primary WINS server address (NetBIOS over TCP/IP Name Server).
 Repeat this option to set secondary WINS server addresses.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7f128c3..9e828d8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -704,7 +704,8 @@ static const char usage_message[] =
   "                    which allow multiple addresses,\n"
   "                    --dhcp-option must be repeated.\n"
   "                    DOMAIN name : Set DNS suffix\n"
-  "                    DNS addr    : Set domain name server address(es)\n"
+  "                    DNS addr    : Set domain name server address(es) (IPv4)\n"
+  "                    DNS6 addr   : Set domain name server address(es) (IPv6)\n"
   "                    NTP         : Set NTP server address(es)\n"
   "                    NBDD        : Set NBDD server address(es)\n"
   "                    WINS addr   : Set WINS server address(es)\n"
@@ -6406,6 +6407,14 @@ add_option (struct options *options,
 	{
 	  dhcp_option_address_parse ("DNS", p[2], o->dns, &o->dns_len, msglevel);
 	}
+      else if (streq (p[1], "DNS6") && p[2])
+	{
+	  /* this is somewhat of a placeholder - we understand the option,
+	   * but cannot act upon it - so we'll just accept it and put it
+	   * into the environment, as we would do on all non-win32 platforms
+	   */
+	  foreign_option (options, p, 3, es);
+	}
       else if (streq (p[1], "WINS") && p[2])
 	{
 	  dhcp_option_address_parse ("WINS", p[2], o->wins, &o->wins_len, msglevel);
-- 
2.7.3


