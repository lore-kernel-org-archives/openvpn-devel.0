Message-ID: <443EC7D0.9020408@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.1-beta14 released
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Apr 13 14:52:05 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: 'openvpn-users' <openvpn-users@lists.sourceforge.net>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

2006.04.13 -- Version 2.1-beta14

* Fixed Windows server bug in time backtrack handling code which
  could cause TLS negotiation failures on legitimate clients.
	
* Rewrote gettimeofday function for Windows to be
  simpler and more efficient.
	
* Merged PKCS#11 extensions to easy-rsa/2.0  (Alon Bar-Lev).

* Added --route-metric option to set a default route metric
  for --route (Roy Marples).

* Added --lladdr option to specify the link layer (MAC) address
  for the tap interface on non-Windows platforms (Roy Marples).

James




