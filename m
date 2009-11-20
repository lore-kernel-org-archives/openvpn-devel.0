Message-ID: <4B06ABED.8090800@...41...>
Date: Fri, 20 Nov 2009 07:47:09 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc22 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Openvpn-devel@lists.sourceforge.net, OpenVpn-Users <openvpn-users@lists.sourceforge.net>

Change log:

2009.11.20 -- Version 2.1_rc22

* Fixed a client-side bug on Windows that occurred when the
   "dhcp-pre-release" or "dhcp-renew" options were combined with
   "route-gateway dhcp".  The release/renew would not occur
   because the Windows DHCP renew function is blocking and
   therefore must be called from another process or thread
   so as not to stall the tunnel.

* Added a hard failure when peer provides a certificate chain
   with depth > 16.  Previously, a warning was issued.

James

