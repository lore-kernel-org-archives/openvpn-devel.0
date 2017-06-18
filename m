References: <20170618194104.25179-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <965e3aed-cd78-c860-5a01-a71c8ea7adb2@...1227...>
Date: Sun, 18 Jun 2017 21:46:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170618194104.25179-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix potential 1-byte overread in TCP
 option parsing.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 18.06.17 um 21:41 schrieb Gert Doering:
> A malformed TCP header could lead to a one-byte overread when
> searching for the MSS option (but as far as we know, with no
> adverse consequences).
> 
> Change outer loop to always ensure there's one extra byte available
> in the buffer examined.
> 
> Technically, this would cause OpenVPN to ignore the only single-byte
> TCP option available, 'NOP', if it ends up being the very last
> option in the buffer - so what, it's a NOP anyway, and all we
> are interested is MSS, which needs 4 bytes.
> (https://www.iana.org/assignments/tcp-parameters/tcp-parameters.xhtml)
> 
> Found and reported by Guido Vranken <guidovranken@...277...>.
> 
> Trac: #745
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/mss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
> index ff24068..7c596d7 100644
> --- a/src/openvpn/mss.c
> +++ b/src/openvpn/mss.c
> @@ -159,7 +159,7 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
>  
>      for (olen = hlen - sizeof(struct openvpn_tcphdr),
>           opt = (uint8_t *)(tc + 1);
> -         olen > 0;
> +         olen > 1;
>           olen -= optlen, opt += optlen)
>      {
>          if (*opt == OPENVPN_TCPOPT_EOL)
> 

ACK. That for is strangely formatted. I have to look very hard to figure
out that.

Arne

