From: Florian Harmuth <florian.harmuth@...68...>
Date: Wed, 06 Oct 2010 23:06:37 +0200
Message-ID: <1286399197.3091.14.camel@...1415...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Tips for implementing multithreading
Reply-To: florian.harmuth@...68...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello all,
i plan to implement the multi threading feature like it has exists in
the 1.x version of openvpn. Where would be the best position for place
this feature? 
As explanation -> we use over the vpn a voip connection which breaks
down for a few seconds during the tls negotiation (cpu freq < 600 mhz).

Best Regards,
flo


