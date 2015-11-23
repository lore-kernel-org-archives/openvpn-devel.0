MIME-Version: 1.0
In-Reply-To: <20151121200637.GD24952@...1296...>
References: <CAN-X3HSXj9a1kiKGBJ1eHgoTeA97WmpqQJPCYf5esKYQa8fLjA@...278...>
	<20151121200637.GD24952@...1296...>
Date: Mon, 23 Nov 2015 11:51:43 +0000
Message-ID: <CAN-X3HQ3jwUxchW=m-57TPBtfyv6E7bfY9fQJ3MH8godvf9nVQ@...278...>
From: Christian Pellegrin <chripell@...410...>
Subject: Re: [Openvpn-devel] [PATCH] Fix info.af == AF_UNSPEC case after
 commit 2bed089d31a12c2d0277e36a64964ebab6640f75
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
Cc: openvpn-devel@lists.sourceforge.net

On Sat, Nov 21, 2015 at 8:06 PM, Gert Doering <gert@...1296...> wrote:
>             if (sock->info.af == AF_UNSPEC)
> +               {
>                    msg (M_WARN, "Could not determine IPv4/IPv6 protocol. Using %s",
>                      addr_family_name(sock->info.lsa->bind_local->ai_family));
> +                  sock->info.af = sock->info.lsa->bind_local->ai_family;
> +               }

Just tested, I ack it works perfectly. Thanks!

