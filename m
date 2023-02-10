Date: Fri, 10 Feb 2023 18:09:38 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y+Z6UrlL4eddu4Vp@...2685...>
References: <20230210133159.1336-1-lstipakov@...277...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

On Fri, Feb 10, 2023 at 03:31:59PM +0200, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> Socket is a handle on Windows, which is usually logged in hex.
> Also an interesting value is INVALID_SOCKET, which is ~0.
> 
> PRIuPTR prints decimals, and for INVALID_SOCKET it prints something like
> 
>   2023-02-10 14:45:21 us=906000 write to TUN/TAP : Jrjestelmkutsulle
> annettu data-alue on liian pieni.   (fd=18446744073709551615,code=122)
> 
> PRIxPTR prints hex, and INVALID_SOCKET looks a bit nicer:
> 
>   2023-02-10 15:17:11 us=828000 write to TUN/TAP : Jrjestelmkutsulle
> annettu data-alue on liian pieni.   (fd=ffffffffffffffff,code=122)
> 

Acked-By: Frank Lichtenheld <frank@...2641...>

Regards,
-- 
  Frank Lichtenheld

