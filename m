Message-ID: <544A1EDC.5040003@...1227...>
Date: Fri, 24 Oct 2014 11:41:48 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <CAAA5faEk-YSopL-9L=cWzpcfwk96r+utbWEWuO_=L0=jjvYzRg@...278...>	<20141023192811.GU396@...1296...>	<CAAA5faFxpQnb7pNd1tSZisVfkGdD4d0xzLBwzwt5acstNfRe0w@...278...>	<20141023211259.GV396@...1296...>	<CAAA5faFzhCkqxe4j24C25b8JaLSgj2HeD5s2i31Em-UQOPURAg@...278...>	<20141024054814.GX396@...1296...>	<CAAA5faFEzEUdfixd5bhTY_9wg49VxCO+ZRWHMtoqJ07g6ouDmA@...278...>
	<20141024091528.GZ396@...1296...>
In-Reply-To: <20141024091528.GZ396@...1296...>
Subject: Re: [Openvpn-devel] man page and options.c contradict
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Reinoud Koornstra <reinoudkoornstra@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Am 24.10.14 11:15, schrieb Gert Doering:
> Hi,
>
> On Fri, Oct 24, 2014 at 01:04:17AM -0600, Reinoud Koornstra wrote:
>> I understood the term mode wrong.
>> So the main mode can be p2p or server to denote the openvpn protocol inside
>> tcp or udp(stateless) session. Initially I thought the term mode is used to
>> denote server, client or udp.
> OpenVPN has the modes "peer2peer" or "(multi-)client to server".
>
> The "client" mode differs from "peer2peer" only insofar as it expects
> to receive confings from the server, while the "server" mode is intended
> to handle multiple clients, send them configs, and so on.
And an important distinction is that the p2p mode does not use Diffie
Hellman, meaning that it provides no Perferct Forward Security.


Arne

