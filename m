MIME-Version: 1.0
In-Reply-To: <1342541993-32462-1-git-send-email-heiko.hund@...1489...>
References: <1342541993-32462-1-git-send-email-heiko.hund@...1489...>
Date: Wed, 18 Jul 2012 07:20:29 +0300
Message-ID: <CAOazyz0w1knsaZ3X3RhSQJU+CgaNDf6y5_CZOR6YMXtauU_m2g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCHv2 1/2] make non-blocking connect work on
	Windows
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks.
I think this is the simplest solution to this issue.

On Tue, Jul 17, 2012 at 7:19 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> Instead of EINPROGRESS WinSock2 returns WSAEWOULDBLOCK if a non-blocking
> connect(2) cannot be completed immediately.
>
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/socket.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 54ebce7..02e2768 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1165,7 +1165,13 @@ openvpn_connect (socket_descriptor_t sd,
>    status = connect (sd, &remote->addr.sa, af_addr_size(remote->addr.sa.sa_family));
>    if (status)
>      status = openvpn_errno_socket ();
> -  if (status == EINPROGRESS)
> +  if (
> +#ifdef WIN32
> +    status == WSAEWOULDBLOCK
> +#else
> +    status == EINPROGRESS
> +#endif
> +  )
>      {
>        while (true)
>         {
> --
> 1.7.9
>
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

