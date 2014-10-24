Message-ID: <544A2C26.5030708@...1435...>
Date: Fri, 24 Oct 2014 12:38:30 +0200
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <CAAA5faEk-YSopL-9L=cWzpcfwk96r+utbWEWuO_=L0=jjvYzRg@...278...>	<20141023192811.GU396@...1296...>	<CAAA5faFxpQnb7pNd1tSZisVfkGdD4d0xzLBwzwt5acstNfRe0w@...278...>	<20141023211259.GV396@...1296...>	<CAAA5faFzhCkqxe4j24C25b8JaLSgj2HeD5s2i31Em-UQOPURAg@...278...>	<20141024054814.GX396@...1296...>	<CAAA5faFEzEUdfixd5bhTY_9wg49VxCO+ZRWHMtoqJ07g6ouDmA@...278...>	<20141024091528.GZ396@...1296...>
	<544A1EDC.5040003@...1227...>
In-Reply-To: <544A1EDC.5040003@...1227...>
Subject: Re: [Openvpn-devel] man page and options.c contradict
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 10/24/2014 11:41 AM, Arne Schwabe wrote:
> Am 24.10.14 11:15, schrieb Gert Doering:
> And an important distinction is that the p2p mode does not use Diffie
> Hellman, meaning that it provides no Perferct Forward Security.

No, I think there's another distinction. There's 'static key mode'
(--secret), which does not do key negotiations. But it is also possible
to use --tls-server with --remote, resulting in a p2p network setup, but
using TLS (and thus dynamic key negotiation and PFS).

So much possibilities!

-Steffan

