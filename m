References: <1440680402-96548-1-git-send-email-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5600591E.1090908@...1856...>
Date: Mon, 21 Sep 2015 21:23:10 +0200
MIME-Version: 1.0
In-Reply-To: <1440680402-96548-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Replace unaligned 16bit access to TCP
 MSS value with bytewise access
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 27-08-15 15:00, Gert Doering wrote:
> TCP options are not always word-aligned, and accessing a 16bit value
> at an odd memory address will cause a "bus error" crash on some
> architectures, e.g. Linux/Sparc(64)
>
> Trac #497
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>   src/openvpn/mss.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
> index 64fd722..7298c7b 100644
> --- a/src/openvpn/mss.c
> +++ b/src/openvpn/mss.c
> @@ -129,7 +129,7 @@ mss_fixup_dowork (struct buffer *buf, uint16_t maxmss)
>   {
>     int hlen, olen, optlen;
>     uint8_t *opt;
> -  uint16_t *mss;
> +  uint16_t mssval;
>     int accumulate;
>     struct openvpn_tcphdr *tc;
>
> @@ -159,14 +159,13 @@ mss_fixup_dowork (struct buffer *buf, uint16_t maxmss)
>         if (*opt == OPENVPN_TCPOPT_MAXSEG) {
>           if (optlen != OPENVPN_TCPOLEN_MAXSEG)
>             continue;
> -        mss = (uint16_t *)(opt + 2);
> -        if (ntohs (*mss) > maxmss) {
> -          dmsg (D_MSS, "MSS: %d -> %d",
> -               (int) ntohs (*mss),
> -	       (int) maxmss);
> -          accumulate = *mss;
> -          *mss = htons (maxmss);
> -          accumulate -= *mss;
> +	mssval = (opt[2]<<8)+opt[3];
> +	if (mssval > maxmss) {
> +	  dmsg (D_MSS, "MSS: %d -> %d", (int) mssval, (int) maxmss);
> +	  accumulate = htons(mssval);
> +	  opt[2] = (maxmss>>8)&0xff;
> +	  opt[3] = maxmss&0xff;
> +	  accumulate -= htons(maxmss);
>             ADJUST_CHECKSUM (accumulate, tc->check);
>           }
>         }
>

ACK.  Change looks fine.  Though I don't have a platform to 
experimentally verify the fix.

-Steffan


