References: <20161129152739.11582-1-list@...1798...>
	<20161130085908.23248-1-list@...1798...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <a856d529-7825-4a03-1cfc-19fb0e58735e@...1435...>
Date: Wed, 30 Nov 2016 10:06:30 +0100
MIME-Version: 1.0
In-Reply-To: <20161130085908.23248-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Refuse to daemonize when running
 from systemd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 30-11-16 09:59, Christian Hesse wrote:
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -926,6 +926,13 @@ bool
>  possibly_become_daemon (const struct options *options)
>  {
>    bool ret = false;
> +
> +#ifdef ENABLE_SYSTEMD
> +  /* return without forking if we are running from systemd */
> +  if (sd_notify(0, "READY=0") > 0)
> +    return ret;
> +#endif
> +
>    if (options->daemon)
>      {
>        ASSERT (!options->inetd);

Does this mean I cannot run openvpn --config bla.conf --daemon from the
command line any more on a systemd system?  This would be a deal-breaker
for me.

-Steffan

