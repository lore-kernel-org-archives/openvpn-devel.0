References: <1466167642-13603-1-git-send-email-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5767BB75.8060008@...2080...>
Date: Mon, 20 Jun 2016 11:46:29 +0200
MIME-Version: 1.0
In-Reply-To: <1466167642-13603-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Remove http-proxy-retry and
 socks-proxy-retry
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 17/06/16 14:47, Arne Schwabe wrote:
> ---
>  Changes.rst           |  2 ++
>  src/openvpn/init.c    |  4 +---
>  src/openvpn/options.c | 13 ++++---------
>  src/openvpn/options.h |  1 -
>  src/openvpn/proxy.c   |  3 +--
>  src/openvpn/proxy.h   |  1 -
>  src/openvpn/socks.c   | 10 +++-------
>  src/openvpn/socks.h   |  4 +---
>  8 files changed, 12 insertions(+), 26 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index ab322e2..f43f057 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -113,6 +113,9 @@ User-visible Changes
>    proxies graciously.  The old "fail TCP fast" behaviour can be achieved by
>    adding "--connect-timeout 10" to the client config.
>  
> +- --http-proxy-retry and --sock-proxy-retry have been removed. Proxy 
> +  connections will now behave like regular connection entries and
> +  generate a USR1 on failure.

I don't mind us cleaning up code and removing options which we consider
not needed.  But I would like to see it better explained *why* we do it.
 It doesn't necessarily need to go into the Changes.rst, but having the
commit message could generally carry a bit more details.


-- 
kind regards,

David Sommerseth

