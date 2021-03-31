References: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ad7e8624-6f87-2874-9786-d5de521bc6a2@...2181...>
Date: Wed, 31 Mar 2021 08:29:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAAUX2SVQRn4zuDC947HE9M38nDNK1oNqyUv0GKeAw2dasHo62Q@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] sudden network disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Tony He <huangya90@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 31/03/2021 06:22, Tony He wrote:
> [36981.631546] ovpn_udp_encap_recv: cannot handle incoming packet: -28
> [36982.692005] ovpn_udp_encap_recv: cannot handle incoming packet: -28

Are these the only two lines from ovpn-dco? or is this a "summary"?

The problem might be related to the router not being able to consume
incoming packets as fast as it needs, thus dropping packets that kill
the iperf connection. Seems a bit too drastic, but with the little
information I have, this is all I can come up.

Can you please re-run the test and have a ping from the PC to the router
ongoing at the same time? It'd be interesting to see how being behaves
when the problems appears.

A packet dump of the whole session may also help.

Cheers,


-- 
-- 
Antonio Quartulli

