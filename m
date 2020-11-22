References: <20201120160418.17690-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <44f29658-6799-81de-3245-5c7a3d835734@...1856...>
Date: Sun, 22 Nov 2020 10:08:36 +0100
MIME-Version: 1.0
In-Reply-To: <20201120160418.17690-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix port-share option with TLS-Crypt v2
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 20-11-2020 17:04, Arne Schwabe wrote:
> The port-share option assumed that all openvpn initial reset packets
> are between 14 and 255 bytes long. This is not true for tls-crypt-v2.

Good catch, I totally missed this in the tls-crypt-v2 patch set.

> ---
>  src/openvpn/ps.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
> index 2089e6b9..cd00bc23 100644
> --- a/src/openvpn/ps.c
> +++ b/src/openvpn/ps.c
> @@ -983,10 +983,36 @@ is_openvpn_protocol(const struct buffer *buf)
>      const int len = BLEN(buf);
>      if (len >= 3)
>      {
> -        return p[0] == 0
> -               && p[1] >= 14
> -               && (p[2] == (P_CONTROL_HARD_RESET_CLIENT_V2 << P_OPCODE_SHIFT)
> -                   || p[2] == (P_CONTROL_HARD_RESET_CLIENT_V3 << P_OPCODE_SHIFT));
> +        if (p[2] == (P_CONTROL_HARD_RESET_CLIENT_V3 << P_OPCODE_SHIFT))
> +        {
> +            /* WKc is at least 306 byte (not including metadata):
> +             *
> +             * 16 bit len + 256 bit HMAC + 128 bit IV + 2048 bit Kc = 2448 bit

The IV is part of the HMAC, so does not need to be counted here. So this
this be 2320 bits / 290 bytes.

> +             *
> +             * This is increased by the normal length of client handshake +
> +             * tls-crypt overhead (32)
> +             *
> +             * For metadata tls-crypt-v2.txt does not explicitly specify
> +             * an upper limit but we also have TLS_CRYPT_V2_MAX_WKC_LEN
> +             * as 1024 bytes. We err on the safe side with 255 extra overhead
> +             *
> +             * We don't do the 2 byte check for tls-crypt-v2 because it is very
> +             * unrealistic to have only 2 bytes available.
> +             */
> +            int plen = (p[0] << 8) | p[1];
> +
> +            return  (plen >= 352 && plen < (1024 + 255));
> +        }
> +        else
> +        {
> +            /* first two bytes are the size field. This is an openvpn packet
> +             * between 14 bytes and 255 (otherwise p[1] would be 01 or larger.
> +             * on the hard reset packet key_id is zero, so only the opcode
> +             * part is non-null */

Instead of explaining the length field in the comment, why not just move
the "int plen = (p[0] << 8) | p[1];" outside the if to have the code
explain that by itself?

> +            return p[0] == 0
> +                && p[1] >= 14
> +                && (p[2] == (P_CONTROL_HARD_RESET_CLIENT_V2 << P_OPCODE_SHIFT));
> +        }
>      }
>      else if (len >= 2)
>      {
> 

Thanks,
-Steffan

