MIME-Version: 1.0
From: wei wang <lnykww@...277...>
Date: Mon, 15 Apr 2019 20:29:10 +0800
Message-ID: <CAPM6dUC_L=Q2HseFEKS7bfrff6McwQo9TSuWKramkbC+5k9Phw@...278...>
Subject: [Openvpn-devel] openvpn with udp lost event.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

For function multi_process_io_udp receive many events, but only
process one at a time. Doest it cause the event to be lost?

In our test, we had create thousands of client. When clients connect
to server at a time, for the clients which already connected on this
server will not receive packet from tun device.

-- 
Regards,
Wang Wei

