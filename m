Message-ID: <16f083eb-67cc-8238-34ff-a22fc704afd2@...2181...>
Date: Mon, 17 Jan 2022 10:53:45 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <CAKuzo_gy_xHzy8Tscb8xJ7QKN5+OZZksG7o_0eYkao8FDDJ5WA@...278...>
 <20220117094917.178-1-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220117094917.178-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] tun: remove tun_finalize()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Hi,

On 17/01/2022 10:49, Lev Stipakov wrote:
[cut]
> -
> -static inline int
> -read_tun_buffered(struct tuntap *tt, struct buffer *buf)
> -{
> -    return tun_finalize(tt->hand, &tt->reads, buf);
> -}
> +int
> +tun_write_win32(struct tuntap *tt, struct buffer *buf);

for prototypes we put the return type on the same line as the function 
name (unless we have line length issues, but not in this case).

Cheers,


-- 
Antonio Quartulli

