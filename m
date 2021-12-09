Date: Thu, 9 Dec 2021 14:20:19 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1860720964.740563.1639056019137@...2642...>
In-Reply-To: <20211207170211.3275837-9-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-9-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 08/21] Decouple MSS fix calculation from
 frame calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net



> Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:01 geschrieben:
[...]
> diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
> index aa5b68ce9..56dea0292 100644
> --- a/src/openvpn/mss.c
> +++ b/src/openvpn/mss.c
> @@ -30,6 +30,8 @@
>  #include "syshead.h"
>  #include "error.h"
>  #include "mss.h"
> +#include "crypto.h"
> +#include "ssl_common.h"
>  #include "memdbg.h"
>  
>  /*
> @@ -204,3 +206,41 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
>          }
>      }
>  }
> +
> +void
> +frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
> +                       const struct options *options)
> +{
> +    if (options->ce.mssfix == 0)
> +    {
> +        return;
> +    }
> +
> +    unsigned int payload_size;
> +    unsigned int overhead;
> +
> +
> +    payload_size = frame_calculate_payload_size(frame, options);
> +
> +    overhead = frame_calculate_protocol_header_size(kt, options,
> +                                                    payload_size, false);
> +
> +    /* Calculate the number of bytes that the payload differs from the payload
> +     * MTU. This are fragment/compression/ethernet headers */
> +    unsigned payload_overhead = frame_calculate_payload_overhead(frame, options, true);
> +
> +    /* We are in a "liberal" position with respect to MSS,
> +     * i.e. we assume that MSS can be calculated from MTU
> +     * by subtracting out only the IP and TCP header sizes
> +     * without options.
> +     *
> +     * (RFC 879, section 7). */
> +
> +    /* Add 20 bytes for the IPv4 header and TCP header of the payload,

"20 bytes each" would make the sentence much easier to parse, IMHO.

> +     * the mssfix routes will add 20 extra if payload is IPv6 */
> +    overhead += 20 + 20;
> +
> +    /* Calculate the maximum MSS value from the max link layer size specified
> +     * by ce.mssfix */
> +    frame->mss_fix = options->ce.mssfix - overhead - payload_overhead;
> +}

Regards,
  Frank
--
Frank Lichtenheld

