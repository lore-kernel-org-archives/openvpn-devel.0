MIME-Version: 1.0
In-Reply-To: <1447190223-8065-1-git-send-email-gert@...1296...>
References: <1447190223-8065-1-git-send-email-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 24 Nov 2015 09:52:57 +0100
Message-ID: <CAA1AbxK900g1RYx9-NLtP3VfUci3vFzFQizo479gFFFSSinDTA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix FreeBSD-specific mishandling of gc
 arena pointer in create_arbitrary_remote()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Tue, Nov 10, 2015 at 10:17 PM, Gert Doering <gert@...1296...> wrote:
> ... and while at it, fix warning about losing "const" qualifier on
> return.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/tun.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 24a61ec..6679330 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -641,7 +641,7 @@ void delete_route_connected_v6_net(struct tuntap * tt,
>   * is still point to point and no layer 2 resolution is done...
>   */
>
> -char *
> +const char *
>  create_arbitrary_remote( struct tuntap *tt, struct gc_arena * gc )
>  {
>    in_addr_t remote;
> @@ -650,7 +650,7 @@ create_arbitrary_remote( struct tuntap *tt, struct gc_arena * gc )
>
>    if ( remote == tt->local ) remote ++;
>
> -  return print_in_addr_t (remote, 0, &gc);
> +  return print_in_addr_t (remote, 0, gc);
>  }
>  #endif
>
> --

ACK (how can this have ever worked...?)

-Steffan

