Message-ID: <48CDC8F9.5080609@...41...>
Date: Sun, 14 Sep 2008 19:31:21 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1_rc11 released
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
To: Openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net, openvpn-announce@lists.sourceforge.net

This release fixes a serious (though not security-related) bug in the 
SSL/TLS negotiation over UDP that can cause SSL/TLS handshake failures. 
  The bug was introduced in 2.1_rc9.

All users of OpenVPN 2.1_rc9 and rc10 are urged to upgrade.

Change log:

2008.09.14 -- Version 2.1_rc11

* Fixed a bug that can cause SSL/TLS negotiations in UDP mode
   to fail if UDP packets are dropped.

James

