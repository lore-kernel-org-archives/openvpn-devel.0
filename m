From: Craig Knox <crg@...49...>
Mime-Version: 1.0
Message-Id: <E1867SL-0005ML-00@...50...>
Subject: [Openvpn-devel] QoS
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Oct 28 02:50:02 2002
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi there,
   I use QoS routing and it works great except over openvpn/tun device. 

   Correct me if I am wrong but I think this is because the packets are
encapsulated within a UDP packet with no regard to what the original
packets TOS field was, so once it reaches a "real" device it is just
treated as bulk even it was suppose to be for example minimum-delay.

   Is there anyway the TOS of the UDP packet could be set the match its
payload's TOS? 

Cheers
Craig




