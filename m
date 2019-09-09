References: <1567784437-25922-1-git-send-email-lstipakov@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e55c41d3-ad05-b559-8b71-2164c415f27b@...2080...>
Date: Tue, 10 Sep 2019 00:18:41 +0200
MIME-Version: 1.0
In-Reply-To: <1567784437-25922-1-git-send-email-lstipakov@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] tun.h: change tun_set() return value
 type to void
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

On 06/09/2019 17:40, Lev Stipakov wrote:
> This function's return value is never used, so make it void.
> 
> Signed-off-by: Lev Stipakov <lstipakov@...277...>
> ---
>  src/openvpn/tun.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index 69831c4..475643a 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -513,7 +513,7 @@ tun_event_handle(const struct tuntap *tt)
>  #endif
>  }
>  
> -static inline unsigned int
> +static inline void
>  tun_set(struct tuntap *tt,
>          struct event_set *es,
>          unsigned int rwflags,
I did some check into the history of this function, even going into the
openvpn-historical-cvs git repository.  The return value of this function was
defined as unsigned int since the very beginning - going back to OpenVPN
2.0_beta18 - which basically was the first public commit after the 1.6.0
release.  In my very quick look, not even once has the return value been used
since that time.

So this change makes sense.  No need to have a return value which has not been
interesting since November 2004.

Acked-By: David Sommerseth <davids@...515...>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


