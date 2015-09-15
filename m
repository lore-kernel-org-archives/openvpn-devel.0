References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-7-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55F7FABF.6040701@...1227...>
Date: Tue, 15 Sep 2015 12:02:23 +0100
MIME-Version: 1.0
In-Reply-To: <1441985627-14822-7-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 06/10] Implement handling of overlapping
 IPv6 routes with IPv6 remote VPN server address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net


+ * "good enough")
+ */
+static bool
+route_ipv6_match_host( const struct route_ipv6 *r6,
+		       const struct in6_addr *host )
+{
+    int bits = r6->netbits;
+    int i;
+    unsigned int mask;
+
+    if ( bits<0 || bits>128 )
+	return false;


bits should be unisgned int since r6->netbits is unsigned int and also
drop the bits <0

Rest looks fine to me. So ACK.

Arne


