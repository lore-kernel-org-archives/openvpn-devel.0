MIME-Version: 1.0
In-Reply-To: <1456991293-63729-1-git-send-email-james@...515...>
References: <1456991293-63729-1-git-send-email-james@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 9 May 2016 20:54:25 +0200
Message-ID: <CAA1Abx+2E2FZN-y6P=mkKpSuZ7bOV5m6rUMTx3V7UP2qPMjZPg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Fixed port-share bug with DoS
	potential
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Thu, Mar 3, 2016 at 8:48 AM, James Yonan <james@...515...> wrote:
> Fixed port-share bug that can cause segfault when the number
> of concurrent connections is large.
>
> The issue is that the port-share code calls openvpn_connect()
> which in turn calls select().  When there are a high number
> of concurrent port-share connections, the fd passed to select
> can potentially exceed FD_SETSIZE, causing undefined behavior.
>
> The fix is to use poll() (if available) instead of select().
>
> Signed-off-by: James Yonan <james@...515...>
> ---
>  src/openvpn/socket.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 714a847..d33bccd 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1149,6 +1149,12 @@ openvpn_connect (socket_descriptor_t sd,
>      {
>        while (true)
>         {
> +#if POLL
> +         struct pollfd fds[1];
> +         fds[0].fd = sd;
> +         fds[0].events = POLLOUT;
> +         status = poll(fds, 1, 0);
> +#else
>           fd_set writes;
>           struct timeval tv;
>
> @@ -1158,7 +1164,7 @@ openvpn_connect (socket_descriptor_t sd,
>           tv.tv_usec = 0;
>
>           status = select (sd + 1, NULL, &writes, NULL, &tv);
> -
> +#endif
>           if (signal_received)
>             {
>               get_signal (signal_received);

ACK

Note that since patch e0b3fd49 in master and 1746908f in release/2.3
this no longer causes a segfault, but triggers an ASSERT().

In the long run, we should migrate away from select() completely.

-Steffan

(This patch was first discussed and reviewed on the closed security@ list)

