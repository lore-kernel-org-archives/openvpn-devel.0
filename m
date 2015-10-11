MIME-Version: 1.0
In-Reply-To: <1444571266-6598-1-git-send-email-arne@...1227...>
References: <1444571266-6598-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 11 Oct 2015 16:25:30 +0200
Message-ID: <CAA1AbxJ+GvoaeAz4qhyzAN=MNr4wfm2cN_0TRweGzer8cnhCjw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Do not set the buffer size by default
 but rely on the operation system default.
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Sun, Oct 11, 2015 at 3:47 PM, Arne Schwabe <arne@...1227...> wrote:
> ---
>  ChangeLog             | 3 +++
>  doc/openvpn.8         | 4 ++--
>  src/openvpn/options.c | 4 ----
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/ChangeLog b/ChangeLog
> index 7b945c8..9642adf 100644
> --- a/ChangeLog
> +++ b/ChangeLog
> @@ -1,6 +1,9 @@
>  OpenVPN Change Log
>  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
>
> +2015.xx.xx -- Version 2.4.0
> +       - sndbuf and recvbuf default now to OS default instead of 65k
> +

Nice, changelog entries!  But, 65k should be 64k.

> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 6823167..2b0af34 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -785,10 +785,6 @@ init_options (struct options *o, const bool init_gc)
>  #ifdef ENABLE_FEATURE_TUN_PERSIST
>    o->persist_mode = 1;
>  #endif
> -#ifndef WIN32
> -  o->rcvbuf = 65536;
> -  o->sndbuf = 65536;
> -#endif
>  #ifdef TARGET_LINUX
>    o->tuntap_options.txqueuelen = 100;
>  #endif

Am I right that it was tested that this indeed results in using
operating system defaults?

-Steffan

