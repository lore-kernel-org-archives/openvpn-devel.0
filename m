Message-ID: <a080d07f-c772-4dc4-de40-1807d2f74a6a@...2181...>
Date: Fri, 10 Feb 2023 20:19:47 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230210133159.1336-1-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230210133159.1336-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Improve format specifier for socket
 handle in Windows
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

On 10/02/2023 14:31, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> Socket is a handle on Windows, which is usually logged in hex.
> Also an interesting value is INVALID_SOCKET, which is ~0.
> 
> PRIuPTR prints decimals, and for INVALID_SOCKET it prints something like
> 
>    2023-02-10 14:45:21 us=906000 write to TUN/TAP : Jrjestelmkutsulle
> annettu data-alue on liian pieni.   (fd=18446744073709551615,code=122)
> 
> PRIxPTR prints hex, and INVALID_SOCKET looks a bit nicer:
> 
>    2023-02-10 15:17:11 us=828000 write to TUN/TAP : Jrjestelmkutsulle
> annettu data-alue on liian pieni.   (fd=ffffffffffffffff,code=122)
> 
> Reported-by: Selva Nair <selva.nair@...277...>
> Signed-off-by: Lev Stipakov <lev@...515...>

I also discussed this with Lev and, despite this being different from 
what we do in the *nix world (where decimal representations make sense 
for file descriptors), it seems to be the right hting to do on Windows 
when using HANDLEs (shrug).

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

