References: <20170609205029.11002-1-gert@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <0ebcc4f6-5972-a169-29a0-0ce89d03ed5c@...1856...>
Date: Sun, 11 Jun 2017 22:41:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170609205029.11002-1-gert@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] proxy.c refactoring: remove always-NULL
 gc parameter
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

On 09-06-17 22:50, Gert Doering wrote:
> get_proxy_authenticate() is called with a "gc" parameter which MUST
> be NULL, otherwise string_alloc() will allocate memory in the gc_arena
> while the caller expects the result to be durable and will do explicit
> free() when no longer needed.  Remove gc parameter, call string_alloc()
> with "NULL" so this is clearly visible.
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/proxy.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
> index 8ff09ba..05f362d 100644
> --- a/src/openvpn/proxy.c
> +++ b/src/openvpn/proxy.c
> @@ -309,7 +309,6 @@ static int
>  get_proxy_authenticate(socket_descriptor_t sd,
>                         int timeout,
>                         char **data,
> -                       struct gc_arena *gc,
>                         volatile int *signal_received)
>  {
>      char buf[256];
> @@ -332,14 +331,14 @@ get_proxy_authenticate(socket_descriptor_t sd,
>              if (!strncmp(buf+20, "Basic ", 6))
>              {
>                  msg(D_PROXY, "PROXY AUTH BASIC: '%s'", buf);
> -                *data = string_alloc(buf+26, gc);
> +                *data = string_alloc(buf+26, NULL);
>                  ret = HTTP_AUTH_BASIC;
>              }
>  #if PROXY_DIGEST_AUTH
>              else if (!strncmp(buf+20, "Digest ", 7))
>              {
>                  msg(D_PROXY, "PROXY AUTH DIGEST: '%s'", buf);
> -                *data = string_alloc(buf+27, gc);
> +                *data = string_alloc(buf+27, NULL);
>                  ret = HTTP_AUTH_DIGEST;
>              }
>  #endif
> @@ -981,7 +980,6 @@ establish_http_proxy_passthru(struct http_proxy_info *p,
>              const int method = get_proxy_authenticate(sd,
>                                                        get_server_poll_remaining_time(server_poll_timeout),
>                                                        &pa,
> -                                                      NULL,
>                                                        signal_received);
>              if (method != HTTP_AUTH_NONE)
>              {
> 

What a mess...  This slightly reduces that, so ACK.

-Steffan

