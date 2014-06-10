From: Gert Doering <gert@...1296...>
Date: Tue, 10 Jun 2014 16:04:29 +0200
Message-Id: <1402409073-54067216-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] OpenVPN port to AIX
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

Hi,

the following four patches port OpenVPN git/master to AIX.  It might not
be the most asked-for platform in the world, but since it finally grew a
tap driver, it can be useful, so here it is :-)

Drawbacks today:
  - AIX has no tun driver, so only --dev tap is supported
  - IPv4 ICMP packets are never fragmented, so t_client fails for IPv4
    ping with 3000 bytes (while IPv6 works!)

gert


