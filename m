Date: Wed, 30 Nov 2022 21:52:48 +0100 (CET)
Message-Id: <202211302052.2AUKqmFW079146@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221130165712.159683-1-arne@...1227...>
References: <20221130165712.159683-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Signal USR1 when connection
 initialising fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Lovingly called "the Lala Land patch" - without this, on P2P NCP fail,
openvpn goes to lala land, sitting there, knowing it has no way to
encrypt a packet for the peer, and happily throwing away all packets
(and on a p2p server, being generally unwilling to do anything useful
even on reconnect).

With the patch, it restarts the instance (SIGUSR1), and the next
"proper" client connection can then succeed.

2022-11-30 21:42:09 us=594531 ERROR: failed to negotiate cipher with peer and --data-ciphers-fallback not enabled. No usable data channel cipher
2022-11-30 21:42:09 us=594617 ERROR: Failed to apply P2P negotiated protocol options
2022-11-30 21:42:09 us=594852 TCP/UDP: Closing socket
2022-11-30 21:42:09 us=594925 Closing TUN/TAP interface


Your patch has been applied to the master branch.

commit 8187bbba5cdfa46fec2595f5f05384fd77eb5714
Author: Arne Schwabe
Date:   Wed Nov 30 17:57:12 2022 +0100

     Signal USR1 when connection initialising fails

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221130165712.159683-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25596.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


